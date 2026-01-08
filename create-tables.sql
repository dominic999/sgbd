ALTER SESSION SET CURRENT_SCHEMA = sgbd;

CREATE TABLE artist (
  id_artist NUMBER GENERATED ALWAYS AS IDENTITY,
  nume VARCHAR2(64) NOT NULL,
  nr_streamuri NUMBER,
  CONSTRAINT pk_artist PRIMARY KEY (id_artist)
);

CREATE TABLE album (
  id_album NUMBER GENERATED ALWAYS AS IDENTITY,
  nume VARCHAR2(64) NOT NULL,
  nr_streamuri NUMBER,
  nr_melodii NUMBER,
  imagine VARCHAR2(128),
  durata NUMBER,
  CONSTRAINT pk_album PRIMARY KEY (id_album)
);

CREATE TABLE album_artist (
  id_album_artist NUMBER GENERATED ALWAYS AS IDENTITY,
  id_artist NUMBER NOT NULL,
  id_album NUMBER NOT NULL,
  artist_principal NUMBER(1) NOT NULL
    CONSTRAINT chk_album_artist_principal CHECK (artist_principal IN (0,1)),
  CONSTRAINT pk_album_artist PRIMARY KEY (id_album_artist),
  CONSTRAINT fk_album_artist_album FOREIGN KEY (id_album)
    REFERENCES album(id_album)
    ON DELETE CASCADE,
  CONSTRAINT fk_album_artist_artist FOREIGN KEY (id_artist)
    REFERENCES artist(id_artist)
    ON DELETE CASCADE
);

CREATE TABLE melodie (
  id_melodie NUMBER GENERATED ALWAYS AS IDENTITY,
  id_album NUMBER,
  nume VARCHAR2(64) NOT NULL,
  nr_likeuri NUMBER,
  nr_dislikeuri NUMBER,
  nr_streamuri NUMBER,
  nr_downloaduri NUMBER,
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

CREATE TABLE abonament (
  id_abonament NUMBER GENERATED ALWAYS AS IDENTITY,
  data_incepere DATE DEFAULT SYSDATE,
  data_innoire DATE DEFAULT SYSDATE,
  status VARCHAR2(16) CHECK (status IN ('activ', 'suspendat', 'neplatit')),
  CONSTRAINT pk_abonament PRIMARY KEY (id_abonament)
);

CREATE TABLE utilizator (
  id_utilizator NUMBER GENERATED ALWAYS AS IDENTITY,
  nume VARCHAR2(64) NOT NULL,
  prenume VARCHAR2(64) NOT NULL,
  data_inregistrare DATE DEFAULT SYSDATE,
  email VARCHAR2(64) UNIQUE NOT NULL,
  parola VARCHAR2(128) UNIQUE,
  id_melodie_ascultata NUMBER,
  id_abonament NUMBER NOT NULL,
  CONSTRAINT pk_utilizator PRIMARY KEY (id_utilizator),
  CONSTRAINT fk_utilizator_melodie_ascultata FOREIGN KEY (id_melodie_ascultata)
    REFERENCES melodie(id_melodie),
  CONSTRAINT fk_utilizator_abonament FOREIGN KEY (id_abonament)
    REFERENCES abonament(id_abonament)
);

CREATE TABLE playlist (
  id_playlist NUMBER GENERATED ALWAYS AS IDENTITY,
  id_creator NUMBER NOT NULL,
  denumire VARCHAR2(32) NOT NULL,
  nr_melodii NUMBER,
  durata NUMBER,
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

CREATE TABLE melodie_downloadata_utilizator (
  id_melodie_downloadata_utilizator NUMBER GENERATED ALWAYS AS IDENTITY,
  id_melodie_downloadata NUMBER NOT NULL,
  id_utilizator NUMBER NOT NULL,
  timp_de_ascultare_lunar NUMBER,
  CONSTRAINT pk_melodie_downloadata_utilizator PRIMARY KEY (id_melodie_downloadata_utilizator),
  CONSTRAINT fk_melodie_downloadata FOREIGN KEY (id_melodie_downloadata)
    REFERENCES melodie(id_melodie),
  CONSTRAINT fk_utilizator_melodie FOREIGN KEY (id_utilizator)
    REFERENCES utilizator(id_utilizator)
);


