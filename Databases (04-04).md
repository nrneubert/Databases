[[L19 RA DB25.pdf]]
==Topic==: Relational algebra
- foundation of SQL

[[L19 RA DB25.pdf]] slide 27.
![[Pasted image 20250404101724.png|600]]

#### Relational algebra
- Basic set of *operations* for the relational model:
$$
\{ \sigma, \pi, \cup, \setminus, \rho, \times \} \qquad \mathrm{(complete \ set)}
$$
- Sequence of relational algebra operations forms *relational algebra expression*.
- A *relation* is like a table where:
	1. all columns have the same generic type
	2. no other constraints are imposed
	3. no order imposed (allow all permutations)
	4. <u>no duplicates are allowed</u>: *set model*!
- A database relation on a data set $D$ consists of
	1. a schema of attribute names $(a_1, a_2,...,a_n)$
	2. a finite $n$-ary relation on $D$, a subset of $D^n$

###### What is an algebra?
Consists of values, operators and rules.



##### Selection
- *Specify a subset of tuples that satisfy a condition*!
	$\Rightarrow$ corresponds to condition in `WHERE` clause.

<U>Notation</U>: $\sigma_C(R)$
- $C$ is a condition on the attributes of R. 
- relation part is: $\{ r \ | \ r \in R \wedge C(r) \}$

*Example*: $\sigma_{\text{type='projector'}}(\text{Rooms})$ returns only tuples that meet the condition. Corresponds to the set
$$
a_1(\text{type}) == \text{'projector'} \ \forall \ \{t_1, t_2, ..., t_n \} \in R=\text{Rooms}.$$

##### Projection
- *Specify a subset of attributes*!
	$\Rightarrow$ corresponds to attributes listed in `SELECT` clause. 

<U>Notation</U>: $\pi_{a_1,...a_n}(R)$
- where schema of $R$ is $(a_1,...a_n, b_1,...b_m)$
- the schema of the result is $(a_1,...a_n)$
- the result relation is $\{ (d_1,...,d_n) \ | \ (d_1, ...,d_{n+m}) \in R \}$

*Example*: $\pi_{\text{group,office}}(\text{People})$ has schema (group,office) and each tuple only has values for these two attributes. 

##### Renaming
$\Rightarrow$ corresponds to `AS`.

<U>Notation</U>: $\rho_{S(b_1,b_2,...,b_n)}(R)$
- to rename relation and attributes.

*Example*: $\rho_{\text{lokale, antal}}(\text{Rooms}) = \rho_{\mathrm{room \rightarrow lokale, capacity \rightarrow antal}}(\text{Rooms})$.

##### Cartesian product
- also called *cross product* or *cross join*.

<U>Notation</U>: $R \times S = (a_1, ..., a_m, b_1, ..., b_n)$
- where the schemas $R = (a_1,...,a_m)$ and $S=(b_1,...,b_n)$.
- the relation part is $\{ (c_1, ..., c_{m+n}) \ | \ (c_1, ..., c_m) \ \in R \ \wedge \ (c_{m+1}, ..., c_{m+n}) \ \in S \}$

##### Union, intersection, difference

![[Pasted image 20250404094847.png|400]]

##### Join
- combine related tuples from two relations into single "longer" tuples. 
- denoted by $\bowtie$
- general join condition of the form $\mathrm{<condition> \ AND \ <condition> \ AND \ ... \ AND \ <condition>}$

*Example*:
$$
\begin{align}
\mathrm{DEPT\_MGR \ \leftarrow \ DEPARTMENT \ \bowtie_{Mgr\_ssn=Ssn} \ EMPLOYEE} \\

\mathrm{RESULT \ \leftarrow \ \pi_{Dname, Lname, Fname}(DEPT\_MGR)}
\end{align}
$$

$\Longrightarrow$ 
###### Formalizing joins
- denoted as *theta join*: $R \bowtie_\Theta S = \sigma_\Theta(R \times S)$
$\Rightarrow$ corresponds to
$$
\begin{align}
\quad \verb|SELECT DISTINCT X1, ..., Xk| \\
\quad \verb|FROM R1, ..., Rn| \\
\quad \verb|WHERE| \ \ \boldsymbol{\Theta}
\end{align}
$$
###### Variations of JOIN
`EQUIJOIN`:
- only "=" comparison operator used.
- pairs of attributes that have identical values in every tuple. 
`NATURAL JOIN`:
- denoted by $*$. 
- corresponds to `EQUIJOIN` on attributes of same name. 

###### Natural Join
<U>Notation</U>: $R * S$
- new schema is $(a_1,...,a_k), c_1,...,c_n, b_1,...,b_m)$
- if $R=(a_1,...,a_k,c_1,...,c_n)$
- and $S=(c_1,...,c_n,b_1,..,b_m)$
- and $\{a_i\} \cap \{ b_i \} = Ø$.

##### Division
Convenient abbreviation for some queries with "all" quantification. 
>*Find all those tuples in first relation that contain all tuples in second relation.* 

Formally this can be expressed as:
$$
A \div B = \pi_x(A) \ \setminus \ \pi_x((\pi_x(A) \times B) \ \setminus \ A)
$$
- returns tuples from $A$ which match all $B$'s tuples in all attributes. 
- result schema is $\text{(attributes of A - attributes of B)} = X$.


