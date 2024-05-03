
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