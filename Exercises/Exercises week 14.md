
##### Exercise 21.26
Consider the following two transactions. Analyze the following schedule and explain whether T2 operations are updated successfully when T1 is rolled back.

| $T_1$      | $T_2$      |
| ---------- | ---------- |
| read(X)    |            |
| X := X - 2 |            |
| write(X)   |            |
|            | read(X)    |
|            | X := X + 3 |
|            | write(X)   |
| ROLLBACK   |            |
|            | COMMIT     |

It depends on the isolation level of the system. 
`READ UNCOMMITTED`: would allow for $T_2$ to perform a dirty read *after* $T_1$ has changed $X$. 
`READ COMMITTED`: would not allow $T_2$ to perform a dirty read, because $T_2$ can not read the write(X) from $T_1$ before it is finally commited. 

#### Exercise 20.16
Add the operation commit at the end of each of the transactions and then give an example of a schedule of each of the following types:

| $T_1$      | $T_2$      |
| ---------- | ---------- |
| read(X)    | read(X)    |
| X := X - N | X := X + M |
| write(X)   | write(X)   |
| read(X)    |            |
| Y := Y + N |            |
| write(Y)   |            |

- Recoverable
No commit until all transactions that have written an item that is read have committed also

| $T_1$      | $T_2$      |
| ---------- | ---------- |
| read(X)    |            |
| X := X - N |            |
| write(X)   |            |
| read(X)    |            |
|            | read(X)    |
|            | X := X + M |
|            | write(X)   |
| read(Y)    |            |
| Y := Y + N |            |
| write(Y)   |            |
| *commit*   |            |
|            | *commit*   |

- Non-recoverable

| $T_1$      | $T_2$      |
| ---------- | ---------- |
| read(X)    |            |
| X := X - N |            |
| write(X)   |            |
| read(X)    |            |
|            | read(X)    |
|            | X := X + M |
|            | write(X)   |
|            | commit     |
| read(Y)    |            |
| Y := Y + N |            |
| write(Y)   |            |
| commit     |            |


- Cascadeless
read only items written by committed transactions.
$T_2$ must *not* read any uncommitted items 

| $T_1$      | $T_2$      |
| ---------- | ---------- |
| read(X)    |            |
| X := X - N |            |
| write(X)   |            |
| read(X)    |            |
| read(Y)    |            |
| Y := Y + N |            |
| write(Y)   |            |
| *commit*   |            |
|            | read(Y)    |
|            | Y := Y + N |
|            | write(Y)   |
|            | *commit*   |


- Strict
 neither read or write item until the last transaction that wrote it has committed.

| $T_1$      | $T_2$      |
| ---------- | ---------- |
| read(X)    |            |
| X := X - N |            |
| write(X)   |            |
| read(X)    |            |
| read(Y)    |            |
| Y := Y + N |            |
| write(Y)   |            |
| *commit*   |            |
|            | read(Y)    |
|            | Y := Y + N |
|            | write(Y)   |
|            | *commit*   |

#### Exercise 20.20
Consider the Employee database schema:
`Staff(sid, sname, position, age, did)`
`Department(nane, address, room, did)`
`Project(pnum, pname)`
`Customer(cid, cname, orderid)`
For each of the following transactions, state and explain the SQL isolation level that is suitable for each transactions.

1. Insert a staff identified by his/her id into the department named 'Marketing'
Probably `REPEATABLE READ` because you need a lock on rows but not on range. 
For most safe procedure `SERIALIZABLE` could also be favored.

2. Change department for a staff identified by his/her id from one department to another department.
For others to have consistent results when pulling data from departments, you need a lock on the rows: `REPEATABLE READ`.

3. Find the total number of customers for an executive report on the overall market development. 
Seeing as though it is a "report", it may allow for some errors: phantom or dirty reads. It depends on the usage.
Either `READ COMMITED` or if you are feeling cool `READ UNCOMMITED`. 

#### Exercise 21.25
Apply the timestamp ordering algorithm to the schedules in Figures 21.8(b) and determine whether the algorithm will allow the execution of the schedules.
![[Pasted image 20250403133622.png|500]]
Assume read_TS(x) = 0, read_TS(y) = 0, read_TS(z) = 0, write_TS(x) = 0, write_TS(y) = 0, write_TS(z) = 0.
TS(T1) = 6, TS(T2) = 1, TS(T3) = 4

| Timestamp | $T_1$    | Allowed | Comparison                                   | Update          |
| --------- | -------- | ------- | -------------------------------------------- | --------------- |
| 6         | read(X)  | Yes     | 6 > write_TS(X) = 0                          | read_TS(X) = 6  |
| 6         | write(X) | Yes     | 6 >= read_TS(X) = 6 AND 6 >= write_TS(X) = 0 | write_TS(X) = 6 |
| 6         | read(Y)  | Yes     | 6 >= write_TS(Y) = 0                         | read_TS(Y) = 6  |
| 6         | write(Y) | Yes     | 6 >= read_TS(Y) = 6 AND 6 >= write_TS(Y) = 6 | write_TS(Y) = 6 |

| Timestamp | $T_2$    | Allowed | Comparison                                   | Update          |
| --------- | -------- | ------- | -------------------------------------------- | --------------- |
| 1         | read(Z)  | Yes     | 1 >= write_TS(Z) = 0                         | read_TS(Z) = 1  |
| 1         | read(Y)  | Yes     | 1 >= write_TS(Y) = 0                         | read_TS(Y) = 1  |
| 1         | write(Y) | Yes     | 1 >= read_TS(Y) = 1 AND 1 >= write_TS(Y) = 0 | write_TS(Y) = 1 |
| 1         | read(X)  | Yes     | 1 >= write_TS(X) = 0                         | read_TS(X) = 1  |
| 1         | write(X) | Yes     | 1 >= read_TS(X) = 1 AND 1 >= write_TS(X) = 0 | write_TS(X) = 1 |


| Timestamp | $T_3$    | Allowed | Comparison                                   | Update          |
| --------- | -------- | ------- | -------------------------------------------- | --------------- |
| 4         | read(Y)  | Yes     | 4 >= write_TS(Y) = 0                         | read_TS(Y) = 4  |
| 4         | read(Z)  | Yes     | 4 >= write_TS(Z) = 0                         | read_TS(Z) = 4  |
| 4         | write(Y) | Yes     | 4 >= read_TS(Y) = 4 AND 4 >= write_TS(Y) = 1 | write_TS(Y) = 4 |
| 4         | write(Z) | Yes     | 4 >= read_TS(Z) = 4 AND 4 >= write_TS(Z) = 0 | write_TS(Z) = 4 |

so none of the transactions will be aborted. 