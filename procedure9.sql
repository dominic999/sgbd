ALTER SESSION SET CURRENT_SCHEMA = sgbd;

CREATE OR REPLACE PROCEDURE adaugare_melodie(
  p_id_utilizator IN NUMBER,
  p_id_playlist IN NUMBER,
  p_id_melodie IN NUMBER
) IS 

  e_melodie_deja_in_playlist EXCEPTION;
  nu_este_creator EXCEPTION;
  nu_are_abonament EXCEPTION;

  v_uid NUMBER;
  v_pid NUMBER;
  v_mid NUMBER;
  v_status_abonament VARCHAR2(32);
  v_exista_deja NUMBER;
  v_apartine_utilizatorului NUMBER;
  v_nume_melodie VARCHAR2(32);
  v_nume_playlist VARCHAR2(32);

BEGIN
  SELECT
    u.id_utilizator,
    p.id_playlist,
    m.id_melodie,
    MAX(a.status),
    MAX(CASE WHEN p.id_creator = u.id_utilizator THEN 1 ELSE 0 END) AS apartine_utilizatorului,
    MAX(CASE WHEN pm.id_melodie IS NOT NULL THEN 1 ELSE 0 END) AS exista_deja
  INTO v_uid, v_pid, v_mid, v_status_abonament, v_apartine_utilizatorului, v_exista_deja
  FROM utilizator u
  LEFT JOIN abonament a ON u.id_abonament = a.id_abonament
  JOIN playlist p ON p.id_playlist = p_id_playlist
  JOIN melodie m ON m.id_melodie = p_id_melodie
  LEFT JOIN playlist_melodie pm ON pm.id_playlist = p.id_playlist AND pm.id_melodie = m.id_melodie
  WHERE u.id_utilizator = p_id_utilizator AND p.id_playlist = p_id_playlist
  GROUP BY u.id_utilizator, p.id_playlist, m.id_melodie;

  IF v_apartine_utilizatorului = 0 THEN
    RAISE nu_este_creator;
  END IF;

  IF v_status_abonament IS NULL OR UPPER(v_status_abonament) <> 'ACTIV' THEN
    RAISE nu_are_abonament;
  END IF;

  IF v_exista_deja = 1 THEN
    RAISE e_melodie_deja_in_playlist;
  END IF;

  SELECT nume INTO v_nume_melodie FROM melodie WHERE id_melodie = p_id_melodie;
  SELECT denumire INTO v_nume_playlist FROM playlist WHERE id_playlist = p_id_playlist;

  INSERT INTO playlist_melodie(id_playlist, id_melodie)
  VALUES (p_id_playlist, p_id_melodie);

  DBMS_OUTPUT.PUT_LINE('OK: melodia ' ||  v_nume_melodie 
    || ' a fost adaugata in playlist ul ' || v_nume_playlist);


  EXCEPTION
    WHEN e_melodie_deja_in_playlist THEN
      DBMS_OUTPUT.PUT_LINE('Melodia deja este in playlist');
    WHEN nu_are_abonament THEN
      DBMS_OUTPUT.PUT_LINE('Utilizatorul nu mai are abonament');
    WHEN nu_este_creator THEN
      DBMS_OUTPUT.PUT_LINE('Utilizatorul nu este creatorul playlistului');
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Date invalide: user / playlist / melodie inexistenta.');



END;
/

SET SERVEROUTPUT ON;

SELECT p.denumire, m.nume
FROM playlist_melodie pm
JOIN playlist p ON p.id_playlist = pm.id_playlist
JOIN melodie  m ON m.id_melodie  = pm.id_melodie
WHERE p.denumire = 'Morning Boost'
ORDER BY m.nume;

DECLARE
  v_uid NUMBER;
  v_pid NUMBER;
  v_mid NUMBER;
BEGIN

  SELECT id_utilizator INTO v_uid FROM utilizator WHERE email = 'alex.popescu@demo.ro';
  SELECT id_playlist   INTO v_pid FROM playlist   WHERE denumire = 'Morning Boost';
  SELECT id_melodie    INTO v_mid FROM melodie    WHERE nume = 'Blinding Lights';

  adaugare_melodie(v_uid, v_pid, v_mid);

END;
/

SELECT p.denumire, m.nume
FROM playlist_melodie pm
JOIN playlist p ON p.id_playlist = pm.id_playlist
JOIN melodie  m ON m.id_melodie  = pm.id_melodie
WHERE p.denumire = 'Morning Boost'
ORDER BY m.nume;

DECLARE
  v_uid NUMBER;
  v_pid NUMBER;
  v_mid NUMBER;
BEGIN
  SELECT id_utilizator INTO v_uid FROM utilizator WHERE email = 'alex.popescu@demo.ro';
  SELECT id_playlist   INTO v_pid FROM playlist   WHERE denumire = 'Morning Boost';
  SELECT id_melodie    INTO v_mid FROM melodie    WHERE nume = 'Neon Heart';

  adaugare_melodie(v_uid, v_pid, v_mid);
END;
/

DECLARE
  v_uid NUMBER;
  v_pid NUMBER;
  v_mid NUMBER;
BEGIN
  SELECT id_utilizator INTO v_uid FROM utilizator WHERE email = 'mara.ionescu@demo.ro';
  SELECT id_playlist   INTO v_pid FROM playlist   WHERE denumire = 'Late Night';
  SELECT id_melodie    INTO v_mid FROM melodie    WHERE nume = 'Neon Heart';

  adaugare_melodie(v_uid, v_pid, v_mid);
END;
/

DECLARE
  v_uid NUMBER;
  v_pid NUMBER;
  v_mid NUMBER;
BEGIN
  SELECT id_utilizator INTO v_uid FROM utilizator WHERE email = 'alex.popescu@demo.ro';
  SELECT id_playlist   INTO v_pid FROM playlist   WHERE denumire = 'Late Night';
  SELECT id_melodie    INTO v_mid FROM melodie    WHERE nume = 'Dark Petals';

  adaugare_melodie(v_uid, v_pid, v_mid);
END;
/

BEGIN
  adaugare_melodie(99999, 1, 1);
END;
/

DELETE FROM playlist_melodie
WHERE id_playlist = (
  SELECT id_playlist
  FROM playlist
  WHERE denumire = 'Morning Boost'
)
AND id_melodie = (
  SELECT id_melodie
  FROM melodie
  WHERE nume = 'Blinding Lights'
);
