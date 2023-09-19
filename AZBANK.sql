create database AZBank
go
use AZBank
go
-- Create the Customer table
CREATE TABLE Customer (
    CustomerId int PRIMARY KEY,
    Name nvarchar(50),
    City nvarchar(50),
    Country nvarchar(50),
    Phone nvarchar(15),
    Email nvarchar(50)
);
go
-- Create the CustomerAccount table
CREATE TABLE CustomerAccount (
    AccountNumber char(9) PRIMARY KEY,
    CustomerId int not null,
    Balance money not null,
    MinAccount money,
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);
go
-- Create the CustomerTransaction table
CREATE TABLE CustomerTransaction (
    TransactionId int PRIMARY KEY,
    AccountNumber char(9),
    TransactionDate smalldatetime,
    Amount money,
    DepositorWithdraw bit,
    FOREIGN KEY (AccountNumber) REFERENCES CustomerAccount(AccountNumber)
);
go


-- Insert into Customer table
INSERT INTO Customer (CustomerId, Name, City, Country, Phone, Email)
VALUES (1, 'John', 'Hanoi', 'Vietnam', '123456789', 'john.doe@example.com'),
       (2, 'Jane', 'Hanoi', 'Vietnam', '987654321', 'jane.smith@example.com'),
       (3, 'David', 'Ho Chi Minh City', 'Vietnam', '555555555', 'david.johnson@example.com');
go
-- Insert into CustomerAccount table
INSERT INTO CustomerAccount (AccountNumber, CustomerId, Balance, MinAccount)
VALUES ('123456789', 1, 1000, 500),
       ('987654321', 2, 2000, 1000),
       ('555555555', 3, 3000, 1500);
go
-- Insert into CustomerTransaction table
INSERT INTO CustomerTransaction (TransactionId, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
VALUES (1, '123456789', '2023-09-19', 500, 0),
       (2, '987654321', '2023-09-18', 1000, 1),
       (3, '555555555', '2023-09-17', 1500, 0);
go



SELECT *
FROM Customer
WHERE City = 'Hanoi';
go
SELECT c.Name, c.Phone, c.Email, ca.AccountNumber, ca.Balance
FROM Customer c
JOIN CustomerAccount ca ON c.CustomerId = ca.CustomerId;
go
ALTER TABLE CustomerTransaction
ADD CONSTRAINT CHK_Amount CHECK (Amount >= 0 AND Amount <= 1000000);
go
CREATE VIEW vCustomerTransactions AS
SELECT c.Name, ca.AccountNumber, ct.TransactionDate, ct.Amount, ct.DepositorWithdraw
FROM Customer c
JOIN CustomerAccount ca ON c.CustomerId = ca.CustomerId
JOIN CustomerTransaction ct ON ca.AccountNumber = ct.AccountNumber;
go

