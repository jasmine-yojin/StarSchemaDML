USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimProduct]    Script Date: 11/5/2022 9:00:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/02/2022
-- Description:	Load DimProduct
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProduct]
	@GroupMemberUserAuthorizationKey AS INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Loading Product table';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;

	INSERT INTO [CH01-01-Dimension].DimProduct
	(
	    ProductSubcategoryKey,
	    ProductCategory,
	    ProductSubcategory,
	    ProductCode,
	    ProductName,
	    Color,
	    ModelName,
		userAuthorizationKey
	
	)
	SELECT 
	    DISTINCT ps.ProductSubcategoryKey,
	    old.ProductCategory, -- ProductCategory - varchar(20)
	    old.ProductSubcategory, -- ProductSubcategory - varchar(20)
	    old.productCode, -- ProductCode - varchar(10)
	    old.ProductName, -- ProductName - varchar(40)
	    old.Color, -- Color - varchar(10)
	    old.ModelName,  -- ModelName - varchar(30)
	    @GroupMemberUserAuthorizationKey
		
	FROM FileUpload.OriginallyLoadedData AS old
		INNER JOIN [CH01-01-Dimension].DimProductSubcategory AS ps
			ON ps.ProductSubcategory = old.ProductSubcategory

	SELECT @WorkFlowStepTableRowCount =  COUNT(*) FROM [CH01-01-Dimension].DimProductCategory;
	SELECT @EndingDateTime = SYSDATETIME();


	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberUserAuthorizationKey;
	PRINT 'Product table loaded.'
		   
END




