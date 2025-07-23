-- tables
-- Table: Dzial
CREATE TABLE Dzial (
    Id integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Dzial_pk PRIMARY KEY (Id)
) ;

-- Table: Kategoria_PrawaJazdy
CREATE TABLE Kategoria_PrawaJazdy (
    Id integer  NOT NULL,
    Nazwa varchar2(4)  NOT NULL,
    CONSTRAINT Kategoria_PrawaJazdy_pk PRIMARY KEY (Id)
) ;

-- Table: Kierowca
CREATE TABLE Kierowca (
    Id integer  NOT NULL,
    Czy_dostepny char(1)  NOT NULL,
    CONSTRAINT check_dostepny_kierowca CHECK (Czy_dostepny IN ('T', 'N') ),
    CONSTRAINT Kierowca_pk PRIMARY KEY (Id)
) ;

-- Table: Kierowca_PrawoJazdy
CREATE TABLE Kierowca_PrawoJazdy (
    Kierowca integer  NOT NULL,
    Kategoria integer  NOT NULL,
    CONSTRAINT Kierowca_PrawoJazdy_pk PRIMARY KEY (Kierowca,Kategoria)
) ;

-- Table: Kierowca_Samochod
CREATE TABLE Kierowca_Samochod (
    Kierowca integer  NOT NULL,
    Samochod integer  NOT NULL,
    Data_Od date  NOT NULL,
    Data_Do date  NULL,
    CONSTRAINT Kierowca_Samochod_pk PRIMARY KEY (Kierowca,Samochod,Data_Od)
) ;

-- Table: Klient
CREATE TABLE Klient (
    Id integer  NOT NULL,
    Nr_NIP varchar2(15)  NOT NULL,
    Nazwa_podmiotu varchar2(50)  NOT NULL,
    Email varchar2(30)  NOT NULL,
    Telefon char(9)  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (Id)
) ;

-- Table: Marka
CREATE TABLE Marka (
    Id integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Marka_pk PRIMARY KEY (Id)
) ;

-- Table: Prac_administracyjny
CREATE TABLE Prac_administracyjny (
    Id integer  NOT NULL,
    Dzial integer  NOT NULL,
    Przelozony integer  NULL,
    CONSTRAINT Prac_administracyjny_pk PRIMARY KEY (Id)
) ;

-- Table: Pracownik
CREATE TABLE Pracownik (
    Id integer  NOT NULL,
    Pesel char(11)  NOT NULL,
    Imie varchar2(30)  NOT NULL,
    Nazwisko varchar2(50)  NOT NULL,
    Pensja number(7,2)  NOT NULL,
    Data_zatrudnienia date  NOT NULL,
    Data_zwolnienia date  NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (Id)
) ;

-- Table: Przeglad
CREATE TABLE Przeglad (
    Id integer  NOT NULL,
    Data date  NOT NULL,
    Koszt number(4,1)  NOT NULL,
    Opis varchar2(200)  NOT NULL,
    CONSTRAINT Przeglad_pk PRIMARY KEY (Id)
) ;

-- Table: Samochod
CREATE TABLE Samochod (
    Id integer  NOT NULL,
    Typ varchar2(50)  NOT NULL,
    Nr_Rejestracyjny varchar2(8)  NOT NULL,
    Pojemnosc_zbiornika number(3,1)  NOT NULL,
    Rok_produkcji number(4,0)  NOT NULL,
    Czy_sprawny char(1)  NOT NULL,
    Czy_dostepny char(1)  NOT NULL,
    Marka integer  NOT NULL,
    Przeglad integer  NOT NULL,
    CONSTRAINT check_sprawny CHECK (Czy_sprawny IN ('T', 'N') ),
    CONSTRAINT check_dostepny_samochod CHECK (Czy_dostepny IN ('T', 'N') ),
    CONSTRAINT Samochod_pk PRIMARY KEY (Id)
) ;

-- Table: Zlecenie
CREATE TABLE Zlecenie (
    Id integer  NOT NULL,
    Opis varchar2(300)  NOT NULL,
    Trasa varchar2(200)  NOT NULL,
    Klient integer  NOT NULL,
    Wartosc number(10,2)  NOT NULL,
    Data_oplacenia date  NULL,
    CONSTRAINT Zlecenie_pk PRIMARY KEY (Id)
) ;

-- Table: Zlecenie_Kierowca
CREATE TABLE Zlecenie_Kierowca (
    Zlecenie integer  NOT NULL,
    Kierowca integer  NOT NULL,
    CONSTRAINT Zlecenie_Kierowca_pk PRIMARY KEY (Zlecenie,Kierowca)
) ;



-- foreign keys
-- Reference: Kierowca_Kategoria_prawa_jazdy (table: Kierowca_PrawoJazdy)
ALTER TABLE Kierowca_PrawoJazdy ADD CONSTRAINT Kierowca_Kategoria_PrawaJazdy
    FOREIGN KEY (Kategoria)
    REFERENCES Kategoria_PrawaJazdy (Id);

-- Reference: Kierowca_Pracownik (table: Kierowca)
ALTER TABLE Kierowca ADD CONSTRAINT Kierowca_Pracownik
    FOREIGN KEY (Id)
    REFERENCES Pracownik (Id);

-- Reference: Kierowca_PrawoJazdy_Kierowca (table: Kierowca_PrawoJazdy)
ALTER TABLE Kierowca_PrawoJazdy ADD CONSTRAINT Kierowca_PrawoJazdy_Kierowca
    FOREIGN KEY (Kierowca)
    REFERENCES Kierowca (Id);

-- Reference: Kierowca_Samochod_Kierowca (table: Kierowca_Samochod)
ALTER TABLE Kierowca_Samochod ADD CONSTRAINT Kierowca_Samochod_Kierowca
    FOREIGN KEY (Kierowca)
    REFERENCES Kierowca (Id);

-- Reference: Kierowca_Samochod_Samochod (table: Kierowca_Samochod)
ALTER TABLE Kierowca_Samochod ADD CONSTRAINT Kierowca_Samochod_Samochod
    FOREIGN KEY (Samochod)
    REFERENCES Samochod (Id);

-- Reference: Prac_Przelozony (table: Prac_administracyjny)
ALTER TABLE Prac_administracyjny ADD CONSTRAINT Prac_Przelozony
    FOREIGN KEY (Przelozony)
    REFERENCES Prac_administracyjny (Id);

-- Reference: Prac_administracyjny_Dzial (table: Prac_administracyjny)
ALTER TABLE Prac_administracyjny ADD CONSTRAINT Prac_administracyjny_Dzial
    FOREIGN KEY (Dzial)
    REFERENCES Dzial (Id);

-- Reference: Prac_administracyjny_Pracownik (table: Prac_administracyjny)
ALTER TABLE Prac_administracyjny ADD CONSTRAINT Prac_administracyjny_Pracownik
    FOREIGN KEY (Id)
    REFERENCES Pracownik (Id);

-- Reference: Samochod_Marka (table: Samochod)
ALTER TABLE Samochod ADD CONSTRAINT Samochod_Marka
    FOREIGN KEY (Marka)
    REFERENCES Marka (Id);

-- Reference: Samochod_Przeglad (table: Samochod)
ALTER TABLE Samochod ADD CONSTRAINT Samochod_Przeglad
    FOREIGN KEY (Przeglad)
    REFERENCES Przeglad (Id);

-- Reference: Zlecenie_Kierowca_Kierowca (table: Zlecenie_Kierowca)
ALTER TABLE Zlecenie_Kierowca ADD CONSTRAINT Zlecenie_Kierowca_Kierowca
    FOREIGN KEY (Kierowca)
    REFERENCES Kierowca (Id);

-- Reference: Zlecenie_Kierowca_Zlecenie (table: Zlecenie_Kierowca)
ALTER TABLE Zlecenie_Kierowca ADD CONSTRAINT Zlecenie_Kierowca_Zlecenie
    FOREIGN KEY (Zlecenie)
    REFERENCES Zlecenie (Id);

-- Reference: Zlecenie_Klient (table: Zlecenie)
ALTER TABLE Zlecenie ADD CONSTRAINT Zlecenie_Klient
    FOREIGN KEY (Klient)
    REFERENCES Klient (Id);

