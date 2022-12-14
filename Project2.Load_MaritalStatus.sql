USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimMaritalStatus]    Script Date: 11/6/2022 11:43:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/5/2022
-- Description:	Load Marital Status Table
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimMaritalStatus]
@GroupMemberAuthorizationKey AS INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Loading MaritalStatus Table';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;

	INSERT INTO [CH01-01-Dimension].DimMaritalStatus
	(
	    MaritalStatus,
	    MaritalStatusDescription,					
		UserAuthorizationKey
	)
	SELECT DISTINCT 
	   old.MaritalStatus, -- MaritalStatus - char(1)
	   MaritalStatusDescription = CASE 
										WHEN old.MaritalStatus = 'M' THEN 'Married'
										WHEN old.MaritalStatus = 'S' THEN 'Single'
										ELSE 'Unknown'
										END
	   ,@GroupMemberAuthorizationKey
	FROM FileUpload.OriginallyLoadedData AS old

	SELECT @WorkFlowStepTableRowCount =  COUNT(*) FROM [CH01-01-Dimension].DimMaritalStatus;
	SELECT @EndingDateTime = SYSDATETIME();

	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberAuthorizationKey;
PRINT 'Loaded MaritalStatus Table'

END
