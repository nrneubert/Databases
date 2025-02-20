[[L5 ComplexQueries 25.pdf]]

##### `NULL`values revisited
Note `NULL` values are treated specially!

**3-values logic**: we have *true*, *false*, *unknown*
`NULL` means unknown, non-exsistent, unknown or nonexsistent
so $3*\mathrm{NULL}=\mathrm{NULL}$
and any comparison with `NULL` yields unknown: $\mathrm{NULL}>3?$ *unknown*

`WHERE` clause only accepts if the result is *true*.

==Example==: What is the result?
![[Images/SELECTwithNULL.png|600]]
Answer is "ira, jan" because "aas" has `NULL` office and any comparison will be unknown (i.e. not true)!

SQL allows queries that check whether an attribute valie is `NULL`: `IS NULL` or `IS NOT NULL`.
==NB==: Do not use `WHERE Super_ssn = NULL;`!

#### Aggregation
`SELECT` clause may involve aggregate functions:
`SUM`, `AVG`, `COUNT`, `MIN`, `MAX`
==NB==: `NULL` values are ignored in these computations except that `count(*)` counts all rows. 

```SQL
SELECT AVG(capacity) AS average FROM Rooms;
```
or
```SQL
SELECT COUNT(DISTINCT type) AS number FROM Equipment;
```

#### Nested queries

**Nested/sub - queries**: 
Any query in parentheses can be used in `FROM` or `WHERE` clauses
**Outer/inner - queries**: 
Outer query is the first `SELECT` ... block, the inner query is the one nested in the `FROM` or `WHERE` clause.

==Example==: Who shares an office with Annika?
```SQL
SELECT name FROM People WHERE office = (SELECT office 
										FROM People
										WHERE userid=`aas`);
```

Why use subqueries? 
- *Very powerful*: express complex conditions
- Can use result of any query as input to another

However, may not lead to most elegant / efficient query

#### `IN` clause
Comparison operator `IN`
- compares value *v* with a set (or multiset) of values *V*
- evaluates to `TRUE` if *v* is one of the elements in *V*

Used to determine whether subquery results contain an element of interest to outer query
![[ComparisonOperatorIN.png|600]]

#### `IN` operator for tuples
Use tuples of values in comparisons
- place them in parentheses
- number of elements and schema needs to match

#### `ANY` and `ALL`
Allows comparisons against
- *any* row in a subquery (`ANY` / `SOME`)
- *all* rows in a subquery (`ALL`)

==Example==: 
```SQL
SELECT topic
	FROM Meetings
	WHERE date >= ALL(SELECT date FROM Meetings);
```


#### Types of nested queries

**Correlated nested query** : a direct relation between the values in the outer and inner query
- can be used to construct ***loops***!
==Example==: Note we use `E.Dno`, so we use the outer query `E` in the inner query.
```SQL
SELECT E.Lname 
	FROM Employee E 
	WHERE salary > ( SELECT AVG(salary) 
						FROM Employee 
						WHERE Dno = E.Dno)
					);
```
which will be evaluated once for each tuple in the outer query (i.e. for each Employee).

###### Ambiguity in nested queries
As a rules, ambiguous attribute names in outer query and subquery are allowed.
- Similar to scope rules in programming languages
- Avoid potential errors and ambiguities by renaming (aliases)

==NB==: Often nested queries can be *reduced* to a single query and should be done such.

#### `EXISTS` and `UNIQUE` functions
`EXISTS` function: *checks whether the result of a correlated nested query is empty or not*.
`NOT EXISTS`: *typically used in conjunction with a correlated nested query*
SQL function `UNIQUE(Q)`: *returns* `TRUE` *if there is no duplicate tuples in the result of query* Q.

==Question==: Do we delete Annika also?
![[DeletionSemantics.png]]
Answer is **3**. 

#### `JOIN` operator
```SQL
SELECT * FROM Table_2 JOIN Table_1 ON condition;
```
is syntactic sugar for
```SQL
SELECT * FROM Table_1, Table_2 WHERE condition;
```
==Example==: 
```SQL
SELECT * FROM Course JOIN Attends ON Course.courseid=Attends.courseid;
```

###### What kind of `JOIN`s can we have?

**Inner join**: *default type of join in a joined table*
- Tuple is included in the result only if a matching tuple exists in the other relation
**Natural join** (on two relations)
- No join condition is specified
- "Naturally" joined on matching values of matching attribute
- i.e. implicit `EQUIJOIN` condition (`=`) for each pair of attributes with same name from the two relations.
- `SELECT * FROM Course NATURAL JOIN Attends;` (if `Course`and`Attends` both only share attribute `courseid`)


**Dangling rows**: all the rows thrown away by the `INNER JOIN`.
An `OUTER JOIN` preserves dangling rows by padding them with `NULL` values.
- A `LEFT` and `RIGHT JOIN` preserves dangling rows from one table only
- ==NB==: in MySQL no outer join, only left or right join (use union of both to get outer)

![[DifferentKindsOfJoin.png|600]]

==Question==: `IN` versus `JOIN`
![[INvsJOIN.png]]Answer is **2**. 

#### Grouping using `GROUP-BY` clause
`SELECT-FROM-WHERE-GROUP BY`
- Rows are grouped by a set of attributes
- Aggregations in `SELECT` are done for each group

Attributes in `SELECT` must be either
- aggregates or
- mentioned in the `GROUP BY` clause

==Example==: How many meeting has each person arranged?
```SQL
SELECT owner, COUNT(meetid) as number
	FROM Meetings
	GROUP BY owner;
```

***Conditions on groups***: the `HAVING` clause
A `HAVING` clause specifies conditions for groups (otherwise, group is eliminated from result)

==Example==: Which offices have more than one occupant?
```SQL
SELECT office
	FROM People
	GROUP BY office
	HAVING COUNT(*) > 1;
```
###### Advanced updates: *Inserting a subquery*
Invite everyone whom Frank meets with to his Beer tasting
```SQL
INSERT INTO Participants (
	SELECT 48333 AS meetid, pid, 'u'
	FROM Meetings NATURAL JOIN Participants
	WHERE owner = ´fra´
		AND pid <> ´fra´
		AND pid NOT IN (SELECT room FROM Rooms)
);
```

`DROP` command: *used to drop named schema elements such as tables, domains or constraint.*
- causes `CASCADE` and `RESTRICT`

`ALTER` command: 
- adding or dropping a column (attribute)
- changing a column definition
- adding or dropping table constraints

==Example==: 
```SQL
ALTER TABLE COMPANY.EMPLOYEE ADD COLUMN Job VARCHAR(12);
```

