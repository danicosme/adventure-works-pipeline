SELECT TOP 5
	BusinessEntityID
	,TerritoryID
	,SalesQuota
	,Bonus
	,CommissionPct
	,SalesYTD
	,SalesLastYear
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dh_ingestao_bronze
FROM sales.SalesPerson
