![[Pasted image 20250327121512.png|600]]

| $T_1$ | $T_2$ | \|  | $T_1$ | $T_2$ |
| ----- | ----- | --- | ----- | ----- |
|       | r(m)  | \|  | r(m)  |       |
| r(m)  |       | \|  | r(n)  |       |
| r(n)  |       | \|  | w(m)  |       |
| w(m)  |       | \|  |       | r(m)  |
|       | r(n)  | \|  |       | r(n)  |
|       | w(m)  | \|  |       | w(m)  |
|       | w(n)  | \|  |       | w(n)  |

![[Pasted image 20250327121703.png|600]]

***Strict***: Exclusive locks unlocked after terminating (commit / abort and rollback)
- In both schedules due to uncommitted transactions *strict 2PL* will not allow the schedule. 
- You could commit after the first write, but the exercise does not allow for this. It would also be weird.  

![[Pasted image 20250327122711.png|600]]

***Conflict serializable***: Two transactions are run intertwined, but the outcome is consistent. A consistent alternative to (slow) serial transactions.

(a)  This one does not work. It is cyclic from $T_1 \rightarrow T_3 \rightarrow T_1$

| $T_1$ | $T_2$ | $T_3$ |
| ----- | ----- | ----- |
| r(x)  |       |       |
|       |       | r(x)  |
| w(x)  |       |       |
|       | r(x)  |       |
|       |       | w(x)  |
(b) This one is not conflict serializable because cycle $T_1 \rightarrow T_3 \rightarrow T_1$

| $T_1$ | $T_2$ | $T_3$ |
| ----- | ----- | ----- |
| r(x)  |       |       |
|       |       | r(x)  |
|       |       | w(x)  |
| w(x)  |       |       |
|       | r(x)  |       |


(c) This one is conflict serializable. A serializable example is shown to the right

| $T_1$ | $T_2$ | $T_3$ | \|  | $T_1$ | $T_2$ | $T_3$ |
| ----- | ----- | ----- | --- | ----- | ----- | ----- |
|       |       | r(x)  | \|  |       | r(x)  |       |
|       | r(x)  |       | \|  |       |       | r(x)  |
|       |       | w(x)  | \|  |       |       | w(x)  |
| r(x)  |       |       | \|  | r(x)  |       |       |
| w(x)  |       |       | \|  | w(x)  |       |       |

(d) This one is not serializable because the cycle $T_1 \rightarrow T_3 \rightarrow T_1$

| $T_1$ | $T_2$ | $T_3$ |
| ----- | ----- | ----- |
|       |       | r(x)  |
|       | r(x)  |       |
| r(x)  |       |       |
|       |       | w(x)  |
| w(x)  |       |       |

**Trick**: Look at all writes and check for any reads that happen before. For each write that happens after another transactions read, the read transaction must happen BEFORE the write transaction.   
