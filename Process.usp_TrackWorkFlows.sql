USE [BIClass]
GO
/****** Object:  StoredProcedure [group2].[usp_TrackWorkFlows]    Script Date: 11/2/2022 4:00:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Jasmine Kim
-- Create date: 10/30/2022
-- Description:	Keep track of the WorkFlow
-- =============================================
CREATE procedure [process].[usp_TrackWorkFlows]
	@WorkFlowDescription NVARCHAR(100),
	@WorkFlowStepTableRowCount INT,
	@StartingDateTime DATETIME2,
	@EndingDateTime DATETIME2,
	@UserAuthorizationKey INT 
AS
BEGIN
    SET NOCOUNT ON;

	INSERT INTO process.WorkflowSteps
	(
	    WorkFlowStepKey,
	    WorkFlowStepDescription,
	    WorkFlowStepTableRowCount,
	    StartingDateDate,
	    EndingDateTime,
	    UserAuthorizationKey
	)
	VALUES
	(   NEXT VALUE FOR PkSequence.WorkFlowStepKey,       -- WorkFlowStepKey - int
	    @WorkFlowDescription,     -- WorkFlowStepDescription - nvarchar(100)
	    @WorkFlowStepTableRowCount, -- WorkFlowStepTableRowCount - int
	    @StartingDateTime, -- StartingDateDate - datetime2(7)
	    @EndingDateTime, -- EndingDateTime - datetime2(7)
	    @UserAuthorizationKey -- UserAuthorizationKey - int
	 )

END;

