[[L18 - Rec.pdf]]

==Topic==: Recovery
$\Rightarrow$ handling ***failures***!

<u>Types of failures</u>:
1. System crash
2. Transaction or system error
3. Local errors, non-handled exception condition
4. Concurrency control enforcement (deadlock handling, serializability violation, ...)
5. Disk failure
6. Physical problems

**Goal**: $\Longrightarrow$ *maintain ACID properties when things go wrong*!

**Need to consider**:
1. Where does the crash happen?
	- Do not know which instruction executed last
2. Multiple, concurrent users?
3. Buffer management 

$\Longrightarrow$
##### Buffer pool management
Database operates:
1. Load data from disk (I/O) to do work in main memory.
	- Creates "dirty pages" that contain changes not yet written to disk
		(*Dirty because they are not yet written to disk, if lost they will not persist*!)
2. Operating system (OS) will write to disk at some point in time. 

##### Log-based recovery
- keep track of modifications of the data
- log stored in <u>stable storage</u>.

Log manager records important events in a log:
1. When transaction starts
2. When transaction modifies data
3. When transaction reaches last statement

<u>To yield better performance, the log can also be stored</u> ***in cache***!

###### Undo/redo algorithm
Following a failure, the following is done:
1. Redo all transactions for which log has both "start" and "commit" entries
2. Undo all transactions for which log has "start" entry but no "commit" entry. 

*Note*: 
-  In multitasking system, more than one transaction may need to be undone
- If a system crashes during recovery, the new recovery must still give correct results (*idempotent*).
	$\Rightarrow$ recoveries are also written to log!

An alternative could be
$\Longrightarrow$
###### No-undo/redo (deferred database modification)
Algorithm:
1. Do not output values to disk until commit log entry on stable storage. 
2. All writes go to log and to database cache.
3. Sometime after commit, cached values are output to disk. 

<u>Advantages</u>:
- Faster recovery: no undo
- No before images needed in log
<u>Disadvantages</u>:
- Database outputs must wait
- Lots of extra work at commit time

An alternative could be
$\Longrightarrow$
###### Undo/no-redo
Algorithm:
1. All changed data items output to disk before commit
- At commit: 
	2. Output (flush) all changed data items in cache
	3. Add commit entry to log

An alternative could be
$\Longrightarrow$
###### No-undo/no-redo
Algorithm:
1. No-undo $\rightarrow$ do not change the database during a transaction
2. No-redo $\rightarrow$ on commit, write changes to the database in a single atomic action

<u>Advantages</u>:
1. Recovery is instantaneous
2. No recovery code need be written

However, *not very common approach* because crashes are *rare events*, and you want to optimize for the direct work on the DBMS. You do not want to force these things. 

##### Strategies for Buffer Pool Management

***Steal strategy***: 
*Cache can be flushed before transaction commits*
$\Rightarrow$ steal $\simeq$ undo
***Force strategy***: 
*At the time of commit you have to write out to disk, and you then avoid any redo*. 
$\Rightarrow$ no-force $\simeq$ redo

**Corresponds to different ways for handling recovery**:
1. Steal/No-Force (Undo/Redo)
2. Steal/Force (Undo/No-redo)
3. No-Steal/No-Force (Redo/No-undo)
4. No-Steal/Force (No-undo/No-redo)

##### ARIES recovery algorithm
Based on 3 concepts:
1. WAL (Write Ahead Logging)
	- We write to the same original location and disk. 
2. Repeating history during redo
3. Logging changes during undo