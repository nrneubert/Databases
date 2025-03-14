[[L14 TA DB25.pdf]]

==<>== Answering the question: "*How does the DBMS actually do X?*"

**Transactions**: <u>logical unit of database processing </u>
- DBMS basic building blocks for *handling queries* and *modifications* [^1].
	$\Rightarrow$ needs to be successfully completed or needs to be cleaned up in case of issues. 
	
[^1]:  Can be done *at the same time* or have to be *shielded* from one another. 

###### Transaction boundaries: 
All database operations between `BEGIN` and `END TRANSACTION` are considered a single transaction. 

***MySQL***: 
`START TRANSACTION` or `BEGIN` to start transaction.
`COMMIT` to end current transaction, *making changes permanent*.
`ROLLBACK` to end current transaction, *canceling its changes*.
`SET autocommit` disables or enables the default autocommit mode for the current session.

$\Longrightarrow$ To ensure no "strange interleaving" between queries, *we need to group statements into transactions*! [^2] 

[^2]: Each statement is considered a single transaction per default in MySQL. 

![[Pasted image 20250314090421.png|700]]
Correct answer is (2) because the `ROLLBACK` implies that Joe's changes have not been commited yet!
###### Terminology for *transaction processing*:

| Notion                 | Description                                                                 |
| ---------------------- | --------------------------------------------------------------------------- |
| Single-user system     | at most one user at a time can use the system                               |
| Multi-user system      | many uses can access the system concurrently                                |
| Concurrency            | More than one process / user at a time                                      |
| Interleaved processing | One model of concurrency. Processes "take turns" being executed on the CPU. |
*Note*: Opposite of *interleaved processing* is parallel processing, e.g. on a GPU. 

**Granularity** of data *is the "size" of data items*. 
- a field, a record, or a whole disk block.
$\Rightarrow$ Concepts for *transaction processing* are <u>independent on granularity</u>. 

Only reading and writing operations are of interest to *transaction processing*!
$\Longrightarrow$
###### Reading and writing

**read_item(X)**: 
1. Find address of disk block that contains item X. 
2. Copy that disk block into a buffer in main memory.
3. Copy item X from buffer to program variable named X. 

**write_item(X)**: 
1. Find address of disk block that contains item X.
2. Copy that disk block into a buffer in main memory.
3. Copy item X from program variable named X into its correct location in buffer.
4. Store updated block from buffer back to disk (either immediately or at later point).
==<>== *DBMS loads data from disk (I/O) to main memory and writes changes to disk* [^3]. 

[^3]: Operating System (OS) executes these operations (more later)

###### Overview over potential multi-user issues

<u>Temporary update (or dirty read) problem</u>:
- A transaction updates a database item and then fails for some reason.
- Updated item is accessed by another transaction before it is changed back to its original value. 
<u>Lost update problem</u>:
- Two transactions access same item rendering its value incorrect.
<u>Incorrect summary problem</u>: 
- A transaction calculates an aggregate on a number of records while another transaction updates some of these records.
![[Pasted image 20250314093010.png|]]
<u>Unrepeatable read problem</u>:
- A transaction reads the same item twice.
- Another transaction changes the value between first and second read

##### Transactions
A transaction is an ***atomic unit of work*** that is *either completed in its entirety or not done at all*. 
For recovery purposes, the *system needs to keep track of when the transaction starts, terminates, and commits or aborts*!

<u>Transaction states</u>: 
1. Active state
2. Partially committed state
3. Committed state
4. Failed state [^4]
5. Terminated State

[^4]: There can be tons of reasons for this: computer failure, etc.

DBMS supports **ACID** transactions:
$\Rightarrow$
- **Atomic**: Either the whole transaction process is done or none is.
- **Consistent**: Database constraints are preserved.
		*Any transaction that starts on a consistent database leaves it again in a consistent state*.
		*Temporary inconsistency while it is still working is permitted*.
- **Isolated**: It appears to user as if only one transaction process executes at a time. No transaction interferes with another. 
- **Durable**: Effects of a process do not get lost if the system crashes. Changes by a transaction persists and do not disappear. 

###### System log [^5]
[^5]: Often also called a **log** or **journal**.
- A log keeps track *of all transaction operations that affect the values of database items*.
- This information may be needed to permit recovery from transaction failures. 
- Stored on disk. 
- Typically periodically backed up to archival storage (tape) to guard against **catastrophic failures**, e.g. hard disk dies. 
###### Recovery manager
Keeps track of:
- `begin_transaction`
- `read` or `write`
- `end_transaction`
- `commit_transaction`
- `rollback` (or `abort`)

