USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[CreateSequences]    Script Date: 11/2/2022 9:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasmine Kim
-- Create date: 11/2/2022
-- Description:	Creates Sequences
-- =============================================

ALTER PROCEDURE [Project2].[CreateSequences] 

AS
BEGIN

	DROP SEQUENCE IF EXISTS PkSequence.DimProductProductKey
	CREATE SEQUENCE PkSequence.DimProductProductKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 
	

	DROP SEQUENCE IF EXISTS PkSequence.DimProductSubcategoryProductSubcategoryKey
	CREATE SEQUENCE PkSequence.DimProductSubcategoryProductSubcategoryKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 
	


	DROP SEQUENCE IF EXISTS PkSequence.DimProductCategoryProductCategoryKey
	CREATE SEQUENCE PkSequence.DimProductCategoryProductCategoryKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 


	DROP SEQUENCE IF EXISTS PkSequence.DimOccupationOccupationKey
	CREATE SEQUENCE PkSequence.DimOccupationOccupationKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 
	

	DROP SEQUENCE IF EXISTS PkSequence.DimTerritoryTerritoryKey
	CREATE SEQUENCE PkSequence.DimTerritoryTerritoryKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 
	

	DROP SEQUENCE IF EXISTS PkSequence.DimCustomerCustomerKey
	CREATE SEQUENCE PkSequence.DimCustomerCustomerKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 
	

	DROP SEQUENCE IF EXISTS PkSequence.DataSalesKey
	CREATE SEQUENCE PkSequence.DataSalesKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 
	

	DROP SEQUENCE IF EXISTS PkSequence.DimManagerSalesManagerSalesKey
	CREATE SEQUENCE PkSequence.DimManagerSalesManagerSalesKey
		AS INT
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 2147483647
		CACHE 
	


	DROP SEQUENCE IF EXISTS PkSequence.WorkFlowStepKey
	CREATE SEQUENCE PkSequence.WorkFlowStepKey
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
	

	DROP SEQUENCE IF EXISTS  PkSequence.UserAuthorizationKey
	CREATE SEQUENCE PkSequence.UserAuthorizationKey
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE

END;

 EXEC [Project2].[CreateSequences] 


