
###### Exercise 14.20

**Figure 14.3a**
- If you change Dname for ONE row then you have to change it for ALL rows, which would not always be done and can cause anomalies. You should split the table into Employee and Department.
- Insertion anomalies can occur for an employee without a department, then you would need to fill out NULLs. 

**Figure 14.3b**
- If you change Pname for ONE row then you have to change it for ALL rows, which could cause anomalies because now a UNIQUE Pnumber would point towards multiple Pname. 

###### Exercise 14.23
*Why do spurious tuples occur in the result of joining the EMP_PROJ1 and EMP_LOCS relations of Figure 14.5 (result shown in Figure 14.6)?*

The general problem is not making a NATURAL JOIN on a unique column.
You generate spurious SSN for example.
###### Exercise 14.23
DISK_DRIVE(<u>serial_Number</u>, manufacturer, model, batch, capacity, retailer)

a. *The manufacturer and serial number uniquely identifies the drive*
{ manufacturer, serial_number } $\rightarrow$ { model, batch, capacity, retailer }

b. *A model number is registered by a manufacturer and hence can’t be used by another manufacturer.*
{ model } $\rightarrow$ { manufacturer }

c. *All disk drives in a particular batch are the same model.*
{ batch } $\rightarrow$ { model }

d. *All disk drives of a particular model of a particular manufacturer have exactly the same capacity.*
{ model, manufacturer } $\rightarrow$ { capacity }

