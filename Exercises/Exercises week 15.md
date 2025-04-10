
#### Exercise validation CC

![[Pasted image 20250410120901.png|600]]

There are three conditions to check. See [[L17 MoreCC.pdf]] and [[L18 - Rec.pdf]]. 
In schedule (a) $T_{1}$ will abort
In schedule (b) $T_{2}$ will abort

#### ## Exercise Multiple Granularity Locking

For each of the granularity hierachies, where T1 has already acquired the locks described in red, answer the following: Can T2 access object f2.2 in X mode? What locks will T2 get?
a)
![[Pasted image 20250410130205.png|400]]
- Yes it is allowed.
- $T_{2}(IX)[R_{1}] \rightarrow T_{2}(IX)[t_{2}] \rightarrow T_{2}(X)[f_{2.2}]$
- and we have to check for compatibility and $IX \ \mathrm{vs.} \ IX$ is okay

b)
![[Pasted image 20250410130227.png|400]]
- No because $T_2$ can not acquire $IX$ on $t_2$ because $T_1$ has an exclusive lock.

c)
![[Pasted image 20250410130238.png|400]]
- Because $IS$ is compatible with $IX$ it is okay for $R_1$. 
- Not allowed to get $IX$ on $t_2$ because it is incompatible with $S$.

d)
![[Pasted image 20250410130249.png|400]]
- Not allowed because $SIX$ is not compatible with $IX$ already on $R_1$. 

#### Exercise Undo/Redo recovery

![[Pasted image 20250410131536.png|600]]

*Redo* all transactions for which log has both “start” and “commit” entries
*Undo* all transactions for which log has “start” entry but no “commit” entry

(a) is a undo
A := 1000
B := 2000

(b) is a undo
C := 700

(c) is a redo
A := 950
B := 2050
C := 600

#### Exercise log records
Explain why log records for transactions on the undo-list must be processed in reverse order, whereas redo is performed in a forward direction on the log.
- *Undo*: to undo all the actions you have to "reverse time", so you take the operations in reverse order.

#### 22.21 Recovery

![[Pasted image 20250410132927.png|600]]

If he uses no-undo / no redo, he will always commit whenever he does something, and that will ensure atomicity. 
