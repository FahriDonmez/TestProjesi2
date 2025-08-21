CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS personalhighesttolowe
      RETURNING
        VALUE(result) TYPE integertab.
        
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    " add solution here
     result = scores_list.
  ENDMETHOD.

  METHOD latest.
    " add solution here
     result = scores_list[ lines( scores_list ) ].
  ENDMETHOD.

  METHOD personalbest.
    " add solution here
     result = REDUCE i( INIT lv_max = scores_list[ 1 ] FOR list IN scores_list NEXT lv_max = COND #( WHEN list > lv_max THEN list ELSE lv_max ) ).
  ENDMETHOD.

  METHOD personaltopthree.
    " add solution here
        SORT scores_list by table_line DESCENDING.
    DATA lv_int TYPE i.

    DATA(lv_lines) = COND i( WHEN  lines( scores_list ) > 3 THEN 3 ELSE lines( scores_list ) ).
    DO lv_lines TIMES.
      DATA(lv_index) = sy-index.
      lv_int = scores_list[ lv_index ].
      INSERT lv_int INTO TABLE result.
    ENDDO.
  ENDMETHOD.

    METHOD personalhighesttolowe.
    result = scores_list.
    SORT result BY table_line DESCENDING .
    
  ENDMETHOD.


ENDCLASS.
