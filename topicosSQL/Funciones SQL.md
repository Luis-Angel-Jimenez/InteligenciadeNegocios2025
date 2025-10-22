# Actividad de Evaluación: Funciones SQL

 **Nombre**: Luis Angel Jimenez

 **Matricula**: 22300038

 **Materia**: Inteligencia de Negocios (BI) 

 **Fecha**: 09 / Octubre / 2025

# Funciones SQL

## CONCAT

 1. Funciones de Cadenas

    - ¿Qué son?

        - Las funciones de cadenas en SQL se utilizan para manipular datos de tipo texto o cadenas de caracteres. Permiten realizar operaciones como concatenar, extraer, reemplazar, buscar y formatear textos. Estas funciones son fundamentales para transformar y dar formato a los datos almacenados en las bases de datos.

    ### Sintaxis de la función `CONCAT`
        
    - Ejemplo: 
        - Las funciones de cadenas permiten manipular textos de varias maneras. Un ejemplo es la función CONCAT que concatena dos o más cadenas.

        ```SQL
        SELECT CONCAT('Su nombre es ', Nombre, ' y su edad es de ', Edad, ' Años.') AS CLIENTE FROM clientes
        ```

    - Resultado


        | No. |                    Clientes                  |
        |-----|--------------------------------------------------|
        |  1  | Su nombre es Ana Torres y su edad es de 25 Años.  |
        |  2  | Su nombre es Luis Perez y su edad es de 34 Años.  |
        |  3  | Su nombre es Soyla Vaca y su edad es de 29 Años.  |
        |  4  | Su nombre es Natacha y su edad es de 41 Años.     |
        |  5  | Su nombre es Sofia Lopez y su edad es de 19 Años. |
        |  6  | Su nombre es Laura Hernandez y su edad es de 38 Años. |
        |  7  | Su nombre es Victor Trujillo y su edad es de 25 Años. |

## GETDATE()

2. Funciones de Fechas

    - ¿Qué son?

        - Las funciones de fechas en SQL permiten manipular y comparar datos de tipo fecha y hora. Estas funciones son útiles para realizar operaciones como la obtención de la fecha actual, el cálculo de diferencias entre fechas, y la conversión entre diferentes formatos de fecha.
        
    ### Sintaxis de la función `GETDATE()`
        
    - Ejemplo: 
        - Las funciones de fechas permiten formatear y comparar fechas. Un ejemplo es la función GETDATE() que obtiene la fecha y hora actuales del sistema.

        ```SQL
        SELECT GETDATE() AS [Fecha y Hora Actual]
        ```


    - Resultado

        |  Fecha y Hora Actual  |
        |-----------------------|
        |2025-10-10 00:18:35.117|

## ISNULL


3. Control de Valores Nulos

    - ¿Qué son?

        - En SQL, un valor nulo (NULL) representa la ausencia de un valor o un valor desconocido. Los valores nulos no son lo mismo que un valor vacío o cero. Existen funciones específicas como ISNULL() o COALESCE() para manejar y reemplazar valores nulos con otros valores.
        
    ### Sintaxis de la función `ISNULL()`
        
    - Ejemplo: 
        - Puedes usar la función ISNULL() para reemplazar un valor nulo con otro valor en las consultas. Esto es útil cuando necesitas asegurarte de que un campo tenga un valor válido y no nulo.

        ```SQL
        SELECT ISNULL(Ciudad, 'Desconocida')AS Ciudad FROM clientes
        ```


    - Resultado
    
    | No. |   Ciudad   |
    |----|------------|
    |  1  |Ciudad De Mexico|
    |  2  |Guadalajara|
    |  3  |Desconocida|
    |  4  |Desconocida|
    |  5  |Chapulhuacan|
    |  6  |Desconocida|
    |  7  |Zacualtipan|

## MERGE

4. Uso de MERGE

    - ¿Qué es?

        - El comando MERGE en SQL se utiliza para realizar operaciones de inserción, actualización o eliminación basadas en condiciones. Este comando compara los datos de dos tablas y realiza las acciones necesarias según si existe o no una coincidencia. Es útil cuando necesitas mantener la sincronización entre dos conjuntos de datos.
        
    ### Sintaxis de la función `MERGE`
        
    - Ejemplo: 
       - Un ejemplo de uso de MERGE es actualizar los registros de una tabla con los datos de otra, insertando nuevos registros si no existen.

        ```SQL        
        MERGE INTO clientes AS target
        USING clientes_actualizados AS source
        ON target.Idcliente = source.Idcliente
        WHEN MATCHED THEN
        UPDATE SET target.Nombre = source.Nombre, 
               target.Edad = source.Edad, 
               target.Ciudad = source.Ciudad
        WHEN NOT MATCHED BY TARGET THEN
        INSERT (Idcliente, Nombre, Edad, Ciudad)
        VALUES (source.Idcliente, source.Nombre, source.Edad, source.Ciudad);
        ```

    - Tablas Actuales

        **Tabla Clientes**

        |Idcliente|Nombre|Edad|Ciudad|
        |---------|------|----|------|
        |    1    |Ana Torres|25|Ciudad de Mexico|
        |    2    |Luis Perez|34|Guadalajara|
        |    3    |Soyla Vaca|29|NULL|
        |    4    |Natacha|41|NULL|
        |    5    |Sofia Lopez|19|Chapulhuacan|
        |    6    |Laura Hernandez|38|NULL|
        |    7    |Victor Trujillo|25|Zacualtipan|


    - La siguiente tabla se creo para hacer uso de Merge

        **Tabla Clientes_actualizados** 
        
        |Idcliente|Nombre|Edad|Ciudad|
        |---------|------|----|------|
        |1|Ana Torres|26|Querétaro|
        |2|Luis Perez|35|Monterrey|
        |3|Soyla Vaca|30|Ciudad de Mexico|

    - Resultado
        - Aqui se puede ver que se actualizaron los primeros 3 clientes

            |Idcliente|Nombre|Edad|Ciudad|
            |---------|------|----|------|
            |    1    |Ana Torres|26|Queretaro|
            |    2    |Luis Perez|35|Monterrey|
            |    3    |Soyla Vaca|30|Ciudad de Mexico|
            |    4    |Natacha|41|NULL|
            |    5    |Sofia Lopez|19|Chapulhuacan|
            |    6    |Laura Hernandez|38|NULL|
            |    7    |Victor Trujillo|25|Zacualtipan|

## CASE

5. Uso de CASE

    - ¿Qué es?

        - La expresión CASE en SQL se utiliza para realizar condiciones dentro de las consultas. Permite evaluar condiciones en los datos y devolver un valor específico dependiendo del resultado de la evaluación. Es similar a un IF en otros lenguajes de programación.
        
    ### Sintaxis de la función `CASE`
        
    - Ejemplo: 
        - Con CASE, puedes evaluar si un valor cumple con ciertas condiciones y devolver diferentes resultados según el caso.

        ```SQL
        SELECT Nombre, Edad, Ciudad,
        CASE 
        WHEN Edad < 20 THEN 'Joven'
        WHEN Edad BETWEEN 20 AND 35 THEN 'Adulto'
        WHEN Edad BETWEEN 36 AND 50 THEN 'Maduro'
        ELSE 'Senior'
        END AS Categoria
    	FROM clientes;
        ```

    - Resultado

    | No. |Nombre|Edad|Ciudad|Categoria|
    |-----|------|----|------|---------|
    |  1  |Ana Torres	|26|Querétaro|Adulto|
    |  2  |Luis Perez	|35|Monterrey|Adulto|
    |  3  |Soyla Vaca	|30|Ciudad de Mexico|Adulto|
    |  4  |Natacha|41|NULL|Maduro|
    |  5  |Sofia Lopez|19|Chapulhuacan|Joven|
    |  6  |Laura Hernandez|38|NULL|Maduro|
    |  7  |Victor Trujillo|25|Zacualtipan|Adulto|


