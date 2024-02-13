SELECT TOP 50
	ProductID
	,Name
	,ProductNumber
	,MakeFlag
	,FinishedGoodsFlag
	,Color
	,SafetyStockLevel
	,ReorderPoint
	,StandardCost
	,ListPrice
	,Size
	,SizeUnitMeasureCode
	,WeightUnitMeasureCode
	,Weight
	,DaysToManufacture
	,ProductLine
	,Class
	,Style
	,ProductSubcategoryID
	,ProductModelID
	,SellStartDate
	,SellEndDate
	,DiscontinuedDate
	,CreationDate
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM production.product
