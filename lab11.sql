/* question 1 
CREATE ROLE PaymentEntry; --creates role
GRANT UPDATE --gives update 
ON Vendors --from the vendors table
TO PaymentEntry; -- to the role
GRANT UPDATE --gives update
ON Invoices --from the invoices table
TO PaymentEntry; --to the role
GRANT UPDATE, INSERT --gives update and insert
ON InvoiceLineItems --from the invoicelineitems table
TO PaymentEntry; --to the role
GRANT SELECT --gives select on all talbes 
TO PaymentEntry; --to the role
*/
/* question 2 
CREATE LOGIN Fall2020 --creates login with name as per question
WITH PASSWORD = '123456', --sets password
DEFAULT_DATABASE = AP; --uses AP as default
CREATE USER Robert FOR LOGIN Fall2020; --create user using the login we created
ALTER ROLE PaymentEntry --alter role from q1
ADD MEMBER Robert; --add new member
*/
--SELECT * FROM syslogins
/* question 4 */
CREATE SCHEMA Jonathan; --creates schema of my name
ALTER SCHEMA Jonathan --alter
TRANSFER dbo.ContactUpdates; --transfer data into my schema
ALTER USER Robert WITH DEFAULT_SCHEMA = Admin; --alter user to make defalut admin 
GRANT SELECT, UPDATE, INSERT, DELETE, EXECUTE --all standard permissions except those specified
ON SCHEMA :: Jonathan --from this schema
TO Robert; --to this user