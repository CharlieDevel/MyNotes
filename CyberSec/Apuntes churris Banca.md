
- Autenticación en páginas web
Tener un pedazo de función que auténticque en **cada página** que el usuario es legítimo

- Tener cuidado con apache con el path, porque cualquiera puede acceder a los archivos del servidor

- Matriz de permisos
Se puede hacer en código una matriz de permisos que tiene recursos y el permiso requerido, y si algún otro componente quiere acceder a un recurso entonces se verifica que permiso tiene y si alcanza a acceder al recurso

- Desplegar muros de otros
Hay que ver cómo es que un usuario puede ver muros de otros de forma dinámica Y TAMBIÉN se guarde en base de datos

- Lista de posts likeados por usuario
Hay que llevar registro de que likes ha dado un usuario para que lo pueda desmarcar luego
- Problemas de seguridad en comunicación entre servidores
Entre los 2 servidores de backend y fronted existen varios riesgos por la necesidad de comunicar datos importantes hacia afuera, que un servidor este hablando legítimamente con el otro y no era un falso, que no sea capturada la llave para encriptar
- Cross side scripting: Hacer que el usuario en una aplicación web crea que está usando algo legítimo, o una parte legitima
- Al atacar, cuidar el tema de los cambios, tipo un usuario malicioso se hace amigo y quita el ser amigo, donde este usuario quiere ver el perfil de alguien cuando NO debería(sólo si el otro usuario no lo sigue)

- Identificar puertos vulnerables
Los puertos en una máquina se usan para que la máquina se comunique con el exterior, y hay programas que usan estos puertos **y quedan en LISTEN**, lo cual son como ventanas abiertas a cualquier interacción que puede ser maliciosa, y se **necesita eliminar los programa innecesarios**

- BLOQUEAR las 2 interfaces de red extra
Porque si alguien consigue las IPs de esas interfaces de red, se puede conectar por SSH o así, y romperlo todo

- Permitir sólo UNA CONEXIÓN a las bases de datos
Configurar en María DB las sesiones permitidas en base de datos sólo una, pero hay que meter más cuidado en el mismo usuario el cual tiene su sesión activa

- El cgi si tiene puertos abiertos, y por ser CGI, se puede inyectar un programa malvado, y como C lo atrapa, entonces es vulnerable a inyección de código **HAY QUE CUIDARSE AL LEER ENTRADA ESTÁNDAR CON CGI**
- También se pueden inyectar cosas **en disco** y así, por ejemplo viendo que archivos son leídos por un programa, **que ruta se está accediendo**
### ==================
- IMPORTANTE SOBRE CERTIFICADOS DIGITALES



Entre máquinas para tener Https
Auténticarse de nuevo con firma digital **cuando se realizan transacciones**

- Si un comando cambia algo luego en realidad no cambio
Es por VCL que por alguna razón cuando alguien cambia una configuración de iptables o algo así, entonces devuelve la configuración a como estaba, pero si se cambia la configuración varias veces entonces VCL se confunde y eventualmente deja el valor que estaba modificado

- Si se intenta conectar a la máquina remota desde otro lugar, puede que no se conecte el ssh pero porque VCL piensa que es algo malicioso, y hay que ir a VCL y decirle que uno se quiere conectar con la interfaz de ellos
# =======

- Cadenas de seguridad
Las cadenas de seguridad no son sólo tener 2 componentes y que uno se relacione con el otro, y cada uno tiene una propiedad de seguridad, es además de que uno se dirige a otro y le HEREDA la seguridad que tenía al otro, protegiendo así con esa otra propiedad al otro componente
OJO: Esto es una espada de doble filo, porque así como un componente está protegiendo a otro componente, pero alguien logra meterse en un componente, **O el otro**, entonces el ataabnte **puede ser capaz** de meterse en el otro componente de la cadena, y así por todos los demás componentes de la cadena

## **Recurso, Procesamiento y Red**
Estas son las 3 arquetipos del software que **la seguridad** busca proteger y manejar estas propiedades, en **cualquiera de sus formas**(hablando de las implementaciones de estas propiedades, donde también los controles de seguridad como auditabilidad que genera bitácoras, entran también como otra forma de esos arquetipos)

Además ésta el **4to componente**, **Las personas**, que se refiere a cualquiera de las formas en las que alguien **interactúa con estos arquetipos**

# CGI
Da paginas html generadas dinámicamente, 
Originalmente hace intermediario entre el cliente y servidor
Pero en este caso será cliente -> frontend(tiene su propia base de datos) -> backend(apache) -> cgi -> base de datos

Cliente habla al servidor como un apache o algo
Pide algo
El servidor es apache, y se le configura que hable cgi
El servidor **Invoca** a otro programa
El cgi entonces hace cosas avanzadas, no cosas super básicas como devolver contenidos de un archivo del servidor
Sino que habla con bases de datos, 


Por medio de environment variables, se comanda qué hacer al programa CGI

- Manejar los buffers donde se lee lo que el usuario mandó
- Tomar en cuenta esto cliente -> frontend(tiene su propia base de datos) -> backend(apache) -> cgi -> base de datos


- variables de entorno
- Parámetros de programa
- Recibir datos del stdin

# ===============

* Uso de librerías
Para efectos de seguridad, hay que entender el proceso de seguridad, por lo tanto, hay que revisar la seguridad en lo que se ha **tomado prestado**, que podrá ser más fácil o más difícil dependiendo de la seguridad inherent
En el mundo real lo que se hace es que se usan **Sólo bibliotecas**, y **asumen que TODO funcionará bien**, incluso aspectos más complejos como seguridad

- CGI hay una biblioteca de María DB, seguramente el paquete de María DB dev

- Certificado digital
La esencia es saber que algo
Es de encriptar algo con una llave privada, y publicar lo encriptado, y con una llave pública que el mismo que ha encriptado da, y la llave pública es capaz de **desencriptar** los datos encriptados, y si es así 
Es básicamente que con la llave privada **se encripta**, y la llave pública **desencripta**, y si la información desencriptada es la misma que la que llegó sin encriptar entonces **la información es auténtica**

Mientras que en los casos donde la llave privada **desencripta** y la pública **encripta**, 

# Como hackear
Primero hay que ver el programa objetivo
Del programa objetivo encontrar
- Puntos de acceso fáciles
- Estados de los componentes en cuanto a relación con qué otros componentes se relaciona, y qué tan accesibles son por otros
- Ver en donde no hay límites o controles de seguridad

# =====================  

## Definición de objetivos de seguridad
Esto nos va a servir porque ahora el contexto de la aplicación es que tenemos algunos componentes claros pero no hechos todavía, **con su seguridad estructural(acoplamiento, cohesión)**, y si aplicamos los objetivos más otras cosas como cadenas de seguridad y propagación de objetivos, **entonces** obtendremos claridad sobre **que componentes necesitan seguridad y qué tipo de seguridad**, qué conexiones ente componentes deberían eliminarse y también **que controles de seguridad aplicar y PORQUE aplicarlos donde están**

Formato de objetivo
QUE
DONDE
CUANDO

### Objetivos
- Autenticación al ingresar al sistema
- Autorización al acceder al muro social u otras acciones delicadas(se implementa con un esquema de autorización), mantener los datos bancarios seguros y confidenciales desde base de datos
- 	Puede haber una cadena de seguridad entre autenticación y confidencialidad

Después de definir objetivos
Identificar como se propagan los objetivos a los componentes
Y luego hacer un análisis de riesgo, **teniendo** el sistema y los objetivos

# Como usar la Máquinas remotas de producción


## Uso de interfaces de red dentro de estas máquinas

# Acceder a server en linux en Oracle VM desde Windows
Si uno tiene un linux corriendo en Oracle VM desde windows, y se ejecuta desde el linux un programa que manda informacion a un puerto, hay que
1. Configurar la maquina virtual en la configuración de red/networking que sea **Bridged Adapter** en vez de NAT, porque asi convertimos al linux como otra computadora dentro de la red local de windows
2. Despues iniciar linux con esa configuracion
3. Iniciar el programa(Si es un programa propio, asegurarse de que el programa mande informacion a la IP del linux y puerto deseado)
4. Introducir en terminal *sudo ifconfig* para saber el IP del linux
5. Introducir en windows la IP y puerto en el navegador como por ejemplo “192.168.0.20:3142/”, y listo




# Firewall y iptables
Iptables está en
`/etc/iptables/rules.v4`
Aquí es donde se controla la **Capa 3 de la máquina** y se pueden **rechazar o aceptar** paquetes del exterior, y los paquetes que vienen del exterior(importante para que apache y otros puedan comunicarse entre máquinas)
Esto se controla por reglas, y las reglas **están encadenadas** donde si una regla aplica a algo, **entonces no va a probar las reglas que están después**

- También puede controlar además con quien puedo hablar, **que tipo de paquetes de una conversación(ESTABLISHED, NEW, RELATED)**, como TCP quita puede permitir paquetes SÓLO SI son de una conversación ESTABLISHED
- RELATED: Significa que de una sesión establecida, hacer una nueva sesión, pero sin usar un paquete NEW
## Para editar IPTABLES
Hay que editar el archivo en su ruta, y **REINICIAR el servicio de IPTABLES**
> Consideraciones
> Esto funciona como las reglas de gramática de ANTLR en términos de **reglas de paquetes válidos**, donde los paquetes que cumplen UNA regla, entonces se deja pasar
> - Con esto hay que considerar paquetes que son muy frecuentes, y no dejar la regla que los deja pasar **en el fondo**, porque el rendimiento de red se verá afectado por **hacer mucha verificación**

- Al crear una regla, y se quiere usar un servicio, como icmp, entonces hay que repetir el servicio en 2 argumentos, el -p, que indica protocolo a usar, y TAMBIÉN el -m, que es o el mismo protocolo, o un componente/elemento de este protocolo, y luego también se especificar el tipo de ese subtipo del protocolo, como el `--state NEW`
	Básicamentete es como que en la máquina hay protocolos, en los protocolos estan sus componentes, en los componentes sus tipo, y así
- También al crear reglas, si la regla es muy específica, **DEBE IR DE PRIMERO** antes de las demás reglas, porque la primera regla que haga match con el paquete entonces ya deja de revisar las reglas que están después
- **Las 4 reglas después de las primeras 2 que empiezan con -A** son las más importantes que uno tiene que modificar, **LAS DEMÁS NO SE TOCAN**, de hecho las 4 tampoco se deberían tocar
![[iptablesNormal.jpg]]

 Reglas SUPER IMPORTANTE `INPUT -i lo -j ACCEPT`
-i = interfaz de entrada(lo = la interfaz de la máquina, el este caso se refiere a la interfaz de `loopback)
-j = accion que va a hacer si la regla se cumple, también significa `jump`, y permite saltar a otra regla
-A = Al inicio de reglas, significa `Append`, y es el añadir 
-: al inicio = Los 2 puntos al inicio de la línea son las DEFINICIONES DE CADENAS, donde aquí se ve que están los 3 de INPUT, OUTPUT Y FORWARD, y también los 2 de vcl, esto también nos puede servir para **Modularizar** y hacer cadenas extras, pero sólo si uno tiene muchas reglas


una regla a ya sea {INPUT, OUTPUT, FORWARD}
 La segunda regla después de esta es muy importante también que
 Fui
Hay que

# =====================
Iptables tiene otro tipo de reglas
- Filtrar, que es con lo que siempre se utiliza
- NAT
- mangle, que es tocar los bits de los paquetes, SÓLO USAR cuando se sabe qué se está haciendo
- Raw

También está otro campo pero más grande llamado **Chains**
- input
- output
- forward
# ===================
# IPtables

- **firewalld**: Hace más simple ip tables, pero hace muchas cosas por debajo como por estándar
- **Nftables**: 
Esto puede agarrar un archivo ip tables y cambiarle la sintaxis



# Generación de certificados digitales









# Comandos
Ver procesos de la máquina
`ps ax | less`
lsmod : Sirve para ver procesos de los módulos del kernel, que tal vez puedan no ser necesarios(se pueden encontrar procesos maliciosos si se compara esto en estado actual de la máquina, y una lista de estos pero cuando la máquina estaba desde un estado seguro, como cuando se recién compró), se quitan cosas de aquí con `rmmod`











# View points Ortogonales
