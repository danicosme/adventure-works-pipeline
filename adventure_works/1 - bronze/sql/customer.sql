SELECT TOP 50
	CustomerID
	,PersonID
	,StoreID
	,TerritoryID
	,AccountNumber
	,CreationDate
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM sales.customer
