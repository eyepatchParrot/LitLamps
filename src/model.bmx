Const NUM_TILES_X:Int = 35
Const NUM_TILES_Y:Int = 25

Type Model
	Field Enemies:TList
	Field Tiles:Tile[,]
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
	Return m
End Function