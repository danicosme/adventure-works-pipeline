SELECT TOP 5
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
	,ModifiedDate
	,CURRENT_TIMESTAMP AS dt_ingestion_bronze
FROM production.product
