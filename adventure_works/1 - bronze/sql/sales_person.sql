SELECT TOP 5
	BusinessEntityID
	,TerritoryID
	,SalesQuota
	,Bonus
	,CommissionPct
	,SalesYTD
	,SalesLastYear
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM sales.SalesPerson
