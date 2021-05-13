/* question 1 
SELECT * --selects all
INTO VendorCopy --creates new copy table
FROM Vendors --tells which table to copy

SELECT * --selects all
INTO InvoiceCopy --creates new copy table
FROM Invoices --tells which table to copy
*/

/* question 2
INSERT INTO InvoiceCopy --selects table to insert into
(VendorID, TermsID, PaymentTotal, InvoiceDate, InvoiceTotal, InvoiceNumber, InvoiceDueDate, CreditTotal) --lists columns that will get new values
VALUES --values that will be inserted
(2, 3 , 2.99, '2015-08-24', 401.40, 'CM-007-700', '2015-09-01', 5.99);

SELECT * --select all
FROM InvoiceCopy --table to select from
WHERE VendorID = 2; --by vendor id
*/

/* question 3
UPDATE VendorCopy --tells which table to update
SET DefaultAccountNo = 542 --sets to 542
WHERE DefaultAccountNo = 572; --wherever default is 572

SELECT * --select all
FROM VendorCopy --specifies table
WHERE DefaultAccountNo = 542; --any time it is 542
*/

/* question 4 
UPDATE InvoiceCopy --tells which table to update
SET TermsID = 5 --sets ID to 5
WHERE VendorID IN --subquery using vendorID as search
(SELECT VendorID --selects column
FROM VendorCopy --from table
WHERE DefaultTermsID = 2); --where default is 2

SELECT * --take all values
FROM InvoiceCopy --from table
WHERE TermsID = 5; --where new value is 5
*/

/* question 5
DELETE VendorCopy --select table to delete from
WHERE VendorState = 'NY'; --tells which value to delete

SELECT * --select all
FROM VendorCopy --from this table
WHERE VendorState = 'NY'; --where value is NY
*/

/* question 6 
DELETE VendorCopy --delete from this table
WHERE VendorState NOT IN --delete if not in vendor state
(SELECT DISTINCT VendorState --take unique vendor states
FROM VendorCopy JOIN InvoiceCopy --join tables on common key value
ON VendorCopy.VendorID = InvoiceCopy.VendorID); --common key vendorID

SELECT * 
FROM VendorCopy
WHERE VendorState IN
(SELECT DISTINCT VendorState
FROM VendorCopy JOIN InvoiceCopy
ON VendorCopy.VendorID = InvoiceCopy.VendorID);
*/

/* question 7 
SELECT 
CAST(InvoiceTotal AS DECIMAl(10, 4)) AS Column1, --turns invoice total into decimal with 4 digits to right of decimal
CAST(InvoiceTotal AS VARCHAR(10)) AS Column2, --turns invoice total to a varchar
CONVERT(DECIMAL(10, 4), InvoiceTotal) AS Column3, --converts value to same decimal value as column1
CONVERT(VARCHAR(10), InvoiceTotal, 10) AS Column4 --converts value to same varchar as comlum2, but uses style 10
FROM Invoices; --where we are selecting from 
*/

/* question 8 
SELECT
CAST(InvoiceDate AS VARCHAR(10)) AS Column1, --turns invoice date to varchar
CONVERT(VARCHAR(10), InvoiceDate, 5) AS Column2, --converts invoice date to varchar using style 5
CONVERT(VARCHAR(10), InvoiceDate, 9) AS Column3, --converts invoice date to varchar using style 9
CAST(InvoiceDate AS REAL) AS Column4 --turns invoice date to the REAL data type
FROM Invoices; --where we are selecting from
*/
