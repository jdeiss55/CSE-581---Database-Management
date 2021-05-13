/* Part 1: Creating the Database */
CREATE DATABASE StatesMDUrgentCareCenter; --create database with name specified by prompt

CREATE TABLE Patients --create
(PatientID int NOT NULL PRIMARY KEY, --not null PK
FirstName varchar(15), --less characters because first names tend to be shorter than last
LastName varchar(20),
Address varchar(30),
PhoneNumber varchar(20),
Email varchar(30)); --end

CREATE TABLE Insurance --create
(InsuranceID int NOT NULL PRIMARY KEY, --not null pk
Provider varchar(40),
ProviderPhone varchar(20),
PatientID int FOREIGN KEY REFERENCES Patients(PatientID)); --fk refrences patients

CREATE TABLE PatientDescription --create
(PDescriptionID int NOT NULL PRIMARY KEY, --not null pk
Age int,
Height varchar(20),
Weight varchar(20),
PatientID int FOREIGN KEY REFERENCES Patients(PatientID)); --fk refrences patients

CREATE TABLE EmergencyInfo --create
(InfoID int NOT NULL PRIMARY KEY, --not null pk
ReferralDoctor varchar(40),
HospitalInfo varchar(40),
MedicationInfo varchar(40),
EmergencyContactName varchar(40),
EmergencyContactPhone varchar(20),
PatientID int FOREIGN KEY REFERENCES Patients(PatientID)); --fk references patients

CREATE TABLE Center --create
(CenterID int NOT NULL PRIMARY KEY, --not null pk
CenterName varchar(30),
Location varchar(30),
Hours varchar(30)); --end

CREATE TABLE CenterDetails --create
(CDetailID int NOT NULL PRIMARY KEY, --not null pk
NumberOfRooms int,
NumberOfDoctors int,
CenterID int FOREIGN KEY REFERENCES Center(CenterID)); --fk references center

CREATE TABLE Employee --create
(EmployeeID int NOT NULL PRIMARY KEY, --not null PK
FirstName varchar(15), --less characters because first names tend to be shorter than last
LastName varchar(20),
PhoneNumber varchar(20),
Email varchar(30)); --end

CREATE TABLE EmployeeDescription --create
(EDescriptionID int NOT NULL PRIMARY KEY, --not null PK
JobTitle varchar(40),
Salary money,
Department varchar(40),
DepartmentPhone varchar(20),
EmployeeID int FOREIGN KEY REFERENCES Employee(EmployeeID)); --fk references employee

CREATE TABLE EmployeeBackground --create
(EBackgroundID int NOT NULL PRIMARY KEY, --not null pk
College varchar(30),
GraduationYear int,
YearsInField int,
EmployeeID int FOREIGN KEY REFERENCES Employee(EmployeeID)); --fk references employee

CREATE TABLE Visit --create
(VisitID int NOT NULL PRIMARY KEY, --not null pk
Date datetime,
time datetime,
PatientID int FOREIGN KEY REFERENCES Patients(PatientID), --fk references patients
EmployeeID int FOREIGN KEY REFERENCES Employee(EmployeeID), --fk references employee
CenterID int FOREIGN KEY REFERENCES Center(CenterID)); --fk references center

CREATE TABLE VisitDescription --create
(VDescriptionID int NOT NULL PRIMARY KEY, --not null pk
ReasonForVisit varchar(50),
Symptoms varchar(50),
VisitID int FOREIGN KEY REFERENCES Visit(VisitID)); --fk references visit

CREATE TABLE Costs --create
(CostID int NOT NULL PRIMARY KEY, --not null pk
TotalMedication money,
TotalProcedures money,
TotalEquiptment money,
CenterID int FOREIGN KEY REFERENCES Center(CenterID)); --fk references center

CREATE TABLE Testing --create
(TestID int NOT NULL PRIMARY KEY, --not null pk
TotalTestsDistributed int,
TotalPositiveTests int,
CountyReportedTo varchar(20),
CenterID int FOREIGN KEY REFERENCES Center(CenterID)); --fk references center

CREATE TABLE Billing --create
(BillingID int NOT NULL PRIMARY KEY, --not null pk
TotalCost money,
Payor varchar(20),
PaymentType varchar(20),
VisitID int FOREIGN KEY REFERENCES Visit(VisitID)); --fk references visit

CREATE TABLE Management --create
(ManageID int NOT NULL PRIMARY KEY, --not null pk
ManagerName varchar(40),
ManagerPhone varchar(20),
ManagerEmail varchar(20),
CenterID int FOREIGN KEY REFERENCES Center(CenterID)); --fk references center

CREATE TABLE ManagementBackground --create
(MBackgroundID int NOT NULL PRIMARY KEY, --not null pk
YearsInField int,
Degree varchar(30),
ManageID int FOREIGN KEY REFERENCES Center(CenterID)); --fk references manager


/* Part 2: Inserting Data */
INSERT INTO Patients(PatientID, FirstName, LastName, Address, PhoneNumber, Email)
VALUES (1, 'Jeff', 'Lambda', '12 Norwalk Street Orlando, FL', '312-345-6457', 'jlamb@gmail.com');
INSERT INTO Patients(PatientID, FirstName, LastName, Address, PhoneNumber, Email)
VALUES (2, 'Suzie', 'Alpha', '62 Olaf Drive Reading, PA', '215-656-0990', 'suealpha@gmail.com');
INSERT INTO Patients(PatientID, FirstName, LastName, Address, PhoneNumber, Email)
VALUES (3, 'Eric', 'Zeta', '1 Street Road Syracuse, NY', '610-200-1854', 'ezeta@gmail.com');
INSERT INTO Patients(PatientID, FirstName, LastName, Address, PhoneNumber, Email)
VALUES (4, 'Anna', 'Foxtrot', '2 Karma Avenue Provedence, RI', '974-032-9994', 'afox@gmail.com');

INSERT INTO Insurance (InsuranceID, Provider, ProviderPhone, PatientID)
Values (1, 'UnitedHealth', '855-311-1612', 1);
INSERT INTO Insurance (InsuranceID, Provider, ProviderPhone, PatientID)
Values (2, 'Caresource', '800-488-0134', 2);
INSERT INTO Insurance (InsuranceID, Provider, ProviderPhone, PatientID)
Values (3, 'Blue Cross', '888-630-2583', 3);
INSERT INTO Insurance (InsuranceID, Provider, ProviderPhone, PatientID)
Values (4, 'Humana', '844-330-7799', 4);

INSERT INTO PatientDescription 
VALUES (1, '26', '6ft 1in', '185 lbs', 1);
INSERT INTO PatientDescription
Values(2, '43', '5ft 4in', '120 lbs', 2);
INSERT INTO PatientDescription
Values(3, '63', '5ft 10in', '175 lbs', 3);
INSERT INTO PatientDescription
Values(4, '33', '5ft 6in', '140 lbs', 4);

INSERT INTO EmergencyInfo
VALUES (1, 'Dr. Omar Jenkins', 'Johns Hopkins Hospital', 'Inhaler', 'Carl Lambda', '312-788-0045', 1);
INSERT INTO EmergencyInfo
VALUES (2, 'Dr. Jessica Knope', 'UCLA Medical Center', 'Metformin', 'John Alpha', '215-295-4334', 2);
INSERT INTO EmergencyInfo
VALUES (3, 'Dr. Thomas Wayne', 'Massachusetts General Hospital', 'Epipen, Amoldipine', 'Connie Zeta', '610-220-1597', 3);
INSERT INTO EmergencyInfo
VALUES (4, 'Dr. Joseph Ingrid', 'Cleveland Clinic', 'Vicodin', 'Tim Foxtrot', '974-111-4522', 4);

INSERT INTO Center
VALUES (1, 'Tower Health Urgent Care', 'Sarrasota, FL' ,'7AM-5PM');
INSERT INTO Center
VALUES (2, 'USHealthworks Urgent Care', 'Levittown, PA' ,'6AM-5PM');
INSERT INTO Center
VALUES (3, 'CareSpot Urgent Care', 'Boston, MA' ,'7AM-4PM');
INSERT INTO Center
VALUES (4, 'MedSpring Urgent Care', 'Cleveland, OH' ,'8AM-5PM');

INSERT INTO CenterDetails
VALUES (1, 30, 12, 1);
INSERT INTO CenterDetails
VALUES (2, 15, 7, 2);
INSERT INTO CenterDetails
VALUES (3, 10, 5, 3);
INSERT INTO CenterDetails
VALUES (4, 40, 22, 4);

INSERT INTO Employee
VALUES (1, 'Edward', 'Minkus' ,'164-224-8454' ,'eminkus@gmail.com');
INSERT INTO Employee
VALUES (2, 'Sally', 'Seashell' ,'564-321-9842' ,'sallysea@gmail.com');
INSERT INTO Employee
VALUES (3, 'Connor', 'Planter' ,'215-351-1682' ,'planterguy@gmail.com');
INSERT INTO Employee
VALUES (4, 'Elizabeth', 'Village' ,'666-689-9642' ,'lizzyvillage@gmail.com');

INSERT INTO EmployeeDescription
VALUES (1, 'Doctor', '$75,000.00', 'General Health', '322-215-4696', 1);
INSERT INTO EmployeeDescription
VALUES (2, 'Nurse', '$50,000.00', 'Nursing', '322-215-7548', 2);
INSERT INTO EmployeeDescription
VALUES (3, 'Doctor', '$85,000.00', 'Vaccinations', '322-215-8465', 3);
INSERT INTO EmployeeDescription
VALUES (4, 'Doctor', '$105,000.00', 'General Health', '322-215-4696', 4);

INSERT INTO EmployeeBackground
VALUES (1, 'University of Pennsylvania', 1984, 20, 1);
INSERT INTO EmployeeBackground
VALUES (2, 'Duke University', 2015, 5, 2);
INSERT INTO EmployeeBackground
VALUES (3, 'New York University', 1991, 16, 3);
INSERT INTO EmployeeBackground
VALUES (4, 'University of Washington', 1980, 28, 4);

INSERT INTO Visit
VALUES (1, '2019-04-23', '3:00PM', 1, 1, 1);
INSERT INTO Visit
VALUES (2, '2020-07-06', '4:30PM', 2, 2, 2);
INSERT INTO Visit
VALUES (3, '2019-12-01', '9:30AM', 3, 3, 3);
INSERT INTO Visit
VALUES (4, '2019-01-30', '12:30PM', 4, 4, 4);

INSERT INTO VisitDescription
VALUES (1, 'COVID-19 Test', 'Sore Throat', 1);
INSERT INTO VisitDescription
VALUES (2, 'Prescription Pick up', 'None', 2);
INSERT INTO VisitDescription
VALUES (3, 'COVID-19 Test', 'Sore Throat, Headache', 3);
INSERT INTO VisitDescription
VALUES (4, 'Flu Vaccine', 'None', 4);

INSERT INTO Costs
VALUES (1, 134755.50, 2466645.43, 9884676.35, 1);
INSERT INTO Costs
VALUES (2, 83783.56, 9178894.34, 1004203.50, 2);
INSERT INTO Costs
VALUES (3, 9928340.04, 7982403.50, 10394554.56, 3);
INSERT INTO Costs
VALUES (4, 345629.89, 5004032.45, 2940284.96, 4);

INSERT INTO Testing
VALUES (1, 343, 90, 'Sarasota County', 1);
INSERT INTO Testing
VALUES (2, 250, 37, 'Bucks County', 2);
INSERT INTO Testing
VALUES (3, 204, 30, 'Suffolk County', 3);
INSERT INTO Testing
VALUES (4, 568, 178, 'Cuyahoga County', 4);

INSERT INTO Billing
VALUES (1, 352.00, 'Insurance', 'Insurance', 1);
INSERT INTO Billing
VALUES (2, 56.50, 'Patient', 'Credit Card', 2);
INSERT INTO Billing
VALUES (3, 352.00, 'Insurance', 'Insurance', 3);
INSERT INTO Billing
VALUES (4, 185.50, 'Insurance', 'Insurance', 4);

INSERT INTO Management
VALUES (1, 'William Bust', '124-454-3356', 'billbust@hotmail.com', 1);
INSERT INTO Management
VALUES (2, 'Margret Collins', '435-323-3355', 'margcoll@gmail.com', 2);
INSERT INTO Management
VALUES (3, 'Emily Throne', '610-696-0007', 'emthrone@gmail.com', 3);
INSERT INTO Management
VALUES (4, 'Jonathan Snow', '267-377-5050', 'jonsnow@gmail.com', 4);

INSERT INTO ManagementBackground
VALUES (1, 10, 'Masters in Business Administration', 1);
INSERT INTO ManagementBackground
VALUES (2, 7, 'Undergraduate in Management', 2);
INSERT INTO ManagementBackground
VALUES (3, 15, 'Masters in Business Administration', 3);
INSERT INTO ManagementBackground
VALUES (4, 17, 'Masters in Business Administration', 4);

/* Part 3: 4 Views, 2 Stored Procs, 2 UDFs, 2 Triggers, and 1 Transaction */

--View 1: Return all Managers that have over 10 years in their field and have a first name that starts with a letter A-H
CREATE VIEW ManagerFilter AS
SELECT ManagerName, YearsInField --selects name and number of years 
FROM Management JOIN ManagementBackground --joins to background
ON Management.ManageID = ManagementBackground.ManageID --on common key
WHERE YearsInField > 10 --more than ten years
AND LEFT(ManagerName, 1) LIKE '[A-H]'; --use like to filter based on an "array" of characters in the alphabet

SELECT * FROM ManagerFilter;

--View 2: Returns the total cost for each center formatted with a dollar sign
CREATE VIEW TotalCenterCosts AS
SELECT CenterName, ('$' + CONVERT(varchar, TotalMedication + TotalProcedures + TotalEquiptment)) AS TotalCostPerCenter --selects name of center as well as adds all of the values together, and converts them to a varchar so that the '$' may be added to the front for formatting
FROM Center JOIN Costs --join tables
ON Center.CenterID = Costs.CenterID; --on common key

SELECT * FROM TotalCenterCosts;

--View 3: Return the names of the centers that have distributed over 200 tests, and got back less than 50 positives
CREATE VIEW TestingFilter AS
SELECT CenterName --selects just the name of the center
FROM Center JOIN Testing --need to access tests, so must join
ON Center.CenterID = Testing.CenterID --on common key
WHERE TotalTestsDistributed > 200 AND TotalPositiveTests < 50; --as per constraints

SELECT * FROM TestingFilter;

--View 4: Return all patient names in the format (last name, first name) as well as their emails for those patients who went to the care center for a COVID-19 test
CREATE VIEW CovidTestedPatients AS
SELECT (Patients.LastName + ', ' + Patients.FirstName) AS PatientName, Patients.Email --formats as per my format, also gets email
FROM Patients JOIN Visit ON Patients.PatientID = Visit.PatientID JOIN VisitDescription ON Visit.VisitID = VisitDescription.VisitID --need to join two tables since patients cannot directly access visitdescription
WHERE ReasonForVisit = 'COVID-19 Test'; --filter for exactly what string I want

SELECT * FROM CovidTestedPatients;

--Stored Procedure 1: Return the name of the center,  its location, and the county it reports test results to for the center that has the greatest number of rooms and number of doctors
USE StatesMDUrgentCareCenter; --use my db
GO
CREATE PROC spMostQualifiedCenter --create
AS
SELECT CenterName, Location, CountyReportedTo --select columns
FROM Center JOIN CenterDetails ON Center.CenterID = CenterDetails.CenterID JOIN Testing ON Center.CenterID = Testing.CenterID --join tables to be able to access data from all
WHERE NumberOfRooms = (SELECT MAX(NumberOfRooms) FROM CenterDetails) --subquery that finds max number of rooms in centerdetails table
AND NumberOfDoctors = (SELECT MAX(NumberOfDoctors) FROM CenterDetails); --subquery that finds max number of doctors in centerdetails table

EXEC spMostQualifiedCenter;

--Stored Procedure 2: Return the name of the patient (lastname,firstname) and their insurance provider for each visit that was paid for using insurance
USE StatesMDUrgentCareCenter --use my db
GO
CREATE PROC spInsurancePayors --create
AS
SELECT (LastName + ', ' + FirstName) AS PatientName, Provider --format name and select columns
FROM Patients JOIN Insurance ON Patients.PatientID = Insurance.PatientID JOIN Visit ON Visit.PatientID = Patients.PatientID JOIN Billing ON Billing.VisitID = Visit.VisitID --need to join 4 tables to be able to access all the data that I need, since patient cannot acces billing without going through visit
WHERE Payor = 'Insurance'; --insurance is the payor

EXEC spInsurancePayors;

--UDF 1: Function that will return the emergency phone number when given the phone number of a patient
CREATE FUNCTION fnEmergency --create
(@PhoneNumber varchar(20)) RETURNS varchar(20) --set variable that can hold phone number and return varchar big enough for phone number
BEGIN
	RETURN(SELECT EmergencyContactPhone FROM EmergencyInfo JOIN Patients ON EmergencyInfo.PatientID = Patients.PatientID WHERE @PhoneNumber = PhoneNumber); --select statement that joins patients with emergency info so that the query can access both phone numbers and see which one correlates to the other
END;

PRINT 'The phone number of the emergency contact is: ' + dbo.fnEmergency('610-200-1854'); --print the function for this specific phone number

--UDF 2: Function that will return a table that contains the name (lastname, firstname), department, and graduation year of the employees that make under a user specified amount
CREATE FUNCTION fnEmployeeFinancialCheck(@Salary money = 0) --create
RETURNS TABLE --table-valued function
RETURN
	(SELECT (LastName + ', ' + FirstName) AS EmployeeName, Department, GraduationYear --format name and select columns
	FROM Employee JOIN EmployeeBackground ON Employee.EmployeeID = EmployeeBackground.EmployeeID JOIN EmployeeDescription ON EmployeeDescription.EmployeeID = Employee.EmployeeID --join all tables related to employee
	WHERE Salary < @Salary); --check if salary is less than 80k

SELECT * FROM fnEmployeeFinancialCheck(80000.00);

--Trigger 1: A trigger that makes sure that the first letter in the County that the test are reported to is capitalized for organizational and neatness purposes
CREATE TRIGGER Testing_INSERT_UPDATE --create trigger
	ON Testing
	AFTER INSERT, UPDATE --after an insert or update statement that affects testing is executed, trigger fires
AS
	UPDATE Testing
	SET CountyReportedTo = UPPER(LEFT(CountyReportedTo, 1)) + Lower(SUBSTRING(CountyReportedTo,2,LEN(CountyReportedTo))) --capitalizes first letter
	WHERE TestID IN (SELECT TestID FROM Inserted); --

UPDATE Testing --test case 
SET CountyReportedTo = 'bucks county'
WHERE TestID = 2;

Select * FROM Testing
WHERE TestID = 2;

--Trigger 2: A trigger that makes sure that patient's emails are all lowercase for organizational and neatness purposes
CREATE TRIGGER Employee_Patients_INSERT_UPDATE --create trigger
	ON Patients
	AFTER INSERT, UPDATE
AS
	UPDATE Patients
	SET Email = LOWER(Email)
	WHERE PatientID IN (SELECT PatientID FROM Inserted)

UPDATE Patients
SET Email = 'jLAmb@gMaIL.COM'
WHERE PatientID = 1;

SELECT * FROM Patients
WHERE PatientID = 1;

--Transaction 1: A Transaction that updates the degree of a manager if they get their masters, as well as increments their years in the field since they went back to school
DECLARE @ErrorCode INT
BEGIN TRAN
	UPDATE ManagementBackground
		SET Degree = 'Masters in Business Administration'
		WHERE Degree <> 'Masters in Business Administration'
	SELECT @ErrorCode = @@ERROR
	IF (@ErrorCode <> 0)
	BEGIN
		PRINT 'Error Occurred'
		ROLLBACK TRAN
	END
	UPDATE ManagementBackground
		SET YearsInField = YearsInField + 1
	SELECT @ErrorCode = @@ERROR
	IF (@ErrorCode <> 0)
	BEGIN
		PRINT 'Error Occurred'
		ROLLBACK TRAN
	END
COMMIT TRAN
		
SELECT * FROM ManagementBackground

--Security Script 1:
USE StatesMDUrgentCareCenter;

CREATE ROLE PatientManager;

GRANT UPDATE, INSERT, DELETE
ON Patients
TO PatientManager;

GRANT UPDATE, INSERT, DELETE
ON PatientDescription
TO PatientManager;

GRANT UPDATE, INSERT, DELETE
ON EmergencyInfo
TO PatientManager;

CREATE LOGIN Project2Script1 WITH PASSWORD = 'script1',
DEFAULT_DATABASE = StatesMDUrgentCareCenter;

CREATE USER RonaldJones
FOR LOGIN Project2Script1;

ALTER ROLE PatientManager
ADD MEMBER RonaldJones;

--Security Script 2
USE StatesMDUrgentCareCenter;

CREATE ROLE EmployeeManager;

GRANT UPDATE, INSERT, DELETE
ON Employee
TO EmployeeManager;

GRANT UPDATE, INSERT, DELETE
ON EmployeeDescription
TO EmployeeManager;

GRANT UPDATE, INSERT, DELETE
ON EmployeeBackground
TO EmployeeManager;

CREATE LOGIN Project2Script2 WITH PASSWORD = 'script2',
DEFAULT_DATABASE = StatesMDUrgentCareCenter;

CREATE USER EmmaPotter
FOR LOGIN Project2Script2;

ALTER ROLE EmployeeManager
ADD MEMBER EmmaPotter;