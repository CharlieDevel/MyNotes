#  Switch multicapa
Este switch se tiene que conectar al routerNAT, el cual está conectado a los demás routers que dan acceso a distintos servidores de la U y el Internet

Después de conectar el multicapa con el router, se procede a configurar y hacer que se conecten
En el multicapa, se abre la terminal, se accede a `configure terminal` y se hace lo siguiente
> Configuración inicial del **multicapa**
```
interface gigabit X // Acceder a la interfaz que está conectada con el router
switchport mode access
switchport access vlan <vlan especial>
exit

// Ahora hay que configurar la IP del multicapa
name 40
Enlace-con-Router
interface vlan <vlan especial>
ip address <ip que el router usa para reconocer este multicapa> <máscara de red de la ip>

// Por ejemplo
interface gig 1/0/2
switchport mode access
switchport access vlan 40
exit
interface vlan 40
ip address 163.178.10.42 255.255.255.252
```
La **vlan especial** se usa únicamente para que el router al que estará conectado sepa cual es la IP de este multicapa

> Configuración inicial del **router** 
```
interface gigabit X // Acceder a la interfaz que está conectada con el multicapa
ip address <ip que el multicapa usa para reconocer este router> <máscara de red de la ip>
no shutdown

// Por ejemplo
interface gig0/0
ip address 163.178.10.41 255.255.255.252
```

Con esto se estableció cómo se comunicarán el multicapa y el router
Ahora hay que configurar el OSPF en ambos dispositivos de red

> En el **multicapa** 
```
configure terminal // Se tiene que estar en modo config
router ospf // Se entra al modo (config-router)
network <identificador de red que el multicapa conozca> <wildcard de esa red> area 0
network <red que usan este multicapa y router> <wildcard de esa red> area 0

// Por ejemplo
network 10.1.101.0 0.0.0.255 area 0 // Se hace esto por cada red que el multicapa conozca
network 163.178.10.40 0.0.0.3 area 0
```
Y con esto se logra hacer que cualquier red que el multicapa conoce pueda dirigirse a los servicios

> En el **router**
```
configure terminal
router ospf
network <red que usan este multicapa y router> <wildcard de esa red> area 0
```

# Router Borde
Este router es necesario para poder llevar todos los paquetes desde dentro de los edificios a este y que este mismo se encargue del NAT dinámico, a la vez que une los paquetes de las distintas vlan
Lo primero es hacer que se conecten el switch de capa 3 y el router de borde por medio de una red /30
Una vez hecho eso hacemos
```c
conf t // Acceder al modo de configuración global
int gig X.<vlan> // Interfaz conectada con el switch capa 3
ip address <Default Gateway del vlan> <mascara de vlan>
ip nat inside

// Por ejemplo
int gig0/2.101
ip address 10.1.101.1 255.255.255.0
```

Estos comandos se repiten por cada vlan
Lo que permiten es hacer que este router maneje estos paquetes
Después se hace
```c
conf t
ip route 0.0.0.0 0.0.0.0 <ip del router POP>
```

Para que estos paquetes sean enviados directamente al POP

## NAT Dinámico
El NAT Dinámico se hace en el router de borde, el cual se hace así
```c
access-list <número> permit <red que será traducída> <wildcard>

// Por ejemplo  
access-list 1 permit 163.178.10.0 0.0.0.7  
// Si 163.178.10.0/2
// Se hace este comando por cada vlan
ip nat pool <nombre> <rango de direcciones IP públicas> netmask <máscara de red>  
ip nat inside source list <número de lista de acceso> pool <nombre del grupo>  
  
  
// Por ejemplo  
ip nat pool REDPUBLICA 172.72.2.2 172.72.2.254 netmask 255.255.255.0  
ip nat inside source list 1 pool REDPUBLICA

int gig X // Interfaz que está conectada con el switch multicapa
ip nat inside

int gig X // Interfaz que está conectada con el router POP
ip nat outside
```

Y con esto se logra configurar el NAT dinámico para las vlans

# Router POP
Este router el recibir los paquetes del router borde traducidos por el NAT y los manda al destino por medio de OSPF
Para configurar OSPF se hace
```c
router ospf <identificador>  

// Por ejemplo  
router ospf 1

network <ID de red conectada/conocida del router> <máscara wildcard> area <número de área OSPF>  
  
// Por ejemplo  
network 163.178.28.0 0.0.0.3 area 0
```
El comando que inicia con `netowrk` se tiene que realizar varias veces, por cada red que el router conozca y esté conectada

> Existe un router en específico que necesita el comando `redistribute static subnets`, este se hace en el router que está conectado con el Router BORDE

