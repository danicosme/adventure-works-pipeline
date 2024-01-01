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
	,CURRENT_TIMESTAMP AS dh_ingestao_bronze
FROM person.person
