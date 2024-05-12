**

//ーーーーーーーーーーーーーーーーー 

//=====  Cuándo deben haber ENTIDADES DÉBILES?

Cuando la  「entidad en sí o los atributos」 de esa entidad dependan de 『otras entidades u otros atributos』, en ese orden

//=====  Cómo hacer buen 『diseño conceptual』 al leer el análisis

※ Saber identificar 『cuándo el análisis está siendo ESCUETO y cuándo está siendo EXACTO』, Identificar cuándo está hablando sobre propiedades que cualquier cosa puede tener(entidades, relaciones y atributos siempre PUEDEN tener 「información compuesta o atributos」) y cuándo está hablando de problemas que deben aparecer en el diseño como resueltos usando X atributos o Y relaciones

※ Saber cuándo están hablando de valores de un atributo de una entidad

※ CUando se habla de un sustantivo y se la da un énfasis 『imperativo』, significa que debe ser una 『Relación』, siempre y cuando hayan varias entidades involucradas

//ーーーーーーーーーーーーーーーーー 

  
  

//===========================  Diagramas EER

  
  

.• ° •.  Día 1

Doble línea = TIENE que participar

La relación tiene doble rombo [Singifica que] la entidad débil NECESITA la entidad fuerte para EXISTIR
La relación tiene doble línea [Singifica que] la entidad tiene participacion OBLIGATORIA en la relacion con la otra entidad
  
  

-Especialización de entidades : Es literal 「Herencia」 de atributos de la super entidad que hereda

Recuerda la entidad base tiene la especialización de forma 「opcional u obligatoria」, por ejemplo un ESTUDIANTE es opcional que sea de una ASOCIACIÓN, pero es obligatorio que sea de PREGRADO o POSTGRADO

También existe la restricción de que las especializaciones sean excluyentes o no, un ESTUDIANTE puede ser de pre y postgrado si está en carreras diferentes

  
  

//===========================  Especializacion

se da para 2 propósitos:

       -Entrar tener muchos 『atributos nulos』

       -Heredar y separar

  
  
  
  

.• ° •.  Día 2 -  Diseño lógico

  
  

Basado en 『relaciones』, es un conjunto de atributos, sin orden

Es sólo una tabla

  
  
  
  
  
  

Super llave : Atributos en plural, en una MISMA tabla que debe cumplir 「ser únicos」

Llave única : Atributo singular y mínimo que 「debe ser único」

Llave primaria :  Una llave única que es escogida, e identifica

Llave foránea : Es una 『referencia entre 2 tablas』, básicamente un atributo que comparten 2

Básicamente, en una fila, hay un atributo que es sólo un atributo, pero está en otra tabla, y en esa tabla es una 『llave primaria』, por lo tanto, ese atributo es una llave foránea

       -Una llave foránea puede 「estar compuesta de varios atributos」, porque si hay una entidad débil dueña de otra entidad débil, la más débil va a a estar atada a los atributos de la dueña si son varios

  

.• ° •.  Dia 3

//===========================  Pasar modelo conceptual a modelo lógico

Las llaves compuestas se pasan a una dimensión, porque son de w dimensiones

  
  
  

Utils: Útiles de la clase

En este caso, ""Acronym" es parte de la relación porque es una 『Entidad Débil』, y SIEMPRE mantiene como llave primaria la parcial, y la llave primaria de su dueña

  
  
  

Esto es malo de entidad débil es dueña de otra es malo porque al hacer las llaves foráneas ocasiona que se repitan datos en las relaciones cuando se da el paso 5 de hacer tablas de relaciones binarias N:M

  

En este paso, si opta por usar el approach de llaves foráneas, se 「modifica la relación que tiene el N a la par」, y el atributo añadido es la llave primaria de la otra entidad de la relación que tiene un 1 a la par

  
  

Si se opta por el cross reference, se crea una nueva relación con el nombre del rombo y una de las entidades, y los atributos 『deben ser llaves foráneas』, y uno de los atributos, o ambos pueden ser parte de la llave primaria

  

Después del paso 2, TODOS los atributos que son 『de las relaciones』 se empiezan a mapear

  

En el paso 2, si la relación débil tiene en su doble rombo un atributo, ese atributo del doble rombo se pasa a la 『entidad débil』

  

En este paso no importa si una de las entidades es débil y tiene varios atributos como llaves primarias dados por puros pasos, 『sólo se pone la llave primaria dada por el diseño conceptual de ambas entidades』 y listo

  
  

.• ° •.  Dia 5

  
  

       -Data definition language : Permite definir el esquema de los modelos, y la base de datos almacena los datos

  
  

       - Data Manipulation Language: Se puede manipular e interactuar con los datos y los meta datos como usuario final

Catálogo : Almacena los esquemas

  
  

Esquema : La definición y estructura de los datos, define qué se puede mapear, como por ejemplo roles o perfiles, y ser guardado en el catálogo, es básicamente 『que puede ver qué información』, si un usuario normal accede qué debería ver y qué no ver

  
  

.• ° •.  Día 5 - SQL Avanzado

  

Consultas anidadas

Se maneja por conjuntos

Por ejemplo, se escoge una columna, la cual es ACRÓNIMO, y como acrónimo está en 2 tablas, se puede anidar y hacer consulta

Se va haciendo de dentro hacia afuera, donde se puede imaginar que se devuelve los resultados como una tabla nueva temporal, y de ahí hacemos OTRO query, siempre y cuando los atributos que hacen el link entre ambos querys APARECEN en ambas tablas

  

.• ° •.  Día 7

  
  

       -triggers

Indica que ANTES o DESPUÉS DE una acción, debe realizarse OTRA ACCIÓN

Si hay procesos que se deben hacer en TODA la tabla, y se requiera que cuando una acción se haga en una tabla, en otra tabla que puede NO estar relacionada directamente, TIENE QUE actualizarse o responder según dependiendo acción hecha en esa tabla, para mantener la COHERENCIA

  
  

       -Coherencia dinámica

Para determinar si la actualización de datos debe hacerse antes o después se debería simplemente seguir el sentido común, porque esos triggers son una herramienta para reflejar COMO las funcionan en la vida real

  

.• ° •.  Día 9 - Repaso normalIzación

  

En transacciones, una "T" significa una transacción

  

.• ° •.  Día 12 - Control de concurrencia

  
  

Palabra clave: Transacción y atomicidad

//=====  Principios ACID

Consistencia: Atributo de la base de datos que dice que la información sea significativa y refleje la realidad que está implementando, y la aplicación debe garantizar esa consistencia porque la aplicación es la que va a definir cómo funciona el negocio, y la base de datos simplemente lo simula de la menor forma

Independiente: La transacción tiene sentido en sí misma y no requiere un sentido de secuencia serial o concurrente para sacar el mismo resultado

Durabilidad: Mantener la información en la base de datos y que sea recuperable siempre y resistente a errores, recuperación ante cualquier situación

  

Schedule: Orden en particular en que transacciones son ejecutadas

El schedule con la menor cantidad de conflictos es el serial

  
  

       -Schedule concurrente puede ser igual que el serial

También está el caso en el que tenemos 2 hilos, está un hilo ejecutando A y el otro hilo está dormido, luego la CPU despierta al hilo 2 y le quita el trabajo al hilo 1 para dárselo al hilo 2, ahora el hilo 2 está trabajando y el 1 está dormido, y eso daría el mismo 『Schedule』 que una ejecución serial

       -Problemas de concurrencia igual suceden

Pero igual existe la posibilidad de errores como la inconsistencia, donde el hilo 1 estaba en medio de una transacción, modifico pero no hizo COMMIT, y en medio de ese trabajo el otro hilo lo retoma y ese hilo hace read al dato que modifico el hilo 1, pero como el cambio no sé guardo entonces se genera un LOST UPDATE, y se pierde la consistencia de los datos

  

       -Lectura sucia

Ocurre cuando se hace un ABORTO de la transacción, y es cuando se hace rollback para deshacer todas las operaciones hechas, PERO sólo tienen efecto en un hilo, y se hicieron 2 hilos que modificaron datos, Y uno de ellos hacer rollback, entonces los cambios del otro hilo NO son deshechos

  

       -Unrepeatable Read

,        -Phantom read

Se tiene al hilo 1 leyendo tuplas de un data item, pero luego se cambia el contexto a otro hilo que modifica esa tabla, y se devuelve el contexto al hilo 1, y de ahí se vuelve a leer la tupla y no queda bien la información

  

       -Seriabilidad

Esto son las distintas formas en las que una transacción se ejecute pero de forma concurrente, pero al final quede como una ejecución serial, como por ejemplo que un hilo se hasta encargado de la primera 3 líneas y el otro las 7 restantes, o que en otro caso el primer hilo ejecutó 5 líneas y el otro ejecutó las otras t

  

       -Problema de seriabilidad

Los problemas se dan cuando sólo se leen data items, en cualquier otro caso como que un sólo hilo haga un read y los demás sólo lean, puede existir la posibilidad de errores

  

Equivalente por conflictos

Se puede hacer swaps entre instrucciones que son seriales Y TAMBIÉN no conflictivas, y ambas transacción, que es la transacción con un orden en edificio y la otra con un orden swapeado, entonces serán equivalentes por conflictos

Y así se puede ir moviendo a un Schedule serializable por conflictos

Así se tiene una ejecución en específico que protege de problemas concurrentes

  
  

Yo puedo leer siempre y cuando no han nadie escribiendo, o al revés donde puedo escribir si no hay nadie leyendo

Eso es una solución para la inanición de hilos

  

       -2PL

La transacción va a pedir todos los candados en la fase de crecimiento,

En la fase de contracción es en donde se van liberando los candados

Se caracteriza por usar candados short, candados de corta duración donde apenas ya no sé usan se liberan

  

       -Strict 2PL

Los candados son long ahora, y es cuando se hace un commit o abort en vez de apenas dejar de ser usados, como al momento de cambiar de contexto

  

Diapositiva 72

El IX se puede convertir en un IS si un hijo sólo quiere leer

  
  

.• ° •.  Día 16 - Optimización y álgebra booleana

  
  

//ーーーーーーーーーーーーーーーーー  Keywords

//ーーーーーーーーーーーーーーーーーーーーーー 

  

//=====  IN : Del lado derecho se debe mostrar VALORES DE TUPLAS, y del lado izquierdo la columna de la tabla exterior, la cual DEBE ESTAR también en la tabla interior

Es básicamente un INTERSECTION, pero los resultados pueden ser MÁS de una sola columna

  
  

       -Es un shortcut de múltiples operadores OR para incluir datos

  

       -Usage of EXISTS

```

  

-- Creacion de trigger para evitar meter a alguien en la tabla dependiendo de una condicion. Verificar que en la tabla de estudiantes NO haya un estudiante con cedula que ya esta en la tabla de Profesores

   IF EXISTS(

       SELECT * FROM INSERTED

       WHERE EXISTS (

           SELECT * FROM Estudiante e

           WHERE e.Cedula = INSERTED.Cedula

       )

```

The EXISTS works different if used in an IF statement, or with a WHERE clause

The EXISTS has a parenthesis right after it, and in that parenthesis there should be a query from the DQL ALWAYS

For IF statements, its simple, if the table returned inside the parenthesis 『has at least one row then returns true』, if the table is empty then it returns false

Now when used along WHERE clauses, the EXISTS works like a "foreach" loop that applies to the outer SELECT, and the "predicate" is inside the parenthesis, making the inner query have a WHERE clause that 『must use the columns from the outer query』

  
  

SELECT column1 FROM table1

WHERE EXISTS(SELECT column2 FROM table2

WHERE table2.column2 = table1.column1)

  
  

That query will return a table containing rows from table1, but only show the rows that 『fulfilled the predicate in the inner query』

  

//=====  EXISTS : Es como cómo el IN pero con AND

  

//=====  NOT EXISTS : El complemento de los datos en la totalidad de la tablatabla

  
  

=//=====  LEFT JOIN

Takes

  
  

//=====  Group by

       ※ Resumen: La estrella en "COUNT(*)" o cUalquier otra función de agregación sólo indica si incluye valores nulls o no, la elección de la columna que se quiere contar se hace gracias al group by, el cual nos permite elegir que columnas queremos que cuente los valores que sean iguales

※ Si se usa COUNT() con la estrella, significa que incluya los valores NULOS, mientras que si ponemos el nombre de la columna, va a contar sólo los valores NO NULOS

Esta operación básicamente recoge todas las 「rows」, y tiene 2 efectos, los efectos se realizan según 『los valores de cada row y la operación de agregación entre estos valores』.

       -Las filas que tengan un valor de una columna con valores iguales a otras filas las va a 『omitir』, excepto una que representa a las demás, como un grupo, esto porque la 「operación de agregación」 las usa y las va a mostrar como una columna más en el resultado del query

       -La columna que aparece después del "group by" va a ser definida como la candidata para la 「operación de agregación」, esto es básicamente tomar en una función tipo MAX todos los valores de una columna como una lista, y los candidatos a tomar se hace según la columna elegida por el group by(donde si en la columna hay 2 valores iguales, entonces la operación de agregación va a tomar el valor que le corresponde en esa columna(ojo que es un valor diferente al de agrupacion de filas))

  
  

//=====  WHERE y HAVING

Estas 2 operaciones hacen la misma operación de filtrar registros, PERO el WHERE se usa ANTES de que se haga alguna operación o cuando se trabaja sobre una tabla simple

Mientras que el HAVING se usa para casos DESPUÉS de aplicar un AGRUPAMIENTO en el query, y filtrar según el resultado de la función de agrupación

Se pueden usar en conjunto para hacer operaciones de agregación limpias y luego limpiar los resultados si de quiere algo en específico

  

//===========================  ON <ACTION> <ACTION2>

       -Al usarse en tablas con FOREIGN KEYS

Resumen: La tabla que se está definiendo dice "Si ejecutan <ACTION> en la tabla en la que mi registro apunta, hagan <ACTION2>  en mi, sobre el registro que apuntaba al registro de la tabla padre"

Esto hace que la tabla hija, la cual es la que hace referencia a un registro de otra tabla, haga que la 『tabla padre adquiera propiedades especiales』, como el que cuando borremos la tabla padre, no sé efectúe la acción porque dejaría tablas hijas con registros huérfanos, o el efectuar la acción que se hace sobre la tabla padre en las tablas hijas

  
  
  

//=====  ON DELETE NO ACTION

       -Después de un FK CONSTRAINT

Establece que NO SE PUEDE BORRAR una tabla padre si hay una fila que tenga referencia a una tabla hijo, o sea, una tabla que está referenciando registros de otra tabla por un FK, está diciendo que NO pueden borrar esa tabla que estan referenciando porque quedarían con registros apuntando a nada(tablas hijas huérfanas)

  
  
  
  
  
  
  
  
  
  

k

  
**