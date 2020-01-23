USE [ARDATA]
GO
/****** Object:  StoredProcedure [dbo].[usp_V0_AddUpdateCommunity]    Script Date: 1/22/2020 3:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 01/22/2020 12:26:35 PM
-- Description:	This SP Processes the community data being retrieved from the VMS API
-- =============================================

CREATE PROCEDURE [dbo].[usp_V0_AddUpdateCommunity] 

	@ClientpKey			int,
	@XMLData			XML

AS

BEGIN

--DECLARE @XMLData XML
--SET @XMLData =
--'<Root xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.villagemanagementsoftware.com/xmlvalidation/vmsproperty.xsd"><Association><AssociationID>65</AssociationID><Name>Aborgate Townhomes, HOA</Name><LegalName>Aborgate Townhomes</LegalName><TaxID>12-3456789</TaxID><DateIncorporation>2004-12-09</DateIncorporation><AssociationAddress><ReferenceID>65</ReferenceID><MailingName>Aborgate Townhomes, HOA</MailingName><MailingName2></MailingName2><MailingSalutation></MailingSalutation><MailingAddress1>6200 Falls Of Neuse Road</MailingAddress1><MailingAddress2>Building 562</MailingAddress2><MailingCity>Raleigh</MailingCity><MailingRegion>NC</MailingRegion><MailingCountry></MailingCountry><MailingPostalCode>27609</MailingPostalCode></AssociationAddress><AssociationPhone>235-548-8797</AssociationPhone><AssociationFax>Please call for information.</AssociationFax><MinimumBankBalance>500</MinimumBankBalance><Communities><Community><CommunityID>297</CommunityID><ReferenceID>65</ReferenceID><Name>Aborgate Townhomes</Name><Units>0</Units><CouponCode>FLP</CouponCode><CouponMessage>See us online at www.arborgate.com!</CouponMessage><TaxID></TaxID></Community><Community><CommunityID>625</CommunityID><ReferenceID>65</ReferenceID><Name>Single Family</Name><Units>0</Units><CouponCode>FLP</CouponCode><CouponMessage></CouponMessage><TaxID></TaxID></Community></Communities></Association><Association><AssociationID>474</AssociationID><Name>ABC Homeowners Association</Name><LegalName>ABC Homeowners Association</LegalName><TaxID>99-9999999</TaxID><DateIncorporation>2005-03-11</DateIncorporation><AssociationAddress><ReferenceID>474</ReferenceID><MailingName>ABC Homeowners Association</MailingName><MailingName2></MailingName2><MailingSalutation></MailingSalutation><MailingAddress1>12 Sample Rd.</MailingAddress1><MailingAddress2></MailingAddress2><MailingCity>Stoobenville</MailingCity><MailingRegion>CA</MailingRegion><MailingCountry></MailingCountry><MailingPostalCode>98989</MailingPostalCode></AssociationAddress><AssociationPhone>480-224-7556</AssociationPhone><AssociationFax>480-123-4567</AssociationFax><MinimumBankBalance>100</MinimumBankBalance><Communities><Community><CommunityID>789</CommunityID><ReferenceID>474</ReferenceID><Name>*** ABC Homeowners Association</Name><Units>0</Units><CouponCode>ABC</CouponCode><CouponMessage></CouponMessage><TaxID></TaxID></Community></Communities></Association><Association><AssociationID>497</AssociationID><Name>Western Shores HOA</Name><LegalName>Western Shores HOA</LegalName><TaxID>38-1717461</TaxID><DateIncorporation>2005-03-11</DateIncorporation><AssociationAddress><ReferenceID>497</ReferenceID><MailingName>Western Shores HOA</MailingName><MailingName2></MailingName2><MailingSalutation></MailingSalutation><MailingAddress1>969 Sunset Blvd</MailingAddress1><MailingAddress2>Suite 501</MailingAddress2><MailingCity>Muskegon</MailingCity><MailingRegion>MI</MailingRegion><MailingCountry></MailingCountry><MailingPostalCode>49442</MailingPostalCode></AssociationAddress><AssociationPhone>(231) 555-1919</AssociationPhone><AssociationFax>231.555.2020</AssociationFax><MinimumBankBalance>0</MinimumBankBalance><Communities><Community><CommunityID>808</CommunityID><ReferenceID>497</ReferenceID><Name>Western Shores HOA</Name><Units>0</Units><CouponCode>ABC</CouponCode><CouponMessage>This is your monthly payment coupon.  Please use it!</CouponMessage><TaxID></TaxID></Community></Communities></Association></Root>'

DECLARE @SQL                      nvarchar(1000)
DECLARE @CompanyCnt               int = 1              -- User for Company Loop
DECLARE @AssociationCnt           int = 1              -- User for Association Loop
DECLARE @PropertyCnt			  int = 1              -- User for Property Loop
DECLARE @CompanyCount             int = 1              -- Used to determine number of Companies in data 
DECLARE @AssociationCount		  int = 1              -- Used to determine number of Associations in data 
DECLARE @PropertyCount            int = 1              -- Used to determine number of Properties in data 
DECLARE @Statement                varchar(50)	= ''
DECLARE @CompanyName			  varchar(100)		   -- VMS Company Name
DECLARE @CommunityKey			  int				   -- VMS Community Key
DECLARE @CommunityName			  varchar(50)		   -- VMS Community Name
DECLARE @CommunityID			  varchar(20)		   -- VMS Community ID
DECLARE @TurnOverDate			  datetime			   -- VMS Date Incorporated
DECLARE @PhoneKey				  int = 1			   -- VMS Phone Number Key
DECLARE @PhoneNumber			  varchar(25)		   -- VMS Phone Number
DECLARE @PhoneTypeKey			  int = 1			   -- VMS Phone Type Key
DECLARE @PhoneTypeName			  varchar(50) = 'Main Number'	  -- VMS Phone Type Name
DECLARE @PhoneIsPrimary			  int = 1			   -- VMS Phone Number is Primary
DECLARE @AddressKey				  int = 1			   -- VMS Address Key
DECLARE @AddressTypeKey			  int = 1			   -- VMS Address Type Key
DECLARE @AddressTypeName		  varchar(50) = 'Main Address'   -- VMS Address Type Name
DECLARE @Address1				  varchar(50)		   -- VMS Community Address line 1
DECLARE @Address2				  varchar(50)		   -- VMS Community Address line 2
DECLARE @City					  varchar(50)		   -- VMS Community Address City
DECLARE @State					  varchar(50)		   -- VMS Community Address State
DECLARE @Zip					  varchar(10)		   -- VMS Community Address Zip
DECLARE @AddressIsPrimary		  int = 1			   -- VMS Address is Primary

SET @AssociationCount = (SELECT @XMLData.value('count(/Root/*)', 'int') AS AssociationCount)

SET @CommunityKey = (CAST(@XMLData AS XML)).value('(/Root/Association/AssociationID)[1]', 'NVARCHAR(MAX)')

WHILE @AssociationCnt < @AssociationCount +1
BEGIN
		SET @SQL = N'SELECT @CommunityKey = (CAST(@XMLData AS XML).value(''(/Root/Association/AssociationID)[' + CAST(@AssociationCnt AS varchar(2)) +']'', ''NVARCHAR(MAX)'')),
					@CommunityName = (CAST(@XMLData AS XML).value(''(/Root/Association/Name)[' + CAST(@AssociationCnt AS varchar(2)) +']'', ''NVARCHAR(MAX)'')),
					@CommunityID = (CAST(@XMLData AS XML).value(''(/Root/Association/TaxID)[' + CAST(@AssociationCnt AS varchar(2)) + ']'', ''NVARCHAR(MAX)'')),
					@TurnOverDate = (CAST(@XMLData AS XML).value(''(/Root/Association/DateIncorporation)[' + CAST(@AssociationCnt AS varchar(2)) + ']'', ''NVARCHAR(MAX)'')),
					@PhoneNumber = (CAST(@XMLData AS XML).value(''(/Root/Association/AssociationPhone)[' + CAST(@AssociationCnt AS varchar(2)) + ']'', ''NVARCHAR(MAX)'')),
					@CompanyName = CompanyName 
					FROM dbo.CompanyxRef 
					WHERE dbo.CompanyxRef.ClientpKey = @ClientpKey'

		EXECUTE sp_executesql @SQL, N'@ClientpKey int,@CompanyName varchar(100) OUTPUT,@CommunityKey int OUTPUT, @CommunityName varchar(50) OUTPUT,@CommunityID varchar(50) OUTPUT,@PhoneNumber varchar(25) OUTPUT,@TurnOverDate varchar(20) OUTPUT,@XMLData XML',@ClientpKey,@CompanyName = @CompanyName,@CommunityKey = @CommunityKey OUTPUT,@CommunityName = @CommunityName OUTPUT,@CommunityID = @CommunityID OUTPUT,@PhoneNumber = @PhoneNumber OUTPUT,@TurnOverDate = @TurnOverDate OUTPUT,@XMLData = @XMLData

		-- Process data for Community Table
		IF EXISTS (SELECT CommunityKey FROM dbo.Community WHERE ClientpKey = @ClientpKey AND CommunityKey = @CommunityKey)
		BEGIN
			SET @SQL = N'UPDATE dbo.Community  
						SET CommunityName = @CommunityName,
						ModifiedDate = GetDate()
						WHERE ClientpKey = @ClientpKey AND CommunityKey = @CommunityKey'

		END
		ELSE
		BEGIN
			SET @SQL = N'INSERT INTO dbo.Community  (ClientpKey,CommunityKey,CommunityName,CommunityID,TurnOverDate,ModifiedDate)
						SELECT @ClientpKey,@CommunityKey,@CommunityName,@CommunityID,@TurnOverDate,GetDate() AS ModifiedDate;'

		END
		EXECUTE sp_executesql @SQL, N'@ClientpKey int, @CommunityKey int,@CommunityName varchar(50),@CommunityID varchar(50),@TurnOverDate varchar(20)',@ClientpKey,@CommunityKey,@CommunityName,@CommunityID,@TurnOverDate

		-- Process data for CompanyCommunity Table
		IF EXISTS (SELECT CommunityKey FROM dbo.CompanyCommunity WHERE ClientpKey = @ClientpKey AND CommunityKey = @CommunityKey)
		BEGIN
			SET @SQL = N'UPDATE dbo.CompanyCommunity  
						SET CommunityName = @CommunityName,
						ModifiedDate = GetDate()
						WHERE ClientpKey = @ClientpKey AND CommunityKey = @CommunityKey'
			--SELECT @SQL AS UPDATESTATEMENT
		END
		ELSE
		BEGIN
			SET @SQL = N'INSERT INTO dbo.CompanyCommunity  (ClientpKey,Active,CommunityID,CommunityKey,CommunityName,CompanyName,ModifiedDate)
						SELECT @ClientpKey,1,@CommunityID,@CommunityKey,@CommunityName,@CompanyName,GetDate() AS ModifiedDate;'
			--SELECT @SQL AS INSERTSTATEMENT
		END
		EXECUTE sp_executesql @SQL, N'@ClientpKey int, @CommunityID varchar(50),@CommunityKey int,@CommunityName varchar(50),@CompanyName varchar(100)',@ClientpKey,@CommunityID,@CommunityKey,@CommunityName,@TurnOverDate

		-- Process data for Community Phones
		IF EXISTS (SELECT PhoneKey FROM dbo.CommunityPhones WHERE ClientpKey = @ClientpKey AND CommunityKey = @CommunityKey AND PhoneKey = @PhoneKey)
		BEGIN
			SET @SQL = N'UPDATE dbo.CommunityPhones  
						SET PhoneNumber = @PhoneNumber,
						ModifiedDate = GetDate()
						WHERE ClientpKey = @ClientpKey AND CommunityKey = @CommunityKey AND PhoneKey = @PhoneKey'
			--SELECT @SQL AS UPDATESTATEMENT
		END
		ELSE
		BEGIN
			SET @SQL = N'INSERT INTO dbo.CommunityPhones  (ClientpKey,CommunityKey,PhoneKey,PhoneTypeKey,PhoneTypeName,PhoneNumber,IsPrimary,ModifiedDate)
						SELECT @ClientpKey,@CommunityKey,@PhoneKey,@PhoneTypeKey,@PhoneTypeName,@PhoneIsPrimary,GetDate() AS ModifiedDate;'
			--SELECT @SQL AS INSERTSTATEMENT
		END
		EXECUTE sp_executesql @SQL, N'@ClientpKey int,@CommunityKey int,@PhoneKey int,@PhoneTypeKey int,@PhoneTypeName varchar(50),@PhoneNumber varchar(25),@PhoneIsPrimary int',@ClientpKey,@CommunityKey,@PhoneKey,@PhoneTypeKey,@PhoneTypeName,@PhoneNumber,@PhoneIsPrimary

		-- Process data for Community Address
		SET @SQL = N'SELECT @Address1 = (CAST(@XMLData AS XML).value(''(/Root/Association/AssociationAddress/MailingAddress1)[' + CAST(@AssociationCnt AS varchar(2)) +']'', ''NVARCHAR(MAX)'')),
					@Address2 = (CAST(@XMLData AS XML).value(''(/Root/Association/AssociationAddress/MailingAddress2)[' + CAST(@AssociationCnt AS varchar(2)) +']'', ''NVARCHAR(MAX)'')),
					@City = (CAST(@XMLData AS XML).value(''(/Root/Association/AssociationAddress/MailingCity)[' + CAST(@AssociationCnt AS varchar(2)) + ']'', ''NVARCHAR(MAX)'')),
					@State = (CAST(@XMLData AS XML).value(''(/Root/Association/AssociationAddress/MailingState)[' + CAST(@AssociationCnt AS varchar(2)) + ']'', ''NVARCHAR(MAX)'')),
					@Zip = (CAST(@XMLData AS XML).value(''(/Root/Association/AssociationAddress/MailingZip)[' + CAST(@AssociationCnt AS varchar(2)) + ']'', ''NVARCHAR(MAX)''))'
		--SELECT @SQL AS GETNEXT
		EXECUTE sp_executesql @SQL, N'@Address1 varchar(50) OUTPUT,@Address2 varchar(50) OUTPUT,@City varchar(50) OUTPUT,@State varchar(50) OUTPUT,@Zip varchar(10) OUTPUT,@XMLData XML',@Address1 = @Address1 OUTPUT,@Address2 = @Address2 OUTPUT,@City = @City OUTPUT,@State = @State OUTPUT,@Zip = @Zip OUTPUT,@XMLData = @XMLData
		--SELECT @CommunityKey AS ThisKey

		IF EXISTS (SELECT AddressKey FROM dbo.CommunityAddress WHERE ClientpKey = @ClientpKey AND CommunityKey = @CommunityKey AND AddressKey = @AddressKey)
		BEGIN
			SET @SQL = N'UPDATE dbo.CommunityAddress 
						SET Address1 = @Address1,Address2 = @Address2,City = @City,State = @State,Zip = @Zip,
						ModifiedDate = GetDate()
						WHERE ClientpKey = @ClientpKey AND CommunityKey = @CommunityKey AND AddressKey = @AddressKey'
			--SELECT @SQL AS UPDATESTATEMENT
		END
		ELSE
		BEGIN
			SET @SQL = N'INSERT INTO dbo.CommunityAddress  (ClientpKey,CommunityKey,AddressKey,AddressTypeKey,AddressTypeName,Address1,Address2,City,State,Zip,IsPrimary,ModifiedDate)
						SELECT @ClientpKey,@CommunityKey,@AddressKey,@AddressTypeKey,@AddressTypeName,@Address1,@Address2,@City,@State,@Zip,@AddressIsPrimary,GetDate() AS ModifiedDate;'
			--SELECT @SQL AS INSERTSTATEMENT
		END
		EXECUTE sp_executesql @SQL, N'@ClientpKey int,@CommunityKey int,@AddressKey int,@AddressTypeKey int,@AddressTypeName varchar(50),@Address1 varchar(50),@Address2 varchar(50),@City varchar(50),@State varchar(50),@Zip varchar(10),@AddressIsPrimary int',@ClientpKey,@CommunityKey,@AddressKey,@AddressTypeKey,@AddressTypeName,@Address1,@Address2,@City,@State,@Zip,@AddressIsPrimary
				
		SET @AssociationCnt = @AssociationCnt + 1
END

END