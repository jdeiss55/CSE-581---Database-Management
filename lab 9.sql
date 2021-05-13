/* question 1 
CREATE PROC spBalanceRange --create procedure as name given by question
	@VendorVar varchar(50) = NULL, --define variable as varchar so we can use the like operator later on
	@BalanceMin money = NULL, --balance minimum as money
	@BalanceMax money = NULL --balance maximum as money
AS
IF @BalanceMin IS NULL --first if to check if balance min is null
	SELECT @BalanceMin = MIN(InvoiceTotal) FROM Invoices --select minimum invoice total
IF @BalanceMax IS NULL OR @BalanceMax = 0 --second if to check if balance max is null or zero
	SELECT @BalanceMax = MAX(InvoiceTotal) FROM Invoices --select maximum invoice total
IF @VendorVar IS NULL --if statement to check if vendor var is null
	SET @VendorVar = '%' --if it is, set to %, so it can accept zero, one, or multiple characters

SELECT VendorName, InvoiceNumber, (InvoiceTotal - CreditTotal - PaymentTotal) AS Balance --select columns
FROM Vendors JOIN Invoices --join vendors and invoices
ON Vendors.VendorID = Invoices.VendorID --on PK vendorID
WHERE (InvoiceTotal - CreditTotal - PaymentTotal) > @BalanceMin --where balance is greater than minimum
AND (InvoiceTotal - CreditTotal - PaymentTotal) < @BalanceMax --where balance is lower than maximum
AND VendorName LIKE @VendorVar; --where vendor name is zero, one, or multiple characters
*/

/* question 2 
EXEC spBalanceRange 'C%'; --exec that calls the stored proc to only return vendor names that start with "C"
EXEC spBalanceRange @BalanceMin = '$300', @BalanceMax = '$600'; --exec that calls the stored proc to only return vendors in the range of 300-600
EXEC spBalanceRange 'B%', @BalanceMin = '$50', @BalanceMax = '$250'; --could not figure out how to get the stored proc to search for 'A%' and 'B%' in the same perameter
*/

/* question 3 
CREATE PROC spDateRange --create stored proc 
	@DateMin varchar(30) = NULL, --variable for min date
	@DateMax varchar(30) = NULL --variable for max date
AS
IF @DateMin IS NULL -- if date min null
	THROW 50005, '@DateMin is blank', 1; --print error
IF @DateMax IS NULL --if date max null
	THROW 50010, '@DateMax is blank', 1; --print error
IF ISDATE(@DateMin) = 0 --if date min, converted to date datatype is 0
	THROW 50015, '@DateMin is not a valid date', 1; --print error
IF ISDATE(@DateMax) = 0 --if date max, converted to date datatype is 0
	THROW 50020, '@DateMax is not a valid date', 1; --print error
IF
(SELECT CONVERT(DATETIME, @DateMin)) > (SELECT CONVERT(DATETIME, @DateMax)) --if min date is greater than max date (both converted to date)
	THROW 50025, '@DateMin is greater than @DateMax', 1; --print error

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, (InvoiceTotal - CreditTotal - PaymentTotal) AS Balance --select columns
FROM Invoices --from table
WHERE InvoiceDate > CONVERT(DATETIME, @DateMin) --where the invoice date is between min and max date
AND InvoiceDate < CONVERT(DATETIME, @DateMax)
ORDER BY InvoiceDate DESC; --earliest date first 
*/

/* question 4 
EXEC spDateRange '2015-12-10', '2015-12-31'; --exec that calls stored proc for dates between december 10th 2015 and december 31st 2015
*/

/* question 5 
CREATE FUNCTION dbo.fnUnpaidInvoiceID() --create the function
RETURNS int --final answer will be int datatype
BEGIN
DECLARE @Answer int --declare variable as int to be manipulated
SELECT TOP 1 @Answer = MIN(InvoiceID) --selects top minimum invoice ID
FROM Invoices --from table
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0 --where balance due is greater than zero
RETURN @Answer --return the int variable
END;

SELECT VendorName, InvoiceNumber, InvoiceDueDate,
InvoiceTotal-CreditTotal-PaymentTotal AS Balance
FROM Vendors Join Invoices
ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceID = dbo.fnUnpaidInvoiceID();
*/

/* question 6 
CREATE FUNCTION fnDateRange --create function
(@DateMin varchar(30) = NULL, @DateMax varchar(30) = NULL) --define variables 
RETURNS TABLE --return type table
AS
RETURN
(SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceTotal-CreditTotal-PaymentTotal AS Balance --select columns
FROM Invoices --from table
WHERE InvoiceDate BETWEEN @DateMin AND @DateMax); --where date is between the minimum and the maximum 
GO

SELECT * --select all
FROM fnDateRange('2016-01-10', '2016-01-15'); --from function with perameters stated in question
*/

/* question 7 */
SELECT VendorCity, dbo.fnDateRange.* --select vendorcity and all of fnDateRange
FROM Vendors, dbo.fnDateRange('2016-01-10', '2016-01-15'); --from vendors and function