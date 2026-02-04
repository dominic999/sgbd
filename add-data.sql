
ALTER SESSION SET CURRENT_SCHEMA = sgbd;

INSERT INTO artist (nume, nr_streamuri) VALUES ('Andrei Nova', 1200000);
INSERT INTO artist (nume, nr_streamuri) VALUES ('Mara Vibes', 890000);
INSERT INTO artist (nume, nr_streamuri) VALUES ('Kira Pulse', 450000);
INSERT INTO artist (nume, nr_streamuri) VALUES ('Radu Echo', 2100000);
INSERT INTO artist (nume, nr_streamuri) VALUES ('Luna Grey', 670000);
INSERT INTO artist (nume, nr_streamuri) VALUES ('Vlad Tempo', 980000);
INSERT INTO artist (nume, nr_streamuri) VALUES ('Daria Bloom', 530000);
INSERT INTO artist (nume, nr_streamuri) VALUES ('Sorin Drift', 1500000);
INSERT INTO artist (nume, nr_streamuri) VALUES ('The Weeknd', NULL);
INSERT INTO artist (nume, nr_streamuri) VALUES ('Daft Punk', NULL);

INSERT INTO album (nume, nr_streamuri, nr_melodii, imagine, durata) VALUES ('Neon Nights', 3200000, 8, 'neon_nights.jpg', 2480);
INSERT INTO album (nume, nr_streamuri, nr_melodii, imagine, durata) VALUES ('Midnight Drive', 2100000, 8, 'midnight_drive.png', 2310);
INSERT INTO album (nume, nr_streamuri, nr_melodii, imagine, durata) VALUES ('Ocean Lines', 1450000, 8, 'ocean_lines.webp', 2405);
INSERT INTO album (nume, nr_streamuri, nr_melodii, imagine, durata) VALUES ('City Lights', 4100000, 8, 'city_lights.jpg', 2550);
INSERT INTO album (nume, nr_streamuri, nr_melodii, imagine, durata) VALUES ('Dark Bloom', 1750000, 8, 'dark_bloom.jpg', 2260);
INSERT INTO album (nume, nr_streamuri, nr_melodii, imagine, durata) VALUES ('Pulse Theory', 2950000, 8, 'pulse_theory.png', 2420);
INSERT INTO album (nume, nr_streamuri, nr_melodii, imagine, durata) VALUES ('Golden Hour', 3600000, 8, 'golden_hour.jpg', 2495);
INSERT INTO album (nume, nr_streamuri, nr_melodii, imagine, durata) VALUES ('Afterglow', 1900000, 8, 'afterglow.webp', 2355);

INSERT INTO gen (denumire) VALUES ('pop');
INSERT INTO gen (denumire) VALUES ('hip-hop');
INSERT INTO gen (denumire) VALUES ('rock');
INSERT INTO gen (denumire) VALUES ('electronic');
INSERT INTO gen (denumire) VALUES ('jazz');
INSERT INTO gen (denumire) VALUES ('indie');
INSERT INTO gen (denumire) VALUES ('lofi');
INSERT INTO gen (denumire) VALUES ('classical');

INSERT INTO feeling (denumire) VALUES ('happy');
INSERT INTO feeling (denumire) VALUES ('sad');
INSERT INTO feeling (denumire) VALUES ('motivated');
INSERT INTO feeling (denumire) VALUES ('chill');
INSERT INTO feeling (denumire) VALUES ('romantic');
INSERT INTO feeling (denumire) VALUES ('energetic');
INSERT INTO feeling (denumire) VALUES ('focused');
INSERT INTO feeling (denumire) VALUES ('nostalgic');

INSERT INTO abonament (data_incepere, data_innoire, status) VALUES (DATE '2025-12-01', DATE '2026-01-01', 'activ');
INSERT INTO abonament (data_incepere, data_innoire, status) VALUES (DATE '2025-11-15', DATE '2025-12-15', 'neplatit');
INSERT INTO abonament (data_incepere, data_innoire, status) VALUES (DATE '2025-10-10', DATE '2025-11-10', 'suspendat');
INSERT INTO abonament (data_incepere, data_innoire, status) VALUES (DATE '2025-12-20', DATE '2026-01-20', 'activ');
INSERT INTO abonament (data_incepere, data_innoire, status) VALUES (DATE '2025-09-05', DATE '2025-10-05', 'neplatit');
INSERT INTO abonament (data_incepere, data_innoire, status) VALUES (DATE '2025-12-25', DATE '2026-01-25', 'activ');
INSERT INTO abonament (data_incepere, data_innoire, status) VALUES (DATE '2025-08-01', DATE '2025-09-01', 'suspendat');
INSERT INTO abonament (data_incepere, data_innoire, status) VALUES (DATE '2025-12-30', DATE '2026-01-30', 'activ');

INSERT INTO melodie (id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Neon Nights'), 'Neon Heart', 12000, 320, 650000, 45000, 215);

INSERT INTO melodie (id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Midnight Drive'), 'Highway Rain', 9800, 210, 540000, 38000, 198);

INSERT INTO melodie (id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Ocean Lines'), 'Ocean Ink', 7600, 145, 410000, 29000, 242);

INSERT INTO melodie (id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES ((SELECT id_album FROM album WHERE nume='City Lights'), 'City Runner', 15000, 500, 820000, 61000, 205);

INSERT INTO melodie (id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Dark Bloom'), 'Dark Petals', 6400, 180, 360000, 24000, 233);

INSERT INTO melodie (id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Pulse Theory'), 'Pulse Loop', 13200, 260, 710000, 52000, 220);

INSERT INTO melodie (id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Golden Hour'), 'Golden Sky', 16800, 190, 900000, 75000, 208);

INSERT INTO melodie (id_album, nume, nr_likeuri, nr_dislikeuri, nr_streamuri, nr_downloaduri, durata)
VALUES ((SELECT id_album FROM album WHERE nume='Afterglow'), 'Afterglow Whisper', 8800, 140, 480000, 33000, 236);

INSERT INTO melodie (id_album, nume, durata) VALUES (NULL, 'Blinding Lights', 200);

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES ('Popescu','Alex', DATE '2025-12-02', 'alex.popescu@demo.ro', 'parola_A1!',
        (SELECT id_melodie FROM melodie WHERE nume='Neon Heart'),
        (SELECT id_abonament FROM abonament WHERE data_incepere=DATE '2025-12-01'));

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES ('Ionescu','Mara', DATE '2025-11-16', 'mara.ionescu@demo.ro', 'parola_B2!',
        (SELECT id_melodie FROM melodie WHERE nume='Highway Rain'),
        (SELECT id_abonament FROM abonament WHERE data_incepere=DATE '2025-11-15'));

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES ('Stan','Radu', DATE '2025-10-11', 'radu.stan@demo.ro', 'parola_C3!',
        (SELECT id_melodie FROM melodie WHERE nume='Ocean Ink'),
        (SELECT id_abonament FROM abonament WHERE data_incepere=DATE '2025-10-10'));

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES ('Marin','Daria', DATE '2025-12-21', 'daria.marin@demo.ro', 'parola_D4!',
        (SELECT id_melodie FROM melodie WHERE nume='City Runner'),
        (SELECT id_abonament FROM abonament WHERE data_incepere=DATE '2025-12-20'));

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES ('Georgescu','Vlad', DATE '2025-09-06', 'vlad.georgescu@demo.ro', 'parola_E5!',
        (SELECT id_melodie FROM melodie WHERE nume='Dark Petals'),
        (SELECT id_abonament FROM abonament WHERE data_incepere=DATE '2025-09-05'));

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES ('Dumitru','Kira', DATE '2025-12-26', 'kira.dumitru@demo.ro', 'parola_F6!',
        (SELECT id_melodie FROM melodie WHERE nume='Pulse Loop'),
        (SELECT id_abonament FROM abonament WHERE data_incepere=DATE '2025-12-25'));

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES ('Matei','Sorin', DATE '2025-08-02', 'sorin.matei@demo.ro', 'parola_G7!',
        (SELECT id_melodie FROM melodie WHERE nume='Golden Sky'),
        (SELECT id_abonament FROM abonament WHERE data_incepere=DATE '2025-08-01'));

INSERT INTO utilizator (nume, prenume, data_inregistrare, email, parola, id_melodie_ascultata, id_abonament)
VALUES ('Enache','Luna', DATE '2025-12-31', 'luna.enache@demo.ro', 'parola_H8!',
        (SELECT id_melodie FROM melodie WHERE nume='Afterglow Whisper'),
        (SELECT id_abonament FROM abonament WHERE data_incepere=DATE '2025-12-30'));

INSERT INTO playlist (id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='alex.popescu@demo.ro'), 'Morning Boost', 12, 2600, 180000);

INSERT INTO playlist (id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='mara.ionescu@demo.ro'), 'Late Night', 10, 2200, 145000);

INSERT INTO playlist (id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='radu.stan@demo.ro'), 'Study Mode', 14, 3000, 210000);

INSERT INTO playlist (id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='daria.marin@demo.ro'), 'Gym Hits', 16, 3400, 260000);

INSERT INTO playlist (id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='vlad.georgescu@demo.ro'), 'Rainy Days', 9, 2000, 98000);

INSERT INTO playlist (id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='kira.dumitru@demo.ro'), 'Road Trip', 13, 2900, 175000);

INSERT INTO playlist (id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='sorin.matei@demo.ro'), 'Chill Vibes', 11, 2400, 132000);

INSERT INTO playlist (id_creator, denumire, nr_melodii, durata, nr_streamuri)
VALUES ((SELECT id_utilizator FROM utilizator WHERE email='luna.enache@demo.ro'), 'Top 2025', 20, 4200, 310000);

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

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Neon Heart'),
        (SELECT id_utilizator FROM utilizator WHERE email='alex.popescu@demo.ro'),
        3600);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Highway Rain'),
        (SELECT id_utilizator FROM utilizator WHERE email='alex.popescu@demo.ro'),
        2100);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Ocean Ink'),
        (SELECT id_utilizator FROM utilizator WHERE email='mara.ionescu@demo.ro'),
        1800);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='City Runner'),
        (SELECT id_utilizator FROM utilizator WHERE email='mara.ionescu@demo.ro'),
        2400);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Dark Petals'),
        (SELECT id_utilizator FROM utilizator WHERE email='radu.stan@demo.ro'),
        900);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Pulse Loop'),
        (SELECT id_utilizator FROM utilizator WHERE email='radu.stan@demo.ro'),
        2700);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Golden Sky'),
        (SELECT id_utilizator FROM utilizator WHERE email='daria.marin@demo.ro'),
        3200);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Afterglow Whisper'),
        (SELECT id_utilizator FROM utilizator WHERE email='daria.marin@demo.ro'),
        1500);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Neon Heart'),
        (SELECT id_utilizator FROM utilizator WHERE email='vlad.georgescu@demo.ro'),
        600);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Highway Rain'),
        (SELECT id_utilizator FROM utilizator WHERE email='kira.dumitru@demo.ro'),
        1100);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Pulse Loop'),
        (SELECT id_utilizator FROM utilizator WHERE email='sorin.matei@demo.ro'),
        2000);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Golden Sky'),
        (SELECT id_utilizator FROM utilizator WHERE email='luna.enache@demo.ro'),
        2600);

INSERT INTO melodie_downloadata_utilizator (id_melodie_downloadata, id_utilizator, timp_de_ascultare_lunar)
VALUES ((SELECT id_melodie FROM melodie WHERE nume='Blinding Lights'),
        (SELECT id_utilizator FROM utilizator WHERE email='alex.popescu@demo.ro'),
        1800);

insert into melodie_artist (id_melodie, id_artist, artist_principal)
values (
  (select id_melodie from melodie where nume = 'Neon Heart'),
  (select id_artist  from artist  where nume = 'Mara Vibes'),
  1
);
COMMIT;
