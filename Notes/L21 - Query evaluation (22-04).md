[[L21 Query Eval DB25.pdf]]

##### Overview of query processing
![[Pasted image 20250429122434.png|400]]


##### Query optimization
Query in SQL is translated into *relational algebra*, which is then <u>optimized</u>. 
*Example*: Translation of nested query
![[Pasted image 20250429122703.png|400]]

##### Query evaluation
<u>Goal</u>: *find the fastest (or least costly in terms of resources) way of retrieving result* 
- which data is needed?
- where is the data?
- how can we retrieve it (e.g. index)?
- how large is the expected result?
- are there different ways of determining the result?

#### Types of selection queries
***Access paths***: indexes (*when deciding what the most efficient data access is*)

##### $\sigma_{C}(R)$
1. *Point query*: Condition is on a single value
$$
\sigma_{\mathrm{ProductID}=42}(Product)
$$
2. *Range range*: Condition is on a range of values
$$
\sigma_{100<\mathrm{Price}<117}(Product)
$$
3. *Conjunction*: Combines logically two conditions with `AND`
$$
\sigma_{\mathrm{Category='Dairy' \ \wedge \ Ma\nu facturer = 'Arla' }}(Product)
$$
4. *Disjunction*: Combines logically two conditions with `OR`
$$
\sigma_{\mathrm{CreationDate<1990 \ \vee \ Ma\nu facturer='FDM'}}(Product)
$$

#### Executing selection for single condition

1. ***Linear search*** (*brute force*)
Retrieve every record in the file, test whether its attribute values satisfy selection condition. 
2. ***Binary search*** (good for *sorted*)
If equality comparison on key attribute on which file is ordered
- Compare value at half file range, then go to earlier half or later half.
1. ***Index-based search*** (best for *equality comparison* - joins)
- Equality comparison on key attribute with primary index (use index)
- Or if comparison condition is $>, \geq, <, \leq$.

#### Executing conjunctions and disjunctions

- If more than one option, <u>always pick most selective condition first</u>, i.e. the one expected to retrieve fewest records most efficiently.
- Use index on query

#### Join
- <u>Most time-consuming operator</u>
- Often natural join or equijoin. 
##### Strategies: 
Work on **per block** (not per record) basis. 
Relation sizes and join selectivities impact join cost. 
$\Rightarrow$
1. <u>Nested loop join</u> (brute force): 
For each tuple in the first table, scan all the tuples in the second table for any matches.  
2. <u>Index-based join</U>
3. <U>Sort-merge join</U>
By sorting each table, it is easier to merge them together by matching. Of course you pay the price of sorting first.
4. <U>Hash join</U>
You invest in hashing and match tuples based on their hash. 

##### Nested loop
$\Longrightarrow$
![[Pasted image 20250429125538.png|450]]

For fastest runtime, you would want to minimize how often you load the larger table, and you would choose the size of the inner relation to be the largest. 

**Runtime**: $b_{O}+b_{O} \cdot \frac{b_{i}}{b_{M}-2}$

##### Index-based join
$\Longrightarrow$
![[Pasted image 20250429133348.png|450]]

#### Algorithms for external sorting

**External sorting**: Sorting algorithms suitable for large files on disk that do not fit entirely in main memory, such as most database files.

##### Sort-merge strategy
$\Longrightarrow$
![[Pasted image 20250429133740.png|450]]

##### Sort-merge join
$\Longrightarrow$
![[Pasted image 20250429133833.png|450]]

##### Hash join
$\Longrightarrow$
![[Pasted image 20250429134757.png|450]]

#### Other operations

##### Projection (*generally straightforward*)
$$
\pi_{\mathrm{Name}}(\mathrm{Customr})
$$
If duplicate elimination necessary then usually done by sorting/hashing then scanning
##### Cartesian product
$$
\mathrm{Custmr \ \times \ Product}
$$
Inherently expensive: need to generate all combinations of tuples
Should be avoided if possible
##### Union, intersection, and difference
Sort and scan
Hash into buckets, check each bucket

#### Combining operations using pipelining
<u>Motivation</u>
- A query is mapped into a sequence of operations
- Each execution of an operation produces a temporary result
- Generating and saving temporary files on disk is time consuming and expensive

#### Aggregate operations
...
[[L21 Query Eval DB25.pdf]] slide 28.
