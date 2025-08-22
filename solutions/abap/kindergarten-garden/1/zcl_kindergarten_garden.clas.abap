CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA students TYPE string_table.

ENDCLASS.


CLASS zcl_kindergarten_garden IMPLEMENTATION.


  METHOD plants.
    " add solution here
     students = VALUE #(
                        ( |Alice| )
                        ( |Alice| )
                        ( |Bob| )
                        ( |Bob| )
                        ( |Charlie| )
                        ( |Charlie| )
                        ( |David| )
                        ( |David| )
                        ( |Eve| )
                        ( |Eve| )
                        ( |Fred| )
                        ( |Fred| )
                        ( |Ginny| )
                        ( |Ginny| )
                        ( |Harriet| )
                        ( |Harriet| )
                        ( |Ileana| )
                        ( |Ileana| )
                        ( |Joseph| )
                        ( |Joseph| )
                        ( |Kincaid| )
                        ( |Kincaid| )
                        ( |Larry| )
                        ( |Larry| )
                      ).

    DATA(student_index1) = line_index( students[ table_line = student ] ) .
    DATA(student_index0) = student_index1 - 1.

    DATA(lv_pos)  = find( val = diagram sub = '\n' ).
    IF lv_pos > 0.
      DATA(lv_row1) = diagram(lv_pos).
      lv_pos = lv_pos + 2.
      DATA(lv_row2) = diagram+lv_pos(*).

      DATA(cup1) = lv_row1+student_index0(1).
      DATA(cup2) = lv_row1+student_index1(1).
      DATA(cup3) = lv_row2+student_index0(1).
      DATA(cup4) = lv_row2+student_index1(1).

      results = VALUE #( ( cup1 ) ( cup2 ) ( cup3 ) ( cup4 ) ).

      LOOP AT results ASSIGNING FIELD-SYMBOL(<r>).
        CASE <r>.
          WHEN 'G'.
            <r> = 'grass'.
          WHEN 'C'.
            <r> = 'clover'.
          WHEN 'R'.
            <r> = 'radishes'.
          WHEN 'V'.
            <r> = 'violets'.
        ENDCASE.
      ENDLOOP.

    ENDIF.
  ENDMETHOD.


ENDCLASS.
