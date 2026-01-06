ALTER SESSION SET CURRENT_SCHEMA = sgbd;

CREATE OR REPLACE PROCEDURE ceva (
  p_id_creator_playlist IN NUMBER
) IS
  
  v_nume_melodie VARCHAR2(32);
  v_nume_playlist VARCHAR2(32);
  v_id_playlist NUMBER;
  v_nr_streamuri NUMBER;
  i NUMBER := 1;
  j NUMBER := 1;

  CURSOR playlisturi IS
    SELECT id_playlist, denumire FROM playlist WHERE id_creator = p_id_creator_playlist; 
  CURSOR melodii_playlist (p_id_playlist NUMBER) IS
    SELECT m.nume, m.nr_streamuri from playlist_melodie pm
    LEFT JOIN melodie m ON pm.id_melodie = m.id_melodie
    WHERE pm.id_playlist = p_id_playlist
    ORDER BY m.nr_streamuri DESC;


  

BEGIN 
  
    OPEN playlisturi;
    LOOP
      
      FETCH playlisturi INTO v_id_playlist, v_nume_playlist;
      EXIT WHEN playlisturi%NOTFOUND;
      IF melodii_playlist%ISOPEN THEN CLOSE melodii_playlist;
      END IF;
      DBMS_OUTPUT.PUT_LINE('Playlist ' || i || ' ' || v_nume_playlist);
      OPEN melodii_playlist(v_id_playlist);
      LOOP
        FETCH melodii_playlist into v_nume_melodie, v_nr_streamuri;
        EXIT WHEN melodii_playlist%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Melodie ' || j || '. ' || v_nume_melodie || ' - ' 
          || v_nr_streamuri || ' streamuri');
        j:=j+1;
      END LOOP;
      CLOSE melodii_playlist;
      j := 1;
      i := i+1;

    END LOOP;

    CLOSE playlisturi;
  
END;
/

SET SERVEROUTPUT ON;
BEGIN
  ceva(1);
END;
/
