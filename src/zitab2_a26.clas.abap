CLASS zitab2_a26 DEFINITION
 PUBLIC
 FINAL
 CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
    "Estructura para datos de empleado
    TYPES: BEGIN OF ty_employee,
             id            TYPE n LENGTH 8,
             first_name    TYPE c LENGTH 40,
             last_name     TYPE c LENGTH 40,
             email         TYPE c LENGTH 50,
             phone_number  TYPE c LENGTH 20,
             salary        TYPE p LENGTH 8 DECIMALS 2,
             currency_code TYPE c LENGTH 3,
           END OF ty_employee.

    "Tipo de tabla para usar con VALUE
    TYPES ty_t_employees TYPE STANDARD TABLE OF ty_employee
          WITH EMPTY KEY.
ENDCLASS.

CLASS zitab2_a26 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    out->write( '═══════════════════════════════════════════════' ).
*    out->write( '   SISTEMA DE GESTIÓN DE EMPLEADOS' ).
*    out->write( '═══════════════════════════════════════════════' ).
*    out->write( | | ).
*
**    "═══════════════════════════════════════════════════════════
**    " ESCENARIO 1: CARGA INICIAL DEL MES
**    " Usar VALUE cuando tenemos varios registros predefinidos
**    "═══════════════════════════════════════════════════════════
**    out->write( '--- ESCENARIO 1: Carga inicial del mes ---' ).
**    out->write( 'RR.HH. tiene 3 empleados nuevos que empiezan hoy' ).
**    out->write( | | ).
**
**    "VALUE permite crear la tabla con todos los datos de una vez
**    "Cada par de paréntesis internos representa UN empleado
**
*    DATA(lt_empleados_mes) = VALUE ty_t_employees(
*      ( id = '00000001'
*        first_name = 'Carlos'
*        last_name = 'García'
*        email = 'carlos.garcia@empresa.com'
*        phone_number = '+34 912345601'
*        salary = '2500.00'
*        currency_code = 'EUR' )
*      ( id = '00000002'
*        first_name = 'Ana'
*        last_name = 'Martínez'
*        email = 'ana.martinez@empresa.com'
*        phone_number = '+34 912345602'
*        salary = '2800.00'
*        currency_code = 'EUR' )
*      ( id = '00000003'
*        first_name = 'Luis'
*        last_name = 'Rodríguez'
*        email = 'luis.rodriguez@empresa.com'
*        phone_number = '+34 912345603'
*        salary = '2600.00'
*        currency_code = 'EUR' )
*    ).
*
*    out->write( 'Empleados cargados con VALUE:' ).
*    out->write( | | ).
*
*    "Mostramos los empleados cargados
*    LOOP AT lt_empleados_mes INTO DATA(ls_emp).
*      out->write( |{ ls_emp-id } - { ls_emp-first_name } { ls_emp-last_name }| ).
*    ENDLOOP.
**
**    out->write( | | ).
**    out->write( 'VALUE es ideal para carga inicial' ).
**    out->write( 'porque podemos definir todos los registros de una vez' ).
**    out->write( | |  ).
**    out->write( | |  ).
*
*
*    "═══════════════════════════════════════════════════════════
*    " ESCENARIO 2: LLEGA UN DIRECTOR QUE DEBE IR PRIMERO
*    " Usar INSERT cuando necesitamos posición específica
*    "═══════════════════════════════════════════════════════════
*    out->write( '--- ESCENARIO 2: Llega el nuevo director ---' ).
*    out->write( 'Debe aparecer en la primera posición de la lista' ).
*    out->write( | | ).
*
*    "Forma clásica: usando estructura intermedia !!!!!!
*    DATA ls_director TYPE ty_employee.
*
*    ls_director-id = '00000004'.
*    ls_director-first_name = 'María'.
*    ls_director-last_name = 'Fernández'.
*    ls_director-email = 'maria.fernandez@empresa.com'.
*    ls_director-phone_number = '+34 912345604'.
*    ls_director-salary = '4500.00'.
*    ls_director-currency_code = 'EUR'.
*
*    "INSERT permite especificar la posición INDEX 1 = primera posición
*    INSERT ls_director INTO lt_empleados_mes INDEX 1.
*    out->write( 'Director insertado en posición 1 con INSERT' ).
*    out->write( | |  ).
*    out->write( 'Lista actualizada:' ).
*    out->write( | |  ).
*
*    " INSERT VALUE operador
*    INSERT VALUE #(
*     id = '00000005'
*     first_name = 'Iván'
*     last_name = 'López'
*     email = 'iván.lopez@empresa.com'
*     phone_number = '+34 912345606'
*     salary = '2700.00'
*     currency_code = 'EUR'
*     ) INTO lt_empleados_mes INDEX 3.
*
*    LOOP AT lt_empleados_mes INTO ls_emp.
*      IF sy-tabix = 1.
*        out->write( |-> { ls_emp-id } - { ls_emp-first_name } { ls_emp-last_name } (DIRECTOR)| ).
*      ELSE.
*        out->write( |  { ls_emp-id } - { ls_emp-first_name } {  ls_emp-last_name }| ).
*      ENDIF.
*    ENDLOOP.
*
*    out->write( | |  ).
*    out->write( 'INSERT es ideal para posiciones específicas' ).
*    out->write( '  porque podemos usar INDEX para indicar dónde' ).
*    out->write( | |  ).
*    out->write( | |  ).
*
*
*    "═══════════════════════════════════════════════════════════
*    " ESCENARIO 3: VAN LLEGANDO SOLICITUDES DURANTE EL DÍA
*    " Usar APPEND para ir agregando al final
*    "═══════════════════════════════════════════════════════════
*    out->write( '--- ESCENARIO 3: Solicitudes durante el día ---' ).
*    out->write( 'Cada solicitud se agrega al final de la cola' ).
*    out->write( | |  ).
*
*    "APPEND siempre agrega al FINAL de la tabla
*
*    "Es más rápido que INSERT cuando no importa la posición
*    "Primera solicitud del día - usando estructura
*
*    DATA ls_nuevo_empleado TYPE ty_employee.
*
*    ls_nuevo_empleado-id = '00000005'.
*    ls_nuevo_empleado-first_name = 'Pedro'.
*    ls_nuevo_empleado-last_name = 'Sánchez'.
*    ls_nuevo_empleado-email = 'pedro.sanchez@empresa.com'.
*    ls_nuevo_empleado-phone_number = '+34 912345605'.
*    ls_nuevo_empleado-salary = '2400.00'.
*    ls_nuevo_empleado-currency_code = 'EUR'.
*
*    APPEND ls_nuevo_empleado TO lt_empleados_mes.
*
*    out->write( 'Solicitud 1: Pedro agregado al final con APPEND' ).
*
*    "Segunda solicitud - usando VALUE # directamente
*    APPEND VALUE #(
*      id = '00000006'
*      first_name = 'Laura'
*      last_name = 'López'
*      email = 'laura.lopez@empresa.com'
*      phone_number = '+34 912345606'
*      salary = '2700.00'
*      currency_code = 'EUR'
*    ) TO lt_empleados_mes.
*
*    out->write( 'Solicitud 2: Laura agregada al final con APPEND' ).
*    out->write( | |  ).
*    out->write( 'Lista final completa:' ).
*    out->write( | |  ).
*
*    LOOP AT lt_empleados_mes INTO ls_emp.
*      out->write( |{ sy-tabix }. { ls_emp-id } - {
*                    ls_emp-first_name } { ls_emp-last_name } | &&
*                  |({ ls_emp-salary } { ls_emp-currency_code })| ).
*    ENDLOOP.
*
*    out->write( | | ).
*    out->write( 'APPEND es ideal para agregar al final' ).
*    out->write( '  porque es la forma más rápida de añadir registros' ).
*    out->write( | | ).
*    out->write( | | ).

*    "═══════════════════════════════════════════════════════════
*    " COMPARACIÓN FINAL
*    "═══════════════════════════════════════════════════════════
*    out->write( '═══════════════════════════════════════════════' ).
*    out->write( '   RESUMEN: ¿CUÁNDO USAR CADA UNO?' ).
*    out->write( '═══════════════════════════════════════════════' ).
*    out->write( ' ' ).
*    out->write( 'VALUE:' ).**
*    out->write( '  -> Carga inicial con múltiples registros' ).
*    out->write( '  -> Cuando conoces todos los datos de antemano' ).
*    out->write( '  -> Código más compacto y legible' ).
*    out->write( ' ' ).
*    out->write( 'INSERT:' ).
*    out->write( '  -> Cuando necesitas posición específica (INDEX)' ).
*    out->write( '  -> Funciona con TODOS los tipos de tablas' ).
*    out->write( '  -> Más flexible pero más lento' ).
*    out->write( ' ' ).
*    out->write( 'APPEND:' ).
*    out->write( '  -> Siempre agrega AL FINAL' ).
*    out->write( '  -> Solo para tablas STANDARD' ).
*    out->write( '  -> La forma MÁS RÁPIDA de agregar' ).
*

*""""""""""""CORRESPONDING
*
*   "=================================================================
*   " DEMOSTRACIÓN 1: Copia Básica de Campos Coincidentes
*   "=================================================================
*   " Definimos un tipo local con solo los campos que necesitamos.
*   " La tabla origen /dmo/flight tiene muchos más campos, pero solo
*   " queremos trabajar con estos tres.
*
*   TYPES: BEGIN OF lty_flights,
*            carrier_id    TYPE /dmo/carrier_id,
*            connection_id TYPE /dmo/connection_id,
*            flight_date   TYPE /dmo/flight_date,
*          END OF lty_flights.
*
*   DATA: gt_my_flights TYPE STANDARD TABLE OF lty_flights,
*         gs_my_flight  TYPE lty_flights.
*
*   " Obtenemos todos los vuelos en EUR de la base de datos
*   SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE currency_code EQ 'EUR'
*     INTO TABLE @DATA(gt_flights).
*
**
**   out->write( |=======================================================| ).
**   out->write( |  CASO 1: Copia básica con campos coincidentes        | ).
**   out->write( |=======================================================| ).
**   out->write( | | ).
**   out->write( |Tabla origen tiene { lines( gt_flights ) } registros con TODOS los campos| ).
**
**
**   " FORMA ANTIGUA: Usando MOVE-CORRESPONDING
**
**
**   MOVE-CORRESPONDING gt_flights TO gt_my_flights.
**
**
**   out->write( |FORMA ANTIGUA: MOVE-CORRESPONDING gt_flights TO gt_my_flights.| ).
**   out->write( |Resultado: { lines( gt_my_flights ) } registros copiados| ).
**   out->write( gt_my_flights ).
**   out->write( | | ).
**
**
**   " Limpiamos para demostrar la forma moderna
**   CLEAR gt_my_flights.
**
**
**   " FORMA MODERNA: Usando el operador CORRESPONDING
**   gt_my_flights = CORRESPONDING #( gt_flights ).
**
**
**   out->write( |FORMA MODERNA: gt_my_flights = CORRESPONDING #( gt_flights ).| ).
**   out->write( |Resultado: { lines( gt_my_flights ) } registros copiados| ).
**   out->write( gt_my_flights ).
**   out->write( |==> Ambas formas producen el MISMO resultado| ).
**   out->write( |\n\n| ).
*
*
*  " DEMOSTRACIÓN 2: Agregar Registros Sin Borrar los Existentes
*   "=================================================================
*   " Ahora imaginen que gt_my_flights ya tiene datos y queremos
*   " AGREGAR más registros sin perder los que ya teníamos.
*   " Esto es muy común cuando acumulamos datos de diferentes fuentes.
*
*
*   out->write( |=======================================================| ).
*   out->write( |  CASO 2: Agregar datos conservando los existentes    | ).
*   out->write( |=======================================================| ).
*   out->write( | | ).
*
*
*   " Primero llenamos gt_my_flights con algunos vuelos en EUR
*   SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE currency_code EQ 'EUR'
*     INTO TABLE @gt_flights
*     UP TO 3 ROWS.
*
*
*   gt_my_flights = CORRESPONDING #( gt_flights ).
*
*
*   out->write( |Comenzamos con { lines( gt_my_flights ) } vuelos en EUR| ).
*   out->write( gt_my_flights ).
*   out->write( | | ).
*
*
*   " Ahora obtenemos vuelos en USD y queremos AGREGARLOS
*   SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE currency_code EQ 'USD'
*     INTO TABLE @gt_flights
*     UP TO 3 ROWS.
*
*
*   out->write( |Queremos agregar { lines( gt_flights ) } vuelos en USD| ).
*   out->write( | | ).
*
*
*   " FORMA ANTIGUA: MOVE-CORRESPONDING con KEEPING TARGET LINES
*   MOVE-CORRESPONDING gt_flights TO gt_my_flights KEEPING TARGET LINES.
*   out->write( |FORMA ANTIGUA: MOVE-CORRESPONDING gt_flights TO gt_my_flights KEEPING TARGET LINES.| ).
*
*
*   out->write( |Resultado: Ahora tenemos { lines( gt_my_flights ) } vuelos totales| ).
*   out->write( |Los primeros 3 EUR se conservaron + 3 USD se agregaron| ).
*   out->write( gt_my_flights ).
*   out->write( | | ).
*
*
*   " Reiniciamos para demostrar la forma moderna
*   CLEAR gt_my_flights.
*
*
*   SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE currency_code EQ 'EUR'
*     INTO TABLE @DATA(gt_flights_eur)
*     UP TO 3 ROWS.
*
*
*   gt_my_flights = CORRESPONDING #( gt_flights_eur ).
*
*
*   " FORMA MODERNA: CORRESPONDING con BASE
*   gt_my_flights = CORRESPONDING #( BASE ( gt_my_flights ) gt_flights ).
*   out->write( |FORMA MODERNA: gt_my_flights = CORRESPONDING #( BASE ( gt_my_flights ) gt_flights ).| ).
*
*
*   out->write( |Resultado: Ahora tenemos { lines( gt_my_flights ) } vuelos totales| ).
*   out->write( |Los primeros 3 EUR se conservaron + 3 USD se agregaron| ).
*   out->write( gt_my_flights ).
*   out->write( |==> Ambas formas producen el MISMO resultado| ).
*   out->write( |\n\n| ).
*
*
*   "=================================================================
*   " DEMOSTRACIÓN 3: Mapeo de Campos con Nombres Diferentes
*   "=================================================================
*   " ¿Qué pasa si los campos tienen información similar pero con
*   " nombres diferentes? Aquí necesitamos hacer un mapeo manual.
*
*
*   out->write( |=======================================================| ).
*   out->write( |  CASO 3: Mapeo de campos con nombres diferentes      | ).
*   out->write( |=======================================================| ).
*   out->write( | | ).
*
*
*   " Definimos un tipo donde los campos se llaman diferente
*
*   TYPES: BEGIN OF lty_flights_renamed,
*            carrier    TYPE /dmo/carrier_id,      "En origen: carrier_id
*            connection TYPE /dmo/connection_id,   "En origen: connection_id
*            date       TYPE /dmo/flight_date,     "En origen: flight_date
*          END OF lty_flights_renamed.
*
*   DATA gt_flights_renamed TYPE STANDARD TABLE OF lty_flights_renamed.
*
*
*   " Obtenemos datos origen
*   SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE currency_code EQ 'EUR'
*     INTO TABLE @gt_flights
*     UP TO 5 ROWS.
*
*
*   out->write( |Tabla origen tiene campos: carrier_id, connection_id, flight_date| ).
*   out->write( |Tabla destino tiene campos: carrier, connection, date| ).
*   out->write( |Los nombres NO coinciden, pero la información es la misma.| ).
*   out->write( | | ).
*
*   " Con CORRESPONDING necesitamos usar MAPPING para indicar
*   " qué campo origen corresponde a qué campo destino
*
*
*   gt_flights_renamed = CORRESPONDING #( gt_flights MAPPING carrier    = carrier_id
*                                                            connection = connection_id
*                                                            date       = flight_date ).
*
*
*   out->write( |Usamos MAPPING para relacionar los campos:| ).
*   out->write( |  carrier    = carrier_id| ).
*   out->write( |  connection = connection_id| ).
*   out->write( |  date       = flight_date| ).
*   out->write( | | ).
*   out->write( |Resultado con campos mapeados:| ).
*   out->write( gt_flights_renamed ).
*   out->write( | | ).
*
*
*   " IMPORTANTE: MOVE-CORRESPONDING NO tiene una forma de hacer MAPPING.
*   " Si los nombres no coinciden exactamente, MOVE-CORRESPONDING simplemente
*   " no copia esos campos. Esta es una ventaja clara del operador CORRESPONDING.


    "READ TABLE

    " Obtenemos datos de aeropuertos para trabajar
    SELECT FROM /dmo/airport
      FIELDS *
      WHERE country EQ 'DE'
      INTO TABLE @DATA(lt_airports).

    out->write( lt_airports ).

    IF sy-subrc EQ 0.
      "============================================================
      " CASO 1: Lectura por ÍNDICE (posición)
      "============================================================
      out->write( |CASO 1: Acceso por ÍNDICE (muy rápido siempre)| ).
      out->write( |-------------------------------------------| ).


      " Forma tradicional: READ TABLE con INDEX
      READ TABLE lt_airports INTO DATA(ls_airport1) INDEX 1.
      out->write( |Forma antigua: READ TABLE ... INDEX 1| ).
      out->write( ls_airport1 ).


      " Forma moderna: Expresión de tabla con corchetes
      DATA(ls_airport2) = lt_airports[ 2 ].
      out->write( |Forma moderna: lt_airports[ 2 ]| ).
      out->write( ls_airport2 ).


      " Si el índice puede no existir, usar OPTIONAL
      DATA(ls_safe) = VALUE #( lt_airports[ 999 ] OPTIONAL ).
      out->write( |Con OPTIONAL no falla si no existe el índice| ).
      out->write( |\n| ).


    "============================================================
     " CASO 2: Lectura por CLAVE (campo específico)
     "============================================================
     out->write( |CASO 2: Acceso por CAMPO (lento si hay muchos registros)| ).
     out->write( |-------------------------------------------| ).


     " Forma tradicional: WITH KEY
     READ TABLE lt_airports INTO DATA(ls_berlin)
       WITH KEY city = 'Berlin'.


     out->write( |Forma antigua: WITH KEY city = 'Berlin'| ).
     out->write( ls_berlin ).


     " Forma moderna: campo = valor entre corchetes
     DATA(ls_munich) = lt_airports[ city = 'Munich' ].
     out->write( |Forma moderna: lt_airports[ city = 'Munich' ]| ).
     out->write( ls_munich ).


     " Acceso directo a un componente específico
     DATA(lv_name) = lt_airports[ city = 'Hamburg' ]-name.
     out->write( |Acceso a componente: ...[ city = 'Hamburg' ]-name| ).
     out->write( |Resultado: { lv_name }| ).
     out->write( |\n| ).

    ENDIF.


  ENDMETHOD.
ENDCLASS.

