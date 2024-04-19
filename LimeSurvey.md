
# Creacion de una encuesta
Hay que considerar cosas como:
* Formato en que se presentan las preguntas(Pagina por pregunta, Seccion por seccion, Todos en uno)
* Presentacion de informacion al encuestado y navegacion: Esto se refiere mas a **que tantas cosas puede hace el encuestado**, como navegar hacia atras, saltarse secciones, mostrarlas repsuestas restantes, etc
* Recolectar los datos lo **mas crudo posible**; Esto se refiere a que cuando se hagan las preguntas, realizar estas preguntsas de tal forma que el encuestado responda de la forma mas cruda y clara posible, para luego en el analisis de datos manejarlo con facilidad
		E. g. al pedir edad marcar que se reciba **solo numeros**, y eso deja los datos bien crudos y no tan pre-procesados, como lo seria poner la edad en **intervalos, como 10-15, 16-20, etc**(Solo se deberia usar el **pre-procesamiento** si se tiene una buena razon para ello, de otra forma va a ser un obstaculo)
## Condiciones de aparicion de preguntas
Esto se hace al seleccionar una pregunta en la **Estructura**, y dar click en **Agregar y editar condiciones**
Lo malo es que si por ejemplo en consentimiento informado, que implica el que el encuestado realice todas las preguntas o no, singifica que tenemos que ir a cada pregunta, y establecer la condicion donde si el consentimiento informado es (SI), entonces se muestra, eso se realiza para todas las preguntas
> Lo bueno es que tambien existe el boton de **Copiar condiciones**, que al darle click, muestra una pantalla con todas las condiciones previamente definidas en otras preguntas, y se puede clickar para hacer que tambien esa condicion aplique a a la misma pregunta

## Tipos de Condicionales
Los condicionales no solo aplican a las preguntas, sino que tambien pueden aplicar a **atributos del encuestado**, donde por ejemplo se puede identificar si el encuestado en la base de datos es marcado como estudiante de enfermeria, y si lo es entonces se le debe ocultar una pregunta que a otros estudiantes se les debe mostrar

# Despues de crear encuestas
## Modificar encuestas ya publicadas
Si la encuesta **no se ha publicado**, se puede modificar **cualquier campo**
PERO si la encuesta **ya esta publicada y alguien la ha respondido**, entonces NO se pueden modificar todos los campos. Por ejemplo si se quiere modificar la redaccion de una pregunta entonces si se puede, **pero** si se quiere modificar el tipo de respuesta(e. g. cambiar de "Si o No" a "Multiopcion") entonces no se puede modificar la encuesta
> La unica forma de modificar ese tipo de datos es creando una nueva version, pero se **perderan los datos**, por eso es importante **testear y verificar con otras personas la encuesta**

# Activación de la encuesta
* Opciones especiales
Estas opciones son específicas sobre que información recolectar o como manejarla cuando alguien la responde y de guardan los datos, o también que sea de **Acceso Restringido** (sólo se puede respondercon un Link y/o contraseña, y se necesita una tabla de participantes)
* Tabla de participantes
Nueva sección que sólo aparece al tener la encuesta en **Acceso Restringido** 
# Factores
* Dependiendo de la configuración del LimeSurvey, las relaciones de los datos en bases de datos **se verá afectada**

* Es aplicable el conocer de **enfoques *Cuantitativo* y *Cualitativos*** a la hora de hacer las preguntas y su recoleccion

* CUIDADO con idioma de la encuesta por bases de datos
Al configurar varias preguntas en diferentes idiomas, incluso como Español(Colombia)/Español(España), por cada pregunta se creará **una Base de Datos diferente por cada idioma**, donde los que respondieron en inglés aparecerán en una base de datos, y los de español en otra

* Captura de respuestas y participantes
Se generarán 2 bases de datos, la de los que **Participaron** y **qué ha sido contestado**, pero dependiendo de cómo este configurada la encuesta(e. G. Respuestas anónimas) entonces se hará esa separación **En las bases de datos generadas**

* **Cuotas**: Es el **costo** de que una persona responda el cuestionario, se puede controlar el limite en la configuracion de la encuesta

Por el minuto 1:57:00 del primer video empieza a explicar como crear cada pregunta
En el minuto *2:26:00* O *2:28:50* Empiezan conceptos mas de logica, que seria cuando ya se tienen las preguntas definidas y se empieza a hacer **logica tipo porgramacion**, e. g. si se respondio una pregunta con una respuesta en especifico, entonces se van a ocultar otras preguntas, consentimiento informado, etc

PENDIENTE minuto3:00:0
La parte de **Activacion de la encuesta**

 Minuto 3:22:00 se explica como **recordar datos**
 > DUDA IMPORTANTE
 > En minuto 3:23:40 se empieza a hablar de exportar los datos, pero hay que tener cuidado con la exportación si luego se quiere sacar datos más estadísticos como la media o así
 > RESPUESTA: La doble dimensión es en realidad cómo esos datos se representan en el archivo exportado, si como en código o string tal cual(tipo si hay preguntas con "si o no" entonces algo que permita la dimensiónalidad permite visualizar eso como "Si" ó "1", como el SPSS)
# Exportar datos 





La