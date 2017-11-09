-- --------------------------------------------------------------------------------
-- Name: Ryan Dennick
-- Class: IT-111-400
-- Abstract: Homework 5 - 1NF Practice
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TUserFavoriteSongs
DROP TABLE TUsers

-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------


CREATE TABLE TUsers
(
	 intUserID						INTEGER			NOT NULL	
	,strUserName					VARCHAR(50)		NOT NULL
	,strEmailAddress				VARCHAR(50)		NOT NULL
	,CONSTRAINT TUsers_PK PRIMARY KEY( intUserID )
);


CREATE TABLE TUserFavoriteSongs
(
	 intUserID						INTEGER			NOT NULL	
	,intFavoriteSongIndex			INTEGER			NOT NULL
	,strFavoriteSongName			VARCHAR(50)		NOT NULL
	,strFavoriteSongArtist			VARCHAR(50)		NOT NULL
	,CONSTRAINT TUserFavoriteSongs_PK PRIMARY KEY( intUserID, intFavoriteSongIndex )
);


-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child					Parent					Column(s)
-- -	-----					------					---------
--1		TUserFavotiteSongs		TUsers					intUserID

ALTER TABLE TUserFavoriteSongs ADD CONSTRAINT TUserFavoriteSongs_TUsers_FK
FOREIGN KEY ( intUserID ) REFERENCES TUsers ( intUserID )


-- --------------------------------------------------------------------------------
-- Step #1.3: Add at least 3 users
-- --------------------------------------------------------------------------------

INSERT INTO TUsers ( intUserID, strUserName, strEmailAddress )
VALUES			 ( 1, 'Bill Ding', 'BillDing@Downtown.com' )
				,( 2, 'Luke Skywalker', 'LSkywalker@Jedi.com' )
				,( 3, 'James T. Kirk', 'KTKirk@StarFleet.gov' )

-- --------------------------------------------------------------------------------
-- Step #1.4: Add at least 2 songs per user
-- --------------------------------------------------------------------------------

INSERT INTO TUserFavoriteSongs (  intUserID, intFavoriteSongIndex, strFavoriteSongName, strFavoriteSongArtist )
VALUES			 ( 1, 1, 'Song A', 'Artist 1' )
				,( 1, 2, 'Song B', 'Artist 2' )
				,( 1, 3, 'Revolution Song', 'Phillips, Craig and Dean' )
				,( 2, 1, 'Hotel California', 'The Eagles' )
				,( 2, 2, 'Stairway to Heaven', 'Led Zeppelin' )
				,( 3, 1, 'Piano Man', 'Billy Joel' )
				,( 3 ,2, 'Hook', 'Blues Traveler' )

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TCourseBooks
DROP TABLE TCourseStudents
DROP TABLE TCourseRooms
DROP TABLE TCourses

-- --------------------------------------------------------------------------------
-- Step #2.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TCourses
(
	 intCourseID					INTEGER			NOT NULL	
	,strCourse						VARCHAR(50)		NOT NULL
	,strDescription					VARCHAR(50)		NOT NULL
	,strInstructorFirstName			VARCHAR(50)		NOT NULL
	,strInstructorLastName			VARCHAR(50)		NOT	NULL
	,strInstructorPhoneNumber		VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourses_PK PRIMARY KEY( intCourseID )
);

CREATE TABLE TCourseRooms
(
	 intCourseID					INTEGER			NOT NULL	
	,intRoomIndex					INTEGER			NOT NULL
	,strRoomRoomNumber				VARCHAR(50)		NOT NULL
	,intRoomCapacity				INTEGER			NOT NULL
	,strRoomMeetingTimes			VARCHAR(50)		NOT	NULL
	,CONSTRAINT TCourseRooms_PK PRIMARY KEY( intCourseID, intRoomIndex )
);

CREATE TABLE TCourseStudents
(
	 intCourseID					INTEGER			NOT NULL	
	,intStudentIndex				INTEGER			NOT NULL
	,strStudentFirstName			VARCHAR(50)		NOT NULL
	,strStudentLastName				VARCHAR(50)		NOT NULL
	,strStudentNumber				VARCHAR(50)		NOT	NULL
	,strStudentPhoneNumber			VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourseStudents_PK PRIMARY KEY( intCourseID, intStudentIndex )
);

CREATE TABLE TCourseBooks
(
	 intCourseID					INTEGER			NOT NULL	
	,intBookIndex					INTEGER			NOT NULL
	,strBookName					VARCHAR(50)		NOT NULL
	,strBookAuthor					VARCHAR(50)		NOT NULL
	,strBookISBN					VARCHAR(50)		NOT	NULL
	,CONSTRAINT TCourseBooks_PK PRIMARY KEY( intCourseID, intBookIndex )
);

-- --------------------------------------------------------------------------------
-- Step #2.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child				Parent				Column(s)
-- -	-----				------				---------
-- 1	TRooms				TCourses			intCourseID
-- 2	TBooks				TCourses			intCourseID
-- 3	TStudents			TCourses			intCourseID

ALTER TABLE TCourseRooms ADD CONSTRAINT TCourseRooms_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

ALTER TABLE TCourseBooks ADD CONSTRAINT TCourseBooks_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )


-- --------------------------------------------------------------------------------
-- Step #2.3: Add at least 3 courses 
-- --------------------------------------------------------------------------------

INSERT INTO TCourses ( intCourseID, strCourse, strDescription, strInstructorFirstName, strInstructorLastName, strInstructorPhoneNumber )
VALUES			 ( 1, 'IT-111', 'Database Design and SQL 1', 'Pam', 'Randsdell', '555-555-5555' )
				,( 2, 'IT-101', '.NET Programming', 'Ray', 'Harmon', '777-777-7777' )
				,( 3, 'BPA-130', 'Business Sys Analysis', 'Lee', 'Clayton', '444-444-4444' )

-- --------------------------------------------------------------------------------
-- Step #2.4: Add at least 2 rooms to each course
-- --------------------------------------------------------------------------------

INSERT INTO TCourseRooms ( intCourseID, intRoomIndex, strRoomRoomNumber, intRoomCapacity, strRoomMeetingTimes )
VALUES			 (1, 1, '100', 50, 'M/W/F 10-11:20am' )
				,(1, 2, '110', 50, 'T/TH 10-11:50am' )
				,(2, 1, '300', 50, 'T/TH 8-9:30am' )
				,(2, 2, '500', 50, 'M/W/F 2-3:30pm' )
				,(3, 1, '400', 50, 'T/TH 8-9:30am' )
				,(3, 2, '120', 50, 'M/W/F 12-1:20pm' )


-- --------------------------------------------------------------------------------
-- Step #2.5: Add at least 2 books to each course
-- --------------------------------------------------------------------------------

INSERT INTO TCourseBooks ( intCourseID, intBookIndex, strBookName, strBookAuthor, strBookISBN )
VALUES			 (1, 1, 'SQL Server for Programmers', 'Patrick Callahan', 'ISBN 987-6-54-321234-5' )
				,(1, 2, 'Learn SQL', 'Joe Smith', 'ISBN 876-5-43-212345-6' )
				,(2, 1, 'Getting Started with Visual Basic', 'Tony Gaddis', 'ISBN 765-4-32-123456-7' )
				,(2, 2, 'Learn Visual Basic', 'Jane Doe', 'ISBN 654-3-21-234567-8' )
				,(3, 1, 'Systems Design and Analysis', 'John Campbell', 'ISBN 543-2-12-345678-9' )
				,(3, 2, 'Learn Systems Design', 'Ann Jones', 'ISBN 432-1-23-456789-8' ) 

-- --------------------------------------------------------------------------------
-- Step #2.6: Add at least 2 students to each course
-- --------------------------------------------------------------------------------

INSERT INTO TCourseStudents ( intCourseID, intStudentIndex, strStudentFirstName, strStudentLastName, strStudentNumber, strStudentPhoneNumber )
VALUES			 (1, 1, 'Ryan', 'Dennick', '1','123-456-7890' )
				,(1, 2, 'Billy', 'Jean', '2', '234-567-8901' )
				,(2, 1, 'Ryan', 'Dennick', '1', '123-456-7890' )
				,(2, 2, 'Billy', 'Jean', '2', '234-567-8901' )
				,(3, 1, 'Ryan', 'Dennick', '1', '123-456-7890' )
				,(3, 2, 'Billy', 'Jean', '2', '234-567-8901' )


-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TFlightAttendants
DROP TABLE TFlightPassengers
DROP TABLE TFlightPilots
DROP TABLE TFlights

-- --------------------------------------------------------------------------------
-- Step #3.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TFlights
(
	 intFlightID					INTEGER			NOT NULL	
	,strFlight						VARCHAR(50)		NOT NULL
	,strDescription					VARCHAR(50)		NOT NULL
	,strAirplaneNumber				VARCHAR(50)		NOT NULL
	,strAirplaneType				VARCHAR(50)		NOT NULL
	,intAirplaneCapacity			INTEGER			NOT NULL
	,CONSTRAINT TFlights_PK PRIMARY KEY( intFlightID )
);

CREATE TABLE TFlightPilots
(
	 intFlightID					INTEGER			NOT NULL
	,intPilotIndex					INTEGER			NOT NULL	
	,strPilotFirstName				VARCHAR(50)		NOT NULL
	,strPilotLastName				VARCHAR(50)		NOT NULL
	,strPilotPhoneNumber			VARCHAR(50)		NOT NULL
	,strPilotRole					VARCHAR(50)		NOT NULL
	,CONSTRAINT TFlightPilots_PK PRIMARY KEY( intFlightID, intPilotIndex )
);


CREATE TABLE TFlightPassengers
(
	 intFlightID					INTEGER			NOT NULL
	,intPassengerIndex				INTEGER			NOT NULL	
	,strPassengerFirstName			VARCHAR(50)		NOT NULL
	,strPassengerLastName			VARCHAR(50)		NOT NULL
	,strPassengerPhoneNumber		VARCHAR(50)		NOT NULL
	,strPassengerSeatNumber			VARCHAR(50)		NOT NULL
	,CONSTRAINT TFlightPassengers_PK PRIMARY KEY( intFlightID, intPassengerIndex )
);


CREATE TABLE TFlightAttendants
(
	 intFlightID					INTEGER			NOT NULL
	,intAttendantIndex				INTEGER			NOT NULL	
	,strFlightAttendantFirstName	VARCHAR(50)		NOT NULL
	,strFlightAttendantLastName		VARCHAR(50)		NOT NULL
	,strFlightAttendantPhoneNumber	VARCHAR(50)		NOT NULL
	,CONSTRAINT TFlightAttendants_PK PRIMARY KEY( intFlightID, intAttendantIndex )
);

-- --------------------------------------------------------------------------------
-- Step #3.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child				Parent				Column(s)
-- -	-----				------				---------
-- 1	TFlightPilots		TFlights			intFlightID
-- 2	TFlightAttendents	TFlights			intFlightID
-- 3	TFlighPassengers	TFlights			intFlightID

ALTER TABLE TFlightPilots ADD CONSTRAINT TPilots_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightAttendants ADD CONSTRAINT TFlightAttendants_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightPassengers ADD CONSTRAINT TFlightPassengers_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )


-- --------------------------------------------------------------------------------
-- Step #3.3: Add at least 3 flights
-- --------------------------------------------------------------------------------

INSERT INTO TFLights ( intFlightID, strFlight, strDescription, strAirplaneNumber, strAirplaneType, intAirplaneCapacity )
VALUES			 ( 1, '123', 'CVG to ATL', '123', 'Boeing 747', 230 )
				,( 2, '234', 'CVG to LAX', '123','Boeing 747',230 )
				,( 3, '345', 'CVG to JFK', '234', 'Boeing 767', 400)

-- --------------------------------------------------------------------------------
-- Step #3.4: Add at least 2 pilots to each flight
-- --------------------------------------------------------------------------------

INSERT INTO TFlightPilots ( intFlightID, intPilotIndex, strPilotFirstName, strPilotLastName, strPilotPhoneNumber, strPilotRole )
VALUES			 ( 1, 1, 'Jim','Jones', '222-222-2222', 'Pilot' ) 
				,( 1, 2, 'Jane', 'Jones', '333-333-3333', 'Co-Pilot' )
				,( 2, 1, 'Steve', 'Miller', '444-444-4444', 'Pilot' )
				,( 2 ,2, 'Susan', 'Smith', '555-555-5555', 'Co-Pilot' )
				,( 3, 1, 'Mike', 'Black', '666-666-6666', 'Pilot' )
				,( 3, 2, 'Sara', 'Jackson', '777-777-7777', 'Co-Pilot' )

-- --------------------------------------------------------------------------------
-- Step #3.5: Add at least 2 flight attendants to each flight
-- --------------------------------------------------------------------------------

INSERT INTO TFlightAttendants ( intFlightID, intAttendantIndex, strFlightAttendantFirstName, strFlightAttendantLastName, strFlightAttendantPhoneNumber )
VALUES			 ( 1, 1, 'John', 'Bates', '888-888-8888' )
				,( 1, 2, 'Megan', 'Hill', '999-999-9999' )
				,( 2, 1, 'Mark', 'Phillips', '123-456-7890')
				,( 2, 2, 'Katie', 'James', '234-567-8901' )
				,( 3, 1, 'George', 'Johnson', '345-678-9012' )
				,( 3, 2, 'Cari', 'Marks', '567-890-1234' )

-- --------------------------------------------------------------------------------
-- Step #3.6: Add at least 2 passengers to each flight
-- --------------------------------------------------------------------------------
INSERT INTO TFlightPassengers ( intFlightID, intPassengerIndex, strPassengerFirstName, strPassengerLastName, strPassengerPhoneNumber, strPassengerSeatNumber )
VALUES			 ( 1, 1, 'Joey', 'Parks', '678-901-2345', '1A' )
				,( 1, 2, 'Hillary', 'Norris', '789-012-3456', '1B' )
				,( 2, 1, 'Leon', 'Harris', '890-123-4567', '1A' )
				,( 2, 2, 'Kelly', 'Ball', '901-234-5678', '1B' )
				,( 3, 1, 'Danny', 'Stevens', '012-345-6789', '1A' )
				,( 3, 2, 'Valorie', 'Edwards', '987-654-3210', '1B' )

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------

DROP TABLE TCustomerOrderItems
DROP TABLE TCustomerOrders
DROP TABLE TCustomers

-- --------------------------------------------------------------------------------
-- Step #4.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
(
	 intCustomerID					INTEGER			NOT NULL	
	,strFirstName					VARCHAR(50)		NOT NULL
	,strLastName					VARCHAR(50)		NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY( intCustomerID )
);

CREATE TABLE TCustomerOrders
(
	 intCustomerID					INTEGER			NOT NULL	
	,intOrderIndex					INTEGER			NOT NULL
	,dtmOrder						DATETIME		NOT NULL
	,CONSTRAINT TCustomerOrders_PK PRIMARY KEY( intCustomerID, intOrderIndex )
);

CREATE TABLE TCustomerOrderItems
(
	 intCustomerID					INTEGER			NOT NULL	
	,intOrderIndex					INTEGER			NOT NULL
	,intItemIndex					INTEGER			NOT NULL
	,strItem						VARCHAR(50)		NOT NULL
	,intQuantity					INTEGER			NOT NULL
	,monPrice						INTEGER			NOT NULL
	,CONSTRAINT TCustomerOrderItems_PK PRIMARY KEY( intCustomerID, intOrderIndex, intItemIndex )
);


-- --------------------------------------------------------------------------------
-- Step #4.3: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child					Parent					Column(s)
-- -	-----					------					---------
-- 1	TCustomerOrders			TCustomers				intCustomerID
-- 2	TCustomerOrderItems		TCustomerOrders			intCustomerID, intOrderIndex

ALTER TABLE TCustomerOrders ADD CONSTRAINT TCustomerOrders_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

ALTER TABLE TCustomerOrderItems ADD CONSTRAINT TCustomerOrderItems_TCustomerOrders_FK
FOREIGN KEY ( intCustomerID, intOrderIndex ) REFERENCES TCustomerOrders ( intCustomerID, intOrderIndex )

-- --------------------------------------------------------------------------------
-- Step #4.4: Add at least 3 customers
-- --------------------------------------------------------------------------------

INSERT INTO TCustomers ( intCustomerID, strFirstName, strLastName )
VALUES				 ( 1, 'Ryan','Dennick' )
					,( 2, 'Larry', 'Michaels' )
					,( 3, 'Bob', 'Allen' )

-- --------------------------------------------------------------------------------
-- Step #4.5: Add at least 3 orders for each customer
-- --------------------------------------------------------------------------------

INSERT INTO TCustomerOrders ( intCustomerID, intOrderIndex, dtmOrder )
VALUES				 ( 1, 1, '1/1/2001' )
					,( 1, 2, '1/2/2002' )
					,( 1, 3, '2/2/2002' )
					,( 2, 1, '1/1/2001' )
					,( 2, 2, '3/3/2003' )
					,( 2, 3, '4/4/2004' )
					,( 3, 1, '5/5/2005' )
					,( 3, 2, '8/8/2008' )
					,( 3, 3, '9/9/2009' )

-- --------------------------------------------------------------------------------
-- Step #4.6: Add at least 2 items for each order
-- --------------------------------------------------------------------------------

INSERT INTO TCustomerOrderItems ( intCustomerID, intOrderIndex, intItemIndex, strItem, intQuantity, monPrice )
VALUES				 (1, 1, 1, 'Macbook Pro', 1, 1500 )
					,(1, 1, 2, 'Screen Protector', 1, 10 )
					,(1, 2, 1, 'Baseball Glove', 1, 250 )
					,(1, 2, 2, 'Baseball', 12, 10 )
					,(1, 3, 1, 'Text Book', 1, 150 )
					,(1, 3, 2, 'Graphing Calculator', 1, 90 )
					,(2, 1, 1, 'TV', 1, 600 )
					,(2, 1, 2, 'TV Stand', 1, 150 )
					,(2, 2, 1, 'Couch', 2, 3000 )
					,(2, 2, 2, 'TV Stand', 1, 150 )
					,(2, 3, 1, 'Bedding', 1, 100 )
					,(2, 3, 2, 'Pillow', 4, 100 )
					,(3, 1, 1, 'Stereo', 1, 300  )
					,(3, 1, 2, 'CDs', 5, 50 )
					,(3, 2, 1, 'Picture Frame', 5, 25 )
					,(3, 2, 2, 'Camera', 1, 200 )
					,(3, 3, 1, 'Pots', 8, 150 )
					,(3, 3, 2, 'Mixer', 1, 250 )

