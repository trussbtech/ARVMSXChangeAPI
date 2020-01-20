	  
-- =============================================
-- Author:		Tyrone Russ
-- Create date: 01/15/2019
-- Create testing table to store imported data
USE OPENXMLTesting
GO

CREATE TABLE XMLwithOpenXML
(
Id INT IDENTITY PRIMARY KEY,
XMLData XML,
LoadedDateTime DATETIME
)

DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR (MAX)

SELECT @XML = XMLData FROM XMLwithOpenXML

EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML

INSERT INTO XMLwithOpenXML(XMLData, LoadedDateTime)
SELECT CONVERT(XML, BulkColumn) AS BulkColumn, GETDATE() 
FROM OPENROWSET(BULK 'C:\temp63714617800830.9.xml', SINGLE_BLOB) AS x;

SELECT * FROM XMLwithOpenXML

EXEC sp_xml_removedocument @hDoc
GO

DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR (MAX)

SELECT @XML = XMLData FROM XMLwithOpenXML

EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML

SELECT CustomerID, CustomerName, Address, OrderID, OrderDate
FROM OPENXML(@hDoc, 'ROOT/Customers/Customer/Orders/Order')
WITH 
(
CustomerID [varchar](50) '../../@CustomerID',
CustomerName [varchar](100) '../../@CustomerName',
Address [varchar](100) '../../Address',
OrderID [varchar](1000) '@OrderID',
OrderDate datetime '@OrderDate'
)

EXEC sp_xml_removedocument @hDoc
GO