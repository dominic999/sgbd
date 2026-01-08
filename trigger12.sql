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
