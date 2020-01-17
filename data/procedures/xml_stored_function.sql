	  
-- =============================================
-- Author:		Tyrone Russ
-- Create date: 01/15/2019
-- Create testing table to store imported data
USE ARDATA
GO


DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR (MAX)

SELECT @XML = XMLData FROM XMLwithOpenXML

EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML

SELECT AssociationID, Name, LegalName, TaxID, DateIncorporation
FROM OPENXML(@hDoc, 'ROOT/Association/Association/AssociationAddress/AssociationAddress')
WITH 
(
AssociationID integer,
Name varchar(100),
LegalName varchar(100),
OrderID varchar(1000),
OrderDate date 
)

EXEC sp_xml_removedocument @hDoc
GO