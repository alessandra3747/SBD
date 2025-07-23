-- foreign keys
ALTER TABLE Kierowca_PrawoJazdy
    DROP CONSTRAINT Kierowca_Kategoria_PrawaJazdy;

ALTER TABLE Kierowca
    DROP CONSTRAINT Kierowca_Pracownik;

ALTER TABLE Kierowca_PrawoJazdy
    DROP CONSTRAINT Kierowca_PrawoJazdy_Kierowca;

ALTER TABLE Kierowca_Samochod
    DROP CONSTRAINT Kierowca_Samochod_Kierowca;

ALTER TABLE Kierowca_Samochod
    DROP CONSTRAINT Kierowca_Samochod_Samochod;

ALTER TABLE Prac_administracyjny
    DROP CONSTRAINT Prac_Przelozony;

ALTER TABLE Prac_administracyjny
    DROP CONSTRAINT Prac_administracyjny_Dzial;

ALTER TABLE Prac_administracyjny
    DROP CONSTRAINT Prac_administracyjny_Pracownik;

ALTER TABLE Samochod
    DROP CONSTRAINT Samochod_Marka;

ALTER TABLE Samochod
    DROP CONSTRAINT Samochod_Przeglad;

ALTER TABLE Zlecenie_Kierowca
    DROP CONSTRAINT Zlecenie_Kierowca_Kierowca;

ALTER TABLE Zlecenie_Kierowca
    DROP CONSTRAINT Zlecenie_Kierowca_Zlecenie;

ALTER TABLE Zlecenie
    DROP CONSTRAINT Zlecenie_Klient;

-- tables
DROP TABLE Dzial;

DROP TABLE Kategoria_PrawaJazdy;

DROP TABLE Kierowca;

DROP TABLE Kierowca_PrawoJazdy;

DROP TABLE Kierowca_Samochod;

DROP TABLE Klient;

DROP TABLE Marka;

DROP TABLE Prac_administracyjny;

DROP TABLE Pracownik;

DROP TABLE Przeglad;

DROP TABLE Samochod;

DROP TABLE Zlecenie;

DROP TABLE Zlecenie_Kierowca;

