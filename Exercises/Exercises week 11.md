##### Exercise on Relational DBMS and NoSQL
For each of the rows in the table below, decide if the statement is true for either SQL or NoSQL databases.

| Statement                                               | SQL            | NOSQL           |
| ------------------------------------------------------- | -------------- | --------------- |
| Has a fixed schema                                      | X              | O               |
| Is horizontally scalable                                | O (vertically) | X               |
| Allows for complex queries                              | X              | X (but depends) |
| Flexibly supports dynamic changes to the data structure | O              | X               |
| Uses a relational data mode                             | X              | O               |
| Stores unstructured or semi-structured data             | O              | X               |
| Uses a DBMS                                             | X              | X               |
| Emphasis is on high availability                        | O              | X               |
| Focuses on supporting CAP properties                    | X              | X               |
| Can store JSON formatted data                           | O              | X               |

##### Exercise 1 on NoSQL systems
What are the 4 major categories of NoSQL systems? Give an example of such a system.
1. Document-based: MongoDB
2. Key-value based: Voldemort (DynamoDB)
3. Column based: Apache HBASE
4. Graph-based: Neo4j

##### Exercise 2 on NoSQL systems
What are CRUD-operations?
1. Create
2. Read
3. Update
4. Delete
5. (Search)

##### Exercise on MongoDB
In leftmost panel:
```JSON
db={
  movies: [
    {
      "title": "Fight Club",
      "writer": "Chuck Palahniuk",
      "year": 1999,
      "actors": [
        "Brad Pitt",
        "Edward Norton"
      ]
    },
    {
      "title": "Pulp Fiction",
      "writer": "Quentin Tarantino",
      "year": 1994,
      "actors": [
        "John Travolta",
        "Uma Thurman"
      ]
    },
    {
      "title": "Inglorious Basterds",
      "writer": "Quentin Tarantino",
      "year": 2009,
      "actors": [
        "Brad Pitt",
        "Diane Kruger",
        "Eli Roth"
      ]
    },
    {
      "title": "The Hobbit: An Unexpected Journey",
      "writer": "J.R.R. Tolkein",
      "year": 2012,
      "franchise": "The Hobbit"
    },
    {
      "title": "The Hobbit: The Desolation of Smaug",
      "writer": "J.R.R. Tolkein",
      "year": 2013,
      "franchise": "The Hobbit"
    },
    {
      "title": "The Hobbit: The Battle of the Five Armies",
      "writer": "J.R.R. Tolkein",
      "year": 2012,
      "franchise": "The Hobbit",
      "synopsis": "Bilbo and Company are forced to engage in a war against an array of combatants and keep the Lonely Mountain from falling into the hands of a rising darkness."
    },
    {
      "title": "Pee Wee Herman's Big Adventure"
    },
    {
      "title": "Avatar"
    }
  ]
}
```

###### Query Documents
1. Retrieve all documents:
![[Pasted image 20250313124015.png|800]]
2. Retrieve all documents with franchise set to "The Hobbit"
![[Pasted image 20250313124118.png|800]]
3. Retrieve all movies released in the 90s
![[Pasted image 20250313124635.png|800]]
4. Retrieve all movies released before the year 2000 or after 2010
![[Pasted image 20250313124820.png|800]]

###### Update documents
1. Add a synopsis to “The Hobbit: An Unexpected Journey” : 
	“A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug.”

![[Pasted image 20250313125154.png|800]]
2. Add an actor named “Samuel L. Jackson” to the movie “Pulp Fiction”
![[Pasted image 20250313125312.png|800]]
