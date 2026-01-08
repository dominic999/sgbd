ALTER SESSION SET CURRENT_SCHEMA = sgbd;


CREATE OR REPLACE FUNCTION artist_preferat (
  p_id_utilizator IN NUMBER
) RETURN VARCHAR2
IS
  TYPE t_artisti IS TABLE OF NUMBER INDEX BY VARCHAR2(128);
  v_artisti_posibili t_artisti;

  v_nume_utilizator  VARCHAR2(32);
  v_key VARCHAR2(128);
  v_nume_artist VARCHAR2(128);
  v_nume_melodie VARCHAR2(128);
  v_timp_maxim NUMBER := -1;
  v_artist_preferat VARCHAR2(128);
BEGIN
  SELECT prenume
  INTO v_nume_utilizator
  FROM utilizator
  WHERE id_utilizator = p_id_utilizator;

  DBMS_OUTPUT.PUT_LINE('Artistul preferat al lui ' || v_nume_utilizator);

  FOR rec IN (
    SELECT
      md.id_melodie_downloadata AS id_melodie,
      md.timp_de_ascultare_lunar AS timp_ascultare
    FROM melodie_downloadata_utilizator md
    WHERE md.id_utilizator = p_id_utilizator
  ) LOOP

    SELECT a.nume, m.nume
    INTO v_nume_artist, v_nume_melodie
    FROM melodie_artist ma
    JOIN artist a ON a.id_artist = ma.id_artist
    JOIN melodie m on m.id_melodie = ma.id_melodie
    WHERE ma.id_melodie = rec.id_melodie
      AND ma.artist_principal = 1;

    IF v_artisti_posibili.EXISTS(v_nume_artist) THEN
      v_artisti_posibili(v_nume_artist) :=
        v_artisti_posibili(v_nume_artist) + rec.timp_ascultare;
    ELSE
      v_artisti_posibili(v_nume_artist) := rec.timp_ascultare;
    END IF;

    DBMS_OUTPUT.PUT_LINE(v_nume_artist || ' | melodie_id' || v_nume_melodie || ' | ' || rec.timp_ascultare || ' sec');
  END LOOP;

  IF v_artisti_posibili.COUNT = 0 THEN
    RETURN 'Nicio data';
  END IF;

  v_key := v_artisti_posibili.FIRST;
  WHILE v_key IS NOT NULL LOOP
    IF v_artisti_posibili(v_key) > v_timp_maxim THEN
      v_timp_maxim := v_artisti_posibili(v_key);
      v_artist_preferat := v_key;
    END IF;
    v_key := v_artisti_posibili.NEXT(v_key);
  END LOOP;

  RETURN v_artist_preferat;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND (user inexistent sau melodie fara artist principal)');
    RETURN 'Nicio data';

  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS (melodie cu mai multi artisti principali)');
     RETURN 'Date inconsistente';
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('VALUE_ERROR: problema de conversie / lungime variabile');
    RETURN 'Date gresite';
END;
/
SET SERVEROUTPUT ON;

DECLARE
  v VARCHAR2(32);
BEGIN
  v := artist_preferat(1);
  DBMS_OUTPUT.PUT_LINE('Return: ' || NVL(v,'(NULL)'));
END;
/

DECLARE
  v VARCHAR2(32);
BEGIN
  v := artist_preferat(910);
  DBMS_OUTPUT.PUT_LINE('Return: ' || NVL(v,'(NULL)'));
END;
/

DECLARE
  v VARCHAR2(32);
BEGIN
  v := artist_preferat(2);
  DBMS_OUTPUT.PUT_LINE('Return: ' || NVL(v,'(NULL)'));
END;
/

