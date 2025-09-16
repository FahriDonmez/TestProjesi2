CLASS zcl_matrix DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS matrix_row
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.
    METHODS matrix_column
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.





CLASS zcl_matrix IMPLEMENTATION.
  METHOD matrix_column.
    DATA lv_i TYPE i.
    DATA lv_len TYPE i.
    DATA lv_pos TYPE i.
    DATA lv_col TYPE i VALUE 1.
    DATA lv_str TYPE string.
    DATA lv_char.

    lv_len = strlen( string ).
    DO lv_len TIMES.
      lv_char = string+lv_pos(1).
      IF lv_char CA '0123456789'.
        lv_str = |{ lv_str }{ lv_char }|.
      ELSEIF lv_char EQ space.
        IF  lv_col = index.
          lv_i = lv_str.
          APPEND lv_i TO result.
        ENDIF.
        CLEAR lv_str.
        lv_col = lv_col + 1.
      ELSEIF string+lv_pos(1) EQ 'n'.
        IF  lv_col = index.
          lv_i = lv_str.
          APPEND lv_i TO result.
        ELSE.
          CLEAR lv_str.
        ENDIF.
        lv_col = 1.
      ENDIF.
      lv_pos = lv_pos + 1.
      IF lv_len = lv_pos AND  lv_col = index.
        lv_i = lv_str.
        APPEND lv_i TO result.
      ENDIF.
    ENDDO.
  ENDMETHOD.

  METHOD matrix_row.
    DATA lv_i TYPE i.
    DATA lv_len TYPE i.
    DATA lv_pos TYPE i.
    DATA lv_row TYPE i VALUE 1.
    DATA lv_str TYPE string.
    DATA lv_char.

    lv_len = strlen( string ).
    DO lv_len TIMES.
      lv_char = string+lv_pos(1).
      IF lv_char CA '0123456789'.
        lv_str = |{ lv_str }{ lv_char }|.
      ELSEIF lv_char EQ space.
        IF  lv_row = index.
          lv_i = lv_str.
          APPEND lv_i TO result.
        ENDIF.
        CLEAR lv_str.
      ELSEIF string+lv_pos(1) EQ 'n'.
        IF  lv_row = index.
          lv_i = lv_str.
          APPEND lv_i TO result.
        ELSE.
          lv_row = lv_row + 1.
          CLEAR lv_str.
        ENDIF.
      ENDIF.
      lv_pos = lv_pos + 1.
      IF lv_len = lv_pos AND  lv_row = index.
        lv_i = lv_str.
        APPEND lv_i TO result.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
