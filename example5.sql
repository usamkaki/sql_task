// Publisher running on port:5433

CREATE DATABASE sample;

CREATE TABLE sample(id INT PRIMARY KEY,name VARCHAR(50));

CREATE TABLE log(id INT PRIMARY KEY,name VARCHAR(50),entry_date text);

CREATE OR REPLACE FUNCTION log() RETURNS TRIGGER AS $ABC$

BEGIN
 
INSERT INTO log(id,name,entry_date) VALUES (new.id,new.name,current_timestamp);

RETURN NEW;

END;

$ABC$ LANGUAGE 'plpgsql';

CREATE TRIGGER log_trigger AFTER INSERT ON sample

FOR EACH ROW EXECUTE PROCEDURE log();

CREATE PUBLICATION new_pub FOR TABLE log;

CREATE ROLE test_user REPLICATION LOGIN PASSWORD 'password';

GRANT SELECT ON log TO test_user;

GRANT SELECT ON sample TO test_user;

CREATE PUBLICATION new_pub1 FOR TABLE sample;

INSERT INTO sample VALUES(1,'Muzammil');

INSERT INTO sample VALUES(2,'Farhan');

INSERT INTO sample VALUES(3,'Zuhaid');

INSERT INTO sample VALUES(4,'Ziaudeen');

SELECT * FROM sample;

SELECT * FROM log;

// Subscriber running on port:5434

CREATE DATABASE sample;

CREATE TABLE log(id INT PRIMARY KEY,name VARCHAR(50),entry_date text);

CREATE SUBSCRIPTION new_sub CONNECTION 'host=localhost port=5433 password=password user=test_user 
dbname=sample' PUBLICATION new_pub;

SELECT * FROM log;

// Subscriber running on port:5435

CREATE DATABASE sample;

CREATE TABLE sample(id INT PRIMARY KEY,name VARCHAR(50));

CREATE SUBSCRIPTION new_sub1 CONNECTION 'host=localhost port=5433 password=password user=test_user 
dbname=sample' PUBLICATION new_pub1;

Select * from sample;




