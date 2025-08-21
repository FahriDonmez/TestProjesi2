CLASS zcl_resistor_color DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string
      RETURNING
        VALUE(value) TYPE i.
ENDCLASS.

CLASS zcl_resistor_color IMPLEMENTATION.

  METHOD resistor_color.
* add solution here
    value = -1.
    CASE color_code.
      WHEN 'black'.
        value = 0.
      WHEN 'orange'.
        value = 3.
      WHEN 'white'.
        value = 9.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
