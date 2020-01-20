SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tyrone Russ
-- Create date: 01/15/2019
-- Create testing table to store imported data
USE mssqltips_db
GO

CREATE TABLE [Company](
	[CompanyID] INTEGER  NOT NULL,
    [Name] [VARCHAR(100) NULL,
    [LedalName] [VARCHAR(100) NULL,
    [TaxID] [varchar](50) NOT NULL,
    [DateIncorporation] [DATE](50) NOT NULL,
 CONSTRAINT [Company_PK] PRIMARY KEY ([Id])
)

-- Importing the XML data file into a SQL Server Table
--
INSERT INTO Company (DOCUMENT, NAME, ADDRESS, PROFESSION)
SELECT
   MY_XML.Customer.query('AssociationID').value('.', 'INTEGER'),
   MY_XML.Customer.query('Name').value('.', 'VARCHAR(100)'),
   MY_XML.Customer.query('LegalName').value('.', 'VARCHAR(50)'),
   MY_XML.Customer.query('TaxID').value('.', 'VARCHAR(50)')
   MY_XML.Customer.query('DateIncorporation').value('.', 'DATE')   
FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'C:\Users\tyron\AppData\Local\Temp\VMS\temp63714617800830.9.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('Association/Association') AS MY_XML (Association);
	  
	
INSERT INTO Company (DOCUMENT, NAME, ADDRESS, PROFESSION)
SELECT
   MY_XML.Customer.query('AssociationID').value('.', 'INTEGER'),
   MY_XML.Customer.query('Name').value('.', 'VARCHAR(100)'),
   MY_XML.Customer.query('LegalName').value('.', 'VARCHAR(50)'),
   MY_XML.Customer.query('TaxID').value('.', 'VARCHAR(50)')
   MY_XML.Customer.query('DateIncorporation').value('.', 'DATE')   
FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'C:\Users\tyron\AppData\Local\Temp\VMS\temp63714617800830.9.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('Association/Association') AS MY_XML (Association);
	  
	INSERT INTO Company (DOCUMENT, NAME, ADDRESS, PROFESSION)
SELECT
   MY_XML.Customer.query('AssociationID').value('.', 'INTEGER'),
   MY_XML.Customer.query('Name').value('.', 'VARCHAR(100)'),
   MY_XML.Customer.query('LegalName').value('.', 'VARCHAR(50)'),
   MY_XML.Customer.query('TaxID').value('.', 'VARCHAR(50)')
   MY_XML.Customer.query('DateIncorporation').value('.', 'DATE')   
FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'C:\Users\tyron\AppData\Local\Temp\VMS\temp63714617800830.9.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('Association/Association') AS MY_XML (Association);
	  
	