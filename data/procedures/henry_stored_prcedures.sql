
-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies address data in Community Address table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateCommunityBAddress] 

	@ClientpKey			int,
	@CommunityID		varchar(50),
	@CommunityKey		varchar(50),
	@AddressTypeName	varchar(50),
	@Address1			varchar(50),
	@Address2			varchar(50),
	@City				varchar(50),
	@State				varchar(50),
	@Zip				varchar(10),
	@IsPrimary			bit,
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		SET @IsPrimary	= 1
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()
		--DECLARE @ClientpKey int = (SELECT ClientpKey FROM dbo.CompanyCommunity WHERE dbo.CompanyCommunity.CommunityID = @CommunityID AND dbo.CompanyCommunity.CommunityKey = @CommunityKey) 

		--  The community key and ID were supplied and use it to qualify the company
		IF exists (SELECT 1 from dbo.CommunityAddress WHERE [ClientpKey] = @ClientpKey  AND [CommunityKey] = @CommunityKey AND [AddressTypeName] = @AddressTypeName)
		
		BEGIN
		--	UPDATE EXISTING CommunityAddress in dbo.CommunityAddress 
			UPDATE dbo.CommunityAddress SET [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [Zip] = @Zip WHERE [ClientpKey] = @ClientpKey AND [CommunityKey] = @CommunityKey AND [AddressTypeName] = @AddressTypeName AND [ModifiedDate] < @modDate
			SELECT 1 AS "retVal"
		END
		ELSE
		BEGIN
		--	INSERT NEW Community Address INTO dbo.CommunityAddress 
			INSERT INTO dbo.CommunityAddress ([ClientpKey],[CommunityKey],[AddressTypeName],[Address1],[Address2],[City],[State],[Zip],[IsPrimary],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@AddressTypeName,@Address1,@Address2,@City,@State,@Zip,@IsPrimary,@modDate)
			SELECT 1 AS "retVal"
		END
		
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateCommunityFax]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies Phone data in Community Phone table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateCommunityFax] 

	@ClientpKey			int,
	@CommunityKey		varchar(50),
	@CommunityID		varchar(50),
	@PhoneTypeName		varchar(50),
	@IsPrimary			bit,
	@PhoneNumber		varchar(20),
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()


		IF exists (SELECT 1 from dbo.CommunityPhones WHERE [ClientpKey] = @ClientpKey  AND [CommunityKey] = @CommunityKey AND [PhoneTypeName] = @PhoneTypeName)
		BEGIN
		--	UPDATE EXISTING CommunityFax in dbo.CommunityFax 
			UPDATE dbo.CommunityPhones SET [PhoneTypeName] = @PhoneTypeName, [PhoneNumber] = @PhoneNumber, [ModifiedDate] = @modDate WHERE ClientpKey = @ClientpKey AND [CommunityKey] = @CommunityKey AND [PhoneTypeName] = @PhoneTypeName AND [ModifiedDate] < @modDate
			SELECT 1 AS "retVal"
		END
		ELSE
		BEGIN
		--	INSERT NEW Community Phone INTO dbo.CommunityFax 
			INSERT INTO dbo.CommunityPhones ([ClientpKey],[CommunityKey],[PhoneTypeName],[IsPrimary],[PhoneNumber],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@PhoneTypeName,@IsPrimary,@PhoneNumber,@modDate)
			SELECT 1 AS "retVal"
		END		
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateCommunityLinks]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies address data in Community table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateCommunityLinks] 

	@ClientpKey			int,
	@CommunityKey		int,
	@CommunityID		varchar(20),
	@LinkRelation		varchar(20),
	@LinkURL			varchar(50),
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()

		If NOT EXISTS (SELECT 1 FROM dbo.CommunityLinks WHERE [ClientpKey] = @ClientpKey AND CommunityKey = @CommunityKey AND [CommunityID] = @CommunityID AND [LinkURL] = @LinkURL)
		BEGIN
		--	Insert all new Community Links for this Community 

			INSERT INTO dbo.CommunityLinks ([ClientpKey],[CommunityKey],[COmmunityID],[LinkRelation],[LinkURL],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@CommunityID,@LinkRelation,@LinkURL,@modDate)
		END
		SELECT 1 AS "retVal"
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateCommunityOAddress]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies address data in Community Address table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateCommunityOAddress] 

	@ClientpKey			int,
	@CommunityID		varchar(50),
	@CommunityKey		varchar(50),
	@AddressTypeName	varchar(50),
	@Address1			varchar(50),
	@Address2			varchar(50),
	@City				varchar(50),
	@State				varchar(50),
	@Zip				varchar(10),
	@IsPrimary			bit,
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		SET @IsPrimary	= 1
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()
		--DECLARE @ClientpKey int = (SELECT ClientpKey FROM dbo.CompanyCommunity WHERE dbo.CompanyCommunity.CommunityID = @CommunityID AND dbo.CompanyCommunity.CommunityKey = @CommunityKey) 

		--  The community key and ID were supplied and use it to qualify the company
		IF exists (SELECT 1 from dbo.CommunityAddress WHERE [ClientpKey] = @ClientpKey  AND [CommunityKey] = @CommunityKey AND [AddressTypeName] = @AddressTypeName)
		
		BEGIN
		--	UPDATE EXISTING CommunityAddress in dbo.CommunityAddress 
			UPDATE dbo.CommunityAddress SET [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [Zip] = @Zip WHERE [ClientpKey] = @ClientpKey AND [CommunityKey] = @CommunityKey AND [AddressTypeName] = @AddressTypeName AND [ModifiedDate] < @modDate
			SELECT 1 AS "retVal"
		END
		ELSE
		BEGIN
		--	INSERT NEW Community Address INTO dbo.CommunityAddress 
			INSERT INTO dbo.CommunityAddress ([ClientpKey],[CommunityKey],[AddressTypeName],[Address1],[Address2],[City],[State],[Zip],[IsPrimary],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@AddressTypeName,@Address1,@Address2,@City,@State,@Zip,@IsPrimary,@modDate)
			SELECT 1 AS "retVal"
		END
		
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateCommunityPhone]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies Phone data in Community Phone table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateCommunityPhone] 

	@ClientpKey			int,
	@CommunityKey		varchar(50),
	@CommunityID		varchar(50),
	@PhoneTypeName		varchar(50),
	@IsPrimary			bit,
	@PhoneNumber		varchar(20),
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()


		IF exists (SELECT 1 from dbo.CommunityPhones WHERE [ClientpKey] = @ClientpKey  AND [CommunityKey] = @CommunityKey AND [PhoneTypeName] = @PhoneTypeName)
		BEGIN
		--	UPDATE EXISTING CommunityPhone in dbo.CommunityPhone 
			UPDATE dbo.CommunityPhones SET [PhoneTypeName] = @PhoneTypeName, [PhoneNumber] = @PhoneNumber, [ModifiedDate] = @modDate WHERE ClientpKey = @ClientpKey AND [CommunityKey] = @CommunityKey AND [PhoneTypeName] = @PhoneTypeName AND [ModifiedDate] < @modDate
			SELECT 1 AS "retVal"
		END
		ELSE
		BEGIN
		--	INSERT NEW Community Phone INTO dbo.CommunityPhone 
			INSERT INTO dbo.CommunityPhones ([ClientpKey],[CommunityKey],[PhoneTypeName],[IsPrimary],[PhoneNumber],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@PhoneTypeName,@IsPrimary,@PhoneNumber,@modDate)
			SELECT 1 AS "retVal"
		END		
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateCommunityRecord]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP adds/Modifies data in Community table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateCommunityRecord] 

	@ClientpKey			int,
	@CommunityKey		varchar(50),
	@CommunityID		varchar(50),
	@CommunityName		varchar(50),
	@ClientType			varchar(50),
	@WebSite			varchar(50),
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate	datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()

		--  The Community ID is used it to qualify the community

		IF exists (SELECT 1 from dbo.Community WHERE [CommunityKey] = @CommunityKey AND [CommunityID] = @CommunityID AND [ClientpKey] = @ClientpKey)
		
			BEGIN
				--	UPDATE EXISTING Community in dbo.Community
				UPDATE dbo.Community SET [CommunityName] = @CommunityName,[AssociationType] = @ClientType,[WebAddress] = @WebSite,[ModifiedDate] = @modDate WHERE [CommunityKey] = @CommunityKey AND [CommunityID] = @CommunityID AND [ClientpKey] = @ClientpKey AND [ModifiedDate] < @modDate
				SELECT 1 AS "retVal";
			END
			ELSE
			BEGIN
				--	INSERT NEW Community INTO dbo.Community 
				INSERT INTO dbo.Community ([CommunityKey],[ClientpKey],[CommunityID],[CommunityName],[AssociationType],[WebAddress],[ModifiedDate]) VALUES(@CommunityKey,@ClientpKey,@CommunityID,@CommunityName,@ClientType,@WebSite,@modDate)
				SELECT 1 AS "retVal";
			END
	END TRY
	BEGIN CATCH  --  The script encountered and error and was not successful
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateCompanyAddress]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies address data in Community Address table
-- =============================================
Create PROCEDURE [dbo].[usp_C0_AddUpdateCompanyAddress] 

	@ClientpKey			int,
	@AddressTypeName	varchar(50),
	@Address1			varchar(50),
	@Address2			varchar(50),
	@City				varchar(50),
	@State				varchar(50),
	@Zip				varchar(10),
	@IsPrimary			bit,
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		SET @IsPrimary	= 1
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()
		
		--  The compnay key and ID were supplied and use it to qualify the company
		IF exists (SELECT 1 from dbo.CompanyAddress WHERE [ClientpKey] = @ClientpKey  AND [AddressTypeName] = @AddressTypeName)
		
		BEGIN
		--	UPDATE EXISTING CompanyAddress in dbo.CommunityAddress 
			UPDATE dbo.CompanyAddress SET [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [Zip] = @Zip WHERE [ClientpKey] = @ClientpKey AND [AddressTypeName] = @AddressTypeName AND [ModifiedDate] < @modDate
			SELECT 1 AS "retVal"
		END
		ELSE
		BEGIN
		--	INSERT NEW Company Address INTO dbo.CommunityAddress 
			INSERT INTO dbo.CompanyAddress ([ClientpKey],[AddressTypeName],[Address1],[Address2],[City],[State],[Zip],[IsPrimary],[ModifiedDate]) VALUES(@ClientpKey,@AddressTypeName,@Address1,@Address2,@City,@State,@Zip,@IsPrimary,@modDate)
			SELECT 1 AS "retVal"
		END
		
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateCompanyCommunityRecord]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 03/09/2017 12:26:35 PM
-- Description:	This SP adds/Modifies data in Company Community cross reference table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateCompanyCommunityRecord] 

	@ClientpKey			int,
	@Active				varchar(20),
	@CommunityID		varchar(20),
	@CommunityKey		int,
	@CommunityName		varchar(100),
	@ModifiedDate 		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate	datetime
		DECLARE @Status		int
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @Active = 'Active' SET @Status = 1 ELSE SET @Status = 0
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()
	    DECLARE @CompanyName varchar(100) = (SELECT [CompanyName] FROM dbo.CompanyxRef WHERE dbo.CompanyxRef.InterfacePartner = 'Caliber' AND Active = 1 AND ClientpKey = @ClientpKey)

		--  The client Name is used to qualify the company

		IF exists (SELECT 1 from dbo.CompanyCommunity WHERE	[ClientpKey] = @ClientpKey AND [CommunityKey] = @CommunityKey)

			BEGIN
				--	UPDATE EXISTING CompanyCommunity cross reference in dbo.CompanyCommunity 
				UPDATE dbo.CompanyCommunity SET [Active] = @Status, [CommunityName] = @CommunityName, [ModifiedDate] = @modDate WHERE [ClientpKey] = @ClientpKey AND [CommunityKey] = @CommunityKey AND [ModifiedDate] < @modDate
				SELECT 1 AS "retVal";
			END
			ELSE
			BEGIN
				--	INSERT NEW CompanyCommunity cross reference in dbo.CompanyCommunity
				INSERT INTO dbo.CompanyCommunity ([ClientpKey],[Active],[CommunityID],[CommunityKey],[CommunityName],[CompanyName],[ModifiedDate]) VALUES(@ClientpKey,@Status,@CommunityID,@CommunityKey,@CommunityName,@CompanyName,@modDate);					
				SELECT 1 AS "retVal";
			END
	END TRY
	BEGIN CATCH  --  The script encountered and error and was not successful
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateCompanyFax]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies Phone data in Community Phone table
-- =============================================
Create PROCEDURE [dbo].[usp_C0_AddUpdateCompanyFax] 

	@ClientpKey			int,
	@PhoneTypeName		varchar(50),
	@IsPrimary			bit,
	@PhoneNumber		varchar(20),
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()


		IF exists (SELECT 1 from dbo.CompanyPhones WHERE [ClientpKey] = @ClientpKey  AND [PhoneTypeName] = @PhoneTypeName)
		BEGIN
		--	UPDATE EXISTING CommunityFax in dbo.CompanyFax 
			UPDATE dbo.CompanyPhones SET [PhoneTypeName] = @PhoneTypeName, [PhoneNumber] = @PhoneNumber, [ModifiedDate] = @modDate WHERE ClientpKey = @ClientpKey AND [PhoneTypeName] = @PhoneTypeName AND [ModifiedDate] < @modDate
			SELECT 1 AS "retVal"
		END
		ELSE
		BEGIN
		--	INSERT NEW Community Phone INTO dbo.CompanyFax 
			INSERT INTO dbo.CompanyPhones ([ClientpKey],[PhoneTypeName],[IsPrimary],[PhoneNumber],[ModifiedDate]) VALUES(@ClientpKey,@PhoneTypeName,@IsPrimary,@PhoneNumber,@modDate)
			SELECT 1 AS "retVal"
		END		
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateCompanyPhone]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies Phone data in Community Phone table
-- =============================================
Create PROCEDURE [dbo].[usp_C0_AddUpdateCompanyPhone] 

	@ClientpKey			int,
	@PhoneTypeName		varchar(50),
	@IsPrimary			bit,
	@PhoneNumber		varchar(20),
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()


		IF exists (SELECT 1 from dbo.CompanyPhones WHERE [ClientpKey] = @ClientpKey  AND [PhoneTypeName] = @PhoneTypeName)
		BEGIN
		
			UPDATE dbo.CompanyPhones SET [PhoneTypeName] = @PhoneTypeName, [PhoneNumber] = @PhoneNumber, [ModifiedDate] = @modDate WHERE ClientpKey = @ClientpKey AND [PhoneTypeName] = @PhoneTypeName AND [ModifiedDate] < @modDate
			SELECT 1 AS "retVal"
		END
		ELSE
		BEGIN
	
			INSERT INTO dbo.CompanyPhones ([ClientpKey],[PhoneTypeName],[IsPrimary],[PhoneNumber],[ModifiedDate]) VALUES(@ClientpKey,@PhoneTypeName,@IsPrimary,@PhoneNumber,@modDate)
			SELECT 1 AS "retVal"
		END		
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateCompanyRecord]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 09/14/2017 12:26:35 PM
-- Description:	This SP Adds/Modifies data in the Company table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateCompanyRecord] 

	@ClientpKey			int,
	@CompanyName		varchar(100),
	@UTCOffset			varchar(2),
	@Interfacepartner	varchar(50),
	@Interfacesystemid	varchar(50),
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate AS datetime)
		SET @UTCOffset = CAST(@UTCOffset AS Int)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()

		--  Determine if the Company record exists

		IF exists (SELECT 1 FROM dbo.Company WHERE [ClientpKey] = @ClientpKey)
		
			BEGIN
				--	UPDATE EXISTING Company in dbo.Company 
				UPDATE dbo.Company SET [Interfacesystemid] = @Interfacesystemid, UTCOffset = @UTCOffset, [ModifiedDate] = @modDate WHERE [ClientpKey] = @ClientpKey AND [ModifiedDate] < @modDate
				SELECT 1 AS "retVal";
			END
		ELSE
			BEGIN
				--	INSERT NEW Company INTO dbo.Company 
				INSERT INTO dbo.Company ([ClientpKey],[CompanyName],[Interfacepartner],[Interfacesystemid],[UtcOffset],[ModifiedDate]) VALUES(@ClientpKey,@CompanyName,@Interfacepartner,@Interfacesystemid,@UTCOffset,@modDate)
				SELECT 1 AS "retVal";
			END
	END TRY
	BEGIN CATCH  --  The script encountered and error and was not successful
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine])

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[CompanyName],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,@CompanyName,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateOwnerAddress]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies address data in Owner Address table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateOwnerAddress] 

	@ClientpKey			int,
	@CommunityKey		int,
	@OwnerKey			int,
	@Address1			varchar(50),
	@Address2			varchar(50),
	@City				varchar(50),
	@State				varchar(50),
	@Zip				varchar(10),
	@Country			varchar(50),
	@IsPrimary			bit,
	@ModifiedDate		varchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()

		DECLARE	@OwnerType	 varchar(20) = (SELECT [ResidentType] FROM dbo.Owners WHERE [ClientpKey] = @ClientpKey AND [CommunityKey] = @CommunityKey AND [OwnerKey] = @OwnerKey)

		IF exists (SELECT 1 from dbo.OwnerAddress WHERE [ClientpKey] = @ClientpKey AND [CommunityKey] = @CommunityKey AND [OwnerKey] = @OwnerKey  AND [OwnerType] = @OwnerType)
		BEGIN
		--	UPDATE EXISTING OwnerAddress in dbo.OwnerAddress 
			UPDATE dbo.OwnerAddress SET  [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [Zip] = @Zip, [Country] = @Country, [ModifiedDate] = @ModifiedDate, [IsPrimary] = @IsPrimary WHERE [ClientpKey] = @ClientpKey AND [CommunityKey] = @CommunityKey AND [OwnerKey] = @OwnerKey AND [OwnerType] = @OwnerType
		END
		ELSE
		BEGIN
		--	INSERT NEW Owner Address INTO dbo.OwnerAddress 
			INSERT INTO dbo.OwnerAddress ([ClientpKey],[CommunityKey],[OwnerKey],[OwnerType],[Address1],[Address2],[City],[State],[Zip],[Country],[IsPrimary],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@OwnerKey,@OwnerType,@Address1,@Address2,@City,@State,@Zip,@Country,@IsPrimary,@modDate)
		END
		SELECT 1 AS "retVal"
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateOwnerLinks]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies address data in the Owner links table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateOwnerLinks] 

	@ClientpKey			int,
	@CommunityKey		int,
	@PropertyKey		int,
	@OwnerKey			int,
	@LinkRelation		varchar(20),
	@LinkURL			varchar(50),
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()

		If not exists (SELECT 1 FROM dbo.OwnerLinks WHERE [ClientpKey] = @ClientpKey AND CommunityKey = @CommunityKey AND [PropertyKey] = @PropertyKey AND [OwnerKey] = @OwnerKey AND [LinkURL] = @LinkURL)
		BEGIN
		--	Insert links that do not exist in Owner links 

			INSERT INTO dbo.OwnerLinks ([ClientpKey],[CommunityKey],[OwnerKey],[PropertyKey],[LinkRelation],[LinkURL],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@OwnerKey,@PropertyKey,@LinkRelation,@LinkURL,@modDate)

		END
		SELECT 1 AS "retVal"
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateOwnerPhone]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies Phone data in Owner table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateOwnerPhone] 

	@ClientpKey			int,
	@CommunityKey		int,
	@OwnerKey			varchar(50),
	@PhoneKey			int,
	@PhoneTypeKey		varchar(50),
	@PhoneTypeName		varchar(50),
	@IsPrimary			bit,
	@AreaCode			varchar(20),
	@PhoneNumber		varchar(20),
	@ModifiedDate		varchar(50)
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()
		SET @PhoneNumber = @AreaCode + '-' + @PhoneNumber

		IF exists (SELECT 1 from dbo.OwnerPhones WHERE [ClientpKey] = @ClientpKey AND [OwnerKey] = @OwnerKey AND [CommunityKey] = @CommunityKey)
		BEGIN
		--	UPDATE EXISTING OwnerPhone in dbo.OwnerPhone 
			UPDATE dbo.OwnerPhones SET [PhoneTypeKey] = @PhoneTypeKey, [PhoneTypeName] = @PhoneTypeName, [IsPrimary]  = @IsPrimary, [PhoneNumber] = @PhoneNumber WHERE [ClientpKey] = @ClientpKey AND [CommunityKey] = @CommunityKey AND OwnerKey = @OwnerKey AND [PhoneKey] = @PhoneKey AND [ModifiedDate] < @modDate
		END
		ELSE
		BEGIN
		--	INSERT NEW Owner Phone INTO dbo.OwnerPhone 
			INSERT INTO dbo.OwnerPhones ([ClientpKey],[CommunityKey],[OwnerKey],[PhoneKey],[PhoneTypeKey],[PhoneTypeName],[IsPrimary],[PhoneNumber],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@OwnerKey,@PhoneKey,@PhoneTypeKey,@PhoneTypeName,@IsPrimary,@PhoneNumber,@modDate)
		END
		SELECT 1 AS "retVal"
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdateOwnerRecord]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 02/21/2017 12:26:35 PM
-- Description:	This SP adds/Modifies data in Owners table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdateOwnerRecord] 
	
	@ClientpKey			int,
	@OwnerKey 			int,
	@CommunityKey 		int,
	@PropertyKey 		int,
	@FirstName			varchar(100),
	@LastName			varchar(100),
	@LegalName			varchar(200),
	@ResidentType 		varchar(20),
	@SettlementDate		varchar(20),
	@HoldPayment		varchar(10),
	@IsPrimary			bit,
	@IsPrimaryOwner		varchar(10),
	@IsOwner			varchar(10),
	@IsOccupant			varchar(10),
	@IsPrimaryOccupant	varchar(10),
	@IsRenter			varchar(10),
	@Is3rdParty			varchar(10),
	@IsCurrent			varchar(10),
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

		DECLARE @OwnerType varchar(20)
    	DECLARE @ModDate datetime

		IF 	(@FirstName = '' AND @LastName = '')  
			BEGIN
				SET @FirstName = @LegalName

			END

	    SET @ModDate = CAST(@ModifiedDate AS datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()
		
		SET @OwnerType = CASE 
			WHEN @IsPrimary = 1 THEN 'Primary' 
		ELSE	'Secondary'
		
		END
		
		SET @HoldPayment = CASE 
			WHEN @HoldPayment = 'True' THEN '1' 
		ELSE	'0'
		
		END
		
		SET @ResidentType = CASE 
			
			WHEN @Is3rdParty		= 'True' THEN '3rd Party' 
			WHEN @IsRenter			= 'True' THEN 'Renter' 
			WHEN @IsPrimaryOccupant	= 'True' THEN 'Pri Occupant' 
			WHEN @IsOccupant		= 'True' THEN 'Occupant' 
			WHEN @IsOwner			= 'True' THEN 'Owner' 

		END

		SET @IsCurrent = CASE 
			WHEN @IsCurrent = 'True' THEN '1' 
		ELSE	'0'

		END

		IF @IsCurrent = '1' UPDATE dbo.Owners SET [IsCurrent] = '0' WHERE [ClientpKey] = @ClientpKey AND [OwnerKey] = @OwnerKey AND [CommunityKey] = @CommunityKey AND [PropertyKey] = @PropertyKey
		
		IF exists (SELECT 1 from dbo.Owners WHERE [ClientpKey] = @ClientpKey AND [OwnerKey] = @OwnerKey AND [CommunityKey] = @CommunityKey AND FirstName = @FirstName AND LastName = @LastName)

		BEGIN
			UPDATE dbo.Owners SET [FirstName] = @FirstName,[LastName] = @LastName, LegalName = @LegalName,ResidentType = @ResidentType,SettlementDate = @SettlementDate, HoldPayment = @HoldPayment, IsPrimary = @IsPrimary, IsCurrent = @IsCurrent, ModifiedDate = @modDate WHERE  [ClientpKey] = @ClientpKey AND [OwnerKey] = @OwnerKey AND [CommunityKey] = @CommunityKey AND [ModifiedDate] < @modDate
			SELECT 1 as "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.Owners ([ClientpKey],[CommunityKey],[OwnerKey],[PropertyKey],[FirstName],[LastName],[LegalName],[ResidentType],[SettlementDate],[HoldPayment],[IsPrimary],[IsCurrent],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@OwnerKey,@PropertyKey,@FirstName,@LastName,@LegalName,@ResidentType,@SettlementDate,@HoldPayment,@IsPrimary,@IsCurrent,@modDate)
			SELECT 1 as "retVal"
		END
		
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
	BYPASS:
END

GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdatePropertyAddress]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies address data in Property table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdatePropertyAddress]
 
	@ClientpKey 		int,
	@CommunityKey		int,
	@PropertyKey		int,
	@AddressTypeName	varchar(50),
	@Address1			varchar(50),
	@Address2			varchar(50),
	@City				varchar(50),
	@State				varchar(50),
	@Zip				varchar(10),
	@IsPrimary			bit,
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()

		IF exists (SELECT 1 from dbo.PropertyAddress WHERE CommunityKey = @CommunityKey AND [PropertyKey] = @PropertyKey AND [ClientpKey] = @ClientpKey)

		BEGIN
		--	UPDATE EXISTING PropertyAddress in dbo.PropertyAddress 
			UPDATE dbo.PropertyAddress SET [AddressTypeName] = @AddressTypeName, [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [Zip] = @Zip, [IsPrimary]  = @IsPrimary WHERE [ClientpKey] = @ClientpKey AND CommunityKey = @CommunityKey AND PropertyKey = @PropertyKey AND ModifiedDate < @modDate
		END
		ELSE
		BEGIN
		--	INSERT NEW Property Address INTO dbo.PropertyAddress 
			INSERT INTO dbo.PropertyAddress ([ClientpKey],[CommunityKey],[PropertyKey],[AddressTypeName],[Address1],[Address2],[City],[State],[Zip],[IsPrimary],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@PropertyKey,@AddressTypeName,@Address1,@Address2,@City,@State,@Zip,@IsPrimary,@modDate)
		END
		SELECT 1 AS "retVal"
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdatePropertyLinks]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 07/13/2017 12:26:35 PM
-- Description:	This SP Modifies address data in Property table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdatePropertyLinks] 

	@ClientpKey			int,
	@PropertyKey		int,
	@CommunityKey		int,
	@LinkRelation		varchar(20),
	@LinkURL			varchar(50),
	@ModifiedDate		varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()

		If NOT EXISTS (SELECT 1 FROM dbo.PropertyLinks WHERE [ClientpKey] = @ClientpKey AND CommunityKey = @CommunityKey AND [PropertyKey] = @PropertyKey AND [LinkURL] = @LinkURL)
		BEGIN
		--	Insert all new Property Links for this property 

			INSERT INTO dbo.PropertyLinks ([ClientpKey],[CommunityKey],[PropertyKey],[LinkRelation],[LinkURL],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@PropertyKey,@LinkRelation,@LinkURL,@modDate)
		END
		SELECT 1 AS "retVal"
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_AddUpdatePropertyRecord]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 02/10/2017 12:26:35 PM
-- Description:	This SP adds/Modifies data in Property table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_AddUpdatePropertyRecord] 

	@ClientpKey			int,
	@CommunityKey		int,
	@PropertyKey		int,
	@LotUnitNumber		varchar(50),
	@ModifiedDate		varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()

		IF exists (SELECT 1 from dbo.Property WHERE [ClientpKey] = @ClientpKey AND [CommunityKey] = @CommunityKey AND [PropertyKey] = @PropertyKey AND @ClientpKey <> '0')
		BEGIN
			UPDATE dbo.Property SET [CommunityKey] = @CommunityKey, [LotUnitNumber] = @LotUnitNumber, [ModifiedDate] = @modDate WHERE [ClientpKey] = @ClientpKey AND CommunityKey = @CommunityKey AND [PropertyKey] = @PropertyKey AND ModifiedDate < @modDate
		END
		ELSE
		BEGIN
			INSERT INTO dbo.Property ([ClientpKey],[CommunityKey],[PropertyKey],[LotUnitNumber],[ModifiedDate]) VALUES(@ClientpKey,@CommunityKey,@PropertyKey,@LotUnitNumber,@modDate)
		END
		SELECT 1 as "retVal"
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_GetCommunityOwners]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 02/10/2017 12:26:35 PM
-- Description:	This SP retrieves community keys for all companies
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_GetCommunityOwners] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [ARDATA].[dbo].[CompanyxRef].[ClientpKey],[ReadyRESALEID] AS ClientId,[Authorization],[SiteURL],[ARDATA].[dbo].[CommunityLinks].[LinkURL]

  FROM [ARDATA].[dbo].[CompanyxRef] INNER JOIN
  [ARDATA].[dbo].[CommunityLinks] ON [ARDATA].[dbo].[CompanyxRef].[ClientpKey] = [ARDATA].[dbo].[CommunityLinks].[ClientpKey]
  WHERE Active=1
  AND [ARDATA].[dbo].[CommunityLinks].[LinkRelation] = 'All Owners'
  AND InterfacePartner = 'Caliber' AND InterfaceSystemID = 'V2'

END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_GetCommunityOwners_V3]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 02/10/2017 12:26:35 PM
-- Description:	This SP retrieves community keys for all companies
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_GetCommunityOwners_V3] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [ARDATA].[dbo].[CompanyxRef].[ClientpKey],[ReadyRESALEID] AS ClientId,[Authorization],[SiteURL],[ARDATA].[dbo].[CommunityLinks].[LinkURL]

  FROM [ARDATA].[dbo].[CompanyxRef] INNER JOIN
  [ARDATA].[dbo].[CommunityLinks] ON [ARDATA].[dbo].[CompanyxRef].[ClientpKey] = [ARDATA].[dbo].[CommunityLinks].[ClientpKey]
  WHERE Active=1
  AND [ARDATA].[dbo].[CommunityLinks].[LinkRelation] = 'All Owners'
  AND InterfacePartner = 'Caliber' AND InterfaceSystemID = 'V3'

END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_GetCompanyURL]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 02/10/2017 12:26:35 PM
-- Description:	This SP retrieves community keys for all companies
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_GetCompanyURL] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [ClientpKey],[ReadyRESALEID] AS ClientId,[Authorization],[SiteURL]

  FROM [ARDATA].[dbo].[CompanyxRef]
  WHERE Active=1
  AND InterfacePartner = 'Caliber' AND InterfaceSystemID = 'V2'

END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_GetCompanyURL_V3]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 02/10/2017 12:26:35 PM
-- Description:	This SP retrieves community keys for all companies
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_GetCompanyURL_V3] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [ClientpKey],[ReadyRESALEID] AS ClientId,[Authorization],[SiteURL]

  FROM [ARDATA].[dbo].[CompanyxRef]
  WHERE Active=1
  AND InterfacePartner = 'Caliber' AND InterfaceSystemID = 'V3'

END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_GetOwnerBalances]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 02/10/2017 12:26:35 PM
-- Description:	This SP retrieves community keys for all companies
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_GetOwnerBalances] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [ARDATA].[dbo].[CompanyxRef].[ClientpKey],[ReadyRESALEID] AS ClientId,[Authorization],[SiteURL],[ARDATA].[dbo].[OwnerLinks].[LinkURL]

  FROM [ARDATA].[dbo].[CompanyxRef] INNER JOIN
  [ARDATA].[dbo].[OwnerLinks] ON [ARDATA].[dbo].[CompanyxRef].[ClientpKey] = [ARDATA].[dbo].[OwnerLinks].[ClientpKey]
  WHERE Active=1
  AND [ARDATA].[dbo].[OwnerLinks].[LinkRelation] = 'All Unit Accounts'
  AND InterfacePartner = 'Caliber' AND InterfaceSystemID = 'V2'

END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_GetOwnerBalances_V3]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 02/10/2017 12:26:35 PM
-- Description:	This SP retrieves community keys for all companies
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_GetOwnerBalances_V3] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [ARDATA].[dbo].[CompanyxRef].[ClientpKey],[ReadyRESALEID] AS ClientId,[Authorization],[SiteURL],[ARDATA].[dbo].[OwnerLinks].[LinkURL]

  FROM [ARDATA].[dbo].[CompanyxRef] INNER JOIN
  [ARDATA].[dbo].[OwnerLinks] ON [ARDATA].[dbo].[CompanyxRef].[ClientpKey] = [ARDATA].[dbo].[OwnerLinks].[ClientpKey]
  WHERE Active=1
  AND [ARDATA].[dbo].[OwnerLinks].[LinkRelation] = 'All Unit Accounts'
  AND InterfacePartner = 'Caliber' AND InterfaceSystemID = 'V3'

END
GO
/****** Object:  StoredProcedure [dbo].[usp_C0_UpdatePropertyDetails]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Henry Jones
-- Create date: 02/10/2017 12:26:35 PM
-- Description:	This SP adds/Modifies data in Property table
-- =============================================
CREATE PROCEDURE [dbo].[usp_C0_UpdatePropertyDetails] 

	@ClientpKey					int,
	@CommunityKey				int,
	@PropertyKey				int,
	@LastAssessmentPaidDate		datetime,
	@LastAssessmentPaidAmount	money,
	@NextAssessmentDate			datetime,
	@NextAssessmentAmount		money,
	@AssessmentPaidThru			datetime,			
	@ModifiedDate				varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

    	DECLARE @modDate datetime
	    SET @modDate = CAST(@ModifiedDate as datetime)
		IF @ModifiedDate = '1900-01-01 00:00:00.000' SET @modDate   = GETDATE()

		IF exists (SELECT 1 from dbo.Property WHERE CommunityKey = @CommunityKey AND [PropertyKey] = @PropertyKey AND [ClientpKey] = @ClientpKey AND  @ClientpKey <> '0')
		BEGIN
			UPDATE dbo.Property SET [LastAssessmentPaidDate] = @LastAssessmentPaidDate, [LastAssessmentPaidAmount] = @LastAssessmentPaidAmount, [NextAssessmentDate] = @NextAssessmentDate,	[NextAssessmentAmount] = @NextAssessmentAmount,	[AssessmentPaidThru] = @AssessmentPaidThru, [ModifiedDate] = @modDate WHERE [PropertyKey] = @PropertyKey -- AND ModifiedDate < @modDate
		END
		SELECT 1 as "retVal"
		--return 1
	END TRY
	BEGIN CATCH
		If exists (SELECT 1 FROM dbo.ProcessingLog WHERE ERROR_NUMBER() = [ErrorMessageNumber] AND ERROR_PROCEDURE() = [ScriptName] AND ERROR_LINE() = [ScriptLine] AND [ErrorDateTime] < DATEADD(HOUR,1,GetDate()))

		BEGIN
			SELECT 0 AS "retVal"
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ProcessingLog ([ClientpKey],[ErrorMessageNumber],[RowNumber],[ScriptName],[ScriptLine],[ErrorMessage]) VALUES(@ClientpKey,ERROR_NUMBER(), @@ROWCOUNT,ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			SELECT 0 AS "retVal"
		END	

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetJSON]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Henry Jones
-- Create date: 06/15/2018 12:26:35 PM
-- Description:	This SP Will retrieve data from a table or view and return it in a JSON format
-- Example of how to execute:  EXEC usp_GetJSON 'Company','CompanyID = 4';
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetJSON] @ObjectName VARCHAR(1000), @Condition VARCHAR(1000), @Action VARCHAR(1000), @Results VARCHAR(8000) OUTPUT, @registries_per_request smallint = null
AS
BEGIN
    IF OBJECT_ID(@ObjectName) IS NULL
        BEGIN
            SELECT Json = '';
            RETURN
        END;

    DECLARE @Top NVARCHAR(20) = CASE WHEN @registries_per_request IS NOT NULL 
                                    THEN 'TOP (' + CAST(@registries_per_request AS NVARCHAR) + ') ' 
                                    ELSE '' 
                                END;

    IF @Condition IS NULL 
		BEGIN
			DECLARE @SQL NVARCHAR(MAX) = N'SELECT ' + @Top + '* INTO ##T ' + 
                                'FROM ' + @ObjectName;
			EXECUTE SP_EXECUTESQL @SQL;
		END;
	ELSE
		BEGIN
			DECLARE @SQLC NVARCHAR(MAX) = N'SELECT ' + @Top + '* INTO ##T ' + 
                                'FROM ' + @ObjectName + ' WHERE ' + @Condition;
			EXECUTE SP_EXECUTESQL @SQLC;
		END;
 

    -- DECLARE @X NVARCHAR(MAX) = '[' + (SELECT * FROM ##T FOR XML PATH('')) + ']';
    DECLARE @X NVARCHAR(MAX) = (SELECT * FROM ##T FOR XML PATH(''));


    SELECT  @X = REPLACE(@X, '<' + Name + '>', 
                    CASE WHEN ROW_NUMBER() OVER(ORDER BY Column_ID) = 1 THEN '{"action": "' + @Action + '","'
                         ELSE '' END + Name + '":"'),
            @X = REPLACE(@X, '</' + Name + '>', '","'),
            @X = REPLACE(@X, ',{', '"}, {"'),
            @X = REPLACE(@X, ',]', '"}'),
			@X = REPLACE(@X, ',"]', '}')
    FROM    sys.columns
    WHERE   [Object_ID] = OBJECT_ID(@ObjectName)
    ORDER BY Column_ID;

    DROP TABLE ##T;

    SET @Results = (SELECT  Json = LEFT(@X, (LEN(@X) -2)) + '}');
	RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[usp_T0_AddUpdateAmenity]    Script Date: 1/8/2020 2:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


