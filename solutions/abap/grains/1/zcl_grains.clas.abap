CLASS zcl_grains DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES type_result TYPE p LENGTH 16 DECIMALS 0.
    METHODS square
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
    METHODS total
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_grains IMPLEMENTATION.
  METHOD square.
    " add solution here
        IF NOT ( input > 0 AND input < 65 ).
      RAISE EXCEPTION TYPE cx_parameter_invalid
        EXPORTING
          previous = NEW cx_parameter_invalid( ).
    ELSE.
      result =  2 ** ( input - 1 ) .   "power
    ENDIF.
    
  ENDMETHOD.

  METHOD total.
    " add solution here
        DO 64 TIMES.
      result = result + square( input = sy-index ).
    ENDDO.
  ENDMETHOD.


ENDCLASS.
