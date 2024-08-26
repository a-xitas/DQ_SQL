## 3. Connecting to the Database ##

import sqlite3

conn = sqlite3.connect('jobs.db')



## 6. Creating a Cursor and Running a Query ##

import sqlite3
conn = sqlite3.connect("jobs.db")
cursor = conn.cursor()

query = "select Major from recent_grads;"
cursor.execute(query)
majors = cursor.fetchall()
print(majors[0:3])

## 8. Fetching a Specific Number of Results ##

import sqlite3
conn = sqlite3.connect("jobs.db")
query = 'SELECT Major, Major_category FROM recent_grads;'

five_results = conn.execute(query).fetchmany(5)


print(five_results)



## 9. Closing the Database Connection ##

conn = sqlite3.connect("jobs.db")

conn.close()

#conn.execute('SELECT * FROM recent_grads LIMIT 5;').fetchone()

## 10. Practice ##

conn = sqlite3.connect('jobs2.db')
reverse_alphabetical = conn.execute('SELECT Major FROM recent_grads ORDER BY Major desc').fetchall()

print(reverse_alphabetical)

conn.close()