SELECT TOP 5
	BusinessEntityID
	,PersonType
	,NameStyle
	,Title
	,FirstName
	,MiddleName
	,LastName
	,Suffix
	,EmailPromotion
	,AdditionalContactInfo
	,Demographics
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM person.person
