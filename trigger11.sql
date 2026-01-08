ALTER SESSION SET CURRENT_SCHEMA = sgbd;


CREATE OR REPLACE TRIGGER melodie_noua_in_playlist
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

CREATE OR REPLACE TRIGGER melodie_scoasa_din_playlist
AFTER DELETE ON playlist_melodie FOR EACH ROW
DECLARE 
  v_durata NUMBER; 
BEGIN
  
  SELECT m.durata INTO v_durata
  from melodie m 
  WHERE m.id_melodie = :OLD.id_melodie;

  UPDATE playlist
  SET nr_melodii = NVL(nr_melodii, 0) - 1,
    durata = NVL(durata, 0) - v_durata
  WHERE id_playlist = :OLD.id_playlist;

END;
/

SELECT id_playlist, denumire, nr_melodii, durata
FROM playlist
WHERE denumire = 'Morning Boost';

SELECT id_melodie, nume, durata
FROM melodie
WHERE nume = 'Golden Sky';

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES (
  (SELECT id_melodie FROM melodie WHERE nume = 'Golden Sky'),
  (SELECT id_playlist FROM playlist WHERE denumire = 'Morning Boost')
);

SELECT id_playlist, denumire, nr_melodii, durata
FROM playlist
WHERE denumire = 'Morning Boost';


DELETE FROM playlist_melodie
WHERE id_playlist = (SELECT id_playlist FROM playlist WHERE denumire = 'Morning Boost')
  AND id_melodie  = (SELECT id_melodie FROM melodie WHERE nume = 'Golden Sky');

SELECT id_playlist, denumire, nr_melodii, durata
FROM playlist
WHERE denumire = 'Morning Boost';
