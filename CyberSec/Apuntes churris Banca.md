
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
- 


Entre máquinas para tener Https
Auténticarse de nuevo con firma digital **cuando se realizan transacciones**

# =======

- Cadenas de seguridad
Las cadenas de seguridad no son sólo tener 2 componentes y que uno se relacione con el otro, y cada uno tiene una propiedad de seguridad, es además de que uno se dirige a otro y le HEREDA la seguridad que tenía al otro, protegiendo así con esa otra propiedad al otro componente
OJO: Esto es una espada de doble filo, porque así como un componente está protegiendo a otro componente, pero alguien logra meterse en un componente, **O el otro**, entonces el atacabnte **puede ser capaz** de meterse en el otro componente de la cadena, y así por todos los demás componentes de la cadena

## **Recurso, Procesamiento y Red**
Estas son las 3 arquetipos del software que **la seguridad** busca proteger y manejar estas propiedades, en **cualquiera de sus formas**(hablando de las implementaciones de estas propiedades, donde también los controles de seguridad como auditabilidad que genera bitácoras, entran también como otra forma de esos arquetipos)

Además ésta el **4to componente**, el **Las personas**, que se refiere a cualquiera de las formas en las que alguien **interactúa con estos arquetipos**

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














# View points Ortogonales
