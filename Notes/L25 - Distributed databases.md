[[L25 -DDB.pdf]]

How do we scale a database to more than 1 computer node?
How does this work with query evaluation and optimization?

#### Distributed database concepts

**Distributed computing system**:
- Number of processing sites / nodes
- Interconnected by computer network
- Cooperate in performing certain assigned tasks
- Way of using more computing power, but with some overhead in terms of coordination and communication

**Distributed database** (<u>DDB</u>)
- Process unit of execution (transaction) in a distributed manner
- DDB definition:
	1. collection of multiple logically related databases
	2. distributed over computer network
	3. distributed database management system as a software system
		- manages a distributed database
		- makes the distribution ***transparent*** to the user

**Transparency**:
$\Longrightarrow$ Hide implementation details from end users
- Offers flexibility to user and developer
- Users do not worry about operational details of network
	1. *Location transparency*: access from any location
	2. *Naming transparency*: access to any named objects

###### Fragmentation and replication

***Reliability*** refers to system live time:
- System is running efficiently most of the time
***Availability*** is probability that the system is continuously available (usable or accessible) during a time interval.

*Improved performance*:
- Keeps data closer to where it is needed
- Reduces data management time
*Easier expansion* (scalability):
- Allows new nodes to be added anytime without changing the configuration

#### Horizontal fragmentation
- Also called <u>sharding</u>.

It is a *horizontal subset* of relation with tuples that *satisfy selection condition*. 
- May be composed of conditions using `AND` or `OR`.
In relational algebra:
$$
\sigma_{C_{i}}(R)
$$
and you would require that every tuple in $R$ satisfies $C_{1} \vee C_{2}\dots$ (*complete horizontal fragmentation*)
##### Derived horizontal fragmentation
Partitioning of primary relation (e.g. `DEPARTMENT`) to other secondary relations (e.g. `EMPLOYEE`) via foreign keys. 
Related data is fragmented in the same way.

#### Vertical fragmentation

Subset of a relation created by a subset of columns.
- Contains values of *selected columns*.
- No selection conditions!
$\Rightarrow$ Because there is no condition, each fragment *must include the primary key attribute*.

In relational algebra:
$$
\Pi_{L_{i}}(R),
$$
where you would list all the attributes you would want to keep. 

*Complete vertical fragmentation*:
- Set of vertical fragments whose projection lists $L_{1},L_{2},\dots,L_{n}$ include all attributes in $R$ and share only primary key of $R$. 
	1. $L_{1} \cup L_{2} \cup \dots \cup L_{n} = \mathrm{ATTRIBUTES}(R)$
	2. $L_{i} \cap L_{j} = \mathrm{PRIMARY \ KEY}(R) \ \forall i,j$
and you can reconstruct $R$ using `FULL OUTER JOIN`.

#### Mixed (*hybrid*) fragmentation representation
- Combination of vertical and horizontal fragmentation
- `SELECT-PROJECT` operations $\Pi_{L_{i}}(\sigma_{Ci}(R))$


#### Schema

**Fragmentation schema**:
- Definition of a set of fragments (horizontal or vertical or both)
- Includes all attributes and tuples in the database

**Allocation schema**:
- Describes the distribution of fragments to sites of distributed databases
- Fully or partially replicated or partitioned 
	(*Replicated means stored at more than one site*)

$\Longrightarrow$
#### Query processing in DDB
Always transmit the lowest amount of bytes (data) across the network.

**Further optimization using semi-join**: 
- Instead of sending full tables, only send join attributes, then request remaining attribute values for those rows where a join match has been identified. 

##### Distributed computation using *MapReduce*
- Efficient and scalable distributed processing
- Automatically parallelized and executed on large clusters
- Runtime system handles issues in parallelization
- Data model: key-value pair

<u>Steps</u>:
1. *Applies map operation to each record*
2. *Produces intermediate key-value pairs*
3. *Applies reduce to all values with same key*

[[L25 -DDB.pdf]] slide 27
![[Pasted image 20250509101302.png|500]]

*Examples*:
**Inverted index**: [[L25 -DDB.pdf]] slide 28
- e.g. look up a word and find where it occurs.
**Sort-merge join**: [[L25 -DDB.pdf]] slide 29
- most efficient for any equi-join with single join matches in one tables only
