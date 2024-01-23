SELECT TOP 5
	CustomerID
	,PersonID
	,StoreID
	,TerritoryID
	,AccountNumber
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM sales.customer
