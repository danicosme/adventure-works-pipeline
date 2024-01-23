SELECT TOP 5
	SalesOrderID
	,RevisionNumber
	,OrderDate
	,DueDate
	,ShipDate
	,Status
	,OnlineOrderFlag
	,SalesOrderNumber
	,PurchaseOrderNumber
	,AccountNumber
	,CustomerID
	,SalesPersonID
	,TerritoryID
	,BillToAddressID
	,ShipToAddressID
	,ShipMethodID
	,CreditCardID
	,CreditCardApprovalCode
	,CurrencyRateID
	,SubTotal
	,TaxAmt
	,Freight
	,TotalDue
	,Comment
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM sales.SalesOrderHeader
