[[L15 CC DB24.pdf]]

***Goal of concurrency control***: support more than one user / query at the same time.
- **Concurrent**: *allow access to database at the same time in interleaved fashion, but ensure same result*
- **Schedule**: *sequence of operations from one or more transactions*.  

==ACID==: What is concurrency control mostly concerned with?
$\Rightarrow$ Mainly **Isolated** (it appears to user as if only one transaction process executes
at a time), and perhaps also **Atomic** (either the whole transaction process is done or none is).

##### Types of schedules
1. **Serial** schedule: 
> *Schedule S serial if, for every transaction T in S, all operations of T executed consecutively in S*
- Simplest case: each transaction gets its turn to have the database by itself, while others wait

1. **Serializable** schedule:
> *Schedule S serializable if equivalent to some serial schedule of same transactions*

$\Longrightarrow$ these are the ones we want to create: *Fast, mutli-user access and correct results*.

When are two schedules **equivalent**?
$\Rightarrow$ <u>Two schedules are result equivalent, if they produce the same final state of the database</u>. 

Look at the operations in the transactions:
1. Do they interfere with one another?
- Notion of **conflict**.

***Conflict***: Transactions, $T_i \ \ \& \ \ T_j$ conflict, if there exists some item $X$, accessed by both $T_i$ and $T_j$ and at least one of them wrote $X$. 

Let $I$ and $J$ be consecutive instructions by two different transactions within $S$. 
- If $I$ and $J$ do not conflict, their order can be swapped to produce new schedule $S'$. 
	$\Rightarrow$ $S$ and $S'$ are ***conflict equivalent***!

Schedule **conflict serializable**, if conflict equivalent to a serial schedule. 

##### Possible transaction conflicts

1. Write/read conflict
*$T_2$ must be executed after $T_1$ as $T_2$ reads value provided by $T_1$*
2. Read/write conflict
*$T_2$ must be executed after $T_1$, as $T_2$ writes a new value after $T_1$ reads the old value*
3. Write/write conflict
*$T_2$ must be executed after $T_1$, as $T_2$ overwrites value created by $T_1$*
4. No conflict
*No implied execution order of $T_1$ and $T_2$ as both read same value of X*.

##### Precedence graph (serializable graph)

![[Pasted image 20250318124821.png|600]]

==Example==:
![[Pasted image 20250318125126.png|600]]

$\Longrightarrow$

**Testing serializability**: *Schedule is (conflict) serializable if its precedence graph is acyclic*
- An inefficient strategy!

##### Determining serializability
(Practical approach)

Devise **protocols** (methods) to ensure serializability.
- Reduce the problem of checking the whole schedule to checking only a **committed projection** of the schedule.
Current approach used in DBMS': *Use of lock with two-phase locking*.

##### Locks for concurrency control
Locking is an operation which secures:
1. permission to read and/or
2. permission to write a data item for a transaction

$\mathbf{Lock(X)}$: data item $X$ is locked in behalf of the requesting transaction (access permission)
$\mathbf{Unlock(X)}$: data item $X$ is made available to all other transactions
	$\Rightarrow$ ***atomic operations***!

==Note==: Transactions must be **well-formed**, i.e. 
1. must not the data item before it reads or writes to it
2. must not lock an already locked data item 
3. most not unlock a free data item

##### Lock modes
There are two **lock modes**:

1. Shared mode: **shared lock (X)** or **read lock (X)**
More than one transaction can apply shared lock on $X$ for reading its value, but no write lock can be applied on $X$ by any other transaction.

2. Exclusive mode: **exclusive lock (X)** or **write lock (X)**
Only one write lock on $X$ can exist at any time and no shared lock can be applied by any other transaction on $X$.

$\Longrightarrow$ the **two-phase protocol** (==2PL==): *ensures serializability*
***Phase 1*** (growing phase)
- *Transaction may request locks*
- *Transaction may not release locks*

- Can acquire a shared lock or exclusive lock on item $X$
- Can **convert (upgrade)** a shared lock on $X$ to an exclusive lock on $X$.

***Phase 2*** (shrinking phase)
- Transaction may not request locks
- Transaction may release locks

- Can release a shared lock or exclusive lock.
- Can **convert (downgrade)** an exclusive lock to a shared lock.

##### Deadlocks

**Deadlock**: 
A cycle of transactions waiting for one another's unlock (***cycle wait***).
**Deadlock prevention**: 
A transaction locks all data items it refers to before it begins execution.
**Deadlock detection and resolution**
Scheduler maintains wait-for-graph for detecting cycles.
**Deadlock avoidance**:
Avoid deadlock by not letting the cycle complete.

![[Pasted image 20250318131038.png|600]]

![[Pasted image 20250318131108.png|600]]

![[Pasted image 20250318131150.png|600]]

