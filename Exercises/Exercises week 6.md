#### 3.19
![[Exercise3.21.png|600]]
**Requirements** and **constraints**: 
1. Airports
	- Each airport is identified by an `Airport_code`
	- An airport can have N departures and arrivals. 
	- Multiple `AIRPLANE_TYPE` can land.
2. Airplanes
	- Only airplanes with specific `AIRPLANE_TYPE` can land in a specific `AIRPORT`.
	- An airplane can only be 1 `AIRPLANE_TYPE`
	- Each airplane has a `Total_no_of_seats`, that is not dependent on the `AIRPLANE_TYPE`
	- Identified by an `Airplane_id`
3. Seats and reservations
	- Each seat is *partially* identified by a `Seat_no`, and depends on a `RESERVATION` (only `Customer_name` and `Cphone`)
	- Each reservation is an instance of a `LEG_INSTANCE`, which is a weak-entity set to the strong(er) set `FLIGHT_LEG`.
	- Each `LEG_INSTANCE` has a N:1 `DEPARTS` and `ARRIVES` dependence on an `AIRPORT`
4. Flights and fares
	- Flights are identified by a `Number`
	- Each flight can have N `FARE`, partially identified by a `Code`.
	- Each flight can have N `FLIGHT_LEG`, each partially identified by a `Leg_no`.
	- A `FLIGHT_LEG` has a dependent `ARRIVAL_AIRPORT` and `DEPARTURE_AIRPORT`
	- A `FLIGHT_LEG` can have N `LEG_INSTANCE`, and each instance must have a specific `Date`, `Dep_time` and `Arr_time` (last two connected to 1 specific `AIRPORT` via `Airport_code)
	- Each fare must have a unique `Code`. 

No constraint having `DEPARTURE_AIRPORT` and `ARRIVAL_AIRPORT` being the same, despite the definition `LEG`: "is a nonstop portion of a flight" (requires motion)??

#### 3.24

![[Exercise3.24.png|600]]

Employee $\rightarrow$ works_in $\rightarrow$ department
- Employee ($0:2$) $\rightarrow$ An employee can work in zero, one or two departments.
- Department ($1:N$) $\rightarrow$ A department should have at least one employee and can have N.
Department $\rightarrow$ contains $\rightarrow$ phone
- Department ($1:3$) $\rightarrow$ A department must have 1 and may have 3 phone numbers.
- Phone ($1:1$) $\rightarrow$ A phone must have 1 corresponding department and not multiple. 
Phone $\rightarrow$ has_phone $\rightarrow$ employee
- Employee ($0:N$) $\rightarrow$ An employee may have 0 or N number of phones.
- Phone ($1:1$) $\rightarrow$ Each phone must belong to exactly 1 employee. 

When is `HAS_PHONE` redundant? 
- If it is a $0:0$ relation $\rightarrow$ meaning employees do not have phones.
- If employees only use phones corresponding to departments.
- If `WORKS_IN` automatically connects each employee to a phone from the department. Although kinda limited due to the $1:3$ relation of department and phone.  

#### 3.25
![[Exercise3.25.png|600]]


#### 3.26


#### 3.27



#### 3.28
![[Exercise3.28.png|600]]

#### 9.5
![[Exercise9.5.png|600]]

