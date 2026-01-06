
ALTER SESSION SET CURRENT_SCHEMA = sgbd;

-- =========================
-- 1) TABELE DE BAZA (8 randuri fiecare)
-- =========================

-- ARTIST (8)
INSERT INTO artist (id_artist, nume, nr_streamuri) VALUES (1, 'Andrei Nova', 1200000);
INSERT INTO artist (id_artist, nume, nr_streamuri) VALUES (2, 'Mara Vibes', 890000);
INSERT INTO artist (id_artist, nume, nr_streamuri) VALUES (3, 'Kira Pulse', 450000);
INSERT INTO artist (id_artist, nume, nr_streamuri) VALUES (4, 'Radu Echo', 2100000);
INSERT INTO artist (id_artist, nume, nr_streamuri) VALUES (5, 'Luna Grey', 670000);
INSERT INTO artist (id_artist, nume, nr_streamuri) VALUES (6, 'Vlad Tempo', 980000);
INSERT INTO artist (id_artist, nume, nr_streamuri) VALUES (7, 'Daria Bloom', 530000);
INSERT INTO artist (id_artist, nume, nr_streamuri) VALUES (8, 'Sorin Drift', 1500000);

-- ALBUM (8)
INSERT INTO album (id_album, nume, nr_streamuri, nr_melodii, imagine, durata)
VALUES (1, 'Neon Nights', 3200000, 8, 'neon_nights.jpg', 2480);

INSERT INTO album (id_album, nume, nr_streamuri, nr_melodii, imagine, durata)
VALUES (2, 'Midnight Drive', 2100000, 8, 'midnight_drive.png', 2310);

INSERT INTO album (id_album, nume, nr_streamuri, nr_melodii, imagine, durata)
VALUES (3, 'Ocean Lines', 1450000, 8, 'ocean_lines.webp', 2405);

INSERT INTO album (id_album, nume, nr_streamuri, nr_melodii, imagine, durata)
VALUES (4, 'City Lights', 4100000, 8, 'city_lights.jpg', 2550);

INSERT INTO album (id_album, nume, nr_streamuri, nr_melodii, imagine, durata)
VALUES (5, 'Dark Bloom', 1750000, 8, 'dark_bloom.jpg', 2260);

INSERT INTO album (id_album, nume, nr_streamuri, nr_melodii, imagine, durata)
VALUES (6, 'Pulse Theory', 2950000, 8, 'pulse_theory.png', 2420);

INSERT INTO album (id_album, nume, nr_streamuri, nr_melodii, imagine, durata)
VALUES (7, 'Golden Hour', 3600000, 8, 'golden_hour.jpg', 2495);

INSERT INTO album (id_album, nume, nr_streamuri, nr_melodii, imagine, durata)
VALUES (8, 'Afterglow', 1900000, 8, 'afterglow.webp', 2355);

-- GEN (8)
INSERT INTO gen (id_gen, denumire) VALUES (1, 'pop');
INSERT INTO gen (id_gen, denumire) VALUES (2, 'hip-hop');
INSERT INTO gen (id_gen, denumire) VALUES (3, 'rock');
INSERT INTO gen (id_gen, denumire) VALUES (4, 'electronic');
INSERT INTO gen (id_gen, denumire) VALUES (5, 'jazz');
INSERT INTO gen (id_gen, denumire) VALUES (6, 'indie');
INSERT INTO gen (id_gen, denumire) VALUES (7, 'lofi');
INSERT INTO gen (id_gen, denumire) VALUES (8, 'classical');

-- FEELING (8)
INSERT INTO feeling (id_feeling, denumire) VALUES (1, 'happy');
INSERT INTO feeling (id_feeling, denumire) VALUES (2, 'sad');
INSERT INTO feeling (id_feeling, denumire) VALUES (3, 'motivated');
INSERT INTO feeling (id_feeling, denumire) VALUES (4, 'chill');
INSERT INTO feeling (id_feeling, denumire) VALUES (5, 'romantic');
INSERT INTO feeling (id_feeling, denumire) VALUES (6, 'energetic');
INSERT INTO feeling (id_feeling, denumire) VALUES (7, 'focused');
INSERT INTO feeling (id_feeling, denumire) VALUES (8, 'nostalgic');

-- ABONAMENT (8) (pun valori explicite, nu las pe DEFAULT)
INSERT INTO abonament (id_abonament, data_incepere, data_innoire, status)
VALUES (1, DATE '2025-12-01', DATE '2026-01-01', 'activ');

INSERT INTO abonament (id_abonament, data_incepere, data_innoire, status)
VALUES (2, DATE '2025-11-15', DATE '2025-12-15', 'neplatit');

INSERT INTO abonament (id_abonament, data_incepere, data_innoire, status)
VALUES (3, DATE '2025-10-10', DATE '2025-11-10', 'suspendat');

INSERT INTO abonament (id_abonament, data_incepere, data_innoire, status)
VALUES (4, DATE '2025-12-20', DATE '2026-01-20', 'activ');

INSERT INTO abonament (id_abonament, data_incepere, data_innoire, status)
VALUES (5, DATE '2025-09-05', DATE '2025-10-05', 'neplatit');

INSERT INTO abonament (id_abonament, data_incepere, data_innoire, status)
VALUES (6, DATE '2025-12-25', DATE '2026-01-25', 'activ');

INSERT INTO abonament (id_abonament, data_incepere, data_innoire, status)
VALUES (7, DATE '2025-08-01', DATE '2025-09-01', 'suspendat');

INSERT INTO abonament (id_abonament, data_incepere, data_innoire, status)
VALUES (8, DATE '2025-12-30', DATE '2026-01-30', 'activ');

-- MELODIE (8) (neaparat dupa ALBUM)
INSERT INTO melodie (id_melodie, id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES (1, 1, 'Neon Heart', 12000, 320, 650000, 45000, 215);

INSERT INTO melodie (id_melodie, id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES (2, 2, 'Highway Rain', 9800, 210, 540000, 38000, 198);

INSERT INTO melodie (id_melodie, id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES (3, 3, 'Ocean Ink', 7600, 145, 410000, 29000, 242);

INSERT INTO melodie (id_melodie, id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES (4, 4, 'City Runner', 15000, 500, 820000, 61000, 205);

INSERT INTO melodie (id_melodie, id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES (5, 5, 'Dark Petals', 6400, 180, 360000, 24000, 233);

INSERT INTO melodie (id_melodie, id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES (6, 6, 'Pulse Loop', 13200, 260, 710000, 52000, 220);

INSERT INTO melodie (id_melodie, id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES (7, 7, 'Golden Sky', 16800, 190, 900000, 75000, 208);

INSERT INTO melodie (id_melodie, id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES (8, 8, 'Afterglow Whisper', 8800, 140, 480000, 33000, 236);

-- UTILIZATOR (8) (dupa MELODIE + ABONAMENT)
INSERT INTO utilizator (id_utilizator, nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES (1, 'Popescu', 'Alex', DATE '2025-12-02', 'alex.popescu@demo.ro', 'parola_A1!', 1, 1);

INSERT INTO utilizator (id_utilizator, nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES (2, 'Ionescu', 'Mara', DATE '2025-11-16', 'mara.ionescu@demo.ro', 'parola_B2!', 2, 2);

INSERT INTO utilizator (id_utilizator, nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES (3, 'Stan', 'Radu', DATE '2025-10-11', 'radu.stan@demo.ro', 'parola_C3!', 3, 3);

INSERT INTO utilizator (id_utilizator, nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES (4, 'Marin', 'Daria', DATE '2025-12-21', 'daria.marin@demo.ro', 'parola_D4!', 4, 4);

INSERT INTO utilizator (id_utilizator, nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES (5, 'Georgescu', 'Vlad', DATE '2025-09-06', 'vlad.georgescu@demo.ro', 'parola_E5!', 5, 5);

INSERT INTO utilizator (id_utilizator, nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES (6, 'Dumitru', 'Kira', DATE '2025-12-26', 'kira.dumitru@demo.ro', 'parola_F6!', 6, 6);

INSERT INTO utilizator (id_utilizator, nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES (7, 'Matei', 'Sorin', DATE '2025-08-02', 'sorin.matei@demo.ro', 'parola_G7!', 7, 7);

INSERT INTO utilizator (id_utilizator, nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES (8, 'Enache', 'Luna', DATE '2025-12-31', 'luna.enache@demo.ro', 'parola_H8!', 8, 8);

-- PLAYLIST (8) (dupa UTILIZATOR)
INSERT INTO playlist (id_playlist, id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES (1, 1, 'Morning Boost', 12, 2600, 180000);

INSERT INTO playlist (id_playlist, id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES (2, 2, 'Late Night', 10, 2200, 145000);

INSERT INTO playlist (id_playlist, id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES (3, 3, 'Study Mode', 14, 3000, 210000);

INSERT INTO playlist (id_playlist, id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES (4, 4, 'Gym Hits', 16, 3400, 260000);

INSERT INTO playlist (id_playlist, id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES (5, 5, 'Rainy Days', 9, 2000, 98000);

INSERT INTO playlist (id_playlist, id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES (6, 6, 'Road Trip', 13, 2900, 175000);

INSERT INTO playlist (id_playlist, id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES (7, 7, 'Chill Vibes', 11, 2400, 132000);

INSERT INTO playlist (id_playlist, id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES (8, 8, 'Top 2025', 20, 4200, 310000);


-- =========================
-- 2) TABELE ASOCIATIVE (12 randuri fiecare)
-- =========================

-- ALBUM_ARTIST (12)
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (1, 1, 1, 1);
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (2, 2, 2, 1);
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (3, 3, 3, 1);
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (4, 4, 4, 1);
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (5, 5, 5, 1);
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (6, 6, 6, 1);
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (7, 7, 7, 1);
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (8, 8, 8, 1);
-- featuring/collab
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (9, 2, 1, 0);
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (10, 4, 2, 0);
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (11, 6, 4, 0);
INSERT INTO album_artist (id_album_artist, id_artist, id_album, artist_principal) VALUES (12, 1, 7, 0);

-- MELODIE_ARTIST (12)
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (1, 1, 1, 1);
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (2, 2, 2, 1);
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (3, 3, 3, 1);
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (4, 4, 4, 1);
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (5, 5, 5, 1);
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (6, 6, 6, 1);
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (7, 7, 7, 1);
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (8, 8, 8, 1);
-- featuring/collab
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (9, 1, 2, 0);
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (10, 4, 6, 0);
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (11, 7, 1, 0);
INSERT INTO melodie_artist (id_melodie_artist, id_melodie, id_artist, artist_principal) VALUES (12, 2, 4, 0);

-- GEN_ALBUM (12)
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (1, 4, 1);
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (2, 4, 2);
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (3, 6, 3);
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (4, 2, 4);
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (5, 1, 5);
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (6, 4, 6);
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (7, 1, 7);
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (8, 6, 8);
-- extra (un album poate avea mai multe genuri)
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (9, 7, 1);
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (10, 7, 3);
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (11, 2, 2);
INSERT INTO gen_album (id_gen_album, id_gen, id_album) VALUES (12, 4, 7);

-- PLAYLIST_MELODIE (12)
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (1, 1, 1);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (2, 2, 1);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (3, 3, 2);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (4, 4, 2);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (5, 5, 3);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (6, 6, 3);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (7, 7, 4);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (8, 8, 4);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (9, 1, 5);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (10, 3, 6);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (11, 6, 7);
INSERT INTO playlist_melodie (id_playlist_melodie, id_melodie, id_playlist) VALUES (12, 8, 8);

-- FEELING_MELODIE (12)
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (1, 6, 1);
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (2, 4, 2);
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (3, 8, 3);
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (4, 3, 4);
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (5, 2, 5);
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (6, 6, 6);
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (7, 1, 7);
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (8, 5, 8);
-- extra
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (9, 7, 3);
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (10, 4, 6);
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (11, 8, 2);
INSERT INTO feeling_melodie (id_feeling_melodie, id_feeling, id_melodie) VALUES (12, 3, 7);

-- MELODIE_DOWNLOADATA_UTILIZATOR (12) (user–melodie cu timp_de_ascultare_lunar completat)
INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (1, 1, 1, 3600);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (2, 2, 1, 2100);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (3, 3, 2, 1800);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (4, 4, 2, 2400);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (5, 5, 3, 900);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (6, 6, 3, 2700);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (7, 7, 4, 3200);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (8, 8, 4, 1500);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (9, 1, 5, 600);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (10, 2, 6, 1100);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (11, 6, 7, 2000);

INSERT INTO melodie_downloadata_utilizator
(id_melodie_downloadata_utilizator, id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES (12, 7, 8, 2600);

COMMIT;
