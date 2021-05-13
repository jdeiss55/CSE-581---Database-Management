/* question 1 
CREATE DATABASE Shopping
*/

/* question 2 
CREATE TABLE Customers
(CustomerID int NOT NULL IDENTITY PRIMARY KEY, FirstName varchar(50) NOT NULL, LastName varchar(50) NOT NULL, Phone varchar(50) NULL);

CREATE TABLE Products
(ProductID int NOT NULL IDENTITY PRIMARY KEY, ProductName varchar(50) NOT NULL, ProductCost MONEY NULL DEFAULT 0 CHECK (ProductCost >= 0));

CREATE TABLE CustomerGroups
(CustomerID int REFERENCES Customers(CustomerID), ProductID int REFERENCES Products(ProductID));
*/

/* question 3 
CREATE CLUSTERED INDEX
Index_CustomerGroups_ProductID
ON CustomerGroups(ProductID)
CREATE INDEX
Index_CustomerGroups_CustomerID
ON CustomerGroups(CustomerID);
*/

/* question 4 
ALTER TABLE Customers
ADD BillsPaid bit NOT NULL DEFAULT 0;
*/

/* question 5
ALTER TABLE  Invoices
ADD CHECK ((PaymentDate IS NULL AND PaymentTotal = 0)
OR (PaymentDate IS NOT NULL AND PaymentTotal > 0)),
CHECK ((PaymentTotal + CreditTotal) <= InvoiceTotal);
*/

/* question 6 
DROP TABLE CustomerGroups;

CREATE TABLE CustomerGroups
(ProductID int REFERENCES Products(ProductID), CustomerID int REFERENCES Customers(CustomerID), UNIQUE(ProductID, CustomerID));
*/