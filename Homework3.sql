-- --------------------------------------------------------------------------------
-- Name: Ryan Dennick
-- Class: IT-111-400
-- Abstract: Homework 3 - Basic SQL
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1;		-- Get out of the master database
SET NOCOUNT ON;	-- Report only errors

-- --------------------------------------------------------------------------------
-- Step #1: Create Tables
-- --------------------------------------------------------------------------------
--DROP TABLE TEmployees

CREATE TABLE TEmployees
(
	 intEmployeeID		INTEGER		NOT NULL
	,strFirstName		VARCHAR(50)	NOT NULL
	,strLastName		VARCHAR(50)	NOT NULL
	,dtmDateOfHire		DATE		NOT NULL
	,monSalary			MONEY		NOT NULL
	,strJobTitle		VARCHAR(50) NOT NULL
	,CONSTRAINT TEmployees_PK PRIMARY KEY ( intEmployeeID )


);
-- --------------------------------------------------------------------------------
-- Step #2: Insert statements
-- --------------------------------------------------------------------------------
INSERT INTO TEmployees ( intEmployeeID, strFirstName, strLastName, dtmDateOfHire, monSalary, strJobTitle )
VALUES (1, 'Luke', 'Skywalker', '2013/01/01', 50000, 'Jedi' );

INSERT INTO TEmployees ( intEmployeeID, strFirstName, strLastName, dtmDateOfHire, monSalary, strJobTitle )
VALUES (2, 'Obi-Wan', 'Kenobi', '2012/02/02', 75000, 'Jedi' );

INSERT INTO TEmployees ( intEmployeeID, strFirstName, strLastName, dtmDateOfHire, monSalary, strJobTitle )
VALUES (3, 'Han', 'Solo', '2013/03/03', 90000, 'Captain' );

INSERT INTO TEmployees ( intEmployeeID, strFirstName, strLastName, dtmDateOfHire, monSalary, strJobTitle )
VALUES (4, 'Darth', 'Vader', '2015/05/05', 150000, 'Jedi' );

INSERT INTO TEmployees ( intEmployeeID, strFirstName, strLastName, dtmDateOfHire, monSalary, strJobTitle )
VALUES (5, 'Jar-Jar', 'Binks', '2016/06/06', 40000, 'Commander' );
-- --------------------------------------------------------------------------------
-- Step #3: Select statements
-- --------------------------------------------------------------------------------

--#1
SELECT
	 intEmployeeID
	,strLastName
FROM
	TEmployees;

--#2
SELECT
	 intEmployeeID
	,strLastName
	,strJobTitle
FROM
	TEmployees
WHERE
	monSalary < 50000
OR  strJobTitle LIKE 'J%';

--#3
SELECT
	 intEmployeeID
	,CONCAT(strLastName,', ',strFirstName) AS 'Full Name'
FROM
	TEmployees
WHERE
	dtmDateOfHire >= '2013/01/01';
	
--#4
SELECT
	  CONCAT(strFirstName, ' ' ,strLastName) AS 'Full Name'
	 ,monSalary
FROM
	TEmployees;

--#5
SELECT
	*
FROM
	TEmployees;

	
-- --------------------------------------------------------------------------------
-- Step #4: Update statements
-- --------------------------------------------------------------------------------

--#1
UPDATE
	TEmployees
SET
	monSalary	=	monSalary * 1.1;

--#2
UPDATE
	TEmployees
SET
	strLastName = 'Johnson'
WHERE
	intEmployeeID = 5;

--#3
UPDATE
	TEmployees
SET
	 strFirstName = 'Bob'
	,monSalary = 55000
WHERE
	strLastName = 'Johnson';

--#4
UPDATE
	TEmployees
SET
	dtmDateOfHire = '2017/09/15'
WHERE
	strFirstName = 'Bob'
AND strLastName = 'Johnson';

--#5
UPDATE
	TEmployees
SET
	strJobTitle = 'Programmer'
WHERE
	intEmployeeID = 5;



-- --------------------------------------------------------------------------------
-- Step #5: Delete statements
-- --------------------------------------------------------------------------------

--#1
DELETE FROM TEmployees
WHERE
	monSalary > 150000

--#2
DELETE FROM TEmployees
WHERE
	intEmployeeID = 5

--#3
DELETE FROM TEmployees
WHERE
	dtmDateOfHire < '2013/01/01'

--#4
DELETE FROM TEmployees
WHERE
	strJobTitle = 'Captain'

--#5
DELETE FROM TEmployees
WHERE
	strLastName = 'Skywalker'



