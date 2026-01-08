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
