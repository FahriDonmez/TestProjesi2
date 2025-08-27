CLASS zcl_atbash_cipher DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS decode
      IMPORTING
        cipher_text TYPE string
      RETURNING
        VALUE(plain_text)  TYPE string .
    METHODS encode
      IMPORTING
        plain_text        TYPE string
      RETURNING
        VALUE(cipher_text) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
      METHODS replace_letter
      IMPORTING
        i_cipher_text       TYPE string
        i_group             TYPE i
      RETURNING
        VALUE(r_plain_text) TYPE string.
ENDCLASS.



CLASS zcl_atbash_cipher IMPLEMENTATION.

  METHOD decode.
* todo
plain_text = replace_letter( i_cipher_text = cipher_text i_group = 0 ).
  ENDMETHOD.

  METHOD encode.
* todo
cipher_text = replace_letter( i_cipher_text = plain_text i_group = 5 ).
  ENDMETHOD.

  METHOD replace_letter.

    DATA(lv_Plain) = 'abcdefghijklmnopqrstuvwxyz1234567890'.
    DATA(lv_Cipher) = 'zyxwvutsrqponmlkjihgfedcba1234567890'.
    DATA(lv_len_t) = strlen( i_cipher_text ).
    DATA(lv_len_a) = strlen( lv_Plain ).
    DATA:
      lv_pos_t  TYPE i,
      lv_pos_p  TYPE i,
      lv_pos_c  TYPE i,
      lv_pos_g  TYPE i,
      lv_letter TYPE c LENGTH 1.

    DO lv_len_t TIMES.
      lv_pos_t = sy-index - 1.
      lv_letter = i_cipher_text+lv_pos_t(1).
      TRANSLATE lv_letter TO LOWER CASE.
      IF lv_letter CA lv_Cipher.
        FIND FIRST OCCURRENCE OF lv_letter IN lv_Cipher MATCH OFFSET lv_pos_c.
        IF sy-subrc EQ 0.
          lv_pos_g = lv_pos_g + 1.
          IF lv_pos_g > i_group AND i_group <> 0.
            r_plain_text = |{ r_plain_text } { lv_Plain+lv_pos_c(1) }|.
            lv_pos_g = 1.
          ELSE.
            r_plain_text = |{ r_plain_text }{ lv_Plain+lv_pos_c(1) }|.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDDO.

  ENDMETHOD.
ENDCLASS.
