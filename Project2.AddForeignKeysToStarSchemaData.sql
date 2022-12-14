USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[AddForeignKeysToStarSchemaData]    Script Date: 11/2/2022 10:20:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/2/2022
-- Description:	Adding Foreign Keys
-- =============================================
ALTER PROCEDURE [Project2].[AddForeignKeysToStarSchemaData]
@MemberKey AS INT 
AS
BEGIN
    SET NOCOUNT ON;
    -- interfering with SELECT statements.
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Adding Foreign Keys';
	DECLARE @WorkFlowStepTableRowCount INT =0;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;


	ALTER TABLE [CH01-01-Dimension].DimProduct
		ADD CONSTRAINT FK_DimProduct_ProductSubcategory
			FOREIGN KEY (ProductSubcategoryKey) REFERENCES [CH01-01-Dimension].DimProductSubcategory (ProductSubcategoryKey);

	ALTER TABLE [CH01-01-Dimension].DimProductSubcategory
		ADD CONSTRAINT FK_ProductSubcategory_ProductCategory
			FOREIGN KEY	(productCategoryKey) REFERENCES [CH01-01-Dimension].DimProductCategory (ProductCategoryKey);

	ALTER TABLE [CH01-01-Fact].DATA
		ADD CONSTRAINT FK_Data_DimCustomer
			FOREIGN KEY (CustomerKey) REFERENCES [CH01-01-Dimension].DimCustomer (CustomerKey)

	ALTER TABLE [CH01-01-Fact].Data
		ADD CONSTRAINT FK_Data_DimGender
			FOREIGN KEY (Gender) REFERENCES [CH01-01-Dimension].DimGender (Gender)

	ALTER TABLE [CH01-01-Fact].Data
		ADD CONSTRAINT FK_Data_DimMaritalStatus
			FOREIGN KEY (MaritalStatus) REFERENCES [CH01-01-Dimension].DimMaritalStatus (MaritalStatus)

	ALTER TABLE [CH01-01-Fact].Data
		ADD CONSTRAINT FK_Data_DimProduct
			FOREIGN KEY (ProductKey) REFERENCES [CH01-01-Dimension].DimProduct(ProductKey)

	ALTER TABLE [CH01-01-Fact].Data		
		ADD CONSTRAINT FK_Data_DimOccupation
			FOREIGN KEY (OccupationKey) REFERENCES [CH01-01-Dimension].DimOccupation (OccupationKey)

	ALTER TABLE [CH01-01-Fact].Data
		ADD CONSTRAINT FK_Data_SalesManagers
			FOREIGN KEY (SalesManagerKey) REFERENCES [CH01-01-Dimension].SalesManagers (SalesManagerKey)

	ALTER TABLE [CH01-01-Fact].Data
		ADD CONSTRAINT FK_Data_DimOrderDate
			FOREIGN KEY (OrderDate) REFERENCES [CH01-01-Dimension].DimOrderDate (OrderDate)

	ALTER TABLE [CH01-01-Fact].Data
		ADD CONSTRAINT FK_Data_DimTerritory
			FOREIGN KEY (TerritoryKey) REFERENCES [CH01-01-Dimension].DimTerritory(TerritoryKey)

		
		
		
		

/*

		ALTER TABLE [Process].[WorkflowSteps]  WITH CHECK ADD  CONSTRAINT [FK_WorkflowSteps_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
	REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
	GO

	ALTER TABLE [Process].[WorkflowSteps] CHECK CONSTRAINT [FK_WorkflowSteps_UserAuthorization]
	GO
*/



	SELECT @EndingDateTime = SYSDATETIME();

	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @MemberKey;
PRINT 'Foreign Keys Added back'
END;
