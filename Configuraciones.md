
# Acceder a server en linux en Oracle VM desde Windows
Si uno tiene un linux corriendo en Oracle VM desde windows, y se ejecuta desde el linux un programa que manda informacion a un puerto, hay que
1. Configurar la maquina virtual en la configuración de red/networking que sea **Bridged Adapter** en vez de NAT, porque asi convertimos al linux como otra computadora dentro de la red local de windows
2. Despues iniciar linux con esa configuracion
3. Iniciar el programa(Si es un programa propio, asegurarse de que el programa mande informacion a la IP del linux y puerto deseado)
4. Introducir en terminal *sudo ifconfig* para saber el IP del linux
5. Introducir en windows la IP y puerto en el navegador como por ejemplo “192.168.0.20:3142/”, y listo

# MariaDb Usuario
Este sitio guia como se hacen usuarios, y mostrar la informacion de estos mismos
[How to Create MariaDB User and Grant Privileges (phoenixnap.com)](https://phoenixnap.com/kb/how-to-create-mariadb-user-grant-privileges)

# Usar mariadb
Solo se introduce `sudo mariadb` para ejecutar mariadb como root, pero tambien se puede usar
`maridb -u MyUser -p`, y despues pedira la contrasenha del usuario

# Conectarse a MariaDB con DBeaver
Esto se hizo usando un linux en maquina virtual sobre windows, con dbeaver en windows y MariaFB en linux
Para esto hay que asegurarse de tener la maquina virtual con la configuracion de red de **Bridged Adapter**
- Hay que asegurarse de crear un usuario del tipo `CREATE USER 'user1'@'%' IDENTIFIED BY 'password1';`, la parte `'%'` indica que **cualquier** IP puede conectarse siempre y cuando se este conectando con el usuario y contrasenha aqui(tambien se puede usar un rango de IPs para mas seguridad)
- Dar permisos para este usuario
`GRANT ALL PRIVILEGES ON *.* TO 'user1'@'%' IDENTIFIED BY 'password1' WITH GRANT OPTION;`, la parte de `WITH GRANT OPTION` es importante porque permite a este usuario que cualquiera se conecte remotamente a el
- `FLUSH PRIVILEGES;`

Y con eso se acaba la parte dentro de mariadb
Ahora hay que configurar mariaDB en sus archivos de configuracion para que sea visible a windows, pero no sera visible dentro de linux, porque por defecto mariaDB corre en `localhost:3306`, pero esto no lo puede ver windows, **windows solo puede ver la interfaz de red que linux tiene**, por eso hay que ir al archivo
`sudo nano /etc/mysql/my.cnf`
Y ahi anhadir esta linea
`bind-address = 192.168.1.100`, reemplazar esa IP por la IP que se encuentra en Linux con el ifconfig

Y ahora solo queda conectar DBeaver con esa IP, puerto, usuario y contrasenha y listo
TAMBIEN hay que seleccionar la base de datos que dbeaver va a poder acceder
En MariaDB para ver las bases de datos usa `SHOW DATABASES`

# Apache
Apache tiene una forma de ser configurado **por medio de archivos .conf sueltos**, de modo que hay un archivo principal que arma a los demas, mientras que los demas archivos de configuracion estan encargados de cosas mas a nivel de usuario, como configuracion basica de sitio, modulos y sitios principalmente(pero uno puede crear mas archivos de conf de otro tipo)

Ademas de la modularizacion de la configuracion, apache tambien tiene como **un switch que activa cierta configuracion y otra la mantiene desactivada**, esto se refiere a los **(conf/site/module)-(available/enabled)**, donde por medio de **a2enmod/a2enconf/a2ensite** se activa el modulo/sitio/conf elegido(porque la carpeta correspoondiente, e.g. modules-enabled, crea un symlink a la carpeta con la configuracion inactiva, e.g. modules-available, y se activa asi)
> Pero hay que notar que esto **solo activa el modulo/sitio/conf, y para que apache lo use hay que configurarlo en los archivos de configuracion**

## Activar cierta configuracion en partes especificas
Se puede activar configuracion especifica(que esta en un archivo .conf) a traves del uso de la palabra `Include`, y despues se introduce el path hacia el archivo de configuracion, 
e.g. `Include conf-available/serve-cgi-bin.conf`
Lo cual permite, **sin importar de la configuracion global**, de usar esa configuracion especifica, como una excepcion para lo que se quiera aplicar, por ejemplo el querer usar cgi en un dominio(el cual se representa con `VirtualHost`) donde si se incluye el archivo en el ejemplo en un archivo de configuracion de host/dominio, entonces se activara el cgi en ese dominio


# SSL y Archivos SSL
En este tipo de contexto, existen distintas terminaciones de archivos(.key | .crt | .pem | .csr), pero esto solo indica que estos archivos contienen informacion de SSL, mientras que el contenido de estos archivos **es lo que importa**, donde existen principalmente 2 tipos archivos, los **PRIVATE KEYS Y CERTIFICATES**
Donde ya estos 2 ultimos se pueden encontrar en cualquier archivo con esas terminaciones
Especificamente se maneja asi:
- **.pem**: Estos archivos siginifican que pueden contener uno o mas CERTIFICATES, una cadena de certificados, o una CSR(Certificate Sgining Request)
- **.crt o .cer**: Estos archivos significan que contienen **solo un** certificado
- **.key**: Estos archivos solo contienen una PRIVATE KEY

## CSR
Además ésta en .CSR(Certificate Sign Request), que esto lo que es es básicamente servir como **public key** para alguien que también tiene una private key, y esto luego con una CERTIFICATE(cer) se va a validar que este .csr es válido(al hacer el proceso de autenticar con la private key)
Y con esto ahora se puede generar un CRT, el cual es la forma en la que se representa **cada persona**, donde así cada sitio tiene que generar el crt de cada persona que quiera autenticarse ante el, esto para generar el crt que verifica a esta persona, y así la próxima vez que vaya a auténticarse 
# Hacer que apache reconozca certificados de CLIENTES
Para que apache logre identificar certificados de clientes, es necesario ademas de hacer que apache tenga su propio certificado y lo use en la configuracion `sites-available/default-ssl.conf`, tambien hay que anhadir que pueda reconocer cuando un cliente esta dando un certificado(**Y TAMBIEN** hacer que apache pase los datos de certificado del cliente al otro programa que lo va a leer como cgi)
Habiendo definido que hay que hacer, la configuracion seria la siguiente

## sites-available/default-ssl.conf
En este archivo hay que anhadir unas cosas ademas de las configuradas al haber configurado apache con ssl
1. Anhadir el certificado del cliente
En este paso hay que anhadir el certificado del cliente para que apache pueda confiar en el(en el caso en el que este certificado sea **auto-firmado**), esto se hace por medio de la directiva `SSLCACertificateFile /path/to/client-cert.pem`, y con esto se tiene listo que apache cuando vea a un cliente presentando este certificado auto firmado, se confie en el
2. Hacer que apache verifique clientes
Antes hemos hecho que apache cuando encuentre un certificado entonces confie en el, pero tambien hay que decirle a apache que cada vez que un cliente presente un certificado, apache lo compruebe contra estos certificados que confiamos, esto se hace con `SSLVerifyClient require`, tambien se puede usar `optional`
3. (Opcional) Mandar el .pem certificado a un programa
Este paso permite hacer que apache envie a un programa(como cgi) el recibir informacion del mismo certificado ademas de otros datos SSL, esto se hace poniendo `SSLOptions +ExportCertData` en el campo apropiado(como dentro de los tags<Directory />)


# Acceder a una maquina remota por SSH con ROOT
Para acceder a una maquina con la cuenta ROOT(que ssh no permite, aun cuando la cuenta root exista), se tiene que modificar una linea en `/etc/ssh/sshd_config`, en este archivo hay que encontrar la directiva `PermitRootLogin`, y hacer `PermitRootLogin yes`, y ahora se podra acceder a la maquina como root por default, util para cuando se usa vscode para conectarse a otras maquinas y poder hacer que vscode tambien haga cosas root, como por ejemplo debbuggear procesos ajenos(como con cgi con apache, que cada vez que alguien accede a un programa cgi por http, se levanta un programa cgi y luego se cierra)

# Audit2allow -a
Esto es parte de selinux, que es algo que hace que las cosas no funcionen en la máquina por seguridad y lo hace por medio de booleanos, permisos extra de archivos/directorios(como los de ls -a, pero se puede ver con `ls -alZ`, donde la Z muestra lo de selinux) y por último módulos que son más dinámicos y complicados de detectar error
Getsebool -a / setsebool ()
El audit también tiene el auditwhy que muestra razones por las que una acción de usuario o proceso ha fallado, también hay otra parte donde muestra con muchísimo más detalle los errores de las cosas, `pero se ve muy feo por el formato muy pobre`















s