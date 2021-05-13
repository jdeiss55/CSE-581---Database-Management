/* Part A: Q2 
SELECT * --select all
FROM Orders; --from table

SELECT * --select all
FROM OrderItems; --from table
*/

/* Part B: Q1 
SELECT (LastName + ', ' + EmailAddress) AS FullName --select column renaming to fullname
FROM Customers --from table
WHERE LEFT(LastName, 1) BETWEEN 'A' AND 'H' --takes leftmost character of Lastname and checks if it is between character 'A' and 'H'
ORDER BY FullName DESC; --orders in descending order
*/

/* Part B: Q2 
SELECT OrderID, OrderDate, ShipDate --select columns
FROM Orders --from table
WHERE OrderDate IS NOT NULL; --where desired value is not null
*/

/* Part C: Q1 
SELECT Customers.LastName, Orders.ShipDate, Products.ProductName, Products.Description, OrderItems.ItemPrice, OrderItems.DiscountAmount, OrderItems.Quantity --select columns with alias
FROM Customers, Orders, OrderItems, Products --from required tables
ORDER BY Customers.LastName ASC, Orders.ShipDate DESC, Products.ProductName DESC; --order by according to question
*/

/* Part C: Q2
SELECT CategoryName --select name
FROM Categories --from table
LEFT JOIN Products --left join (outer join to make sure unmatched elements)
ON Categories.CategoryID = Products.CategoryID --join on PK CategoryID
WHERE ProductID IS NULL; --where ID is null, as per hint
*/

/* Part C: Q3 
SELECT EmailAddress, (SUM(ItemPrice * Quantity)) AS PriceTotal, (AVG(DiscountAmount * Quantity)) AS DiscountTotal --select columns as per question
FROM Customers JOIN Orders --join customers and orders table because there is no way of joining orderitems
ON Customers.CustomerID=Orders.CustomerID --join on PK customer id
JOIN OrderItems --now we join orderitems as well and use the orderID PK because it does not exist in the customers table
ON Orders.OrderID=OrderItems.OrderID --join using order id PK
GROUP BY EmailAddress --group by to prevent duplicates 
ORDER BY PriceTotal DESC; --ordered descending as per question
*/

/* Part C: Q4 
SELECT EmailAddress, COUNT(Orders.OrderID) AS NumOrders, SUM((ItemPrice - DiscountAmount) * Quantity) AS OrderTotal --select columns as per question
FROM Customers JOIN Orders --join customers to orders so that we can then join orders to orderitems
ON Customers.CustomerID = Orders.CustomerID --join on PK customer id
JOIN OrderItems --then join orderitems because we cant join customers and orderitems directly because there are no common PKs
ON Orders.OrderID = OrderItems.OrderID --join on order id PK
WHERE ItemPrice > 500 --where the item price is over 500
GROUP BY EmailAddress --group by to prevent duplicates
ORDER BY EmailAddress DESC; --order descending as per question
*/

/* Part C: Q5 
SELECT EmailAddress, Orders.OrderID, SUM((ItemPrice - DiscountAmount) * Quantity) AS OrderTotal --select columns as per question
FROM Customers JOIN Orders --join customers to orders so that we can then join orders to orderitems
ON Customers.CustomerID = Orders.CustomerID --join on PK customerID
JOIN OrderItems --then we can join orders and orderitems to combine with customers
ON Orders.OrderID = OrderItems.OrderID --join on PK orderID
GROUP BY EmailAddress, Orders.OrderID --group by email and orders as per question and to avoid duplicates

SELECT SelectOrders.EmailAddress, MAX(SelectOrders.OrderTotal) AS LargestOrder --select columns, but use table alias for select inside of this select
FROM( --select within select
SELECT EmailAddress, Orders.OrderID, SUM((ItemPrice - DiscountAmount) * Quantity) AS OrderTotal --select columns as per question
FROM Customers JOIN Orders --join customers to orders so that we can then join orders to orderitems
ON Customers.CustomerID = Orders.CustomerID --join on PK customerID
JOIN OrderItems --then we can join orders and orderitems to combine with customers
ON Orders.OrderID = OrderItems.OrderID --join on PK orderID
GROUP BY EmailAddress, Orders.OrderID --group by email and orders as per question and to avoid duplicates
) AS SelectOrders --set table alias 
GROUP BY SelectOrders.EmailAddress --group by email as per question
*/

/* Part C: Q6 
SELECT EmailAddress, OrderID, OrderDate --select columns as per question
FROM Customers JOIN Orders --join customers and orders
ON Customers.CustomerID = Orders.CustomerID --on PK customer id
WHERE OrderDate = --start subquery to get newest order date
(SELECT MIN(OrderDate) --select min (newest) order date
FROM Orders --from orders table
WHERE Customers.CustomerID = Orders.CustomerID) --where subquery ID is the same as main query ID
*/

/* Part C: Q7
SELECT ListPrice, CAST(ListPrice AS char) AS Price2Decimals, --selects list price, casts list price to char so that it has 2 digits to right of decimal
CAST(ListPrice AS real) AS PriceReal, CONVERT(int, ListPrice) AS PriceInteger --casts list price to real number, converts list price to int datatype
FROM Products --from table
*/

/* Part C: Q8 
SELECT CardNumber, LEN(CardNumber) AS LengthCardNumber, RIGHT(CardNumber, 6) AS Right6CardNumber, --selects card number, length of card number, last 6 digits of card number
('XXX-XXXX-XX' + Right(CardNumber, 6)) AS XFormatCardNumber --selects card number with format as per question
FROM Orders --from table
*/

/* Part C: Q9 
SELECT OrderID, OrderDate, --select columns
DATEADD(month, 1, OrderDate) AS ApproxShipDate, ShipDate, --add one month to order date, select ship date
DATEDIFF(day, OrderDate, ShipDate) AS DaysToShip --find difference between order and ship date (days)
FROM Orders --from table
WHERE MONTH(OrderDate) = '04' AND YEAR(OrderDate) = '2016' --filter where month of order date is april and year is 2016
*/

/* Part C: Q10 
INSERT INTO Customers(EmailAddress, Password, FirstName, LastName) --insert statement showing which columns will receive new values
VALUES ('kriegerrobert@gmail.com', '', 'Krieger', 'Robert') --insert the values

SELECT * --select all
FROM Customers --from table we just edited
WHERE EmailAddress = 'kriegerrobert@gmail.com' --check to make sure was inserted by targeting email
*/

/* Part C: Q11 
UPDATE Customers --update table
SET Password = 'secret@1234' --change password to what question stated
WHERE EmailAddress = 'kriegerrobert@gmail.com' --where email is this

SELECT * --select all
FROM Customers --from table we just edited
WHERE EmailAddress = 'kriegerrobert@gmail.com' --check to make sure was inserted by targeting email
*/

/* Part D: Q1 
CREATE VIEW OrderItemProductsDetails --create view
AS
SELECT o.OrderID, o.OrderDate, o.TaxAmount, o.ShipDate, --select columns with alias so no crossing tables
oi.ItemPrice, oi.DiscountAmount, (oi.ItemPrice - oi.DiscountAmount) AS FinalPrice, --select columns with alias so no crossing tables
oi.Quantity, (oi.Quantity * (oi.ItemPrice - oi.DiscountAmount)) AS ItemTotal, --select columns with alias so no crossing tables
p.ProductName, p.Description --select columns with alias so no crossing tables
FROM Orders o, OrderItems oi, Products p --from tables
WHERE o.OrderID = oi.OrderID AND oi.ProductID = p.ProductID; --match/join tables

SELECT * --select all
FROM OrderItemProductsDetails --from view
*/

/* Part D: Q2 
CREATE VIEW Top5BestSelling --create view
AS
SELECT TOP 5 ProductName, SUM((ItemPrice - DiscountAmount) * Quantity) AS OrderTotal, COUNT(OrderID) AS OrderCount --selects top 5 of these columns
FROM Products, OrderItems --from these tables
WHERE Products.ProductID = OrderItems.ProductID --join tables
GROUP BY ProductName --group by to prevent duplicates

SELECT * --select all
FROM Top5BestSelling --from view
*/

/*Part D: Q3
CREATE PROC spUpdateProductDiscount --create procedure with name specified in question
@ProductID int, --define product int variable
@UpdateDiscountPercent money -- define temp var for new discount 
AS
IF @UpdateDiscountPercent < 0 --if var is negative 
	THROW 50001, 'The discount percent cannot be a negative number', 1; --print error
UPDATE Products --update table
SET DiscountPercent = @UpdateDiscountPercent --set old percent to new percent
WHERE ProductID = @ProductID; --where product id in new table is product id in temp table
GO --run

EXEC spUpdateProductDiscount 1, -50; --test to see if gives error message
GO

EXEC spUpdateProductDiscount 1, 50; --updates productID 1 to 50 discount percent
GO

SELECT ProductID, ProductName, DiscountPercent --shows update
FROM Products
*/

/* Part D: Q4 */
DECLARE @num1 int = 15 --declare first int
DECLARE @num2 int = 30 --declare second int
DECLARE @count int = 1 --counter

WHILE @count <= @num1 --while count is less than or equal to first num
BEGIN --start
IF (@num1 % @count = 0 AND @num2 % @count = 0) --find common factors using mod as per question
PRINT 'Common Factors of 15 and 30: ' +  CONVERT(varchar, @count) --print string and convert datatype to varchar
SET @count = @count + 1 --incriment count to avoid infinite loop
END

/* Part D: Q5 
CREATE FUNCTION fnDiscountPrice --create function
	(@ItemID int) --define variable
RETURNS money --return money datatype
BEGIN
	RETURN (SELECT SUM(ItemPrice - DiscountAmount) AS DiscountPriceOfItem --return a select that gives us the discount price of the item
	FROM OrderItems --from table
	WHERE ItemID = @ItemID); --temp table matches original ID
END;

PRINT 'Discount Price is $' + CONVERT(varchar, dbo.fnDiscountPrice(5)); --test

CREATE FUNCTION fnItemTotal --create function
	(@ItemID int) --define variable
RETURNS money --returns datatype money 
BEGIN
	RETURN (SELECT SUM(dbo.fnDiscountPrice(@ItemID) * Quantity) --returns a select sum of the discount price of the specified itemID times the quantity
	FROM OrderItems --pulls from table
	WHERE ItemID = @ItemID); --temp table matches original ID
END;

PRINT 'Item Price is $' + CONVERT(varchar, dbo.fnItemTotal(5)); --test
*/

