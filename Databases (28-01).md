###### *Introduction*
In the course we will work with relational databases using SQL (query *decorative* language). 

##### **Terminologi**

**Database**
- Collection of related data
- Known facts that can be related and have implicit meaning

**Miniworld** *or* **universe of discourse (UoD)**
- Represents some aspect of the real world
- Logically coherent collection of data with inherent meaning
- Built for specific purpose
$\Rightarrow$
>We can not and should not model everything in our world - just exactly what is needed, not more, not less.

**DBMS**: *Database management system*
- Collection of <u>programs</u>; 
	*We use MySQL Workbench to make a well-functioning database, and only "configure" the structure of the database.*
- Databases make use of the DBMS to support data management
	*Easy to put in data, ensure data quality and retrieve data*
- Generic platform
	
Recently we have seen a push towards NoSQL databases due to scalability. 

==**?**:== *Could I just use a text editor instead of a database to store student information?*
$\Rightarrow$ Yes, in simple cases
- No repeated information
- No automatic control of consistency, constraints or updates
###### When not to use DBMS:
*It is more desirable to use regular files for*:
- Simple, well-defined database applications not expected to change at all

##### Creating a database
*A database application is a collection of data and the programs that allow the manipulation of these data.*
Defining a database
- Specify the data types, structures, constraints

**Meta-data**: database definition *or* descriptive information (table name, columns)

| meta   |     | STUDENT |        |       |
| ------ | :-: | :-----: | :----: | :---: |
| *meta* | id  |  name   | course | years |
| *data* |  1  |   --    |   --   |  --   |

#### Summary of DBMS features
- Controlling redundancy
		==*Data normalization*==: *No need to enter the same information repeatedly*.
			***Denormalization***: sometimes necessary to use *controlled redundancy* to improve query performance.
- Restricting unauthorized access

*Later we will see*
- Storage structures and efficient search techniques
- Backup and recovery
- Multiple user access: *more than one user/program (thread) can access the database at the same time*
- Representing complex data relationships
		Enforcing integrity constraints
		Referential integrity constraints: *every section record must be related to a course record*
- Triggers: *allows updates to the data based on other changes*
- General abstraction: *no need to worry about data handling*

==**?:**== *Which of these two models is better?*
![[Images/Which of these models are better.png]]
For many more records *model 1* would have a lot of redundancy. In general *model 2* is preferred.
*Model 1*: Denormalized data
*Model 2:* Normalized data

#### Database models
* **Conceptual model**: *Entity relationship* (next lecture)
	for analysis and design
- **Logical model**: *Relational model*

![[Images/Simplified database environment.png]]
