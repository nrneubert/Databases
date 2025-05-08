## Apriori exercise

A.      A database has four transactions. Let _min_support_ = 65% and _min_confidence_= 85%.

|TID|items_bought|
|---|---|
|T1|{K, A, D, B}|
|T2|{D, A, C, E, B}|
|T3|{C, A, B, E}|
|T4|{B, A, D}|

  1. Find all frequent item sets using the Apriori algorithm.
![[IMG_0218.jpg]]

2. For the longest frequent itemset containing A and D, list all association rules, determine their support and confidence, and keep only the ones exceeding both of the above thresholds.

Our longest frequent item set containing A, D is: $\{ A, B, D\}$
All association rules are:
$$
\{ A, B \} , \{A,D\}, \{B,D\}
$$
![[IMG_0219.jpg]]
Due to the minimum thresholds we only keep:
$$
\{A,D\}, \{B,D\}
$$
## K-means exercise

Use the k-means algorithm and Euclidean distance to cluster the following 8 examples into 3 clusters: A1=(2,10), A2=(2,5), A3=(8,4), A4=(5,8), A5=(7,5), A6=(6,4), A7=(1,2), A8=(4,9).

Suppose that the initial seeds (centriods of each cluster) are A1, A4 and A7.

- Run the k-means algorithm for 1 iteration only where at the end you determine the new clusters and compute the centroids of those new clusters. 
![[IMG_0220.jpg]]

- How would the k-means clustering continue and when would it stop?
The point A4 would be swallowed up by the blue cluster, and then it would stop immediately after. So after 2 iterations it would stop. 

- Could there be a different k-means clustering for the same data?
Yes, depending on the initialization. It seems as though it might always be the same (within reason)

## Decision tree exercise

You are given the data in the table below, which describes a few properties of a person and whether that person buys a computer or not.

- Now determine which will be the attribute will be the first split in a decision tree using the above data as your training data.
Total entropy based on if the person buys the computer:
$$
14 = 9(Yes) + 5(No)
$$
then
$$
E(S) =-\frac{9}{14}\log_{2}\left( \frac{9}{14} \right) - \frac{5}{14}\log_{2}\left( \frac{5}{14} \right) = 0.940
$$
Afterwards, we partition each attribute (Age, Income, Student, Credit_rating) into their respective possibilities.
E.g. for Age:
$$
\leq 30: 5=2(Y)+3(N): E(S) = 0.971
$$
$$
31\dots 40: 4=4(Y)+0(N): E(S) = 0.0
$$
$$
>40:5=3(Y)+2(N):E=0.971
$$
Compute information gain:
$$
G_{Age}=0.940 -\frac{5}{14} \cdot 0.971 + \frac{4}{14}\cdot 0 - \frac{5}{14} \cdot 0.971 = 0.246
$$
Do this similarly for all the attributes:
$$
G_{Income} = 0.029
$$
$$
G_{Student} = 0.151
$$
$$
G_{Credit \ rating} = 0.048
$$
and we choose the attribute with the highest information gain (the most decisive of the attributes): Age, and take this was our root. 

- How would the construction of the decision tree continue and when do you stop?
You would choose the $E(T)$ based on which decision you have taken. For example, if you are working on the $Age: \leq 30$, then you have 5 entries to work with, and have to determine whether these 5 are students or not. 

- How do you use the decision tree to classify a new data item?
By following the tree down. 


## **Review Question 29.4**

What is the multidimensional data model?

How is it used in data warehousing?

## **Review Question 29.5**

Define the following terms:

- Star schema
- Snowflake schema
- Fact constellation
- Data marts