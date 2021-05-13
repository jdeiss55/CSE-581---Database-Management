/* question 1 */
SELECT InvoiceNumber, InvoiceDate, InvoiceDueDate, InvoiceTotal /*chooses the columns*/
FROM Invoices; /*tells where to select from */

/* question 2 */
SELECT InvoiceNumber as Number, InvoiceTotal as Total, (PaymentTotal + CreditTotal) as Credits /* gives each column an alias and uses sum to get credits */
FROM Invoices; /* tells where to select from */

/* question 3 */
SELECT (VendorContactLName + ', ' + VendorContactFName) as "Full Name" /* creates last name, first name format */
From Vendors /* tells where to select from */
ORDER BY "Full Name" DESC; /* display the names in descending order by last name, aka Z - A */

/* question 4 */
SELECT * /* select all */
FROM Invoices /* tells where to select from */
WHERE ((InvoiceTotal - (PaymentTotal + CreditTotal) <= 0) AND PaymentDate IS NULL) /* checks whether there is still payment due by making sure that there is either a null or some balance remaining */
OR ((InvoiceTotal - (PaymentTotal - CreditTotal) > 0) AND PaymentDate IS NOT NULL);

/* question 5 */
SELECT VendorName, VendorCity, VendorZipCode, DefaultAccountNo, AccountDescription /* choose columns */
FROM Vendors, GLAccounts /* pull from two tables*/
WHERE AccountDescription = 'Other Equipment' /* filter for specific description */
ORDER BY VendorCity DESC; /* ordered from Z - A */

/* question 6 */
SELECT FirstName, (FirstName + ', ' + LastName) as FullName /* selects names, creates full name column */
From ContactUpdates /* tells us where to select from */
ORDER BY FirstName ASC; /* orders from A-Z */
/* as you can see by the table that this query displays, none of the vendors in the ContactUpdates table have the same last name */

/* question 7 */
SELECT VendorName, VendorState /* selects name and state */
FROM Vendors /* tells us where to select from */
WHERE VendorState = 'CA' /* filters states for CA */
UNION 
SELECT VendorName, 'Not in CA' /* selects name and state, but changes state name to Not in CA */
FROM Vendors 
WHERE VendorState <> 'CA' /* filters out the states that are not CA and makes them Not in CA */
ORDER BY VendorName ASC; /* orders names from A-Z */

/*/* question 8 */
SELECT ItemID, ShippedDate /* selects item and the date (going to be NULL) */
FROM OrderDetails, Orders /* chooses tables */
WHERE ShippedDate IS NULL; /* filters for which items have not been shipped yet, aka NULL */*/

