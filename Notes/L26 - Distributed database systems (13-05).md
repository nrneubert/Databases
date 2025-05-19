[[L26 - DDB2.pdf]]

#### Terminology:

**Homogeneous** *distributed database systems*: 
>All sites of database system have identical setup, i.e. same database system software.
  Underlying operating system may be different. 

**Heterogeneous** *distributed database systems*:
> Federated; each site may run different database system, but the data access is managed through a simple conceptual schema. 
> Multi database; there is no conceptual global schema. 



DDBs need to also handle 
- *maintain global consistency*
- *recover all copies and ensure their consistency*
due to multiple copies and fragmentation of data items.
$\Longrightarrow$ **Concurrency control and recovery** (yet again...)

Leads to concepts such as:
1. *Communication link failure*
2. *Distributed commit* 
3. *Distributed deadlock*

Most straightforward and simple solution is:

##### Primary site
One of the sites is *special* (called **primary** site) and is a coordinator for transaction management. 
Same logic as for centralized (single) databases (*e.g.* 2PL). 

Advantages:
1. Extension of centralized 2PL
2. Data items locked only at one site
3. Can be accessed at any site
Disadvantages:
4. If primary site fails, the entire system is inaccessible. 

$\Rightarrow$ You could use a designated "backup-site" (*shadow*)

#### Primary copy technique
Instead of a site, a data item partition is designated primary copy. 
To lock a data item, just lock the primary copy of it. 

Advantages:
1. Primary copies are distributed across sites, so a single site is not overloaded.
Disadvantages:
2. Identification of a primary copy complex
3. Distributed directory must be maintained, possibly as all sites

#### Coordinator failure
[[L26 - DDB2.pdf]] slide 10
There are various scenarios and actions to take. 

#### Concurrency control based on voting
Lock requests are sent out to all sites that have the data item. 
If the majority of the sites say yes (grants permission) the lock will be acquired. 

Include a time-out period to avoid unacceptably long waits. 
If requesting transaction does not get any vote information it simply aborts. 

Advantages:
1. No primary copy of coordinator
2. Very robust (but also slow!)

#### Two-phase commit (*2PC*)
(*Most used concurrency and recovery scheme*)

>Each node recovers the transaction under its own recovery protocol. 
>If any of these nodes fails or cannot commit the part of the transaction, then the transaction is aborted. 

Global recovery manager / coordinator *maintains information in addition to local logs and tables* (for each database).
**Phase 1**:
- All participating databases signal the coordinator that their part of the transaction is finished. 
- Coordinator sends "prepare for commit" message to all participants. 
- Participants receiving message force-writes all log records to disk. 
	- If done: return "ready to commit" to coordinator
	- If fails: return "cannot commit" to coordinator.
	- No reply is interpreted as "cannot commit".
**Phase 2**:
- If all votes are positive, coordinator sends "commit" message to all participants.
	- Participants commit
- If there is at least one negative (or missing) vote, then send "roll back" message to all participants.
	- Participants undo locally

==Diagram:==
![[Pasted image 20250513133833.png|500]]

**Blocking** can occur if a node fails after receiving a "prepare to commit" message from the coordinator. 

$\Longrightarrow$ *introduce a third phase* (**precommit**) *between voting and global decision*.
>*Means that all participants receiving such a message know that all participants have voted commit*. 
- when receiving votes from all participants, coordinator sends out *precommit message*.
- acknowledge pre-commit messages
- coordinator receives all pre-commits and *then* sends global commit message

==Diagram:==
![[Pasted image 20250513135108.png|500]]


