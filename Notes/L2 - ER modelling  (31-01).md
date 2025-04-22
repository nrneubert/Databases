[[L2 ERMod25.pdf]]

We will be talking about relational models:
- *Effective and captures many situations*
- *Leads to useful yet not too complex query languages*
##### Entity-relationship (ER) modelling
We need a **structured** process to create a well-formed database.
>*Time spent on design is time well spent*

$\Rightarrow$ **ER-diagrams**
- High-level designs with the *key* components sketched
- Can be discussed with customers
We will have:
- Rule of thumb for good design
- Algorithmic conversion into relational schemas. 

Starting point is the ***miniworld***
==NB:== **ER-diagrams** reflect the assumptions made about the *miniworld*. 
Then we need to ***identify***:
- things/objects called **entities** (rectangle)
- descriptive information/properties called **attributes** (oval)
- **relationships** between entities (diamond):
	e.g. how projects *belong to* departments or employees 

***Complex attributes*** can be composed of simpler attributes: $\mathrm{StreetAddress} \Rightarrow \mathrm{Street} \land \mathrm{Number}$
- called **composite attributes**


![[Images/ER_diagram_of_a_company.png|500]]
**Entity set**: a collection of entities with same attributes
**Relationship set**: a collection of relations between entities in these *entity sets*. 

You can also have *attributes* on *relationships*. 
	e.g. *Student* ***attends*** with a *grade* a *Course*. 

Instead of doing this, one could use **multiway relationships**. 
- Depending on the amount of entities connected this can be *binary* (2), *tertiary* (3) and so on. 
For many relations, this can be reduced to a number of *binary relationships*:
![[Images/Reducing to binary relationships.png|500|500]]

Typically having only a single *attribute* to an *entity-set* is a sign of poor design. Always aim for simplicity. 

##### Cardinality ratio in relationship sets
- How many entities *can* be part of a relationship set in *one relation*?
**Many-to-many** (denoted **M:N**)
- Each entity is connected to zero or many entities
- These are called ***cardinality ratios***
For example: A student may attend no, a single or several courses, and a course is attended by zero, a single or several students.

![[Images/Cardinality ratio example.png|200 ]]

**Many-to-one** (**M:1**):
- The first entity determines the second entity (indicated by an arrow)
*For example*: a *Course* is ***taught*** by one *Professor*. 
Once we know the course, we also know the professor ("determined").

**One-one** (**1:1**): 
- Each entity in the relationship determines the other
*For example*: each course is the favorite of one professor, but no two professors have the same favorite course. 

Cardinality ratios can be specified on the ER-diagram.
- alternative notations such as $\min$, $\max$ and $*$ ($\equiv \infty$) can be seen. 

**Total participation** (or *exsistence dependency*):
- Connection is to *exactly* one entity
- Essentially means a minimum cardinality
- Denoted by a double-line
*For example*: Each course is taught by a professor, i.e., there is no course without a professor.

![[Cardinality ratio question.png]]
Answer is most generally *many-to-many*, but if a *person* can not work for several *companies*, then it could be *many-to-one* - which is an optimization from the *many-to-many*.

***Roles***: An entity set may be in several relationships
- called **recursive** or **self-referencing**
- for clarity, label the edges with *role* names
![[Images/Example of roles.png|200]]

***Keys***: A set of attributes that **identifies** entities.
- every entity set *must* have a key
- indicated by underlining the attribute name. 
*For example*: each course is uniquely identified by a course code

==NB:== Any entity set must have a key, but there may be several options for the keys.
It is generally preferred to fewer and reuse existing attributes.
*For example*: A key for a *Course* could be <u>name</u> and <u>year</u>.

**Weak entity sets**: 
- if an entity set has no key, it is a **weak entity set** and must get its key partially from another (*supporting*) entity set through a *many-to-exactly-one*-relationship. 
- indicated by a double rectangle and double diamond. 

![[Images/Weak entity set example.png|400]]

##### Design principles
- Do not use a key from another entity as attribute
	instead use another relationship
- Use attributes instead of entity sets unless:
	it has at least one-key attribute
	it is the many-part in a *many-many* or *many-one* relationship
- Think about which queries you want to answer w.r.t. the level of detail


#### From E/R-models to schemas
Entity set       $\Rightarrow$  table
Attribute       $\Rightarrow$  attribute
Relationship  $\Rightarrow$  table
- where attributes are keys or relationship attributes. 

Use cardinality ratios to simplify
$\rightarrow$ tables with single participation may be combined

To handle weak entity sets, we simply include the supporting entity key as an attribute. 

![[Images/Generating tables from ER-diagram.png|600]]

then we can merge tables to simplify 

![[Generating tables from ER-diagrams fixed.png|600]]

simplify the generated schemas by combining.

Here we assume a *M:1* cardinality relationship
![[Reduce M-1 relationship.png]]

