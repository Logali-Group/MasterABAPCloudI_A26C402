CLASS zitab_a26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zitab_a26 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    " Ejemplo básico: STANDARD TABLE
*    " Caso de uso: Generar un listado simple de todas las reservas
*
*    out->write( '=== STANDARD TABLE ===' ).
*    out->write( ' ' ).
*
*    "Declaramos una tabla STANDARD con clave vacía
*    "Es el tipo más básico y común
*
*    DATA lt_reservas TYPE STANDARD TABLE OF /dmo/booking.
*    "DATA(lt_reservas2) =
*
*    "Traemos datos de la base de datos
*    "INTO TABLE carga todos los registros en la tabla interna
*    SELECT * FROM /dmo/booking
*      INTO TABLE @lt_reservas.
*
*    out->write( 'Datos cargados en memoria' ).
*    out->write( ' ' ).
*
*    "Ahora recorremos TODOS los registros
*    "Este es el uso típico de STANDARD TABLE
*
*    LOOP AT lt_reservas INTO DATA(ls_reserva).
*      "Mostramos solo los primeros 5 para no saturar la pantalla
*      IF sy-tabix <= 5.
*        out->write( ls_reserva-booking_id ).
*        out->write( ls_reserva-customer_id ).
*        out->write( ls_reserva-flight_price ).
*        out->write( ' ' ).
*      ENDIF.
*
*    ENDLOOP.
*
*    out->write( 'Proceso completado' ).
*    out->write( ' ' ).
*    out->write( 'STANDARD TABLE es ideal cuando:' ).
*    out->write( '- Procesamos todos los registros de inicio a fin' ).
*    out->write( '- No necesitamos buscar registros específicos' ).
*    out->write( '- Queremos el código más simple posible' ).


    " Example básico: SORTED TABLE
    " Caso de uso: Mostrar clientes en orden alfabético

*    out->write( '=== SORTED TABLE - Lista Ordenada ===' ).
*    out->write( ' ' ).
*
*    "Declaramos una tabla SORTED ordenada por apellido
*    "NON-UNIQUE permite que varios clientes tengan el mismo apellido
*    DATA lt_clientes TYPE SORTED TABLE OF /dmo/customer WITH NON-UNIQUE KEY last_name .
*
*    "Traemos clientes de la base de datos
*    "La tabla se ordena AUTOMÁTICAMENTE por apellido
*    SELECT * FROM /dmo/customer
*      INTO TABLE @lt_clientes.
*
*    out->write( 'Clientes cargados y ordenados automáticamente' ).
*    out->write( ' ' ).
*    out->write( 'Lista en orden alfabético por apellido:' ).
*    out->write( ' ' ).
*
*    "Recorremos la tabla - ya está ordenada
*    LOOP AT lt_clientes INTO DATA(ls_cliente).
*
*      "Mostramos solo los primeros 8
*      IF sy-tabix <= 50.
*        out->write( | { ls_cliente-last_name },{ ls_cliente-first_name } |  ).
*        out->write( ' ' ).
*      ENDIF.
*
*    ENDLOOP.
*
*    out->write( ' ' ).
*    out->write( 'SORTED TABLE es ideal cuando:' ).
*    out->write( '- Necesitamos datos ordenados automáticamente' ).
*    out->write( '- Haremos búsquedas frecuentes más adelante' ).
*    out->write( '- Queremos mostrar información ordenada al usuario' ).



" Ejemplo básico: HASHED TABLE
" Caso de uso: Cargar datos maestros de clientes

    out->write( '=== HASHED TABLE - Datos Maestros ===' ).
    out->write( ' ' ).

    "Declaramos una tabla HASHED con clave única
    "UNIQUE KEY significa que no puede haber dos clientes con el mismo ID
    DATA lt_clientes TYPE HASHED TABLE OF /dmo/customer WITH UNIQUE KEY customer_id.

    "Cargamos todos los clientes
    "Internamente se crea una estructura hash para búsquedas rápidas
    SELECT * FROM /dmo/customer
      INTO TABLE @lt_clientes
      UP TO 20 ROWS.

    out->write( 'Clientes cargados en estructura hash' ).
    out->write( ' ' ).

    "IMPORTANTE: HASHED TABLE no tiene orden específico
    "Los registros están organizados según el hash, no alfabéticamente
    out->write( 'Algunos clientes en la tabla:' ).
    out->write( ' ' ).

    LOOP AT lt_clientes INTO DATA(ls_cliente).

      out->write(  | { ls_cliente-customer_id  } - { ls_cliente-last_name }, { ls_cliente-first_name } | ).

    ENDLOOP.

    out->write( 'HASHED TABLE es ideal cuando:' ).
    out->write( '- Tenemos datos con clave única (como IDs)' ).
    out->write( '- Haremos MUCHAS búsquedas más adelante' ).
    out->write( '- La velocidad de búsqueda es crítica' ).
    out->write( '- No nos importa el orden de los registros' ).






  ENDMETHOD.

ENDCLASS.

