USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[DropForeignKeysFromStarSchemaData]    Script Date: 11/5/2022 8:51:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 10/30/2022
-- Description:	Drop the Foreign Keys From the Star Schema
-- =============================================
ALTER PROCEDURE [Project2].[DropForeignKeysFromStarSchemaData]
	@GroupMemberUserAuthorizationKey INT 
AS
BEGIN
	SET NOCOUNT ON;

	 
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Dropping All Foreign Keys';
	DECLARE @WorkFlowStepTableRowCount INT= 0;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;


    ALTER TABLE [CH01-01-Fact].Data
		DROP CONSTRAINT FK_Data_DimCustomer;

	ALTER TABLE [CH01-01-Fact].Data
		DROP CONSTRAINT FK_Data_DimGender;
	
	ALTER TABLE [CH01-01-Fact].Data
		DROP CONSTRAINT FK_Data_DimMaritalStatus;

	ALTER TABLE [CH01-01-Fact].Data
		DROP CONSTRAINT FK_Data_DimProduct;

	
	ALTER TABLE [CH01-01-Fact].Data
		DROP CONSTRAINT FK_Data_DimOccupation;

	ALTER TABLE [CH01-01-Fact].Data
		DROP CONSTRAINT FK_Data_SalesManagers;

	ALTER TABLE [CH01-01-Fact].Data
		DROP CONSTRAINT FK_Data_DimOrderDate;

	ALTER TABLE [CH01-01-Fact].Data
		DROP CONSTRAINT FK_Data_DimTerritory;

	ALTER TABLE [CH01-01-Dimension].DimProduct
		DROP CONSTRAINT FK_DimProduct_ProductSubcategory;

	ALTER TABLE [CH01-01-Dimension].DimProductSubcategory
		DROP CONSTRAINT FK_ProductSubcategory_ProductCategory;

	PRINT 'All foreign keys dropped'

	SELECT @EndingDateTime = SYSDATETIME();

	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberUserAuthorizationKey;

end
