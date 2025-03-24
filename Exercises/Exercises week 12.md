![[Pasted image 20250320121753.png|600]]

We need to use 
![[Pasted image 20250320121937.png|500]]

so for node 1: we get
$P(A) = P(4)/3 + P(3)/3 + P(2)/1 = 4.2/3 + 1.2/3 + 2.5/1 = 4.3$

#### 4. Transaction - Example analysis 1
![[Pasted image 20250320122242.png|600]]

**Transaction 1**: 
1. read(balance)
2. calculate interest  
3. read(balance)
4. write(balance)

It is an **unrepeatable read problem** because transaction 1 reads the value of account 1's balance twice, but transaction 2 writes to that value in between the two reads.

#### Transaction - Example analysis 2
![[Pasted image 20250320123440.png|600]]

a)
Transaction B would read the original account balance before transaction A succeeds; 1000 dkk. 
It is problematic because transaction A is attempting to write to this value.
b)
Depending on timings of the transactions and rollbacks the transaction B would measure different resulting balances (not very consistent :)). 

