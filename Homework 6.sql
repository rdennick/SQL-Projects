-- --------------------------------------------------------------------------------
-- Name: Ryan Dennick
-- Class: IT-111-400
-- Abstract: Homework 6 
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------

DROP TABLE TFlightAttendants
DROP TABLE TFlightPassengers
DROP TABLE TFlightPilots
DROP TABLE TFlights

-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
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
	,bitFlightAttendantChief		BIT				NOT NULL
	,CONSTRAINT TFlightAttendants_PK PRIMARY KEY( intFlightID, intAttendantIndex )
);


-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child				Parent				Column(s)
-- -	-----				------				---------
-- 1	TFlightPilots		TFlights			intFlightID
-- 2	TFlightAttendents	TFlights			intFlightID
-- 3	TFlighPassengers	TFlights			intFlightID

ALTER TABLE TFlightPilots ADD CONSTRAINT TFlightPilots_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightAttendants ADD CONSTRAINT TFlightAttendants_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightPassengers ADD CONSTRAINT TFlightPassengers_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )



-- --------------------------------------------------------------------------------
-- Step #1.3: Add at least three flights
-- --------------------------------------------------------------------------------

INSERT INTO TFLights ( intFlightID, strFlight, strDescription, strAirplaneNumber, strAirplaneType, intAirplaneCapacity )
VALUES			 ( 1, '123', 'CVG to ATL', '123', 'Boeing 747', 230 )
				,( 2, '234', 'CVG to LAX', '123','Boeing 747',230 )
				,( 3, '345', 'CVG to JFK', '234', 'Boeing 767', 400)


-- --------------------------------------------------------------------------------
-- Step #1.4: Add at least two pilots to each flight
-- --------------------------------------------------------------------------------

INSERT INTO TFlightPilots ( intFlightID, intPilotIndex, strPilotFirstName, strPilotLastName, strPilotPhoneNumber, strPilotRole )
VALUES			 ( 1, 1, 'Jim','Jones', '222-222-2222', 'Pilot' ) 
				,( 1, 2, 'Jane', 'Jones', '333-333-3333', 'Co-Pilot' )
				,( 1, 3, 'Tim', 'Hudson', '243-343-5455', 'Backup Pilot' )
				,( 1, 4, 'Lauren', 'Marks', '135-246-7913', 'Backup Co-Pilot')
				,( 2, 1, 'Steve', 'Miller', '444-444-4444', 'Pilot')
				,( 2 ,2, 'Susan', 'Smith', '555-555-5555', 'Co-Pilot' )
				,( 2, 3, 'Hank', 'Williams', '357-801-2468', 'Backup Pilot')
				,( 2, 4, 'Kara', 'Bailey', '975-310-1592', 'Backup Co-Pilot' )
				,( 3, 1, 'Mike', 'Black', '666-666-6666', 'Pilot' )
				,( 3, 2, 'Sara', 'Jackson', '777-777-7777', 'Co-Pilot' )
				,( 3, 3, 'Peter', 'Franks', '223-334-5566', 'Backup Pilot' )
				,( 3, 4, 'Gina', 'Grey', '133-244-5778', 'Backup Co-Pilot' )


-- --------------------------------------------------------------------------------
-- Step #1.5: Add at least two flight attendants to each flight
-- --------------------------------------------------------------------------------

INSERT INTO TFlightAttendants ( intFlightID, intAttendantIndex, strFlightAttendantFirstName, strFlightAttendantLastName, strFlightAttendantPhoneNumber, bitFlightAttendantChief )
VALUES			 ( 1, 1, 'John', 'Bates', '888-888-8888', 1 )
				,( 1, 2, 'Megan', 'Hill', '999-999-9999', 0 )
				,( 2, 1, 'Mark', 'Phillips', '123-456-7890', 1)
				,( 2, 2, 'Katie', 'James', '234-567-8901', 0 )
				,( 3, 1, 'George', 'Johnson', '345-678-9012', 1 )
				,( 3, 2, 'Cari', 'Marks', '567-890-1234', 0 )


-- --------------------------------------------------------------------------------
-- Step #1.6: Add at least two flight attendants to each flight
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
DROP TABLE TPatientVisitLabTestResults
DROP TABLE TPatientVisitLabTests
DROP TABLE TPatientVisitMedications
DROP TABLE TPatientVisitProcedures
DROP TABLE TPatientVisits
DROP TABLE TPatients

-- --------------------------------------------------------------------------------
-- Step #2.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TPatients
(
	 intPatientID					INTEGER			NOT NULL	
	,strFirstName					VARCHAR(50)		NOT NULL
	,strLastName					VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatients_PK PRIMARY KEY( intPatientID )
);

CREATE TABLE TPatientVisits
(
	 intPatientID					INTEGER			NOT NULL
	,intVisitIndex					INTEGER			NOT NULL	
	,dtmVisitDate					DATETIME		NOT NULL
	,strVisitNotes					VARCHAR(8000)	NOT NULL
	,CONSTRAINT TPatientVisits_PK PRIMARY KEY( intPatientID, intVisitIndex )
);

CREATE TABLE TPatientVisitProcedures
(
	 intPatientID					INTEGER			NOT NULL
	,intVisitIndex					INTEGER			NOT NULL
	,intProcedureIndex				INTEGER			NOT NULL	
	,strProcedure					VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisitProcedures_PK PRIMARY KEY( intPatientID, intVisitIndex, intProcedureIndex )
);

CREATE TABLE TPatientVisitMedications
(
	 intPatientID					INTEGER			NOT NULL
	,intVisitIndex					INTEGER			NOT NULL
	,intMedicationIndex				INTEGER			NOT NULL	
	,strMedication					VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisitMedications_PK PRIMARY KEY( intPatientID, intVisitIndex, intMedicationIndex )
);

CREATE TABLE TPatientVisitLabTests
(
	 intPatientID					INTEGER			NOT NULL
	,intVisitIndex					INTEGER			NOT NULL
	,intLabTestIndex				INTEGER			NOT NULL	
	,strLabTest						VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisitLabTests_PK PRIMARY KEY( intPatientID, intVisitIndex, intLabTestIndex )
);

CREATE TABLE TPatientVisitLabTestResults
(
	 intPatientID					INTEGER			NOT NULL
	,intVisitIndex					INTEGER			NOT NULL
	,intLabTestIndex				INTEGER			NOT NULL
	,intResultIndex					INTEGER			NOT NULL	
	,strResult						VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisitLabTestResults_PK PRIMARY KEY( intPatientID, intVisitIndex, intLabTestIndex, intResultIndex )
);

-- --------------------------------------------------------------------------------
-- Step #2.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child								Parent							Column(s)
-- -	-----								------							---------
-- 1	TPatientVisits						TPatients						intPatientID
-- 2	TPatientVisitProcedures				TPatientVisits					intPatientID, intVisitIndex
-- 3	TPatientVisitMedications			TPatientVisits					intPatientID, intVisitIndex
-- 4	TPatientVisitLabTests				TPatientVisits					intPatientID, intVisitIndex
-- 5	TPatientVisitLabTestResults			TPatientVisitLabTests			intPatientID, intVisitIndex, intLabTestIndex

ALTER TABLE TPatientVisits ADD CONSTRAINT TPatientVisits_TPatients_FK
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )

ALTER TABLE TPatientVisitProcedures ADD CONSTRAINT TPatientVisitsProcedures_TPatientVisits_FK
FOREIGN KEY ( intPatientID, intVisitIndex ) REFERENCES TPatientVisits ( intPatientID, intVisitIndex )

ALTER TABLE TPatientVisitMedications ADD CONSTRAINT TPatientVisitsMedications_TPatientVisits_FK
FOREIGN KEY ( intPatientID, intVisitIndex ) REFERENCES TPatientVisits ( intPatientID, intVisitIndex )

ALTER TABLE TPatientVisitLabTests ADD CONSTRAINT TPatientVisitsLabTests_TPatientVisits_FK
FOREIGN KEY ( intPatientID, intVisitIndex ) REFERENCES TPatientVisits ( intPatientID, intVisitIndex )

ALTER TABLE TPatientVisitLabTestResults ADD CONSTRAINT TPatientVisitLabTestResults_TPatientVisitLabTests_FK
FOREIGN KEY ( intPatientID, intVisitIndex, intLabTestIndex ) REFERENCES TPatientVisitLabTests ( intPatientID, intVisitIndex, intLabTestIndex )

-- --------------------------------------------------------------------------------
-- Step #2.3: Add 2 patients
-- --------------------------------------------------------------------------------

INSERT INTO TPatients ( intPatientID, strFirstName, strLastName )
VALUES			 ( 1, 'Ryan', 'Dennick' )
				,( 2, 'Jon', 'Doe' )

-- --------------------------------------------------------------------------------
-- Step #2.4: Add at least two visits for each patient
-- --------------------------------------------------------------------------------

INSERT INTO TPatientVisits ( intPatientID, intVisitIndex, dtmVisitDate, strVisitNotes ) 
VALUES			 ( 1, 1, '01/01/2001', 'Patient came in with symptoms of the flu.' )
				,( 1, 2, '02/02/2002', 'Patient came in for a routine check-up.' )
				,( 2, 1, '03/03/2003', 'Patient came in with a stomach virus.' )
				,( 2, 2, '04/04/2004', 'Patient came in with a broken arm.' )

-- --------------------------------------------------------------------------------
-- Step #2.5: Add at least two procedures for each patient
-- --------------------------------------------------------------------------------

INSERT INTO TPatientVisitProcedures ( intPatientID, intVisitIndex, intProcedureIndex, strProcedure )
VALUES			 ( 1, 1, 1, 'Check vitals' )
				,( 1, 1, 2, 'Take temperature' )
				,( 1, 2, 1, 'Test reflexes' )
				,( 1, 2, 2, 'Blood test' )
				,( 2, 1, 1, 'Take temperature' )
				,( 2, 1, 2, 'Check vitals' )
				,( 2, 2, 1, 'Perform surgery' )
				,( 2, 2, 2, 'Place arm in a cast' )

-- --------------------------------------------------------------------------------
-- Step #2.6: Add at least two medications for each patient
-- --------------------------------------------------------------------------------

INSERT INTO TPatientVisitMedications ( intPatientID, intVisitIndex, intMedicationIndex, strMedication )
VALUES			 ( 1, 1, 1, 'Advil' )
				,( 1, 1, 2, 'NyQuil' )
				,( 1, 2, 1, '' )
				,( 1, 2, 2, '' )
				,( 2, 1, 1, 'Advil' )
				,( 2, 1, 2, 'NyQuil' )
				,( 2, 2, 1, 'Pain Killer' )
				,( 2, 2, 2, 'Tylenol' )

-- --------------------------------------------------------------------------------
-- Step #2.7: Add at least two lab tests for each patient
-- --------------------------------------------------------------------------------

INSERT INTO TPatientVisitLabTests ( intPatientID, intVisitIndex, intLabTestIndex, strLabTest )
VALUES			 ( 1, 1, 1, 'Flu Test' ) 
				,( 1, 1, 2, 'Mono' )
				,( 1, 2, 1, 'Electrolytes' )
				,( 1, 2, 2, 'Glucose' )
				,( 2, 1, 1, 'Flu Test' )
				,( 2, 1, 2, 'Lyme Disease' )
				,( 2, 2, 1, 'X-Ray' )
				,( 2, 2, 2, 'MRI' )

-- --------------------------------------------------------------------------------
-- Step #2.8: Add at least two results for each lab test
-- --------------------------------------------------------------------------------

INSERT INTO TPatientVisitLabTestResults ( intPatientID, intVisitIndex, intLabTestIndex, intResultIndex, strResult )
VALUES			 ( 1, 1, 1, 1, 'Positive' )
				,( 1, 1, 1, 2, 'Negative' )
				,( 1, 1, 2, 1, 'Positive' )
				,( 1, 1, 2, 2, 'Negative' )
				,( 1, 2, 1, 1, 'Positive' )
				,( 1, 2, 1, 2, 'Negative' )
				,( 1, 2, 2, 1, 'Positive' )
				,( 1, 2, 2, 2, 'Negative' )
				,( 2, 1, 1, 1, 'Positive' )
				,( 2, 1, 1, 2, 'Negative' )
				,( 2, 1, 2, 1, 'Positive' )
				,( 2, 1, 2, 2, 'Negative' )
				,( 2, 2, 1, 1, 'Positive' )
				,( 2, 2, 1, 2, 'Negative' )
				,( 2, 2, 2, 1, 'Positive' )
				,( 2, 2, 2, 2, 'Negative' )


-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TCourtDocketCaseDefendantLawyers 
DROP TABLE TCourtDocketCaseDefendants
DROP TABLE TCourtDocketCasePlaintiffLawyers 
DROP TABLE TCourtDocketCasePlaintiffs
DROP TABLE TCourtDocketCases
DROP TABLE TCourtDockets


-- --------------------------------------------------------------------------------
-- Step #3.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TCourtDockets
(
	 intCourtRoomID					INTEGER			NOT NULL	
	,strCourtRoomNumber				VARCHAR(50)		NOT NULL
	,strJudgeFirstName				VARCHAR(50)		NOT NULL
	,strJudgeLastName				VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourtDockets_PK PRIMARY KEY( intCourtRoomID )
);

CREATE TABLE TCourtDocketCases
(
	 intCourtRoomID					INTEGER			NOT NULL
	,intCaseIndex					INTEGER			NOT NULL	
	,strCaseNumber					VARCHAR(50)		NOT NULL
	,strCaseTitle					VARCHAR(50)		NOT NULL
	,strCaseDescription				VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourtDocketCases_PK PRIMARY KEY( intCourtRoomID, intCaseIndex )
);

CREATE TABLE TCourtDocketCasePlaintiffs
(
	 intCourtRoomID					INTEGER			NOT NULL
	,intCaseIndex					INTEGER			NOT NULL
	,intPlaintiffIndex				INTEGER			NOT NULL	
	,strPlaintiffFirstName			VARCHAR(50)		NOT NULL
	,strPlaintiffLastName			VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourtDocketCasePlaintiffs_PK PRIMARY KEY( intCourtRoomID, intCaseIndex, intPlaintiffIndex )
);

CREATE TABLE TCourtDocketCasePlaintiffLawyers
(
	 intCourtRoomID					INTEGER			NOT NULL
	,intCaseIndex					INTEGER			NOT NULL
	,intPlaintiffIndex				INTEGER			NOT NULL
	,intPlaintiffLawyerIndex		INTEGER			NOT NULL	
	,strPlaintiffLawyerFirstName	VARCHAR(50)		NOT NULL
	,strPlaintiffLawyerLastName		VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourtDocketCasePlaintiffLawyers_PK PRIMARY KEY( intCourtRoomID, intCaseIndex, intPlaintiffIndex, intPlaintiffLawyerIndex )
);

CREATE TABLE TCourtDocketCaseDefendants
(
	 intCourtRoomID					INTEGER			NOT NULL
	,intCaseIndex					INTEGER			NOT NULL
	,intDefendantIndex				INTEGER			NOT NULL	
	,strDefendantFirstName			VARCHAR(50)		NOT NULL
	,strDefendantLastName			VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourtDocketCaseDefendants_PK PRIMARY KEY( intCourtRoomID, intCaseIndex, intDefendantIndex )
);
	
CREATE TABLE TCourtDocketCaseDefendantLawyers
(
	 intCourtRoomID					INTEGER			NOT NULL
	,intCaseIndex					INTEGER			NOT NULL
	,intDefendantIndex				INTEGER			NOT NULL
	,intDefendantLawyerIndex		INTEGER			NOT NULL	
	,strDefendantLawyerFirstName	VARCHAR(50)		NOT NULL
	,strDefendantLawyerLastName		VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourtDocketCaseDefendantLawyers_PK PRIMARY KEY( intCourtRoomID, intCaseIndex, intDefendantIndex, intDefendantLawyerIndex )
);


-- --------------------------------------------------------------------------------
-- Step #3.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child								Parent							Column(s)
-- -	-----								------							---------
-- 1	TCourtDocketCases					TCourtDockets					intCourtRoomID
-- 2	TCourtDocketCasePlaintiffs			TCourtDocketCases				intCourtRoomID, intCaseIndex
-- 3	TCourtDocketCaseDefendants			TCourtDocketCases				intCourtRoomID, intCaseIndex
-- 4	TCourtDocketCasePlaintiffLawyers	TCourtDocketCasePlaintiffs		intCourtRoomID, intCaseIndex, intPlaintiffIndex
-- 5	TCourtDocketCaseDefendantLawyers	TCourtDocketCaseDefendants		intCourtRoomID, intCaseIndex, intDefendantIndex

ALTER TABLE TCourtDocketCases ADD CONSTRAINT TCourtDocketCases_TCourtDockets_FK
FOREIGN KEY ( intCourtRoomID ) REFERENCES TCourtDockets ( intCourtRoomID )

ALTER TABLE TCourtDocketCasePlaintiffs ADD CONSTRAINT TCourtDocketCasePlaintiffs_TCourtDocketCases_FK
FOREIGN KEY ( intCourtRoomID, intCaseIndex ) REFERENCES TCourtDocketCases ( intCourtRoomID, intCaseIndex )

ALTER TABLE TCourtDocketCaseDefendants ADD CONSTRAINT TCourtDocketCaseDefendants_TCourtDocketCases_FK
FOREIGN KEY ( intCourtRoomID, intCaseIndex ) REFERENCES TCourtDocketCases ( intCourtRoomID, intCaseIndex )

ALTER TABLE TCourtDocketCasePlaintiffLawyers ADD CONSTRAINT TCourtDocketCasePlaintiffLawyers_TCourtDocketCasePlaintiffs_FK
FOREIGN KEY ( intCourtRoomID, intCaseIndex, intPlaintiffIndex ) REFERENCES TCourtDocketCasePlaintiffs ( intCourtRoomID, intCaseIndex, intPlaintiffIndex )

ALTER TABLE TCourtDocketCaseDefendantLawyers ADD CONSTRAINT TCourtDocketCaseDefendantLawyers_TCourtDocketCaseDefendants_FK
FOREIGN KEY ( intCourtRoomID, intCaseIndex, intDefendantIndex ) REFERENCES TCourtDocketCaseDefendants ( intCourtRoomID, intCaseIndex, intDefendantIndex )

-- --------------------------------------------------------------------------------
-- Step #3.3: Add at least two court rooms
-- --------------------------------------------------------------------------------

INSERT INTO TCourtDockets ( intCourtRoomID, strCourtRoomNumber, strJudgeFirstName, strJudgeLastName )
VALUES			 ( 1, '100', 'John', 'Smith' )
				,( 2, '200', 'Jane', 'Harris' )

-- --------------------------------------------------------------------------------
-- Step #3.4: Add at least two cases for each court room
-- --------------------------------------------------------------------------------

INSERT INTO TCourtDocketCases ( intCourtRoomID, intCaseIndex, strCaseNumber, strCaseTitle, strCaseDescription )
VALUES			 ( 1, 1, '100', 'The people vs Jim Henderson', 'Jim is accused of fraud.' )
				,( 1, 2, '120', 'The State vs Donna James', 'Ms. James was cited for speeding.' )
				,( 2 ,1, '190', 'The People vs Eli Danks', 'Mr. Danks is accused of thieft.' )
				,( 2, 2, '345', 'The State vs Laura Phillips', 'Mrs Phillips was cited for vandalism' )

-- --------------------------------------------------------------------------------
-- Step #3.5: Add at least two plaintiffs for each case
-- --------------------------------------------------------------------------------

INSERT INTO TCourtDocketCasePlaintiffs ( intCourtRoomID, intCaseIndex, intPlaintiffIndex, strPlaintiffFirstName, strPlaintiffLastName )
VALUES			 ( 1, 1, 1, 'Craig', 'Henderson' )
				,( 1, 1, 2, 'Penny', 'Blanks' )
				,( 1, 2, 1, 'Gerry', 'James' )
				,( 1, 2, 2, 'Kelly', 'Johnson' )
				,( 2, 1, 1, 'Eric', 'Nicks' )
				,( 2, 1, 2, 'Sara', 'Carry' )
				,( 2, 2, 1, 'Lisa', 'Allen' )
				,( 2, 2, 2, 'Larry', 'Welsh' )

-- --------------------------------------------------------------------------------
-- Step #3.6: Add at least two lawyers for each plaintiff
-- --------------------------------------------------------------------------------

INSERT INTO TCourtDocketCasePlaintiffLawyers ( intCourtRoomID, intCaseIndex, intPlaintiffIndex, intPlaintiffLawyerIndex, strPlaintiffLawyerFirstName, strPlaintiffLawyerLastName )
VALUES			 ( 1, 1, 1, 1, 'Jessica', 'Posey' )
				,( 1, 1, 1, 2, 'Kenny', 'Smith' )
				,( 1, 1, 2, 1, 'Joe', 'Gil' )
				,( 1, 1, 2, 2, 'Mary', 'Martin' )
				,( 1, 2, 1, 1, 'Blake', 'Jones' )
				,( 1, 2, 1, 2, 'Debora', 'Dennis' )
				,( 1, 2, 2, 1, 'Xavier', 'Wright' )
				,( 1, 2, 2, 2, 'Colleen', 'Schmidt' )
				,( 2, 1, 1, 1, 'Mike', 'Green' )
				,( 2, 1, 1, 2, 'Deon', 'Leftwitch' )
				,( 2, 1, 2, 1, 'Jay', 'Davis' )
				,( 2, 1, 2, 2, 'Jessie', 'Lofton' )
				,( 2, 2, 1, 1, 'Ryan', 'Berry' )
				,( 2, 2, 1, 2, 'Steve', 'Miller' )
				,( 2, 2, 2, 1, 'Pat', 'Oneill')
				,( 2, 2, 2, 2, 'Tina', 'Star' )

-- --------------------------------------------------------------------------------
-- Step #3.7: Add at least two defendants for each case
-- --------------------------------------------------------------------------------

INSERT INTO TCourtDocketCaseDefendants ( intCourtRoomID, intCaseIndex, intDefendantIndex, strDefendantFirstName, strDefendantLastName )
VALUES			 ( 1, 1, 1, 'Jim', 'Henderson' )
				,( 1, 1, 2, 'Rona', 'Banks' )
				,( 1, 2, 1, 'Donna', 'James' )
				,( 1, 2, 2, 'Kara', 'Johnson' )
				,( 2, 1, 1, 'Eli', 'Danks' )
				,( 2, 1, 2, 'Stephanie', 'Carry' )
				,( 2, 2, 1, 'Laura', 'Phillips' )
				,( 2, 2, 2, 'Sid', 'Walsh' )




-- --------------------------------------------------------------------------------
-- Step #3.6: Add at least two lawyers for each defendant
-- --------------------------------------------------------------------------------

INSERT INTO TCourtDocketCaseDefendantLawyers ( intCourtRoomID, intCaseIndex, intDefendantIndex, intDefendantLawyerIndex, strDefendantLawyerFirstName, strDefendantLawyerLastName )
VALUES			 ( 1, 1, 1, 1, 'Cory', 'Richards' )
				,( 1, 1, 1, 2, 'Keith', 'Faulk' )
				,( 1, 1, 2, 1, 'Tom', 'Hart' )
				,( 1, 1, 2, 2, 'Jordan', 'Hamilton' )
				,( 1, 2, 1, 1, 'Wes', 'Adams' )
				,( 1, 2, 1, 2, 'Tim', 'Douglas' )
				,( 1, 2, 2, 1, 'Herb', 'Willis' )
				,( 1, 2, 2, 2, 'Carrol', 'Speights' )
				,( 2, 1, 1, 1, 'Dan', 'White' )
				,( 2, 1, 1, 2, 'Darius', 'Vance' )
				,( 2, 1, 2, 1, 'Victor', 'Santiago' )
				,( 2, 1, 2, 2, 'Rob', 'Anderson' )
				,( 2, 2, 1, 1, 'Oliver', 'Bonds' )
				,( 2, 2, 1, 2, 'Terry', 'Doyle' )
				,( 2, 2, 2, 1, 'Daniel', 'Miles')
				,( 2, 2, 2, 2, 'Chris', 'Morten' )
