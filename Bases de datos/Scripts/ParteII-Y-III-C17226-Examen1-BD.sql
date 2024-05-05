--CREATE DATABASE C17226_Examen_1;

--//===========================  Entidades fuertes

CREATE TABLE C17226_Examen_1.dbo.Persona (
	nombre varchar(255),
	correo varchar(255) NOT NULL,
	CONSTRAINT PK_Persona PRIMARY KEY (correo)
);

CREATE TABLE C17226_Examen_1.dbo.Consola (
	nombre varchar(255) NOT NULL,
	companhia varchar(255) NOT NULL,
	anhoSalida int,
	CONSTRAINT PK_Consola PRIMARY KEY (nombre, companhia)
);

CREATE TABLE C17226_Examen_1.dbo.Material (
	nombre varchar(255) NOT NULL,
	textura varchar(255),
	descripcion varchar(255),
	CONSTRAINT PK_Material PRIMARY KEY (nombre)
);

CREATE TABLE C17226_Examen_1.dbo.Area (
	nombre varchar(255) NOT NULL,
	mapaUbicado varchar(255),
	CONSTRAINT PK_Area PRIMARY KEY (nombre)
);

CREATE TABLE C17226_Examen_1.dbo.Equipamiento (
	nombre varchar(255) NOT NULL,
	lugar varchar(255),
	texturaImagen varchar(255),
	cantDefensa int,
	cantAtaque int,
	color varchar(255),
	tipoEquipamiento varchar(255),
	CONSTRAINT PK_Equipamiento PRIMARY KEY (nombre)
);

--//===========================  Entidades debiles

CREATE TABLE C17226_Examen_1.dbo.Cuenta (
	correoPersona varchar(255) NOT NULL,
	username varchar(255) NOT NULL,
	contrasenha varchar(255),
	defensaTotal int,
	ataqueTotal int,
	CONSTRAINT PK_Cuenta PRIMARY KEY (correoPersona, username),
	CONSTRAINT FK_Cuenta_Persona_correo FOREIGN KEY (correoPersona) REFERENCES C17226_Examen_1.dbo.Persona(correo)
);

CREATE TABLE C17226_Examen_1.dbo.Logro (
	nombre varchar(255) NOT NULL,
	nombreConsola varchar(255) NOT NULL,
	companhiaConsola varchar(255) NOT NULL,
	imagen varchar(255),
	descripcion varchar(255),
	CONSTRAINT PK_Logro PRIMARY KEY (nombre, nombreConsola, companhiaConsola),
	CONSTRAINT FK_Logro_Consola_nombreConsola_companhiaConsola 
		FOREIGN KEY (nombreConsola, companhiaConsola) 
		REFERENCES C17226_Examen_1.dbo.Consola(nombre, companhia)
);


CREATE TABLE C17226_Examen_1.dbo.Edificio (
	nombreArea varchar(255) NOT NULL,
	nombre varchar(255) NOT NULL,
	imagen varchar(255),
	tipoEdificio varchar(255) NOT NULL,
	CONSTRAINT PK_Edificio PRIMARY KEY (nombreArea, nombre),
	CONSTRAINT FK_Edificio_Area_nombre FOREIGN KEY (nombreArea) REFERENCES C17226_Examen_1.dbo.Area(nombre)
);


--//===========================  M:N

CREATE TABLE C17226_Examen_1.dbo.Juega (
	nombreConsola varchar(255) NOT NULL,
	companhiaConsola varchar(255) NOT NULL,
	correoPersona varchar(255) NOT NULL,
	CONSTRAINT PK_Juega PRIMARY KEY (nombreConsola, companhiaConsola, correoPersona),
	CONSTRAINT FK_Juega_Consola_nombreConsola_companhiaConsola FOREIGN KEY (nombreConsola, companhiaConsola) REFERENCES Consola(nombre, companhia),
	CONSTRAINT FK_Juega_Persona_correoPersona FOREIGN KEY (correoPersona) REFERENCES Persona(correo)
);

CREATE TABLE C17226_Examen_1.dbo.Accede (
	correoCuenta varchar(255) NOT NULL,
	usernameCuenta varchar(255) NOT NULL,
	nombreArea varchar(255) NOT NULL,
	CONSTRAINT PK_Accede PRIMARY KEY (correoCuenta, usernameCuenta, nombreArea),
	CONSTRAINT FK_Accede_Cuenta_correoCuenta_usernameCuenta FOREIGN KEY (correoCuenta, usernameCuenta) REFERENCES C17226_Examen_1.dbo.Cuenta(correoPersona, username),
	CONSTRAINT FK_Accede_Area_nombreArea FOREIGN KEY (nombreArea) REFERENCES C17226_Examen_1.dbo.Area(nombre)
);

CREATE TABLE CuentaTieneEquipamiento(
	correoCuentaPerteneciente varchar(255) NOT NULL,
	usernameCuentaPerteneciente varchar(255) NOT NULL,
	nombreEquipamiento varchar(255) NOT NULL,
	equipado smallint DEFAULT 0,
	PRIMARY KEY(correoCuentaPerteneciente, usernameCuentaPerteneciente, nombreEquipamiento),
	CONSTRAINT FK_CuentaTieneEquipamiento_Cuenta_correoCuentaPerteneciente_usernameCuentaPerteneciente
		FOREIGN KEY (correoCuentaPerteneciente, usernameCuentaPerteneciente)
		REFERENCES C17226_Examen_1.dbo.Cuenta(correoPersona, username),
	CONSTRAINT FK_CuentaTieneEquipamiento_Equipamiento_nombreEquipamiento
		FOREIGN KEY (nombreEquipamiento)
		REFERENCES C17226_Examen_1.dbo.Equipamiento(nombre)
);

CREATE TABLE C17226_Examen_1.dbo.CuentaTieneMaterial (
	correoCuenta varchar(255) NOT NULL,
	usernameCuenta varchar(255) NOT NULL,
	nombreMaterial varchar(255) NOT NULL,
	cantidad int DEFAULT 0,
	CONSTRAINT PK_CuentaTieneMaterial PRIMARY KEY (correoCuenta, usernameCuenta, nombreMaterial),
	CONSTRAINT FK_CuentaTieneMaterial_Cuenta_correoCuenta_usernameCuenta 
		FOREIGN KEY (correoCuenta, usernameCuenta) 
		REFERENCES C17226_Examen_1.dbo.Cuenta(correoPersona, username),
	CONSTRAINT FK_CuentaTieneMaterial_Material_nombreMaterial 
		FOREIGN KEY (nombreMaterial) 
		REFERENCES C17226_Examen_1.dbo.Material(nombre)
);

--//===========================  1:N

CREATE TABLE C17226_Examen_1.dbo.Gana (
	nombreLogro varchar(255) NOT NULL,
	nombreConsola varchar(255) NOT NULL,
	companhiaConsola varchar(255) NOT NULL,
	correoCuenta varchar(255) NOT NULL,
	usernameCuenta varchar(255) NOT NULL,
	CONSTRAINT PK_Gana PRIMARY KEY (nombreLogro, nombreConsola, companhiaConsola, correoCuenta, usernameCuenta),
	CONSTRAINT FK_Gana_Logro_nombreLogro_nombreConsola_companhiaConsola 
		FOREIGN KEY (nombreLogro, nombreConsola, companhiaConsola) 
		REFERENCES C17226_Examen_1.dbo.Logro(nombre, nombreConsola, companhiaConsola),
	CONSTRAINT FK_Gana_Cuenta_correoCuenta_usernameCuenta FOREIGN KEY (correoCuenta, usernameCuenta) REFERENCES C17226_Examen_1.dbo.Cuenta(correoPersona, username)
);

--//===========================  Recursivas

CREATE TABLE C17226_Examen_1.dbo.Relacion (
	correoCuentaEmisora varchar(255) NOT NULL,
	usernameCuentaEmisora varchar(255) NOT NULL,
	correoCuentaReceptora varchar(255) NOT NULL,
	usernameCuentaReceptora varchar(255) NOT NULL,
	tipoRelacion varchar(255),
	CHECK (tipoRelacion = 'Amistad' OR tipoRelacion = 'Bloqueo'),
	CONSTRAINT PK_Relacion PRIMARY KEY (correoCuentaEmisora, usernameCuentaEmisora, correoCuentaReceptora, usernameCuentaReceptora),
	CONSTRAINT FK_Relacion_Cuenta_correoCuentaEmisora_usernameCuentaEmisora 
		FOREIGN KEY (correoCuentaEmisora, usernameCuentaEmisora) 
		REFERENCES C17226_Examen_1.dbo.Cuenta(correoPersona, username),
	CONSTRAINT FK_Relacion_Cuenta_correoCuentaReceptora_usernameCuentaReceptora 
		FOREIGN KEY (correoCuentaReceptora, usernameCuentaReceptora) 
		REFERENCES C17226_Examen_1.dbo.Cuenta(correoPersona, username)
);


CREATE TABLE C17226_Examen_1.dbo.Crea (
	materialCreado  varchar(255) NOT NULL,
	CONSTRAINT PK_Crea PRIMARY KEY (materialCreado),
	CONSTRAINT FK_Crea_Material_nombreMaterialCreado FOREIGN KEY (materialCreado ) REFERENCES C17226_Examen_1.dbo.Material(nombre)
);

CREATE TABLE C17226_Examen_1.dbo.MaterialesParaCrear (
	materialCreado varchar(255) NOT NULL,
	nombreMaterial varchar(255) NOT NULL,
	cantRequerida int NOT NULL,
	CONSTRAINT PK_MaterialesParaCrear PRIMARY KEY (MaterialCreado, nombreMaterial),
	CONSTRAINT FK_MaterialesParaCrear_Material_nombreMaterial FOREIGN KEY (nombreMaterial) REFERENCES C17226_Examen_1.dbo.Material(nombre),
	CONSTRAINT FK_MaterialesParaCrear_Crea_materialCreado FOREIGN KEY (materialCreado ) REFERENCES C17226_Examen_1.dbo.Crea(materialCreado)
);

/*  
Parte 3
	-Material, relacion recursiva en disenho logico
El problema de Material y las recetas para crear otros materiales era que se usaba un Id de tipo int que queria identificar una receta y en la tabla "Crea", donde estan los resultados de las recetas, aparceria ahi el atributo ID como FK,
ese id seria la llave primaria de la tabla "MaterialesParaCrear", pero si ese ID era la llave primaria entonces no se podria ya meter materiales de otro tipo, como hacer que un pico de oro se represente en la base de datos como el resultado de 2 de oro y 3 de madera, porque el ID solo registra uno de ellos, y si se usaba la alternativa de que en el "MaterialesParaCrear" se tenian 2 atributos para formar el PK, el ID y el material que forma parte de la receta, entonces ahora el probelma es que no se puede usar el ID como FK en la tabla "Crea", porque un FK tiene que ser *toda* la llave primaria de la otra tabla, no una parte
Por lo que la solucion es hacer lo que normalmente se hace en el paso de conversion de disenho coneptual a logico, en el que convertimos una relacion 1:N en otra tabla, usando referencias cruzadas, y ahora "MaterialesParaCrear" va a tener 2 FKs, y ambos seran la llave primaria, donde un componente es de la tabla "Crea", y el otro atributo es de la tabla "Material"

	-En disenho logico falta la relacion entre Material y Cuenta
No se hizo la relacion entre Cuenta y Matierial que debia existir y esta en el disenho coneptual
La solucion es anhadirla

	-Logro como entidad fuerte en el disenho conceptual
El disenho conceptual tiene al logro como una entidad fuerte, pero deberia ser una entidad debil porque los logros dependen de la entidad Consola, porque son especificos a cada consola
La solucion es hacerlo una entidad debil y su duenha es la 

	-Triple relacion
La triple relacion no era necesaria porque introduce mas complejidad por involucrar 3 entidades, cuando pueden ser 2 entidades por medio de hacer que logro sea una entidad debil ya que logro al ser debil incluye los datos de la consola en la que se obitene el logro, y la cuenta ya obtiene ese logro

	-Cardinalildad de Material y Equipamiento
La cardinalidad de estaS tablas deberia ser M:N y no 1:N porque el equipamiento y Material pueden existir y estar para varios usuarios

**/

--//===========================  Insercion de datos
INSERT INTO C17226_Examen_1.dbo.Consola (nombre,companhia,anhoSalida) VALUES
	 (N'wii',N'nintendo',1999),
	 (N'xbox',N'microsoft',2000);

INSERT INTO C17226_Examen_1.dbo.Area (nombre) VALUES
	 (N'pretil'),
	 (N'parque');

INSERT INTO C17226_Examen_1.dbo.Equipamiento (nombre,lugar,texturaImagen,cantDefensa,cantAtaque,color,tipoEquipamiento) VALUES
	 (N'casco de oro',N'cabeza',NULL,33,4,N'amarillo',N'casco'),
	 (N'guantes de goma',N'manos',NULL,10,13,N'blanco',N'manos'),
	 (N'casco power ranger',N'cabeza',NULL,10,20,N'rojo',N'casco');
	
INSERT INTO C17226_Examen_1.dbo.Edificio (nombreArea,nombre,imagen,tipoEdificio) VALUES
	 (N'pretil',N'biblioteca CM',NULL,N'Decorativo'),
	 (N'pretil',N'EEG',NULL,N'Interactivo');

INSERT INTO C17226_Examen_1.dbo.Persona (nombre,correo) VALUES
	 (N'ana',N'ana@gmail.com'),
	 (N'john',N'john@gmail.com');

INSERT INTO C17226_Examen_1.dbo.Cuenta (correoPersona,username,contrasenha) VALUES
	 (N'ana@gmail.com',N'annna',N'annna'),
	 (N'john@gmail.com',N'johhhn',N'johhhn');

INSERT INTO C17226_Examen_1.dbo.Relacion (correoCuentaEmisora,usernameCuentaEmisora,correoCuentaReceptora,usernameCuentaReceptora,tipoRelacion) VALUES
	 (N'ana@gmail.com',N'annna',N'john@gmail.com',N'johhhn',N'Amistad'),
	 (N'john@gmail.com',N'johhhn',N'ana@gmail.com',N'annna',N'Amistad');

INSERT INTO C17226_Examen_1.dbo.Accede (correoCuenta,usernameCuenta,nombreArea) VALUES
	 (N'ana@gmail.com',N'annna',N'pretil'),
	 (N'john@gmail.com',N'johhhn',N'parque');

INSERT INTO C17226_Examen_1.dbo.Logro (nombre,nombreConsola,companhiaConsola,imagen,descripcion) VALUES
	 (N'novato',N'xbox',N'microsoft',NULL,N'accede por primera vez al juego'),
	 (N'premium',N'xbox',N'microsoft',NULL,N'compra una cuenta premium');

INSERT INTO C17226_Examen_1.dbo.Gana (nombreLogro,nombreConsola,companhiaConsola,correoCuenta,usernameCuenta) VALUES
	 (N'novato',N'xbox',N'microsoft',N'john@gmail.com',N'johhhn'),
	 (N'premium',N'xbox',N'microsoft',N'ana@gmail.com',N'annna');

INSERT INTO C17226_Examen_1.dbo.Material (nombre,textura,descripcion) VALUES
	 (N'madera',NULL,N'madera para construir'),
	 (N'oro',NULL,N'crea materiales hechos con oro'),
	 (N'pico de oro',NULL,N'pica mejor que un pico de piedra'),
	 (N'piedra',NULL,N'crea materiales hechos con piedra'),
	 (N'valla',NULL,N'bloquea el paso para delimitar un area'),
	 (N'valla de oro',NULL,N'valla mejorada con oro');

INSERT INTO C17226_Examen_1.dbo.Crea (materialCreado) VALUES
	 (N'pico de oro'),
	 (N'valla'),
	 (N'valla de oro');

INSERT INTO C17226_Examen_1.dbo.MaterialesParaCrear (materialCreado,nombreMaterial,cantRequerida) VALUES
	 (N'pico de oro',N'madera',3),
	 (N'pico de oro',N'oro',2),
	 (N'valla',N'madera',6),
	 (N'valla de oro',N'oro',4),
	 (N'valla de oro',N'valla',1);

INSERT INTO C17226_Examen_1.dbo.CuentaTieneEquipamiento (correoCuentaPerteneciente,usernameCuentaPerteneciente,nombreEquipamiento,equipado) VALUES
	 (N'ana@gmail.com',N'annna',N'casco power ranger',1),
	 (N'john@gmail.com',N'johhhn',N'casco de oro',1),
	 (N'john@gmail.com',N'johhhn',N'guantes de goma',1);

	
INSERT INTO C17226_Examen_1.dbo.Juega (nombreConsola,companhiaConsola,correoPersona) VALUES
	 (N'xbox',N'microsoft',N'ana@gmail.com'),
	 (N'xbox',N'microsoft',N'john@gmail.com');

INSERT INTO C17226_Examen_1.dbo.CuentaTieneMaterial (correoCuenta,usernameCuenta,nombreMaterial,cantidad) VALUES
	 (N'ana@gmail.com',N'annna',N'oro',7),
	 (N'john@gmail.com',N'johhhn',N'oro',6);

--//===========================  parte II.4
SELECT c.correoPersona, c.username FROM 
Cuenta c 
INNER JOIN CuentaTieneMaterial ctm 
ON c.correoPersona = ctm.correoCuenta
WHERE EXISTS( --Verificar que exista antes las cuentas que tengan el casco power ranger rojo
	SELECT * FROM Equipamiento e 
	INNER JOIN CuentaTieneEquipamiento cte 
	ON e.nombre = cte.nombreEquipamiento 
	WHERE e.nombre = 'casco power ranger' AND e.color = 'rojo' 
	AND cte.correoCuentaPerteneciente  = c.correoPersona AND cte.usernameCuentaPerteneciente  = c.username 
)
AND ctm.nombreMaterial = 'oro' AND ctm.cantidad > 5; --Si existen cuentas con casco power ranger rojo, verificar que tengan mas de 5 de oro

--//===========================  parte II.5
drop procedure ActualizarStatsEquipamiento;
CREATE PROCEDURE ActualizarStatsEquipamiento(
	@correo varchar(255),
	@username varchar(255)
)
AS
BEGIN
	DECLARE @defensaTotal int;
	DECLARE @ataqueTotal int;
	
	IF NOT EXISTS(
		SELECT * FROM Cuenta c 
		WHERE c.correoPersona = @correo AND c.username = @username
	)
	BEGIN 
		PRINT('No existe nadie con los valores dados, cancelando operacion');
	END
	ELSE 
	BEGIN		
		SELECT @ataqueTotal = SUM(e.cantAtaque) FROM Equipamiento e
		INNER JOIN CuentaTieneEquipamiento cte ON e.nombre = cte.nombreEquipamiento 
		WHERE cte.correoCuentaPerteneciente = @correo AND cte.usernameCuentaPerteneciente = @username;
		
		SELECT @defensaTotal = SUM(e.cantDefensa) FROM Equipamiento e
		INNER JOIN CuentaTieneEquipamiento cte ON e.nombre = cte.nombreEquipamiento 
		WHERE cte.correoCuentaPerteneciente = @correo AND cte.usernameCuentaPerteneciente = @username;
		
		UPDATE Cuenta 
		SET ataqueTotal = @ataqueTotal
		WHERE correoPersona = @correo AND username = @username;
	
		UPDATE Cuenta 
		SET defensaTotal = @defensaTotal
		WHERE correoPersona = @correo AND username = @username;
		
		PRINT ('Operacion realizada con exito');
	END

END;

EXEC ActualizarStatsEquipamiento @correo = 'asdj', @username = 'asd' 

EXEC ActualizarStatsEquipamiento @correo = 'john@gmail.com', @username = 'johhhn' 

--//===========================  parte II.6
/*  
El registro del que alguien haya ganado un equipamiento me parece que se manejaria mejor en la aplicacion y ya no tanto en la base de datos porque esto tiene origen en la aplicacion y habria logica de validacion que se ocupe de la asignacion, la cual iria junto a la logica de validacion, y por esto estaria mejor en la aplicacion
Pero las restricciones a nivel de bases de datos existe la tabla de CuentaTieneEquipamiento, donde se registra con las FK el equipo conseguido por los jugadores, y se verifica que ha ganado el equipamiento, aunque no hay logica que verifique si lo ha conseguido o no, principalmente por la dificultad de saber desde base de datos como consiguio el equipo

 */











