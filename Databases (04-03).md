[[L11 AuthNOSQLDB25.pdf]]

##### Prepared statements
SQL statements may be prepared:
- checked and compiled ***once***
- executed ***multiple times***
![[Pasted image 20250304131436.png|400]]

$\Rightarrow$ (3) because
```SQL
SELECT * FROM Users WHERE userid = 'x' OR 'y'='y';
```
and because the latter is always `TRUE`, everything would be returned. 

This leads up to: ***SQL Injection Attacks***. 
- Be careful with dynamic SQL. 
```Java
"SELECT * FROM Users WHERE userid = '" + userid + "'"
```
is 
- fine if userid is `"ira"`
- bad if userid is `"x' OR 'y'='y"`

In python: 
- NEVER use `%`, e.g. `evil"); DROP TABLE users;` could be passed!

#### Protection against SQL injection
You need to **bind variables**: 
- Instead of passing inputs directly to execution, bind inputs to variables first.
- ***JDBC***: prepared statements
- ***Python***: `c.execute('INSERT INTO users VALUES (?)', (user,))

$\Rightarrow$ *SQL statement is compiled before user input is added.*
$\Rightarrow$ *Input does not become part of SQL execution code*

**Sanitize inputs**:
- Upon receiving user input ,pass it through a filter
- Either match against valid pattern (preferred) or strip it from invalid patterns (such as escape characters)

##### Database security

Focus here on **discretionary security** mechanism
- ***Grant privileges*** to users / user ***authorization***
- Capability to access
	1. specific data files, tuples or attribute values
	2. in a specified mode (read, insert, delete)

- Database administrator (DBA)
	1. Creates accounts for (groups of) users and assigns appropriate security level
	2. Grants and revokes privileges

###### Authorization
*Terminology*:
- ***Objects***: tables or views (or triggers, types)
- ***Privileges***: a range of different actions
$\rightarrow$
- ***Owner*** of a database object: unlimited privileges
- ***Users***: identified by their login identities, explicitly assigned privileges
- ***Roles***: hierarchical groups of users
- ***Public***: corresponds to the group of all users and roles

==**How to grant privileges?**==
```SQL
-- Signature
GRANT privileges ON object TO identity 

-- Examples
GRANT SELECT, UPDATE(office) 
	ON People
	TO amoeller;
GRANT INSERT, DELETE 
	ON Exams
	TO engberg;
```
***Privileges***:
1. `SELECT`: retrieval or read
*Modify* privileges
1. `INSERT`
2. `DELETE`
3. `UPDATE`
- `REFERENCES`; right to include an attribute in a foreign key

**Transitive granting**: Grantee may ***propagate***/pass on these (or weaker) privileges to other ***identities***. 
- *Weaker means same privilege on subset of attributes.*
```SQL
-- Signature
GRANT privileges ON object TO identity WITH GRANT OPTION;

-- Example
GRANT SELECT, UPDATE ON Exams TO aomeller WITH GRANT OPTION;

-- Issued by amoeller
GRANT UPDATE(date, time) ON Exams to engberg;
```

==**How to revoke privileges?**==
```SQL
REVOKE privileges ON object FROM identities CASCADE
-- also removes transitive privileges

REVOKE privileges ON object FROM identities RESTRICT
-- fails if transitive privileges are affected

REVOKE GRANT OPTION FOR privileges ...
-- revoke right to grant future transitive privileges
```


##### Roles
Combines groups of users with set of privileges:
```SQL
-- owner does;
CREATE ROLE Paymaster;
GRANT UPDATE(salary) ON Payroll TO Paymaster;
GRANT Paymaster TO amoeller WITH GRANT OPTION;

-- amoeler does;
SET ROLE Paymaster;
GRANT Paymaster TO engberg;
```
All users and roles have the role `public`.
==Role hierarchies==: ***All privileges are inherited***
```SQL
CREATE ROLE Employee;
CREATE ROLE Paymaster;
CREATE ROLE Boss;
GRANT Employee TO Paymaster;
GRANT Paymaster TO Boss;
```
gives: $\mathrm{ Employee \rightarrow Paymaster \rightarrow Boss}$. 

**Views** can be used to restrict these privileges:
```SQL 
CREATE VIEW Vips AS SELECT * FROM People WHERE group = 'vip';

GRANT SELECT ON Vips TO amoeller;
```
$\Rightarrow$ privileges on Views do not transfer to the entire base table!

(Done with *Authorization*)

-----------------

#### NoSQL databases
- <u>Not Only SQL</u>
###### Motivation:
- High performance; *efficient response time*
- Availability; *always able to response*
- <u>Scalability</u>; *can handle huge and continously increasing data volumes*
	$\rightarrow$ challenges for traditional systems!
		- relational model *too restrictive*: 
		 schema models required, effort in maintaining constraints etc.


###### Distribution
Most NoSQL use **distributed databases** (distrubuted storage)
- Database across several computers (called **sites**, nodes, local databases)
- Distributed over computer network (e.g. internet), managed by *distributed DBMS* (***DDBMS***).

![[Pasted image 20250304133928.png|500]]

##### Bandwidth and network latency
In a NoSQL database, *we want to minimize the amount of data that needs to be transmitted over the network*!
	$\Rightarrow$ new measure of complexity: e.g. *transferred data volume (or communication rounds) instead of disk I/O*. 
	$\Rightarrow$ network latency and bandwidth *dominate response time*!

##### Trade-offs in NoSQL
- Scalability
- High performance
- Typically consistency less importrant
		- In relational databases, we are *guaranteed consistency*, i.e. data always in agreement with all integrity constraints. 
		- In NoSQL we use weaker ***eventual consistency*** notion: *there may be temporal inconsistencies in the transfer from the master to the slave sites*.

##### CAP properties
Goals when replicating data:
1. Consistency
2. Availability
3. Partition tolerance; *system continues operation even if partitioned by network default*

**Cap theorem**: *It is impossible to guarantee all three C, A, P. We need to choose any two properties if desired.*
$\Rightarrow$ typically consistency is weakened!

##### NoSQL systems: *data model*
Emphasize performance and flexibility over modelling power and complex querying. 
**No schema** required:
	- Allow **semi-structured, self-describing** data: 
		1. JSON (JavaScript Object Notation)
		2. XML (Extensible Markup Language)
		3. ...
	$\rightarrow$ *Idea*: provide metadata when you provide data. 
	- Since no constraints can be specified, <u>checking must be handled by the application programs</u>! 

**XML**: *Extensible Markup Language*
Self-describing document.
- **tags <>** to annotate the data with **meta-data** (also human read-able)
	--> *sort of local schema along with the data*
- tags **well-formed** (opening and closing tags in the correct order)
 
![[Pasted image 20250304135749.png|400]]


**JSON**: *JavaScript Object Notation*
Similar to XML, **self-describing**, only opening tag (*bracket notation*)
![[Pasted image 20250304135910.png|500]]



