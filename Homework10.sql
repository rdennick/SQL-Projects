-- --------------------------------------------------------------------------------
-- Name: Ryan Dennick
-- Class: IT-111-400
-- Abstract: Homework 10 - Joins New Syntax 
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors



-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TCourseStudents
DROP TABLE TCourseBooks
DROP TABLE TStudents
DROP TABLE TGrades
DROP TABLE TBooks
DROP TABLE TCourses
DROP TABLE TRooms
DROP TABLE TInstructors
-- --------------------------------------------------------------------------------
-- Step #3.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TCourses
(
	 intCourseID			INTEGER			NOT NULL
	,strCourse				VARCHAR(50)		NOT NULL
	,strDescription			VARCHAR(50)		NOT NULL
	,intInstructorID		INTEGER			NOT NULL
	,intRoomID				INTEGER			NOT NULL
	,CONSTRAINT TCourse_PK PRIMARY KEY ( intCourseID )
);

CREATE TABLE TInstructors
(
	 intInstructorID		INTEGER			NOT NULL
	,strFirstName			VARCHAR(50)		NOT NULL
	,strLastName			VARCHAR(50)		NOT NULL
	,strPhoneNumber			VARCHAR(50)		NOT NULL
	,CONSTRAINT TInstructors_PK PRIMARY KEY ( intInstructorID )
);

CREATE TABLE TRooms
(
	 intRoomID				INTEGER			NOT NULL
	,strRoomNumber			VARCHAR(50)		NOT NULL
	,intCapacity			INTEGER			NOT NULL
	,strMeetingTime			VARCHAR(50)		NOT NULL
	,CONSTRAINT TRooms_PK PRIMARY KEY ( intRoomID )
);

CREATE TABLE TBooks
(
	 intBookID				INTEGER			NOT NULL
	,strBookName			VARCHAR(50)		NOT NULL
	,strBookAuthor			VARCHAR(50)		NOT NULL
	,strBookISBN			VARCHAR(50)		NOT NULL
	,CONSTRAINT TBooks_PK PRIMARY KEY ( intBookID )
);

CREATE TABLE TGrades
(
	 intGradeID				INTEGER			NOT NULL
	,strLetterGrade			VARCHAR(50)		NOT NULL
	,decGradePointValue		DECIMAL			NOT NULL
	,CONSTRAINT TGrades_PK PRIMARY KEY ( intGradeID )
);

CREATE TABLE TStudents
(
	 intStudentID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(50)		NOT NULL
	,strLastName			VARCHAR(50)		NOT NULL
	,strStudentNumber		VARCHAR(50)		NOT NULL
	,strPhoneNumber			VARCHAR(50)		NOT NULL
	,CONSTRAINT TStudents_PK PRIMARY KEY ( intStudentID ) 
);

CREATE TABLE TCourseBooks
(
	 intCourseID			INTEGER			NOT NULL
	,intBookID				INTEGER			NOT NULL
	,CONSTRAINT TCourseBooks_PK PRIMARY KEY ( intCourseID, intBookID )
);		

CREATE TABLE TCourseStudents
(
	 intCourseID			INTEGER			NOT NULL
	,intStudentID			INTEGER			NOT NULL
	,intGradeID				INTEGER			NOT NULL
	,CONSTRAINT TCourseStudents_PK PRIMARY KEY ( intCourseID, intStudentID )
);


-- --------------------------------------------------------------------------------
-- Step #3.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column(s)
-- -	-----							------						---------
-- 1	TCourses						TInstructors				intInstructorID
-- 2	TCourses						TRooms						intRoomID
-- 3	TCourseBooks					TCourses					intCourseID
-- 4	TCourseBooks					TBooks						intBookID
-- 5	TCourseStudents					TCourses					intCourseID
-- 6	TCourseStudents					TStudents					intStudentID
-- 7	TCourseStudents					TGrades						intGradeID

ALTER TABLE TCourses ADD CONSTRAINT TCourses_TInstructors_FK
FOREIGN KEY ( intInstructorID ) REFERENCES TInstructors ( intInstructorID )

ALTER TABLE TCourses ADD CONSTRAINT TCourses_TRooms_FK
FOREIGN KEY ( intRoomID ) REFERENCES TRooms ( intRoomID )

ALTER TABLE TCourseBooks ADD CONSTRAINT TCourseBooks_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

ALTER TABLE TCourseBooks ADD CONSTRAINT TCourseBooks_TBooks_FK
FOREIGN KEY ( intBookID ) REFERENCES TBooks ( intBookID )

ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TStudents_FK
FOREIGN KEY ( intStudentID ) REFERENCES TStudents ( intStudentID )

ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TGrades_FK
FOREIGN KEY ( intGradeID ) REFERENCES TGrades ( intGradeID )


-- --------------------------------------------------------------------------------
-- Step #3.3: Add at least three courses
-- --------------------------------------------------------------------------------

INSERT INTO TInstructors ( intInstructorID, strFirstName, strLastName, strPhoneNumber )
VALUES		 ( 1, 'Tim', 'Brown', '135-792-4680' )
			,( 2, 'Barb', 'Thompson', '987-654-3210' )
			,( 3, 'Frank', 'Gains', '876-543-2109' )

INSERT INTO TRooms ( intRoomID, strRoomNumber, intCapacity, strMeetingTime )
VALUES		 ( 1, '100', 100, 'M/W/F 10-12pm' )
			,( 2, '200', 100, 'T/Th 8-930am' )
			,( 3, '300', 100, 'M/W/F 1-3pm' )

INSERT INTO TCourses ( intCourseID, strCourse, strDescription, intInstructorID, intRoomID )
VALUES		 ( 1, 'IT-111', 'Database Design and SQL 1', 1, 1 )
			,( 2, 'IT-101', '.NET Programming 1', 2, 2 )
			,( 3, 'BPA-130', 'Business Systems Analysis', 3, 3 )


-- --------------------------------------------------------------------------------
-- Step #3.3: Add at least three books and assign one course to each
-- --------------------------------------------------------------------------------

INSERT INTO TBooks ( intBookID, strBookName, strBookAuthor, strBookISBN )
VALUES		 ( 1, 'SQL for Programmers', 'Pat Callahan', '123-4-56-789012-3' )
			,( 2, 'Getting Started with Visual Basic', 'Tony Gaddis', '234-5-67-890123-4' )
			,( 3, 'Systems Design and Analysis', 'John Smith', '345-6-78-901234-5' )

INSERT INTO TCourseBooks ( intCourseID, intBookID )
VALUES		 ( 1, 1 )
			,( 2, 2 )
			,( 3, 3 )

-- --------------------------------------------------------------------------------
-- Step #3.3: Add at least three students and add two to each course
-- --------------------------------------------------------------------------------

INSERT INTO TStudents ( intStudentID, strFirstName, strLastName, strStudentNumber, strPhoneNumber )
VALUES		 ( 1, 'Cory', 'James', '1', '123-456-7890' )
			,( 2, 'Hanna', 'Kelly', '2', '234-567-8901' )
			,( 3, 'Phil', 'Dawkins', '3', '345-678-9012' )

INSERT INTO TGrades ( intGradeID, strLetterGrade, decGradePointValue )
VALUES		  ( 1, 'A', 4.0 )
			 ,( 2, 'B', 3.0 )
			 ,( 3, 'C', 2.0 )
			 ,( 4, 'D', 1.0 )
			 ,( 5, 'F', 0.0 )
			 ,( 6, 'W', 0.0 )
			 ,( 7, 'I', 0.0 )
			 ,( 8, 'S', 4.0 )
			 ,( 9, 'N', 0.0 )

INSERT INTO TCourseStudents ( intCourseID, intStudentID, intGradeID )
VALUES		 ( 1, 1, 1 )
			,( 1, 2, 3 )
			,( 2, 3, 2 )
			,( 2, 1, 1 )
			,( 3, 2, 2 )
			,( 3, 3, 4 )

-- --------------------------------------------------------------------------------
-- Step #3.4: Write a join that will display the course ID, name, description 
--            and meeting times along with the instructor info and room info
--            Include order by clause
-- --------------------------------------------------------------------------------
SELECT
	 TC.intCourseID
	,TC.strCourse
	,TC.strDescription
	,TR.strMeetingTime
	,TI.intInstructorID
	,TI.strLastName
		+ ', ' + TI.strFirstName AS strInstructor
	,TI.strPhoneNumber
	,TR.intRoomID
	,TR.strRoomNumber
	,TR.intCapacity

FROM
	 TCourses As TC
		JOIN TInstructors As TI
		ON ( TC.intInstructorID = TI.intInstructorID )
		JOIN TRooms As TR
		ON (TC.intRoomID = TR.intRoomID )

ORDER BY
	 TC.strCourse




-- --------------------------------------------------------------------------------
-- 3.5: Write the join that will display a record for every student in a course
--      along with the students grade. Include an order by statement
-- --------------------------------------------------------------------------------
SELECT
	 TC.intCourseID
	,TC.strCourse
	,TS.intStudentID
	,TS.strLastName
		+ ', ' + TS.strFirstName AS strStudent
	,TG.intGradeID
	,TG.strLetterGrade
	,TG.decGradePointValue

FROM
	TCourses As TC
		JOIN TCourseStudents As TCS
			JOIN TStudents As TS
			ON ( TCS.intStudentID = TS.intStudentID )
			JOIN TGrades As TG
			ON (TCS.intGradeID = TG.intGradeID )
		ON ( TC.intCourseID = TCS.intCourseID )

ORDER BY
	 TCS.intStudentID
-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TFlightFlightAttendants
DROP TABLE TFlightPassengers
DROP TABLE TFlightPilots
DROP TABLE TFlightAttendantRoles
DROP TABLE TFlightAttendants
DROP TABLE TPassengers
DROP TABLE TPilotRoles
DROP TABLE TPilots
DROP TABLE TFlights
DROP TABLE TAirplanes

-- --------------------------------------------------------------------------------
-- 4.1 Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TFlights
(
	 intFlightID				INTEGER			NOT NULL
	,strFlight					VARCHAR(50)		NOT NULL
	,strDescription				VARCHAR(50)		NOT NULL
	,intAirplaneID				INTEGER			NOT NULL
	,CONSTRAINT TFlights_PK PRIMARY KEY ( intFlightID )
);

CREATE TABLE TAirplanes
(
	 intAirplaneID				INTEGER			NOT NULL
	,strAirplaneNumber			VARCHAR(50)		NOT NULL
	,strAirplaneType			VARCHAR(50)		NOT NULL
	,intCapacity				INTEGER			NOT NULL
	,CONSTRAINT TAirplanes_PK PRIMARY KEY ( intAirplaneID )
);

CREATE TABLE TPilotRoles
(
	 intPilotRoleID				INTEGER			NOT NULL
	,strPilotRole				VARCHAR(50)		NOT NULL
	,CONSTRAINT TPilotRoles_PK PRIMARY KEY	( intPilotRoleID )
);

CREATE TABLE TFlightPilots
(
	 intFlightID				INTEGER			NOT NULL
	,intPilotID					INTEGER			NOT NULL
	,intPilotRoleID				INTEGER 		NOT NULL
	,CONSTRAINT TFlightPilots_PK PRIMARY KEY ( intFlightID, intPilotID )
);

CREATE TABLE TPilots
(
	 intPilotID					INTEGER			NOT NULL
	,strFirstName				VARCHAR(50)		NOT NULL
	,strLastName				VARCHAR(50)		NOT NULL
	,strPhoneNumber				VARCHAR(50)		NOT NULL
	,CONSTRAINT TPilots_PK PRIMARY KEY ( intPilotID )
);


CREATE TABLE TFlightPassengers
(
	 intFLightID				INTEGER			NOT NULL
	,intPassengerIndex			INTEGER			NOT NULL
	,intPassengerID				INTEGER			NOT NULL
	,strSeatNumber				VARCHAR(50)		NOT NULL
	,CONSTRAINT TFlightPassengers_PK PRIMARY KEY ( intFlightID, intPassengerIndex )
);

CREATE TABLE TPassengers
(
	 intPassengerID				INTEGER			NOT NULL
	,strFirstName				VARCHAR(50)		NOT NULL
	,strLastName				VARCHAR(50)		NOT NULL
	,strPhoneNumber				VARCHAR(50)		NOT NULL
	,CONSTRAINT TPassengers_PK PRIMARY KEY ( intPassengerID )
);

CREATE TABLE TFlightAttendantRoles
(
	 intFlightAttendantRoleID	INTEGER			NOT NULL
	,strFlightAttendantRoles	VARCHAR(50)		NOT NULL
	,CONSTRAINT TFlightAttendantRoles_PK PRIMARY KEY ( intFlightAttendantRoleID )
);

CREATE TABLE TFlightFlightAttendants
(
	 intFlightID				INTEGER			NOT NULL
	,intFlightAttendantID		INTEGER			NOT NULL
	,intFlightAttendantRoleID	INTEGER			NOT NULL
	,CONSTRAINT TFlightFLightAttendants_PK PRIMARY KEY ( intFlightID, intFlightAttendantID )
);

CREATE TABLE TFlightAttendants
(
	 intFlightAttendantID		INTEGER			NOT NULL
	,strFirstName				VARCHAR(50)		NOT NULL
	,strLastName				VARCHAR(50)		NOT NULL
	,strPhoneNumber				VARCHAR(50)		NOT NULL
	,CONSTRAINT TFlightAttendants_PK PRIMARY KEY ( intFlightAttendantID )
);


-- --------------------------------------------------------------------------------
-- 4.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column(s)
-- -	-----							------						---------
-- 1	TFlights						TAirplanes					intAirplaneID
-- 2	TFlightPilots					TFlights					intFlightID
-- 3	TFlightPilots					TPilots						intPilotID
-- 4	TFlightPilots					TPilotRoles					intPilotRoleID
-- 5	TFlightPassengers				TFlights					intFlightID
-- 6	TFlightPassengers				TPassengers					intPassengerID
-- 7	TFlightFlightAttendants			TFlights					intFlightID
-- 8	TFlightFlightAttendants			TFlightAttendants			intFlightAttendantID
-- 9	TFlightFlightAttendants			TFlightAttendantRoles		intFlightAttendantRoleID

ALTER TABLE TFlights ADD CONSTRAINT TFlights_TAirplanes_FK
FOREIGN KEY ( intAirplaneID ) REFERENCES TAirplanes ( intAirplaneID )

ALTER TABLE TFlightPilots ADD CONSTRAINT TFlightPilots_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightPilots ADD CONSTRAINT TFlightPilots_TPilots_FK
FOREIGN KEY ( intPilotID ) REFERENCES TPilots ( intPilotID )

ALTER TABLE TFlightPilots ADD CONSTRAINT TFlightPilots_TPilotRoles_FK
FOREIGN KEY ( intPilotRoleID ) REFERENCES TPilotRoles ( intPilotRoleID )

ALTER TABLE TFlightPassengers ADD CONSTRAINT TFlightPassengers_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightPassengers ADD CONSTRAINT TFlightPassengers_TPassengers_FK
FOREIGN KEY ( intPassengerID ) REFERENCES TPassengers ( intPassengerID ) 

ALTER TABLE TFlightFlightAttendants ADD CONSTRAINT TFlightFlightAttendants_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightFlightAttendants ADD CONSTRAINT TFlightFlightAttendants_TFlightAttendants_FK
FOREIGN KEY ( intFlightAttendantID ) REFERENCES TFlightAttendants ( intFlightAttendantID )

ALTER TABLE TFlightFlightAttendants ADD CONSTRAINT TFlightFlightAttendants_TFlightAttendantRoles_FK
FOREIGN KEY ( intFlightAttendantRoleID ) REFERENCES TFlightAttendantRoles ( intFlightAttendantRoleID )

-- --------------------------------------------------------------------------------
-- 4.3: Add data to tables
-- --------------------------------------------------------------------------------

INSERT INTO TAirplanes ( intAirplaneID, strAirplaneNumber, strAirplaneType, intCapacity ) 
VALUES		 ( 1, 'ZZ034', '737', 200 )
			,( 2, '23423', '767', 350 )
			,( 3, '03403', '737', 200 )

INSERT INTO TFlights ( intFlightID, strFlight, strDescription, intAirplaneID )
VALUES		 ( 1, '1705', 'CVG to ATL', 1 )
			,( 2, '4302', 'ATL to PHX', 2 )
			,( 3, '1616', 'YYZ to FLA', 3 )

INSERT INTO TPilots ( intPilotID, strFirstName, strLastName, strPhoneNumber )
VALUES		 ( 1, 'Pilot', 'Bob', '555-0001' )
			,( 2, 'Pilot', 'Joe', '555-0002' ) 
			,( 3, 'Pilot', 'Betty', '555-0003' )
			,( 4, 'Pilot', 'Sue', '555-0004' )
			,( 5, 'Pilot', 'Alpha', '555-0005')
			,( 6, 'Pilot', 'Omega', '555-006' )

INSERT INTO TPilotRoles ( intPilotRoleID, strPilotRole )
VALUES		 ( 1, 'Pilot' )
			,( 2, 'CoPilot' )

INSERT INTO TFlightPilots ( intFlightID, intPilotID, intPilotRoleID ) 
VALUES		 ( 1, 1, 1 )
			,( 1, 2, 2 )
			,( 2, 3, 1 )
			,( 2, 4, 2 )
			,( 3, 5, 1 )
			,( 3, 6, 2 )


INSERT INTO TFlightAttendants ( intFlightAttendantID, strFirstName, strLastName,strPhoneNumber ) 
VALUES		 ( 1, 'Attendant', 'Mark', '555-1001' )
			,( 2, 'Attendant', 'Mary', '555-1002' )
			,( 3, 'Attendant', 'Matthew', '555-1003' )
			,( 4, 'Attendant', 'John', '555-1004' )
			,( 5, 'Attendant', 'Paul', '555-1005' )
			,( 6, 'Attendant', 'Luke', '555-1006' )

INSERT INTO TFlightAttendantRoles ( intFlightAttendantRoleID, strFlightAttendantRoles )
VALUES		 ( 1, 'Chief Attendant' )
			,( 2, 'Attendant' )

INSERT INTO TFlightFlightAttendants ( intFlightID, intFlightAttendantID, intFlightAttendantRoleID ) 
VALUES		 ( 1, 1, 1 )
			,( 1, 2, 2 )
			,( 2, 3, 1 )
			,( 2, 4, 2 )
			,( 3, 5, 1 )
			,( 3, 6, 2 )

INSERT INTO TPassengers ( intPassengerID, strFirstName, strLastName, strPhoneNumber )
VALUES		 ( 1, 'Pass', 'Enger 01', '555-2001' )
			,( 2, 'Pass', 'Enger 02', '555-2002' )
			,( 3, 'Pass', 'Enger 03', '555-2003' )
			,( 4, 'Pass', 'Enger 04', '555-2004' )
			,( 5, 'Pass', 'Enger 05', '555-2005' )
			,( 6, 'Pass', 'Enger 06', '555-2006' )

INSERT INTO TFlightPassengers ( intFLightID, intPassengerIndex, intPassengerID, strSeatNumber )
VALUES		 ( 1, 1, 1, 'A1' )
			,( 1, 2, 2, 'A2' )
			,( 2, 1, 3, 'B1' )
			,( 2, 2, 4, 'B2' )
			,( 3, 1, 5, 'C1' )
			,( 3, 2, 6, 'C2' )

-- --------------------------------------------------------------------------------
-- 4.4: Write the join that will show all the flight info and all pilots except
--      co-pilots. Display airplane information.  Use and order by clause
-- --------------------------------------------------------------------------------

SELECT
	 TF.intFlightID
	,TF.strFlight
	,TF.strDescription
	,TPi.intPilotID
	,TPi.strLastName
		+ ', ' + TPi.strFirstName AS strPilotName
	,TPi.strPhoneNumber
	,TPR.strPilotRole
	,TA.intAirplaneID
	,TA.strAirplaneNumber
	,TA.strAirplaneType
	,TA.intCapacity

FROM
	TFlights As TF
		JOIN TFlightPilots As TFPi
			JOIN TPilots As TPi
			ON ( TFPi.intPilotID = TPi.intPilotID )
			JOIN TPilotRoles As TPR
			ON (TFPi.intPilotRoleID = TPR.intPilotRoleID )
		ON ( TF.intFlightID = TFPi.intFlightID )
		JOIN TAirplanes As TA
		ON ( TF.intAirplaneID = TA.intAirplaneID )

WHERE
	TPR.strPilotRole = 'Pilot'

ORDER BY
	 TF.intFlightID

-- --------------------------------------------------------------------------------
-- 4.5: Write the join that will show all the passengers on all flights.
-- --------------------------------------------------------------------------------

SELECT
	 TPa.intPassengerID
	,TPa.strLastName
		+ ', ' + TPa.strFirstName
	,TPa.strPhoneNumber
	,TF.intFlightID
	,TFPa.strSeatNumber

FROM
	TFlights As TF
		JOIN TFlightPassengers As TFPa
			JOIN TPassengers As TPa
			ON ( TFPa.intPassengerID = TPa.intPassengerID )
		ON ( TF.intFlightID = TFPa.intFLightID )

ORDER BY
	 TF.intFlightID




-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------

DROP TABLE TCustomerOrderItems
DROP TABLE TItems
DROP TABLE TCustomerOrders
DROP TABLE TCustomers
-- --------------------------------------------------------------------------------
-- Step #5.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
(
	 intCustomerID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(50)		NOT NULL
	,strLastName			VARCHAR(50)		NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
);

CREATE TABLE TCustomerOrders
(
	 intCustomerID			INTEGER			NOT NULL
	,intOrderIndex			INTEGER			NOT NULL
	,dtmOrder				DATETIME		NOT NULL
	,CONSTRAINT TCustomerOrders_PK PRIMARY KEY ( intCustomerID, intOrderIndex )
);


CREATE TABLE TCustomerOrderItems
(
	 intCustomerID			INTEGER			NOT NULL
	,intOrderIndex			INTEGER			NOT NULL
	,intItemID				INTEGER			NOT NULL
	,intQuantity			INTEGER			NOT NULL	
	,CONSTRAINT TCustomerOrderItems_PK PRIMARY KEY ( intCustomerID, intOrderIndex, intItemID )
);


CREATE TABLE TItems
(
	 intItemID				INTEGER			NOT NULL
	,strItemName			VARCHAR(50)		NOT NULL
	,monPrice				MONEY			NOT NULL
	,CONSTRAINT TItem_PK PRIMARY KEY ( intItemID )
);





-- --------------------------------------------------------------------------------
-- Step #5.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column(s)
-- -	-----							------						---------
-- 1	TCustomerOrders					TCustomers					intCustomerID
-- 2	TCustomerOrderItems				TCustomerOrders				intCustomerID, intOrderIndex
-- 3	TCustomerOrderItems				TItems						intItemID

ALTER TABLE TCustomerOrders ADD CONSTRAINT TCustomerOrders_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

ALTER TABLE TCustomerOrderItems ADD CONSTRAINT TCustomerOrderItems_TCustomerOrders_FK
FOREIGN KEY ( intCustomerID, intOrderIndex ) REFERENCES TCustomerOrders ( intCustomerID, intOrderIndex )

ALTER TABLE TCustomerOrderItems ADD CONSTRAINT TCustomerOrdersItems_TItems_FK
FOREIGN KEY ( intItemID ) REFERENCES TItems ( intItemID )


-- --------------------------------------------------------------------------------
-- Step #5.3: Add data to tables
-- --------------------------------------------------------------------------------

INSERT INTO TCustomers ( intCustomerID, strFirstName, strLastName )
VALUES		 ( 1, 'Ryan', 'Dennick' )
			,( 2, 'Lucy', 'Hill' )
			,( 3, 'Wendy', 'Berry' )


INSERT INTO TCustomerOrders ( intCustomerID, intOrderIndex, dtmOrder )
VALUES		 ( 1, 1, '2001/01/01 1:00 PM' )
			,( 1, 2, '2002/02/02 2:00 PM' )
			,( 1, 3, '2003/03/03 3:00 PM' )

			,( 2, 1, '2004/04/04 4:00 PM' )
			,( 2, 2, '2005/05/05 5:00 PM' )
			,( 2, 3, '2006/06/06 6:00 PM' )

			,( 3, 1, '2007/07/07 7:00 PM' )
			,( 3, 2, '2008/08/08 8:00 PM' )
			,( 3, 3, '2009/09/09 9:00 PM' )



INSERT INTO TItems ( intItemID, strItemName, monPrice )
VALUES		 ( 1, 'MacBook', 1000 )
			,( 2, 'Calculator', 90.99 )
			,( 3, 'Bike', 300 )
			,( 4, 'Baseball Glove', 50.50 )
			,( 5, 'Couch', 450.98 )
			,( 6, 'Stereo', 250.99 )

INSERT INTO TCustomerOrderItems ( intCustomerID, intOrderIndex, intItemID, intQuantity )
VALUES 		 ( 1, 1, 1, 1 )
			,( 1, 1, 2, 2 )
			,( 1, 2, 3, 1 )
			,( 1, 2, 4, 1 )
			,( 1, 3, 5, 1 )
			,( 1, 3, 6, 1 )

			,( 2, 1, 1, 3 )
			,( 2, 1, 2, 2 )
			,( 2, 2, 3, 5 )
			,( 2, 2, 4, 4 )
			,( 2, 3, 5, 2 )
			,( 2, 3, 6, 1 )

			,( 3, 1, 1, 3 )
			,( 3, 1, 2, 5 )
			,( 3, 2, 3, 1 )
			,( 3, 2, 4, 6 )
			,( 3, 3, 5, 1 )
			,( 3, 3, 6, 2 )


-- --------------------------------------------------------------------------------
-- Step #5.4: Write the join that will show all customers, their orders and the 
--			  items on their orders. use and order by clause
-- --------------------------------------------------------------------------------

SELECT
	 TC.intCustomerID
	,TC.strLastName
		+ ', ' + TC.strFirstName AS strCustomer
	,TCO.intOrderIndex
	,TCO.dtmOrder
	,TI.intItemID
	,TI.strItemName
	,TI.monPrice
	,TCOI.intQuantity

FROM

	TCustomers As TC
		JOIN TCustomerOrders As TCO
			JOIN TCustomerOrderItems As TCOI
				JOIN TItems AS TI
				ON ( TCOI.intItemID = TI.intItemID )
			ON (TCO.intCustomerID = TCOI.intCustomerID AND TCO.intOrderIndex = TCOI.intOrderIndex )
		ON ( TC.intCustomerID = TCO.intCustomerID )

ORDER BY
	 TC.strLastName
	,TC.strFirstName

-- --------------------------------------------------------------------------------
-- Extra: Write the join that will show customer information, the order information
--		  and the total cost of the order
-- --------------------------------------------------------------------------------


SELECT
	 TC.intCustomerID
	,TC.strLastName
		+ ', ' + TC.strFirstName AS strCustomer
	,TCO.intOrderIndex
	,TCO.dtmOrder
	,SUM(TI.monPrice * TCOI.intQuantity) AS monTotal

FROM
	TCustomers As TC
		JOIN TCustomerOrders As TCO
			JOIN TCustomerOrderItems As TCOI
				JOIN TItems AS TI
				ON ( TCOI.intItemID = TI.intItemID )
			ON (TCO.intCustomerID = TCOI.intCustomerID AND TCO.intOrderIndex = TCOI.intOrderIndex )
		ON ( TC.intCustomerID = TCO.intCustomerID )

GROUP BY 
	 TC.intCustomerID
	,TC.strLastName
	,TC.strFirstName 
	,TCO.intOrderIndex
	,TCO.dtmOrder

ORDER BY
	 TC.strLastName
	,TC.strFirstName
	,TCO.dtmOrder