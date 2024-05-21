# PC
> IP y Default Gateway configurada manualmente o por DHCP

# Switches
Los switches permiten la circulación de distintos paquetes de VLANs en la red, y en el caso de la VLANs se tienen 2 tipos de interfaces para operar con los switches
Las de Acceso y los Troncales
Estas interfaces dentro de los switches sirven para separar distintas partes del edificio, servicios, y redes usando VLANs

> Los de acceso definen a qué VLAN un dispositivo pertenece
> Los troncales permiten la circulación de las distintas VLANs entre los dispositivos de red

## Interfaz de Acceso
> Definen la VLAN a la que el dispositivo conectado pertenece ahora

- Para configurar una interfaz de acceso en un switch, es necesario
```
interface FastEthernet X // Entrar a la interfaz del switch
switchport mode access
switchport access vlan <vlan> // número de vlan 1-4096
```
Con estos comandos, activamos el modo access de la interfaz y le brindamos al dispositivo conectado la VLAN que usará

## Interfaz troncal
> Conecta dispositivos de red para circular los paquetes de las VLANs

- Para configurar una interfaz troncal, es necesario introducir en el switch
```
interface FastEthernet X // Entrar a la interfaz
switchport mode trunk
switchport trunk native vlan 999
switchport trunk allowed vlan <vlans separadas por comas sin espacios>
```
Lo que esto permite es activar la interfaz en modo troncal, y la circulación de las VLANs que permitamos
Estas VLANs serán con las que se trabajarán para la redes y serán guiadas por estos switches

# Switch multicapa
Esto es un switch y un router, lo que permite usar el modo troncal en este dispositivo y seguir trabajando igual, además de eso también puede enrutar paquetes a otras redes

- Para hacer este dispositivo funcional
Primero se prende conectandolo
Se inicia un proceso que se puede repetir, el cual hace que el router 
1. Conozca todas las VLANs que tocará
2. Se convierta en el Default Gateway de las VLANs
Lo comandos que se pueden repetir son estos
```
interface vlan <vlan>
ip address <direccion IP de router> <máscara de red>
vlan <vlan>
name <nombre descriptivo de VLAN>
exit
```
En cuanto a la interfaz conectada al switch troncal, se debe hacer lo siguiente en la interfaz conectada a este switch
```
interface FastEthernet X // Interfaz conectadas a switch troncal
switchport mode trunk
switchport trunk native vlan 999
switchport trunk allowed vlan <vlans separadas por comas sin espacios>
```
Esto permite la circulación de las VLANs en el switch multicapa 

## Enrutamiento de paquetes de distintas VLANs
El switch multicapa es el único encargado a dirigir los paquetes de unas VLANs que se dirigen a otras VLANs 
Lo que se hace primero es
```
ip routing
```
Para dirigir los paquetes automáticamente que el switch multicapa ya tiene conectados y es configurado como el Default Gateway de algunos
Pero faltan dirigir los paquetes de otras VLANs del otro edificio, como los que van de un laboratorio de un edificio al otro edificio
Para esto se conectan los switch multicapa de ambos edificios, y en ambas interfaces que se conectan se tiene que hacer lo siguiente
```
switchport mode access
switchport access vlan <vlan especial>
```
La **vlan especial** es para que se redirigan los paquetes que le llegan al switch multicapa y estos mensajes van al otro edificio, ésta vlan se configura en ambos switches por medio de la interfaz vlan
```
interface vlan <vlan especial>
ip address <dirección IP de multicapa> <máscara de red de los multicapa>

// Por ejemplo
interface vlan 100 // Realizado en ambos multicapa
ip address 10.1.100.1 255.255.255.252 // Realizado en el primer multicapa
ip address 10.1.100.2 255.255.255.252 // Realizado en el segundo multicapa
```
Esta red **"10.1.100.0/30"** será la forma por la cual estos 2 switches multicapa se van a reconocer entre sí y se redirigen los mensajes de un edificio a otro
Y para que esto suceda se hace lo siguiente
```
configure terminal // Se debe estar en el modo config
ip route <vlan destino> <máscara vlan destino> <ip del otro multicapa> // Se repite por cada VLAN que se tenga que redirigir

// Por ejemplo
// Estamos en el multicapa 10.1.100.1, este router puede redirigir paquetes de las VLANs 101, 102, 105 y 201, pero no las 103 y 104
ip route 10.1.103.0 255.255.255.0 10.1.100.2
ip route 10.1.104.0 255.255.255.0 10.1.100.2
```
Esto lo que logra es ahora que los multicapa sepan contactarse entre sí para enviar paquetes de VLANs que no controlan

# DHCP

El DHCP es un servicio que automatiza la asignación de dirección IP, máscara de red y Default Gateway para cualquier computadora nueva
Lo primero es crearlo y configurarlo para que sirva un pool de direcciones
```
Se crea un Server
Se accede a la pestaña de "servicios" del server, y se accede DHCP
Se configura dirección IP, máscara de red y Default Gateway para la red que va a servir
```

En cuanto a la dirección IP y Default Gateway de la interfaz que va a dar el servicio de estos servers DHCP, se les da una vlan especial de servicios
```
Dirección IP: 10.1.105.3 // El "3" lo podemos ver cómo el DHCP que da servicio a la VLAN 103
Default Gateway: 10.1.105.1
```
Esto servirá en un futuro a poder ayudar a computadoras que están en otro edificio y necesitan acceder a los multicapa para hacer llegar el mensaje broadcast al DHCP que lo puede configurar

Ahora se puede conectar a una red, estos deben conectarse a los switches troncales, en una interfaz modo acceso, de la siguiente manera

## En los switches troncales
```
interface FastEthernet X // Acceder a la interfaz conectada al server DHCP
switchport mode access
switchport access vlan <vlan de servicio>
// Por ejemplo
switchport access vlan 105
```
La **vlan de servicio** en la configuración será la vlan por la cual el servicio se ofrece a las demás VLANs, pero sólo una interfaz puede dar el servicio a una VLAN en el server DHCP 

## En los switches de acceso
Ahora se configuran las computadoras nuevas que se conectan al switch, realmente lo único que se configura es la interfaz del switch por la que la nueva computadora se conecta
```
interface FastEthernet X // Interfaz conectada a la PC
switchport mode access
switchport access vlan <vlan de laboratorio>
```
La vlan de acceso es importante ya que la computadora cuando se le Active la configuración por DHCP, mandará un mensaje broadcast a todos los dispositivos en la red, y para cuando le llegue al DHCP él sabrá para qué red es ya que el switch etiqueta ese mensaje con uno de vlan que ya se conoce

## En los multicapa
Ahora para que las computadoras del otro edificio puedan tener estos servicios igualmente, se necesita configurar los multicapa de manera especial cada uno

> El multicapa que no posee servers DHCP en su edificio y tiene que acceder al otro, necesitará saber la **dirección IP** de los servers, para poder redirigir los mensajes broadcast de nuevas computadoras
> El multicapa que sí posee los servers DHCP en su edificio necesitará saber hacía dónde enviar **mensajes de tipo broadcast**  por parte del servidor DHCP hacia ésta nueva computadora

### En el multicapa que no tiene DHCP en su edificio
```
interface vlan <vlan que solicita servicio DHCP>
ip helper-address <IP del server DHCP que se encarga de la vlan que solicita>

// Por ejemplo
ip helper-address 10.1.105.3 // En el caso donde la nueva computadora es de la vlan 103
```
Ahora el multicapa, en vez de botar el paquete broadcast hacía el DHCP, lo redirige hacia el server DHCP
> Es importante haber configurado el "ip route" para paquetes que se dirigen a redes tipo 10.1.105.0/24

### En el multicapa que sí tiene DHCP en su edificio
```
interface vlan <vlan de servicios>
ip helper-address <vlan que solicita terminada en 0> // Se hace por cada vlan que vaya a querer el servicio

// Por ejemplo
interface vlan 105
ip helper-address 10.1.<vlan servida>.0

// Concretamente
ip helper-address 10.1.103.0
```
Lo que esto logra es hacer que los mensajes broadcast por parte del DHCP logren llegar a la computadora de origen y las otras computadoras de la red, y con esto se logra la configuración de DHCP en otros edificios

# WLC
El WLC configura los AP que se conecten a él y permitirán la configuración automática de cualquier AP en la red
Es necesario una VLAN exclusiva para los AP, donde se utiliza la 10.1.201.0/24

Primero se crea el WLC y se configura
```
Se accede al WLC y se accede a la pestaña "Wireless LANs"
Aquí...
Se configura el SSID para dar nombre a la red de APs
Se configura la VLAN a la 201

Ahora se accede a la pestaña "Management"
Aquí...
Se configura "IPv4 Address" a una IP dentro de la red de APs, por ejemplo 10.1.201.2
"Mask" a la máscara de la red 
"Default Gateway" a la dirección del  default gateway
```
Ahora para conectar el WLC a las redes, se conecta al switch troncal parecido al DHCP, donde en la terminal del switch troncal hacemos lo siguiente
```
interface FastEthernet X // Interfaz conectada al WLC
switchport mode access
switchport access vlan 201
```
Y se tiene listo el WLC

# AP
Los AP sólo necesitan conectarse, encenderse, y configurar en la pestaña "WLC" la dirección IP del WLC en la red

//===========================  Canal de ventana deslizante

E //=========	- - - - |==================  
R //								   ===========================  

Los - - - son tiempo y ancho de banda desaprovechado
Es básicamente una cadena de producción, donde se tiene una cinta transportadora, y se llena lo más posible y lo que quepa

Dominio de comisión
Es saber **cuales canales** pueden haber colisiones si los dispositivos mandan datos al mismo tiempo, si varias computadoras envían datos al mismo tiempo y no hay problema entnces no hay dominio de colisión
Los switches son inteligentes, y cada puerto es un medio independiente a los demás, donde si varias computadoras envían al mismo tiempo, **no habrá colisión**
A cambio, un Hub, que es como soldar todo en un solo puerto, conforma toda una colisión porque si varios envían al mismo tiempo, entonces hay colisión

//===========================  Software Design

# Preamble
The basic idea in 「cohesion」 and 「coupling」 is the declaration of 2 things when developing software for our solutions

* Logic (cohesion(Primary investigation))
The already studied and defined problem, where it is clear the responsibilities and behaviours that the system and components of the system should have, and 『focus』 only on one function
> The **abstraction** of the problem and focus of every component

* Implementation (coupling(Secondary investigation)
The code that performs the processes and data in order to 『achieve』 the solution that was formulated from the logic **effectively**
> The true **process** data passes through to solve the problem

High coupling makes the system more efficient, but harder to understand
The cohesion

「 Feature 」     ※ Software Pattern
        Responsibilities(+|-):
**++Enhance** the structure of the 「whole」 system 
	(Can be done to the patterns themselves **too** because they are **sub-systems**)
+Alternative solutions with own trade-offs
+Cooperate with other components to **ease** a process
-Should be known how to implement them

「 Scenario 」     ※ Modularity / Cohesion
The 『functions』 of the system should be **highly** **cohesive**
The 『software patterns』 should be **coupled**, BUT ONLY WITH themselves
	Their **responsibilities and behaviours** regarding the system logic should be 『highly cohesive』
Given:
        -
When:
        -
Then:
        -