[[L16 AdvCC.pdf]]
==Topic==: <u>Advanced concurrency control</u>

![[Pasted image 20250325122959.png|600]]

##### Isolation levels
- <u>These are defined for each transaction; not the entire database!</u>

SQL defines 4 *isolation levels*.
`SET TRANSACTION ISOLATION LEVEL`
1. `SERALIZABLE` - slow but high protection
2. `REPEATABLE READ`
Read and write locks on rows but not on range.
*No dirty reads, but more rows may appear*!
3. `READ COMMITTED`
Read and write locks on rows, but read locks are released immediately after reading.
*No dirty reads, but not necessarily the same value every time*!
4. `READ UNCOMMITTED` - faster but more risky
No read locks.
*Dirty reads are possible*!

Transactions that only read can *never violate* seralizability.
Declared in SQL as:
```SQL
SET TRANSACTION READ ONLY;
```

##### Transactions and constraints
- Constraints are checked after modifications
- If violated, the transaction is rolled back
- Sometimes a transaction *must temporarily violate a constraint*:
```SQL
CREATE TABLE Chicken (chickenID INT PRIMARY KEY, eggID INT REFERENCES Egg(eggID));

CREATE TABLE Egg(eggID INT PRIMARY KEY, chickenID INT REFERENCES Chicken(chickenID));
```
A constraint can be declared deferrable by
```SQL
DEFERRABLE INITIALLY DEFERRED
```
- not available in MySQL yet, but e.g. in PostgreSQL.

##### Timestamp protocol
- Manage concurrency as equivalent to *serial execution in timestamp order*.
- Each transaction is given a timestamp when entering system.
- Access to a data item must be in timestamp order. 
==Note==: the **latest** transaction is the **youngest** transaction and the one with the **largest** timestamp. 
$\Rightarrow$ <u> No locking needed!</u>

***Implementation***:
Permit access that follows the timestamp order:
- When T reads X, write_TS(X) must be earlier than timestamp of T
- When T writes X, write_TS(X) **and** read_TS(X) must be earlier.
$\Rightarrow$ Abort T if out of order and restart with a new (later) timestamp

Some implementations include **Thomas' rule**: 
>read_TS(X) $\leq$ T $<$ write_TS(X) $\Rightarrow$ already written!

###### Cascading rollbacks
- One transaction aborting can cause other transactions to abort.
- How to eliminate these cascading rollbacks?

$\Longrightarrow$
###### Strict timestamp based concurrency control
- Transactions should read <u>only</u> commited values.

![[Pasted image 20250325134851.png|600]]

##### Multiversion concurrency control
- Versions are created for each write operation.

**Key idea**:
- Maintain older versions of data items
- When reading, allocate the right version to the read operation of a transaction.
$\Rightarrow$ *Means reads never are rejected*!

**Advantages and disadvantages**:
1. Significantly more storage (RAM and disk) is required to maintain multiple versions
2. Garbage collection is needed to run when old versions no longer needed (induces some overhead)
3. Older versions available for recovery or for temporal databases. 

To ensure serializability, the following two rules are used:

>***Rule 1***: reject T if it attempts to overwrite a version (with the most recent timestamp that is still earlier than its own timestamp, so in the right creation order) if that was already read by a younger T’ (meaning that T’ would then have read out of order)

>***Rule 2:*** If transaction T issues read_item(X), find the version $X_i$ that has the highest write_TS(Xi) of all versions of X that is also less than or equal to TS(T), then return the value of $X_i$ to T, and set the value of read _TS($X_i$) to the largest of TS(T) and the current read_TS($X_i$)

$\rightarrow$ guarantees that a read will never be rejected!

