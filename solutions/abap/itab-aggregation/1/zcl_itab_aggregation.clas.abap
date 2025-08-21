CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    " add solution here
    
    DATA: lt_init  TYPE initial_numbers,
          ls_aggr  TYPE aggregated_data_type,
          lv_group TYPE group,
          lv_count TYPE i,
          lv_sum   TYPE i,
          lv_min   TYPE i,
          lv_max   TYPE i.
    lt_init = initial_numbers.
    IF  lines( lt_init ) = 0.
      RETURN.
    ENDIF.
    SORT lt_init BY group.
    LOOP AT lt_init ASSIGNING FIELD-SYMBOL(<fs>).
      IF lv_group NE <fs>-group.
        CLEAR: lv_count, lv_sum, lv_max, lv_min, ls_aggr.
      ENDIF.
      lv_group = <fs>-group.
      lv_count = lv_count + 1.
      lv_sum = lv_sum + <fs>-number.
      IF lv_max IS INITIAL OR <fs>-number GT lv_max.
        lv_max = <fs>-number.
      ENDIF.
      IF lv_min IS INITIAL OR <fs>-number LT lv_min.
        lv_min = <fs>-number.
      ENDIF.
      ls_aggr-group = lv_group.
      ls_aggr-count = lv_count.
      ls_aggr-sum = lv_sum.
      ls_aggr-max = lv_max.
      ls_aggr-min = lv_min.
      ls_aggr-average = lv_sum / lv_count.
      IF lv_count NE 1.
        DELETE aggregated_data WHERE group EQ lv_group.
      ENDIF.
      APPEND ls_aggr TO aggregated_data.
    ENDLOOP.
    
  ENDMETHOD.

ENDCLASS.
