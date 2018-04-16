-- --------------------------------------------------------------------------------
-- Name: Ryan Dennick
-- Class: IT-111-400
-- Abstract: Final Project
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
IF OBJECT_ID( 'VCustomerLaborCosts')	IS NOT NULL DROP VIEW  VCustomerLaborCosts
IF OBJECT_ID( 'TJobMaterials' )			IS NOT NULL DROP TABLE TJobMaterials
IF OBJECT_ID( 'TJobWorkers' )			IS NOT NULL DROP TABLE TJobWorkers
IF OBJECT_ID( 'TMaterials' )			IS NOT NULL DROP TABLE TMaterials
IF OBJECT_ID( 'TWorkerSkills' )			IS NOT NULL DROP TABLE TWorkerSkills
IF OBJECT_ID( 'TWorkers' )				IS NOT NULL DROP TABLE TWorkers
IF OBJECT_ID( 'TSkills' )				IS NOT NULL DROP TABLE TSkills
IF OBJECT_ID( 'TJobs' )					IS NOT NULL DROP TABLE TJobs
IF OBJECT_ID( 'TStatus' )				IS NOT NULL DROP TABLE TStatus
IF OBJECT_ID( 'TCustomers' )			IS NOT NULL DROP TABLE TCustomers
-- --------------------------------------------------------------------------------
-- 1.1 Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
(
	 intCustomerID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(50)		NOT NULL
	,strLastName			VARCHAR(50)		NOT NULL
	,strAddress				VARCHAR(50)		NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
);

CREATE TABLE TJobs
(
	 intJobID				INTEGER			NOT NULL
	,intCustomerID			INTEGER			NOT NULL
	,strDescription			VARCHAR(2000)	NOT NULL
	,dteStartDate			DATE			NOT NULL
	,dteEndDate				DATE			NOT NULL
	,intStatusID			INTEGER			NOT NULL
	,CONSTRAINT TJobs_PK PRIMARY KEY ( intJobID )
);

CREATE TABLE TStatus
(
	 intStatusID			INTEGER			NOT NULL
	,strStatus				VARCHAR(50)		NOT NULL
	,CONSTRAINT TStatus_PK PRIMARY KEY ( intStatusID )
);

CREATE TABLE TWorkers
(
	 intWorkerID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(50)		NOT NULL
	,strLastName			VARCHAR(50)		NOT NULL
	,dteHireDate			DATE			NOT NULL
	,CONSTRAINT TWorkers_PK PRIMARY KEY ( intWorkerID )
);

CREATE TABLE TSkills
(
	 intSkillID				INTEGER			NOT NULL
	,strSkill				VARCHAR(50)		NOT NULL
	,CONSTRAINT TSkills_PK PRIMARY KEY ( intSkillID )
);

CREATE TABLE TWorkerSkills
(
	 intWorkerID			INTEGER			NOT NULL
	,intSkillID				INTEGER			NOT NULL
	,CONSTRAINT TWorkerSkills_PK PRIMARY KEY ( intWorkerID, intSkillID )
);

CREATE TABLE TMaterials
(
	 intMaterialID			INTEGER			NOT NULL
	,strDescription			VARCHAR(2000)	NOT NULL
	,monMaterialCost		MONEY			NOT NULL
	,CONSTRAINT TMaterials_PK PRIMARY KEY ( intMaterialID )
);

CREATE TABLE TJobWorkers
(
	 intJobID				INTEGER			NOT NULL
	,intWorkerID			INTEGER			NOT NULL
	,intHoursWorked			INTEGER			NOT NULL
	,intHourlyRate			INTEGER			NOT NULL
	,CONSTRAINT TJobWorkers_PK PRIMARY KEY ( intJobID, intWorkerID )
);

CREATE TABLE TJobMaterials
(
	 intJobID				INTEGER			NOT NULL
	,intMaterialID			INTEGER			NOT NULL
	,intQuantity			INTEGER			NOT NULL
	,CONSTRAINT TJobMaterials_PK PRIMARY KEY ( intJobID, intMaterialID )
);


-- --------------------------------------------------------------------------------
-- 1.2 Create and Identify Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column(s)
-- -	-----							------						---------
-- 1	TJobs							TStatus						intStatusID
-- 2	TJobs							TCustomers					intCustomerID
-- 3	TWorkerSkills					TSkills						intSkillID
-- 4	TWorkerSkills					TWorkers					intWorkerID
-- 4	TJobMaterials					TMaterials					intMaterialID
-- 5	TJobMaterials					TJobs						intJobID
-- 6	TJobWorkers						TJobs						intJobID
-- 7	TJobWorkers						TWorkers					intWorkerID


ALTER TABLE TJobs ADD CONSTRAINT TJobs_TStatus_FK
FOREIGN KEY ( intStatusID ) REFERENCES TStatus ( intStatusID ) 

ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TSkills_FK
FOREIGN KEY ( intSkillID ) REFERENCES TSkills ( intSkillID )

ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )

ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TMaterials_FK
FOREIGN KEY ( intMaterialID ) REFERENCES TMaterials ( intMaterialID )

ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )

ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )

ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )



-- --------------------------------------------------------------------------------
-- 2.1 Insert Data
-- --------------------------------------------------------------------------------

INSERT INTO TCustomers ( intCustomerID, strFirstName, strLastName, strAddress )
VALUES		 ( 1, 'Bill', 'James', '123 Main Street' )
			,( 2, 'Sara', 'Smith', '234 South Avenue' )
			,( 3, 'Ron', 'Harold', '345 Main Street' )
			,( 4, 'Tim', 'Butler', '456 Forrest Lane' )
			,( 5, 'Holly', 'Thomas', '567 South Hamilton Court' )
			,( 6, 'Colin', 'Green', '678 Riverview Avenue' )
			,( 7, 'Adam', 'James', '789 North Drive Road' )
			,( 8, 'Tonya', 'Swanson', '912 Main Street' )

INSERT INTO TStatus ( intStatusID, strStatus )
VALUES		 ( 1, 'Open' )
			,( 2, 'In Process' )
			,( 3, 'Complete' )

INSERT INTO TSkills ( intSkillID, strSkill )
VALUES		 ( 1, 'Carpentry' ) 
			,( 2, 'Welding' )
			,( 3, 'Sodering' )
			,( 4, 'Programming' )
			,( 5, 'Project Management' )
			,( 6, 'Event Planning' )
			,( 7, 'Designer' )
			,( 8, 'Negotiation' )
			,( 9, 'Scheduling' )
			,( 10, 'Renovation' )
			,( 11, 'Demolition' )
			,( 12, 'Repairs' )
			,( 13, 'Maintenance' )

INSERT INTO TWorkers ( intWorkerID, strFirstName, strLastName, dteHireDate )
VALUES		 ( 1, 'Paul', 'Lofton', '2015/01/01' )
			,( 2, 'Holly', 'George', '2015/01/01' )
			,( 3, 'Vince', 'Marzillo', '2015/01/01' )
			,( 4, 'Kelly', 'Johnson', '2016/01/01' )
			,( 5, 'Cam', 'Banks', '2016/01/01' )
			,( 6, 'Tara', 'Allen', '2016/01/01' )
			,( 7, 'Allie', 'Phillips', '2017/01/01' )
			,( 8, 'Lance', 'Bates', '2017/01/01' )
			,( 9, 'Frank', 'Dunn', '2017/01/01' )


INSERT INTO TWorkerSkills ( intWorkerID, intSkillID )
VALUES		 ( 1, 1 )
			,( 1, 4 )
			,( 1, 13 )
			,( 2, 9 )
			,( 2, 8 )
			,( 2, 7 )
			,( 3, 4 ) 
			,( 3, 5 )
			,( 3, 6 )
			,( 4, 1 )
			,( 4, 2 )
			,( 4, 3 )
			,( 5, 10 )
			,( 5, 11 )
			,( 5, 12 )
			,( 6, 6 )
			,( 6, 13 )
			,( 6, 12 )
			,( 7, 9 )
			,( 7, 8 )
			,( 7, 12 )
			,( 8, 4 )
			,( 8, 7 )
			,( 8, 1 )
			,( 9, 10 )
			,( 9, 11 )
			,( 9, 12 )

INSERT INTO TMaterials ( intMaterialID, strDescription, monMaterialCost )
VALUES		 ( 1, 'PlyWood', 5.00 )
			,( 2, 'Piping', 2.50 )
			,( 3, 'Nails',	1.00 )
			,( 4, 'Cement', 10.00 )
			,( 5, 'Drill', 50.00 )
			,( 6, 'Hammer', 15.00 )
			,( 7, 'Saw', 25.00 )
			,( 8, 'Glass', 8.00 )
			,( 9, 'Plastic', 4.00 )
			,( 10, 'Sod', 9.00 )
			,( 11, 'Soil', 3.00 )
			,( 12 ,'Drywall', 8.00 )
			,( 13, 'Water', 2.00 )

INSERT INTO TJobs ( intJobID, intCustomerID, strDescription, dteStartDate, dteEndDate, intStatusID )
VALUES		 ( 1, 1, 'Redo Plumming in apartment building', '2015/05/05', '2015/06/05', 3 )
			,( 2, 2, 'Put up drywall', '2017/12/08', '', 2 )
			,( 3, 3, 'Landscaping for local business', '2016/03/03', '2016/03/30', 3 )
			,( 4, 4, 'New windows in house', '2017/08/07', '', 1 ) 
			,( 5, 5, 'Cementing new driveway', '2017/09/09', '', 1 )
			,( 6, 6, 'Building backyard deck', '2017/11/11', '', 2 )
			,( 7, 7, 'Renovating bathroom', '2017/12/01', '', 2 )
			,( 8, 8, 'Resodding front yard', '2016/08/10', '', 2 )
			,( 9, 3, 'Installing new drywall', '2017/01/05', '2017/01/25', 3 )
			,( 10, 3, 'Cementing new sidewalk', '2017/05/10', '2017/05/25', 3 )
			,( 11, 3, 'Installing new windows in living room', '2017/12/15', '', 1 )
			,( 12, 3, 'New sod and soil at local park', '2017/04/01', '', 2 )
			,( 13, 1, 'Remodeling office space', '2017/12/20', '', 1 )


INSERT INTO TJobWorkers ( intJobID, intWorkerID, intHourlyRate, intHoursWorked )
VALUES		 ( 1, 5, 15, 10 )
			,( 1, 9, 12, 10 )
			,( 2, 1, 20, 6 )
			,( 2, 4, 24, 4 )
			,( 3, 6, 10, 10 )
			,( 3, 5, 16, 2 )
			,( 4, 8, 25, 6 )
			,( 4, 9, 22, 8 )
			,( 5, 2, 18, 7 )
			,( 5, 3, 30, 5 )
			,( 6, 7, 11, 6 )
			,( 6, 1, 16, 5 )
			,( 7, 8, 12, 13 )
			,( 7, 2, 19, 14 )
			,( 8, 4, 20, 5 )
			,( 8, 5, 20, 7 )
			,( 9, 1, 22, 12 )
			,( 9, 6, 25, 3 )
			,( 10, 2, 38, 9 )
			,( 10, 7, 30, 5 )
			,( 11, 4, 8, 8 )
			,( 11, 8, 12, 10 )
			,( 12, 9, 18, 8 )
			,( 13, 8, 0, 0 )

INSERT INTO TJobMaterials ( intJobID, intMaterialID, intQuantity )
VALUES		 ( 1, 2, 20 )
			,( 1, 3, 100 )
			,( 1, 12, 4 )
			,( 2, 12, 20 )
			,( 2, 6, 4 )
			,( 2, 3, 100 )
			,( 3, 10, 15 )
			,( 3, 11, 5 )
			,( 4, 8, 10 )
			,( 4, 9, 10 )
			,( 5, 4, 10 )
			,( 5, 13, 10 )
			,( 5, 1, 10 )
			,( 6, 1, 15 )
			,( 6, 6, 2 )
			,( 6, 3, 100 )
			,( 6, 4, 10 )
			,( 7, 1, 5 )
			,( 7, 2, 10 )
			,( 7, 4, 10 )
			,( 8, 10, 13 )
			,( 8, 11, 13 )
			,( 8, 13, 13 )
			,( 9, 12, 10 )
			,( 9, 3, 100 )
			,( 10, 4, 10 )
			,( 10, 13, 10 )
			,( 11, 8, 5 )
			,( 11, 9, 5 )
			,( 12, 10, 8 )
			,( 12, 11, 8 )
			,( 12, 13, 8 )
			,( 13, 12, 7 )
			,( 13, 1, 5 )


-- --------------------------------------------------------------------------------
-- 3.1 Update and Delete: Create SQL to update the address for a specific customer
-- --------------------------------------------------------------------------------

SELECT
	 intCustomerID
	,strFirstName
		+ ' ' + strLastName As strFullName
	,strAddress

FROM
	TCustomers

WHERE
	intCustomerID = 2


UPDATE 
	TCustomers

SET
	strAddress = '789 NewPlace Drive'

WHERE
	intCustomerID = 2


SELECT
	 intCustomerID
	,strFirstName
		+ ' ' + strLastName As strFullName
	,strAddress

FROM
	TCustomers

WHERE
	intCustomerID = 2
	

-- --------------------------------------------------------------------------------
-- 3.2 Update and Delete: Create SQL to increase hourly rate by $2 for each worker
-- that has been an employee for at least 1 year.  
-- --------------------------------------------------------------------------------

SELECT
	 TW.intWorkerID
	,TW.strFirstName
		+ ' ' + strLastName As FullName
	,TJW.intHourlyRate
	
FROM
	 TWorkers As TW
	,TJobWorkers AS TJW
	
WHERE
	 TW.intWorkerID = TJW.intWorkerID

ORDER BY
	 TW.dteHireDate


UPDATE
	  TJobWorkers 

SET
	 intHourlyRate = intHourlyRate + 2

FROM
	 TWorkers As TW
		JOIN TJobWorkers As TJW
		ON ( TW.intWorkerID = TJW.intWorkerID )

WHERE
	 TW.dteHireDate < DATEADD(YEAR, -1, GETDATE()) 
	

SELECT
	 TW.intWorkerID
	,TW.strFirstName
		+ ' ' + strLastName As FullName
	,TJW.intHourlyRate
	
FROM
	 TWorkers As TW
	,TJobWorkers AS TJW
	
WHERE
	 TW.intWorkerID = TJW.intWorkerID

ORDER BY
	 TW.dteHireDate


-- --------------------------------------------------------------------------------
-- 3.3 Update and Delete: Create SQL to delete a specific job that has associated
-- work hours and materials assigned to it
-- --------------------------------------------------------------------------------

SELECT 
	 TJ.intJobID
	,TJ.intCustomerID
	,TJ.strDescription
	,TJW.intWorkerID
	,TW.strFirstName
		+ ' ' + TW.strLastName As strWorkerName
	,TJW.intHoursWorked
	,TM.intMaterialID
	,TM.strDescription

FROM
	 TJobs As TJ
	,TWorkers As TW
	,TJobWorkers As TJW
	,TJobMaterials As TJM
	,TMaterials As TM

WHERE
	 TJ.intJobID = TJW.intJobID
AND  TJ.intJobID = TJM.intJobID
AND	 TM.intMaterialID = TJM.intMaterialID
AND  TW.intWorkerID = TJW.intWorkerID

ORDER BY
	 TJ.intJobID


DELETE FROM
	 TJobMaterials

WHERE
	 intJobID = 1

DELETE FROM
	 TJobWorkers

WHERE
	 intJobID = 1

DELETE FROM
	 TJobs

WHERE 
	 intJobID = 1

SELECT 
	 TJ.intJobID
	,TJ.intCustomerID
	,TJ.strDescription
	,TJW.intWorkerID
	,TW.strFirstName
		+ ' ' + TW.strLastName As strWorkerName
	,TJW.intHoursWorked
	,TM.intMaterialID
	,TM.strDescription

FROM
	 TJobs As TJ
	,TWorkers As TW
	,TJobWorkers As TJW
	,TJobMaterials As TJM
	,TMaterials As TM

WHERE
	 TJ.intJobID = TJW.intJobID
AND  TJ.intJobID = TJM.intJobID
AND	 TM.intMaterialID = TJM.intMaterialID
AND  TW.intWorkerID = TJW.intWorkerID

ORDER BY
	 TJ.intJobID

-- --------------------------------------------------------------------------------
-- 4.1 Queries: List all jobs that are in process. Include the Job ID and description
-- , Customer ID and name, and the start date. order by the Job ID 
-- --------------------------------------------------------------------------------

SELECT
	 TJ.intJobID
	,TJ.strDescription
	,TJ.intCustomerID
	,TC.strFirstName
		+ ' '  + TC.strLastName As strCustomerName
	,TJ.dteStartDate
	,TSt.strStatus

FROM
	 TJobs As TJ
	,TCustomers As TC
	,TStatus As TSt

WHERE
	 TJ.intCustomerID = TC.intCustomerID
AND	 TJ.intStatusID = TSt.intStatusID
AND  TSt.strStatus = 'In Process'

ORDER BY
	 TJ.intJobID

-- --------------------------------------------------------------------------------
-- 4.2 Queries: List all complete jobs for a specific customer and the materials 
-- used on each job.  Include the quantity, unit cost, and total cost for each 
-- material on each job.  Order by Job ID and Material ID
-- --------------------------------------------------------------------------------

SELECT
	 TJ.intJobID
	,TC.intCustomerID
	,TC.strFirstName
		+ ' ' + TC.strLastName AS strCustomerName
	,TM.strDescription
	,TJM.intQuantity
	,TM.monMaterialCost
	,SUM(TM.monMaterialCost * TJM.intQuantity ) As intTotalCostPerItem
	
FROM
	 TJobs As TJ
	,TJobMaterials As TJM
	,TMaterials As TM
	,TCustomers As TC
	,TStatus  As TSt

WHERE
	 TJ.intJobID = TJM.intJobID
AND  TM.intMaterialID = TJM.intMaterialID
AND  TSt.intStatusID = TJ.intStatusID
AND  TC.intCustomerID = 3
AND  TSt.strStatus = 'Complete'

GROUP BY
	  TJ.intJobID
	 ,TC.intCustomerID
	 ,TC.strFirstName
	 ,TC.strLastName
	 ,TM.intMaterialID
	 ,TM.strDescription
	 ,TJM.intQuantity
	 ,TM.monMaterialCost

ORDER BY
	 TJ.intJobID
	,TM.intMaterialID
	
-- --------------------------------------------------------------------------------
-- 4.3 Queries: Write the query to list the total cost for all materials for
-- each completed job for the customer.  
-- --------------------------------------------------------------------------------

SELECT
	 TJ.intJobID
	,TC.intCustomerID
	,TC.strFirstName
		+ ' ' + TC.strLastName As strCustomer
	,SUM(TM.monMaterialCost * TJM.intQuantity ) As intTotalCost

FROM
	 TJobs As TJ
	,TCustomers As TC
	,TMaterials As TM
	,TJobMaterials As TJM
	,TStatus As TSt

WHERE
	 TJ.intJobID = TJM.intJobID
AND  TM.intMaterialID = TJM.intMaterialID
AND  TJ.intCustomerID = TC.intCustomerID
AND  TJ.intStatusID = TSt.intStatusID
AND  TC.intCustomerID = 3
AND  TSt.strStatus = 'Complete'

GROUP BY
	 TJ.intJobID
	,TC.intCustomerID
	,TC.strFirstName
	,TC.strLastName
	
ORDER BY
	 TJ.intJobID


-- --------------------------------------------------------------------------------
-- 4.4 Queries: Write a query to list all jobs that have work entered for them. 
-- Include the job ID, job description and job status description.  List the total
-- hours worked for each job with the lowest, highest and average hourly rate.  The
-- average hourly rate should be weighted based on the number of hours worked at
-- that rate.  Make sure that your data includes at least one job that does not 
-- have hours logged.  This job should not be included in the query.  Order by
-- highest to lowest average hourly rate.  
-- --------------------------------------------------------------------------------

SELECT
	 TJ.intJobID
	,TJ.strDescription
	,TSt.strStatus
	,SUM(TJW.intHoursWorked) As intTotalHoursWorked
	,MIN(TJW.intHourlyRate) As intMinHourlyRate
	,MAX(TJW.intHourlyRate) As IntMaxHourlyRate
	,(SUM(TJW.intHourlyRate * TJW.intHoursWorked) / SUM(TJW.intHoursWorked))  As intAvgHourlyRate

FROM
	 TJobs As TJ
	,TJobWorkers As TJW
	,TStatus As TSt

WHERE
	 TJ.intJobID = TJW.intJobID
AND  TJ.intStatusID = TSt.intStatusID
AND  TJW.intHoursWorked > 0

GROUP BY
	 TJ.intJobID
	,TJ.strDescription
	,TSt.strStatus

ORDER BY
	 intAvgHourlyRate DESC


-- --------------------------------------------------------------------------------
-- 4.5 Queries: Write a query that lists all materials that have not been used on
-- any jobs.  Include Material ID and description.  Order by Material ID
-- --------------------------------------------------------------------------------

SELECT
	 TM.intMaterialID
	,TM.strDescription

FROM
	TMaterials As TM

WHERE
	 NOT EXISTS (
					SELECT
						 *
					FROM
						 TJobMaterials As TJM
					WHERE
						 TJM.intMaterialID = TM.intMaterialID
				)

ORDER BY
	 TM.intMaterialID


-- --------------------------------------------------------------------------------
-- 4.6 Queries: Create a query that lists all workers with a specific skill, their
-- hire date and the total number of jobs that the worked on.  List the Skill ID
-- and description with each row.  order by Worker ID
-- --------------------------------------------------------------------------------

SELECT
	 TW.intWorkerID
	,TW.strFirstName
		+ ' ' + TW.strLastName As strWorkers
	,TW.dteHireDate
	,COUNT(TJW.intHourlyRate) As intNumberOfJobsWorked
	,TSk.intSkillID
	,TSk.strSkill


FROM 
	 TWorkers As TW
	,TSkills As TSk
	,TJobWorkers As TJW
	,TWorkerSkills As TWS

WHERE
	 TW.intWorkerID = TJW.intWorkerID
AND	 TW.intWorkerID = TWS.intWorkerID
AND	 TSk.intSkillID = TWS.intSkillID
AND  TSk.strSkill = 'Programming'

GROUP BY
	 TW.intWorkerID
	,TW.strFirstName
	,TW.strLastName
	,TW.dteHireDate
	,TSk.intSkillID
	,TSk.strSkill

ORDER BY
	 TW.intWorkerID


-- --------------------------------------------------------------------------------
-- 4.7 Queries: Create a query that lists all workers that worked greater than 20
-- hours for all jobs that they worked on.  Include the Worker ID and name, number
-- of hours worked and number of jobs that they worked on.  Order by Worker ID
-- --------------------------------------------------------------------------------

SELECT
	 TW.intWorkerID
	,TW.strFirstName
		+ ' ' + TW.strLastName As strWorkerName
	,SUM(TJW.intHoursWorked) As intTotalHoursWorked
	,COUNT(TJW.intHourlyRate) As intTotalNumberOfJobs


FROM
	 TWorkers As TW
	,TJobWorkers As TJW

WHERE
	 TW.intWorkerID = TJW.intWorkerID

GROUP BY
	 TW.intWorkerID
	,TW.strFirstName
	,TW.strLastName

HAVING 
	 SUM(TJW.intHoursWorked) > 20

ORDER BY
	 TW.intWorkerID


-- --------------------------------------------------------------------------------
-- 4.8 Queries: Create a view that includes the labor costs associated with each
-- job.  Include Customer ID and name
-- --------------------------------------------------------------------------------

GO

CREATE VIEW VCustomerLaborCosts

AS

SELECT
	 TC.intCustomerID
	,TC.strFirstName
		+ ' ' + TC.strLastName As strCustomerName
	,TJ.intJobID
	,TJ.strDescription
	,SUM(TJW.intHourlyRate * TJW.intHoursWorked ) As intLaborCost

FROM
	 TCustomers As TC
	,TJobs As TJ
	,TJobWorkers As TJW

WHERE
	 TC.intCustomerID = TJ.intCustomerID
AND  TJ.intJobID = TJW.intJobID

GROUP BY
	 TC.intCustomerID
	,TC.strFirstName
	,TC.strLastName
	,TJ.intJobID
	,TJ.strDescription

GO

SELECT
	 *
FROM
	 VCustomerLaborCosts

ORDER BY
	 intCustomerID

-- --------------------------------------------------------------------------------
-- 4.9 Queries: Use the view from 4.8 to create a query that includes the total
-- labor cost for each customer
-- --------------------------------------------------------------------------------

SELECT 
	 intCustomerID
	,strCustomerName
	,SUM(intLaborCost) As intTotalLaborCost

FROM
	 VCustomerLaborCosts

GROUP BY
	 intCustomerID
    ,strCustomerName

ORDER BY
	 intCustomerID


-- --------------------------------------------------------------------------------
-- 4.10 Queries: Write the query that lists all customers who are located on 'Main
-- Street'. Include the Customer ID and full address.  Order by Customer ID. Make
-- sure you have at least three customers on 'Main Street' each with different house
-- numbers.  Make sure that you also have customers that are not on 'Main Steet'
-- --------------------------------------------------------------------------------

SELECT
	 TC.intCustomerID
	,TC.strFirstName
		+ ' ' + TC.strLastName as strCustomerName
	,TC.strAddress

FROM
	 TCustomers As TC

WHERE
	 TC.strAddress LIKE '%Main Street%'

ORDER BY
	 TC.intCustomerID

