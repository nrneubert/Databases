[[L9 TriggIndDB25.pdf]]

### Triggers and indexes
- Ways to improve performance of our database.
- *Triggers*: ...
- *Indexes*: allow DBMS to perform certain queries faster

----------------

#### Triggers
- Also called **event-condition-action rules**.
- Constraints have limited, fixed reactions to violations
- Trigger enable ***general reactions***.

***Structure***:
1. Event: `AFTER`,`BEFORE`, `INSERT`, `DELETE`, `UPDATE`, `FOR EACH OF`
2. Condition: any SQL boolean expression
3. Action: any sequence of SQL modifications

Attribute and rows checks are efficient, but not really expressive. 
Triggers are <u>much more expressive</u> and can be efficient. 

##### Row-level or statement-level
```SQL
CREATE TRIGGER LogInsert 
	AFTER INSERT ON People
	FOR EACH **STATEMENT**
	INSERT INTO LogFile VALUES('People', CURRENT_TIME);
```
`FOR EACH ROW`: performs the action once for each row (=tuple)
`FOR EACH STATEMENT` (not in MySQL): performs the action once

==NB==: In this case both would do the same, but if we insert multiple rows it will have a significance. 

##### Referencing old and new
An `INSERT` implies there exists a variable for 
- a new row     if `FOR EACH ROW`
- a new table   if `FOR EACH STATEMENT`
- 
An `DELETE` implies there exists a variable for 
- an old row     if `FOR EACH ROW`
- an old table   if `FOR EACH STATEMENT`

An `UPDATE` implies both new and old versions!

==Examples:==
![[Pasted image 20250225113554.png|400]]
![[Pasted image 20250225114612.png|400]]
![[Pasted image 20250225114444.png|400]]
![[Pasted image 20250225114533.png|400]]
![[Pasted image 20250225114705.png|400]]

##### Views
- A ***view*** is a virtual table / a **named query**. 
- Defined as a function of ***base tables** or other views. 

==Example:== 
```SQL
CREATE VIEW Vips AS 
	SELECT * FROM People
	WHERE `group` = 'vip';

CREATE VIEW BusyDays AS
	SELECT name, date
	FROM People, Meetings
	WHERE People.userid = Meetings.owner;
```
$$\Rightarrow$$
```SQL
SELECT * FROM BusyDays, Vips 
	WHERE BusyDays.name = Vips.name;
```

==Note==: Information of the virtual table is not stored anywhere!

###### Materialized views
- ==Exception==: information of virtual table is ***now stored*** as a table!
- Requires recomputation whenever the view may have changed.
- ***Not available in MySQL***, but can be simulated with triggers. 

```SQL
CREATE *MATERIALIZED* VIEW VipsM AS
	SELECT * FROM People
	WHERE group = 'vip';
```

**Trade-offs**:
*Compared to regular view it is*: 
- faster for queries
- slower for modifications
*Typically a compromise*
- recompute the view periodically
	$\Rightarrow$ this ***only works*** if correctness is not critical. 

==Question==: 
```SQL
CREATE VIEW AvgCap AS
	SELECT AVG(capacity) AS average
	FROM Rooms;

UPDATE AvgCap SET average=117;
```
Views are not always updateable, but in the case of using aggregate functions it is NOT updateable. 
In this case changing the average would require manipulating all the capacity entries of Rooms. 
##### Modifying views
- Generally, it makes no sense to update a view! The function is not ***reversible***. 

**Simple views** may be modified if:
- only a single table in `FROM`
- only `SELECT` simple attribute (no aggregates)
- no subqueries in `WHERE`
$\Rightarrow$ *needs to be reversible*!

```SQL
CREATE VIEW Vips AS
	SELECT * FROM People
	WHERE `group` = 'vip';

INSERT INTO Vips VALUES('Glynn Winskel', 'Turing-222', 'gwinskel', 'vip');
```
==BUT== note the value is inserted into People!

##### Alternatives to modifiable views
Triggers may be used to catch view modifications: `INSTEAD OF`-triggers
- *Intended action is then performed on the underlying base tables.*
- ***BUT*** *... not available in MySQL.*

==Example:==
![[Pasted image 20250225122719.png|400]]

-----------------

#### Indexes structures

Data is typically stored in an ***external storage***:
- Hard disks (considered permanent)
- SSDs (flash storage)

###### What does it mean for data to be retrieved from a disk?
- To read or write data from a disk, find the right location on the disk, then read from there
	1. *Seek time*
	2. *Read time*
- **File systems**: input/output (I/O) entire blocks (size is OS dependent)
		- Blocks not necessarily contiguous (*reorganizable*)
		- I/O's can be thought of as 'trips' of retrieval and output. 
			$\Rightarrow$ *This is what we want to optimize*!
		- SSDs have no read/write heads and thus no *seek delay*; still substantially *slower than RAM*.

Suppose we have the query:
```SQL
SELECT * FROM R WHERE condition
```
***Full table scan***:
- read all rows in the ttable
- report those that satisfy the condition
- complexity in I/O model?
$\Rightarrow$ *Fine is many rows will actually be selected, rule of thumb is 5-10%*. 

BUT if we have the **point query**:
```SQL
SELECT * FROM People WHERE userid = 'amoeller';
```
We know that `userid` is a key, hence it is a **point query** 
- *looking or a single particular data point*
$\Rightarrow$ Optimizable if `userid` is sorted alphabetically. 
- Very bad if we search for `zennen`...

**Binary search**: 
- *Jump to the middle of the list of userids* 
- *Check if current userid is before or after amoeller in alphabet*
- *Jump to first quarter, check again*

##### Indexes (=index structures)
***Index on a table***: data structure that helps find rows quickly.
- A table may have several indexes. 
- Virtual sorting of the table
- Each primary key has by default an index
**Trade-off**: *Makes (some) queries faster, but makes modifications slower*

```SQL
CREATE INDEX DateIndex
	ON Meetings(date);

CREATE INDEX ExamIndex
	ON Exams(vip, date, time);
```

##### Indexed file
- Suitable for applications that require *random access*
- Usually combined with *sequential file*
- A **single-level index** is an *auxiliary file* of entries: `<search-key, pointer to record>` ordered on the search key. 
	$\Rightarrow$ Index is separate from data file
	- Usually smaller (10-20% rule of thumb)

For ***primary keys***, the index file will *often* be stored in *main memory*. 
- *Look up primary key value is "for free", as no I/O is needed*!

**Primary index**: defined on a data file ordered on the primary key
***Dense index***: *has one entry for each search key values*
***Sparse index***: *fewer index entries than search key values*
***Secondary index***: *defined on a data file not ordered on the index's search key*
***Clustering index***: *contains consecutive rows*
	$\Rightarrow$ Equivalent to sorting the table
***Multi-level-index***: *index on index, until all entries of the top level fit in one disk block.*

