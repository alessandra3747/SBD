-- tables
-- Table: Produkt
CREATE TABLE Produkt_ (
    IdProdukt int  NOT NULL,
    Nazwa varchar(30)  NOT NULL,
    Cena int  NOT NULL,
    CONSTRAINT Produkt_pk PRIMARY KEY  (IdProdukt)
);

-- Table: Zakup
CREATE TABLE Zakup_ (
    IdZakup int  NOT NULL,
    Data date  NOT NULL,
    IdProdukt int  NOT NULL,
    DoArchiwizacji bit  NOT NULL,
    CONSTRAINT Zakup_pk PRIMARY KEY  (IdZakup)
);

-- foreign keys
-- Reference: Zakup_Produkt (table: Zakup)
ALTER TABLE Zakup_ ADD CONSTRAINT Zakup_Produkt
    FOREIGN KEY (IdProdukt)
    REFERENCES Produkt_ (IdProdukt);

INSERT INTO Produkt_ VALUES (1,'Produkt A',40);
INSERT INTO Produkt_ VALUES (2,'Produkt B',120);
INSERT INTO Produkt_ VALUES (3,'Produkt C',89);
INSERT INTO Produkt_ VALUES (4,'Produkt D',2500);
INSERT INTO Produkt_ VALUES (5,'Produkt E',240);
INSERT INTO Produkt_ VALUES (6,'Produkt F',32);

INSERT INTO Zakup_ VALUES(10,'2019-12-20',1,1);
INSERT INTO Zakup_ VALUES(20,'2020-05-21',5,1);
INSERT INTO Zakup_ VALUES(30,'2021-03-13',6,1);
INSERT INTO Zakup_ VALUES(40,'2019-06-30',1,1);
INSERT INTO Zakup_ VALUES(50,'2017-11-29',3,1);
INSERT INTO Zakup_ VALUES(60,'2023-12-28',1,0);
INSERT INTO Zakup_ VALUES(70,'2024-04-20',2,0);
INSERT INTO Zakup_ VALUES(80,'2023-05-12',4,0);
INSERT INTO Zakup_ VALUES(90,'2022-10-10',4,0);
INSERT INTO Zakup_ VALUES(11,'2024-01-18',5,0);

SELECT * FROM Zakup_;
SELECT * FROM Produkt_;