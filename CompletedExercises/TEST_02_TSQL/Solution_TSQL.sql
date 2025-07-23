--ZADANIE 1
CREATE PROCEDURE zad1
@nazwaProduktu VARCHAR(100)
    AS
BEGIN

    DECLARE @cenaProduktu INT = (SELECT Cena FROM Produkt_ WHERE Nazwa LIKE @nazwaProduktu);

    DECLARE @aktId INT, @aktCena INT;

    DECLARE curs CURSOR FOR SELECT IdProdukt, Cena FROM Produkt_;

    OPEN curs;
    FETCH NEXT FROM curs INTO @aktId, @aktCena;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @aktCena < @cenaProduktu
        BEGIN
            UPDATE Produkt_ SET Cena = Cena * 0.92 WHERE IdProdukt = @aktId;

            DECLARE @tmp INT = @aktCena * 0.92;
            PRINT('ZMIENIONO CENE PRODUKTU O ID: ' + CAST(@aktId AS VARCHAR) + ' NA WARTOSC: ' + CAST(@tmp AS VARCHAR));
        END;
        FETCH NEXT FROM curs INTO @aktId, @aktCena;
    END;

    CLOSE curs;
    DEALLOCATE curs;

END;


SELECT * FROM Produkt_;

EXEC zad1 'Produkt A';

GO;


--ZADANIE 2
ALTER TRIGGER zad2 ON Zakup_
FOR INSERT, UPDATE, DELETE
    AS
BEGIN

    IF EXISTS(
        SELECT 1 FROM deleted LEFT JOIN inserted ON deleted.IdZakup = inserted.IdZakup
        WHERE inserted.IdZakup IS NULL AND deleted.DoArchiwizacji = 0
    )
    BEGIN
        RAISERROR('NIE MOZNA USUWAC ZAKUPOW NIE PRZEZNACZONYCH DO ARCHIWIZACJI', 15, 1);
        INSERT INTO Zakup_ SELECT * FROM deleted;
    END;


    IF EXISTS(
        SELECT 1 FROM inserted LEFT JOIN deleted ON inserted.IdZakup = deleted.IdZakup
        WHERE deleted.IdZakup IS NULL AND YEAR(inserted.Data) >= 2025
    )
    BEGIN
        RAISERROR('NIE MOZNA DODAWAC ZAKUPOW DOKONANYCH W 2025 ROKU LUB POZNIEJ', 15, 1);
        DELETE FROM Zakup_ WHERE Zakup_.IdZakup = (SELECT IdZakup FROM inserted);
    END;


    IF EXISTS(
        SELECT 1 FROM inserted INNER JOIN deleted ON inserted.IdZakup = deleted.IdZakup
        AND inserted.IdProdukt <> deleted.IdProdukt
    )
    BEGIN
        RAISERROR('NIE MOZNA AKTUALIZOWAC POLA PRODUKT', 15, 1);
        UPDATE Zakup_ SET Zakup_.IdProdukt = (SELECT IdProdukt FROM deleted) WHERE Zakup_.IdZakup = (SELECT IdZakup FROM deleted);
    END;


END;

--SPRAWDZENIE TRIGGERA
SELECT * FROM Zakup_;
DELETE FROM Zakup_ WHERE IdZakup = 11;
INSERT INTO Zakup_ VALUES (100, '2026-06-01', 4, 0);
UPDATE Zakup_ SET Zakup_.IdProdukt = 2 WHERE IdZakup = 90;

