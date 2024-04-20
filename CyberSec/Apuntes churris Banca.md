
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

- Cadenas de segurida
Las cadenas de seguridad no son sólo tener 2 componentes y que uno se relacione con el otro, y cada uno tiene una propiedad de seguridad, es además de que uno se dirige a otro y le HEREDA la seguridad que tenía al otro, protegiendo así con esa otra propiedad al otro componente















s