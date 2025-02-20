[[L6 FunDep 25.pdf]]

###### High quality databases
We will not identify quality issues and their causes. 

##### Guidelines for good design
- One tables $\rightarrow$ one meaning
	*Design relation schema to make it easy to explain its meaning*
	*Do not combine attributes from multiple entity types*
- Avoid anomalies; else mark and handle in program
	*Note any anomalies clearly and make sure the programs operating will be work correct.*

- It is bad practice to group many attributes together into a **fat** relation.
	$\Rightarrow$ can end up with many `NULL`!
	$\Rightarrow$ wasted storage space
	$\Rightarrow$ needs to be taken into account when querying!

#### Anomalies
There are ***three types*** of anomalies.

1. Insertion anomalies
	- If we want to insert a tuple we must provide consistent attribute values as well or `NULL`s.
2. Modification anomaly
	-  Updating a row may cause inconsistent information unless all redundant values are updated as well
3. Deletion anomalies
	- Deleting a row causes too much information to disappear

***To fix these issues***: ==functional dependencies==
$X\rightarrow Y$ is a constraint on possible tuples forming relation state $r$ of $R$ between sets of attributes, $X, Y \subseteq R$ such that
$$
\mathrm{t_1}[X] = \mathrm{t_2}[X] \rightarrow \mathrm{t_1}[Y] = \mathrm{t_2}[Y]
$$
meaning that if *a value of one (or multiple) set(s) is known, then the other is known as well*. 
This is a property of the **miniworld**. 
E.g. value of zip implies value of city: $\mathrm{8000} \rightarrow \mathrm{Aarhus}$.

###### Properties of FDs
**Trivial**: $a_1,...,a_n \rightarrow b$ for any set of attributes $a_1, ... a_n$.
**Superkey**: $a_1,...,a_n\rightarrow b$ for any $b$ when $a_1, ... , a_n$ is a superkey. 
###### How do we find functional dependencies?
***If we are given a populated table***
	$\rightarrow$ <span style="color: red;">can not determine which FDs hold!</span>
	$\rightarrow$ can state that FD does *not* hold if there are tuples showing violation

***Inferring dependencies***: Given an initial set of dependencies, find all other ones that follow logically
- Initially given FDs called *semantically obvious*.
- Logically deduced FDs called *inferred*.

###### Notation for FDs in anomaly-ridden relations

![[FD-notation.png]]

###### Closure of a Set of Dependencies: $F^+$
==Example==:
$R=(A,B,C,D)$
$F={A\rightarrow B, A\rightarrow C, CD\rightarrow A}$
then logically some members of $F^+$ includes
$F^+={CD\rightarrow B}$

##### Armstrong's axioms
- Used to help compute closures

*Reflexivity*: If $\beta \subseteq \alpha$, then $\alpha \rightarrow \beta$ (for any sets of attributes $\alpha$ and $\beta$)
*Augmentation*: If $\alpha \rightarrow \beta$, then $\gamma \alpha \rightarrow \gamma \beta$
*Transitivity*: If $\alpha \rightarrow \beta$ and $\beta \rightarrow \gamma$, then $\alpha \rightarrow \gamma$

*Union*: If $\alpha \rightarrow \beta$ and $\alpha \rightarrow \gamma$, then $\alpha \rightarrow \beta \gamma$
*Decomposition*: If $\alpha \rightarrow \beta \gamma$, then $\alpha \rightarrow \beta$ and $\alpha \rightarrow \gamma$
*Pseudotransitivity*: If $\alpha \rightarrow \beta$ and $\gamma \beta \rightarrow \delta$, then $\alpha \gamma \rightarrow \delta$

==Example==:
![[ClosureAndKeys.png]]

Because $X'={A,D}$ gives the closure $X'^+={A,B,C,D}$ it is a superkey. If you remove either $A$ or $B$ you do not have a key anymore, hence it is a minimal key and also a candidate key!
