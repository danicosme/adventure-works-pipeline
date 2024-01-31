SELECT TOP 5
	SalesOrderID
	,SalesOrderDetailID
	,CarrierTrackingNumber
	,OrderQty
	,ProductID
	,SpecialOfferID
	,UnitPrice
	,UnitPriceDiscount
	,LineTotal
	,CreationDate
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM sales.SalesOrderDetail
