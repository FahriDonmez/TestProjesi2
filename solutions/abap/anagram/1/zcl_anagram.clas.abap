CLASS zcl_anagram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS anagram
      IMPORTING
        input         TYPE string
        candidates    TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
      METHODS parse_letter
      IMPORTING
        i_input       TYPE string
      RETURNING
        VALUE(result) TYPE string_table.
ENDCLASS.



CLASS zcl_anagram IMPLEMENTATION.
  METHOD anagram.
* add solution here
 DATA:
      i_letters TYPE string_table,
      c_letters TYPE string_table.



    LOOP AT candidates INTO DATA(ls_c).
      i_letters = parse_letter( input ).
      c_letters = parse_letter( ls_c ).
      IF i_letters[] <> c_letters[].
        SORT i_letters.
        SORT c_letters.
        IF i_letters[] = c_letters[].
          APPEND ls_c TO result.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD parse_letter.

    DATA: l_pos  TYPE i,
          letter.

    DATA(lv_len) = strlen( i_input ).



    DO lv_len TIMES.
      letter = i_input+l_pos(1).
      TRANSLATE letter TO LOWER CASE.
      APPEND letter TO result.
      l_pos = l_pos + 1.
    ENDDO.

  ENDMETHOD.
ENDCLASS.
