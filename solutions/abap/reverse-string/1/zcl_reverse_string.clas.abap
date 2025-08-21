CLASS zcl_reverse_string DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_reverse_string IMPLEMENTATION.

  METHOD reverse_string.
    " Please complete the implementation of the reverse_string method
     DATA lv_pos TYPE i.
    DATA(lv_len) = strlen( input ).
    lv_pos = lv_len - 1.
    DO lv_len TIMES.
      result = |{ result }{ input+lv_pos(1) }|.
      lv_pos = lv_pos - 1.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
