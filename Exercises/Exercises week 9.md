
-----
##### 14.27
Consider a relation $R(A,B,C,D,E)$ with the following dependencies:
$$
AB\rightarrow C, \quad CD\rightarrow E, \quad DE\rightarrow B
$$
Is $AB$ a candidate key of this relation? If not, is $ABD$? Explain your answer.

-------------
For $AB$ to be a candidate key, 
1. You need to be able to 'hit' all the remaining attributes (superkey)
2. Minimal key
In notation: $AB⁺ = \{ A, B, C, D, E\}$

Because $AB⁺ = \{ A, B, C \}$ it is <u>not a candidate key</u>. 
Now: $ABD⁺ = \{ A, B, C, D, E \}$
Is it also a minimal key? If we remove either $A$, $B$ or $D$ it is not a superkey. 
$\Rightarrow$ $ABD$ is a candidate key. 


-----
##### 15.21
Consider the relation `REFRIG(Model#, Year, Price, Manuf_plant, Color)`, which is abbreviated as `REFRIG(M, Y, P, MP, C)`, and the following set $F$ of functional dependencies $F=\{ M\rightarrow MP, \quad \{ M, Y \} \rightarrow P, \quad MP \rightarrow C\}$

---------
**a)** *Evaluate each of the following as a candidate key for `REFRIG`, giving reasons why it can or cannot be a key:*
1. $\{M\}$
Now: $\{M\}⁺ = \{ M, MP, C \}$, <u>it can not be a key</u>.

2. $\{M,Y\}$
Now: $\{M,Y\}⁺ = \{ M, MP, P, Y, C\}$
and if we remove either $M$ or $Y$ it is not a key anymore, and <u>therefore it is a candidate key</u>.

3. $\{M,C\}$
Now: $\{ M,C \} = \{ M, MP, C \}$, <u>it can not be a key</u>.

**b)** *Based on the above key determination, state whether the relation `REFRIG` is in 3NF and in BCNF, and provide proper reasons.*
3NF: For every nontrivial FD: $X \rightarrow A$, then $X$ is a *superkey* or $A$ is a *prime attribute*.
BCNF For all non-trivial dependencies $a_1, ..., a_n \rightarrow b$, then $a_1, ... a_n$ is a superkey. 

In $MP\rightarrow C$, the LHS is not part of a key, hence <u>it is not in 3NF nor BCNF</u>. 

**c)** *Consider the decomposition of `REFRIG` into $D=\{R_1(M,Y,P), \quad R_2(M,MP,C)\}$. Is this decomposition lossless? Show why.*
Check if either:
- $(R_1 \cap R_2) \rightarrow (R_1 - R_2)$ is in $F^{+15}$
- $(R_1 \cap R_2) \rightarrow (R_2 - R_1)$ is in $F⁺$
NB: 
- $\cap$ means intersection denoting the common elements in both sets.
- $(R_1-R_2)$ means the attributes that are in $R_1$ but not in $R_2$.
- $F⁺$ denotes all the functional dependencies (closure) of the set.

Now: 
$(R_1 \cap R_2) = \{ M \}$
$(R_1-R_2) = \{ Y, P \}$ 
$(R_2-R_1) = \{MP ,C \}$
Does
1. $\{ M \} \rightarrow \{ Y, P \}$: ***no***
2. $\{ M \} \rightarrow \{ MP, C \}$: ***yes***

$\Rightarrow$ *yes it is a lossless decomposition*.

----
##### 14.22
Given the relation $R$ with three attributes $XYZ$ for each of the following sets of functional dependencies, identify the best normal form that $R$ satifies (1NF, 2NF, 3NF, BCNF)

-----
1NF: Only attribute values permitted are single **atomic** (or **indivisible**) values.
2NF: Every non-prime attribute is fully functionally dependent on candidate key
	$\Rightarrow$ no partial dependencies
3NF: For every nontrivial FD: $X \rightarrow A$, then $X$ is a *superkey* or $A$ is a *prime attribute*.
***Prime attribute***: *attribute part of a candidate key*
BCNF: For all non-trivial dependencies $a_1, ..., a_n \rightarrow b$, then $a_1, ... a_n$ is a superkey. 

1. $Z\rightarrow X, \quad Z\rightarrow Y$
1NF is satisfied.
2NF is satisfied because $X,Y$ both depends on $Z$.
3NF is satisfied because because all LHS' contain $Z$.
BCNF is satisfied because the above. 

2. $Y\rightarrow Z$
1NF is satisfied.
2NF is not satisfied because $Y$ is not a candidate key

3. $XYZ \rightarrow Z, \quad Z\rightarrow X$
1NF is satisfied.
2NF is satisfied because $Z$ is part of a candidate key.
3NF is satisfied because $X$ is a prime attribute
BCNF is not satisfied because $Z$ is not a superkey. 

---
##### Exercise 14.34
Consider the following relation:
`CAR_SALE(Car_id, Option_type, Option_listprice, Sale_date, Option_discountedprice)`

This relation refers to options installed in cars (e.g., cruise control) that were sold at a dealership, and the list and discounted prices of the options.
If
- $\text{CarId}\rightarrow \text{Sale\_date}$
- $\text{Option\_type} \rightarrow \text{Option\_listprice}$
- $\text{CarID, Option\_type} \rightarrow \text{Option\_discountedprice}$,
argue using the generalized definition of the 3NF that this relation is not in 3NF. 
Then argue from your knowledge of 2NF, why it is not even in 2NF. 

-----




