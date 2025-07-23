--ZADANIE 1
CREATE PROCEDURE rabat
    AS
BEGIN
    DECLARE klienciCursor CURSOR FOR (
        SELECT Gosc.IdGosc, COUNT(Rezerwacja.Zaplacona), Gosc.Procent_rabatu
        FROM Gosc
        INNER JOIN Rezerwacja ON Gosc.IdGosc = Rezerwacja.IdGosc
        WHERE Zaplacona = 1
        GROUP BY Gosc.IdGosc, Gosc.Procent_rabatu
    );

    DECLARE @gosc INT, @ileZaplaconych INT, @procentRabatu INT;

    OPEN klienciCursor;
    FETCH NEXT FROM klienciCursor INTO @gosc, @ileZaplaconych, @procentRabatu;

    WHILE(@@FETCH_STATUS = 0)
        BEGIN
            IF(@ileZaplaconych >= 2)
                BEGIN
                    IF(@procentRabatu IS NOT NULL)
                        UPDATE Gosc SET Procent_rabatu = 10 WHERE Gosc.IdGosc = @gosc;
                    IF(@procentRabatu IS NULL)
                        UPDATE Gosc SET Procent_rabatu += 10 WHERE Gosc.IdGosc = @gosc;
                    PRINT('ZWIEKSZONO RABAT GOSCIA O ID: ' + CAST(@gosc AS VARCHAR));
                END;
            FETCH NEXT FROM klienciCursor INTO @gosc, @ileZaplaconych, @procentRabatu;
        END;
    CLOSE klienciCursor;
END;

EXEC rabat;

DROP PROCEDURE rabat;

GO;

--ZADANIE 2
CREATE TRIGGER zad2 ON Rezerwacja
FOR INSERT, UPDATE, DELETE
    AS
BEGIN

    IF EXISTS(
        SELECT 1 FROM inserted
        LEFT JOIN deleted ON inserted.IdRezerwacja = deleted.IdRezerwacja
        WHERE deleted.IdRezerwacja IS NULL AND inserted.DataDo < inserted.DataOd
    )
    BEGIN
        RAISERROR ('NIE MOZNA DODAC REZERWACJI O WCZESNIEJSZEJ DACIE ZAKONCZENIA, NIZ ROZPOCZECIA', 15, 1);
        ROLLBACK;
    END;


    IF EXISTS(
        SELECT 1 FROM inserted
        INNER JOIN deleted ON inserted.IdRezerwacja = deleted.IdRezerwacja
    )
    BEGIN
        RAISERROR ('NIE MOZNA MODYFIKOWAC REZERWACJI, KTORE ZOSTALY OPLACONE', 15, 1);
        ROLLBACK;
    END;


    IF EXISTS(
        SELECT 1 FROM deleted
        LEFT JOIN inserted ON inserted.IdRezerwacja = deleted.IdRezerwacja
        WHERE inserted.IdRezerwacja IS NULL AND YEAR(deleted.DataOd) = 2009
    )
    BEGIN
        RAISERROR ('NIE MOZNA USUWAC REZERWACJI Z 2009 ROKU', 15, 1);
        ROLLBACK;
    END;


END;


INSERT INTO Rezerwacja VALUES (21, '2024-09-01', '2024-08-15', 1, 101, 1);
UPDATE Rezerwacja SET Rezerwacja.NrPokoju = 103 WHERE Rezerwacja.IdRezerwacja = 1;
DELETE Rezerwacja WHERE Rezerwacja.IdRezerwacja = 1;

DROP TRIGGER zad2;

