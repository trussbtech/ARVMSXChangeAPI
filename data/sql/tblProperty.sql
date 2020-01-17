USE [ReadyResale]
GO

ALTER TABLE [dbo].[tblProperty] DROP CONSTRAINT [DF_tblProperty_RecordFlag_01]
GO

/****** Object:  Table [dbo].[tblProperty]    Script Date: 12/27/2019 3:21:05 PM ******/
DROP TABLE [dbo].[tblProperty]
GO

/****** Object:  Table [dbo].[tblProperty]    Script Date: 12/27/2019 3:21:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblProperty](
	[PropertyID] [int] IDENTITY(1,1) NOT NULL,
	[ReadyResaleID] [varchar](30) NULL,
	[CommID] [varchar](100) NULL,
	[txtDisplayName] [varchar](50) NULL,
	[RecordNumber] [varchar](25) NULL,
	[RecordFlag] [int] NOT NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[StreetAddress] [varchar](150) NULL,
	[StreetAddress2] [varchar](150) NULL,
	[StreetName] [varchar](150) NULL,
	[FullAddress] [varchar](150) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Zip] [varchar](12) NULL,
	[Phone] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[LotNumber] [varchar](20) NULL,
	[BuildingNumber] [varchar](12) NULL,
	[AptNumber] [varchar](12) NULL,
	[CurrentBalance] [money] NULL,
	[LastPayDate] [varchar](12) NULL,
	[PrePaid] [varchar](12) NULL,
	[RegularChargeAmount] [money] NULL,
	[RegularDeliquentAmount] [money] NULL,
	[RegularLateAmount] [money] NULL,
	[SpecialChargeAmount] [money] NULL,
	[SpecialDeliquentAmount] [money] NULL,
	[SpecialLateAmount] [money] NULL,
	[OtherChargeAmount] [money] NULL,
	[OtherDeliquentAmount] [money] NULL,
	[OtherLateAmount] [money] NULL,
	[HoldAction] [varchar](20) NULL,
 CONSTRAINT [PK_Properties_01] PRIMARY KEY CLUSTERED 
(
	[PropertyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblProperty] ADD  CONSTRAINT [DF_tblProperty_RecordFlag_01]  DEFAULT ((0)) FOR [RecordFlag]
GO

