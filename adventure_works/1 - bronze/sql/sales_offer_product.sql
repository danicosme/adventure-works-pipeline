SELECT TOP 5
	SpecialOfferID
	,ProductID
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dh_ingestao_bronze
FROM sales.SpecialOfferProduct
