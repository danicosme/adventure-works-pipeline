SELECT TOP 5
	AddressID
	,AddressLine1
	,AddressLine2
	,City
	,StateProvinceID
	,PostalCode
	,SpatialLocation
	,CreationDate
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM person.address
