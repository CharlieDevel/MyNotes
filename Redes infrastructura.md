
# Balanceo de cargas
Se tienen varioas computadoras con recursos multiplicados
3 maquinas de BD
2 de WEB que acceden las 3 BD 
2 de PROXY que acceden las maquinas WEB
> Las proxies tienen IP diferentes, y **solo una esta activa a la vez**, para tener una misma IP para los clientes, y esto funciona de tal forma donde si se cae una entonces la otra asume la IP

#Problema Si una maquina WEB se case a media conversacion con un cliente, como se puede hacer para que otra maquina retome la conversacion?
Se usan las **bases de datos** para tener una memoria para mantener la conversacion, metiendo una responsabilidad extra a las bases de datos, pero es simple
Otra solucion es la de crear una comunicacion fluida entre estos pero es mas laborioso
#Problema Cuano se tiene solo una IP publica, como se puede hacer para que los proxies trabajen con esto? Y acaso solo existe un proxy a la vez?(SI cuando solo hay una IP publica disponible)
Here’s an analogy: think of the load balancer(proxy) as a receptionist at a large office. There’s only one reception desk (the public IP), but there are many employees (the backend servers). When a visitor (a request) arrives, the receptionist decides which employee should meet the visitor based on who’s currently available or who’s the most suitable for the visitor’s needs.

# Virtualizacion
La virtualizacion permitio el evolucionar de tener maquinas con varios programas dentro al mismo tiempo, como base de datos y app web en la misma maquina, y al estar en la misma maquina tienen un acoplamiento entre estos, que puede empeorar mucho entre mas maquinas



# Logging
Logging en las maquinas sobre conexiones que se quieren hacer a cualquier maquina en toda la red y detectar intentos de ataques maliciosos metiendo algun mecanismo con un programa que revise todos los logs y recoga la informacion que sea sospechosa con criterios


# VS NAT
Virtual Server NAT(Network Translation)
Un paquete de usuario llega al load balancer, y la IP es la del load balancer, pero ahora le cambia la IP hacia uno de los servidores que de verdad ofrece el servicio(por medio de la NAT), y luego el servidor de verdad simplemente manda devuelta
- Esto tiene inherentemente un cullo de botella por el load balancer, que es solo uno que tiene la IP publica, y si se cae entonces ya no se puede acceder a los demas servicios

# VS TUN
Tunneling
Se hace que el cliente mande paquetes normal, 
Y luego cuando las maquinas reales desenvuelven el paquete tuneleado, entonces **cada maquina real responde por su cuenta**, mandandoel paquete de respuesta directamente al ciente
Esto lo logra porque simplemente da vuelta a las IP de src y dst


# VS Direct Routing
Esto involucra capa 2
porque tambien ocupa software especial que sea capaz de hacer que el load balancer reciba paquetes de capa 3, y de alguna forma lo convierte en un paquete de capa 2, con el que hace que **obligatoriamente este conectado a las maquinas reales por capa 2, switches**, y tambien entiendan la forma de hablar asi 

# IP flotante
Está es una técnica para cuando tenemos una IP pública pero queremos que hayan 2 dispositivos de red que manejen la red y la reciban, como un par de firewalls, pero con sólo una IP

Lo que normalmente se hace es usar un protocolo para esto, y también hay otro aspecto el cual es el de poder también **Monitorear** estos dispositivos, en Internet se usa algo que es mediocre el cual es tener esa IP flotante y también dar una IP extra que sí se la quedan a cada dispositivo, pero es bastante básico y primitivo

La mejor opción es el hacer que uno tome el rol de *Monitorear* y el otro de *ser monitoreado*, y se usa un protocolo tal como Virtual Redundant Routing Protocol, para poder hacer la IP flotante y también tener algo que configura estos roles de una conexión tipo Peer 2 Peer con **Keepalived**

Esto también tiene otro problema porque cuando se obtiene esto, la máquina que está de backup y no tiene la IP flotante, tampoco tiene acceso a Internet, lo que significa que no puede se puede ingresar a esta máquina, y está muy limitada, por lo que se añade funcionalidad extra a las máquinas cuando no tienen la IP flotante, y es la de hacer que su default gateway cambie a la default gateway de la otra red a la que están conectados, pero **Por detrás**(o sea la red interna a la que están conectados con otra interfaz de red, ya que están conectados también al frente a la calle con la interfaz de red que usa la IP flotante)

En realidad las máquinas que comparten IP no tienen 2 interfaces de red, sólo UNA, pero esta en un estado especial como *medio muerto*, donde se puede hacer cosas raras pero que también puede hacer que keepalived le ponga la IP flotante

En realidad si tienen 2 interfaces, la de atrás y la de adelante, pero la de adelante está zombie