[[L22 QueryOptim DB24.pdf]]

Transform query into faster, equivalent query:
![[Pasted image 20250430133707.png|400]]

1. *Heuristic* (logical) optimization
	- Optimization of query tree (relational algebra)
	
2. *Cost-based* (physical) optimization
	- Optimization by looking directly at the database structure

#### Using heuristics in *query optimization*
***Main heuristic***: 
$\Longrightarrow$
>*Apply first the operations that reduce the size of intermediate results*.

Process for *heuristics* optimization:
1. Parser of high-level query generates initial internal representation
$$
\mathrm{SQL \Longrightarrow Relational \ algebra }
$$
2. Apply heuristics rules to optimize internal representation
3. Generate query execution plan to execute groups of operations
##### Query trees
- Tree data structure corresponding to relational algebra expression
- Input relations as leaf nodes
- Operations as internal nodes

![[Pasted image 20250430134332.png|400]]

We can then apply our rule (***applying selections early***) by pushing these operations *down* the tree. 
*Example*:
![[Pasted image 20250430140022.png|400]]

***and*** we can also optimize by ranking our *selections* after *how restrictive* they are. 
>$\Rightarrow$ more restrictive selections earlier!

***and*** we can also instead of using $\times$ (cartesian product) followed by $\sigma_{condition}$ form joins by using $\bowtie_{condition}$.

***and*** we can push projections *down* the tree as far as possible. Remember, we do not want to carry around unnecessary information. For that reason, we can also introduce any additional projections. 

#### General transformation rules
([[L22 QueryOptim DB24.pdf]] slide 17)

1. Cascade of $\sigma$: break up conjunctive selection into sequences
2. Commutativity of $\sigma$
3. Cascade of $\pi$: in cascade of $\pi$ operations, all but the last one can be ignored
4. Commuting $\sigma$ with $\pi$: if selection condition involves only attributes in projection list, the two operations can be commuted.
5. Commutativity of $\bowtie$ (and $\times$)
6. Commuting $\sigma$ with $\bowtie$ (or $\times$)
7. Commuting $\pi$ with $\bowtie$ (or $\times$)
8. Set operations $\cap, \cup$, but not for $\setminus$
9. Associativity of $\bowtie,\times,\cup,\cap$
10. Commuting $\sigma$ with set operations
11. The $\pi$ operation commutes with $\cup$
12. ...

#### Cost-based *query optimization*
(*upsides*)
- Estimate and compare costs of executing a query using different execution strategies
- Can "learn" from data stored in the database
***but*** (*downsides*)
- need to consider a number of different strategies
- need to define **cost function**

##### Approach

1. Transformations to generate *multiple* candidate query trees from initial tree.
2. Statistics on the inputs to each operator needed. 
	- on leaf relations stored in system catalog
	- on intermediate relations needs to be estimated
3. Cost formulas estimate cost of executing each operation in each candidate query tree
	- could be CPU time, I/O time, communication time, main memory usage, or a combination

Relevant statistics could be:
- number of distinct values of an attribute (think joins and so on)
- number of levels in an index

##### Statistics used as input to cost
>The cheat sheet on Brightspace is your friend. 

<u>Catalog information</u>
1. Information about the size of a file
	- number of records: $r$
	- record size: $R$
	- number of blocks: $b$
	- blocking factor ($bfr$): how many records per block
2. Information about indexes and indexing attributes of a file
	- number of levels ($x$) of each multilevel index
	- number of first-level index blocks: $bl1$
	- number of distinct values ($d$) of an attribute
		(can be used to estimate the selectivity)
	- selectivity ($sl$) of an attribute
	- selection cardinality ($s$) of an attribute ($s=sl\cdot r$)

