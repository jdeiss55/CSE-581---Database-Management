/* question 1 
SELECT TOP 5 Artist, SUM(UnitPrice) AS TotalEarnings --selects only top 5 artists, takes sum of unit price and changes column name
FROM Items --where we are getting columns from
GROUP BY  Artist --grouping the artists with multiple instances together
ORDER BY TotalEarnings ASC; --ordering by least amount earned 
*/

/* question 2 
SELECT VendorName, COUNT(*) AS InvoiceCount, --selects name, count of invoices, and average of invoice total
AVG(InvoiceTotal) AS InvoiceAverage
FROM Vendors JOIN Invoices --need to join the tables to be able to access the number of invoices
ON Vendors.VendorID = Invoices.VendorID --vendorID is a key in both tables, so we can join it on that
GROUP BY VendorName --groups by name
ORDER BY InvoiceCount DESC; --sorts by descending number of invoices
*/

/* question 3 
SELECT GLAccounts.AccountDescription, COUNT(*) AS LineItemCount, SUM(InvoiceLineItemAmount) AS LineItemSum --identifies columns taking counts and sums
FROM GLAccounts JOIN InvoiceLineItems --joins the two tables who have AccountNo
ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo --both tables are joined on AccountNo because it is a key in each table
GROUP BY GLAccounts.AccountDescription --groups by account description so no duplicates
HAVING COUNT(*) > 2 --makes sure there are no InvoiceLineCount instances less than 2 
ORDER BY LineItemSum DESC; --orders by lineitem sum 
*/


/* question 4 
SELECT AccountNo, SUM(InvoiceLineItemAmount) AS LineItemSum --creates columns, including sum
FROM InvoiceLineItems --tells which table to take from
GROUP BY AccountNo WITH ROLLUP; --groups by account number so no duplicates, and adds rollup summary row
*/

/* question 5 
SELECT VendorName, COUNT(InvoiceLineItems.AccountNo) as NumAccounts --take name and count number of invoices per account number	
FROM Vendors JOIN Invoices --join tables that both have vendorID
ON Vendors.VendorID = Invoices.VendorID
JOIN InvoiceLineItems -- join both tables that have invoiceID
On Invoices.InvoiceID = InvoiceLineItems.InvoiceID
GROUP BY VendorName --group by vendor name so no duplicates
HAVING COUNT(InvoiceLineItems.AccountNO) > 2 --count only number of accounts greater than 2
ORDER BY NumAccounts ASC; --order by asc number of accounts
*/

/*question 6 
SELECT DISTINCT GLAccounts.AccountNo --selects account number with no repeats
FROM GLAccounts JOIN InvoiceLineItems -- joins tables that have common account number key
ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
WHERE InvoiceLineItemAmount > --derived table that takes avg of all invoice line items and compares to item amount 
(SELECT AVG(InvoiceLineItemAmount) FROM InvoiceLineItems);
*/

/* question 7 
SELECT SUM(InvoiceMin) AS SumSmallest --take sum of invoice min, which is created in the derived table
FROM (SELECT VendorID, MIN(InvoiceTotal) AS InvoiceMin -- select from the derived table that selects minimum invoice totals
FROM Invoices 
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0 --as per the question, this is how you calculate if there is balance due
GROUP BY VendorID) AS Minimum -- groups by vendorID
*/

/* question 8 */
SELECT VendorID, VendorCity, VendorState, VendorZipCode --selects desired columns
FROM Vendors
WHERE VendorCity + VendorZipCode NOT IN --using + to add the two expressions together so that the query can search for both
(SELECT VendorCity + VendorZipCode --creating derived table to search for common zip code and city 
FROM Vendors
GROUP BY VendorCity, VendorZipCode --groups by city and zip code so that there are no repeats
HAVING COUNT(*) >1) --counts to make sure that there are not multiple instances of matching city/zip codes
ORDER BY VendorCity DESC, VendorState ASC; --orders by vendor city and vendor state as per the prompt






