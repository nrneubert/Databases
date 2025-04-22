[[L8 NF.pdf]]

==Note==: In functional dependencies, no `NULL` values are allowed for the join attributes. 
- In general `NULL` values are problematic for decomposition: *no good normalization theory exists*. 

==**1NF**==: Only attribute values permitted are single **atomic** (or **indivisible**) values.
==**2NF**==: Every non-prime attribute is fully functionally dependent on candidate key
	$\Rightarrow$ no partial dependencies
==**3NF**==: For every nontrivial FD: $X \rightarrow A$, then $X$ is a *superkey* or $A$ is a *prime attribute*.
***Prime attribute***: *attribute part of a candidate key*

###### *Minimal cover* of a set of dependencies
- Several sets of dependencies may have the same closure: *Which one to choose as starting point?*

A minimal cover, $G$, for a set of FDs, $F$, is a set of functional dependencies that:
- is **equivalent** to $F$, so that $G^+ = F^+$
- all dependencies are in **canonical form**, so that $a_1, ... a_n \rightarrow b$
- is **minimal**, i.e. if any dependency in $G$ is removed, then $G$ is no longer a cover
- has only **fully functional dependencies**, i.e. if we remove any $a_i$ from a dependency, then $G$ is no longer a cover.

***Obtaining a minimal cover***: 
1. Split RHS to obtain canonical form
2. Remove non-necessary attributes on LHS to obtain minimal FDs
3. Remove any FD that is not needed to maintain cover property

==Example==:
![[Pasted image 20250226085256.png|600]]
##### Algorithm for *relational synthesis* into 3NF

Given relation, $R$, and functional dependencies, $F$
1. Find a *minimal cover* $G$ for $F$.
2. For each LHS $X$ of a FD that appears in $G$:
	- *Create relation $R_1$ with attributes $\{ X \cup \{ A_1 \} \cup \{ A_2 \} ... \cup \{ A_k \} \}$, 
		where $X$ is the key of the relation, and $X\rightarrow A_1, ..., X\rightarrow A_k$ are the only dependencies in $G$ with $X$ as LHS.*
	- *Place remaining attributes in a relation $R_2$*
3. If none of the relation schemas contains a key of $R$, then create one more relation schema that contains attributes that form a key of $R$.
4. Eliminate any redundant relation, i.e., a relation that is a projection to a proper subset of the attributes of another relation. 

==Note==: A 3NF decomposition solution is not unique! There can be multiple minimal covers.


**==Boyce-Codd Normal Form (BCNF)**==: 
For all non-trivial dependencies $a_1, ..., a_n \rightarrow b$, then $a_1, ... a_n$ is a superkey. 
- *In BCNF it is not allowed that $b$ is a prime attribute.*

***Algorithm*** **for BCNF**:
Given relation, $R$, and functional dependencies, $F$
1. Find a FD $X\rightarrow Y$ in $R$ that violates BCNF (else done)
2. Replace $R$ with relation $R_1$ with attributes ($R - Y$) and relation $R_2$ with attributes ($X\cup Y$).
3. Repeat until all relations are in BCNF. 

BCNF decomposition ***is not always dependency preserving***!
	$\Rightarrow$ DBMS can not maintain the dependencies!
However, 3NF ***allows some redundancy***!

$\Rightarrow$ This is the trade-off between BCNF (*stricter normalization / less redundancy*) and 3NF (*less strictly normalized, preserves dependencies*). 

##### Multivalued dependencies (MVD)
- ***Independent*** pieces of information in the same relation!
	*As for FDs, this is known from the real world, not inferred from the schema.*

Instead functional dependencies implies a set of values:
$$
	\mathrm{teacher} \rightarrow \rightarrow \mathrm{course}
$$
or
$$
\mathrm{teacher} \ -\rightarrow \mathrm{course}
$$
$\Rightarrow$ "*A teacher implies a set of courses, but not necessarily a single course value.*"

**Meaning**: For each pair of tuples $t$ and $u$ of $R$ that agree on the $A$'s, we can find in $R$ some tuple $v$ that agrees:
- with both $t$ and $u$ on the $A$'s
- with $t$ on the $B$'s
- with $u$ on the attributes that are not $A$'s or $B$'s

##### Fourth normal form (4NF)
==**4NF**==: $R$ is in 4th normal form if whenever $A_1 A_2 ... A_n \rightarrow \rightarrow B_1 B_2 ... B_m$ is a nontrivial MVD, $\{A_1 A_2 ... A_N\}$ is a superkey. 

***Algorithm*** **for 4NF**:
Given relation $R$, functional and multivalued dependencies $F$
1. If $R$ is not in 4NF (else done) 
	- find a nontrivial MVD $X \rightarrow \rightarrow Y$ that violates 4NF
	- replace $R$ by two relation schemas ($R - Y$) and ($X \cup Y$)
2. Repeat for $R_1$ and $R_2$. 





