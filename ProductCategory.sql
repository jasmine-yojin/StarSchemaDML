USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimProductCategory]    Script Date: 11/3/2022 1:31:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 10/30/22 
-- Description:	Load ProductCategory Table
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProductCategory]
	@MemberKey AS INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Loading DimProductCategory';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;

	INSERT INTO [CH01-01-Dimension].DimProductCategory
	(
	    productCategory,
	    userAuthrizationKey
	)
	SELECT DISTINCT
	    OLD.ProductCategory,      -- productCatetory - varchar(20)
	    @MemberKey       -- userAuthrizationKey - int
	    
	FROM FileUpload.OriginallyLoadedData AS OLD

	SELECT @WorkFlowStepTableRowCount =  COUNT(*) FROM [CH01-01-Dimension].DimProductCategory;
	SELECT @EndingDateTime = SYSDATETIME();

	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @MemberKey;

END


