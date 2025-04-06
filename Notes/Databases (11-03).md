[[L13 IR+Web DB25.pdf]]

###### Information Retrieval and Web Search

#### Information retrieval (IR)
- Process of *retrieving documents* from a *collection* in *response to a query* by a user.
- Unstructured data (<u>distinction</u> *between highly structured DBMS*)
- **Free-form search request** (unstructured)
- **Keyword search query**

$\Rightarrow$ high noise-to-signal ratio: ***many irrelevant texts***!

<u>Unstructured</u>: lack of meta data (*what is the intent of the query?*)

 Simplest and most commonly used forms of IR queries:
 1. Keyword queries
 2. Boolean queries

<u>Keyword queries</u>:
**Keywords** implicitly connected by a logical `AND` operator
- Remove ***stop words***: of, to, a, and (>80% of documents)
- Removal must be performed before indexing

<u>Boolean queries</u>: 
`AND`: both terms must be found
`OR`: either term found
`NOT`: record containing keyword omitted

Indexes are best to base on *search terms*, i.e. keywords!

**Inverted index**: *attaches distinct terms with a list of all documents that contains term*.
<u>Construction</u>:
- break documents into vocabulary terms by *tokenizing, cleaning, stopword removal, stemming, ...*
- derive frequency counts and other statistics
- turn document-term representation into a term-document representation. 

**Simplified IR process pipeline**

![[Pasted image 20250311124205.png|500]]


How *indicative* is a *search-term* for a ***specific document***?

$\Rightarrow$ A rare term like "Rumpletiltskin" is more likely to be indicative than the frequent term "story". 
***Document frequency***: how frequently the words appear in the entire document collection. 
- If it is very frequent, it does not tell us much about the individual document.

$\Rightarrow$ A document with 100 mentions of "Cat" is more likely to be relevant than one with a single mention.
***Term frequency***: how many times a word appears in a document

$\Longrightarrow$
##### Vector space model
- Documents and queries represented as *vectors*. 
- The *weight* of the term is stored in each position. 
- Vector distance measure used to *rank retrieved documents*.

$\Rightarrow$ Documents close to query measured using vector-space metric are returned first.

![[Pasted image 20250311125532.png|500]]


**TF-IDF**: 
- TF (*term frequency*) assigns high weight to terms in a document that occur frequently. 
	- relative to length of document, so longer documents do not necessarily imply higher weight
$$
TF _{ij} = \frac{f_ij}{\sum_i f_{ij}}, \quad f_{ij} = \text{frequency of term i in document j}
$$
- IDF (*inverse-document frequency*) assigns high weight to rare words found in few documents  - "discriminative"; use logarithm to reduceimpact of absolute values
$$
IDF_i = \log\frac{N}{n_i}, \quad n_i = \text{number of docs that mention i}, N = \text{total number of docs}

$$
(To avoid division by zero add 1 to numerator and denominator)
And then
$$
\text{TF-IDF score:} \quad w_{ij} = TF_{ij} \ \times \ IDF_i 
$$

$\Longrightarrow$ Can be used for **vector-space similarity**.

**Cosine similarity**:
$$
CosSim(D_j,Q) = \frac{\sum_i w_{ij} \times w_{iq} }{\sqrt{\sum_i w_{ij}^2} \times \sqrt{\sum_i w_{iq}^2}}
$$
$\Longrightarrow$
##### Probabilistic model
- Probability ranking principle to device whether the document belongs to the relevant set or the nonrelevant set for a query. 

**Okapi**: 
- Build a score based on: 
	1. frequency of term in document
	2. frequency of term in query
	3. ....
	4. ....
**BM25** (Best Match 25)
- *Basic idea*: incorporate relevance information, use weights that work well in practice (empirically found). 

$\Longrightarrow$
##### Evaluating information retrieval results
As ***opposed*** to SQL queries, in IR *not all results* are necessarily correct.
$\rightarrow$ Need to measure *the quality* of the results.

Assuming we know some **ground truth** or **golden standard**.
- Often found manually!

Check some results and see how the IR system fares:
**Hits**: *true positives*
**Misses**: *false negatives*
**False alarms**: *false positives*
**Correct rejections**: *true negatives*

![[Pasted image 20250311134431.png|300]]

$\Rightarrow$ **Popular measures:
1. ***Recall***: number of relevant documents retrieved by a search (hits) divided by total number of existing relevant documents
2. ***Precision***: number of relevant documents retrieved by a search divided by the total number of documents retrieved by that search
3. ***F-score***: single measure that combines precision and recall (<u>harmonic mean</u>) to compare different result sets:
$$
\text{2 * precision * recall / (precision + recall)}
$$

![[Pasted image 20250311134752.png|600]]


##### Web search
- Delivers results with <u>high precision</u> even at the expense of recall. 
- Web pages are connected via **hyper links**: destination page + anchor text.

**PageRank** algorithm:
(*Used by Google*)
- Highly linked pages are more important (have greater authority) than pages with fewer links. 

$$
P(A) = \sum_I P(X_i)/O(X_i), \quad 
X_i \text{ set of webpages pointing to A, } O(X_i) \text{  is the number of out-links from page } X_i
$$
.... but how do we start this?

$\Rightarrow$ Initially pageranks are unknown.
- Give an nitial pagerank to every webpage. 
- Perform the calculation of pagerank iteratively. 
- Repeat the calculation a number of times until the pagerank values are stable (converge).
*Similar to doing a random walk that converges to some fixed value.*

To encourage converge a damping factor, $0 < d  < 1$ (usually $0.85$), is introduced:
$$
P(A) = (1-d)+d\cdot \left(\sum_i P(X_i) / O(X_i)\right)
$$
