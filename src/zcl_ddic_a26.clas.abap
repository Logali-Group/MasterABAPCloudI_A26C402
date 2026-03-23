CLASS zcl_ddic_a26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ddic_a26 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(ls_structure) = VALUE zst_employee_a26( employee_id = 1
                                                 name        = 'Mateo'
                                                 last_name   = 'Garcia'
                                                 age         = 30
                                                 sex         = 'M'
                                                 address-adress_id     = 1
                                                 address-street_name = 'Street 1'
                                                 address-int_number      = 2
                                                 address-city            = 'New York'
                                                 address-country         =  'US'           ).


       DATA(ls_structure2) = VALUE zst_employee_a262( employee_id = 1
                                                      name        = 'Mateo'
                                                      last_name   = 'Garcia'
                                                      age         = 30
                                                      sex         = 'M'
                                                      adress_id     = 1
                                                      street_name = 'Street 1'
                                                      int_number      = 2
                                                      city            = 'New York'
                                                      country         =  'US'           ).


        out->write( ls_structure2 )    .




DATA(lt_empl_addr) = VALUE ztt_emp_address_a26(  ).


MODIFY zemployee_a26 FROM TABLE @(   VALUE #( (    emp_id        = 1
                                                   emp_first_name = 'Ana'
                                                   emp_last_name  = 'Gomez'  )

                                            (  emp_id        = 2
                                               emp_first_name = 'Laura'
                                               emp_last_name  = 'Gomez' ) ) ).
  ENDMETHOD.

ENDCLASS.
