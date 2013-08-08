Const TILE_SIZE:Int = 20
Const CONTAINS_NOTHING:Int = 0
Const CONTAINS_TOWER:Int   = 1

Type Tile
	Field x:Int, y:Int
	Field contains:Int
End Type

Function NewTile:Tile(x:Int, y:Int)
	Local t:Tile = New Tile
	t.x = x
	t.y = y
	t.contains = CONTAINS_NOTHING
	Return t
End Function