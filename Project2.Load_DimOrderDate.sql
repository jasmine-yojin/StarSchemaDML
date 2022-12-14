USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimOrderDate]    Script Date: 11/6/2022 11:44:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/5/2022
-- Description:	Loading DimOrderDate Table
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimOrderDate]
@GroupMemberAuthorizationKey AS INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Loading DimOrderDate Table';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;

	INSERT INTO [CH01-01-Dimension].DimOrderDate
	(
	    OrderDate,
	    MonthName,
	    MonthNumber,
	    Year,
	    userAuthorizationKey	   
	)	
	SELECT DISTINCT
		old.OrderDate,
		DATENAME(MONTH, old.OrderDate),
		DATEPART(MONTH, old.OrderDate),
		year (old.orderDate),
		@GroupMemberAuthorizationKey

	FROM FileUpload.OriginallyLoadedData AS old

	SELECT @WorkFlowStepTableRowCount =  COUNT(*) FROM [CH01-01-Dimension].DimOrderDate;
	SELECT @EndingDateTime = SYSDATETIME();

	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberAuthorizationKey;

PRINT 'Loaded DimOrderDate Table'

END
