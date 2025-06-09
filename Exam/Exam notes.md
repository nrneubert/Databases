
### Functional dependencies

>==Trivial FD==: $X  \rightarrow Y$ is trivial if: $Y \subset X$.
  ==Non-trivial FD==: *see above*.

>==Superkey==: Superset of a candidate key.

>==Candidate key==: <U>Minimal</U> set of a key.

>==Primary key==: Candidate key chosen by designer. 

>==Prime attributes==: Attributes contained in candidate key. 

>==Closure of **FDs**==: Set of all dependencies that include *F* and all those that can be inferred from *F*. Denoted as $F^+$.

>==Closure of **set of attributes**==: Maximum set of attributes that can be inferred from the provided set of attributes. 

### Normalization
Database design principle to 
1. *reduce redundancy*
2. *avoid complexities*
3. *organize data in a consistent way.*
4. *eliminate duplicates*
but loses out on
 - query efficiency 

>==1NF==: No multivalued attributes, i.e. only simple values. 

>==2NF==: Parts of the candidate key must not be functional dependent on non-prime attributes. 
- *Example:* $\{ \mathbf{A,B} \} :  \quad \overbrace{ \mathbf{A} \rightarrow C,D,E}^{\text{illegal}}$
$\Rightarrow$ No arrows from part of candidate key!

**Decompose**: *Make new table containing LHS and RHS. Remove RHS from origin table.*

>==3NF==: Non-prime attributes must not be functionally determined by other non-prime attributes.
- *Equivalent to no transitive dependencies*: $\mathbf{A} \rightarrow \overbrace{B \rightarrow C}^{\text{illegal}}$
$\Rightarrow$ No arrows starting from non-prime attributes!

**Decompose**: *Make new table containing LHS and RHS. Remove RHS from origin table.*

>==BCNF==: No dependencies from non-key attributes to key attributes.
- *Example*: $\{ \mathbf{A,B} \} \rightarrow \overbrace{C \rightarrow \mathbf{A}}^{\text{illegal}}$
$\Rightarrow$ No arrows pointing towards prime attributes!

**Decompose**: *Remove one of the prime-attributes*!
***NB***: BCNF is lossless, but it is not dependency preserving!

>==Losslessness==: Decomposition is lossless if we can recover initial table by performing multiple joins.
  ==Dependency preservation==: We do not lose dependencies. True if all dependencies can be inferred from the current set. 


### Triggers
-  Can <u>not</u> modify the database schema; solely DML (*Data Manipulation Language*) for data-level operations.

>Invoked *automatically*.
>Defined in terms of the event *that invokes it*, and the *action it performs*.
>May operate either `BEFORE` or `AFTER` the execution of the event that invokes it. 

### Storage
<u>Main memory vs. disk</u>:
- Data access from disk is typically 2 orders of magnitude slower. 
- Data in main memory is **volatile**, while **non-volatile** for disk.
- Disk is solely mechanical moving parts, while main memory is completely electronic.

>Each time we read from disk, we retrieve a *block* of records.
>Size of these *blocks* is fixed, but depends on the OS.

#### Indexes

>==Index==: data structure that facilitates quicker access to a data. 
- *can be* used for both main memory and disk!
- *stored in a data file*.


> ==Primary index==: Indexes on the primary key (ordered on key).
- --> ==Dense index==: Has exactly one index entry for each search key value.
- --> ==Sparse index==: Has fewer index entries than search key values.  

> ==Clustering index==: Indexes on a non-key field (ordered on field).
- --> One index entry of each (distinct!) value of the field.
- --> Each index points to first data block of records for search key.

> ==Secondary index==: Not ordered on the index's search key (purely a mess!)

> ==Multi-level index==: Structure of index on index until all entries of the top-level structure fit into 1 disk block.
- --> Pin top-level index in main memory (RAM).

#### $B^+$-trees
- *multi-leveled* indexing structure
- tailored for disk-based data organization: *aligns with disk block sizes, so very efficient for disk storage and access.*
- grows horizontally by splitting the root. 

| $\Downarrow$ Operation | Average     | Worst case  |
| ---------------------- | ----------- | ----------- |
| Search                 | $O(\log n)$ | $O(\log n)$ |
| Insert                 | $O(\log n)$ | $O(\log n)$ |
| Delete                 | $O(\log n)$ | $O(\log n)$ |

> ==Balanced==: all paths from root to a leaf have the same length. 
- --> guarantees good search performance!

### Authorization

Preparing SQL statements they are compiled **only once**, but **executed multiple times**!
>==SQL injection attacks==: Using dynamic SQL queries with user inputs, people can inject malicious statements!
- ***Fix***: Bind inputs to variables and then ==sanitize== them!
>==Sanitize==: Filters matching the input to patterns and stripping it from invalid patterns.

The Database Administrator (***DBA***) can ==grant permissions==:
```
GRANT *privileges* ON *object* TO *identity* WITH GRANT OPTION;
```
>==Transitive granting==: Allows users to grant other users privileges: `WITH GRANT OPTION`.

There are the following *privileges*:
`SELECT`: 
`INSERT`:
`DELETE`: 
`UPDATE`:
`REFERENCES`: *the right to include an attribute in a foreign key*.

==Revoking privileges== can be done using
```
REVOKE *privileges* ON *object* FROM *identities* <CASCADE/RESTRICT>
```
where `<CASCADE/RESTRICT>` revolves around *transitive granted privileges*.

To ==create roles== 
```
CREATE ROLE Paymaster; 
GRANT UPDATE(salary) ON Payroll TO Paymaster; 
GRANT Paymaster TO amoeller WITH GRANT OPTION;
```

### NoSQL
$\equiv$ *Not Only SQL*.
<u>Motivation</u>
- Huge amounts of data
- High performance (response time)
- Consistency less important
- Scalability (relational model *too restrictive*!)
$\Rightarrow$ Often done using **distributed databases**!

***Data-model***: "*Master-slave replication or master-master replication and sharding*."
Commonly *hashing* and *range partitions* is used to localize data.

Categories of systems:
1. Document-based: ***MongoDB***
- --> ==Normalized==: *Decompose into several documents of similar structure and content*
- --> ==Denormalized==: *All information in one document*
1. Key-value stores: ***Voldemort*** (builds on ***DynamoDB***)
2. Column-based / wide-column: ***Apache HBase***
3. Graph-based: ***Neo4j***

>==CRUD==: **C**reate, **R**ead, **U**pdate, **D**elete (+ **S**earch) operations provided through API. 

>==CAP properties==: Goals when replicating data across distributed network:
- **C**: Consistency (same value among replicas)
- **A**: Availability (successful read/writes)
- **P**: Partition tolerance (robust under network failure)
*Note*: <small>In DBMS *consistency* was integrity constraints, now we only want identical replicas!</small>

>==CAP theorem==: <u>Impossible to guarantee all three: C, A, P.</u>
- --> NoSQL systems slack on **C**: consistency.

**Keywords**:
- *No schema required*, instead *semi-structured* data such as JSON, XML!
- *Less powerful query languages*!
- May provide *multiple version storage*.
- *Vertically* scalable (<u>not</u> horizontally)
### Recovery strategies

>==Idempotent==: *If a system crashes during the recovery stage, the new recovery must still give correct results*.

>==Cascading rollback==: *A transaction fails or aborts, and as a result, all other transactions that read data modified by the failed transaction must also be rolled back.*

>==Checkpointing==: process where the system periodically writes all modified (*dirty*) pages from memory to disk.
- improves **recovery** efficiency
- ensures a **consistent** state can be restored after unexpected crash.

>==Shadow-paging==: copy-on-write technique for avoiding in-place updates of pages
- when a page is modified (*dirty*), the system writes changes to a **new (shadow) page** instead of overwriting the old.
- upon commit the page table pointer is switched to the new page (**atomic**!). 
$\approx$ no-undo / no-redo

$\Longrightarrow$ *possible to use both techniques, but often redundant because both handle recovery well*.

>==Write ahead logging== (*WAL*): maintain “before image” in log (main-memory!), flush to disk before overwritten with “after image” on disk

>==Undo==: rollback changes of *uncommited* transactions
  ==Redo==: reapply changes of *commited* transactions after a crash. 

>==Steal==: *uncommited* dirty pages <u>can be</u> written, so you need to ***undo*** them.
- e.g. to save space in main memory you flush the dirty pages more often.
>==Force==: *commited* pages are <u>immediately</u> written (forced!) to disk, so you do not need to repeat them (***no-redo***). 
- generally not favorable because it leads to a ton of continuously costly I/Os

|              | Steal          | No-steal          |
| ------------ | -------------- | ----------------- |
| **Force**    | Undo / no-redo | No-undo / no-redo |
| **No-force** | Undo / redo    | No-undo / redo    |

>==Undo/redo==:
1. Undo all transactions that has a log entry of *"start"* but no *"commit"*.
2. Redo all transactions that has a long entry of *"start"* and *"commit"*.

>==ARIES==: *Recovery algorithm implemented in many IBM related databases*.

**Based on 3 key ideas**:
1. Write Ahead Logging: *Log changes **before** writing them to disk.*
2. Repeat history during redo: *Reapply all actions, including uncommited, to **reconstruct state***
3. Logging changes during undo: *When undoing, **log each undo action**, so crash during recovery is safe* (**idempotent**)

**Using a 3-phase recovery**:
1. Analysis: *Identify dirty pages and active transactions*.
2. Redo: *Repeat history*.
3. Undo: *Roll back any uncommited transactions using the log*.

### Transactions
- Multiuser DBMS systems on single-threaded CPUs are <u>interleaved</u>.
- Provides mechanism for logical units of database processing.

<u>Database access operations</u>: Done by reading database item into *a program variable*, and then writing the *program variable value* to a database item. 

>==Def.=== (***Transaction***): *A unit of work defined by a* `BEGIN TRANSCATION` and `END TRANSACTION`.

> ==Isolation level==: Defines degree to which transactions are *isolated*!
1. **`SERLIAZABLE`**: guarantees transactions behave as though they were serial. 
2. **`REPEATABLE READ`**: read and write locks on rows (not on ranges)!
	--> no dirty reads!
	--> *phantoms*: new rows can still be inserted
3. **`READ COMMITED`**: read and write locks on rows, but read locks released immediately after reading.
	--> no dirty reads, but because read locks are released you can get different values.
4. **`READ UNCOMMITED`**: no read locks!
	--> very risky!

| Isolation level (highest to lowest!) | Dirty reads allowed? | Unrepeatable reads allowed? | Phantom reads allowed? | Concurrency |
| ------------------------------------ | -------------------- | --------------------------- | ---------------------- | ----------- |
| `SERIALIZABLE`                       | No                   | No                          | No                     | Low         |
| `REPEATABLE READ`                    | No                   | No                          | Yes                    | Medium      |
| `READ COMMITED`                      | No                   | Yes                         | Yes                    | High        |
| `READ UNCOMMITED`                    | Yes                  | Yes                         | Yes                    | Very High   |

> ==Overview of problems==: 
1. ***Dirty reads***: 
	- A transaction updates a database item and then fails for some reason.
	- Updated item is accessed by another transaction before it is changed back to its original value.
2. ***Unrepeatable reads***:
	- A transaction reads the same item twice.
	- Another transaction changes the value between first and second read
3. ***Lost update***:
	- Two transactions access same item rendering its value incorrect.
4. ***Phantom reads***: 
	- A transaction queries for an item twice. 
	- Another transaction inserts an item matching the query between first and second read. 

### Concurrency control

> ==Schedule==: Order in which transactions or operations are performed.
- --> *Example:* for 
$$
\begin{align}
T_{1} &: \quad R_{1}(X), W_{1}(X) \\
T_{2} &: \quad R_{2}(X)
\end{align}
$$
	can be interleaved in many different ways!
$$
\begin{align}
1 &: \quad R_{1}(X), W_{1}(X), R_{2}(X) \quad \Rightarrow \text{Serial} \\
2 &: \quad R_{2}(X), R_{1}(X), W_{1}(X) \quad \Rightarrow \text{Serial} \\
3 &: \quad R_{1}(X), R_{2}(X), W_{1}(X) \quad \Rightarrow \text{Concurrent}
\end{align}
$$
- ---> Relevant for: *consistency* and *isolation*!

>==Conflict==: Occurs when you have
1. actions from at least 2 transactions
2. one of them is a write
3. they are on the same attribute

>==Serializable==: A transaction that is **(conflict) equivalent** to a serial schedule. 

>==Precedence graphs==:
1. For every transaction make a node.
2. Draw directed edge from $i$ to $j$ if 
$$ 
\begin{align}
RW &: \ R_{i}(X),\dots, W_{j}(X) \\
WR &: \ W_{i}(X),\dots,R_{j}(X) \\
WW &: \ W_{i}(X),\dots,W_{j}(X)
\end{align}
$$
3. If there is a cycle (despite labeling of attributes!) then it is <u>NOT</u> serializable.
4. To obtain the serializable schedule, follow the arrows from end to end. Note; there may be several. 

#### Timestamping
- Every transaction gets a *timestamp*; $\mathrm{ST_{1}}\rightarrow \mathrm{TS(T_{1})=1}$.
- Resolves *at what point in time* the transactions should see the state of information in.  

>==Single version==:
1.  $R(X) \ : \ W_{TS}(X) \leq TS(T_{i})$
- *If the write-timestamp is younger than yours, then you should not be allowed to read.*
	$\Rightarrow$ if allowed: $R_{TS}(X) = \mathrm{max}(R_{TS}(X), TS(T_{i})$
	$\Rightarrow$ else abort and rollback.
2. $W(X) \ : \ W_{TS}(X) \leq TS(T_{i}) \ \mathrm{AND} \ R_{TS}(X) \leq TS(T_{i})$
- *Same as before, but now also if someone younger has written the value, then you should not be allowed to change it at an earlier time.*
	$\Rightarrow$ if allowed: $W_{TS}(X) = \mathrm{max}(W_{TS}(X), TS(T_{i}))$
	$\Rightarrow$ else abort and rollback. 

>==Multi version==: Reads will always be okay, but not necessarily for writes.
1. $R(X) :$ always allowed, but read version with highest $W_{TS}$ that is $\leq TS(T_{i})$
2. $W(X) :$ find version with highest $W_{TS}$ that is still $\leq TS(T_{i})$. 
	If $R_{TS} \leq TS(T_{i})$, then it is allowed. Then make a new version with $R_{TS}=W_{TS}=TS(T_{i})$.

### Misc
