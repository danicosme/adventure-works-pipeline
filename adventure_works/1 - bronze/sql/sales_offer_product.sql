SELECT TOP 5
	SpecialOfferID
	,ProductID
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM sales.SpecialOfferProduct
