ALTER SESSION SET CURRENT_SCHEMA = sgbd;

CREATE OR REPLACE PROCEDURE creare_raport_lunar(
  p_id_utilizator IN NUMBER
) IS

  TYPE nume_melodii IS TABLE OF VARCHAR2(64);
  v_nume nume_melodii := nume_melodii();

  type durate_melodii IS VARRAY(3) OF NUMBER;
  v_durate durate_melodii := durate_melodii();

  type durata_ascultare IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  v_durata_ascultare durata_ascultare := durata_ascultare();

  v_data_inregistrare DATE;
  v_total_durata NUMBER := 0;
  v_avg_durata NUMBER := 0;
  v_nume_utilizator VARCHAR2(32);
  v_prenume_utilizator VARCHAR2(32);
  i PLS_INTEGER := 0;

BEGIN

  SELECT u.data_inregistrare, u.nume, u.prenume
  INTO v_data_inregistrare, v_nume_utilizator, v_prenume_utilizator
  FROM utilizator u
  WHERE u.id_utilizator = p_id_utilizator; 

  DBMS_OUTPUT.PUT_LINE('RAPORT LUNAR PENTRU ' || v_nume_utilizator || ' '|| v_prenume_utilizator);
  DBMS_OUTPUT.PUT_LINE('Utilizator: ' || p_id_utilizator);
  DBMS_OUTPUT.PUT_LINE('Data inregistrare: ' || TO_CHAR(v_data_inregistrare, 'YYYY-MM-DD'));
  DBMS_OUTPUT.PUT_LINE('Top 3 melodii ale lunii (dupa timp_de_ascultare_lunar):');

  FOR rec in (
  
    SELECT m.nume as nume_melodie,
    NVL(m.durata, 0) as durata_melodie,
    NVL(md.timp_de_ascultare_lunar, 0) as timp 
    FROM melodie_downloadata_utilizator md 
    LEFT JOIN melodie m 
    ON md.id_melodie_downloadata = m.id_melodie
    WHERE md.id_utilizator = p_id_utilizator
    ORDER BY NVL(md.timp_de_ascultare_lunar, 0) DESC, m.id_melodie ASC
    FETCH FIRST 3 ROWS ONLY
     
  ) LOOP 

    i := i+1;
    DBMS_OUTPUT.PUT_LINE(rec.nume_melodie || ' ' || rec.durata_melodie || ' ' || rec.timp);

    v_nume.EXTEND;
    v_nume(i) := rec.nume_melodie;

    v_durate.EXTEND;
    v_durate(i) := rec.durata_melodie;

    v_durata_ascultare(i) := rec.timp;
    v_total_durata := v_total_durata + rec.durata_melodie;


 END LOOP;

  IF i = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nu exista melodii descarcate pentru acest utilizator.');
    RETURN;
  END IF;
 
  v_avg_durata := v_total_durata / i;

  FOR j in 1 .. i LOOP
    v_durata_ascultare(j) := TRUNC(v_durata_ascultare(j) / 60);
    DBMS_OUTPUT.PUT_LINE(j || '. ' || v_nume(j) || ' a fost ascultata '
        || v_durata_ascultare(j) || ' de minute.' );

  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Durata totala Top ' || i || ': ' || v_total_durata || ' sec');
  DBMS_OUTPUT.PUT_LINE('Durata medie Top ' || i || ': ' || ROUND(v_avg_durata, 2) || ' sec');

 EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Eroare: utilizatorul nu exista (id=' || p_id_utilizator || ').');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Eroare neasteptata: ' || SQLERRM); 


END creare_raport_lunar;
/

SET SERVEROUTPUT ON;
BEGIN 
  creare_raport_lunar(1);
END;
/
