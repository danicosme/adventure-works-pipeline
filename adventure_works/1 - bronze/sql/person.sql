SELECT TOP 50
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
	,CreationDate
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM person.person
