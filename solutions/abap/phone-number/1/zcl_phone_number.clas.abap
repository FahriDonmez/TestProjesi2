CLASS zcl_phone_number DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS clean
      IMPORTING
        !number       TYPE string
      RETURNING
        VALUE(result) TYPE string
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_phone_number IMPLEMENTATION.

  METHOD clean.
" add your code here
 DATA: lv_clean_number TYPE string,
          lv_pos          TYPE i,
          lv_char         TYPE c LENGTH 1,
          lv_error        TYPE c LENGTH 1.

    DATA(lv_len) = strlen( number ).

    DO lv_len TIMES.
      lv_char = number+lv_pos(1).
      IF lv_char CA '1234567890'.
        lv_clean_number = |{ lv_clean_number }{ lv_char }|.
      ENDIF.
      lv_pos = lv_pos + 1.
    ENDDO.

    lv_len = strlen( lv_clean_number ).

    IF lv_len = 11.
      lv_char = lv_clean_number(1).
      IF lv_char = '1'.
        lv_clean_number = lv_clean_number+1(*).
      ELSE.
        lv_error = 'X'.
      ENDIF.
    ENDIF.

    lv_len = strlen( lv_clean_number ).
    IF lv_len = 10.
      lv_char = lv_clean_number(1).
      IF lv_char NA '23456789'.
        lv_error = 'X'.
      ENDIF.
      lv_char = lv_clean_number+3(1).
      IF lv_char NA '23456789'.
        lv_error = 'X'.
      ENDIF.
    ELSE.
      lv_error = 'X'.
    ENDIF.

    IF lv_error = ''.
      result = lv_clean_number.
    ELSE.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
