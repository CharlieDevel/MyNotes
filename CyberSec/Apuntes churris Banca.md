
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

Entre máquinas para tener Https
Auténticarse de nuevo con firma digital **cuando se realizan transacciones**

# =======

- Cadenas de seguridad
Las cadenas de seguridad no son sólo tener 2 componentes y que uno se relacione con el otro, y cada uno tiene una propiedad de seguridad, es además de que uno se dirige a otro y le HEREDA la seguridad que tenía al otro, protegiendo así con esa otra propiedad al otro componente

- **Recurso, Procesamiento y Red**
Estas son las 3 arquetipos del software que **la seguridad** busca proteger y manejar estas propiedades, en **cualquiera de sus formas**(hablando de las implementaciones de estas propiedades, donde también los controles de seguridad como auditabilidad que genera bitácoras, entran también como otra forma de esos arquetipos)


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




s