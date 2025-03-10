import mysql.connector
from mysql.connector import Error

try:
    connection = mysql.connector.connect(host='localhost',
                                         database='NGOs',
                                         user='root',
                                         password='admin')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)

        query = ("SELECT email FROM Supporter NATURAL JOIN Supports GROUP BY email HAVING COUNT(*) = 1;")
        cursor.execute(query)

        for t in cursor:
            print(t)

        

except Error as e:
    print("Error while connecting to MySQL", e)
finally:
    if connection.is_connected():
        cursor.close()
        connection.commit()
        print("MySQL changes are commited")
        connection.close()
        print("MySQL connection is closed")
