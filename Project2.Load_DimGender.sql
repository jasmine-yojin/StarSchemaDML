USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimGender]    Script Date: 11/6/2022 11:41:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/5/2022
-- Description:	Load DimGender Table
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimGender]
@GroupMemberAuthorizationKey AS INT 
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
	 
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Loading DimGender Table';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;

	INSERT INTO [CH01-01-Dimension].DimGender
	(
	    Gender,
	    GenderDescription,
		UserAuthorizationKey
	)
	SELECT DISTINCT
		old.Gender, -- Gender - char(1)
	    GenderDescription= CASE
								WHEN old.Gender ='M' THEN 'Male'
								WHEN old.Gender = 'F' THEN 'Female'
								ELSE 'Unknown'
								End, 
		@GroupMemberAuthorizationKey
	FROM FileUpload.OriginallyLoadedData AS old


	SELECT @WorkFlowStepTableRowCount =  COUNT(*) FROM [CH01-01-Dimension].DimGender;
	SELECT @EndingDateTime = SYSDATETIME();
	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberAuthorizationKey;
PRINT 'Loaded DimGender Table'
END;