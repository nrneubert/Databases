USE exercise610;
/*
SELECT Fname, Lname FROM Employee, Works_on, Project WHERE
	Employee.Salary > 3000 AND
    Employee.Dno = 5 AND
    Employee.Ssn = Works_on.Essn AND
    Works_on.Pno = Project.Pnumber AND
    Project.Pname = 'ProductZ';
*/
/*
SELECT Fname, Lname FROM Employee WHERE
	Employee.Address LIKE '%Houston%' AND
    Employee.Super_ssn = 333445555;
*/

SELECT DISTINCT Fname, Lname FROM Employee, Project, Works_on WHERE
		Project.Pname = 'Computerization' AND
        Project.Pnumber = Works_on.Pno AND
        Works_on.Essn = Employee.Ssn;
        
        
        
        
        
        