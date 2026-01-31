CLASS zcl_02_oper_a26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_02_oper_a26 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

"CTRL + ><
"CTRL + SHIFT + ><

*      "Suma
   DATA: lv_num_a TYPE i VALUE 20,
         lv_num_b TYPE i VALUE 5,
         lv_total TYPE p LENGTH 6 DECIMALS 2.
*   "+
*   lv_total = lv_num_a + lv_num_b.
*   out->write( | Number a { lv_num_a }  Number b { lv_num_b } Total: { lv_total }  |    ).
*
*   "ADD
*   ADD 5 TO lv_total.
*   out->write( | Total: { lv_total } | ).
*
*   "+=
*   lv_total += 5. "acumulador
*   out->write( | Total: { lv_total } | ).
*
*   lv_total = lv_num_a + lv_num_b + lv_total.
*   out->write( | Total: { lv_total } | ).
*
*   CLEAR lv_total. "limpiamos la variable
*   out->write( | Total: { lv_total } | ).


*   "Resta
*   lv_total = lv_num_a - lv_num_b.
*   out->write( | Number a: { lv_num_a }  Number b: { lv_num_b } Total: { lv_total }  |    ).
*
*   "SUBTRACT
*   SUBTRACT 2 FROM lv_total.
*   out->write( | Total: { lv_total } | ).
*
*   lv_total = lv_num_a - 1.
*   out->write( | Total: { lv_total } | ).


*  "Multi
*   lv_total = lv_num_a  * lv_num_b.
*   out->write( | Number a: { lv_num_a }  Number b: { lv_num_b } Total: { lv_total }  |    ).
*
*   MULTIPLY lv_total BY 5.
*   MULTIPLY lv_total BY lv_num_a.
*
*   out->write( | Number a: { lv_num_a }  Number b: { lv_num_b } Total: { lv_total }  |    ).
*
*   lv_total = lv_total * 2.
*   out->write( | Number a: { lv_num_a }  Number b: { lv_num_b } Total: { lv_total }  |    ).


*  "DIVIDE
*   lv_total = lv_num_a / lv_num_b.
*   out->write( | Number a: { lv_num_a }  Number b: { lv_num_b } Total: { lv_total }  |    ).
*
*   DIVIDE lv_total BY 2.
*   out->write( | Total: { lv_total } | ).
*
*   CLEAR lv_total.
*
*   DATA(lv_total2) = ( lv_num_a + lv_num_b ) / 3.
*   out->write( | Total: { lv_total2 } | ).
*
*    "DIV
*   lv_num_a = 9.
*   lv_num_b = 4.
*   lv_total = lv_num_a / lv_num_b.
*   out->write( | Total: { lv_total } | ).
*
*   lv_total = lv_num_a DIV lv_num_b. "regresa el resultado entero de la division, sin el residuo
*   out->write( | Total: { lv_total } | ).
*
******MOD
*   lv_total = lv_num_a / lv_num_b.
*   out->write( | Total: { lv_total } | ).
*
*   lv_total = lv_num_a MOD lv_num_b. "devuelve el resto de la división, 9 en 4 cabe 2 veces y resta 1, por eso regresa 1
*   out->write( | Total: { lv_total } | ).

*****EXP
*   lv_num_a = 3.
*   out->write( | Number a: { lv_num_a } | ).
*
*   lv_num_a = lv_num_a ** 2.
*   out->write( | Number a: { lv_num_a } | ).
*
*   CLEAR lv_num_a.
*
*   lv_num_a = 3.
*   DATA(lv_exp) = 3.
*   lv_num_a = lv_num_a ** lv_exp.
*   out->write( | Number a: { lv_num_a } | ).
*
*   " ipow
*   DATA(lv_result) = ipow( base = 2 exp = 3 ).
*   out->write( lv_result ).










 ENDMETHOD.

ENDCLASS.
