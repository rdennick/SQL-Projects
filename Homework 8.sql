-- --------------------------------------------------------------------------------
-- Name: Ryan Dennick
-- Class: IT-111-400
-- Abstract: Homework 8 - 3NF Practice
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
 DROP TABLE TPatientVisitLabTestResults
 DROP TABLE TPatientVisitLabTests
 DROP TABLE TPatientVisitMedications
 DROP TABLE TPatientVisitProcedures
 DROP TABLE TLabTests
 DROP TABLE TMedications
 DROP TABLE TProcedures
 DROP TABLE TPatientVisits
 DROP TABLE TPatients


-- --------------------------------------------------------------------------------
-- Step 2.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TPatients
(
	 intPatientID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(50)		NOT NULL
	,strLastName			VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatients_PK PRIMARY KEY ( intPatientID )
);

CREATE TABLE TPatientVisits
(
	 intPatientID			INTEGER			NOT NULL
	,intVisitIndex			INTEGER			NOT NULL
	,dtmVisitDate			DATETIME		NOT NULL
	,strVisitNotes			VARCHAR(8000)	NOT NULL
	,CONSTRAINT TPatientVisits_PK PRIMARY KEY ( intPatientID, intVisitIndex )
);

CREATE TABLE TPatientVisitProcedures
(
	 intPatientID			INTEGER			NOT NULL
	,intVisitIndex			INTEGER			NOT NULL
	,intProcedureIndex		INTEGER			NOT NULL
	,intProcedureID			INTEGER			NOT NULL
	,strProcedureNotes		VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisitProcedures_PK PRIMARY KEY ( intPatientID, intVisitIndex, intProcedureIndex )
);

CREATE TABLE TPatientVisitMedications
(
	 intPatientID			INTEGER			NOT NULL
	,intVisitIndex			INTEGER			NOT NULL
	,intMedicationID		INTEGER			NOT NULL
	,strDosage				VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisitMedications_PK PRIMARY KEY ( intPatientID, intVisitIndex, intMedicationID )
);

CREATE TABLE TPatientVisitLabTests
(
	 intPatientID			INTEGER			NOT NULL
	,intVisitIndex			INTEGER			NOT NULL
	,intLabTestIndex		INTEGER			NOT NULL
	,intLabTestID			INTEGER 		NOT NULL
	,CONSTRAINT TPatientVisitLabTests_PK PRIMARY KEY ( intPatientID, intVisitIndex, intLabTestIndex )
);

CREATE TABLE TPatientVisitLabTestResults
(
	 intPatientID			INTEGER			NOT NULL
	,intVisitIndex			INTEGER			NOT NULL
	,intLabTestIndex		INTEGER			NOT NULL
	,intResultIndex			INTEGER			NOT NULL
	,strResult				VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisitLabTestResults_PK PRIMARY KEY ( intPatientID, intVisitIndex, intLabTestIndex, intResultIndex )
);

CREATE TABLE TProcedures
(
	 intProcedureID			INTEGER			NOT NULL
	,strProcedure			VARCHAR(50)		NOT NULL
	,strBillingCode			VARCHAR(50)		NOT NULL
	,CONSTRAINT TProcedures_PK PRIMARY KEY ( intProcedureID )
);

CREATE TABLE TMedications
(
	 intMedicationID		INTEGER			NOT NULL
	,strMedication			VARCHAR(50)		NOT NULL
	,strBillingCode			VARCHAR(50)		NOT NULL
	,CONSTRAINT TMedications_PK PRIMARY KEY ( intMedicationID )
);

CREATE TABLE TLabTests
(
	 intLabTestID			INTEGER			NOT NULL
	,strName				VARCHAR(50)		NOT NULL
	,strBillingCode			VARCHAR(50)		NOT NULL
	,CONSTRAINT TLabTests_PK PRIMARY KEY ( intLabTestID )
);


-- --------------------------------------------------------------------------------
-- Step 2.3: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column(s)
-- -	-----							------						---------
-- 1	TPatientVisits					TPatients					intPatientID
-- 2	TPatientVisitProcedures			TPatientVisits				intPatientID, intVisitIndex
-- 3	TPatientVIsitProcedures			TProcedures					intProcedureID
-- 4	TPatientVisitMedications		TPatientVisits				intPatientID, intVisitIndex
-- 5	TPatientVisitMedications		TMedications				intMedicationID
-- 6	TPatientVisitLabTests			TPatientVisits				intPatientID, intVisitIndex
-- 7	TPatientVisitLabTests			TLabTests					intLabTestID
-- 8	TPatientVisitLabTestResults		TPatientVisitLabTests		intPatientID, intVisitIndex, intLabTestIndex



ALTER TABLE TPatientVisits ADD CONSTRAINT TPatientVisits_TPatients_FK
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )

ALTER TABLE TPatientVisitProcedures ADD CONSTRAINT TPatientVisitProcedures_TPatientVisits_FK
FOREIGN KEY ( intPatientID, intVisitIndex ) REFERENCES TPatientVisits ( intPatientID, intVisitIndex )

ALTER TABLE TPatientVisitProcedures ADD CONSTRAINT TPatientVisitProcedures_TProcedures_FK
FOREIGN KEY ( intProcedureID ) REFERENCES TProcedures ( intProcedureID )

ALTER TABLE TPatientVisitMedications ADD CONSTRAINT TPatientVisitMedications_TPatientVisits_FK
FOREIGN KEY ( intPatientID, intVisitIndex ) REFERENCES TPatientVisits ( intPatientID, intVisitIndex )

ALTER TABLE TPatientVisitMedications ADD CONSTRAINT TPatientVisitMedications_TMedications_FK
FOREIGN KEY ( intMedicationID ) REFERENCES TMedications ( intMedicationID )

ALTER TABLE TPatientVisitLabTests ADD CONSTRAINT TPatientVisitLabTests_TPatientVisits_FK
FOREIGN KEY ( intPatientID, intVisitIndex ) REFERENCES TPatientVisits ( intPatientID, intVisitIndex )

ALTER TABLE TPatientVisitLabTests ADD CONSTRAINT TPatientVisitLabTests_TLabTests_FK
FOREIGN KEY ( intLabTestID ) REFERENCES TLabTests ( intLabTestID )

ALTER TABLE TPatientVisitLabTestResults ADD CONSTRAINT TPatientVisitLabTestResults_TPatientVisitLabTests_FK
FOREIGN KEY ( intPatientID, intVisitIndex, intLabTestIndex ) REFERENCES TPatientVisitLabTests ( intPatientID, intVisitIndex, intLabTestIndex )


-- --------------------------------------------------------------------------------
-- Step 2.4: Add two patients
-- --------------------------------------------------------------------------------

INSERT INTO TPatients ( intPatientID, strFirstName, strLastName )
VALUES		 ( 1, 'Ryan', 'Dennick' )
			,( 2, 'John', 'Anderson' )

-- --------------------------------------------------------------------------------
-- Step 2.5: Add at least two visits for each patient
-- --------------------------------------------------------------------------------

INSERT INTO TPatientVisits ( intPatientID, intVisitIndex, dtmVisitDate, strVisitNotes )
VALUES		 ( 1, 1, '01/01/2001', 'Patient came in with symptoms of the flu' )
			,( 1, 2, '02/02/2002', 'Patient came in with a broken arm' )

			,( 2, 1, '03/03/2003', 'Patient came in for a check-up' )
			,( 2, 2, '04/04/2004', 'Patient came in with a sprained ankle' )

-- --------------------------------------------------------------------------------
-- Step 2.6: Add at least two procedures for each patient visit
-- --------------------------------------------------------------------------------

INSERT INTO TProcedures ( intProcedureID, strProcedure, strBillingCode )
VALUES		 ( 1, 'Take temperature', '1234' )
			,( 2, 'Check lymph nodes', '2345' )
			,( 3, 'Test reflexes', '3456' )
			,( 4, 'Create cast', '6789' )
			,( 5, 'Wrap sprained ankle', '7890' )
			,( 6, 'Take X-ray', '8901')

INSERT INTO TPatientVisitProcedures ( intPatientID, intVisitIndex, intProcedureIndex, intProcedureID, strProcedureNotes )
VALUES		 ( 1, 1, 1,	1, 'Took patients temperature' )
			,( 1, 1, 2, 2, 'Checked lymph nodes' )
			,( 1, 2, 1, 6, 'Took an X-ray' )
			,( 1, 2, 2, 4, 'Created a cast' )

			,( 2, 1, 1, 3, 'Took patients temperature' )
			,( 2, 1, 2, 2, 'Tested reflexes' )
			,( 2, 2, 1, 6, 'Took an X-ray' )
			,( 2, 2, 2, 3, 'Wrapped patients ankle' )

-- --------------------------------------------------------------------------------
-- Step 2.7: Add at least two medications for each patient visit
-- --------------------------------------------------------------------------------

INSERT INTO TMedications ( intMedicationID, strMedication, strBillingCode )
VALUES		 ( 1, 'Advil', '0987' )
			,( 2, 'Pain Reliever', '9876' )
			,( 3, 'Tylenol', '8765' )
			,( 4, 'Muscle Relaxer', '7654' )
			,( 5, 'No medication required', '6543')
			,( 6, 'Lollypop', '5432' )

INSERT INTO TPatientVisitMedications ( intPatientID, intVisitIndex, intMedicationID, strDosage )
VALUES		 ( 1, 1, 1, '200 mg' )
			,( 1, 1, 2, '300 mg' )
			,( 1, 2, 3, '200 mg' )
			,( 1, 2, 4, '300 mg' )

			,( 2, 1, 5, 'No dosage' )
			,( 2, 1, 6, 'One' )
			,( 2, 2, 2, '300 mg' )
			,( 2, 2, 4, '400 mg' ) 

-- --------------------------------------------------------------------------------
-- Step 2.8: Add at least two lab tests for each patient visit
-- --------------------------------------------------------------------------------

INSERT INTO TLabTests ( intLabTestID, strName, strBillingCode )
VALUES		 ( 1, 'Flu Test', 'T123' )
			,( 2, 'Mono', 'T234' )
			,( 3, 'Electrolytes', 'T345' )
			,( 4, 'Glucose', 'T456' )
			,( 5, 'Lyme Disease', 'T567' )
			,( 6, 'X-Ray', 'T678' )
			,( 7, 'MRI', 'T789' )

INSERT INTO TPatientVisitLabTests ( intPatientID, intVisitIndex, intLabTestIndex, intLabTestID )
VALUES		 ( 1, 1, 1, 3 )
			,( 1, 1, 2, 3 )
			,( 1, 2, 1, 6 )
			,( 1, 2, 2, 7 )

			,( 2, 1, 1, 5 )
			,( 2, 1, 2, 2 )
			,( 2, 2, 1, 6 )
			,( 2, 2, 2, 7 )

INSERT INTO TPatientVisitLabTestResults ( intPatientID, intVisitIndex, intLabTestIndex, intResultIndex, strResult )
VALUES		 ( 1, 1, 1, 3, 'Positive' )
			,( 1, 1, 2, 3, 'Negative' )
			,( 1, 2, 1, 2, 'Positive' )
			,( 1, 2, 2, 1, 'Negative' )

			,( 2, 1, 1, 1, 'Positive' )
			,( 2, 1, 2, 3, 'Negative' ) 
			,( 2, 2, 1, 2, 'Positive' )
			,( 2, 2, 2, 3, 'Negative' )


-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
DROP TABLE TInsurancePolicyClaimPayments
DROP TABLE TInsurancePolicyClaims
DROP TABLE TInsurancePolicies
DROP TABLE TPaymentRecipients
DROP TABLE TPolicyTypes
DROP TABLE TStatuses
DROP TABLE TClients
DROP TABLE TAgents


-- --------------------------------------------------------------------------------
-- Step 3.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TAgents
(
	 intAgentID					INTEGER			NOT NULL
	,strFirstName				VARCHAR(50)		NOT NULL
	,strLastName				VARCHAR(50)		NOT NULL
	,strPhone					VARCHAR(50)		NOT NULL
	,strAddress					VARCHAR(50)		NOT NULL
	,CONSTRAINT TAgents_PK PRIMARY KEY ( intAgentID )
);

CREATE TABLE TClients
(
	 intClientID				INTEGER			NOT NULL
	,strFirstName				VARCHAR(50)		NOT NULL
	,strLastName				VARCHAR(50)		NOT NULL
	,strPhone					VARCHAR(50)		NOT NULL
	,strAddress					VARCHAR(50)		NOT NULL
	,CONSTRAINT TClient_PK PRIMARY KEY ( intClientID )
);

CREATE TABLE TStatuses
(
	 intStatusID				INTEGER			NOT NULL
	,strStatus					VARCHAR(50)		NOT NULL
	,CONSTRAINT TStatuses_PK PRIMARY KEY ( intStatusID )
);

CREATE TABLE TPolicyTypes
(
	 intPolicyTypeID			INTEGER			NOT NULL
	,strType					VARCHAR(50)		NOT NULL
	,CONSTRAINT TPolicyTypes_PK PRIMARY KEY ( intPolicyTypeID )
);

CREATE TABLE TInsurancePolicies
(
	 intInsurancePolicyID		INTEGER			NOT NULL
	,strInsurancePolicyNumber	VARCHAR(50)		NOT NULL
	,intPolicyTypeID			INTEGER			NOT NULL
	,dtmStartDate				DATETIME		NOT NULL
	,monAnnualPayment			MONEY			NOT NULL
	,intStatusID				INTEGER			NOT NULL
	,intAgentID					INTEGER			NOT NULL
	,intClientID				INTEGER			NOT NULL
	,CONSTRAINT TInsurancePolicies_PK PRIMARY KEY ( intInsurancePolicyID )
);

CREATE TABLE TInsurancePolicyClaims
(
	 intInsurancePolicyID		INTEGER			NOT NULL
	,intClaimIndex				INTEGER			NOT NULL
	,strClaimDate				VARCHAR(50)		NOT NULL
	,strClaimDescription		VARCHAR(50)		NOT NULL
	,CONSTRAINT TInsuancePolicyClaims_PK PRIMARY KEY ( intInsurancePolicyID, intClaimIndex )
);


CREATE TABLE TInsurancePolicyClaimPayments
(
	 intInsurancePolicyID		INTEGER			NOT NULL
	,intClaimIndex				INTEGER			NOT NULL
	,intPaymentIndex			INTEGER			NOT NULL
	,strDate					VARCHAR(50)		NOT NULL
	,intPaymentRecipientID		INTEGER			NOT NULL
	,monAmount					MONEY			NOT NULL
	,CONSTRAINT TInsuancePolicyClaimPayments_PK PRIMARY KEY ( intInsurancePolicyID, intClaimIndex, intPaymentIndex )
);

CREATE TABLE TPaymentRecipients
(
	 intPaymentRecipientID		INTEGER			NOT NULL
	,strFirstName				VARCHAR(50)		NOT NULL
	,strLastName				VARCHAR(50)		NOT NULL
	,strPhone					VARCHAR(50)		NOT NULL
	,strAddress					VARCHAR(50)		NOT NULL
	,CONSTRAINT TPaymentRecipients_PK PRIMARY KEY ( intPaymentRecipientID )
);

-- --------------------------------------------------------------------------------
-- Step 3.3: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child								Parent						Column(s)
-- -	-----								------						---------
-- 1	TInsurancePolicies					TPolicyTypes				intPolicyTypeID
-- 2	TInsurancePolicies					TStatuses					intStatusID
-- 3	TInsurancePolicies					TAgents						intAgentID
-- 4	TInsurancePolicies					TClients					intClientID
-- 5	TInsurancePolicyClaims				TInsurancePolicies			intInsurancePolicyID
-- 6	TInsurancePolicyClaimPayments		TInsurancePolicyClaims		intInsurancePolicyID, intClaimIndex
-- 7	TInsurancePolicyClaimPayments		TPaymentRecipients			intPaymentRecipientID

ALTER TABLE TInsurancePolicies ADD CONSTRAINT TInsurancePolicies_TPolicyTypes_FK
FOREIGN KEY ( intPolicyTypeID ) REFERENCES TPolicyTypes ( intPolicyTypeID )

ALTER TABLE TInsurancePolicies ADD CONSTRAINT TInsurancePolicies_TStatuses_FK
FOREIGN KEY ( intStatusID ) REFERENCES TStatuses ( intStatusID )

ALTER TABLE TInsurancePolicies ADD CONSTRAINT TInsurancePolicies_TAgents_FK
FOREIGN KEY ( intAgentID ) REFERENCES TAgents ( intAgentID )

ALTER TABLE TInsurancePolicies ADD CONSTRAINT TInsurancePolicies_TClients_FK
FOREIGN KEY ( intClientID ) REFERENCES TClients ( intClientID )

ALTER TABLE TInsurancePolicyClaims ADD CONSTRAINT TInsurancePolicyClaims_TInsurancePolicies_FK
FOREIGN KEY ( intInsurancePolicyID ) REFERENCES TInsurancePolicies ( intInsurancePolicyID )

ALTER TABLE TInsurancePolicyClaimPayments ADD CONSTRAINT TInsurancePolicyClaimPayments_TInsurancePolicyClaims_FK
FOREIGN KEY ( intInsurancePolicyID, intClaimIndex ) REFERENCES TInsurancePolicyClaims ( intInsurancePolicyID, intClaimIndex )

ALTER TABLE TInsurancePolicyClaimPayments ADD CONSTRAINT TInsurancePolicyClaimPayments_TPaymentRecipients_FK
FOREIGN KEY ( intPaymentRecipientID ) REFERENCES TPaymentRecipients ( intPaymentRecipientID )


-- --------------------------------------------------------------------------------
-- Step 3.4: Add two insurance policies
-- --------------------------------------------------------------------------------

INSERT INTO TAgents ( intAgentID, strFirstName, strLastName, strPhone, strAddress )
VALUES		 ( 1, 'Hank', 'Jones', '123-456-7890', '123 Main Street' )
			,( 2, 'Jen', 'Thompson', '234-567-8901', '234 Second Street' )
			,( 3, 'Terry', 'Doyle', '345-678-9012', '345 North Lane' )
			,( 4, 'Rhonda', 'Smith', '456-789-0123', '456 Hope Drive' )

INSERT INTO TClients ( intClientID, strFirstName, strLastName, strPhone, strAddress )
VALUES		 ( 1, 'Ryan', 'Dennick', '987-654-3210', '123 Last Ave' )
			,( 2, 'Chirs', 'Johnson', '876-543-2109', '987 Third Steet' )

INSERT INTO TStatuses ( intStatusID, strStatus )
VALUES		 ( 1, 'Due' )
			,( 2, 'Late' )
			,( 3, 'Paid' )

INSERT INTO TPolicyTypes ( intPolicyTypeID, strType )
VALUES		 ( 1, 'Home' )
			,( 2, 'Auto' )
			,( 3, 'Life' )
		
INSERT INTO TInsurancePolicies ( intInsurancePolicyID, strInsurancePolicyNumber, intPolicyTypeID, dtmStartDate, monAnnualPayment, intStatusID, intAgentID, intClientID )
VALUES		 ( 1, '1', 2, '01/01/2001', 800, 3, 1, 1 )
			,( 2, '2', 1, '02/02/2002', 1500, 1, 2, 2)

-- --------------------------------------------------------------------------------
-- Step 3.5: Add two claims for each policy
-- --------------------------------------------------------------------------------

INSERT INTO TInsurancePolicyClaims ( intInsurancePolicyID, intClaimIndex, strClaimDate, strClaimDescription )
VALUES		 ( 1, 1, '03/03/2003', 'Fender bender' )
			,( 1, 2, '04/04/2004', 'Car was stolen' )

			,( 2, 1, '05/05/2005', 'Earthquake' )
			,( 2, 2, '06/06/2006', 'Wildfire damage' )

-- --------------------------------------------------------------------------------
-- Step 3.5: Add two payments for each insurance policy claim
-- --------------------------------------------------------------------------------

INSERT INTO TPaymentRecipients ( intPaymentRecipientID, strFirstName, strLastName, strPhone, strAddress )
VALUES		 ( 1, 'Ryan', 'Dennick', '987-654-3210', '123 Last Ave' )
			,( 2, 'Chirs', 'Johnson', '876-543-2109', '987 Third Steet' )


INSERT INTO TInsurancePolicyClaimPayments ( intInsurancePolicyID, intClaimIndex, intPaymentIndex, strDate, intPaymentRecipientID, monAmount )
VALUES		 ( 1, 1, 1, '03/05/2003', 1, 1000 )
			,( 1, 1, 2, '03/10/2003', 1, 500 )

			,( 1, 2, 1, '04/08/2004', 1, 1000 )
			,( 1, 2, 2, '04/15/2004', 1, 500 )

			,( 2, 1, 1, '05/10/2005', 2, 1000 )
			,( 2, 1, 2, '05/15/2005', 2, 500 )

			,( 2, 2, 1, '06/10/2006', 2, 1000 )
			,( 2, 2, 2, '06/14/2006', 2, 500 )