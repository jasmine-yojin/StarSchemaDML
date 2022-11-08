USE [BIClass]
GO

/****** Object:  StoredProcedure [Project2].[TruncateStarSchemaData]    Script Date: 11/7/2022 10:08:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Jasmine Kim
-- Create date: 10/30/2022
-- Description:	Truncating Tables
-- =============================================
CREATE PROCEDURE [Project2].[TruncateStarSchemaData]
	@GroupMemberUserAuthorizationKey INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Truncating Tables and Restarting Sequences';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;

	TRUNCATE TABLE [CH01-01-Fact].[Data]
	TRUNCATE TABLE [CH01-01-Dimension].DimCustomer
	TRUNCATE TABLE [CH01-01-Dimension].DimGender
	TRUNCATE TABLE [CH01-01-Dimension].DimMaritalStatus
	TRUNCATE TABLE [CH01-01-Dimension].DimOccupation
	TRUNCATE TABLE [CH01-01-Dimension].DimOrderDate
	TRUNCATE TABLE [CH01-01-Dimension].DimProduct
	TRUNCATE TABLE [CH01-01-Dimension].DimTerritory
	TRUNCATE TABLE [CH01-01-Dimension].SalesManagers
	TRUNCATE TABLE [CH01-01-Dimension].DimProductCategory
	TRUNCATE TABLE [CH01-01-Dimension].DimProductSubcategory
	TRUNCATE TABLE Process.WorkflowSteps

	ALTER SEQUENCE PkSequence.DataSalesKey
	RESTART WITH 1;
		
	ALTER SEQUENCE PkSequence.DimCustomerCustomerKey
	RESTART WITH 1;
		
	ALTER SEQUENCE PkSequence.DimOccupationOccupationKey
	RESTART WITH 1;
	
	ALTER SEQUENCE PkSequence.DimProductCategoryProductCategoryKey
	RESTART WITH 1;
	
	
	ALTER SEQUENCE PkSequence.DimProductProductKey
	RESTART WITH 1;
	
	ALTER SEQUENCE PkSequence.DimProductSubcategoryProductSubcategoryKey
	RESTART WITH 1;
	
	ALTER SEQUENCE PkSequence.DimSalesManagerSalesManagerKey
	RESTART WITH 1;
	
	ALTER SEQUENCE PkSequence.DimTerritoryTerritoryKey
	RESTART WITH 1;

	ALTER SEQUENCE PkSequence.UserAuthorizationKey
	RESTART WITH 1;

	ALTER SEQUENCE PkSequence.WorkFlowStepKey
	RESTART WITH 1;

	SELECT @WorkFlowStepTableRowCount =  0;
	SELECT @EndingDateTime = SYSDATETIME();

	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberUserAuthorizationKey;

	PRINT 'tables truncated and sequences restarted'
END
GO


