-- --------------------------------------------------------------------------------
-- Name: Ryan Dennick
-- Class: IT-111-400
-- Abstract: Test #2
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TBookClubMeetingBookAuthors
DROP TABLE TBookClubMeetings
DROP TABLE TBookClubMembers
DROP TABLE TBooks
DROP TABLE TBookGenres
DROP TABLE TAuthors
DROP TABLE TAuthorRanks
DROP TABLE TMemberPhoneNumbers
DROP TABLE TMemberPhoneNumberTypes
DROP TABLE TMemberEmails
DROP TABLE TMembers
DROP TABLE TBookClubs
DROP TABLE TClubOrganizers

-- --------------------------------------------------------------------------------
-- Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TClubOrganizers
(
	 intClubOrganizerID			INTEGER			NOT NULL
	,strFirstName				VARCHAR(50)		NOT NULL
	,strLastName				VARCHAR(50)		NOT NULL
	,CONSTRAINT TClubOrganizers_PK PRIMARY KEY ( intClubOrganizerID )
);

CREATE TABLE TBookClubs
(
	 intClubID					INTEGER			NOT NULL
	,strClubName				VARCHAR(50)		NOT NULL
	,intClubOrganizerID			INTEGER			NOT NULL
	,CONSTRAINT TBookClubs_PK PRIMARY KEY ( intClubID )
);

CREATE TABLE TBookClubMembers
(
	 intClubID					INTEGER			NOT NULL
	,intMemberIndex				INTEGER			NOT NULL
	,intMemberID				INTEGER			NOT NULL
	,CONSTRAINT TBookClubMembers_PK PRIMARY KEY ( intClubID, intMemberIndex )
);

CREATE TABLE TMembers
(
	 intMemberID				INTEGER			NOT NULL
	,strFirstName				VARCHAR(50)		NOT NULL
	,strLastName				VARCHAR(50)		NOT NULL
	,CONSTRAINT TMembers_PK PRIMARY KEY ( intMemberID )
);

CREATE TABLE TMemberPhoneNumbers
(
	 intMemberID				INTEGER			NOT NULL
	,intPhoneNumberIndex		INTEGER			NOT NULL
	,strPhoneNumber				VARCHAR(50)		NOT NULL
	,intPhoneNumberTypeID		INTEGER			NOT NULL
	,CONSTRAINT TMemberPhoneNumbers_PK PRIMARY KEY ( intMemberID, intPhoneNumberIndex )
);

CREATE TABLE TMemberEmails
(
	 intMemberID				INTEGER			NOT NULL
	,intEmailIndex				INTEGER			NOT NULL
	,strEmail					VARCHAR(50)		NOT NULL
	,CONSTRAINT TMemberEmails_PK PRIMARY KEY ( intMemberID, intEmailIndex )
);

CREATE TABLE TMemberPhoneNumberTypes
(
	 intPhoneNumberTypeID		INTEGER			NOT NULL
	,strPhoneNumberType			VARCHAR(50)		NOT NULL
	,CONSTRAINT TMemberPhoneNumberTypes_PK PRIMARY KEY ( intPhoneNumberTypeID )
);

CREATE TABLE TBookClubMeetings
(
	 intClubID					INTEGER			NOT NULL
	,intMeetingIndex			INTEGER			NOT NULL
	,dteMeetingDate				DATE			NOT NULL
	,intBookID					INTEGER			NOT NULL
	,CONSTRAINT TBookClubMeetings_PK PRIMARY KEY ( intClubID, intMeetingIndex )
);

CREATE TABLE TBookClubMeetingBookAuthors
(
	 intClubID					INTEGER			NOT NULL
	,intMeetingIndex			INTEGER			NOT NULL
	,intAuthorIndex				INTEGER			NOT NULL
	,intAuthorID				INTEGER			NOT NULL
	,CONSTRAINT TBookClubMeetingBookAuthers_PK PRIMARY KEY ( intClubID, intMeetingIndex, intAuthorIndex ) 
);

CREATE TABLE TBooks
(
	 intBookID					INTEGER			NOT NULL
	,strBookName				VARCHAR(50)		NOT NULL
	,intGenreID					INTEGER			NOT NULL
	,CONSTRAINT TBooks_PK PRIMARY KEY ( intBookID )
);

CREATE TABLE TBookGenres
(
	 intGenreID					INTEGER			NOT NULL
	,strBookGenre				VARCHAR(50)		NOT NULL
	,CONSTRAINT TBookGenres_PK PRIMARY KEY ( intGenreID )
);

CREATE TABLE TAuthors
(
	 intAuthorID				INTEGER			NOT NULL
	,strFirstName				VARCHAR(50)		NOT NULL
	,strLastName				VARCHAR(50)		NOT NULL
	,intAuthorRankID			INTEGER			NOT NULL
	,CONSTRAINT TAuthors_PK PRIMARY KEY ( intAuthorID )
);

CREATE TABLE TAuthorRanks
(
	 intAuthorRankID			INTEGER			NOT NULL
	,strRank					VARCHAR(50)		NOT NULL
	,CONSTRAINT TAutherRanks_PK PRIMARY KEY ( intAuthorRankID )
);

-- --------------------------------------------------------------------------------
-- Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column(s)
-- -	-----							------						---------
-- 1	TBookClubs						TClubOrganizers				intClubOrganizerID
-- 2	TBookClubMembers				TBookClubs					intClubID
-- 3	TBookClubMembers				TMembers					intMemberID
-- 4	TMemberPhoneNumbers				TMemberPhoneNumberTypes		intPhoneNumberTypeID
-- 5	TMembers						TMemberPhoneNumbers			intMemberID 
-- 6	TMembers						TMemberEmails				intMemberID
-- 7	TBookClubMeetings				TBookClubs					intClubID
-- 8	TBookClubMeetings				TBooks						intBookID
-- 9	TBookClubMeetingBookAuthors		TBookClubMeetings			intClubID, intMeetingID
-- 9	TBookClubMeetingBookAuthors		TAuthors					intAuthorID
-- 10	TBooks							TBookGenre					intGenreID
-- 11	TAuthors						TAuthorRanks				intAuthorRankID

ALTER TABLE TBookClubs ADD CONSTRAINT TBookClubs_TClubOrganizers_FK
FOREIGN KEY ( intClubOrganizerID ) REFERENCES TClubOrganizers ( intClubOrganizerID )

ALTER TABLE TBookClubMembers ADD CONSTRAINT TBookClubMembers_TBookClubs_FK
FOREIGN KEY ( intClubID ) REFERENCES TBookClubs ( intClubID )

ALTER TABLE TBookClubMembers ADD CONSTRAINT TBookClubMembers_TMembers_FK
FOREIGN KEY ( intMemberID ) REFERENCES TMembers ( intMemberID ) 

ALTER TABLE TMemberPhoneNumbers ADD CONSTRAINT TMemberPhoneNumbers_TMemberPhoneNumberTypes_FK
FOREIGN KEY ( intPhoneNumberTypeID ) REFERENCES TMemberPhoneNumberTypes ( intPhoneNumberTypeID )

ALTER TABLE TMemberPhoneNumbers ADD CONSTRAINT TMemberPhoneNumbers_TMembers_FK
FOREIGN KEY ( intMemberID ) REFERENCES TMembers ( intMemberID )

ALTER TABLE TMemberEmails ADD CONSTRAINT TMemberEmails_TMembers_FK
FOREIGN KEY ( intMemberID ) REFERENCES TMembers ( intMemberID )

ALTER TABLE TBookClubMeetings ADD CONSTRAINT TBookClubMeetings_TBookClubs_FK
FOREIGN KEY ( intClubID ) REFERENCES TBookClubs ( intClubID )

ALTER TABLE TBookClubMeetings ADD CONSTRAINT TBookClubMeetings_TBooks_FK
FOREIGN KEY ( intBookID ) REFERENCES TBooks ( intBookID )

ALTER TABLE TBookClubMeetingBookAuthors ADD CONSTRAINT TBookClubMeetingBookAuthors_TBookClubMeetings_FK
FOREIGN KEY ( intClubID, intMeetingIndex ) REFERENCES TBookClubMeetings ( intClubID, intMeetingIndex )

ALTER TABLE TBookClubMeetingBookAuthors ADD CONSTRAINT TBookClubMeetingBookAuthors_TAuthors_FK
FOREIGN KEY ( intAuthorID ) REFERENCES TAuthors ( intAuthorID ) 

ALTER TABLE TBooks ADD CONSTRAINT TBooks_TBookGenres_FK
FOREIGN KEY ( intGenreID ) REFERENCES TBookGenres ( intGenreID )

ALTER TABLE TAuthors ADD CONSTRAINT TAuthors_TAuthorRanks_FK
FOREIGN KEY ( intAuthorRankID ) REFERENCES TAuthorRanks ( intAuthorRankID )



-- --------------------------------------------------------------------------------
-- Create Inserts
-- --------------------------------------------------------------------------------

INSERT INTO TClubOrganizers ( intClubOrganizerID, strFirstName, strLastName) 
VALUES		 ( 1, 'Joe', 'Smith' )
			,( 2, 'Kelly','Jones' )
			,( 3, 'Bill', 'James' )

INSERT INTO TBookClubs ( intClubID, strClubName, intClubOrganizerID ) 
VALUES		 ( 1, 'A Novel Idea', 1 )
			,( 2, 'Between the Covers', 2 )
			,( 3, 'The Bookies', 3 )

INSERT INTO TMemberPhoneNumberTypes ( intPhoneNumberTypeID, strPhoneNumberType )
VALUES		 ( 1, 'Cell' )
			,( 2, 'Home' )
			,( 3, 'Office' )

INSERT INTO TMembers ( intMemberID, strFirstName, strLastName ) 
VALUES		 ( 1, 'Ryan', 'Dennick' )
			,( 2, 'Jared', 'Dunn' )
			,( 3, 'Joe', 'Smith' )
			,( 4, 'Kelly', 'Jones' )
			,( 5, 'Bill', 'James' )
			,( 6, 'Lauren', 'Hill' )
			,( 7, 'Pete', 'Olson' )
			,( 8, 'Beth', 'Austin' )
			,( 9, 'Matt', 'Stevens' )

INSERT INTO TMemberPhoneNumbers ( intMemberID, intPhoneNumberIndex, strPhoneNumber, intPhoneNumberTypeID )
VALUES		 ( 1, 1, '123-456-7890', 1 )
			,( 1, 2, '234-567-8901', 2 )
			,( 1, 3, '345-678-9012', 3 )
			,( 2, 1, '987-654-3210', 1 )
			,( 2, 2, '876-543-2109', 2 )
			,( 3, 1, '765-432-1098', 1 )
			,( 3, 2, '654-321-0987', 2 )
			,( 4, 1, '321-098-7654', 1 )
			,( 4, 2, '124-554-6464', 2 )
			,( 4, 3, '435-545-2121', 3 )
			,( 5, 1, '222-333-4444', 1 )
			,( 5, 2, '444-555-6666', 2 )
			,( 5, 3, '666-555-4444', 3 )
			,( 6, 1, '333-343-4665', 1 )
			,( 6, 2, '092-203-2324', 2 )
			,( 7, 1, '888-443-5775', 1 )
			,( 7, 2, '999-222-2223', 2 )
			,( 8, 1, '423-665-6766', 1 )
			,( 8, 2, '555-222-6622', 2 )
			,( 9, 1, '434-211-7676', 1 )
			,( 9, 2, '444-222-7777', 2 )
			,( 9, 3, '212-574-2233', 3 )

INSERT INTO TMemberEmails ( intMemberID, intEmailIndex, strEmail ) 
VALUES		 ( 1, 1, 'rdennick@email.com' )
			,( 1, 2, 'rdennick2@email.com' )
			,( 2, 1, 'jdunn@email.com' )
			,( 2, 2, 'dunnj@email.com' )
			,( 3, 1, 'jsmith@email.com' )
			,( 4, 1, 'kjones@email.com' )
			,( 4, 2, 'jonesk12@email.com' )
			,( 5, 1, 'bjames@email.com' )
			,( 5, 2, 'jamesb21@email.com' )
			,( 6, 1, 'lhill@email.com' ) 
			,( 7, 1, 'polson@email.com' )
			,( 7, 2, 'olson.pete@email.com' )
			,( 8, 1, 'baustin@email.com' )
			,( 8, 2, 'austin12beth@email.com' )
			,( 9, 1, 'mstevens@email.com' )



INSERT INTO TBookClubMembers ( intClubID, intMemberIndex, intMemberID )
VALUES		 ( 1, 1, 1 )
			,( 1, 2, 2 )
			,( 1, 3, 3 )
			,( 1, 4, 6 )

			,( 2, 1, 4 )
			,( 2, 2, 6 )
			,( 2, 3, 7 )
			,( 2, 4, 1 )

			,( 3, 1, 5 )
			,( 3, 2, 8 )
			,( 3, 3, 9 )
			,( 3, 4, 1 ) 

INSERT INTO TAuthorRanks ( intAuthorRankID, strRank )
VALUES		 ( 1, 'Main Author' )
			,( 2, 'Co-Author' )

INSERT INTO TAuthors ( intAuthorID, strFirstName, strLastName, intAuthorRankID )
VALUES		 ( 1, ' Wes', 'Peters', 1 )
			,( 2, 'Jason', 'McIntyre', 2 )
			,( 3, 'Chirs', 'Williams', 1 )
			,( 4, 'Susan', 'Lopez', 2 )
			,( 5, 'Grace', 'Yates', 1 )
			,( 6, 'Dan', 'Gonzalez', 2 )

INSERT INTO TBookGenres  ( intGenreID, strBookGenre )
VALUES		 ( 1, 'Mystery' )
			,( 2, 'Romance' )
			,( 3, 'Action' )

INSERT INTO TBooks ( intBookID, strBookName, intGenreID)
VALUES		 ( 1, 'Unsolved Mysteries', 1 )
			,( 2, 'Lost Love', 2 )
			,( 3, 'Mission Impossible', 3 )

INSERT INTO TBookClubMeetings  ( intClubID, intMeetingIndex, dteMeetingDate, intBookID )
VALUES		 ( 1, 1, '2001/01/01', 1 )
			,( 1, 2, '2001/04/01', 1 )
			,( 1, 3, '2001/05/01', 1 )

			,( 2, 1, '2002/02/02', 2 )
			,( 2, 2, '2002/03/01', 2 )
			,( 2, 3, '2002/05/01', 2 )

			,( 3, 1, '2003/03/03', 3 )
			,( 3, 2, '2003/04/01', 3 )
			,( 3, 3, '2003/05/01', 3 )

INSERT INTO TBookClubMeetingBookAuthors ( intClubID, intMeetingIndex, intAuthorIndex, intAuthorID )
VALUES		 ( 1, 1, 1, 1 )
			,( 1, 2, 1, 1 )
			,( 1, 3, 1, 1 )

			,( 1, 1, 2, 2 )
			,( 1, 2, 2, 2 )
			,( 1, 3, 2, 2 )

			,( 2, 1, 1, 3 )
			,( 2, 2, 1, 3 )
			,( 2, 3, 1, 3 )

			,( 2, 1, 2, 4 )
			,( 2, 2, 2, 4 )
			,( 2, 3, 2, 4 )

			,( 3, 1, 1, 5 )
			,( 3, 2, 1, 5 )
			,( 3, 3, 1, 5 )

			,( 3, 1, 2, 6 )
			,( 3, 2, 2, 6 )
			,( 3, 3, 2, 6 )

-- --------------------------------------------------------------------------------
-- Create a query to list the members in each book club along with each member’s
-- email address and cell phone #
-- --------------------------------------------------------------------------------

SELECT
	 TBC.intClubID
	,TBC.strClubName
	,TM.intMemberID
	,TM.strFirstName
		+ ' ' + TM.strLastName As strFullName
	,TME.strEmail
	,TMPN.strPhoneNumber

FROM 
	 TBookClubs As TBC
		JOIN TBookClubMembers As TBCM
			JOIN TMembers As TM
				JOIN TMemberEmails As TME
				ON ( TM.intMemberID = TME.intMemberID )
				JOIN TMemberPhoneNumbers As TMPN
					JOIN TMemberPhoneNumberTypes As TMPNT
					ON (TMPN.intPhoneNumberTypeID = TMPNT.intPhoneNumberTypeID )
				ON ( TM.intMemberID = TMPN.intMemberID )
			ON ( TBCM.intMemberID = TM.intMemberID )
		ON ( TBC.intClubID = TBCM.intClubID ) 

WHERE
	TMPNT.strPhoneNumberType = 'cell'
AND TME.intEmailIndex = 1

ORDER BY
	TBC.strClubName


-- --------------------------------------------------------------------------------
-- Create a query to list the meeting dates for each book club.  Include the
-- meeting date, the book name, the main author and the book genre.
-- --------------------------------------------------------------------------------

SELECT
	 TBCM.intClubID
	,TBCMBA.intMeetingIndex
	,TBCM.dteMeetingDate
	,TB.strBookName
	,TA.strFirstName
		+ ' ' + TA.strLastName As strMainAuthorName
	,TBG.strBookGenre

FROM
	 TBookClubMeetings As TBCM
		JOIN TBookClubMeetingBookAuthors As TBCMBA
			JOIN TAuthors As TA
			ON (TBCMBA.intAuthorID = TA.intAuthorID )
			JOIN TAuthorRanks As TAR
			ON ( TA.intAuthorRankID = TAR.intAuthorRankID )
		ON ( TBCM.intClubID = TBCMBA.intClubID AND TBCM.intMeetingIndex = TBCMBA.intMeetingIndex )
		JOIN TBooks As TB
			JOIN TBookGenres As TBG
			ON ( TB.intGenreID = TBG.intGenreID )
		ON ( TBCM.intBookID = TB.intBookID )

WHERE
	 TAR.strRank = 'Main Author'

ORDER BY
	 TBCM.intClubID
	,TBCM.intMeetingIndex