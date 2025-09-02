CLASS zcl_rle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS encode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

    METHODS decode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

ENDCLASS.


CLASS zcl_rle IMPLEMENTATION.

  METHOD encode.

    "Add solution here
DATA:
      old_letter VALUE '|',
      new_letter,
      pos        TYPE i,
      count      TYPE i.

    DATA(lenth) = strlen( input ).

    DO lenth TIMES.
      new_letter = input+pos(1).
      IF new_letter = old_letter.
        count = count + 1.
      ELSE.
        IF  old_letter  <> '|'.
          IF count > 1.
            IF old_letter = space.
              result = |{ result }{ count } |.
            ELSE.
              result = |{ result }{ count }{ old_letter }|.
            ENDIF.
          ELSE.
            IF old_letter = space.
              result = |{ result } |.
            ELSE.
              result = |{ result }{ old_letter }|.
            ENDIF.

          ENDIF.
        ENDIF.
        count = 1.
      ENDIF.

      pos = pos + 1.
      IF pos = lenth.
        IF new_letter <> old_letter.
          count =  1.
        ENDIF.

        IF new_letter <> '|'.
          IF count > 1.
            IF new_letter = space.
              result = |{ result }{ count } |.
            ELSE.
              result = |{ result }{ count }{ new_letter }|.
            ENDIF.
          ELSE.
            IF new_letter = space.
              result = |{ result } |.
            ELSE.
              result = |{ result }{ new_letter }|.
            ENDIF.
          ENDIF.
        ENDIF.

      ENDIF.
      old_letter = new_letter.
    ENDDO.
  ENDMETHOD.


  METHOD decode.

    "Add solution here
 DATA: pos    TYPE i,
          letter,
          repeat TYPE i,
          number TYPE string.

    DATA(length) = strlen( input ).

    DO length TIMES.
      letter = input+pos(1).
      IF letter CA '1234567890'.
        number = |{ number }{ letter }|.
      ELSE.
        repeat = COND #( WHEN number = '' THEN 1 ELSE number ).
        DO repeat TIMES.
          IF letter = space.
            result = |{ result } |.
          ELSE.
            result = |{ result }{ letter }|.
          ENDIF.
        ENDDO.
        CLEAR number.
      ENDIF.
      pos = pos + 1.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
