USE [AssociationReady]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_eCheckFee]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_ResaleFee]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_ExpireDays]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_intFreeDocs]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_intRightHTML]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_intLeftHTML]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtDemoMode]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtPackageNo]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtPackageYes]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtRushChargeDays]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtRushChargeFee]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtResaleDocumentsFee]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtDueStatusFee]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtDisclosureFee_1]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtPackageFee]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtResaleServiceCharge]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_txtCommunitySearchLength]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_intVisible]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_isTops]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_intCheckListSteps]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_intDirectBilling]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_intCompanyCerts]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_intCompanyResale]
GO

ALTER TABLE [dbo].[tblCompany] DROP CONSTRAINT [DF_tblCompany_intCompanyDocs]
GO

/****** Object:  Table [dbo].[tblCompany]    Script Date: 12/27/2019 3:20:01 PM ******/
DROP TABLE [dbo].[tblCompany]
GO

/****** Object:  Table [dbo].[tblCompany]    Script Date: 12/27/2019 3:20:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblCompany](
	[pkCompany] [int] IDENTITY(0,1) NOT NULL,
	[intCompanyDocs] [int] NOT NULL,
	[intCompanyResale] [int] NOT NULL,
	[intCompanyCerts] [int] NOT NULL,
	[intSellsItems] [int] NULL,
	[intDirectBilling] [int] NOT NULL,
	[intCheckListStep] [int] NOT NULL,
	[isTops] [int] NOT NULL,
	[intVisible] [int] NOT NULL,
	[txtGuid] [varchar](100) NULL,
	[txtCompanyName] [varchar](255) NULL,
	[txtCompanyAddress1] [varchar](255) NULL,
	[txtCompanyAddress2] [varchar](255) NULL,
	[txtCompanyCity] [varchar](255) NULL,
	[txtCompanyState] [varchar](50) NULL,
	[txtCompanyZip] [varchar](50) NULL,
	[txtBillingAddress1] [varchar](255) NULL,
	[txtBillingAddress2] [varchar](255) NULL,
	[txtBillingCity] [varchar](255) NULL,
	[txtBillingState] [varchar](50) NULL,
	[txtBillingZip] [varchar](50) NULL,
	[txtCompanyOfficePhone] [varchar](50) NULL,
	[txtCompanyOfficeFax] [varchar](50) NULL,
	[txtCompanyEmailAddress] [varchar](255) NULL,
	[txtCompanyWebsite] [varchar](255) NULL,
	[txtCommunitySearchLength] [int] NOT NULL,
	[txtResaleServiceCharge] [varchar](50) NOT NULL,
	[txtCompanyClosingContactName] [varchar](100) NULL,
	[txtCompanyClosingContactEmail] [varchar](255) NULL,
	[txtItemContactEmailAddress] [varchar](255) NULL,
	[txtCompanyClosingContactSignaturePath] [text] NULL,
	[txtPackageFee] [varchar](50) NOT NULL,
	[txtDisclosureFee] [varchar](50) NOT NULL,
	[txtDueStatusFee] [varchar](50) NOT NULL,
	[txtResaleDocumentsFee] [varchar](50) NOT NULL,
	[txtRushChargeFee] [varchar](50) NOT NULL,
	[txtRushChargeDays] [varchar](50) NOT NULL,
	[txtRushChargeText] [text] NULL,
	[txtOrderConfimationText] [text] NULL,
	[txtPackageYes] [varchar](50) NOT NULL,
	[txtPackageValue] [varchar](50) NOT NULL,
	[txtCompanyLogoLocation] [varchar](255) NULL,
	[txtRandomNumber] [int] NULL,
	[txtStyleSheetPath] [varchar](150) NULL,
	[txtDemoMode] [varchar](50) NULL,
	[headerHTML] [varchar](2000) NULL,
	[footerHTML] [varchar](2000) NULL,
	[leftHTML] [varchar](2000) NULL,
	[rightHTML] [varchar](2000) NULL,
	[intLeftHTML] [int] NOT NULL,
	[intRightHTML] [int] NOT NULL,
	[backgroundHTML] [varchar](255) NULL,
	[bgColor] [varchar](255) NULL,
	[backTabColor] [varchar](50) NULL,
	[selectedTabImage] [varchar](255) NULL,
	[normalTabImage] [varchar](255) NULL,
	[hoverTabImage] [varchar](255) NULL,
	[Active] [int] NULL,
	[InSetup] [int] NULL,
	[PackageOnly] [int] NULL,
	[txtEmailSubject] [varchar](8000) NULL,
	[txtEmailBody] [varchar](8000) NULL,
	[intFreeDocs] [int] NULL,
	[LandingPageHTML] [varchar](100) NULL,
	[ResalePackageTableHeaderText] [varchar](50) NULL,
	[ResaleDocumentTableHeaderText] [varchar](50) NULL,
	[DocumentPackageTableHeadertext] [varchar](50) NULL,
	[AHNID] [varchar](50) NULL,
	[LoginLink] [varchar](300) NULL,
	[ExpireDays] [int] NOT NULL,
	[ResaleFee] [int] NOT NULL,
	[eCheckFee] [int] NULL,
	[txtTransactionFee] [varchar](50) NULL,
 CONSTRAINT [PK_tblCompany] PRIMARY KEY CLUSTERED 
(
	[pkCompany] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_intCompanyDocs]  DEFAULT (0) FOR [intCompanyDocs]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_intCompanyResale]  DEFAULT (0) FOR [intCompanyResale]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_intCompanyCerts]  DEFAULT (0) FOR [intCompanyCerts]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_intDirectBilling]  DEFAULT (0) FOR [intDirectBilling]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_intCheckListSteps]  DEFAULT (0) FOR [intCheckListStep]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_isTops]  DEFAULT (0) FOR [isTops]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_intVisible]  DEFAULT (0) FOR [intVisible]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtCommunitySearchLength]  DEFAULT (0) FOR [txtCommunitySearchLength]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtResaleServiceCharge]  DEFAULT (0) FOR [txtResaleServiceCharge]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtPackageFee]  DEFAULT (0) FOR [txtPackageFee]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtDisclosureFee_1]  DEFAULT (0) FOR [txtDisclosureFee]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtDueStatusFee]  DEFAULT (0) FOR [txtDueStatusFee]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtResaleDocumentsFee]  DEFAULT (0) FOR [txtResaleDocumentsFee]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtRushChargeFee]  DEFAULT (0) FOR [txtRushChargeFee]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtRushChargeDays]  DEFAULT (0) FOR [txtRushChargeDays]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtPackageYes]  DEFAULT (0) FOR [txtPackageYes]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtPackageNo]  DEFAULT (0) FOR [txtPackageValue]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_txtDemoMode]  DEFAULT ('False') FOR [txtDemoMode]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_intLeftHTML]  DEFAULT (0) FOR [intLeftHTML]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_intRightHTML]  DEFAULT (0) FOR [intRightHTML]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_intFreeDocs]  DEFAULT (0) FOR [intFreeDocs]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_ExpireDays]  DEFAULT (14) FOR [ExpireDays]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_ResaleFee]  DEFAULT ((10)) FOR [ResaleFee]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany_eCheckFee]  DEFAULT ((8)) FOR [eCheckFee]
GO

ALTER TABLE [dbo].[tblCompany] ADD  CONSTRAINT [DF_tblCompany]  DEFAULT ('10') FOR [txtTransactionFee]
GO

