SELECT TOP 5
	CustomerID
	,PersonID
	,StoreID
	,TerritoryID
	,AccountNumber
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dh_ingestao_bronze
FROM sales.customer
