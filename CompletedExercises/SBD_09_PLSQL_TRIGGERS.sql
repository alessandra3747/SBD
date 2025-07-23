--1
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER del_emp
BEFORE DELETE ON emp
BEGIN
  Raise_application_error(-20100,'Cannot remove employees!') ;   
END;

delete from emp where empno=7369;

select * from emp;


--2
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER zad2
BEFORE INSERT OR UPDATE
ON emp FOR EACH ROW
DECLARE 
v_sal emp.sal%type;
BEGIN
    v_sal := :new.sal;
    IF v_sal < 1000 THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20100, 'Salary too low!');
        ELSIF UPDATING THEN
            :new.sal := :old.sal;
            DBMS_OUTPUT.PUT_LINE('New salary too low. Assining old salary instead (' || :old.sal || ' instead of ' || v_sal || ')');
        END IF;        
    END IF;
END;

update emp set sal=500 where empno= 7369;

--3
CREATE TABLE budget (currentValue INT NOT NULL);

INSERT INTO budget (currentValue)
SELECT SUM(sal) FROM emp;


SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER upd_budget
AFTER INSERT OR UPDATE OR DELETE ON emp 
BEGIN
  UPDATE budget SET currentValue = (SELECT SUM(sal) FROM emp);
END;

--4
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER task_4
BEFORE INSERT OR UPDATE OR DELETE ON emp 
FOR EACH ROW
DECLARE 
    v_count INT;
BEGIN 
    IF DELETING AND :old.sal > 0 THEN     
        Raise_application_error(-20100,'cannot remove employee with salary above 0'); 
    ELSIF (UPDATING AND :old.ename != :new.ename) THEN 
       -- Raise_application_error(-20100,'changing names is forbidden!');  
        dbms_output.put_line('changing names is forbidden!');  
    ELSIF INSERTING THEN    
        SELECT COUNT(1) INTO v_count FROM emp e WHERE e.ename = :new.ename; 
        IF v_count > 0 THEN
            Raise_application_error(-20100,'Employee with this name already exists!');  
        END IF;        
    END IF;
END;

/* Tests
DELETE FROM emp e WHERE empno = 7499;

UPDATE emp set ename ='aa' WHERE empno =7499;

INSERT INTO EMP (empno, ename) VALUES (1, 'ALLEN');
*/