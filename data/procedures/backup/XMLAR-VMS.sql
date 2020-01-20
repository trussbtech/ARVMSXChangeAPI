
-- =============================================
-- Author:		Tyrone Russ
-- Create date: 01/15/2019
-- Create testing table to store imported data
USE ARDATA
GO

CREATE TABLE CompanyTest (
	CompanyID INTEGER  NOT NULL,
    Name VARCHAR(100) NOT NULL,
    LedalName VARCHAR(100) NULL,
    TaxID  VARCHAR(100) NOT NULL,
    DateIncorporation DATE NOT NULL,
 CONSTRAINT [Company_PK] PRIMARY KEY ([CompanyID])
)

-- Importing the XML data file into a SQL Server Table
--
INSERT INTO CompanyTest (CompanyID, Name, LedalName, TaxID, DateIncorporation)
SELECT
   MY_XML.query('AssociationID').value('.', 'INTEGER'),
   MY_XML.query('Name').value('.', 'VARCHAR(100)'),
   MY_XML.query('LegalName').value('.', 'VARCHAR(50)'),
   MY_XML.query('TaxID').value('.', 'VARCHAR(50)'),
   MY_XML.query('DateIncorporation').value('.', 'DATE')  
FROM (SELECT CAST(MY_XML As xml)
      FROM OPENROWSET(BULK 'C:\Users\tyron\AppData\Local\Temp\VMS\temp63714617800830.9.xml', SINGLE_BLOB) As T(MY_XML)) As T(MY_XML)
      CROSS APPLY MY_XML.nodes('Association/Association') As MY_XML (Association);
	  