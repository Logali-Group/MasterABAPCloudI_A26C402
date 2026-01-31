CLASS zcl_data_conv_a25 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_data_conv_a25 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    DATA: lv_string  TYPE string VALUE `12345`, " ''
*          lv_int     TYPE i.
*    DATA: lv_date    TYPE d,
*          lv_decimal TYPE p LENGTH 3 DECIMALS 2.
*
*    lv_int = lv_string.
*
*    out->write( 'OK' ).
*    out->write( lv_int ).
*
*    lv_string = `ABDCFD20230101`.
*    lv_date = lv_string.
*
*    out->write( |String value: { lv_string }| ).
*    out->write( |Date Value: { lv_date DATE = USER }| ).


*get_user_name()     sy-uname Nombre de usuario
*get_user_language() sy-langu Idioma del usuario
*get_system_date()   sy-datum Fecha del servidor
*get_system_time()   sy-uzeit Hora del servidor

*    "truncamiento
*
*    "1. Truncamiento de Caracteres (Pérdida de datos)
*
*    DATA: lv_string TYPE string VALUE `LOGALI`,
*          lv_char   TYPE c LENGTH 2.
*
*    " Se intenta guardar "LOGALI" (6 caracteres) en una variable de solo 2
*
*    lv_char = lv_string.
*    out->write( lv_char ).
*
*    "Redondeo
*    DATA: lv_decimal TYPE p LENGTH 3 DECIMALS 5.
*
*    " Caso A: 1 / 6 = 0.166666...
*    lv_decimal = 1 / 6.
*    out->write( lv_decimal ).
*
*    " Caso B: 1 / 12 = 0.083333...
*    lv_decimal = 1 / 12.
*    out->write( |1 / 12 is rounded to { lv_decimal }| ).
*
*    "conversiones forzadas
*    DATA(lv_date) = '20250101'. "mostrar asi en el depurador e imprimir
*    out->write( lv_date ).
*
*    DATA(lv_date2) = CONV d( '20250101' ).
*    out->write( lv_date2 ).

*"Text symbols
*   out->write( text-001 ).
*   out->write( text-002 )."XXXXXXXXX


"Date and Time
   DATA: lv_date  TYPE d,
         lv_date2 TYPE d,
         lv_time  TYPE t,
         lv_time2 TYPE c LENGTH 6.

   lv_date  = cl_abap_context_info=>get_system_date(  ).
   lv_time  = cl_abap_context_info=>get_system_time(  ). "hora del sistema

  "Cálculos de fecha y hora
   lv_date  = '20260101'.
   lv_date2 = '20260622'.

   DATA(lv_days) = lv_date2 - lv_date.

   out->write( lv_days ).
   out->write( lv_date ).
   out->write( lv_time ).


   "Offset
   DATA(lv_month) = lv_date2+4(2). "mes
   out->write( |'mes', { lv_month } | ).

   DATA(lv_year) = lv_date2(4).
   out->write( |'año', { lv_year  } | ). "año

   DATA(lv_day) = lv_date2+6(2).
   out->write( | 'día', { lv_day } | ).  "día



  ENDMETHOD.

ENDCLASS.
