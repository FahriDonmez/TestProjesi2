CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
      TYPES: BEGIN OF ty_list,
             letter TYPE c LENGTH 1,
             point  TYPE i,
           END OF ty_list,
           tt_list TYPE TABLE OF ty_list.

    DATA: letter_list TYPE tt_list.

     METHODS constructor.
     
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD constructor.

    letter_list = VALUE #(

      ( letter = 'A' point = 1 )
      ( letter = 'E' point = 1 )
      ( letter = 'I' point = 1 )
      ( letter = 'O' point = 1 )
      ( letter = 'U' point = 1 )
      ( letter = 'L' point = 1 )
      ( letter = 'N' point = 1 )
      ( letter = 'R' point = 1 )
      ( letter = 'S' point = 1 )
      ( letter = 'T' point = 1 )
      ( letter = 'D' point = 2 )
      ( letter = 'G' point = 2 )
      ( letter = 'B' point = 3 )
      ( letter = 'C' point = 3 )
      ( letter = 'M' point = 3 )
      ( letter = 'P' point = 3 )
      ( letter = 'F' point = 4 )
      ( letter = 'H' point = 4 )
      ( letter = 'V' point = 4 )
      ( letter = 'W' point = 4 )
      ( letter = 'Y' point = 4 )
      ( letter = 'K' point = 5 )
      ( letter = 'J' point = 8 )
      ( letter = 'X' point = 8 )
      ( letter = 'Q' point = 10 )
      ( letter = 'Z' point = 10 )

      ).

  ENDMETHOD.
  
  METHOD score.
    " add solution here
        DATA: lv_pos TYPE i.
    DATA(str_len) = strlen( input ).

    DO str_len TIMES.
      lv_pos = sy-index - 1.
      DATA(lv_letter) = substring( val = input off = lv_pos len = 1 ).
      READ TABLE letter_list WITH KEY letter = to_upper( lv_letter )
      INTO DATA(ls_list).
      IF sy-subrc EQ 0.
        result = result + ls_list-point.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
