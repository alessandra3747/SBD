--enable output
SET Serveroutput ON;

/*1.	Write a simple script in PL/SQL. Declare a variable to store number of records from table EMP. Display the result as “There are N records in table EMP”. */
DECLARE v_counter INTEGER;-- := 10;
BEGIN
	SELECT COUNT(1) INTO counter
	FROM emp e;
	dbms_output.put_line('There are ' || counter || ' records in table EMP') ;
END;

/*2.	Using PL/SQL, find number of departments with assigned employees. If number is lower than 4, find first department without employees and add a new employee to that department. If there are 4 or more departments with employees display a message that no records were added.*/
DECLARE v_counter INTEGER; v_emptyDeptNo INTEGER;
BEGIN
	SELECT COUNT(1) INTO v_counter
	FROM dept d WHERE NOT EXISTS (	SELECT 1 
									FROM emp e
									WHERE e.deptno=d.deptno);
	IF v_counter<4 THEN
		SELECT d.deptno INTO v_emptyDeptNo
		FROM dept d LEFT JOIN emp e ON d.deptno=e.deptno
		WHERE e.deptno IS NULL;
		
		INSERT INTO emp(empno,ename,hiredate,job,deptno,sal) 
		VALUES (1000,'Kowalski',SYSDATE(),'CLERK',v_emptyDeptNo,1000);
	ELSE	
		dbms_output.put_line('No need of inserting new records') ;
	END IF;
END;

/*3.	Create a procedure for adding new departments into table DEPT. The procedure will expect parameters: departmentNo, name and location. Check if a department with this number, name or location already exists. If exists, do not insert a new record.   */
SET Serveroutput ON;
CREATE OR REPLACE PROCEDURE AddDept 
(departmentNo INTEGER,
 deptName VARCHAR2,
 location VARCHAR2)
AS 
v_ifexists integer;
BEGIN
    SELECT COUNT(1) INTO v_ifexists 
	FROM dept 
	WHERE deptno = departmentNo OR dname=deptName OR loc = location;
 IF v_ifexists>0  THEN
        dbms_output.put_line('Department already exists!') ;
    ELSE 
    INSERT INTO dept(deptno,dname, loc) 
	VALUES (departmentNo,deptName, location);
 END IF;
 SELECT * FROM DEPT;
END AddDept;

/

SELECT * FROM dept;
DELETE FROM dept WHERE deptno =50;

CALL AddDept(50, 'IT', 'Warsaw'); --Positional notation

EXECUTE AddDept(departmentNo=>50,deptName=>'IT', location => 'Warsaw');--Named notation

BEGIN
    AddDept(50, 'IT', location => 'Warsaw'); --Mixed notation
END;

/*4.	Create a procedure for inserting employees. The procedure will expect paremeters: department number and employee’s name. The procedure should check whether the given department exists (otherwise we report an error). Assign values for remaining columns:
EMPNO - a new EMPNO calculated as a maximum EMPNO in table + 1
SAL - salary equal to the minimum wage in chosen department
JOB - 'CLERK'
HIREDATE - current system date

Return the new EMPNO in output parameter
*/

SET Serveroutput ON;

CREATE OR REPLACE PROCEDURE AddEmployee 
(p_deptno DEPT.DEPTNO%TYPE,
p_lastname EMP.ENAME%TYPE,
p_newEmpNo OUT EMP.EMPNO%TYPE)
AS 
v_ifexists INTEGER;
v_minsal EMP.SAL%TYPE; 
BEGIN
    SELECT COUNT(1) INTO v_ifexists FROM dept WHERE deptno=p_deptno;
 IF v_ifexists=1  THEN        
        SELECT NVL(MIN(e.sal),450) INTO v_minsal FROM emp e where e.deptno=p_deptno;--NVL is in case that chosen department has no employees yet.
        SELECT MAX(e.empno)+1 into p_newEmpNo FROM emp e;
        INSERT INTO emp(empno,ename,hiredate,job,deptno,sal) 
		VALUES (p_newEmpNo,p_lastname,SYSDATE(),'CLERK',p_deptno,v_minsal);
    ELSE 
    Raise_application_error(-20100,'Department does not exist!') ;    
 END IF;
END AddEmployee;
/

/*
5.	Create a function which given a parameter deptno will return number of employees hired in this department. Display a value received from function in output.
*/

CREATE OR REPLACE FUNCTION f_countEmployees(p_deptno INTEGER) RETURN INTEGER
IS 
v_count INTEGER;
BEGIN
    SELECT COUNT(1) INTO v_count FROM emp e WHERE e.deptno=p_deptno;
    RETURN(v_count);
END f_countEmployees;
/


