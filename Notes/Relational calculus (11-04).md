[[L20 RC DB25.pdf]]

##### OUTER JOIN operators
Left outer join: $R \loj S$
Right outer join: $R \roj S$
Full outer join: $R \foj S$

![[Outer-Join.jpg|300]]
- marks on the side of bowtie indicate the relation to keep all tuples in. 
##### Recursive queries
Operation applied to recursive relationship between tuples of same type. 

$\rightarrow$ can not compute the transitive closure of a binary relation $R$. 
(***e.g.*** we can not handle an indefinite number of joins)
- *means that relational algebra is not* <u>Turing complete</u>.
- *but that also means easier to optimize queries*!

#### Relational calculus
Relational algebra *describes sequence of operations* to derive the desired results.
Relational calculus based on *first-order predicate calculus*.
$\rightarrow$ relational calculus *more declarative, specifying what is desired*

**Main difference is**: *at what level of detail we operate at*. 
Two forms of calculi:
1. Tuple relational calculus (==TRC==)
2. Domain relational calculus (==DRC==)

##### Tuple variables and range relations

***TRC*** expresses results as sets of tuples that satisfy a condition. 
$$
\{ \ t \ | \ \mathrm{COND(t)} \ \}
$$
Or in a more general expression where $A_i$ are attributes in tuple $t_j$
$$
\{ \ t_{1}.A_{j}, t_{2}.A_{k}, \dots, t_{n}.A_{m} \ | \ \mathrm{COND}(t_{1},t_{2},\dots,t_{n}, t_{n+1}, t_{n+2}, \dots, t_{n+m}) \ \}
$$

Boolean conditions are:
- made up of one or more **atoms** connected via **logical operators**: `AND`, `OR`, `NOT`; written as $\wedge, \vee, \neg$

*Example*: List all information about expensive products
$$
\{ \ t \ | \ \mathrm{Product}(t) \wedge t.\mathrm{Price} > 1000 \ \}
$$
*Example*: List the names of dairy products costing more than 1000
$$
\{ t.\mathrm{name} \ | \mathrm{Product}(t) \wedge t.\mathrm{category} = '\mathrm{Dairy}' \wedge t.\mathrm{Price} > 1000 \}
$$

We can also use **quantifiers**:
1. Universal quantifier $\forall$; true if true for every tuple
2. Existential quantifier $\exists$; true if true for any tuple

*Example*: List the products where there is at least one purchased item from the products category
$$
\{ \ t \ | \ \mathrm{Product}(t) \wedge \exists s \ (\mathrm{Purchased}(s) \ \wedge \ t.\mathrm{Category} = s.\mathrm{Category}) \ \}
$$

***Practice queries***:
*List the names of customers who have purchased a product*
$$
\{ \ t.\mathrm{name} \ | \ \mathrm{Customr}(t) \wedge \exists s(\mathrm{Purchased}(s) \wedge t.\mathrm{CustomrId}=s.\mathrm{CustomrId}) \ \}
$$
*List the IDs of expensive purchased products*
$$
\{ \ t.\mathrm{ProductId} \ | \ \mathrm{Product}(t) \wedge \exists s(\mathrm{Purchased}(s) \wedge s.\mathrm{CustomrId} = t.\mathrm{CustomrId}) \wedge t.\mathrm{Price} > 1000 \ \}
$$
*List the customers who have purchased all soy products*
$$
\{ \ c.\mathrm{Name} \ | \ \mathrm{Customr}(c) \wedge \forall f(\mathrm{Product}(f) \wedge f.\mathrm{Category}= '\mathrm{Soy}' \Rightarrow (\exists r(\mathrm{Purchased}(r) \wedge r.\mathrm{ProductId}=f.\mathrm{ProductId} \wedge r.\mathrm{CustomrId} = c.\mathrm{CustomrId}))) \ \}
$$

#### Transforming expressions
Transform one type of quantifier into other with negation (preceded by `NOT`). 
*Example*:
$$
\forall x(\mathrm{Cat}(x)) = \neg \exists x(\neg \mathrm{Cat}(x))
$$
![[Pasted image 20250422133236.png|400]]

*Example usage*: Find the product(s) with maximum price - without using a maximum (or minimum) operator!
$$
\{ \ p \ | \ \mathrm{Product(p)} \wedge \neg \exists s(\mathrm{Product}(s) \wedge s.\mathrm{Price} > p.\mathrm{Price}) \ \}
$$
*or you could check if all other have a lower price*.

#### Safety
Possible to write tuple calculus expression that generates infinite relations. 
*Example*:
$$
\{  \ t \ | \ \neg r(t) \ \}
$$
results in infinite relation if the domain of any attribute of relation $r$ is infinite.
For example:
$$
\{ \ t \ | \ \neg \mathrm{Employe}(t) \ \}
$$
for all tuples which are not employees: infinitely many!

**An expression is safe if** all values in its result are from the domain of the expression. 
$\Rightarrow$ <u>make sure to limit to domain</u>!

### Domain relational calculus

Domain relational calculus differs from tuple calculus in the type of variables used in formulas. 
Rather than variables ranging over tuples, now it is *ranging over single values* from *domains of attributes*. 

*Example*: Product has 4 attributes, and hence a query would be
$$
\{ I, N, P, C \ | \\mathrm{Product}(I,N,P,C) \wedge P > 1000 \}
$$
or in general:
$$
\{  x_{1}, x_{2}, \dots, x_{n} \ | \ P(x_{1}, x_{2}, \dots, x_{n}) \}
$$
*Example*: List the names of the expensive products
$$
\{  N \ | \ \exists I \ \exists P \ \exists C \ (\mathrm{Product}(I,N,P,C) \wedge P > 1000 ) \}
$$

Why is this any good? *Because we can match rows explicitly*
$$
\{ \ I, N, P ,C \ | \ \mathrm{Product}(I,N,P,C) \wedge \exists x,y,w \ (\mathrm{Product}(x,y,P,w)) \ \}
$$
meaning we match $z=P$. 
