CLASS zcl_isogram DEFINITION PUBLIC.

  PUBLIC SECTION.
    METHODS is_isogram
      IMPORTING
        VALUE(phrase)        TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_isogram IMPLEMENTATION.

  METHOD is_isogram.
    " add solution here
 DATA:
      lv_pos_1       TYPE i,
      lv_pos_2       TYPE i,
      lv_letter      TYPE c LENGTH 1,
      lv_letter_srch TYPE c LENGTH 1,
      lv_count       TYPE i.

    DATA(lv_len) = strlen( phrase ).

    result = abap_true.

    TRANSLATE phrase TO LOWER CASE.

    DO lv_len TIMES.

      lv_letter = phrase+lv_pos_1(1).
      IF lv_letter <> '-' AND  lv_letter <> ' '.
        DO lv_len TIMES.
          lv_letter_srch = phrase+lv_pos_2(1).
          IF lv_letter = lv_letter_srch.
            lv_count = lv_count + 1.
          ENDIF.
          lv_pos_2 = lv_pos_2 + 1.
        ENDDO.
        IF lv_count > 1.
          result = abap_false.
        ENDIF.
      ENDIF.
      CLEAR: lv_pos_2, lv_count.
      lv_pos_1 = lv_pos_1 + 1.
    ENDDO.
    
  ENDMETHOD.

ENDCLASS.
