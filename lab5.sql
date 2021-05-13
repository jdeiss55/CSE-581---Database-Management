/* question 1 */
SELECT VendorContactLName + ' ' + LEFT(VendorContactFName, 2) + ',' AS Contact, --formats the name according to question
RIGHT(VendorPhone, 8) AS PhoneNumber --takes only right 8 digits
FROM Vendors --shows where to take from
WHERE VendorPhone IN --subquery that searches the complete vendors for vendor phone instances that start with 209
(SELECT VendorPhone
FROM Vendors
WHERE LEFT(VendorPhone, 3) = '209');


/* question 2 */
SELECT InvoiceNumber, (InvoiceTotal - PaymentTotal - CreditTotal) AS TotalBalance--creates balance column and selects
FROM Invoices --shows what table to select from
WHERE TotalBalance > 0 AND InvoiceDueDate < GETDATE() + 12; --takes current date and adds 12 as said in question

/* question 3 */
SELECT InvoiceNumber, (InvoiceTotal - PaymentTotal - CreditTotal) AS TotalBalance --selects columns
FROM Invoices --table where selected from
WHERE TotalBalance > 0 AND InvoiceDueDate BETWEEN DATEADD(DAY, -1, GETDATE()) AND GETDATE(); --uses dateadd function to subtract one day from end of month

/* question 4 */
SELECT InvoiceNumber, (InvoiceTotal - PaymentTotal - CreditTotal) AS TotalBalance, selects columns
RANK() OVER (ORDER BY Balance ASC) AS BalanceRank --ranks by balance in ascending order
FROM Invoices --table where selected from
WHERE TotalBalance > 0 and InvoiceDueDate < GETDATE() + 12; --takes current date and adds 12 as said in question