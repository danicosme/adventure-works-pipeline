SELECT TOP 50
	SpecialOfferID
	,ProductID
	,CreationDate
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM sales.SpecialOfferProduct
