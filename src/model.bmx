Const NUM_TILES_X:Int = 35
Const NUM_TILES_Y:Int = 25
Const COST_TOWER:Int = 100

Type Model
	Field Enemies:TList
	Field Tiles:Tile[,]
	Field Money:Int
End Type

Function NewModel:Model()
	Local m:Model = New Model
	m.Enemies = CreateList()
	m.Tiles = New Tile[NUM_TILES_X, NUM_TILES_Y]
	For Local i:Int = 0 Until NUM_TILES_X
		For Local j:Int = 0 Until NUM_TILES_Y
			m.Tiles[i, j] = NewTile(i, j)
		Next
	Next
	m.Money = 100
	Return m
End Function