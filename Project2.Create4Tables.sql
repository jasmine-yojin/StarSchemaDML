USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[preparation]    Script Date: 11/5/2022 8:55:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/2/22
-- Description:	Creates ProductCategory, ProductSubcategory, WorflowSteps, UserAuthorization tables 
-- =============================================
ALTER PROCEDURE [Project2].[preparation]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --ProductCategory
	DROP TABLE IF EXISTS [CH01-01-Dimension].[DimProductCategory]
	CREATE TABLE [CH01-01-Dimension].[DimProductCategory](
	[ProductCategoryKey] [INT] NOT NULL,
	[productCategory] [VARCHAR](20) NOT NULL,
	[DateAdded] [DATETIME2](7) NULL,
	[DateOfLastUpdate] [DATETIME2](7) NULL,
	[userAuthrizationKey] [INT] NOT NULL,
	 CONSTRAINT [PK_ProductCategoryKey] PRIMARY KEY CLUSTERED 
	(
		[ProductCategoryKey] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	
	ALTER TABLE [CH01-01-Dimension].[DimProductCategory]
	ADD CONSTRAINT DFT_DimProductCategory_ProductCategoryKey
		DEFAULT (NEXT VALUE FOR PkSequence.DimProductCategoryProductCategoryKey)
		FOR ProductCategoryKey;

	ALTER TABLE [CH01-01-Dimension].[DimProductCategory] ADD  CONSTRAINT [DF_DimProductCatetory_DateAdded]  DEFAULT (SYSDATETIME()) FOR [DateAdded]
	
	
	ALTER TABLE [CH01-01-Dimension].[DimProductCategory] ADD  CONSTRAINT [DF_DimProductCatetory_DateOfLastUpdate]  DEFAULT (SYSDATETIME()) FOR [DateOfLastUpdate]
	
	
	--ProductSubcategory table
	DROP TABLE IF EXISTS [CH01-01-Dimension].[DimProductSubcategory];
	CREATE TABLE [CH01-01-Dimension].[DimProductSubcategory](
	[ProductSubcategoryKey] [INT] NOT NULL,
	productCategoryKey INT NULL,
	productSubcategory VARCHAR (20) NULL,
	[userAuthrizationKey] [INT] NOT NULL,
	[DateAdded] [DATETIME2](7) NULL,
	[DateOfLastUpdate] [DATETIME2](7) NULL,
	 CONSTRAINT [PK_ProductSubcategoryKey] PRIMARY KEY CLUSTERED 
	(
		[ProductSubcategoryKey] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	
	ALTER TABLE [CH01-01-Dimension].[DimProductSubcategory]
	ADD CONSTRAINT DFT_DimProductSubcategory_ProductSubcategoryKey
		DEFAULT (NEXT VALUE FOR PkSequence.DimProductSubcategoryProductSubcategoryKey)
		FOR ProductSubcategoryKey;

	ALTER TABLE [CH01-01-Dimension].[DimProductSubcategory] ADD  CONSTRAINT [DF_DimSubProductCatetory_DateAdded]  DEFAULT (SYSDATETIME()) FOR [DateAdded]
	

	ALTER TABLE [CH01-01-Dimension].[DimProductSubcategory] ADD  CONSTRAINT [DF_DimSubProductCatetory_DateOfLastUpdate]  DEFAULT (SYSDATETIME()) FOR [DateOfLastUpdate]
	

	--UserAuthorization
	DROP TABLE IF EXISTS DbSecurity.UserAuthorization
	CREATE TABLE [DbSecurity].[UserAuthorization](
	[UserAuthorizationKey] [INT] NOT NULL,
	[ClassTime] [NCHAR](5) NULL,
	[IndividualProject] [NVARCHAR](60) NULL,
	[GroupMemberLastName] [NVARCHAR](35) NOT NULL,
	[GroupMemberFirstName] [NVARCHAR](25) NOT NULL,
	[GroupName] [NVARCHAR](20) NOT NULL,
	[DateAdded] [DATETIME2](7) NULL,
	PRIMARY KEY CLUSTERED 
	(
		[UserAuthorizationKey] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	
	ALTER TABLE DbSecurity.UserAuthorization
	ADD CONSTRAINT DFT_UserAuthorization_UserAuthorizationKey
		DEFAULT (NEXT VALUE FOR PkSequence.UserAuthorizationKey)
		FOR UserAuthorizationKey;

	ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('10:45') FOR [ClassTime]
	

	ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA') FOR [IndividualProject]
	

	ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('Group2') FOR [GroupName]
	

	ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT (SYSDATETIME()) FOR [DateAdded]
	

	--Workflow Table
	DROP TABLE IF EXISTS process.WorkflowSteps
	CREATE TABLE [Process].[WorkflowSteps](
	[WorkFlowStepKey] [INT] NOT NULL,
	[WorkFlowStepDescription] [NVARCHAR](100) NOT NULL,
	[WorkFlowStepTableRowCount] [INT] NULL,
	[StartingDateDate] [DATETIME2](7) NULL,
	[EndingDateTime] [DATETIME2](7) NULL,
	[ClassTime] [CHAR](5) NULL,
	[UserAuthorizationKey] [INT] NOT NULL,
	 CONSTRAINT [PK_WorkFlowSteps] PRIMARY KEY CLUSTERED 
	(
		[WorkFlowStepKey] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	
	ALTER TABLE process.WorkflowSteps
	ADD CONSTRAINT DFT_WorkflowSteps_WorkflowStepKey
		DEFAULT (NEXT VALUE FOR PkSequence.WorkFlowStepKey)
		FOR WorkFlowStepKey;


	ALTER TABLE [Process].[WorkflowSteps] ADD  DEFAULT ((0)) FOR [WorkFlowStepTableRowCount]
	

	ALTER TABLE [Process].[WorkflowSteps] ADD  DEFAULT (SYSDATETIME()) FOR [StartingDateDate]
	

	ALTER TABLE [Process].[WorkflowSteps] ADD  DEFAULT (SYSDATETIME()) FOR [EndingDateTime]
	

	ALTER TABLE [Process].[WorkflowSteps] ADD  DEFAULT ('10:45') FOR [ClassTime];



	--dimProduct
		--first dropping the table to drop the identity property.
	DROP TABLE IF EXISTS [CH01-01-Dimension].[DimProduct]

	--re-creating the table. This time, no identity property. Adding the other three columns.
	CREATE TABLE [CH01-01-Dimension].[DimProduct](
	[ProductKey] [INT] NOT NULL,
	[ProductSubcategoryKey] [INT] NULL,
	[ProductCategory] [VARCHAR](20) NULL,
	[ProductSubcategory] [VARCHAR](20) NULL,
	[ProductCode] [VARCHAR](10) NULL,
	[ProductName] [VARCHAR](40) NULL,
	[Color] [VARCHAR](10) NULL,
	[ModelName] [VARCHAR](30) NULL,
	userAuthorizationKey INT NOT NULL,
	DateAdded DATETIME2 NOT NULL
		CONSTRAINT DFT_DimProduct_DateAdded DEFAULT (SYSDATETIME()),
	DateOfLastUpdate DATETIME2 NOT NULL
		CONSTRAINT DFT_DimProduct_DateOfLastUpdate DEFAULT (SYSDATETIME()),
	 CONSTRAINT [PK__DimProdu__A15E99B3E27177EF] PRIMARY KEY CLUSTERED 
	(
	[ProductKey] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	--setting the default of primary key to sequence
	ALTER TABLE [CH01-01-Dimension].[DimProduct]
	ADD CONSTRAINT DFT_DimProduct_ProductKey
		DEFAULT (NEXT VALUE FOR PkSequence.DimProductProductKey)
		FOR ProductKey;
	
	PRINT '4 tables created';

-- ADDING 3 columns to each table
--DimGender
	ALTER TABLE [CH01-01-Dimension].DimGender
		ADD userAuthorizationKey INT NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimGender
		ADD DateAdded datetime2 (7) NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimGender
		ADD DateOfLastUpdate datetime2 (7) NOT null
	
	ALTER TABLE  [CH01-01-Dimension].DimGender ADD  CONSTRAINT [DF_DimGender_DateAdded]  DEFAULT (SYSDATETIME()) FOR [DateAdded]
	ALTER TABLE  [CH01-01-Dimension].DimGender ADD  CONSTRAINT [DF_DimGender_DateOfLastUpdate]  DEFAULT (SYSDATETIME()) FOR [DateOfLastUpdate]

--DimMaritalStatus
	ALTER TABLE [CH01-01-Dimension].DimMaritalStatus
		ADD userAuthorizationKey INT NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimMaritalStatus
		ADD DateAdded datetime2 (7) NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimMaritalStatus
		ADD DateOfLastUpdate datetime2 (7) NOT null
	
	ALTER TABLE  [CH01-01-Dimension].DimMaritalStatus ADD  CONSTRAINT [DF_DimMaritalStatus_DateAdded]  DEFAULT (SYSDATETIME()) FOR [DateAdded]
	ALTER TABLE  [CH01-01-Dimension].DimMaritalStatus ADD  CONSTRAINT [DF_DimMaritalStatus_DateOfLastUpdate]  DEFAULT (SYSDATETIME()) FOR [DateOfLastUpdate]

--DimOccupation
	ALTER TABLE [CH01-01-Dimension].DimOccupation
		ADD userAuthorizationKey INT NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimOccupation
		ADD DateAdded datetime2 (7) NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimOccupation
		ADD DateOfLastUpdate datetime2 (7) NOT null
	
	ALTER TABLE  [CH01-01-Dimension].DimOccupation ADD  CONSTRAINT [DF_DimOccupation_DateAdded]  DEFAULT (SYSDATETIME()) FOR [DateAdded]
	ALTER TABLE  [CH01-01-Dimension].DimOccupation ADD  CONSTRAINT [DF_DimOccupation_DateOfLastUpdate]  DEFAULT (SYSDATETIME()) FOR [DateOfLastUpdate]

	ALTER TABLE [CH01-01-Dimension].DimOccupation
		ADD CONSTRAINT DFT_DimOccupation_OccupationKey
			DEFAULT (NEXT VALUE FOR PkSequence.DimOccupationOccupationKey) FOR OccupationKey

--DimOrderDate
	ALTER TABLE [CH01-01-Dimension].DimOrderDate
		ADD userAuthorizationKey INT NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimOrderDate
		ADD DateAdded datetime2 (7) NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimOrderDate
		ADD DateOfLastUpdate datetime2 (7) NOT null
	
	ALTER TABLE  [CH01-01-Dimension].DimOrderDate ADD  CONSTRAINT [DF_DimOrderDate_DateAdded]  DEFAULT (SYSDATETIME()) FOR [DateAdded]
	ALTER TABLE  [CH01-01-Dimension].DimOrderDate ADD  CONSTRAINT [DF_DimOrderDate_DateOfLastUpdate]  DEFAULT (SYSDATETIME()) FOR [DateOfLastUpdate]

--DimTerritory
	ALTER TABLE [CH01-01-Dimension].DimTerritory
		ADD userAuthorizationKey INT NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimTerritory
		ADD DateAdded datetime2 (7) NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimTerritory
		ADD DateOfLastUpdate datetime2 (7) NOT null
	
	ALTER TABLE  [CH01-01-Dimension].DimTerritory ADD  CONSTRAINT [DF_DimTerritory_DateAdded]  DEFAULT (SYSDATETIME()) FOR [DateAdded]
	ALTER TABLE  [CH01-01-Dimension].DimTerritory ADD  CONSTRAINT [DF_DimTerritory_DateOfLastUpdate]  DEFAULT (SYSDATETIME()) FOR [DateOfLastUpdate]

	ALTER TABLE [CH01-01-Dimension].DimTerritory
		DROP CONSTRAINT PK__DimTerri__C54B735D813BBCA6
	ALTER TABLE [CH01-01-Dimension].DimTerritory
		DROP COLUMN TerritoryKey
	ALTER TABLE [CH01-01-Dimension].DimTerritory
		ADD TerritoryKey INT NOT NULL 	
	ALTER TABLE [CH01-01-Dimension].DimTerritory
		ADD CONSTRAINT PK__DimTerri__C54B735D813BBCA6 PRIMARY KEY (TerritoryKey);
	
	ALTER TABLE [CH01-01-Dimension].DimTerritory
		ADD CONSTRAINT DFT_DimTerritory_TerritoryKey
			DEFAULT (NEXT VALUE FOR PkSequence.DimTerritoryTerritoryKey) FOR TerritoryKey

--DimCustomer
	ALTER TABLE [CH01-01-Dimension].DimCustomer
		ADD userAuthorizationKey INT NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimCustomer
		ADD DateAdded datetime2 (7) NOT NULL
	ALTER TABLE [CH01-01-Dimension].DimCustomer
		ADD DateOfLastUpdate datetime2 (7) NOT null
	
	ALTER TABLE  [CH01-01-Dimension].DimCustomer ADD  CONSTRAINT [DF_DimCustomer_DateAdded]  DEFAULT (SYSDATETIME()) FOR [DateAdded]
	ALTER TABLE  [CH01-01-Dimension].DimCustomer ADD  CONSTRAINT [DF_DimCustomer_DateOfLastUpdate]  DEFAULT (SYSDATETIME()) FOR [DateOfLastUpdate]

	ALTER TABLE [CH01-01-Dimension].DimCustomer
		DROP CONSTRAINT PK__DimCusto__95011E6452BCF41C
	ALTER TABLE [CH01-01-Dimension].DimCustomer
		DROP COLUMN CustomerKey
	ALTER TABLE [CH01-01-Dimension].DimCustomer
		ADD CustomerKey INT NOT NULL 	
	ALTER TABLE [CH01-01-Dimension].DimCustomer
		ADD CONSTRAINT PK__DimCusto__95011E6452BCF41C PRIMARY KEY (CustomerKey);



	ALTER TABLE [CH01-01-Dimension].DimCustomer
		ADD CONSTRAINT DFT_SalesManagers_CustomerKey
			DEFAULT (NEXT VALUE FOR PkSequence.DimCustomerCustomerKey) FOR CustomerKey

--Data
	ALTER TABLE [CH01-01-Fact].Data
		ADD userAuthorizationKey INT NOT NULL
	ALTER TABLE [CH01-01-Fact].Data
		ADD DateAdded datetime2 (7) NOT NULL
	ALTER TABLE [CH01-01-Fact].Data
		ADD DateOfLastUpdate datetime2 (7) NOT null
	
	ALTER TABLE  [CH01-01-Fact].Data ADD  CONSTRAINT [DF_Data_DateAdded]  DEFAULT (SYSDATETIME()) FOR [DateAdded]
	ALTER TABLE  [CH01-01-Fact].Data ADD  CONSTRAINT [DF_Data_DateOfLastUpdate]  DEFAULT (SYSDATETIME()) FOR [DateOfLastUpdate]

	ALTER TABLE  [CH01-01-Fact].Data
		ADD CONSTRAINT DFT_Data_SalesKey
			DEFAULT (NEXT VALUE FOR PkSequence.dataSalesKey) FOR SalesKey

--SalesManager
	
	ALTER TABLE [CH01-01-Dimension].SalesManagers
		ADD UserAuthorizationKey INT NOT NULL
	ALTER TABLE [CH01-01-Dimension].SalesManagers
		ADD DateAdded datetime2 (7) NULL
	ALTER TABLE [CH01-01-Dimension].SalesManagers
		ADD DateOfLastUpdate DATETIME2 (7) NULL 


	ALTER TABLE [CH01-01-Dimension].SalesManagers
		ADD CONSTRAINT DF_SalesManager_DateAdded DEFAULT (SYSDATETIME()) FOR DateAdded

	ALTER TABLE [CH01-01-Dimension].SalesManagers
		ADD CONSTRAINT DF_SalesManager_DateOfLastUpdate DEFAULT (SYSDATETIME()) FOR DateOfLastUpdate

	ALTER TABLE [CH01-01-Dimension].SalesManagers
		ADD CONSTRAINT DFT_SalesManagers_SalesManagerKey
			DEFAULT (NEXT VALUE FOR PkSequence.DimSalesManagerSalesManagerKey) FOR SalesManagerKey

END;


