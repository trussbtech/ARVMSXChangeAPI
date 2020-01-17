USE [ReadyResale]
GO

/****** Object:  Table [dbo].[TOPS.TOPSData]    Script Date: 12/27/2019 3:22:12 PM ******/
DROP TABLE [dbo].[TOPS.TOPSData]
GO

/****** Object:  Table [dbo].[TOPS.TOPSData]    Script Date: 12/27/2019 3:22:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TOPS.TOPSData](
	[ReadyResale ID] [varchar](30) NULL,
	[COMMID] [varchar](10) NULL,
	[RECORD NUMBER] [varchar](7) NULL,
	[OWNER FIRST NAME] [varchar](50) NULL,
	[OWNER LAST NAME] [varchar](50) NULL,
	[OWNER SUFFIX] [varchar](5) NULL,
	[Person Type] [varchar](1) NULL,
	[OWNER FISRT NAME 2] [varchar](50) NULL,
	[OWNER LAST NAME 2] [varchar](50) NULL,
	[Home Phone Area] [varchar](6) NULL,
	[Home Phone] [varchar](8) NULL,
	[Home Phone EXT] [varchar](6) NULL,
	[Work Phone Area] [varchar](6) NULL,
	[Work Phone] [varchar](8) NULL,
	[Work Phone EXT] [varchar](6) NULL,
	[Alt Phone Area] [varchar](6) NULL,
	[Alt Phone] [varchar](8) NULL,
	[Alt Phone EXT] [varchar](6) NULL,
	[ACCOUNT NUM] [varchar](20) NULL,
	[LOT UNIT NUM] [varchar](10) NULL,
	[Building Number] [varchar](12) NULL,
	[Street Address] [varchar](150) NULL,
	[Street Name] [varchar](150) NULL,
	[Apt Num] [varchar](12) NULL,
	[Property City] [varchar](50) NULL,
	[Property State] [varchar](2) NULL,
	[Property Zip] [varchar](12) NULL,
	[PROLEGALLIN] [varchar](50) NULL,
	[PROLEGALLIN2] [varchar](50) NULL,
	[OWNER RATIO] [varchar](10) NULL,
	[ProGrpOwnno] [int] NULL,
	[PROSQFT] [int] NULL,
	[PERSETTLDAT] [varchar](12) NULL,
	[ACC] [varchar](20) NULL,
	[ACCCOUNT] [varchar](3) NULL,
	[Current Balance] [money] NULL,
	[Last Pay Date] [varchar](12) NULL,
	[PrePaid] [varchar](12) NULL,
	[Reg Charge Amount] [money] NULL,
	[Reg Deliquent Amount] [money] NULL,
	[Reg Late Amount] [money] NULL,
	[Spc Charge Amount] [money] NULL,
	[Spc Deliquent Amount] [money] NULL,
	[Spc Late Amount] [money] NULL,
	[Oth Charge Amount] [money] NULL,
	[Oth Deliquent Amount] [money] NULL,
	[Oth Late Amount] [money] NULL,
	[Hold Action] [varchar](20) NULL,
	[Alt Mail Addr1] [varchar](150) NULL,
	[Alt Mail Addr2] [varchar](150) NULL,
	[Alt Mail City] [varchar](50) NULL,
	[Alt Mail State] [varchar](2) NULL,
	[Alt Mail Zip] [varchar](12) NULL,
	[Paid Through Date] [varchar](12) NULL,
	[Next Due Date] [varchar](12) NULL
) ON [PRIMARY]
GO

