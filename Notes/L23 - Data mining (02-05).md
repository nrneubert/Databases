[[L23 - DM DB25.pdf]]

We will go from a *transactional* database to a situation where we want to use the information in the database for *understanding the customers* by *learning from* the transactions.
$\Rightarrow$ end goal is to be able to make *business decisions*.

**Data mining**: We want to extract new information or patterns from our data. 
**Data warehouses/marts**: *a database for data analysis purposes*. 
***OLAP***: Online analytical processes

![[Pasted image 20250502084259.png|500]]

##### Definitions of *data mining*

- Discovery of *new information* in terms of patterns or rules from large datasets.
- Process of employing one or more computer learning technique to automatically analyze and extract knowledge from data. 
- May generate thousands of patterns; *not all interesting*
  Pattern is interesting if 
		1. easily understood by humans
		2. valid on new or test data
		3. potentially useful
		4. novel
		5. validates some hypothesis. 
- Objective vs. subjective interestingness measures 
	1. Objective: based on statistics and structures of patterns
	2. Subjective: based on user's belief in the data

#### KDD: *knowledge discovery in databases*

![[Pasted image 20250502084941.png|500]]

#### Types of discovered knowledge

##### Association rule mining
- *Allows you to gain knowledge of associations*

![[Pasted image 20250502085510.png|400]]

To express how interesting rules are:
1. **Support**: percentage of transactions that contain all items in the rule (prevalence)
	- *Probability of a transaction contains all rule items.*
2. **Confidence**: fraction of transactions containing RHS items of the rule to transactions containing LHS items of the rule (strength)
	- *Conditional probability given that LHS items that the RHS items are contained as well.*

##### Mining frequent itemsets
We want to find *all rules* that exceed *two user specified thresholds*:
1. Minimum support
2. Minimum confidence

Firstly, find the **item sets** that are <u>frequent</u>; *those that exceed minimum support threshold*.

**Naïve algorithm**:
- count the frequency of for all possible subsets in the database
- too expensive since there are $2^m$ such item sets. 

**Apriori principle** (*monotonicity*):
- any subset of a frequent item set must be frequent!
*Example*:
if $\mathrm{\{butter,milk\}}$ frequent, then $\mathrm{\{butter\}}$ must also be frequent.
$\Longrightarrow$
>use opposite to exclude possible sets: *any set that is not frequent can not be the subset of a frequent one (downward closure)*.

