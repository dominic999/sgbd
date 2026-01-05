ALTER SESSION SET CURRENT_SCHEMA = sgbd;


CREATE TABLE artist (

  id_artist NUMBER PRIMARY KEY,
  nume VARCHAR2(64) NOT NULL,
  nr_streamuri NUMBER

);

CREATE TABLE album (

  id_album NUMBER PRIMARY KEY,
  nume VARCHAR2(64) NOT NULL,
  nr_streamuri NUMBER,
  nr_melodii NUMBER,
  IMAGINE VARCHAR2(128),
  durata NUMBER

);

CREATE TABLE album_artist (
  id_album_artist NUMBER PRIMARY KEY,
  id_artist NUMBER NOT NULL,
  id_album NUMBER NOT NULL,

  artist_principal NUMBER(1) NOT NULL
    CONSTRAINT chk_album_artist_principal CHECK (artist_principal IN (0,1)),

  CONSTRAINT fk_album_artist_album FOREIGN KEY (id_album)
    REFERENCES album(id_album)
    ON DELETE CASCADE,

  CONSTRAINT fk_album_artist_artist FOREIGN KEY (id_artist)
    REFERENCES artist(id_artist)
    ON DELETE CASCADE
);

CREATE TABLE melodie (
  id_melodie NUMBER PRIMARY KEY,
  id_album NUMBER,
  nume VARCHAR2(64) NOT NULL,
  nr_likeuri NUMBER,
  nr_dislikeuri NUMBER,
  nr_streamuri NUMBER,
  nr_downloaduri NUMBER,
  durata NUMBER,

  CONSTRAINT fk_album_melodie FOREIGN KEY (id_album)
    REFERENCES album(id_album)
);

CREATE TABLE melodie_artist (
  id_melodie_artist NUMBER PRIMARY KEY,
  id_melodie NUMBER NOT NULL,
  id_artist NUMBER NOT NULL,

  artist_principal NUMBER(1) NOT NULL
    CONSTRAINT chk_melodie_artist_principal CHECK (artist_principal IN (0,1)),

  CONSTRAINT fk_melodie_artist_artist FOREIGN KEY (id_artist)
    REFERENCES artist(id_artist)
    ON DELETE CASCADE,

  CONSTRAINT fk_melodie_artist_melodie FOREIGN KEY (id_melodie)
    REFERENCES melodie(id_melodie)
    ON DELETE CASCADE
);

CREATE TABLE gen (

  id_gen NUMBER PRIMARY KEY,
  denumire VARCHAR2(32) NOT NULL

);

CREATE TABLE gen_album (
  
  id_gen_album NUMBER PRIMARY KEY,
  id_gen NUMBER NOT NULL,
  id_album NUMBER NOT NULL,

  CONSTRAINT fk_album_gen FOREIGN KEY
    (id_album) REFERENCES 
    album(id_album)
    ON DELETE CASCADE,

  CONSTRAINT fk_gen_album FOREIGN KEY
    (id_gen) REFERENCES
    gen(id_gen)
    ON DELETE CASCADE

);


CREATE TABLE abonament (

  id_abonament NUMBER PRIMARY KEY,
  data_incepere DATE DEFAULT SYSDATE,
  data_innoire DATE DEFAULT SYSDATE,
  status VARCHAR2(16) 
    CHECK (status IN ('activ', 'suspendat', 'neplatit'))

);

CREATE TABLE utilizator(

  id_utilizator   NUMBER PRIMARY KEY,
  name VARCHAR2(64) NOT NULL,
  prenume VARCHAR2(64) NOT NULL,
  email VARCHAR2(64) UNIQUE NOT NULL,
  parola VARCHAR2(128) UNIQUE,
  id_melodie_ascultata NUMBER,
  id_abonament NUMBER,

 CONSTRAINT fk_utilizator_melodie_ascultata FOREIGN KEY
  (id_melodie_ascultata) REFERENCES
  melodie(id_melodie),

 CONSTRAINT fk_utilizator_abonament FOREIGN KEY
  (id_abonament) REFERENCES
  abonament(id_abonament)
    
);

CREATE TABLE playlist (

  id_playlist NUMBER PRIMARY KEY,
  id_creator NUMBER ,
  denumire VARCHAR2(32) NOT NULL,
  nr_melodii NUMBER,
  durata NUMBER,
  nr_streamuri NUMBER,

  CONSTRAINT fk_creator FOREIGN KEY
    (id_creator) REFERENCES utilizator(id_utilizator),

);

CREATE TABLE playlist_melodie (
  
  id_playlist_melodie NUMBER PRIMARY KEY,
  id_melodie NUMBER NOT NULL,
  id_playlist NUMBER NOT NULL,

  CONSTRAINT fk_melodie FOREIGN KEY
    (id_melodie) REFERENCES melodie(id_melodie) ON DELETE CASCADE,

  CONSTRAINT fk_playlist FOREIGN KEY
    (id_playlist) REFERENCES playlist(id_playlist) ON DELETE CASCADE,

);

CREATE TABLE feeling (

  id_feeling NUMBER PRIMARY KEY,
  denumire VARCHAR2(32) NOT NULL

);

CREATE TABLE feeling_melodie (
  
  id_feeling_melodie NUMBER PRIMARY KEY,
  id_feeling NUMBER NOT NULL,
  id_melodie NUMBER NOT NULL,

  CONSTRAINT fk_melodie_feeling FOREIGN KEY
    (id_melodie) REFERENCES 
    melodie(id_melodie)
    ON DELETE CASCADE,

  CONSTRAINT fk_feeling_melodie FOREIGN KEY
    (id_feeling) REFERENCES
    feeling(id_feeling)
    ON DELETE CASCADE

);

CREATE TABLE melodie_downloadata_utilizator (

  id_melodie_downloadata_utilizator NUMBER PRIMARY KEY,
  id_melodie_downloadata NUMBER NOT NULL,
  id_utilizator NUMBER NOT NULL,

  CONSTRAINT fk_melodie_downloadata FOREIGN KEY
    (id_melodie_downloadata) REFERENCES 
    melodie(id_melodie),

  CONSTRAINT fk_utilizator_melodie FOREIGN KEY
    (id_utilizator) REFERENCES 
    utilizator(id_utilizator)

);
