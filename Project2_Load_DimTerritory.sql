USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimTerritory]    Script Date: 11/6/2022 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/5/2022
-- Description:	Loading DimTerritory Table
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimTerritory]
@GroupMemberAuthorizationKey AS INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @WorkFlowDescription NVARCHAR(100) = 'Loading DimTerritory Table';
	DECLARE @WorkFlowStepTableRowCount INT;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
	DECLARE @EndingDateTime DATETIME2;

	INSERT INTO [CH01-01-Dimension].DimTerritory
	(
	    TerritoryGroup,
	    TerritoryCountry,
	    TerritoryRegion,
	    userAuthorizationKey
	   
	)
	SELECT DISTINCT
		old.TerritoryGroup,
		old.TerritoryCountry,
		old.TerritoryRegion,
		@GroupMemberAuthorizationKey

	FROM FileUpload.OriginallyLoadedData AS old

	SELECT @WorkFlowStepTableRowCount =  COUNT(*) FROM [CH01-01-Dimension].DimTerritory;
	SELECT @EndingDateTime = SYSDATETIME();

	EXEC process.usp_trackWorkFlows @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @GroupMemberAuthorizationKey;
	PRINT 'Loaded DimTerritory Table'
	
	END
