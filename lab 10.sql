/* question 1 */
BEGIN TRANSACTION Question1 --start
	UPDATE Invoices --update table
	SET VendorID = 68 --update the vendor ID to be correct for drawing board
	WHERE VendorID = 65;

	DELETE Vendors --delete board
	WHERE VendorName = 'The Drawing Board';

	UPDATE Vendors --replace board
	SET VendorName = 'ComputerBoard'
	WHERE VendorName = 'Computer Library'
COMMIT TRANSACTION; --finish

SELECT * 
FROM Vendors
WHERE VendorName = 'ComputerBoard'



/* question 2 
BEGIN TRANSACTION Question2 --begin

	INSERT INTO InvoiceArchive --insert into table
	SELECT * FROM Invoices --all from this table
	WHERE InvoiceID NOT IN --where does not exist
	(SELECT InvoiceID --in the other table
	FROM InvoiceArchive)
	AND PaymentDate IS NOT NULL; --and invoice is paid

	DELETE --remove
	FROM Invoices --from table
	WHERE InvoiceID IN --where the invoice
	(SELECT InvoiceID --in this table
	FROM InvoiceArchive)
	AND PaymentDate IS NOT NULL; --is paid

COMMIT TRANSACTION; --commit

SELECT * FROM Invoices 
SELECT * FROM InvoiceArchive
*/