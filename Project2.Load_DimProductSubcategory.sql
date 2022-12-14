USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimProductSubcategory]    Script Date: 11/5/2022 8:58:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 10/30/2022
-- Description:	Load Product Subcategory Table
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProductSubcategory]
	@GroupMemberUserAuthorizationKey AS INT 
AS
BEGIN
    SET NOCOUNT ON; --added to prevent extra result sets from
    -- interfering with SELECT statements.
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Loading DimProductSubcategory';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;


	INSERT INTO [CH01-01-Dimension].DimProductSubcategory
	(
	    ProductSubcategory,
		productCategoryKey,
	    userAuthrizationKey
		
	)
	SELECT DISTINCT
	    old.ProductSubcategory,      -- ProductSubcategory - varchar(20)
	    pc.productCategoryKey,
		@GroupMemberUserAuthorizationKey       -- userAuthrizationKey - int
	 FROM FileUpload.OriginallyLoadedData AS old
		INNER JOIN [CH01-01-Dimension].DimProductCategory AS pc
			ON pc.productCategory = old.ProductCategory;

	 SELECT @WorkFlowStepTableRowCount =  COUNT(*) FROM [CH01-01-Dimension].DimProductSubcategory;
	SELECT @EndingDateTime = SYSDATETIME();
	 
	 EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberUserAuthorizationKey;

	PRINT 'ProductSubcategory Table loaded'
END;
