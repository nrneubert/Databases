
[[L4 AdvSQL25.pdf]]

#### Recap: SQL DDL
Keys uniquely identify tuples:
`PRIMARY KEY`: within a table
`FOREIGN KEY`: across tables
and ensure quality of your data. 

Other constraints:
`NOT NULL`, `UNIQUE`, `DEFAULT`
Triggered actions:
`CASCADE`, `SET NULL`, `SET DEFAULT`

==Q==: Which SQL DDL for Group?
![[whichSqlDdlForGroup.png|600]]
*Note `g_id` should be dotted*
Answer is `E` because `Group` is a weak-entity set, and therefore borrows the primary key of the supporting entity as a foreign key. 
We need to have both `g_id` and `Name` be the primary keys of `Group`. 

#### SQL DML: `SELECT-FROM-WHERE`

Basic form of a SQL query: 
`SELECT` | *desired attributes*                              |  *projection*: projecting to attributes               
`FROM`     | ***one or more tables***                           |  *join*: combining tables
`WHERE`   | ***condition about the involved rows***  |  *selection condition*: selecting rows
and the result is a **table**. 

###### Combining conditions in `WHERE`:
| `AND` | `OR` | `NOT` | `=` | `<>` | `<` | `>` | `<=` | `>=` |
| ----- | ---- | ----- | --- | ---- | --- | --- | ---- | ---- |
|       |      |       |     |      |     |     |      |      |
###### Renaming in SELECT
The selected attributes can be given new names.
```SQL
SELECT name AS navn, office AS kontor
	FROM People
	WHERE office = `Ny-357`;
```

###### Renaming in `FROM`
```SQL
SELECT name, office
	FROM People AS Folk
	WHERE Folk.office = `Ny-357`;
```

###### General renaming options
Specifying a new name right after the original one using `AS`; 
* called an **alias** or **tuple variable**. 

###### Math in `SELECT`
Attributes may have computed values
```SQL
SELECT customer AS kunde, date AS dato, price*7.44 AS pris 
	FROM Purchase
	WHERE customer = `ira`;
```
also supports `+`, `-`, `/`.
$\Rightarrow$ Convenient both in `SELECT` and `WHERE`
```SQL
SELECT customer AS PricelessCustomer
	FROM Purchase
	WHERE fee + price > 7;
```

```SQL
SELECT price as Sweetspot
	FROM Purchase
	WHERE price BETWEEN 2.99 AND 4.99;
```

###### Multiple relations (joins)

***General loop semantics***
*Loop through all rows in all tables*
*For each combination*
	- <span style="color:grey">check if the condition is true</span>
	- <span style="color:grey">project the rows onto the desired attributes</span>
*Note that duplicates are still kept*

==NB==: SQL is implemented in a more optimized way. 

==Q==: Which of these is correct?

![[multiplerelationsjoins.png|600]]
Answer with correct syntax is **1**, however **4** could be right but `capacity` and `room` is not an attribute in the table `Meetings` (you'll get an unknown error). 

###### Ambiguous attribute names
Same name can be used for two (or more) attributes 
- as long as the attributes are in different relations
- if using two same name attributes in the query, must **qualify** attribute name with relation name to prevent ambiguity.
	`Relation.Attribute`
	`SELECT    Fname, EMPLOYEE.Name, Address`
	`FROM      EMPLOYEE, DEPARTMENT`
	`WHERE     DEPARTMENT.Name=´Research´ AND 
	`          DEPARTMENT.Dnumber=EMPLOYEE.Dnumber;`

###### Unspecified `WHERE`clause
Indicates no condition on tuple selection. 
- Returns a lot of tuples!

###### Asterisk notation
Specify an asterisk `*` instead of attributes in `SELECT` clause to retrieve all attribute values of the selected tuples. 
```SQL
SELECT * FROM Employee;
```

==Q==: Using the same relation twice, find all pairs of roommates

![[Findallpairsofroommates.png|600]]
Answer is **3**. It is the only one with alphabetical sorting to avoid duplicates. 
You need to rename the table to `p1` and `p2` to create a 'duplicate' as a reference to (***self-join***). 

###### Finding a pattern in a string
We would like to find all events relating to beer that are organized by Frank:
```SQL
SELECT owner, topic
	FROM Meetings
	WHERE owner=´fra´ AND topic LIKE ´%beer%´;
```

###### Fun with pattern matching
`LIKE` comparison operator
- used for string **pattern matching**
- `%` replaces an arbitrary number of zero or more characters
- `_` underscore replaces a single character
	`SELECT Name FROM Student WHERE Address LIKE ´%Aarhus%´;`
		*Matches Aarhus, 8200 Aarhus N, 8000 Aarhus, etc*
	`SELECT Name FROM Student WHERE Address LIKE ´Aarhus__´;`
		*Matches Aarhus N, but not Aarhus*
- If you need to find a string with `%` precede it with an escape character `\`
- `CONCAT` to concatenate strings
	`SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees;`

###### Scalar functions
May use scalar functions: many are available
- integer, float functions
- string functions
- calendar functions

```SQL
SELECT CHARACTER_LENGTH(name) AS len, UPPER(´group´) AS ´GROUP´ FROM People;
```
==NB==: you actually do not need to capitalize `AS` here, but it is good practice to capitalize keywords in SQL. 

###### Tables as Sets in SQL
SQL does not automatically eliminate duplicate tuples in query results (**multiset semantics**). 
To do this use the `DISTINCT` keyword in the `SELECT`clause
- turns the result into a **set**. 
- each values remains *only once* in the result.
- <u>expensive</u> operation. 

```SQL
SELECT studies FROM Student;
vs.
SELECT DISTINCT studies FROM Student;
```

if not `DISTINCT`, you can specify `ALL`. 

###### Set operations in SQL
Following set operations:
	1    `UNION`         3    :    elements in 1 or in 3
	1    `EXCEPT`       3    :    elements in 1 but not in 3 (difference)
	1    `INTERSECT` 3    :    elements in 1 and 3 : 2
Mathematical set operations.  
Note you can not use `*` in a `UNION`!

Corresponding multiset oeprations: `UNION ALL`, `EXCEPT ALL`, `INTERSECT ALL`. 
	$\Rightarrow$ Uses multiset semantics and <u>keeps duplicates</u>

###### Ordering of query results
Use `ORDER BY` clause. 
- Keyword `DESC` (descending) to see results in a descending order of values.
- Keyword `ASC` (ascending) to specify ascending order explicitly (<u>default</u>)
You can combine these, to order in an order:
```SQL 
ORDER BY D.Dname DESC, E.Lname ASC, E.Fname ASC
```

###### Modifications
SQL **commands**/**statements** may modify the database (not "queries"). 
- *these do not return a result*
- *their effect is on the database state*

Three kinds of modification: 
- Insert one or more rows: `INSERT INTO`
		`INSERT INTO Participants VALUES (42835, ´ira´, ´a´);`
		or optionally specify attribute names (<u>recommended</u>)
		`INSERT INTO Participants(pid, status, meetid) VALUES (´ira´, ´a´, 42835);`
		==NB==: missing values are `NULL` or defaults. 
- Delete one or more rows: `DELETE FROM` combined with `WHERE`
```SQL
DELETE FROM     EMPLOYEE
WHERE           Lname=`Brown´;
```
or
```SQL
DELETE FROM     EMPLOYEE;
```
<u>to delete everything!</u>

- Update existing rows and columns: `UPDATE` combined with `SET`
```SQL
UPDATE     PROJECT
SET        Plocation=´Bellaire´, Dnum=5
WHERE      Pnumber=10;
```
or
```SQL
UPDATE People
	SET office = ´Ny-343´
	WHERE userid = ´ira´;
```


