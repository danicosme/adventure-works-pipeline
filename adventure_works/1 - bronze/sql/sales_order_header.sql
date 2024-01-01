SELECT TOP 5
	*,
	CURRENT_TIMESTAMP AS dh_ingestao_bronze
FROM sales.SalesOrderHeader
