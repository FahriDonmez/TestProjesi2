CLASS zcl_hamming DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string
        second_strand TYPE string
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
ENDCLASS.

CLASS zcl_hamming IMPLEMENTATION.

  METHOD hamming_distance.
    " add solution here
        DATA(lv_len1) = strlen( first_strand ).
    DATA(lv_len2) = strlen( second_strand ).

    IF lv_len1 <> lv_len2.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ELSE.
      DO lv_len1 TIMES.
        DATA(lv_pos) = sy-index - 1.
        IF first_strand+lv_pos(1) <> second_strand+lv_pos(1).
          result = result + 1.
        ENDIF.
      ENDDO.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
