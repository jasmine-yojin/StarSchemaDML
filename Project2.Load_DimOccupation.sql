USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimOccupation]    Script Date: 11/6/2022 11:44:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/5/2022
-- Description:	Load DimOccupation Table
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimOccupation]
@GroupMemberAuthorizationKey AS INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Loading DimOccupation Table';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;

	INSERT INTO [CH01-01-Dimension].DimOccupation
	(
	    Occupation,
	    userAuthorizationKey
	)
	SELECT DISTINCT 
		old.occupation,
		@GroupMemberAuthorizationKey
	FROM FileUpload.OriginallyLoadedData AS old   


	SELECT @WorkFlowStepTableRowCount =  COUNT(*) FROM [CH01-01-Dimension].DimOccupation;
	SELECT @EndingDateTime = SYSDATETIME();

	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberAuthorizationKey;

PRINT 'Loaded DimOccupation Table'

END
