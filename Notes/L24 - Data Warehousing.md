[[L24 - DW DB25.pdf]]

##### *Recap*: Data mining
Discovery of new information (patterns) from data

**Association rule**: 
see [[L23]]

**Clustering**: group objects into sub-groups (clusters)
- Unsupervised (no labels) learning
- "maximize" intra-class similarity and "minimize" interclass similarity
- **K-means***: given $k$, form $k$ groups so that sum of distances between mean elements minimal

**Classification**: Learn model to describe classes and make predictions
(*We already know the groups of (some) data.*)
- Supervised (with labels) learning
- We will see 3 examples:
	1. Decision trees
	2. Neural networks

#### Decision tree
- Flow-chart like graphical representation
- Intuitive and interpretative classification model
*Example*:
![[Pasted image 20250506123456.png|500]]

##### Building a decision tree
Trees are created top-down
>We greedily try to reduce our uncertainty about the class outcome (YES/NO).

Entropy for $k$ classes with frequencies $p_i$ (information theory: measure of uncertainty)
$$
\mathrm{Entropy}(T) = - \sum_{i=1}^{k}p_{i} \log_{2}p_{i}
$$
Compute the information gain of a split using an attribute by comparing the entropy before and after. 
$\Rightarrow$ *always pick the split that reduces uncertainty most*. 
$$
\mathrm{Information \ gain}(T,A) = \mathrm{Entropy}(T) - \sum_{i=1}^{m} \frac{|T_{i}|}{|T|} \cdot \mathrm{Entropy}(T_{i})
$$
##### Evaluation of classifiers
Determine the fraction of correctly predicted class labels (for each object):
$$
\mathrm{classification \ accuracy} = \frac{\mathrm{count(correctly \ predicted \ class \ labels)}}{\mathrm{count(o)}}
$$
$$
\mathrm{classification \ error} = 1 - \mathrm{classification \ accuracy}
$$
**Overfitting**: accuracy worse on entire data than on training data

###### Recap:
###### Navigating a data warehouse
Functionality to navigate and study data:
- Roll-up: *data is summarized with increasing generalization*
- Drill-down: *increasing levels of detail are revealed*
- Pivot: *cross tabulation is performed*
- Slice and dice: *performing projection operations on the dimensions*
- Sorting: *data is sorted by ordinal value*
- Selection: *data is available by value or range*
- Derived attributes: *attributes are computed by operations on stored derived values*

