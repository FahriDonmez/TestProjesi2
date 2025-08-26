CLASS zcl_clock DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.
    METHODS get
      RETURNING
        VALUE(result) TYPE string.
    METHODS add
      IMPORTING
        !minutes TYPE i.
    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.

* add solution here
    DATA: gv_hour TYPE string.
    METHODS fill_time
      IMPORTING
        i_hours   TYPE i
        i_minutes TYPE i.
        
ENDCLASS.



CLASS zcl_clock IMPLEMENTATION.

  METHOD add.
* add solution here
DATA: lv_h TYPE i.
    DATA: lv_m TYPE i.
    DATA: lv_bolum TYPE i.
    DATA: lv_mod TYPE i.

    lv_h = gv_hour(2).
    lv_m = gv_hour+3(2) + minutes + ( lv_h * 60 ).

    IF lv_m > 60.
      lv_bolum = lv_m DIV 60.
      lv_h = lv_bolum.
      lv_mod = lv_m MOD 60.
      lv_m = lv_mod.
    ELSE.
      lv_h = 0.
    ENDIF.
    IF lv_h > 23.
      lv_mod = lv_h MOD 24.
      lv_h = lv_mod.
    ENDIF.

    fill_time(
i_hours = lv_h
i_minutes = lv_m ).
  ENDMETHOD.


  METHOD constructor.
* add solution here
DATA: lv_h TYPE i.
    DATA: lv_bolum TYPE i.
    DATA: lv_mod TYPE i.
    DATA: lv_m TYPE i.

    lv_h = hours MOD 24.



    lv_mod =  abs( minutes ) MOD 60.
    lv_mod = abs( minutes ) - lv_mod.
    lv_bolum =  ( lv_mod DIV 60 ).
    IF minutes < 0.
      lv_bolum = lv_bolum * -1.
    ENDIF.

    lv_h = lv_h + lv_bolum.
    lv_h = lv_h MOD 24.

    lv_m = 0.


    fill_time( i_hours = lv_h i_minutes = lv_m ).

    lv_m = minutes MOD 60.

    lv_m = COND #( WHEN minutes < 0 THEN lv_m - 60 ELSE lv_m ).

    me->add( minutes = lv_m ).
  ENDMETHOD.


  METHOD get.
* add solution here
result = gv_hour.
  ENDMETHOD.


  METHOD sub.
* add solution here
 DATA: lv_h TYPE i.
    DATA: lv_m TYPE i.
    DATA: lv_bolum TYPE i.
    DATA: lv_mod TYPE i.

    lv_h = minutes MOD 1440.

    lv_m = gv_hour+3(2) + ( gv_hour(2) * 60 ).

    IF lv_m > lv_h.
      lv_m = lv_m - lv_h.
    ELSE.
      lv_m = 1440 - ( lv_h - lv_m ).
    ENDIF.

    IF lv_m > 60.
      lv_bolum = lv_m DIV 60.
      lv_h = lv_bolum.
      lv_mod = lv_m MOD 60.
      lv_m = lv_mod.
    ELSE.
      lv_h = 0.
    ENDIF.
    IF lv_h > 23.
      lv_mod = lv_h MOD 24.
      lv_h = lv_mod.
    ENDIF.

    fill_time(
i_hours = lv_h
i_minutes = lv_m ).
  ENDMETHOD.

    METHOD fill_time.

    DATA: lv_h TYPE c LENGTH 2.
    DATA: lv_m TYPE c LENGTH 2.

    lv_h = COND #( WHEN i_hours < 10 THEN |0{ i_hours }|  ELSE i_hours ).
    lv_m = COND #( WHEN i_minutes < 10 THEN |0{ i_minutes }|  ELSE i_minutes ).
    gv_hour = |{ lv_h }:{ lv_m }|.

  ENDMETHOD.
ENDCLASS.
