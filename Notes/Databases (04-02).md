[[L3 BasicSQL25.pdf]]
### <u>Basic SQL and the Relational model</u>

##### Relational model
Use a simple data structure: <u>the table</u>
- richer models, e.g. XML or JSON are useful in some settings
- useful yet not too complex query languages
An elegant mathematical foundation: <u>relation</u>
- contents of the table store the relation
	$\rightarrow$ e.g. all the tuples (rows) in the *Student* relation.
- relational algebra, calculus and set / multi-set theory

##### Relational data model
***Rows*** (*tuples*) store entries
***Columns*** (*attributes*/*features*) contain the name and values
An ***attribute value*** is a piece of information we store.

![[Relational data model.png|400]]

##### Schemas
***Schema*** is the description of the table/relation.
A relation schema involves:
1. name of relation
2. names of attributes
3. types of attributes
4. constraints

==NB==: We are looking at ***abstract tables***, which are
- invariant under permutation of rows and columns
- no information is stored in a specific order

An attribute value may be **NULL**, meaning
- it is unknown
- no value exists
- it is unknown or does not exist

##### SQL: <u>S</u>tructured <u>Q</u>uery <u>L</u>anguage
Invented by IBM in the 1970s. 
High-level and "declarative" with no low-level manipulations.

**DDL**: Data Definition Language for schema definitions
**DML**: Data Manipulation Language for data handling

##### DDL

###### Creating databases
We start by creating our data:
```SQL
CREATE SCHEMA COMPANY;
```
==NB==: In MySQL you can also use `DATABASE` instead of `SCHEMA`. 
- makes the name "Company" known and you can continue defining more of the schema.
- empty at first

If there is already a database of that name, you will get an error unless you use `IF NOT EXISTS`, as
```SQL
CREATE {DATABASE | SCHEMAS} [IF NOT EXISTS] db_name;
```

###### Creating tables
We add relations / (base) tables
```SQL
CREATE TABLE Employee (...);
```
- requires at the same time also the definition of the table columns
- empty as first
To specify attributes you need to specify the *name* and *data type*
```SQL
CREATE TABLE Employee (
	name VARCHAR(40),
	...
);
```

##### SQL Data types

**Numeric**: 
`INT(n)` 
- possible to specify number of digits
`FLOAT(size,d)`
- possible to specify maximum number of digits and maximum number of digits to the right of the decimal point 
**Character-string**: 
`CHAR(n)` (fixed-length)
- if length is not fulfilled it will be padded with blank characters to the right
`VARCHAR(n)` (variable-length)

and more...
`BIT` or `BIT VARYING(n)`
Boolean of `True`, `False` or `NULL`
`DATE` with components `YEAR`, `MONTH` and `DAY`
`TIMESTAMP` is a combination of `DATE` and `TIME`fields, optionally `WITH TIME ZONE`

***Domain*** is a name used with the attribute specification
- Makes it easier to change the data type for a domain that is used by numerous attributes
- Improves readability
```SQL
CREATE DOMAIN CPR_NR AS CHAR(10);
```

##### Relational model constraints
- restrictions on the actual values in a database state
- derived from the rules in the ==miniworld== that the database represents. 
***Domain constraints*** specifies the range of possible values.  
- e.g. `DATE` only permits values that fit the type "2024-02-08". 

###### <u>Key constraints</u>
**Key**/**superkey**: 
- subset of the attributes of the relation 
- no two distinct tuples (*rows*) have the same value for key
**Candidate key**:
- ***Minimal superkey***: removing any attribute leaves a set of attributes that is no longer a superkey. 
		e.g. {`first_name`, `last_name`, `b_day`} removing`b_day`will be a problem for Students with the same first and last name. 
***Primary key*** of the relation
- <u>Designated among cadidate keys</u> (chosen by developer) to identify rows in the table.
- Mark other candidate keys as unique. 
- 
![[Candidate keys.png|500]]
and then you choose one of these candidate keys as your primary key.

###### Specifying key and referential integrity constraints in SQL
`PRIMARY KEY` clause
```SQL
Dnumber INt PRIMARY KEY;
```
`UNIQUE` clause
- Specifies alternate (secondary) keys
```SQL
Dname VARCHAR(15) UNIQUE;
```
For multi-attribute keys, we have to do 
```SQL
CREATE TABLE Exams(
	studid CHAR(2),
	date DATE,
	time TIME,
	vip VARCHAR(15),
	room VARCHAR(40),
	PRIMARY KEY (studid, date)
);
```

###### Enforcing key constraints
Checked during insertion or update.
If it is violated, then a runtime error occurs. 

###### Attribute constraints and defaults
`NOT NULL` can be specified to not permit `NULL` values for a particular attribute. 
==NB==: A primary key can not be `NULL`. 
Default values can also be specified using the `DEFAULT` clause
```SQL
CREATE TABLE Employee(
	name VARCHAR(20),
	country VARCHAR(5) DEFAULT 'DK'
);
```

##### Foreign key
- Specifies that an attribute <u>must reference an attribute in another table</u>: **referential integrity**. 
- The referenced attribute must be a primary key. 
- Also possible for multi-attribute keys.
Done using the `FOREIGN KEY` clause. 

![[Foreign key.png|500]]

<u>How are these constraints enforced?</u>
- Course table (**source**/**parent**) references Professor (**target**/**child**)
	$\rightarrow$ tuple in Course had `prof_id` value that exists in Professor.

![[Foreign keys references.png]]

###### Violated referential integrity constraints
Specify behavior with **referential triggered action** clause
- `CASCADE`: make the same change in the source
	e.g. if course code changes in Course, then propagate change to Student
- `SET NULL`: change source value to `NULL`
	e.g. if textbook goes out of print (deleted), remove it from Course by setting corresponding textbook values to `NULL`
- `SET DEFAULT`: change source value to `DEFAULT`
	e.g. if a Brightspace theme is removed, set preferred theme in User to `DEFAULT`.

For example:
```SQL
CREATE TABLE Course (
	code INT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	prof_if INT,
	FOREIGN KEY (prof_id) REFERENCES 
	Professor(id) ON DELETE SET NULL ON UPDATE CASCADE
);
```

##### Attribute constraints
`CHECK` clauses at the end of a `CREATE TABLE` statement.
- `CHECK( condition )` after an attribute
```SQL
Dnumber INT NOT NULL CHECK (Dnumber > 0 AND Dnumber < 21);
```
or
```SQL
CHECK (`group`='vip' OR `group`='phd' OR `group`='tap')
```

==NB==: These conditions are checked during insert or update of *any* attribute.

