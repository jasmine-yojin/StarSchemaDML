USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_Data]    Script Date: 11/8/2022 1:01:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/5/2022
-- Description:	Loading Data Table
--
-- @GroupMemberUserAuthorizationKey is the 
-- UserAuthorizationKey of the Group Member who completed 
-- this stored procedure.
--
-- =============================================
ALTER PROCEDURE [Project2].[Load_Data]
	@GroupMemberUserAuthorizationKey INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Loading Data Table';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;
    /****** Script for SelectTopNRows command from SSMS  ******/

	INSERT INTO [CH01-01-Fact].Data
	(
	    SalesKey,
		SalesManagerKey,
	    OccupationKey,
	    TerritoryKey,
	    ProductKey,
	    CustomerKey,
	    ProductCategory,
	    SalesManager,
	    ProductSubcategory,
	    ProductCode,
	    ProductName,
	    Color,
	    ModelName,
	    OrderQuantity,
	    UnitPrice,
	    ProductStandardCost,
	    SalesAmount,
	    OrderDate,
	    MonthName,
	    MonthNumber,
	    Year,
	    CustomerName,
	    MaritalStatus,
	    Gender,
	    Education,
	    Occupation,
	    TerritoryRegion,
	    TerritoryCountry,
	    TerritoryGroup,
	    userAuthorizationKey
	)
	SELECT DISTINCT 
	   old.SalesKey,
	   sm.SalesManagerKey,    -- SalesManagerKey - int
	    do.OccupationKey,    -- OccupationKey - int
	    dt.TerritoryKey,    -- TerritoryKey - int
	    dp.ProductKey,    -- ProductKey - int
	    dc.CustomerKey,    -- CustomerKey - int
	    old.ProductCategory,    -- ProductCategory - varchar(20)
	    old.SalesManager,    -- SalesManager - varchar(20)
	    old.ProductSubcategory,    -- ProductSubcategory - varchar(20)
	    old.ProductCode,    -- ProductCode - varchar(10)
	    old.ProductName,    -- ProductName - varchar(40)
	    old.Color,    -- Color - varchar(10)
	    old.ModelName,    -- ModelName - varchar(30)
	    old.OrderQuantity,    -- OrderQuantity - int
	    old.UnitPrice,    -- UnitPrice - money
	    old.ProductStandardCost,    -- ProductStandardCost - money
	    old.SalesAmount,    -- SalesAmount - money
	    old.OrderDate,    -- OrderDate - date
	    old.MonthName,    -- MonthName - varchar(10)
	    old.MonthNumber,    -- MonthNumber - int
	    old.year,    -- Year - int
	    old.CustomerName,    -- CustomerName - varchar(30)
	    old.MaritalStatus,    -- MaritalStatus - char(1)
	    old.Gender,    -- Gender - char(1)
	    old.Education,    -- Education - varchar(20)
	    old.Occupation,    -- Occupation - varchar(20)
	    old.TerritoryRegion,    -- TerritoryRegion - varchar(20)
	    old.TerritoryCountry,    -- TerritoryCountry - varchar(20)
	    old.TerritoryGroup,    -- TerritoryGroup - varchar(20)
	    @GroupMemberUserAuthorizationKey       -- userAuthorizationKey - int

	   FROM FileUpload.OriginallyLoadedData AS old
		INNER JOIN [CH01-01-Dimension].SalesManagers AS sm
			ON sm.SalesManager = old.SalesManager AND
               sm.Category = old.ProductCategory
		INNER JOIN [CH01-01-Dimension].DimOccupation AS do
			ON do.Occupation = old.Occupation
		INNER JOIN [CH01-01-Dimension].DimTerritory AS dt
			ON dt.TerritoryCountry = old.TerritoryCountry AND
			   dt.TerritoryGroup = old.TerritoryGroup AND
               dt.TerritoryRegion = old.TerritoryRegion
		INNER JOIN [CH01-01-Dimension].DimProduct AS dp
			ON dp.productName = old.ProductName
		INNER JOIN [CH01-01-Dimension].DimCustomer AS dc
			ON dc.CustomerName = old.CustomerName
		
	SELECT @WorkFlowStepTableRowCount =  COUNT(*) FROM [CH01-01-Fact].Data;
	SELECT @EndingDateTime = SYSDATETIME();

	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberUserAuthorizationKey;
	PRINT 'Loaded Data Table'

END;


