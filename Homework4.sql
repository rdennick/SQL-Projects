-- --------------------------------------------------------------------------------
-- Name: Ryan Dennick
-- Class: IT-111-400
-- Abstract: Homework 4 - Intermediate SQL
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TEmployeeParkingSpots
DROP TABLE TEmployees
DROP TABLE TParkingSpots
-- --------------------------------------------------------------------------------
-- Step #1: Create Tables
-- --------------------------------------------------------------------------------


CREATE TABLE TEmployees
(
	 intEmployeeID			INTEGER			NOT NULL	
	,strFirstName			VARCHAR(50)		NOT NULL
	,strMiddleName			VARCHAR(50)		NOT NULL
	,strLastName			VARCHAR(50)		NOT NULL
	,dtmDateOfHire			DATETIME		NOT NULL
	,strPosition			VARCHAR(50)		NOT NULL
	,CONSTRAINT TEmployees_PK PRIMARY KEY( intEmployeeID )
);

CREATE TABLE TParkingSpots
(
	 intParkingSpotID		INTEGER			NOT NULL
	,strParkingSpot			VARCHAR(50)		NOT NULL	
	,CONSTRAINT TParkingSpots_PK PRIMARY KEY( intParkingSpotID )
);


CREATE TABLE TEmployeeParkingSpots
(
	 intEmployeeID			INTEGER			NOT NULL
	,intParkingSpotID		INTEGER			NOT NULL
	,CONSTRAINT TEmployeeParkingSpots_PK PRIMARY KEY( intEmployeeID, intParkingSpotID )
	,CONSTRAINT TEmployeeParkingSpots_intParkingSpotID_UN UNIQUE( intParkingSpotID )
);

-- --------------------------------------------------------------------------------
-- Step #2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------

-- #	Child					Parent				Column(s)
--		-----					------				---------
-- 1	TEmployeeParkingSpots	TEmployees			intEmployeeID
-- 2	TEmployeeParkingSpots	TParkingSpots		intParkingSpotsID

-- 1
ALTER TABLE TEmployeeParkingSpots ADD CONSTRAINT TEmployeeParkingSpots_TEmployees_FK
	FOREIGN KEY ( intEmployeeID ) REFERENCES TEmployees( intEmployeeID )

-- 2
ALTER TABLE TEmployeeParkingSpots ADD CONSTRAINT TEmployeeParkingSpots_TParkingSpots_FK
	FOREIGN KEY (intParkingSpotID ) REFERENCES TParkingSpots( intParkingSpotID )


-- --------------------------------------------------------------------------------
-- Step #3: Add 5 employees
-- --------------------------------------------------------------------------------

INSERT INTO TEmployees ( intEmployeeID, strFirstName, strMiddleName, strLastName, dtmDateOfHire, strPosition )
VALUES ( 1, 'Ansel', '', 'Adams', '1/1/2001', 'President' )
	
INSERT INTO TEmployees ( intEmployeeID, strFirstName, strMiddleName, strLastName, dtmDateOfHire, strPosition )
VALUES ( 2, 'Barnum', '', 'Baily', '2/2/2002', 'Project Manager' )

INSERT INTO TEmployees ( intEmployeeID, strFirstName, strMiddleName, strLastName, dtmDateOfHire, strPosition )
VALUES ( 3, 'Davy', '', 'Jones', '3/3/2003', 'Programmer' )

INSERT INTO TEmployees ( intEmployeeID, strFirstName, strMiddleName, strLastName, dtmDateOfHire, strPosition )
VALUES ( 4, 'David', '', 'Smith', '4/4/2004', 'Programmer' )

INSERT INTO TEmployees ( intEmployeeID, strFirstName, strMiddleName, strLastName, dtmDateOfHire, strPosition )
VALUES ( 5, 'Ed', '', 'Wilson', '5/5/2005', 'DBA' )

-- --------------------------------------------------------------------------------
-- Step #4: Add 15 parking spots
-- --------------------------------------------------------------------------------

-- LEVEL #1, SPOTS: 1-5 
INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 1, 'Level 1, Spot 1' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 2, 'Level 1, Spot 2' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 3, 'Level 1, Spot 3' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 4, 'Level 1, Spot 4' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 5, 'Level 1, Spot 5' )

-- LEVEL #2, SPOTS: 1-5
INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 6, 'Level 2, Spot 1' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 7, 'Level 2, Spot 2' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 8, 'Level 2, Spot 3' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 9, 'Level 2, Spot 4' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 10, 'Level 2, Spot 5' )

-- LEVEL #3, SPOTS: 1-5
INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 11, 'Level 3, Spot 1' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 12, 'Level 3, Spot 2' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 13, 'Level 3, Spot 3' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 14, 'Level 3, Spot 4' )

INSERT INTO TParkingSpots( intParkingSpotID, strParkingSpot )
VALUES( 15, 'Level 3, Spot 5' )


-- --------------------------------------------------------------------------------
-- Step #5: Give all employees a parking spot on level 1
-- --------------------------------------------------------------------------------

INSERT INTO TEmployeeParkingSpots( intEmployeeID, intParkingSpotID )
VALUES		 ( 1, 1 )
			,( 2, 2 )
			,( 3, 5 )
			,( 4, 3 )
			,( 5, 4 )


-- --------------------------------------------------------------------------------
-- Step #6: Give two parking spots to one employee
-- --------------------------------------------------------------------------------

INSERT INTO TEmployeeParkingSpots( intEmployeeID, intParkingSpotID )
VALUES		 ( 1, 6)		-- He already had spot 1

-- --------------------------------------------------------------------------------
-- Step #7: TRY to give same spot to two employees
-- --------------------------------------------------------------------------------

--INSERT INTO TEmployeeParkingSpots( intEmployeeID, intParkingSpotID )
--VALUES		 ( 2,1 )

-- --------------------------------------------------------------------------------
-- Step #8: Add employee Xavier as a DBA
-- --------------------------------------------------------------------------------

INSERT INTO TEmployees ( intEmployeeID, strFirstName, strMiddleName, strLastName, dtmDateOfHire, strPosition )
VALUES ( 6, 'Charles', '', 'Xavier', '6/6/2006', 'DBA' )


-- --------------------------------------------------------------------------------
-- Step #9: Delete employee Wilson
-- --------------------------------------------------------------------------------

DELETE FROM TEmployeeParkingSpots
WHERE
	intEmployeeID = 5

DELETE FROM TEmployees
WHERE
	--strLastName = 'Wilson'			-- DO NOT WANT THIS!!
	intEmployeeID = 5

-- --------------------------------------------------------------------------------
-- Step #10: Give Xavier a parking spot on level 1
-- --------------------------------------------------------------------------------

INSERT INTO TEmployeeParkingSpots( intEmployeeID, intParkingSpotID )
VALUES		( 6, 4 )

-- --------------------------------------------------------------------------------
-- Step #11: Move first three employees from level 1 to level 2 parking spots
-- --------------------------------------------------------------------------------

UPDATE
	TEmployeeParkingSpots
SET
	intParkingSpotID = 7
WHERE
	intParkingSpotID = 1

UPDATE
	TEmployeeParkingSpots
SET
	intParkingSpotID = 8
WHERE
	intParkingSpotID = 2

UPDATE
	TEmployeeParkingSpots
SET
	intParkingSpotID = 9
WHERE
	intParkingSpotID = 5

-- --------------------------------------------------------------------------------
-- Step #12: Move all remaining employees from level 1 to level 3 parking spots
-- --------------------------------------------------------------------------------

UPDATE
	TEmployeeParkingSpots
SET
	intParkingSpotID = 11
WHERE
	intParkingSpotID = 3

UPDATE
	TEmployeeParkingSpots
SET
	intParkingSpotID = 12
WHERE
	intParkingSpotID = 4


SELECT * FROM TEmployeeParkingSpots

-- --------------------------------------------------------------------------------
-- Step #13: Show all employees not president
-- --------------------------------------------------------------------------------

SELECT
	 intEmployeeID
	,strLastName + ', ' + strFirstName		AS strFullName
FROM
	TEmployees
WHERE
	strPosition <> 'President'

-- --------------------------------------------------------------------------------
-- Step #14: Show all employees not programmers or DBA's
-- --------------------------------------------------------------------------------

SELECT
	 intEmployeeID
	,strLastName + ', ' + strFirstName		AS strFullName
FROM
	TEmployees
WHERE
	strPosition <> 'Programmer'
AND strPosition <> 'DBA'

-- --------------------------------------------------------------------------------
-- Step #15: Show middle name and date of hire for all employees
-- --------------------------------------------------------------------------------

SELECT
	 intEmployeeID
	,strMiddleName
	,dtmDateOfHire
FROM
	TEmployees
ORDER BY
	 strLastName
	,strFirstName

-- --------------------------------------------------------------------------------
-- Step #16: Show all parking spots on level 1
-- --------------------------------------------------------------------------------

SELECT
	 intParkingSpotID
	,strParkingSpot
FROM
	TParkingSpots
WHERE
	strParkingSpot	LIKE	'Level 1,%'

-- --------------------------------------------------------------------------------
-- Step #17: Show all parking spots that are spot #4 or spot #2
-- --------------------------------------------------------------------------------

SELECT
	 intParkingSpotID
	,strParkingSpot
FROM
	TParkingSpots
WHERE
	strParkingSpot	LIKE	'Level %, Spot 2'
OR  strParkingSpot	LIKE	'Level %, Spot 4'

-- --------------------------------------------------------------------------------
-- Step #18: Add 1 to every employee ID
-- --------------------------------------------------------------------------------


DROP TABLE TEmployeeParkingSpots


UPDATE
	TEmployees
SET
	intEmployeeID = intEmployeeID + 1

CREATE TABLE TEmployeeParkingSpots
(
	 intEmployeeID			INTEGER			NOT NULL
	,intParkingSpotID		INTEGER			NOT NULL
	,CONSTRAINT TEmployeeParkingSpots_PK PRIMARY KEY( intEmployeeID, intParkingSpotID )
	,CONSTRAINT TEmployeeParkingSpots_intParkingSpotID_UN UNIQUE( intParkingSpotID )
)

INSERT INTO TEmployeeParkingSpots( intEmployeeID, intParkingSpotID )
VALUES		 ( 2, 6 )
			,( 2, 7 )
			,( 3, 8 )
			,( 4, 9 )
			,( 5, 11 )
			,( 7, 12 )

-- This can be very time consuming with a lot of records. You have to drop the table to remove any foreign key references and then recreate the table and reenter values.