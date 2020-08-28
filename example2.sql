
// Publisher running on port:5433

CREATE DATABASE students;

CREATE TABLE students (id INT PRIMARY KEY, name VARCHAR(100),branch VARCHAR(100),
address VARCHAR(100),city VARCHAR(100));

CREATE ROLE sturep REPLICATION LOGIN PASSWORD 'password';

CREATE PUBLICATION stu_pub FOR TABLE students;

GRANT SELECT ON students TO sturep;

INSERT INTO students VALUES (1,'Kabir','Civil','Benson Town','Bangalore');

INSERT INTO students VALUES (2,'Sufiyan','Mechanical','Frazer Town','Bangalore');

INSERT INTO students VALUES (3,'Khasim','EEE','pursaiwakam','Chennai');

INSERT INTO students VALUES (4,'Abrar','ECE','Anna Nagar','Chennai');

INSERT INTO students VALUES (5,'Zaid','CSE','Kilpauk','Chennai');

INSERT INTO students VALUES (6,'faizan','Civil','Periamet','Chennai');

SELECT * FROM students;

CREATE PROCEDURE insert_values(INT,VARCHAR(100),VARCHAR(100),VARCHAR(100),VARCHAR(100))

LANGUAGE 'plpgsql'

AS $$

BEGIN

INSERT INTO students(id,name,branch,address,city) VALUES ($1,$2,$3,$4,$5);

COMMIT;

END;

$$

CALL insert_values(6,'Muddasir','IT','Choolai','Chennai');

CALL insert_values(7,'Tauseef','Mechanical','Tambaram','Chennai');

SELECT * FROM students;

// Subscriber running on port:5434

CREATE DATABASE students;


CREATE TABLE students (id INT PRIMARY KEY, name VARCHAR(100),branch VARCHAR(100),
address VARCHAR(100),city VARCHAR(100));

CREATE SUBSCRIPTION stu_sub CONNECTION 'host=localhost port=5433 password=password user=sturep 
dbname=students' PUBLICATION stu_pub;

SELECT * FROM students;








