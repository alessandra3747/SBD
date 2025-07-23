--WSTAWIANIE DANYCH DO TABELI DZIAL
INSERT INTO Dzial (id, nazwa) VALUES (1, 'LOGISTYKA');
INSERT INTO Dzial (id, nazwa) VALUES (2, 'MARKETING');
INSERT INTO Dzial (id, nazwa) VALUES (3, 'FINANSE');
INSERT INTO Dzial (id, nazwa) VALUES (4, 'SERWIS');
INSERT INTO Dzial (id, nazwa) VALUES (5, 'ARCHIWUM');


--WSTAWIANIE DANYCH DO TABELI PRACOWNIK
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(1, '86021096114', 'Jan', 'Kowalski', 5700.00, TO_DATE('2020-03-12', 'YYYY-MM-DD'), NULL);
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(2, '92112499346', 'Anna', 'Nowak', 4500.00, TO_DATE('2019-05-15', 'YYYY-MM-DD'), NULL);
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(3, '76032512341', 'Katarzyna', 'Klepka', 5200.00, TO_DATE('2015-02-21', 'YYYY-MM-DD'), NULL);
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(4, '78030695273', 'Piotr', 'Winkiel', 6200.00, TO_DATE('2012-08-16', 'YYYY-MM-DD'), TO_DATE('2020-04-10', 'YYYY-MM-DD'));
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(5, '81080536298', 'Kamil', 'Szmidt', 4750.00, TO_DATE('2018-06-20', 'YYYY-MM-DD'), NULL);
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(6, '87033062728', 'Beata', 'Pilnik', 6450.00, TO_DATE('2017-11-23', 'YYYY-MM-DD'), NULL);
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(7, '80041033281', 'Patrycja', 'Tyczka', 5100.00, TO_DATE('2022-12-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(8, '92072925394', 'Bartosz', 'Dynia', 6300.00, TO_DATE('2014-03-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(9, '98063014199', 'Piotr', 'Tynk', 6300.00, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(10, '70112164295', 'Robert', 'Pawlik', 5100.00, TO_DATE('2014-05-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Pracownik (id, pesel, imie, nazwisko, pensja, data_zatrudnienia, data_zwolnienia) VALUES
(11, '92082132305', 'Tomasz', 'Filar', 5800.00, TO_DATE('2020-04-11', 'YYYY-MM-DD'), NULL);


--WSTAWIANIE DANYCH DO TABELI PRAC_ADMINISTRACYJNY
INSERT INTO Prac_administracyjny (id, dzial, przelozony) VALUES (1, 1, NULL);
INSERT INTO Prac_administracyjny (id, dzial, przelozony) VALUES (2, 2, 1);
INSERT INTO Prac_administracyjny (id, dzial, przelozony) VALUES (3, 3, 1);
INSERT INTO Prac_administracyjny (id, dzial, przelozony) VALUES (11, 3, 1);
INSERT INTO Prac_administracyjny (id, dzial, przelozony) VALUES (6, 4, 1);
INSERT INTO Prac_administracyjny (id, dzial, przelozony) VALUES (7, 4, 1);


--WSTAWIANIE DANYCH DO TABELI KIEROWCA
INSERT INTO Kierowca (id, czy_dostepny) VALUES (10, 'N');
INSERT INTO Kierowca (id, czy_dostepny) VALUES (9, 'T');
INSERT INTO Kierowca (id, czy_dostepny) VALUES (5, 'T');
INSERT INTO Kierowca (id, czy_dostepny) VALUES (8, 'T');


--WSTAWIANIE DANYCH DO TABELI KATEGORIA_PRAWA_JAZDY
INSERT INTO Kategoria_PrawaJazdy (id, nazwa) VALUES (1, 'B');
INSERT INTO Kategoria_PrawaJazdy (id, nazwa) VALUES (2, 'C');
INSERT INTO Kategoria_PrawaJazdy (id, nazwa) VALUES (3, 'C+E');
INSERT INTO Kategoria_PrawaJazdy (id, nazwa) VALUES (4, 'D');


--WSTAWIANIE DANYCH DO TABELI KIEROWCA_PRAWO_JAZDY
INSERT INTO Kierowca_PrawoJazdy (kierowca, kategoria) VALUES (10, 1);
INSERT INTO Kierowca_PrawoJazdy (kierowca, kategoria) VALUES (10, 2);
INSERT INTO Kierowca_PrawoJazdy (kierowca, kategoria) VALUES (10, 4);
INSERT INTO Kierowca_PrawoJazdy (kierowca, kategoria) VALUES (9, 1);
INSERT INTO Kierowca_PrawoJazdy (kierowca, kategoria) VALUES (9, 3);
INSERT INTO Kierowca_PrawoJazdy (kierowca, kategoria) VALUES (5, 1);
INSERT INTO Kierowca_PrawoJazdy (kierowca, kategoria) VALUES (8, 4);


--WSTAWIANIE DANYCH DO TABELI MARKA
INSERT INTO Marka (id, nazwa) VALUES (1, 'Mercedes');
INSERT INTO Marka (id, nazwa) VALUES (2, 'Ford');
INSERT INTO Marka (id, nazwa) VALUES (3, 'Volkswagen');


--WSTAWIANIE DANYCH DO TABELI PRZEGLAD
INSERT INTO Przeglad (id, data, koszt, opis)
VALUES (1, TO_DATE('2023-06-15', 'YYYY-MM-DD'), 98.0, 'Stan karoseri - oznaki rdzy');
INSERT INTO Przeglad (id, data, koszt, opis)
VALUES (2, TO_DATE('2023-08-20', 'YYYY-MM-DD'), 98.0, 'Silnik - zalecona wymiana oleju silnikowego');
INSERT INTO Przeglad (id, data, koszt, opis)
VALUES (3, TO_DATE('2023-10-20', 'YYYY-MM-DD'), 98.0, 'Brak nieprawidłowości');
INSERT INTO Przeglad (id, data, koszt, opis)
VALUES (4, TO_DATE('2023-09-13', 'YYYY-MM-DD'), 98.0, 'Opony - nierównomierne zużycie opony');


--WSTAWIANIE DANYCH DO TABELI SAMOCHOD
INSERT INTO Samochod (id, typ, nr_rejestracyjny, pojemnosc_zbiornika, rok_produkcji, czy_sprawny, czy_dostepny, marka, przeglad)
VALUES (1, 'VAN', 'WF123456', 80.0, 2016, 'T', 'T', 1, 1);
INSERT INTO Samochod (id, typ, nr_rejestracyjny, pojemnosc_zbiornika, rok_produkcji, czy_sprawny, czy_dostepny, marka, przeglad)
VALUES (2, 'PICKUP', 'WV54321', 75.0, 2019, 'T', 'N', 2, 2);
INSERT INTO Samochod (id, typ, nr_rejestracyjny, pojemnosc_zbiornika, rok_produkcji, czy_sprawny, czy_dostepny, marka, przeglad)
VALUES (3, 'PICKUP', 'WR122334', 75.0, 2017, 'N', 'N', 2, 3);
INSERT INTO Samochod (id, typ, nr_rejestracyjny, pojemnosc_zbiornika, rok_produkcji, czy_sprawny, czy_dostepny, marka, przeglad)
VALUES (4, 'VAN', 'WF246801', 78.0, 2021, 'T', 'T', 3, 4);


--WSTAWIANIE DANYCH DO TABELI KIEROWCA_SAMOCHOD
INSERT INTO Kierowca_Samochod (kierowca, samochod, data_od, data_do)
VALUES (10, 2, TO_DATE('2024-05-30', 'YYYY-MM-DD'), NULL);
INSERT INTO Kierowca_Samochod (kierowca, samochod, data_od, data_do)
VALUES (10, 3, TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-02-12', 'YYYY-MM-DD'));
INSERT INTO Kierowca_Samochod (kierowca, samochod, data_od, data_do)
VALUES (9, 1, TO_DATE('2022-10-04', 'YYYY-MM-DD'), TO_DATE('2022-10-07', 'YYYY-MM-DD'));
INSERT INTO Kierowca_Samochod (kierowca, samochod, data_od, data_do)
VALUES (5, 1, TO_DATE('2022-10-07', 'YYYY-MM-DD'), TO_DATE('2022-10-12', 'YYYY-MM-DD'));
INSERT INTO Kierowca_Samochod (kierowca, samochod, data_od, data_do)
VALUES (5, 3, TO_DATE('2021-07-23', 'YYYY-MM-DD'), TO_DATE('2021-07-30', 'YYYY-MM-DD'));
INSERT INTO Kierowca_Samochod (kierowca, samochod, data_od, data_do)
VALUES (8, 3, TO_DATE('2024-01-04', 'YYYY-MM-DD'), TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO Kierowca_Samochod (kierowca, samochod, data_od, data_do)
VALUES (8, 3, TO_DATE('2021-10-20', 'YYYY-MM-DD'), TO_DATE('2021-10-22', 'YYYY-MM-DD'));


--WSTAWIANIE DANYCH DO TABELI KLIENT
INSERT INTO Klient (id, nr_NIP, nazwa_podmiotu, email, telefon)
VALUES (1, '12345678901234', 'ABC Sp. z o.o.', 'kontakt@abc.pl', '123456789');
INSERT INTO Klient (id, nr_NIP, nazwa_podmiotu, email, telefon)
VALUES (2, '012711987654321', 'XYZ S.A.', 'biuro@xyz.pl', '987654321');
INSERT INTO Klient (id, nr_NIP, nazwa_podmiotu, email, telefon)
VALUES (3, '3470294729513', 'CORPO S.A.', 'corpo@mail.pl', '100200300');


--WSTAWIANIE DANYCH DO TABELI ZLECENIE
INSERT INTO Zlecenie (id, opis, trasa, klient, wartosc, data_oplacenia)
VALUES (1, 'Przewóz towarow', 'Krakow - Warszawa', 1, 1000.00, TO_DATE('2023-02-03', 'YYYY-MM-DD'));
INSERT INTO Zlecenie (id, opis, trasa, klient, wartosc, data_oplacenia)
VALUES (2, 'Przewóz mebli', 'Kraków - Gdansk', 2, 1500.00, NULL);
INSERT INTO Zlecenie (id, opis, trasa, klient, wartosc, data_oplacenia)
VALUES (3, 'Przewoz towarow z dodatkowym zabezpieczeniem', 'Warszawa - Wroclaw', 3, 1900.00, TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO Zlecenie (id, opis, trasa, klient, wartosc, data_oplacenia)
VALUES (4, 'Przewoz towarow', 'Krakow - Bialystok', 1, 1600.00, TO_DATE('2021-07-25', 'YYYY-MM-DD'));
INSERT INTO Zlecenie (id, opis, trasa, klient, wartosc, data_oplacenia)
VALUES (5, 'Przewoz towarow i mebli', 'Warszawa - Lodz', 3, 1850.00, TO_DATE('2022-10-05', 'YYYY-MM-DD'));
INSERT INTO Zlecenie (id, opis, trasa, klient, wartosc, data_oplacenia)
VALUES (6, 'Przewoz towarow', 'Warszawa - Lublin', 3, 850.00, TO_DATE('2021-10-21', 'YYYY-MM-DD'));


--WSTAWIANIE DANYCH DO TABELI ZLECENIE_KIEROWCA
INSERT INTO Zlecenie_Kierowca (zlecenie, kierowca) VALUES (1, 10);
INSERT INTO Zlecenie_Kierowca (zlecenie, kierowca) VALUES (2, 10);
INSERT INTO Zlecenie_Kierowca (zlecenie, kierowca) VALUES (3, 8);
INSERT INTO Zlecenie_Kierowca (zlecenie, kierowca) VALUES (4, 5);
INSERT INTO Zlecenie_Kierowca (zlecenie, kierowca) VALUES (5, 9);
INSERT INTO Zlecenie_Kierowca (zlecenie, kierowca) VALUES (5, 5);
INSERT INTO Zlecenie_Kierowca (zlecenie, kierowca) VALUES (6, 8);


COMMIT;