USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_SalesManagers]    Script Date: 11/5/2022 9:01:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/2/2022
-- Description:	Load SalesManager Table
-- =============================================
ALTER PROCEDURE [Project2].[Load_SalesManagers] 
@GroupMemberUserAuthorizationKey AS INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Loading SalesManagers Table';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;
	   
	INSERT INTO [CH01-01-Dimension].SalesManagers
	(
		Category,
		SalesManager,
		Office,
		UserAuthorizationKey
	)
	SELECT DISTINCT
		old.ProductCategory,
		old.SalesManager,
		Office = CASE
					 WHEN old.SalesManager LIKE 'Marco%' THEN
						 'Redmond'
					 WHEN old.SalesManager LIKE 'Alberto%' THEN
						 'Seattle'
					 WHEN old.SalesManager LIKE 'Maurizio%' THEN
						 'Redmond'
					 ELSE
						 'Seattle'
				 END,
		@GroupMemberUserAuthorizationKey
	FROM FileUpload.OriginallyLoadedData AS old
	--ORDER BY old.SalesManagerKey;

	SELECT @WorkFlowStepTableRowCount =  COUNT(*) FROM [CH01-01-Dimension].SalesManagers;
	SELECT @EndingDateTime = SYSDATETIME();

	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberUserAuthorizationKey;

	PRINT 'Loaded SalesManager Table'
END
