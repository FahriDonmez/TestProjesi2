CLASS zcl_nth_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_nth_prime IMPLEMENTATION.
  METHOD prime.
    " add solution here
    DATA: lv_number    TYPE i,
          lv_iterasyon TYPE i,
          lv_count     TYPE i,
          lv_count_p   TYPE i.

    IF input = 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ELSE.
      DO.
        lv_number = lv_number + 1.

        IF lv_number > 1.
          DO lv_number TIMES.
            lv_iterasyon = lv_iterasyon + 1.
            IF lv_iterasyon > 1.
              DATA(lv_val) = lv_number MOD lv_iterasyon.
              IF lv_val = 0.
                lv_count = lv_count + 1.
              ENDIF.
            ENDIF.
          ENDDO.
          IF lv_count = 1.
            lv_count_p = lv_count_p + 1.
          ENDIF.
          IF lv_count_p = input.
            result = lv_number.
            EXIT.
          ELSE.
            lv_iterasyon = 0.
            lv_count = 0.
          ENDIF.
        ENDIF.
      ENDDO.
    ENDIF.
  ENDMETHOD.


ENDCLASS.
