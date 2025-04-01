[[L17 MoreCC.pdf]]
==Topic==: More concurrency control

![[Pasted image 20250328084612.png|]]
Answer is ==C== because T3 attempts to read(A) before T2, who have already overwritten A, and therefore in regular timestamping it would abort.
If instead it was a W(A), it would still be allowed - but this is not generally the case. 

##### Validation (optimistic) concurrency control
- Most transactions that work on the DB are not in conflict, and we do not need all of this overhead. 
- **Idea**: "do the work" (but *on local copies only*); before committing, check if there are any potential issues, if so, abort and restart, otherwise write changes to database. 
- Serializability <u>only checked at commit time</u>.

<u>Definitions</u>:
$\mathrm{read\_set}(T_1)$ : all objects transaction $T_1$ *reads* to.
$\mathrm{write\_set}(T_1)$ : all objects transaction $T_1$ *writes* to.
$\mathrm{TS(T_i)}$ : timestamp assigned to transaction $T_i$ (at beginning of its validation phase)
###### Validation phase
Check the timestamp ordering with other transactions that recently committed. 
For all other recent $TS(T_j) < TS(T_i)$ one of the three conditions needs to be fulfilled: 

1. $T_j$ completes all three phases *before* $T_i$ begins. 
	$\Rightarrow$ allows $T_i$ to see $T_j$'s changes, but execute in serial order: first $T_j$, then $T_i$. 
2. $T_j$ completes its write phase before $T_i$ starts its write phase, and $T_j$ does not change any item read by $T_i$
$$
\mathrm{write\_set}(T_j) \ \cap \ \mathrm{read\_set}(T_i) = Ø
$$
	$\Rightarrow$ allows $T_i$ to read items while $T_j$ is still modifying items, but $T_i$ does not read any item modified by $T_j$.
	$\Rightarrow$ although $T_i$ might overwrite items written by $T_j$, all of $T_j$'s writes precede all of $T_i$'s writes. 
3. $T_j$ completes its read phase before $T_i$ completes its read phase AND $T_j$ does not write to any item that is either read or written by $T_i$.
$$
\mathrm{write\_set}(T_j) \ \cap \ \mathrm{read\_set}(T_i) = Ø
$$
$$
\mathrm{write\_set}(T_j) \ \cap \ \mathrm{write\_set}(T_i) = Ø
$$
	$\Rightarrow$ allows $T_i$ and $T_j$ to read and write items at the same time, but does not allow $T_i$ to read or write items written by $T_j$. 

##### Multiple granularity locking
- A *lockable unit og data* defines its ***granularity***. 
	*Course*: entire database
	*Fine*: a tuple or an attribute of a relation
- Data item granularity significantly affects concurrency control performance. 

Granularity can be outlined in a hierarchical structure: 
![[Pasted image 20250328095729.png|500]]

To manage such a hierarchy, *three additional locking modes* are defined: ***Intention lock modes***

1. Intention-shared (IS): *shared lock will be requested on some descendant node(s)*
2. Intention-exclusive (IX): *exclusive lock(s) will be requested on some descendant node(s)*
3. Shared-intention-exclusive (SIX): *the current node is locked in shared mode, but an exclusive lock(s) will be requested on some descendant node(s)*

Locks are applied using a compatibility matrix:
==Slide 23==.

There exists a set of rules to follow in order to produce serializable schedules using multiple granularity locking:
==Slide 24==.

**Example**:
![[Pasted image 20250401123444.png|250]]
*Note*: 
- both $T_1$ and $T_2$ can have $IX(f_1)$ because they are intentions and no one have an exclusive lock on $f_1$ yet.
- in shrinking phase it is reversed; you unlock from the bottom and up until the database node, e.g. $f_2$. 

###### Multiversion Two-Phase Locking Using Certify Locks

Allow a transaction $T’$ to read a data item $X$ while it is write- locked by a conflicting transaction $T$.

This is accomplished <u>by maintaining two versions of each data item</u> $X$, where one version must have been written by some committed transaction

In [[L17 MoreCC.pdf]] slide 29, there are steps for concurrency control for this model. 

##### Snapshot isolation
- *almost* as good as serializable. 
Transactions see data items based on committed values of the items in the database snapshot *when transaction start*.
Any changes after transaction start can *not* be seen.

No read locks are needed, <u>only</u> write locks.

$\Rightarrow$ 
No phantom reads, dirty reads, or non-repeatable read as only committed values are seen. 
- rare anomalies can occur!

