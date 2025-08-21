CLASS zcl_itab_nesting DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF artists_type,
             artist_id   TYPE string,
             artist_name TYPE string,
           END OF artists_type.
    TYPES artists TYPE STANDARD TABLE OF artists_type WITH KEY artist_id.
    TYPES: BEGIN OF albums_type,
             artist_id  TYPE string,
             album_id   TYPE string,
             album_name TYPE string,
           END OF albums_type.
    TYPES albums TYPE STANDARD TABLE OF albums_type WITH KEY artist_id album_id.
    TYPES: BEGIN OF songs_type,
             artist_id TYPE string,
             album_id  TYPE string,
             song_id   TYPE string,
             song_name TYPE string,
           END OF songs_type.
    TYPES songs TYPE STANDARD TABLE OF songs_type WITH KEY artist_id album_id song_id.


    TYPES: BEGIN OF song_nested_type,
             song_id   TYPE string,
             song_name TYPE string,
           END OF song_nested_type.
    TYPES: BEGIN OF album_song_nested_type,
             album_id   TYPE string,
             album_name TYPE string,
             songs      TYPE STANDARD TABLE OF song_nested_type WITH KEY song_id,
           END OF album_song_nested_type.
    TYPES: BEGIN OF artist_album_nested_type,
             artist_id   TYPE string,
             artist_name TYPE string,
             albums      TYPE STANDARD TABLE OF album_song_nested_type WITH KEY album_id,
           END OF artist_album_nested_type.
    TYPES nested_data TYPE STANDARD TABLE OF artist_album_nested_type WITH KEY artist_id.

    METHODS perform_nesting
      IMPORTING
        artists            TYPE artists
        albums             TYPE albums
        songs              TYPE songs
      RETURNING
        VALUE(nested_data) TYPE nested_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_itab_nesting IMPLEMENTATION.

  METHOD perform_nesting.
        DATA:  ls_nest TYPE  artist_album_nested_type.

    LOOP AT artists INTO DATA(ls_artists).
      ls_nest-artist_id = ls_artists-artist_id.
      ls_nest-artist_name = ls_artists-artist_name.
      APPEND ls_nest TO nested_data.
    ENDLOOP.

    LOOP AT nested_data ASSIGNING FIELD-SYMBOL(<nest>).
      LOOP AT albums INTO DATA(ls_albums) WHERE artist_id = <nest>-artist_id.
        INSERT VALUE #( album_id = ls_albums-album_id album_name = ls_albums-album_name ) INTO TABLE <nest>-albums.
      ENDLOOP.
      LOOP AT <nest>-albums ASSIGNING FIELD-SYMBOL(<albums>).
        LOOP AT songs INTO DATA(ls_song) WHERE artist_id = <nest>-artist_id AND album_id = <albums>-album_id.
          INSERT VALUE #( song_id = ls_song-song_id song_name = ls_song-song_name ) INTO TABLE <albums>-songs.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
    
  ENDMETHOD.

ENDCLASS.
