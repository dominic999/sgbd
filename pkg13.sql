ALTER SESSION SET CURRENT_SCHEMA = sgbd;

CREATE OR REPLACE PACKAGE pkg_construire_playlist AS 
  
  TYPE t_record_melodie IS RECORD (
    id_melodie melodie.id_melodie%TYPE,
    durata melodie.durata%TYPE
  );

  TYPE t_list_recorduri IS TABLE OF t_record_melodie;

  TYPE t_statistici_playlist IS RECORD (
    durata playlist.durata%TYPE,
    artist_top NUMBER,
    streamuri_totale NUMBER
  );

  FUNCTION verificatre_abonament_activ (p_id_utilizator NUMBER) RETURN NUMBER; 
  FUNCTION statistici_playlist (p_lista_melodii t_list_recorduri) RETURN t_statistici_playlist;
  PROCEDURE generare_playlist (p_id_utilizator NUMBER, p_feeling VARCHAR2, p_durata_maxima NUMBER);
  PROCEDURE afisare_playlist (p_nume_playlist VARCHAR2, p_nr_melodii NUMBER, p_durata_toatala NUMBER);

END pkg_construire_playlist;
/

CREATE OR REPLACE PACKAGE BODY pkg_construire_playlist AS

  FUNCTION verificatre_abonament_activ (p_id_utilizator NUMBER) RETURN NUMBER IS 
    v_id_abonament NUMBER;
    v_status_abonament VARCHAR2(16);
  BEGIN

    SELECT id_abonament 
    INTO v_id_abonament
    FROM utilizator 
    WHERE id_utilizator = p_id_utilizator;

    IF v_id_abonament IS NULL THEN
      RETURN 0; 
    END IF;

    SELECT status 
    INTO v_status_abonament
    FROM abonament
    WHERE id_abonament = v_id_abonament;

    IF v_status_abonament <> 'activ' THEN 
      RETURN 0; 
    END IF;

    RETURN 1;

   EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 2;

  END verificatre_abonament_activ;

  -- TYPE t_statistici_playlist IS RECORD (
  --   durata playlist.durata%TYPE,
  --   artist_top NUMBER,
  --   streamuri_totale NUMBER
  -- );

  -- TYPE t_record_melodie IS RECORD (
  --   id_melodie melodie.id_melodie%TYPE,
  --   durata melodie.durata%TYPE
  -- );

  FUNCTION statistici_playlist (p_lista_melodii t_list_recorduri) RETURN t_statistici_playlist 
  IS

    TYPE t_top_artisti IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_top_artisti t_top_artisti;

    v_id_artist NUMBER;
    v_nr_streamuri NUMBER;
    v_durata_melodie NUMBER;
    v_durata_totala NUMBER := 0;
    v_streamuri_totale NUMBER := 0;
    v_artist_top_numar NUMBER := 0;
    v_artist_top_id NUMBER := NULL;
    v_cheie NUMBER;

    statistici_finale t_statistici_playlist;

  BEGIN 

    FOR i IN 1 .. p_lista_melodii.COUNT LOOP

      BEGIN
        SELECT m.nr_streamuri, m.durata, ma.id_artist
        INTO v_nr_streamuri, v_durata_melodie, v_id_artist
        FROM melodie_artist ma
        JOIN melodie m ON ma.id_melodie = m.id_melodie
        WHERE ma.id_melodie = p_lista_melodii(i).id_melodie AND ma.artist_principal = 1;

        v_durata_totala := v_durata_totala + NVL(v_durata_melodie, 0);
        v_streamuri_totale := v_streamuri_totale + NVL(v_nr_streamuri, 0);

        IF v_top_artisti.EXISTS(v_id_artist) THEN
          v_top_artisti(v_id_artist) := v_top_artisti(v_id_artist) + 1;
        ELSE 
          v_top_artisti(v_id_artist) := 1;
        END IF;

        EXCEPTION
          WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Aceasta melodie are mai multi artisti principali, ceea ce este o inconsistenta a datelor');
          WHEN NO_DATA_FOUND THEN
            NULL;
      END;
    END LOOP;

    v_cheie := v_top_artisti.FIRST;
    WHILE v_cheie IS NOT NULL LOOP
      IF v_top_artisti(v_cheie) > v_artist_top_numar THEN
        v_artist_top_numar := v_top_artisti(v_cheie);
        v_artist_top_id := v_cheie;
      END IF;
      v_cheie := v_top_artisti.NEXT(v_cheie);
    END LOOP;

    statistici_finale.streamuri_totale := v_streamuri_totale;
    statistici_finale.durata := v_durata_totala;
    statistici_finale.artist_top := v_artist_top_id;
    RETURN statistici_finale;

  END statistici_playlist;

  --generare playlist

  PROCEDURE generare_playlist (p_id_utilizator NUMBER, p_feeling VARCHAR2, p_durata_maxima NUMBER) 
  IS 
    v_lista_melodii t_list_recorduri := t_list_recorduri();
    v_durata_actuala NUMBER := 0;
    v_id_playlist NUMBER;
    v_id_feeling NUMBER;
    v_statistici t_statistici_playlist;
    v_ultimul_id_playlist NUMBER;
    v_nume_playlist VARCHAR2(64);

  BEGIN

    IF verificatre_abonament_activ(p_id_utilizator) <> 1 THEN
      DBMS_OUTPUT.PUT_LINE('Utilizatorul nu exista sau nu are abonament activ');
      RETURN;
    END IF;

    SELECT NVL(MAX(id_playlist), 1) INTO v_ultimul_id_playlist FROM playlist;

    v_ultimul_id_playlist := v_ultimul_id_playlist + 1;
    v_nume_playlist := 'playlist-' || v_ultimul_id_playlist;

    INSERT INTO playlist(id_creator, denumire, nr_melodii, durata, nr_streamuri)
      VALUES (p_id_utilizator, v_nume_playlist, 0, 0, 0)
      RETURNING id_playlist INTO v_id_playlist;

    SELECT id_feeling 
    INTO v_id_feeling
    FROM feeling 
    WHERE denumire = p_feeling;

    FOR rec in (
      SELECT m.durata AS durata_melodie, m.nume AS nume_melodie, m.id_melodie as id
      FROM feeling_melodie fm 
      JOIN melodie m ON fm.id_melodie = m.id_melodie 
      WHERE fm.id_feeling = v_id_feeling
    ) LOOP

       IF v_durata_actuala + NVL(rec.durata_melodie, 0) > p_durata_maxima THEN
            EXIT;
       END IF;

      v_durata_actuala := v_durata_actuala + NVL(rec.durata_melodie, 0);

        -- adaug in lista
        v_lista_melodii.EXTEND;
        v_lista_melodii(v_lista_melodii.COUNT).id_melodie := rec.id;
        v_lista_melodii(v_lista_melodii.COUNT).durata := rec.durata_melodie;

        -- insereaz in tabelul asociativ
        INSERT INTO playlist_melodie(id_melodie, id_playlist)
        VALUES (rec.id, v_id_playlist);
      END LOOP;

    v_statistici := statistici_playlist(v_lista_melodii);

    afisare_playlist(v_nume_playlist, v_lista_melodii.COUNT, v_statistici.durata);

    DBMS_OUTPUT.PUT_LINE('ID playlist creat: ' || v_id_playlist);

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Feeling inexistent: ' || p_feeling);

  END generare_playlist;

  PROCEDURE afisare_playlist (p_nume_playlist VARCHAR2, p_nr_melodii NUMBER, p_durata_toatala NUMBER) 
  IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('==============================');
    DBMS_OUTPUT.PUT_LINE('Playlist generat: ' || p_nume_playlist);
    DBMS_OUTPUT.PUT_LINE('Nr melodii: ' || NVL(p_nr_melodii, 0));
    DBMS_OUTPUT.PUT_LINE('Durata totala (sec): ' || NVL(p_durata_toatala, 0));
    DBMS_OUTPUT.PUT_LINE('==============================');
  END afisare_playlist;

END pkg_construire_playlist;
/

SET SERVEROUTPUT ON;

DECLARE
  v_uid              NUMBER;
  v_id_abonament      NUMBER;
  v_status            VARCHAR2(16);

  v_ok               NUMBER;

  v_pid              NUMBER;
  v_pname            VARCHAR2(64);
  v_nr               NUMBER;
  v_dur              NUMBER;

  v_lista            pkg_construire_playlist.t_list_recorduri := pkg_construire_playlist.t_list_recorduri();
  v_stats            pkg_construire_playlist.t_statistici_playlist;
BEGIN
  -- 1) ia userul Alex
  SELECT id_utilizator, id_abonament
  INTO v_uid, v_id_abonament
  FROM utilizator
  WHERE email = 'alex.popescu@demo.ro';

  DBMS_OUTPUT.PUT_LINE('User id = ' || v_uid || ', abonament id = ' || NVL(v_id_abonament, -1));

  -- 2) status abonament (daca exista)
  IF v_id_abonament IS NOT NULL THEN
    SELECT status INTO v_status FROM abonament WHERE id_abonament = v_id_abonament;
    DBMS_OUTPUT.PUT_LINE('Status abonament = ' || v_status);
  ELSE
    DBMS_OUTPUT.PUT_LINE('User fara abonament (id_abonament NULL).');
  END IF;

  -- 3) test functie verificare abonament
  v_ok := pkg_construire_playlist.verificatre_abonament_activ(v_uid);
  DBMS_OUTPUT.PUT_LINE('verificatre_abonament_activ -> ' || v_ok || ' (1=activ, 0=inactiv, 2=nu exista)');

  -- 4) ruleaza generare playlist
  DBMS_OUTPUT.PUT_LINE('--- Rulez generare_playlist(feeling=energetic, durata_max=600) ---');
  pkg_construire_playlist.generare_playlist(
    p_id_utilizator => v_uid,
    p_feeling       => 'energetic',
    p_durata_maxima => 600
  );

  -- 5) gaseste ultimul playlist creat de user cu prefix playlist-
  SELECT id_playlist, denumire, nr_melodii, durata
  INTO v_pid, v_pname, v_nr, v_dur
  FROM (
    SELECT p.id_playlist, p.denumire, p.nr_melodii, p.durata
    FROM playlist p
    WHERE p.id_creator = v_uid
      AND p.denumire LIKE 'playlist-%'
    ORDER BY p.id_playlist DESC
  )
  WHERE ROWNUM = 1;

  DBMS_OUTPUT.PUT_LINE('Ultimul playlist creat: id=' || v_pid || ', nume=' || v_pname);
  DBMS_OUTPUT.PUT_LINE('DB playlist -> nr_melodii=' || NVL(v_nr,0) || ', durata=' || NVL(v_dur,0));

  -- 6) listeaza melodiile din playlist
  DBMS_OUTPUT.PUT_LINE('--- Melodii din playlist (din DB) ---');
  FOR r IN (
    SELECT m.id_melodie, m.nume, m.durata
    FROM playlist_melodie pm
    JOIN melodie m ON m.id_melodie = pm.id_melodie
    WHERE pm.id_playlist = v_pid
    ORDER BY m.id_melodie
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('  #' || r.id_melodie || ' | ' || r.nume || ' | durata=' || NVL(r.durata,0));
  END LOOP;

  -- 7) test direct statistici_playlist: construiesc lista din DB si apelez functia
  FOR r IN (
    SELECT m.id_melodie, NVL(m.durata,0) AS durata
    FROM playlist_melodie pm
    JOIN melodie m ON m.id_melodie = pm.id_melodie
    WHERE pm.id_playlist = v_pid
  ) LOOP
    v_lista.EXTEND;
    v_lista(v_lista.COUNT).id_melodie := r.id_melodie;
    v_lista(v_lista.COUNT).durata := r.durata;
  END LOOP;

  v_stats := pkg_construire_playlist.statistici_playlist(v_lista);
  DBMS_OUTPUT.PUT_LINE('--- statistici_playlist(pe lista din DB) ---');
  DBMS_OUTPUT.PUT_LINE('durata=' || NVL(v_stats.durata,0) ||
                       ', streamuri_totale=' || NVL(v_stats.streamuri_totale,0) ||
                       ', artist_top(id)=' || NVL(v_stats.artist_top, -1));

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Eroare: nu am gasit user/playlist/abonament pentru datele de test.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Eroare neasteptata: ' || SQLERRM);
END;
/
