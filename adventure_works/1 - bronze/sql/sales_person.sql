SELECT TOP 50
	BusinessEntityID
	,TerritoryID
	,SalesQuota
	,Bonus
	,CommissionPct
	,SalesYTD
	,SalesLastYear
	,CreationDate
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM sales.SalesPerson
