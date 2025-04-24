
#### 8.19
Specify the following queries in relational algebra on the database schema given in Exercise 5.14:
```
CUSTOMER(Cust#, Cname, City)
RENTAL(Rental#, Rdate, Cust#, Time, Date, Hourly_rate)
RENTAL_CAR(Rental#, Car#, Driver#, Start_time, End_time, Amount_received)
CAR(Car#, Year, Model, Price, Depreciation, Last_service)
SERVICING(Garage#, Car#, Service_date)
GARAGE(Garage#, GAddress, Owner_name)
DRIVER(Driver#,Dname, DAddress)
```

1. List all information about the cars that were serviced at the garage number ‘101’ on today’s date.
Perform natural join between `CAR` and `SERVICING` using the `Car#` attribute and have a `WHERE` specifying `Garage# = 101` and `DATE = today`.
$$
\mathrm{\sigma_{service\_{date} ='today' \ \wedge \ Garage = '101' }(Car * Servicing)}
$$
2. List `RENTAL` information about the rental services where the `DRIVER` named “Jose Lopez” had provided service. Produce a listing: `Rental#`, `Car#`, `Start_time`, `End_time` and `Amount_received`.
$$
\mathrm{\pi_{Rental, Car, Start\_time, End\_time, Amount\_recevied}(\sigma_{Dname='Jose Lopez'}(Driver) * Rental\_car)}
$$
3. Produce a listing `Cname`, `No_of_rentals`, `Tot_rental_amt`, where the middle column is the total number of rental services taken by the customer and the last column is the total rental amount received for that customer.
$$
\rho_{COUNT\rightarrow No\_of\_rentals, SUM \rightarrow Tot\_rental\_amt}(\mathrm{_{Cname}\gamma_{COUNT(Rntal), SUM(Amount\_received)}(Custmr * Rntal * Rntal\_{car})) }
$$
4. List the rentals where the duration of service was more than 10 hours.
$$
\sigma_{END-START > 10}(Rental\_car)
$$
5. List the driver number, names, and addresses of all those drivers who are yet to be employed.
$$
\mathrm{Driver \ \setminus \ \pi_{Driver, Dname, DAddr}(Driver*Rental\_car)}
$$

#### 8.24
Specify the following queries in both tuple and domain relational calculus.
![[5.5.png|600]]

1. Retrieve the names of all employees in department 5 who work more than 10 hours per week on the ProductX project.
$$
\begin{align*}
\{ \ e.Fname, \ e.Lname \ | \ Employe(e) \wedge \ e.Dno = 5 \\
& \wedge \ \exists p \ \exists w \ ( \\
& \quad Project(p) \\
& \quad \wedge \ Works\_on(w) \\
& \quad \wedge \ p.Pname = \text{'ProductX'} \\
& \quad \wedge \ w.Essn = e.Essn \\
& \quad \wedge \ w.Pno = p.Pnumber \\
& \quad \wedge \ w.hours > 10 \ ) \\
\}
\end{align*}
$$
$$
\begin{align*}
\{ Fn, Ln \ | \ Employe(Fn, M, Ln, Ssn, Bd, A, Se, Sa, Sup, Dno) \wedge \\
& \quad Dno = 5 \\
& \quad \exists Pna, Pnu, Dnum (\exists essn, pno, hours \\
& \quad Project(\dots) \wedge Works\_on(\dots) \wedge \\
& \quad pna='ProjectX' \wedge hours > 10 \\
& \quad essn = ssn \wedge Pnu = pno) \\
\}
\end{align*}
$$

#### 8.30
Show how you can specify the following relational algebra operations in both tuple and domain relational calculus.
![[Pasted image 20250424134828.png|200]]

1. :
$$
\begin{align*}
\{ t \ | \ R(t) \wedge A = 'd'\} \\
\{ A,B,C \ | \ R(A,B,C) \wedge A='d' \}
\end{align*}
$$
2. :
$$
\begin{align*}
\{ t.A, t.B \ | \ R(t) \} \\
\{ A,B \ | \ R(A,B,C)\}
\end{align*}
$$
3. :
$$
\begin{align*}
\{ t \ | \ R(r) \wedge S(s) \exists r,s ( t.A = r.A \wedge t.B = r.B \wedge s.C = r.C  \wedge t.D = r.D \wedge t.E = r.E)\} \\
\{ A,B,C,D,E \ | \ R(A,B,C) \wedge S(C,D,E) \}
\end{align*}
$$
