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
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dh_ingestao_bronze
FROM sales.SalesOrderDetail
