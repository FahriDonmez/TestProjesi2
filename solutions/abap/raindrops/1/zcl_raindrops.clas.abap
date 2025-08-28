CLASS zcl_raindrops DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS raindrops
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_raindrops IMPLEMENTATION.

  METHOD raindrops.
* add solution here
    result = COND #( WHEN input MOD 3 = 0 THEN 'Pling' ELSE '' ).
    result = |{ result }{ COND #( WHEN input MOD 5 = 0 THEN 'Plang' ELSE '' ) }|.
    result = |{ result }{ COND #( WHEN input MOD 7 = 0 THEN 'Plong' ELSE '' ) }|.
    result = COND #( WHEN result = '' THEN input ELSE result ).
  ENDMETHOD.

ENDCLASS.
