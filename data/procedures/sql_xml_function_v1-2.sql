USE OPENXMLTesting
GO

INSERT INTO XMLwithOpenXML(XMLData, LoadedDateTime)
SELECT CONVERT(XML, BulkColumn) AS BulkColumn, GETDATE() 
FROM OPENROWSET(BULK 'C:/arvms-xml/AssociationsCommunities.xml', SINGLE_BLOB) AS x;

DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR (MAX)

SELECT @XML = XMLData FROM XMLwithOpenXML

EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML

SELECT AssociationID, Name, LegalName, TaxID, DateIncorporation
FROM OPENXML(@hDoc, 'ROOT/Association/AssociationAddress')
WITH 
(
AssociationID Integer '@AssociationID',
Name varchar(100) '@Name',
LegalName varchar(50) '@LegalName',
TaxID varchar(50) '@TaxID',
DateIncorporation date '@DateIncorporation'
)

SELECT * FROM XMLwithOpenXML

EXEC sp_xml_removedocument @hDoc

