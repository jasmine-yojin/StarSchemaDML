--creating Sequences
	DROP SEQUENCE IF EXISTS PkSequence.DimProductProductKey	
	CREATE SEQUENCE PkSequence.DimProductProductKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 
	

	DROP SEQUENCE IF EXISTS PkSequence.DimProductSubcategoryProductSubcategoryKey
	CREATE SEQUENCE PkSequence.DimProductSubcategoryProductSubcategoryKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 
	


	DROP SEQUENCE IF EXISTS PkSequence.DimProductCategoryProductCategoryKey
	CREATE SEQUENCE PkSequence.DimProductCategoryProductCategoryKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 

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


--creating foreign keys
ALTER TABLE [CH01-01-Dimension].DimProduct
		ADD CONSTRAINT FK_DimProduct_ProductSubcategory
			FOREIGN KEY (ProductSubcategoryKey) REFERENCES [CH01-01-Dimension].DimProductSubcategory (ProductSubcategoryKey);

ALTER TABLE [CH01-01-Dimension].DimProductSubcategory
	ADD CONSTRAINT FK_ProductSubcategory_ProductCategory
		FOREIGN KEY	(productCategoryKey) REFERENCES [CH01-01-Dimension].DimProductCategory (ProductCategoryKey);