CLASS zcl_03_ope_car_a26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_03_ope_car_a26 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    "f descripción
* "Funciones de Longitud
*  "strlen() and numofchar
*
*   " ---------------------------------------------------------
*   " CASO 1: Usando STRING (Dinámico) -> Se usan backticks ` `
*   " ---------------------------------------------------------
*   " Al usar `...`, creamos un STRING real, no un CHAR.
*   " Texto: "Logali Group" (12 caracteres) + 4 espacios = 16 total
*
*   DATA(lv_string) = `Logali Group    `.
*
*   " STRLEN en STRING: Cuenta TODO, incluidos los espacios finales.
*
*   DATA(lv_len_str) = strlen( lv_string ).
*
*   " NUMOFCHAR en STRING: Sigue ignorando los espacios finales (cuenta caracteres 'visibles').
*   DATA(lv_num_str) = numofchar( lv_string ).
*
*   out->write( '--- RESULTADOS CON STRING (`...`) ---' ).
*   out->write( |Texto: "{ lv_string }"| ).
*   out->write( |STRLEN:      { lv_len_str }| ).  " Resultado: 16
*   out->write( |NUMOFCHAR:   { lv_num_str }| ).  " Resultado: 12
*
*
*   " ---------------------------------------------------------
*   " CASO 2: Usando CHAR (Fijo) -> Se usan comillas ' '
*   " ---------------------------------------------------------
*   DATA(lv_char)   = 'Logali Group    '.
*
*   " En campos tipo CHAR, AMBAS funciones ignoran los espacios de relleno.
*
*   DATA(lv_len_char) = strlen( lv_char ).
*   DATA(lv_num_char) = numofchar( lv_char ).
*
*   out->write( ' ' ).
*   out->write( '--- RESULTADOS CON CHAR (''...'') ---' ).
*   out->write( |Texto: "{ lv_char }"| ).
*   out->write( |STRLEN:      { lv_len_char }| ). " Resultado: 12
*   out->write( |NUMOFCHAR:   { lv_num_char }| ). " Resultado: 12.


    "Funciones de búsqueda
*    DATA lv_string TYPE string VALUE 'LOGALI local'.
*    DATA(lv_num)   = strlen( lv_string ).
    "count

*    lv_num = count( val = lv_string sub = 'LO'  ). "encuentra el número de coincidencias con el patron exacto
*    out->write( lv_num ).
*
*    lv_num = count_any_of( val = lv_string sub = 'LO' ). "encuentra las coincidencias no importa el orden
*    out->write( lv_num ). "encuentra el caracter L dos veces y O una vez
*
*    lv_num = count_any_not_of( val = lv_string sub = 'LO'  ).
*    out->write( lv_num ). "devuelve todas las posiciones que no coinciden con el patrón


    "FIND
*    lv_num = find( val = lv_string sub = 'LI' ).
*    out->write( lv_num ).
*
*    lv_num = find_any_of( val = lv_string sub = 'LI' ).
*    out->write( lv_num ).
*
*    lv_num = find_any_not_of( val = lv_string sub = 'LI' ).
*    out->write( lv_num ).


*    "Funciones de procesamiento
*    DATA lv_string TYPE string VALUE ' Logali Group! Welcome to ABAP Cloud Master  '.
*    "Change Case of characters
*    out->write( |TO_UPPER         = {   to_upper(  lv_string ) } | ).
*    out->write( |TO_LOWER         = {   to_lower(  lv_string ) } | ).
*    out->write( |TO_MIXED         = {   to_mixed(  lv_string ) } | ).
*    out->write( |FROM_MIXED       = { from_mixed(  lv_string ) } | ).


*    "ejemplo más claro de tomixed y frommixed
*
*    DATA(lv_camel_case) = 'SalesOrderItems'.
*
*    " Resultado: SALES_ORDER_ITEMS
*    out->write( |De Camel a Snake: { from_mixed( lv_camel_case ) }| ).
*
*    DATA(lv_snake_case) = 'GET_MATERIAL_DATA'.
*
*    " Resultado: getMaterialData
*    " El parámetro 'sep = _' le dice a la función qué carácter debe eliminar para unir las palabras.
*    out->write( |De Snake a Camel: { to_mixed( val = lv_snake_case sep = '_' ) }| ).
*
*
*   "DATA(lv_num) = find( val = to_lower( lv_string ) sub = 'li' case = abap_false ).


*   "Change order of characters
*   out->write( |REVERSE             = {  reverse( lv_string ) } | ).
*   out->write( |SHIFT_LEFT  (places)= {  shift_left(  val = lv_string places   = 5  ) } | ).
*   out->write( |SHIFT_RIGHT (places)= {  shift_right( val = lv_string places   = 5  ) } | ).
*   out->write( |SHIFT_LEFT  (circ)  = {  shift_left(  val = lv_string circular = 5  ) } | ).
*   out->write( |SHIFT_RIGHT (circ)  = {  shift_right( val = lv_string circular = 5  ) } | ).
*


*    DATA lv_string TYPE string VALUE ' Logali Group! Welcome to ABAP Cloud Master  '.
**    " Extract a Substring
**    out->write( |SUBSTRING        = {  substring(        val = lv_string off = 9 len = 6 ) } | ).
**    out->write( |SUBSTRING_FROM   = {  substring_from(   val = lv_string sub = 'ABAP'     ) } | ).
**    out->write( |SUBSTRING_AFTER  = {  substring_after(  val = lv_string sub = 'ABAP'     ) } | ).
**    out->write( |SUBSTRING_TO     = {  substring_to(     val = lv_string sub = 'ABAP'     ) } | ).
**    out->write( |SUBSTRING_BEFORE = {  substring_before( val = lv_string sub = 'ABAP'     ) } | ).
*
*
*  " Condense, REPEAT and Segment
*   out->write( |CONDENSE         = {   condense( val = lv_string ) } | ).
*   out->write( |REPEAT           = {   repeat(   val = lv_string occ = 2 ) } | ).
*   out->write( |SEGMENT1         = {   segment(  val = lv_string sep = '!' index = 1 ) } |  ).
*   out->write( |SEGMENT2         = {   segment(  val = lv_string sep = '!' index = 2 ) } |  ).

* "Contains
*   DATA: lv_text    TYPE string,
*         lv_pattern TYPE string.
*
*   lv_text = 'The employee`s number is: 123-456-7890'.
*   lv_pattern = `\d{3}-\d{3}-\d{4}`. " Patrón para un número de teléfono
*
*   IF contains( val = lv_text pcre = lv_pattern ).
*     out->write( 'The text contains a phone number' ).
*   ELSE.
*     out->write( 'The text doesn`t contains a phone number' ).
*   ENDIF.
*
*  "match
*   DATA(lv_number) = match( val = lv_text pcre = lv_pattern occ = 1 ).
*   out->write( lv_number ).



*    "Contains
*    DATA: lv_string  TYPE string,
*          lv_pattern TYPE string.
*
*    lv_string = 'Please contact us at support@logali.com for more information'.
*    lv_pattern = `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b`. " regex for a email
*
*    IF contains( val = lv_string pcre = lv_pattern ). "verdadero
*      out->write( 'The text contains an email address' ).
*
*      DATA(lv_count) = count( val = lv_string pcre = lv_pattern )." cuantas veces hay coincidencias
*      out->write( lv_count ).
*
*      DATA(lv_pos) = find( val = lv_string pcre = lv_pattern occ = 1 ). " dónde está en lv_String
*      out->write( lv_pos ).
*
*    ELSE.
*      out->write( 'The text does not contain an email address' ).
*    ENDIF.


    "Concatenación

    "&&
    "||
    "CONCATENATE
    "concat_lines_of

*   "Concatenación
*   DATA: lv_string_a TYPE string VALUE 'Welcome to Logali Group',
*         lv_string_b TYPE string.
*
*   "si no le especifico el espacio, quedan juntos
*   lv_string_b = 'ABAP' && ` ` && 'Student'.
*
*   DATA(lv_fin_string) = | Concatenation 1: { lv_string_a } / { lv_string_b } |.
*   out->write( lv_fin_string ).
*
*   CONCATENATE lv_string_a lv_string_b INTO DATA(lv_fin_string2) SEPARATED BY ' '. "or space
*   out->write( | Concatenation 2: { lv_fin_string2 } | ).

*   "Insert
*   DATA(lv_ins_string) = insert( val = '123CLIENT02' sub = 'INV' off = 3  ).
*   out->write(  lv_ins_string  ).
*
*   lv_ins_string = insert( val = '123CLIENT02' sub = `INV` ).
*   out->write(  lv_ins_string  ).


*   "SPLIT
*   DATA(lv_string1) = 'Logali-Group-SAP-Academy'.
*   out->write( lv_string1 ).
*
*   SPLIT lv_string1 AT '-' INTO DATA(gv_word1)
*                                DATA(gv_word2)
*                                DATA(gv_word3)
*                                DATA(gv_word4).
*"SPLIT ... INTO TABLE
*
*   out->write( gv_word1 ).
*   out->write( gv_word2 ).
*   out->write( gv_word3 ).
*   out->write( gv_word4 ).

*    "Overlay
*    DATA(lv_company) = '--------------->Logali Group'.
*    DATA(lv_name) = 'ABAP_Class                        '.
*
*    OVERLAY lv_name WITH lv_company.
*    out->write( lv_name ).
*
*    DATA(lv_string) = 'a.b.c.a.b.c.A'.
*    DATA(lv_string2) = 'z.x.y.Z.x.y.z'.
*
*    OVERLAY lv_string WITH lv_string2 ONLY 'ab'.
*    out->write( lv_string ).

    " Reemplazar REPLACE

    " Reemplazar REPLACE
    DATA(lv_replace) = 'Logali-Group-Academia-SAP'.
    DATA(lv_sign) = '-'.
*    out->write( lv_replace ). "Valor Inicial
*    REPLACE '-' WITH '/' INTO lv_replace.
*    out->write( lv_replace ). "valor reemplazado el primero que encuentra
    out->write( lv_replace ). "Valor Inicial

*    REPLACE ALL OCCURRENCES OF '-' IN lv_replace WITH '/'.
*    out->write( lv_replace ). "valor reemplazado todos

    "lv_replace = replace( val = lv_replace sub = lv_sign with = '/' occ = 0 ).
    lv_replace = replace( val = lv_replace  with = `#` off = 5 len = 3  ).
    out->write( lv_replace ).




  ENDMETHOD.

ENDCLASS.
