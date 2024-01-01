SELECT TOP 5
	AddressID
	,AddressLine1
	,AddressLine2
	,City
	,StateProvinceID
	,PostalCode
	,SpatialLocation
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dh_ingestao_bronze
FROM person.address
