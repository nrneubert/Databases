[[L7 Norm.pdf]]

##### Determining keys using FDs

Using ***the attribute closure*** we can determine keys:
- *If the attribute closure* $X^+$ *contains all attributes of the relation, the attributes* $X$ *are a superkey*. 
- *A* <span style="color: red;"> primary/candidate key</span> *has to be minimal*.

A FD, $a_1, ..., a_n \rightarrow b$, is ***a full functional dependency*** if $a_1,...,a_{i-k}, a_{i+k},...a_n \rightarrow b$ is not a FD for any $k$.
- If a table has a FD, then it also had a full FD. 
- Otherwise ***partial dependency***.
==NB==: also called ***nonreducible***. 

<span style="color: lightblue;"> Now we will talk about how to use FDs to decompose problematic tables. </span>

A proper decomposition should make use of functional dependencies: `userid` $\rightarrow$ `userid, name, group, office`.

$\Rightarrow$ ***Nonadditive Join Decomposition***

A relation $R(a, b, c)$ can be **decomposed** into tables $R_1(a, b)$ and $R_2(a,c)$, where
$$
R_1 = \pi_{a, b}(R)
$$
$$
R_2 = \pi_{a,c}(R)
$$
where $\pi$ denotes a projection to some attributes.

If $a_1,...a_n$ is a superkey for $R_1$ or for $R_2$, then this is called a ***nonadditive join*** decomposition. 

==Example==: nonadditive join on superkey `userid`.
![[Pasted image 20250218124202.png]]

Note information can be lost in decomposition!
$\Rightarrow$ ***Dependency-preserving decomposition*** 
- If each functional dependency in $F$ either appears in one of the relation schemas $R_i$ or can be inferred from the dependencies that appear in some $R_i$.

<u>Formulation</u>
Given $R(a,b,c)$ decomposed into $R_1(a,b)$, $R_2(a,c)$.
Let $F_i$ be set of dependencies in $F^+$ that include attributes in $R_i$, i.e. $F_i=\pi(R_i(F^+))$.
<span style="color: green">If</span>
$$
(F_1 \cup F_2)^+ = F^+
$$
then it is a dependency-preserving decomposition.


##### Normalization of relations
$\rightarrow$ Takes a relation schema through a *series of tests* to *certify whether it satisfies a certain* ***normal form***. 
- Proceeds in a *top-down* fashion from 1st to 4th NF (normal-form)

$\Rightarrow$ **1st normal form** (==**1NF**==)
(Now a part of the formal definition of a relation in the basic (flat) relational model....)

<span style="color:indianred"> Only attribute values permitted are single atomic (or indivisible) values </span>
- i.e. no relation within relation (**nested relation**)

$\Rightarrow$ **Higher normal forms**
2nd, 3rd, ... normal-forms all target dependencies that may cause ***anomalies***!

Properties that the relational schemas should have:
- **Nonadditive join property**
	$\rightarrow$ extremely critical because you could lose your key!
- **Dependency preservation property**
	$\rightarrow$ desirable, but sometimes *sacrificed* for other factors.

$\Rightarrow$ **2nd normal form** (==**2NF**==)
- *Concerned with the mixture of attributes*!
**Prime attribute** is an attribute that is part of a candidate key (otherwise **non-prime**).

***Second normal form*** ensures that attributes are fully dependent on the key, unless they are part of a candidate key themselves.

<span style="color: indianred"> Relation is in 2NF if every non-prime attribute is fully functional dependent on candidate key </span>

==Example==:
![[Pasted image 20250218132954.png]]

==Example==:
![[Pasted image 20250218133603.png]]
Answer is (b) because `Work Location` is ***only*** partially dependent on the candidate key `Name`. 
Depending on the miniworld, you could split the relation into `R1(Name, Work Location)`, `R2(Name, Skill, Task)`. 

$\Rightarrow$ **3rd normal form** (==**3NF**==)

Relation is in 3NF if for every nontrivial FD $X \rightarrow A$, $X$ superkey or $A$ prime attribute. 
- *No non-key attributes determine other non-key attributes*
- *No proper subset of key determines non-key attributes*

==Example==:
![[Pasted image 20250218134251.png]]
becomes
![[Pasted image 20250218134304.png]]

