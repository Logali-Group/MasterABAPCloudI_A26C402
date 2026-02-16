CLASS zcl_structure_a26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_structure_a26 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Definición de la estructura anidada

    DATA: BEGIN OF ls_empl_info,
            BEGIN OF info,
              id         TYPE i VALUE 123456,
              first_name TYPE string VALUE `Laura`,
              last_name  TYPE string VALUE `Martínez`,
            END OF info,

            BEGIN OF address,
              city    TYPE string VALUE `Frankfurt`,
              street  TYPE string VALUE `123 Main street`,
              country TYPE string VALUE `Germany`,
            END OF address,

            BEGIN OF position,
              department TYPE string VALUE `IT`,
              salary     TYPE p DECIMALS 2 VALUE `2000.25`,
            END OF position,

          END OF ls_empl_info.

* "out->write( ls_empl_info ).
*
*    " ============================================
*    " SOLUCIÓN: Escribir cada subestructura
*    " ============================================
*    out->write( |========================================| ).
*    out->write( |EMPLOYEE INFORMATION| ).
*    out->write( |========================================| ).
*    out->write( |  | ).
*    out->write( |PERSONAL INFO:| ).
*    out->write( ls_empl_info-info ).
*    out->write( |  | ).
*    out->write( |ADDRESS:| ).
*    out->write( ls_empl_info-address ).
*    out->write( |  | ).
*    out->write( |POSITION:| ).
*    out->write( ls_empl_info-position ).
*    out->write( |========================================| ).

*"Acceso
*  "nested structure
*   ls_empl_info = VALUE #(
*                           info     = VALUE #( id = 1234598 first_name = 'María' last_name = 'Nova'  )
*                           address  = VALUE #( city = 'Madrid' street = 'Gran Vía' country = 'Spain' )
*                           position = VALUE #( department = 'Finance' salary = '2500.23' )  ).
*
*   out->write( |========================================| ).
*   out->write( |EMPLOYEE INFORMATION| ).
*   out->write( |========================================| ).
*   out->write( |  | ).
*   out->write( |PERSONAL INFO:| ).
*   out->write( ls_empl_info-info ).
*   out->write( |  | ).
*   out->write( |ADDRESS:| ).
*   out->write( ls_empl_info-address ).
*   out->write( |  | ).
*   out->write( |POSITION:| ).
*   out->write( ls_empl_info-position ).

  "DEEP Structure
   "Creando el tipo estructurado para  la tabla interna anidada

   TYPES: BEGIN OF lty_flights,
            flight_date   TYPE /dmo/flight-flight_date,
            price         TYPE /dmo/flight-price,
            currency_code TYPE /dmo/flight-currency_code,
          END OF lty_flights.

   "Creando la estructura profunda (DEEP)
   DATA: BEGIN OF ls_flight,
           carrier    TYPE /dmo/flight-carrier_id VALUE 'AA',
           connid     TYPE /dmo/flight-connection_id VALUE '0018',
           lt_flights TYPE TABLE OF lty_flights WITH EMPTY KEY,
         END OF ls_flight.

   SELECT flight_date,
          price,
          currency_code
     FROM /dmo/flight
     WHERE carrier_id = 'AA'
     INTO CORRESPONDING FIELDS OF TABLE @ls_flight-lt_flights
     UP TO 4 ROWS.

   out->write( |Flight Details for { ls_flight-carrier } - { ls_flight-connid }| ).
   out->write( |Total flights found: { lines( ls_flight-lt_flights ) }| ).

   IF ls_flight-lt_flights IS NOT INITIAL.
     out->write( ls_flight-lt_flights ).
   ELSE.
     out->write( |No flights found| ).
   ENDIF.

   "CLEAR
   SELECT SINGLE FROM /dmo/flight
    FIELDS *
    WHERE carrier_id = 'LH'
    INTO @DATA(ls_flight2).

   CLEAR ls_flight2-currency_code."solo un campo
   out->write( data = ls_flight2 name = 'ls_flight2' ).

   CLEAR ls_flight2."borro toda la estructura
   out->write( data = ls_flight2 name = 'ls_flight2' ).


  ENDMETHOD.


ENDCLASS.
