CLASS zcl_exec_log_a26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_exec_log_a26 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( 'This is my first class in ABAP' ).
    "F9 Ejecutar
    "SHIFT + F1 formatear
    "CTRL+F3 activar

    "ABAP built-in
    "TYPES
    "Dictionary ABAP

    DATA lv_int TYPE i VALUE 2026.

    DATA lv_string TYPE string.

    lv_string = 'ABAP'.

    DATA lv_date TYPE d.

    lv_date = '20260101'.

    DATA lv_dec TYPE p LENGTH 8 DECIMALS 2 VALUE '23095.45'.


    out->write( | String Var : { lv_string } | ).
    out->write( lv_date ).
    out->write( lv_dec ).

    TYPES: : BEGIN OF lty_employee,
               id   TYPE i,
               name TYPE string,
               age  TYPE i,
             END OF lty_employee.

    lv_date = cl_abap_context_info=>get_system_date( ).

DATA ls_employee TYPE lty_employee.

    out->write( lv_date ).

"var
DATA lv_var TYPE c LENGTH 20.

"constantes
CONSTANTS: lc_const TYPE c LENGTH 6 VALUE 'Logali'.

"declaraciones en línea
DATA(lv_result) = 4 + 7.










  ENDMETHOD.

ENDCLASS.
