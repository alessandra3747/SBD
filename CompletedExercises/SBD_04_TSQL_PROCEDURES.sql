--ZADANIE 1
DECLARE @record_number INT;
SET @record_number = (SELECT COUNT(EMP.EMPNO) FROM EMP);
PRINT 'THERE ARE ' + CAST(@record_number AS VARCHAR(30)) + ' EMPLOYEES';
--ALBO: PRINT 'THERE ARE ' + CONVERT(VARCHAR(30), @record_number) + ' EMPLOYEES';



--PROCEDURY :
GO

CREATE PROCEDURE getDept
@deptNumber INT
    AS
    BEGIN
        SELECT ENAME,SAL,DEPTNO FROM EMP
        WHERE DEPTNO = @deptNumber;
    END
--PROCEDURA MUSI BYC PIERWSZA W BATCH , WIĘC PRZED NIĄ NALEŻY WSTAWIĆ GO

GO

EXEC getDept 30;
--ALBO: EXEC getDept @deptNumber = 30;

GO


--ZADANIE 2
DECLARE @emp_number INT;
SET @emp_number = (SELECT COUNT(EMP.EMPNO) FROM EMP);
IF (@emp_number < 16)
BEGIN
    PRINT 'JEST ' + CAST(@emp_number AS VARCHAR(30)) + ' PRACOWNIKOW';
    INSERT INTO EMP VALUES (7950, 'KOWALSKI', NULL, NULL, NULL, NULL, NULL, NULL);
    PRINT 'DODANO PRACOWNIKA KOWALSKIEGO';
END
ELSE
BEGIN
    PRINT 'JEST ' + CAST(@emp_number AS VARCHAR(30)) + ' PRACOWNIKOW';
    PRINT 'NIE DODANO PRACOWNIKA';
END

SELECT * FROM EMP;


--ZADANIE 3
GO

CREATE PROCEDURE getEmp
@salVal INT
    AS
    BEGIN
        SELECT EMP.ENAME, EMP.SAL FROM EMP
        WHERE EMP.SAL > @salVal;
    END

GO

EXEC getEmp 1000;

GO

--ZADANIE 4
CREATE PROCEDURE insertDept
@deptNumber INT ,
@name VARCHAR(50) ,
@loc VARCHAR(60)
    AS
    BEGIN
       IF EXISTS(
                SELECT 1 FROM DEPT
                WHERE DEPT.DEPTNO = @deptNumber AND DEPT.LOC = @loc
            )
            BEGIN
               PRINT CAST(@deptNumber AS VARCHAR(30)) + ' ' + @name + ' ' + @loc + ' JUZ ISTNIEJE';
            END
       ELSE
            BEGIN
                INSERT INTO DEPT VALUES (@deptNumber, @name, @loc);
                PRINT CAST(@deptNumber AS VARCHAR(30)) + ' ' + @name + ' ' + @loc + ' ZOSTAL DODANY';
            END
    END;

GO

EXEC insertDept 50, 'HR', 'WARSAW';

select * from dept;

GO

--ZADANIE 5
CREATE PROCEDURE insertEmp
@name VARCHAR(60) ,
@deptNo INT
    AS
BEGIN
    IF NOT EXISTS (
                SELECT 1 FROM DEPT
                WHERE DEPT.DEPTNO = @deptNo
    )
        PRINT 'DZIAL ' + CAST(@deptNo AS VARCHAR(30)) + ' NIE ISTNIEJE';
    ELSE
        BEGIN
           DECLARE @sal INT = (SELECT MIN(EMP.SAL) FROM EMP);
           DECLARE @empNo INT = (SELECT MAX(EMP.EMPNO) FROM EMP) + 1;
           INSERT INTO EMP VALUES (@empNo, @name, NULL, NULL, NULL, @sal, NULL, @deptNo);
           PRINT 'DODANO NOWEGO PRACOWNIKA';
        END
END

GO 

EXEC insertEmp 'NOWAK', 10;