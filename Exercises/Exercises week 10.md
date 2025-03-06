##### MVD: Exercise 1
Follow the rules in secret notes.

| A   | B   | C   | Note  |
| --- | --- | --- | ----- |
| a   | b   | c   | given |
| d   | b   | e   | given |
| f   | b   | g   | given |
| a   | b   | e   | found |
| a   | b   | g   | --    |
| f   | b   | e   | --    |
| d   | b   | g   | --    |
| d   | b   | c   | --    |
| f   | b   | c   | --    |

##### MVD: Exercise 2
Only key is $(A,C,D)$.

$R_1(A,E)$, key A
$R_2(A,B,C)$, key AC
$R_3(A,C,D)$, key ACD

$R_3$ does not violate 4NF because it is a trivial functional dependency.
$R_2$ violates 4NF because $A\rightarrow \rightarrow C$.

We should split $R_2$, but we lose the $AC\rightarrow B$ when doing it. 

##### 26.34
Write triggers to enforce the following:
(a) *Whenever an employee’s project assignments are changed, check if the total hours per week spent on the employee’s projects are less than 30 or greater than 40; if so, notify the employee’s direct supervisor.*

```SQL
DROP TABLE IF EXISTS trigger_log;
CREATE TABLE trigger_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255),
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
DROP TRIGGER IF EXISTS AlertSupervisor;
CREATE TRIGGER AlertSupervisor
BEFORE UPDATE ON Works_on
FOR EACH ROW
BEGIN
    DECLARE total_hours DECIMAL(5,1);
    SELECT SUM(hours) INTO total_hours FROM Works_on WHERE Pno = NEW.Pno;
    IF (total_hours >= 0 AND total_hours <= 700) THEN 
        INSERT INTO trigger_log (message) VALUES (CONCAT('Total hours: ', total_hours));
    END IF;
END//
DELIMITER ;
    
SELECT * FROM Works_on;
SELECT SUM(hours) FROM Works_on WHERE Pno=2;
UPDATE Works_on SET hours=40 WHERE Pno=2;
SELECT * FROM Works_on;
SELECT * FROM trigger_log;
```

(b) *Whenever an EMPLOYEE is deleted, delete the PROJECT tuples and DEPENDENT tuples related to that employee, and if the employee is managing a department or supervising any employees, set the MGRSSN for that department to null and set the SUPERSSN for those employees to null.*

```SQL
DELIMITER //
DROP TRIGGER IF EXISTS OnDeleteEmployee;
CREATE TRIGGER OnDeleteEmployee 
		AFTER DELETE ON Employee
        FOR EACH ROW
        BEGIN
			DELETE FROM Works_on WHERE Essn = OLD.Ssn;
			DELETE FROM Dependent WHERE Essn = OLD.Ssn;
            UPDATE Employee SET Super_ssn = NULL WHERE Super_ssn = OLD.Ssn;
			UPDATE DEPARTMENT SET Mgr_ssn = NULL WHERE Mgr_ssn = OLD.Ssn;
		END//
DELIMITER ;
```

##### 7.9
Consider the following view DEPT_SUMMARY, defined on the COMPANY database in figure 5.6:
```SQL
CREATE VIEW DEPT_SUMMARY(D, C, Total_s, Average_s)
AS SELECT DNo, COUNT(*) SUM(Salary), AVG (Salary)
FROM EMPLOYEE
GROUP BY Dno;
```
State which of the following queries and updates would be allowed on the view. If a query or update would be allowed, show what the corresponding query or update on the base relations would look like, and give its result when applied to the database in figure 5.6.

(a) 
```SQL 
SELECT * FROM DEPT_SUMMARY;
```
![[Pasted image 20250306130810.png|400]]
It is generally okay to select.

(b)
```SQL
SELECT D, C FROM DEPT_SUMMARY WHERE TOTAL_S > 100000;
```
![[Pasted image 20250306130903.png]]

(c) 
```SQL
SELECT D, AVERAGE_S FROM DEPT_SUMMARY WHERE C > (SELECT C FROM DEPT_SUMMARY WHERE D = 4);
```
![[Pasted image 20250306130944.png]]
(d) 
```SQL
UPDATE DEPT_SUMMARY SET D = 3 WHERE D = 4;
```
Views are not updatable (generally)

(e) 
```SQL
DELETE FROM DEPT_SUMMARY WHERE C > 4;
```
Views are not updatable (generally)

##### Exercise on indexes
In the following exercises, determine how many I/O operations will be needed to execute the query given the index in the figure specified.
(a)
```SQL
SELECT * FROM PEOPLE WHERE name="Angel, Joe";
```
We search the index structure (IN memory) alphabetically and find "Anderson, Zach". Perform 1 I/O to disk and retrieves the a data-block, which is searched (IN memory) for "Angel, Joe". He is found, so only 1 I/O is needed.
(b)
```SQL
SELECT * FROM EMPLOYEE WHERE Dept_number="3";
```
**Figure 17.2**: 
We do 2 I/Os to get the 2 blocks containing `Dept_number = "3"`. You do not need to get the first index because of the structure of the index file. 
**Figure 17.3**:
We can only retrieve 1 block per I/O, and due to the structure of the index file, we have to do 2 I/Os. 
**Figure 17.4**:
Only 1 I/O because our index field values actually point towards a block containing that index!
If there were duplicates, this would be very messy and it would not be possible to make this indexing. The system would not allow duplicates. 