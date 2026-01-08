ALTER SESSION SET CURRENT_SCHEMA = sgbd;

DECLARE OR REPLACE TRIGGER melodie_noua_in_playlist
AFTER INSERT ON playlist_melodie FOR EACH ROW
DECLARE 
  v_durata NUMBER; 
BEGIN
  
  SELECT m.durata INTO v_durata
  from melodie m 
  WHERE m.id_melodie = :NEW.id_melodie;

  UPDATE playlist
  SET nr_melodii = NVL(nr_melodii, 0) + 1,
    durata = NVL(durata, 0) + v_durata
  WHERE id_playlist = :NEW.id_playlist;

END;
/
