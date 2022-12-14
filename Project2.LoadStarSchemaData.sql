USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[LoadStarSchemaData]    Script Date: 11/6/2022 11:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName
-- Create date: 
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[LoadStarSchemaData]
    -- Add the parameters for the stored procedure here
AS
BEGIN
    SET NOCOUNT ON;

    --
    --	Drop All of the foreign keys prior to truncating tables in the star schema
 	--
    EXEC  [Project2].[DropForeignKeysFromStarSchemaData] @GroupMemberUserAuthorizationKey = 1;
	--
	--	Check row count before truncation
	EXEC	[Project2].[ShowTableStatusRowCount] 
		--@GroupMemberUserAuthorizationKey = 1  -- Change -1 to the appropriate UserAuthorizationKey
		@TableStatus = N'''Pre-truncate of tables'''
    --
    --	Always truncate the Star Schema Data
    --
    EXEC [Project2].[TruncateStarSchemaData] @GroupMemberUserAuthorizationKey = 1;
    --
    --	Load the star schema
    --
    EXEC  [Project2].[Load_DimProductCategory] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimProductSubcategory] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimProduct] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_SalesManagers] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimGender] @GroupMemberAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimMaritalStatus] @GroupMemberAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimOccupation] @GroupMemberAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimOrderDate] @GroupMemberAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimTerritory] @GroupMemberAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimCustomer] @GroupMemberAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_Data] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
  --
    --	Recreate all of the foreign keys prior after loading the star schema
    --
 	--
	--	Check row count before truncation
	EXEC	[Project2].[ShowTableStatusRowCount]
		--@GroupMemberUserAuthorizationKey = -1,  -- Change -1 to the appropriate UserAuthorizationKey
		@TableStatus = N'''Row Count after loading the star schema'''
	--
   EXEC [Project2].[AddForeignKeysToStarSchemaData] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    --
END;
