
//Publisher running on port:5433

CREATE DATABASE phonebook;

CREATE TABLE phonebook(name VARCHAR(50),phone VARCHAR(50),city VARCHAR(50)); 

CREATE ROLE ph_user REPLICATION LOGIN PASSWORD 'password'; 

CREATE PUBLICATION ph_pub FOR TABLE phonebook;

GRANT SELECT ON phonebook TO ph_user;

INSERT INTO phonebook VALUES('Khizar Hussain',8072759',Bangalore');

INSERT INTO phonebook VALUES('Touqeer Adnan','6387455','Bangalore');

INSERT INTO phonebook VALUES('Mohammed Shariq','9875465','Trivandrum');

INSERT INTO phonebook VALUES('Liyan Fazil','8815220','Chennai');

SELECT * FROM phonebook;

CREATE PROCEDURE insert_data( VARCHAR(50),VARCHAR(50),VARCHAR(50))

LANGUAGE 'plpgsql'

AS $$

BEGIN

INSERT INTO phonebook(name,phone,city) VALUES ($1,$2,$3);

COMMIT;

END;

$$

CALL insert_data('Kashif','9867525','Vellore');

CALL insert_data('Yasir','9629677','Bangalore');

CALL insert_data('Hammad','8796542','Coimbatore');

CALL insert_data('Usaid','8796519','Salem');

SELECT * FROM phonebook;


//Subscriber running on port:5434

CREATE DATABASE phonebook;

CREATE TABLE phonebook(name VARCHAR(50),phone VARCHAR(50),city VARCHAR(50));

CREATE SUBSCRIPTION ph_sub CONNECTION 'host=localhost port=5433 password=password user=repuser
dbname=phonebook' PUBLICATION ph_pub;

SELECT * FROM phonebook;

SELECT * FROM phonebook WHERE name='Usaid';

SELECT name,city FROM phonebook;

 

 


