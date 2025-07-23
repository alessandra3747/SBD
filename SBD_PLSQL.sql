--ALEKSANDRA FUS S30395
    
--PROCEDURA 1
-- WYBRANIE DOSTĘPNYCH KIEROWCÓW I SAMOCHODOW

CREATE OR REPLACE PROCEDURE dostepniKierowcySamochody IS
    CURSOR c_kierowcy IS SELECT PRACOWNIK.IMIE, PRACOWNIK.NAZWISKO, KIEROWCA.CZY_DOSTEPNY
                         FROM PRACOWNIK INNER JOIN KIEROWCA ON PRACOWNIK.ID = KIEROWCA.ID
                         WHERE KIEROWCA.CZY_DOSTEPNY = 'T';
    CURSOR c_samochody IS SELECT SAMOCHOD.ID, SAMOCHOD.CZY_DOSTEPNY FROM SAMOCHOD WHERE SAMOCHOD.CZY_DOSTEPNY = 'T';
    rec_kierowca c_kierowcy%ROWTYPE;
    rec_samochod c_samochody%ROWTYPE;
BEGIN

    DBMS_OUTPUT.PUT_LINE('-------------------');
    DBMS_OUTPUT.PUT_LINE('Dostępni kierowcy:');
    DBMS_OUTPUT.PUT_LINE('-------------------');

    OPEN c_kierowcy;
    FETCH c_kierowcy INTO rec_kierowca;

    WHILE c_kierowcy%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('Kierowca: ' || rec_kierowca.IMIE ||' ' || rec_kierowca.NAZWISKO || ' - Dosteny: ' || rec_kierowca.CZY_DOSTEPNY);
        FETCH c_kierowcy INTO rec_kierowca;
    END LOOP;

    CLOSE c_kierowcy;

    DBMS_OUTPUT.PUT_LINE('-------------------');
    DBMS_OUTPUT.PUT_LINE('Dostepne samochody:');
    DBMS_OUTPUT.PUT_LINE('-------------------');

    OPEN c_samochody;
    FETCH c_samochody INTO rec_samochod;

    WHILE c_samochody%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('Samochod: ' || rec_samochod.ID || ' - Dostepny: ' || rec_samochod.CZY_DOSTEPNY);
        FETCH c_samochody INTO rec_samochod;
    END LOOP;

    CLOSE c_samochody;

END;

CALL dostepniKierowcySamochody();

--PROCEDURA 2
-- WYŚWIETLENIE KTÓRY KIEROWCA/KIEROWCY ZAJMUJE SIĘ ZLECENIEM
CREATE OR REPLACE PROCEDURE kierowcaZlecenia
(v_idZlecenia ZLECENIE.ID%TYPE)
IS
CURSOR c_kierowcy IS
        SELECT PRACOWNIK.IMIE, PRACOWNIK.NAZWISKO, ZLECENIE_KIEROWCA.ZLECENIE
        FROM ZLECENIE_KIEROWCA
        INNER JOIN KIEROWCA ON ZLECENIE_KIEROWCA.KIEROWCA = KIEROWCA.ID
        INNER JOIN PRACOWNIK  ON KIEROWCA.ID = PRACOWNIK.ID
        WHERE ZLECENIE_KIEROWCA.ZLECENIE = v_idZlecenia;

    rec_kierowca c_kierowcy%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
    DBMS_OUTPUT.PUT_LINE('Zlecenie ID: ' || v_idZlecenia);

    OPEN c_kierowcy;
    FETCH c_kierowcy INTO rec_kierowca;

    IF c_kierowcy%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Brak przypisanych kierowców do tego zlecenia.');
    ELSE
        WHILE c_kierowcy%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE('  Kierowca: ' || rec_kierowca.IMIE || ' ' || rec_kierowca.NAZWISKO);
            FETCH c_kierowcy INTO rec_kierowca;
        END LOOP;
    END IF;

    CLOSE c_kierowcy;
END;

CALL kierowcaZlecenia(5);

--WYZWALACZ 1
-- AUTOMATYCZNA ZMIANA DOSTEPNOSCI KIEROWCY PRZY PRZYPISYWANIU GO DO ZLECENIA
CREATE OR REPLACE TRIGGER zmienDostepnoscKierowcy
AFTER INSERT OR DELETE ON ZLECENIE_KIEROWCA
FOR EACH ROW
    DECLARE v_count INT;
BEGIN
    IF INSERTING THEN
        UPDATE KIEROWCA
        SET CZY_DOSTEPNY = 'N'
        WHERE ID = :NEW.KIEROWCA;
    END IF;

    IF DELETING THEN
        --SPRAWDZENIE CZY KIEROWCA MA INNE ZLECENIA AKTYWNE
        SELECT COUNT(*) INTO v_count
        FROM ZLECENIE_KIEROWCA
        WHERE KIEROWCA = :OLD.KIEROWCA;

        IF v_count = 0 THEN
            UPDATE KIEROWCA
            SET CZY_DOSTEPNY = 'T'
            WHERE ID = :OLD.KIEROWCA;
        END IF;
    END IF;
END;

--WYZWALACZ 2
-- SPRAWDZENIE PRZED PRZYDZIELENIEM SAMOCHODU KIEROWCY, CZY MA ON AKTUALNY PRZEGLAD, JEST DOSTEPNY I SPRAWNY
CREATE OR REPLACE TRIGGER sprawdzPrzeglad
BEFORE INSERT OR UPDATE ON KIEROWCA_SAMOCHOD
FOR EACH ROW
    DECLARE
    v_data DATE;
    v_sprawny VARCHAR(1);
    v_dostepny VARCHAR(1);
BEGIN

        SELECT SAMOCHOD.CZY_SPRAWNY INTO v_sprawny FROM SAMOCHOD WHERE SAMOCHOD.ID = :NEW.SAMOCHOD;
        SELECT SAMOCHOD.CZY_DOSTEPNY INTO v_dostepny FROM SAMOCHOD WHERE SAMOCHOD.ID = :NEW.SAMOCHOD;

        SELECT PRZEGLAD.DATA INTO v_data
        FROM PRZEGLAD INNER JOIN SAMOCHOD ON PRZEGLAD.ID = SAMOCHOD.PRZEGLAD
        WHERE SAMOCHOD.ID = :NEW.SAMOCHOD;

        IF v_data < ADD_MONTHS(:NEW.DATA_OD, -12) OR v_data < ADD_MONTHS(:NEW.DATA_DO, -12) THEN
            RAISE_APPLICATION_ERROR(-20100, 'Przeglad samochodu jest nieaktualny.');
        ELSIF v_sprawny = 'N' OR v_dostepny = 'N' THEN
            RAISE_APPLICATION_ERROR(-20100, 'Samochod jest niedostepny.');
        END IF;
END;
