USE OPENXMLTesting
GO

INSERT INTO XMLwithOpenXML(XMLData, LoadedDateTime)
SELECT CONVERT(XML, BulkColumn) AS BulkColumn, GETDATE() 
FROM OPENROWSET(BULK 'C:/arvms-xml/AssociationsCommunities.xml', SINGLE_BLOB) AS x;

DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR (MAX)

SELECT @XML = XMLData FROM XMLwithOpenXML

EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML

SELECT (AssociationID, Name, LegalName, TaxID, DateIncorporation,ReferenceID.MailingName,MailingName2,
MailingSalutation, MailingAddress1, MailingAddress2, MailingCity, MailingRegion, MailingCountry,MailingPostalCode)
FROM OPENXML(@hDoc, 'ROOT/Association/Association/AssociationAddress/AssociationAddress')
WITH 
(
AssociationID Integer '@AssociationID',
Name varchar(100) '@Name',
LegalName varchar(50) '@LegalName',
TaxID varchar(50) '@TaxID',
DateIncorporation date '@DateIncorporation',
ReferenceID varchar(100) '@ReferenceID',
MailingName varchar(100) '@MailingName',
MailingName2 varchar(100) '@MailingName2',
MailingSalutation varchar(100) '@MailingSalutation',
MailingAddress1 varchar(100) '@MailingAddress1',
MailingAddress2 varchar(100) '@MailingAddress2',
MailingCity  varchar(100) '@MailingCity',
MailingRegion  varchar(100) '@MailingRegion',
MailingCountry  varchar(100) '@MailingAddress2',
MailingPostalCode  varchar(100) '@MailingPostalCode'
)

EXEC sp_xml_removedocument @hDoc
GO