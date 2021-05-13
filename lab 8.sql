/* question 1
CREATE VIEW InvoiceBasic AS --creates view
SELECT VendorName, InvoiceNumber, InvoiceTotal --selects columns
FROM Vendors JOIN Invoices --join two tables 
ON Vendors.VendorID = Invoices.VendorID; --joins on pk VendorID

SELECT * --select all
FROM InvoiceBasic --from the view I created
WHERE (LEFT(VendorName, 1) = 'A') OR (LEFT(VendorName, 1) = 'B') OR (LEFT(VendorName, 1) = 'C') --where the first letter is A, B, or C
ORDER BY InvoiceTotal ASC; --orders from smallest to largest total
*/


/* question 2 
CREATE VIEW Top10PaidInvoices AS --creates view
SELECT TOP 10 VendorName, MAX(InvoiceDate) AS LastInvoiceDate, SUM(InvoiceTotal) AS SumOfInvoices --takes top 10 columns according to prompt
FROM Vendors JOIN Invoices --join tables
ON Vendors.VendorID = Invoices.VendorID --on primary key VendorID
WHERE InvoiceTotal - CreditTotal - PaymentTotal = 0 --makes sure invoice is paid
GROUP BY VendorName --no duplicates
ORDER BY SumOfInvoices ASC; --largest invoices

SELECT * --select all
FROM Top10PaidInvoices --from view we created
*/


/* question 3 
CREATE VIEW VendorAddress AS --create view
SELECT VendorID, VendorAddress1, VendorAddress2, VendorCity, VendorState, VendorZipCode --select columns so they can be updated
FROM Vendors --from desired table

UPDATE VendorAddress --update view
SET VendorAddress2 = '' --make blank space 
WHERE VendorAddress2 IS NULL; --where address 2 is null

SELECT * --select all
FROM VendorAddress --from view
WHERE VendorID = 7 --where id is 7
*/


/* question 4 
SELECT * --select all
FROM AP.sys.foreign_keys --catalog view
*/


/* question 5 
USE AP --uses AP database
DECLARE @TotalBalanceDue MONEY --declares variable as type money
SET @TotalBalanceDue = (SELECT SUM(InvoiceTotal - PaymentTotal - CreditTotal) --sets total balance to sum of balance
FROM Invoices) --from invoices table
IF @TotalBalanceDue < 45000 --start if else statement 
BEGIN
SELECT VendorName, InvoiceNumber, InvoiceDueDate, (InvoiceTotal - PaymentTotal - CreditTotal) AS Balance --selects columns as said in question
FROM Invoices JOIN Vendors --join tables
ON Invoices.VendorID = Vendors.VendorID --on PK vendorID
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0 --makes sure there is a balance
ORDER BY InvoiceDueDate DESC --order by newest date at top
PRINT 'Balance due is $' + CONVERT(varchar, @TotalBalanceDue, 1) --prints statement and converts variable from money to varchar so that it can be printed
END --end if
ELSE PRINT 'Balance due is more than $45,000' --else print message as stated in question
*/


/* question 6 
USE AP; --use AP database
SELECT VendorID, MAX(InvoiceDate) AS LastInvoiceDate --select columns per question
INTO #VendorTemp --create temp table
FROM Invoices --take from invoices table
GROUP BY VendorID --no duplicate vendors

SELECT VendorName, LastInvoiceDate, InvoiceTotal --select columns per questions
FROM Invoices JOIN #VendorTemp AS LastInvoice --join using temp table
ON (Invoices.VendorID = LastInvoice.VendorID --join on vendorID PK
AND Invoices.InvoiceDate = LastInvoice.LastInvoiceDate) --join based on dates
JOIN Vendors --join another table
ON Invoices.VendorID = Vendors.VendorID --on vendorID PK
ORDER BY VendorName, LastInvoiceDate;  --order by name and date 
*/


/* question 7 */
USE AP --uses AP database
IF NOT EXISTS --if does not exist
(SELECT * FROM sys.views --select from all views in system
WHERE NAME = 'EarliestInvoice') --where the name is earliest invoice, the one we are creating
EXEC('CREATE VIEW EarliestInvoice AS
SELECT InvoiceDate, InvoiceTotal
FROM Invoices
JOIN (SELECT VendorID, MIN(InvoiceDate) AS EarliestInvoiceDate
FROM Invoices
GROUP BY VendorID) AS MostRecentInvoice
ON (Invoices.VendorID = MostRecentInvoice.VendorID
AND Invoices.InvoiceDate = MostRecentInvoice.EarliestInvoiceDate)'); --exec that creates the view based on the question. Similar to question 6.

SELECT * --select all
FROM EarliestInvoice --from view we created


/* question 8
DECLARE @NameOfTable nvarchar(1000) --declare variable as varchar
SET @NameOfTable = --set variable
(SELECT TOP 1 NAME --select top name 
FROM sys.tables --from all tables in system
WHERE NAME NOT IN ('sysdiagrams', 'dtproperties') --where the name is not sysdiagrams or dtproperties
ORDER BY NAME) --order by name of the table
EXEC('SELECT COUNT(*) AS CountOf' + @NameOfTable + ' FROM ' + @NameOfTable); --execute statement that selects count of tables with same name 
*/