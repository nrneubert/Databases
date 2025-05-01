### Exercise on query optimization

We are given the following database schema:

```
Student (sid, name, age, address) 
Book(bid, title, author) 
Checkout(sid, bid, date)
```

Keys are _bid_, _pid_, and _(sid, bid)_ respectively. We are furthermore given the following information about the database:

- There are 10, 000 Student records stored on 1, 000 blocks.
- There are 50, 000 Book records stored on 5, 000 blocks.
- There are 300, 000 Checkout records stored on 15, 000 blocks.
- There are 500 different authors.
- Student ages range from 7 to 24.

Now we want to find the name of all students who are teenagers (i.e., between 13 and 19 years old) and checked out a book written by 'J. R. R. Tolkien'.

1. Write it as an SQL query
```SQL
SELECT S.name from STUDENT S 
	JOIN CHECKOUT C ON S.sid = C.sid 
	JOIN BOOK B ON C.bid = B.bid 
		WHERE S.age > 17 AND S.age < 20
		AND B.author = 'J. R. R. Tolkien'    
```

2. Suggest a query plan.
Any plan in relational algebra that does the same.

3. Compute the cost of your initial query plan.
- $\bowtie_{sid}(S,C)$
1 000 blocks for S and 15 000 blocks for C $\Rightarrow$
15 M I/Os
300 k tuples 
15 k blocks (assume 20 tuples per block)
- $\bowtie_{bid}(-,B)$
$\mathrm{15 k \ blocks \ \cdot 5 k \ blocks = 75 M \ IOs}$
and we have
$\mathrm{300 k \ tuples \approx 15k \ blocks}$
- $\sigma_{Author='Tolkien'}$
$\mathrm{15 k \ IOs}$
1/500 authors are Tolkien, so $\mathrm{600 \ tuples \approx 30 \ blocks}$
- $\sigma_{12<age<19}$
$\mathrm{15 \ IOs}$
approximately 39% of ages contained, so $\mathrm{600 \ tuples \ \cdot 0.39 = 234 \ tuples \approx 12 \ blocks}$
- $\pi_{name}$
$\mathrm{12 \ IOs}$

$\Longrightarrow$
so summed up: $\mathrm{90 \ M + 15,042 \ IOs}$
if 50 IOs/s then this takes approximately 500 hours. 

3. Use the Heuristic Algebraic Optimization algorithm to make an optimized query plan. (if your first query plan turns out to be optimal try to make a worse plan by applying the 'opposite of the heuristics')


4. Compute the cost of your new plan.
We get approximately $\mathrm{3 M \ tuples}$

5. Suggest an index that would lead to a lower cost of your _optimal_ query plan.
It is actually more optimal to join Book and Checkout first. Because there are far more Checkout records, if we had a B-tree index on Checkout.bid it would reduce the IO significantly.


