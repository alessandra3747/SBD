--ZADANIE 1
DECLARE Zad1 CURSOR FOR
    SELECT EMP.EMPNO, EMP.SAL
    FROM EMP;

DECLARE @empNo INT , @empSal INT;

OPEN Zad1;
FETCH NEXT FROM Zad1 INTO @empNo, @empSal;

WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @empSal < 1000
            BEGIN
                UPDATE EMP SET EMP.SAL = @empSal*1.1
                WHERE EMP.EMPNO = @empNo;
                PRINT 'ZWIEKSZONO PENSJE PRACOWNIKA ' + CAST(@empNo AS VARCHAR);
            END
        IF @empSal > 1500
            BEGIN
                UPDATE EMP SET EMP.SAL = @empSal*0.9
                WHERE EMP.EMPNO = @empNo;
                PRINT 'ZMNIEJSZONO PENSJE PRACOWNIKA ' + CAST(@empNo AS VARCHAR);
            END
        FETCH NEXT FROM Zad1 INTO @empNo, @empSal;
    END;
CLOSE Zad1;
DEALLOCATE Zad1;

GO

--ZADANIE 2
CREATE PROCEDURE Zad2
@salLow INT,
@salHigh INT
AS
BEGIN

    DECLARE @empNo INT , @empSal INT;

    DECLARE Zad2Cursor CURSOR FOR
    SELECT EMP.EMPNO, EMP.SAL
    FROM EMP;

    OPEN Zad2Cursor;
    FETCH NEXT FROM Zad2Cursor INTO @empNo, @empSal;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @empSal < @salLow
            BEGIN
                UPDATE EMP SET EMP.SAL = @empSal*1.1
                WHERE EMP.EMPNO = @empNo;
                PRINT 'ZWIEKSZONO PENSJE PRACOWNIKA ' + CAST(@empNo AS VARCHAR);
            END
        IF @empSal > @salHigh
            BEGIN
                UPDATE EMP SET EMP.SAL = @empSal*0.9
                WHERE EMP.EMPNO = @empNo;
                PRINT 'ZMNIEJSZONO PENSJE PRACOWNIKA ' + CAST(@empNo AS VARCHAR);
            END
        FETCH NEXT FROM Zad2Cursor INTO @empNo, @empSal;
    END;
CLOSE Zad2Cursor;
DEALLOCATE Zad2Cursor;

END;

EXECUTE Zad2 1000, 1500;

GO

--ZADANIE 3
ALTER PROCEDURE Zad3
@deptNo INT
AS
BEGIN

    IF NOT EXISTS(SELECT 1 FROM EMP WHERE EMP.DEPTNO = @deptNo)
        RETURN;

    DECLARE @avg INT;
    SELECT @avg = AVG(EMP.SAL)
    FROM EMP
    WHERE EMP.DEPTNO = @deptNo;

    DECLARE @empNo INT, @empSal INT;

    DECLARE Zad3Cursor CURSOR FOR
        SELECT EMP.EMPNO, EMP.SAL
        FROM EMP
        WHERE EMP.DEPTNO = @deptNo;

    OPEN Zad3Cursor;

    FETCH NEXT FROM Zad3Cursor INTO @empNo, @empSal;

    WHILE(@@FETCH_STATUS = 0)
        BEGIN
            IF @empSal < @avg
                BEGIN
                UPDATE EMP SET EMP.SAL = @empSal*0.05 WHERE EMP.EMPNO = @empNo;
                PRINT 'ZWIEKSZONO PENSJE PRACOWNIKA ' + CAST(@empNo AS VARCHAR) + ' Z DZIALU ' + CAST(@deptNo AS VARCHAR);
                END
            FETCH NEXT FROM Zad3Cursor INTO @empNo, @empSal;
        END

    CLOSE Zad3Cursor;
    DEALLOCATE Zad3Cursor;
END;

EXECUTE Zad3 10;

GO

--ZADANIE 4
CREATE TABLE MAGAZYN (
    IDPOZYCJI INT PRIMARY KEY,
    NAZWA     VARCHAR(60),
    ILOSC     INT
);

INSERT INTO MAGAZYN VALUES (1, 'MLEKO', 10);
INSERT INTO MAGAZYN VALUES (2, 'CZEKOLADA', 12);
INSERT INTO MAGAZYN VALUES (3, 'CHLEB', 6);
INSERT INTO MAGAZYN VALUES (4, 'JAJKA', 4);

DECLARE @idPoz INT, @nazwaPoz VARCHAR(60), @iloscPoz INT;
BEGIN
    SELECT @idPoz = IDPOZYCJI, @nazwaPoz = NAZWA, @iloscPoz = ILOSC
    FROM MAGAZYN
    WHERE ILOSC = (SELECT MAX(ILOSC) FROM MAGAZYN);

    IF @iloscPoz >= 5
        BEGIN
            UPDATE MAGAZYN SET ILOSC = @iloscPoz-5
            WHERE IDPOZYCJI = @idPoz;

            PRINT('ZMNIEJSZONO O 5 ILOSC PRODUKTU: ' + CAST(@nazwaPoz AS VARCHAR));
        END;
    ELSE
        RAISERROR ('STAN PRODUKTU JEST MNIEJSZY OD 5', 11, 1);
END;

GO
--ZADANIE 5
ALTER PROCEDURE Zad5
@val INT
AS
BEGIN
    DECLARE @idPoz INT, @nazwaPoz VARCHAR(60), @iloscPoz INT;

    SELECT @idPoz = IDPOZYCJI, @nazwaPoz = NAZWA, @iloscPoz = ILOSC
    FROM MAGAZYN
    WHERE ILOSC = (SELECT MAX(ILOSC) FROM MAGAZYN);

    IF @iloscPoz >= 5
        BEGIN
            UPDATE MAGAZYN SET ILOSC = @iloscPoz-@val
            WHERE IDPOZYCJI = @idPoz;

            PRINT('ZMNIEJSZONO O ' + CAST(@val AS VARCHAR) + ' ILOSC PRODUKTU: ' + CAST(@nazwaPoz AS VARCHAR));
        END;
    ELSE
        RAISERROR ('STAN PRODUKTU JEST MNIEJSZY OD 5', 11, 1);

END;

EXECUTE Zad5 7;