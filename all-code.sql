-- 4
ALTER SESSION SET CURRENT_SCHEMA = sgbd;

CREATE TABLE artist (
  id_artist NUMBER GENERATED ALWAYS AS IDENTITY,
  nume VARCHAR2(64) NOT NULL,
  imagine VARCHAR2(256) NOT NULL,
  CONSTRAINT pk_artist PRIMARY KEY (id_artist)
);

CREATE TABLE album (
  id_album NUMBER GENERATED ALWAYS AS IDENTITY,
  nume VARCHAR2(64) NOT NULL,
  imagine VARCHAR2(256) NOT NULL,
  CONSTRAINT pk_album PRIMARY KEY (id_album)
);

CREATE TABLE melodie (
  id_melodie NUMBER GENERATED ALWAYS AS IDENTITY,
  id_album NUMBER,
  nume VARCHAR2(64) NOT NULL,
  durata NUMBER,
  CONSTRAINT pk_melodie PRIMARY KEY (id_melodie),
  CONSTRAINT fk_album_melodie FOREIGN KEY (id_album)
    REFERENCES album(id_album)
);

CREATE TABLE melodie_artist (
  id_melodie_artist NUMBER GENERATED ALWAYS AS IDENTITY,
  id_melodie NUMBER NOT NULL,
  id_artist NUMBER NOT NULL,
  artist_principal NUMBER(1) NOT NULL
    CONSTRAINT chk_melodie_artist_principal CHECK (artist_principal IN (0,1)),
  CONSTRAINT pk_melodie_artist PRIMARY KEY (id_melodie_artist),
  CONSTRAINT fk_melodie_artist_artist FOREIGN KEY (id_artist)
    REFERENCES artist(id_artist)
    ON DELETE CASCADE,
  CONSTRAINT fk_melodie_artist_melodie FOREIGN KEY (id_melodie)
    REFERENCES melodie(id_melodie)
    ON DELETE CASCADE
);

CREATE TABLE gen (
  id_gen NUMBER GENERATED ALWAYS AS IDENTITY,
  denumire VARCHAR2(32) NOT NULL,
  CONSTRAINT pk_gen PRIMARY KEY (id_gen)
);

CREATE TABLE gen_album (
  id_gen_album NUMBER GENERATED ALWAYS AS IDENTITY,
  id_gen NUMBER NOT NULL,
  id_album NUMBER NOT NULL,
  CONSTRAINT pk_gen_album PRIMARY KEY (id_gen_album),
  CONSTRAINT fk_album_gen FOREIGN KEY (id_album)
    REFERENCES album(id_album)
    ON DELETE CASCADE,
  CONSTRAINT fk_gen_album FOREIGN KEY (id_gen)
    REFERENCES gen(id_gen)
    ON DELETE CASCADE
);


CREATE TABLE utilizator (
  id_utilizator NUMBER GENERATED ALWAYS AS IDENTITY,
  nume VARCHAR2(64) NOT NULL,
  prenume VARCHAR2(64) NOT NULL,
  data_inregistrare DATE DEFAULT SYSDATE,
  email VARCHAR2(64) UNIQUE NOT NULL,
  parola VARCHAR2(128) UNIQUE,
  CONSTRAINT pk_utilizator PRIMARY KEY (id_utilizator)
);

CREATE TABLE abonament (
  id_abonament NUMBER GENERATED ALWAYS AS IDENTITY,
  id_utilizator NUMBER NOT NULL,
  data_start DATE DEFAULT SYSDATE,
  data_stop DATE DEFAULT NULL,
  status VARCHAR2(16) CHECK (status IN ('activ', 'inactiv')),
  CONSTRAINT pk_abonament PRIMARY KEY (id_abonament),
  CONSTRAINT fk_detinator_abonament FOREIGN KEY (id_utilizator)
    REFERENCES utilizator(id_utilizator)
);

CREATE TABLE playlist (
  id_playlist NUMBER GENERATED ALWAYS AS IDENTITY,
  id_creator NUMBER NOT NULL,
  denumire VARCHAR2(32) NOT NULL,
  nr_streamuri NUMBER,
  CONSTRAINT pk_playlist PRIMARY KEY (id_playlist),
  CONSTRAINT fk_creator FOREIGN KEY (id_creator)
    REFERENCES utilizator(id_utilizator)
);

CREATE TABLE playlist_melodie (
  id_playlist_melodie NUMBER GENERATED ALWAYS AS IDENTITY,
  id_melodie NUMBER NOT NULL,
  id_playlist NUMBER NOT NULL,
  CONSTRAINT pk_playlist_melodie PRIMARY KEY (id_playlist_melodie),
  CONSTRAINT fk_melodie FOREIGN KEY (id_melodie)
    REFERENCES melodie(id_melodie)
    ON DELETE CASCADE,
  CONSTRAINT fk_playlist FOREIGN KEY (id_playlist)
    REFERENCES playlist(id_playlist)
    ON DELETE CASCADE
);

CREATE TABLE feeling (
  id_feeling NUMBER GENERATED ALWAYS AS IDENTITY,
  denumire VARCHAR2(32) NOT NULL,
  CONSTRAINT pk_feeling PRIMARY KEY (id_feeling)
);

CREATE TABLE feeling_melodie (
  id_feeling_melodie NUMBER GENERATED ALWAYS AS IDENTITY,
  id_feeling NUMBER NOT NULL,
  id_melodie NUMBER NOT NULL,
  CONSTRAINT pk_feeling_melodie PRIMARY KEY (id_feeling_melodie),
  CONSTRAINT fk_melodie_feeling FOREIGN KEY (id_melodie)
    REFERENCES melodie(id_melodie)
    ON DELETE CASCADE,
  CONSTRAINT fk_feeling_melodie FOREIGN KEY (id_feeling)
    REFERENCES feeling(id_feeling)
    ON DELETE CASCADE
);

CREATE TABLE melodie_ascultata_utilizator (
  id_melodie_ascultata_utilizator NUMBER GENERATED ALWAYS AS IDENTITY,
  id_melodie_ascultata NUMBER NOT NULL,
  id_utilizator NUMBER NOT NULL,
  timp_de_ascultare_lunar NUMBER,
  liked NUMBER NOT NULL
    CONSTRAINT chk_utilizator_liked CHECK (liked IN (0,1)),
  disliked NUMBER NOT NULL
    CONSTRAINT chk_utilizator_disliked CHECK (disliked IN (0,1)),
  download NUMBER NOT NULL
    CONSTRAINT chk_utilizator_downloaded CHECK (download IN (0,1)),
  streamuri NUMBER,
  CONSTRAINT pk_melodie_ascultata_utilizator PRIMARY KEY (id_melodie_ascultata_utilizator),
  CONSTRAINT fk_melodie_ascultata FOREIGN KEY (id_melodie_ascultata)
    REFERENCES melodie(id_melodie),
  CONSTRAINT fk_utilizator_melodie FOREIGN KEY (id_utilizator)
    REFERENCES utilizator(id_utilizator)
);

-- asta este procedura pentru ca la inceputul lunii sa se reseteze timpul de ascultare
CREATE OR REPLACE PROCEDURE resetare_timp_ascultare_lunar
IS
BEGIN
  UPDATE melodie_ascultata_utilizator
  SET timp_de_ascultare_lunar = 0;
END;
/



BEGIN
  DBMS_SCHEDULER.CREATE_JOB(
    job_name => 'resetare_timp_ascultare',
    job_type => 'PLSQL_BLOCK',
    job_action => 'BEGIN
        resetare_timp_ascultare_lunar();
      END;
      ',
    start_date => SYSTIMESTAMP, 
    repeat_interval => 'FREQ=MONTHLY; BYMONTHDAY=1; BYHOUR=0; BYMINUTE=0' ,
    enabled => TRUE
  );
END;
/


-- 5
ALTER SESSION SET CURRENT_SCHEMA = sgbd;

--aici incep inserturile pentru artist
INSERT INTO artist (nume, imagine) VALUES ('Andrei Nova', 'imagine.jpg');
INSERT INTO artist (nume, imagine) VALUES ('Mara Vibes', 'imagine.jpg');
INSERT INTO artist (nume, imagine) VALUES ('Kira Pulse', 'imagine.jpg');
INSERT INTO artist (nume, imagine) VALUES ('Radu Echo', 'imagine.jpg');
INSERT INTO artist (nume, imagine) VALUES ('Luna Grey', 'imagine.jpg');
INSERT INTO artist (nume, imagine) VALUES ('Vlad Tempo', 'imagine.jpg');
INSERT INTO artist (nume, imagine) VALUES ('Daria Bloom', 'imagine.jpg');
INSERT INTO artist (nume, imagine) VALUES ('Sorin Drift', 'imagine.jpg');
INSERT INTO artist (nume, imagine) VALUES ('The Weeknd', 'imagine.jpg');
INSERT INTO artist (nume, imagine) VALUES ('Daft Punk', 'imagine.jpg');

--aici incep inserturile pentru albume
INSERT INTO album (nume, imagine) VALUES ('Neon Nights', 'Neon Nights.jpg');
INSERT INTO album (nume, imagine) VALUES ('Midnight Drive', 'Midnight Drive.jpg');
INSERT INTO album (nume, imagine) VALUES ('Ocean Lines', 'Ocean Lines.jpg');
INSERT INTO album (nume, imagine) VALUES ('City Lights', 'City Lights.jpg');
INSERT INTO album (nume, imagine) VALUES ('Dark Bloom', 'Dark Bloom.jpg');
INSERT INTO album (nume, imagine) VALUES ('Pulse Theory', 'pulsetheory.jpg');
INSERT INTO album (nume, imagine) VALUES ('Golden Hour', 'goldenhour.jpg');
INSERT INTO album (nume, imagine) VALUES ('Afterglow', 'afterglow.jpg');

--aici incep inserturile pentru genuri
INSERT INTO gen (denumire) VALUES ('pop');
INSERT INTO gen (denumire) VALUES ('hip-hop');
INSERT INTO gen (denumire) VALUES ('rock');
INSERT INTO gen (denumire) VALUES ('electronic');
INSERT INTO gen (denumire) VALUES ('jazz');
INSERT INTO gen (denumire) VALUES ('indie');
INSERT INTO gen (denumire) VALUES ('lofi');
INSERT INTO gen (denumire) VALUES ('classical');

--aici incep inserturile pentru feelinguri
INSERT INTO feeling (denumire) VALUES ('happy');
INSERT INTO feeling (denumire) VALUES ('sad');
INSERT INTO feeling (denumire) VALUES ('motivated');
INSERT INTO feeling (denumire) VALUES ('chill');
INSERT INTO feeling (denumire) VALUES ('romantic');
INSERT INTO feeling (denumire) VALUES ('energetic');
INSERT INTO feeling (denumire) VALUES ('focused');
INSERT INTO feeling (denumire) VALUES ('nostalgic');

--aici incep inserturile pentru utilizatori
INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola)
VALUES ('Popescu','Alex', DATE '2025-12-02', 'alex.popescu@demo.ro', 'parola_A1!');

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola)
VALUES ('Ionescu','Mara', DATE '2025-11-16', 'mara.ionescu@demo.ro', 'parola_B2!');

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola)
VALUES ('Stan','Radu', DATE '2025-10-11', 'radu.stan@demo.ro', 'parola_C3!');

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola)
VALUES ('Marin','Daria', DATE '2025-12-21', 'daria.marin@demo.ro', 'parola_D4!');

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola)
VALUES ('Georgescu','Vlad', DATE '2025-09-06', 'vlad.georgescu@demo.ro', 'parola_E5!');

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola)
VALUES ('Dumitru','Kira', DATE '2025-12-26', 'kira.dumitru@demo.ro', 'parola_F6!');

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola)
VALUES ('Matei','Sorin', DATE '2025-08-02', 'sorin.matei@demo.ro', 'parola_G7!');

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola)
VALUES ('Enache','Luna', DATE '2025-12-31', 'luna.enache@demo.ro', 'parola_H8!');


--aici incep inserturile pentru abonamente
-- Alex Popescu - activ
INSERT INTO abonament (id_utilizator, data_start, data_stop, status)
VALUES (
  (SELECT id_utilizator FROM utilizator WHERE email = 'alex.popescu@demo.ro'),
  DATE '2025-12-01',
  NULL,
  'activ'
);

-- Mara Ionescu - inactiv (a avut în 15.11 - 15.12)
INSERT INTO abonament (id_utilizator, data_start, data_stop, status)
VALUES (
  (SELECT id_utilizator FROM utilizator WHERE email = 'mara.ionescu@demo.ro'),
  DATE '2025-11-15',
  DATE '2025-12-15',
  'inactiv'
);

-- Radu Stan - inactiv (10.10 - 10.11)
INSERT INTO abonament (id_utilizator, data_start, data_stop, status)
VALUES (
  (SELECT id_utilizator FROM utilizator WHERE email = 'radu.stan@demo.ro'),
  DATE '2025-10-10',
  DATE '2025-11-10',
  'inactiv'
);

-- Daria Marin - activ din 20.12
INSERT INTO abonament (id_utilizator, data_start, data_stop, status)
VALUES (
  (SELECT id_utilizator FROM utilizator WHERE email = 'daria.marin@demo.ro'),
  DATE '2025-12-20',
  NULL,
  'activ'
);

-- Vlad Georgescu - inactiv (05.09 - 05.10)
INSERT INTO abonament (id_utilizator, data_start, data_stop, status)
VALUES (
  (SELECT id_utilizator FROM utilizator WHERE email = 'vlad.georgescu@demo.ro'),
  DATE '2025-09-05',
  DATE '2025-10-05',
  'inactiv'
);

-- Kira Dumitru - activ din 25.12
INSERT INTO abonament (id_utilizator, data_start, data_stop, status)
VALUES (
  (SELECT id_utilizator FROM utilizator WHERE email = 'kira.dumitru@demo.ro'),
  DATE '2025-12-25',
  NULL,
  'activ'
);

-- Sorin Matei - inactiv (01.08 - 01.09)
INSERT INTO abonament (id_utilizator, data_start, data_stop, status)
VALUES (
  (SELECT id_utilizator FROM utilizator WHERE email = 'sorin.matei@demo.ro'),
  DATE '2025-08-01',
  DATE '2025-09-01',
  'inactiv'
);

-- Luna Enache - activ din 30.12
INSERT INTO abonament (id_utilizator, data_start, data_stop, status)
VALUES (
  (SELECT id_utilizator FROM utilizator WHERE email = 'luna.enache@demo.ro'),
  DATE '2025-12-30',
  NULL,
  'activ'
);


--aici incep inserturile pentru melodii
INSERT INTO melodie (id_album, nume, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Neon Nights'), 'Neon Heart', 215);

INSERT INTO melodie (id_album, nume, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Midnight Drive'), 'Highway Rain', 198);

INSERT INTO melodie (id_album, nume, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Ocean Lines'), 'Ocean Ink', 242);

INSERT INTO melodie (id_album, nume, durata)
VALUES ((SELECT id_album FROM album WHERE nume='City Lights'), 'City Runner', 205);

INSERT INTO melodie (id_album, nume, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Dark Bloom'), 'Dark Petals', 233);

INSERT INTO melodie (id_album, nume, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Pulse Theory'), 'Pulse Loop', 220);

INSERT INTO melodie (id_album, nume, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Golden Hour'), 'Golden Sky', 208);

INSERT INTO melodie (id_album, nume, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Afterglow'), 'Afterglow Whisper', 236);

INSERT INTO melodie (id_album, nume, durata) VALUES (NULL, 'Blinding Lights', 200);

-- aici incep inserturile pentru playlist
INSERT INTO playlist (id_creator, denumire, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='alex.popescu@demo.ro'), 'Morning Boost', 180000);

INSERT INTO playlist (id_creator, denumire, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='mara.ionescu@demo.ro'), 'Late Night', 145000);

INSERT INTO playlist (id_creator, denumire, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='radu.stan@demo.ro'), 'Study Mode', 210000);

INSERT INTO playlist (id_creator, denumire, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='daria.marin@demo.ro'), 'Gym Hits', 260000);

INSERT INTO playlist (id_creator, denumire, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='vlad.georgescu@demo.ro'), 'Rainy Days', 98000);

INSERT INTO playlist (id_creator, denumire, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='kira.dumitru@demo.ro'), 'Road Trip', 175000);

INSERT INTO playlist (id_creator, denumire, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='sorin.matei@demo.ro'), 'Chill Vibes', 132000);

INSERT INTO playlist (id_creator, denumire, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='luna.enache@demo.ro'), 'Top 2025', 310000);


-- aici incep inserturile pentru melodie_artist
INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Neon Heart'),
        (SELECT id_artist FROM artist WHERE nume='Andrei Nova'), 1);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Highway Rain'),
        (SELECT id_artist FROM artist WHERE nume='Mara Vibes'), 1);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Ocean Ink'),
        (SELECT id_artist FROM artist WHERE nume='Kira Pulse'), 1);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='City Runner'),
        (SELECT id_artist FROM artist WHERE nume='Radu Echo'), 1);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Dark Petals'),
        (SELECT id_artist FROM artist WHERE nume='Luna Grey'), 1);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Pulse Loop'),
        (SELECT id_artist FROM artist WHERE nume='Vlad Tempo'), 1);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Golden Sky'),
        (SELECT id_artist FROM artist WHERE nume='Daria Bloom'), 1);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Afterglow Whisper'),
        (SELECT id_artist FROM artist WHERE nume='Sorin Drift'), 1);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Neon Heart'),
        (SELECT id_artist FROM artist WHERE nume='Mara Vibes'), 0);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='City Runner'),
        (SELECT id_artist FROM artist WHERE nume='Vlad Tempo'), 0);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Golden Sky'),
        (SELECT id_artist FROM artist WHERE nume='Andrei Nova'), 0);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Highway Rain'),
        (SELECT id_artist FROM artist WHERE nume='Radu Echo'), 0);

INSERT INTO melodie_artist (id_melodie, id_artist, artist_principal)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Blinding Lights'),
        (SELECT id_artist FROM artist WHERE nume='The Weeknd'), 1);

INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='electronic'), (SELECT id_album FROM album WHERE nume='Neon Nights'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='electronic'), (SELECT id_album FROM album WHERE nume='Midnight Drive'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='indie'),      (SELECT id_album FROM album WHERE nume='Ocean Lines'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='hip-hop'),    (SELECT id_album FROM album WHERE nume='City Lights'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='pop'),        (SELECT id_album FROM album WHERE nume='Dark Bloom'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='electronic'), (SELECT id_album FROM album WHERE nume='Pulse Theory'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='pop'),        (SELECT id_album FROM album WHERE nume='Golden Hour'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='indie'),      (SELECT id_album FROM album WHERE nume='Afterglow'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='lofi'),       (SELECT id_album FROM album WHERE nume='Neon Nights'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='lofi'),       (SELECT id_album FROM album WHERE nume='Ocean Lines'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='hip-hop'),    (SELECT id_album FROM album WHERE nume='Midnight Drive'));
INSERT INTO gen_album (id_gen, id_album) VALUES ((SELECT id_gen FROM gen WHERE denumire='electronic'), (SELECT id_album FROM album WHERE nume='Golden Hour'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Neon Heart'),
        (SELECT id_playlist FROM playlist WHERE denumire='Morning Boost'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Blinding Lights'),
        (SELECT id_playlist FROM playlist WHERE denumire='Morning Boost'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Highway Rain'),
        (SELECT id_playlist FROM playlist WHERE denumire='Morning Boost'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Ocean Ink'),
        (SELECT id_playlist FROM playlist WHERE denumire='Late Night'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='City Runner'),
        (SELECT id_playlist FROM playlist WHERE denumire='Late Night'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Dark Petals'),
        (SELECT id_playlist FROM playlist WHERE denumire='Study Mode'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Pulse Loop'),
        (SELECT id_playlist FROM playlist WHERE denumire='Study Mode'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Golden Sky'),
        (SELECT id_playlist FROM playlist WHERE denumire='Gym Hits'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Afterglow Whisper'),
        (SELECT id_playlist FROM playlist WHERE denumire='Gym Hits'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Neon Heart'),
        (SELECT id_playlist FROM playlist WHERE denumire='Rainy Days'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Ocean Ink'),
        (SELECT id_playlist FROM playlist WHERE denumire='Road Trip'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Pulse Loop'),
        (SELECT id_playlist FROM playlist WHERE denumire='Chill Vibes'));

INSERT INTO playlist_melodie (id_melodie, id_playlist)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Afterglow Whisper'),
        (SELECT id_playlist FROM playlist WHERE denumire='Top 2025'));


--aici incep inserturile feeling_melodie
INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='energetic'),
        (SELECT id_melodie FROM melodie WHERE nume='Neon Heart'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='chill'),
        (SELECT id_melodie FROM melodie WHERE nume='Highway Rain'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='nostalgic'),
        (SELECT id_melodie FROM melodie WHERE nume='Ocean Ink'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='motivated'),
        (SELECT id_melodie FROM melodie WHERE nume='City Runner'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='sad'),
        (SELECT id_melodie FROM melodie WHERE nume='Dark Petals'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='energetic'),
        (SELECT id_melodie FROM melodie WHERE nume='Pulse Loop'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='happy'),
        (SELECT id_melodie FROM melodie WHERE nume='Golden Sky'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='romantic'),
        (SELECT id_melodie FROM melodie WHERE nume='Afterglow Whisper'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='focused'),
        (SELECT id_melodie FROM melodie WHERE nume='Ocean Ink'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='chill'),
        (SELECT id_melodie FROM melodie WHERE nume='Pulse Loop'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='nostalgic'),
        (SELECT id_melodie FROM melodie WHERE nume='Highway Rain'));

INSERT INTO feeling_melodie (id_feeling, id_melodie)
VALUES ((SELECT id_feeling FROM feeling WHERE denumire='motivated'),
        (SELECT id_melodie FROM melodie WHERE nume='Golden Sky'));

--aici incep inserturuile pentru melodii ascultate
INSERT INTO melodie_ascultata_utilizator
(id_melodie_ascultata, id_utilizator, timp_de_ascultare_lunar, liked, disliked, download, streamuri)
VALUES (
  (SELECT id_melodie FROM melodie WHERE nume='Neon Heart'),
  (SELECT id_utilizator FROM utilizator WHERE email='alex.popescu@demo.ro'),
  3600, 1, 0, 1, 10
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Highway Rain'),
  (SELECT id_utilizator FROM utilizator WHERE email='alex.popescu@demo.ro'),
  2100, 0, 1, 0, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Ocean Ink'),
  (SELECT id_utilizator FROM utilizator WHERE email='mara.ionescu@demo.ro'),
  1800, 1, 0, 0, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='City Runner'),
  (SELECT id_utilizator FROM utilizator WHERE email='mara.ionescu@demo.ro'),
  2400, 0, 0, 1, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Dark Petals'),
  (SELECT id_utilizator FROM utilizator WHERE email='radu.stan@demo.ro'),
  900, 0, 1, 1, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Pulse Loop'),
  (SELECT id_utilizator FROM utilizator WHERE email='radu.stan@demo.ro'),
  2700, 1, 0, 1, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Golden Sky'),
  (SELECT id_utilizator FROM utilizator WHERE email='daria.marin@demo.ro'),
  3200, 1, 0, 1, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Afterglow Whisper'),
  (SELECT id_utilizator FROM utilizator WHERE email='daria.marin@demo.ro'),
  1500, 0, 0, 0, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Neon Heart'),
  (SELECT id_utilizator FROM utilizator WHERE email='vlad.georgescu@demo.ro'),
  600, 0, 1, 0, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Highway Rain'),
  (SELECT id_utilizator FROM utilizator WHERE email='kira.dumitru@demo.ro'),
  1100, 1, 0, 1, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Pulse Loop'),
  (SELECT id_utilizator FROM utilizator WHERE email='sorin.matei@demo.ro'),
  2000, 0, 0, 1, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Golden Sky'),
  (SELECT id_utilizator FROM utilizator WHERE email='luna.enache@demo.ro'),
  2600, 1, 0, 0, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Blinding Lights'),
  (SELECT id_utilizator FROM utilizator WHERE email='alex.popescu@demo.ro'),
  1800, 0, 0, 1, 20
);

INSERT INTO melodie_ascultata_utilizator
VALUES (
  DEFAULT,
  (SELECT id_melodie FROM melodie WHERE nume='Blinding Lights'),
  (SELECT id_utilizator FROM utilizator WHERE email='luna.enache@demo.ro'),
  1800, 0, 0, 1, 20
);


-- asta este insertul pentru a testa o exceptie
insert into melodie_artist (id_melodie, id_artist, artist_principal)
values (
  (select id_melodie from melodie where nume = 'Neon Heart'),
  (select id_artist  from artist  where nume = 'Mara Vibes'),
  1
);

COMMIT;


--6
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
    NVL(ma.timp_de_ascultare_lunar, 0) as timp 
    FROM melodie_ascultata_utilizator ma
    LEFT JOIN melodie m 
    ON ma.id_melodie_ascultata = m.id_melodie
    WHERE ma.id_utilizator = p_id_utilizator
    ORDER BY NVL(ma.timp_de_ascultare_lunar, 0) DESC, m.id_melodie ASC
    FETCH FIRST 3 ROWS ONLY
     
  ) LOOP 

    i := i+1;

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


-- 7
ALTER SESSION SET CURRENT_SCHEMA = sgbd;

CREATE OR REPLACE PROCEDURE gaseste_playlisturile_utilizatorului (
  p_id_creator_playlist IN NUMBER
) IS

  
  v_nume_melodie VARCHAR2(32);
  v_nume_playlist VARCHAR2(32);
  v_id_playlist NUMBER;
  v_id_melodie NUMBER;
  v_nr_streamuri NUMBER;
  i NUMBER := 1;
  j NUMBER := 1;

  CURSOR playlisturi IS
    SELECT id_playlist, denumire FROM playlist WHERE id_creator = p_id_creator_playlist; 
  CURSOR melodii_playlist (p_id_playlist NUMBER) IS
    SELECT m.nume, m.id_melodie, SUM(ma.streamuri) from playlist_melodie pm
    LEFT JOIN melodie m ON pm.id_melodie = m.id_melodie
    LEFT JOIN melodie_ascultata_utilizator ma ON pm.id_melodie = ma.id_melodie_ascultata
    WHERE pm.id_playlist = p_id_playlist
    GROUP BY m.nume, m.id_melodie
    ORDER BY SUM(ma.streamuri) DESC
    ;

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
        FETCH melodii_playlist into v_nume_melodie, v_id_melodie, v_nr_streamuri;
        
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
  gaseste_playlisturile_utilizatorului(1);
END;
/

-- 8
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
      ma.id_melodie_ascultata AS id_melodie,
      ma.timp_de_ascultare_lunar AS timp_ascultare
    FROM melodie_ascultata_utilizator ma
    WHERE ma.id_utilizator = p_id_utilizator
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

    DBMS_OUTPUT.PUT_LINE(v_nume_artist || ' | nume_melodie ' || v_nume_melodie || ' | ' || rec.timp_ascultare || ' sec');
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
  DBMS_OUTPUT.PUT_LINE('Artist Preferat: ' || v_artist_preferat);

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

--asta ma astepts sa dea too many rows 
DECLARE
  v VARCHAR2(32);
BEGIN
  v := artist_preferat(1);
  DBMS_OUTPUT.PUT_LINE('Return: ' || NVL(v,'(NULL)'));
END;
/

--asta ma astept sa dea no data found
DECLARE
  v VARCHAR2(32);
BEGIN
  v := artist_preferat(910);
  DBMS_OUTPUT.PUT_LINE('Return: ' || NVL(v,'(NULL)'));
END;
/

--asta ma astept sa dea bine
DECLARE
  v VARCHAR2(32);
BEGIN
  v := artist_preferat(2);
  DBMS_OUTPUT.PUT_LINE('Return: ' || NVL(v,'(NULL)'));
END;
/


-- 9
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
  LEFT JOIN abonament a ON a.id_utilizator = u.id_utilizator
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

-- aici introduc o melodie cu scucces
DECLARE
  v_uid NUMBER;
  v_pid NUMBER;
  v_mid NUMBER;
BEGIN

  SELECT id_utilizator INTO v_uid FROM utilizator WHERE email = 'alex.popescu@demo.ro';
  SELECT id_playlist   INTO v_pid FROM playlist   WHERE denumire = 'Morning Boost';
  SELECT id_melodie    INTO v_mid FROM melodie    WHERE nume = 'Dark Petals';

  adaugare_melodie(v_uid, v_pid, v_mid);

END;
/

SELECT p.denumire, m.nume
FROM playlist_melodie pm
JOIN playlist p ON p.id_playlist = pm.id_playlist
JOIN melodie  m ON m.id_melodie  = pm.id_melodie
WHERE p.denumire = 'Morning Boost'
ORDER BY m.nume;

-- aici incerc sa introduc o melodie care deja este in playlist
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

-- aici utilizatorul nu mai are abonament, deci nu poate sa introduca melodie
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

-- aici incerc sa introduc o melodie intr un playlist ce nu imi apartine
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


-- 10
ALTER SESSION SET CURRENT_SCHEMA = sgbd;

CREATE OR REPLACE TRIGGER protejare_delete_utitlizator
BEFORE DELETE ON utilizator
BEGIN
  IF SYS_CONTEXT('USERENV','SESSION_USER') <> 'ADMIN' THEN
      RAISE_APPLICATION_ERROR(-20030, 'Stergerea de utilizatori este interzisa daca nu esti admin');
  END IF;

END;
/

DELETE FROM utilizator;


-- 11
ALTER SESSION SET CURRENT_SCHEMA = sgbd;

-- asta este un trigger care se asigura ca nu poti sa ai si dilike si dilike  
CREATE OR REPLACE TRIGGER schimbare_like
BEFORE UPDATE ON melodie_ascultata_utilizator FOR EACH ROW
BEGIN

  -- cazul in care vreau sa dau like si deja e disliked
  IF :NEW.liked = 1 AND :OLD.disliked = 1 THEN
    :NEW.disliked := 0;
  END IF;

  -- cazul in care vreau sa dau dislike si deja e liked
  IF :NEW.disliked = 1 AND :OLD.liked = 1 THEN
    :NEW.liked := 0;
  END IF;

END;
/

SELECT * FROM melodie_ascultata_utilizator 
WHERE id_melodie_ascultata_utilizator = 1;

UPDATE melodie_ascultata_utilizator
SET disliked = 1
WHERE id_melodie_ascultata_utilizator = 1;

SELECT * FROM melodie_ascultata_utilizator 
WHERE id_melodie_ascultata_utilizator = 1;


-- 12
ALTER SESSION SET CURRENT_SCHEMA = sgbd;

CREATE OR REPLACE TRIGGER protejare_structura
BEFORE DROP OR ALTER
ON SCHEMA
BEGIN
  IF SYS_CONTEXT('USERENV', 'SESSION_USER') <> 'ADMIN' THEN
    RAISE_APPLICATION_ERROR(
      -20050,
      'Modificarea structurii bazei de date este permisa doar utilizatorului ADMIN'
    );
  END IF;
END;
/

DROP TABLE utilizator;


-- 13
ALTER SESSION SET CURRENT_SCHEMA = sgbd;

CREATE OR REPLACE PACKAGE pkg_construire_playlist AS 
  
  TYPE t_record_melodie IS RECORD (
    id_melodie melodie.id_melodie%TYPE,
    durata melodie.durata%TYPE
  );

  TYPE t_list_recorduri IS TABLE OF t_record_melodie;

  TYPE t_statistici_playlist IS RECORD (
    durata melodie.durata%TYPE,
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

    SELECT a.id_abonament 
    INTO v_id_abonament
    FROM utilizator u
    JOIN abonament a ON a.id_utilizator = u.id_utilizator
    WHERE u.id_utilizator = p_id_utilizator;

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

  --AM RAMAS AICI
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

        -- gasesc nr de streamuri ale melodiei 
        SELECT SUM(streamuri) 
        INTO v_nr_streamuri
        FROM melodie_ascultata_utilizator 
        WHERE id_melodie_ascultata = p_lista_melodii(i).id_melodie;

        --aici o sa imi dea no data found daca nu are artist principal
        SELECT max(m.durata), min(ma.id_artist)
        INTO v_durata_melodie, v_id_artist
        FROM melodie m
        JOIN melodie_artist ma ON m.id_melodie = ma.id_melodie AND ma.artist_principal = 1 
        WHERE m.id_melodie = p_lista_melodii(i).id_melodie;

        -- SELECT m.nr_streamuri, m.durata,
        --        (SELECT MIN(id_artist)
        --         FROM melodie_artist
        --         WHERE id_melodie = m.id_melodie AND artist_principal = 1)
        -- INTO v_nr_streamuri, v_durata_melodie, v_id_artist
        -- FROM melodie m
        -- WHERE m.id_melodie = p_lista_melodii(i).id_melodie;

        -- aici adun durata si nr de streamuri ale melodiei curente la total
        v_durata_totala := v_durata_totala + NVL(v_durata_melodie, 0);
        v_streamuri_totale := v_streamuri_totale + NVL(v_nr_streamuri, 0);

        -- fac asta ca sa vad ce artist apare cel mai des in playlist
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

    -- aici gasesc artistul top
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

    -- aici verific abonamentul utiliaztorului
    IF verificatre_abonament_activ(p_id_utilizator) <> 1 THEN
      DBMS_OUTPUT.PUT_LINE('Utilizatorul nu exista sau nu are abonament activ');
      RETURN;
    END IF;

    -- aici gasesc idul ultimului playlist pentru a putea crea unu nou
    SELECT NVL(MAX(id_playlist), 1) INTO v_ultimul_id_playlist FROM playlist;

    -- aici il cresc cu 1 ca sa nu intru peste unul deja existent
    v_ultimul_id_playlist := v_ultimul_id_playlist + 1;
    v_nume_playlist := 'playlist-' || v_ultimul_id_playlist;

    INSERT INTO playlist(id_creator, denumire, nr_streamuri)
      VALUES (p_id_utilizator, v_nume_playlist, 0)
      RETURNING id_playlist INTO v_id_playlist;

    -- aici gasesc idul feelingului
    SELECT id_feeling 
    INTO v_id_feeling
    FROM feeling 
    WHERE denumire = p_feeling;

    -- aici iterez peste toate melodiile cu feelingul primit ca si parametru
    FOR rec in (
      SELECT m.durata AS durata_melodie, m.nume AS nume_melodie, m.id_melodie as id
      FROM feeling_melodie fm 
      JOIN melodie m ON fm.id_melodie = m.id_melodie 
      WHERE fm.id_feeling = v_id_feeling
    ) LOOP

       -- aici verific, daca as adauga melodia actuala trec peste limia primita? 
       -- daca da, ies din loop, daca nu, continui
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
  SELECT u.id_utilizator, a.id_abonament
  INTO v_uid, v_id_abonament
  FROM utilizator u
  JOIN abonament a ON a.id_utilizator = u.id_utilizator
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
  DBMS_OUTPUT.PUT_LINE('--- Rulez generare_playlist(feeling=chill, durata_max=600) ---');
  pkg_construire_playlist.generare_playlist(
    p_id_utilizator => v_uid,
    p_feeling       => 'chill',
    p_durata_maxima => 600
  );

  -- 5) gaseste ultimul playlist creat de user cu prefix playlist-
  SELECT id_playlist, denumire
  INTO v_pid, v_pname
  FROM (
    SELECT p.id_playlist, p.denumire
    FROM playlist p
    WHERE p.id_creator = v_uid
      AND p.denumire LIKE 'playlist-%'
    ORDER BY p.id_playlist DESC
  )
  WHERE ROWNUM = 1;

  SELECT SUM(m.durata), count(m.id_melodie) 
  INTO v_dur, v_nr
  FROM playlist_melodie pm
  JOIN melodie m ON pm.id_melodie = m.id_melodie
  WHERE pm.id_playlist = v_pid;

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

