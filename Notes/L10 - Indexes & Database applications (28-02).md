[[L10 App DB25.pdf]]

Databases are typically stored in permanent storage: *hard disk* or *flash drive*
$\Rightarrow$ *NOT* stored in main memory (*RAM*).
*In our examples, we have been able to load the entire DB in RAM, but for large databases this is not possible*, ***which reduces the query performance***!
$\Rightarrow$ <u>Justifies counting I/Os to reduce complexity of model</u>

Indexes are synonymous with organization, and tells the DBML *how* to easily find items.
$\Rightarrow$ From main memory we already *know* where to find the entries!
![[Pasted image 20250228085450.png|500]]
Answer is **B**: If all levels were dense you would never narrow down your tree of indexes. It can however make sense to have the bottom-most-level be dense, but you can have a sparse bottom-most-level. 
#### Database applications

#### B-Trees
*Most fundamental index structure in DBMLs.*
A variation of *search trees*, that <u>supports</u>:
- insert a row
- delete a row
- search for a row given the index attribute(s)

In practice a variant known as **B+-trees** are used. 
![[Pasted image 20250228090616.png|600]]

**Invariants**: properties that will hold for any B+-tree;
- Each node (block) holds at most $p-1$ keys. 
	$\rightarrow$ compute from OS block size and size of search key
	$\rightarrow$ called a B+-tree of order $p$.
- Each node must hold at least $\lceil p/2 \rceil$ pointers
- All leaves must be at the same level
	$\rightarrow$ thus the tree remains **balanced**:
		its height with $n$ rows is at most $1+\log_{p/2}(n)$
		in practice the height is 3 or 4

#### Maintaining B+-trees
When the database is modified, the *index needs to be modified as well*.
Indexes needs *to always be ordered*
	$\rightarrow$ some extra maintenance needed when no free space in index file
B+-trees can typically be modified locally, i.e., only few blocks need changes
	$\rightarrow$ means low I/O cost

***Insertion***:
- Search for index node of interest.
- Is there space in the node? 
	$\rightarrow$ Yes, then just insert it.
	$\rightarrow$ No, then we will have to *split the leaf* into *two new nodes*! 
	 We *also need a corresponding entry higher up in the index*, so the two new nodes are correctly found.
	 $\rightarrow$ *This can cause overflow all the way through all layers* and possibly to the root!
		<u>very rare</u>!

***Deletion***:
- Same as insertion, but the opposite process. If you have too few nodes *you will then merge*. 
- Generally, deleted rows are left as *tombstones*!

***Update***: Combination of insertion and deletion.

#### Embedded SQL
- SQL is *rarely* written as ad-hoc queries using the generic SQL interface.
Typically:
$$
\text{client} \quad \Leftrightarrow \quad \text{internet} \quad \Leftrightarrow \quad \text{server} \quad \Leftrightarrow \quad \text{database}
$$

***Static SQL***:
- syntactic extension of host language
- predefined and stored in the database
- *typical use*: monthly accounting statements
***Dynamic SQL***:
- API in host language
- dynamically interpreted by the database
- *typical use*: web applications

You need to establish a *connection* from the software program to the database.
Then you can use the connection to query the database or execute statements. 
Afterwards you need to close the connection. 

***Connection error handling***:
- To handle connection errors use *try* statements, catch all errors using the `errors.Error` exception.

###### SQLite
- Very lightweight DBMS storing a database in *a single file* <u>without</u> a separate database server. 
- Supports SQL queries, but *does not* have all features of MySQL
- Sufficient for *smaller applications*
- Included in both iOS and Android mobile phones. 

![[Pasted image 20250228095133.png|500]]
![[Pasted image 20250228095324.png|500]]

###### MySQL and Python

![[Pasted image 20250228095717.png|500]]

###### Java Database Connectivity (JDBC)
- Common Java framework for SQL databases

$\Rightarrow$ ***Impedance mismatch***; relational model vs. objects (or types)
- When exchanging data, needs to be handled exceptionally. 
- In Java a `ResultSet` object manages a cursor on rows (similarly to an iterator)
- We can then map column types using `getString(...)`, `getInt(...)`.





