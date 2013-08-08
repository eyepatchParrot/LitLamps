Type Controller
	Field TheView:View
	Field TheModel:Model
	
	Method Tick()
		If Self.numEnemies() < 1
			Self.spawnEnemy(HUD_HEIGHT, HUD_HEIGHT + ARENA_HEIGHT)
		End If
		
		Self.tickEnemies()
		Self.checkForSuccessfulEnemies()
	End Method
	
	Method GetEnemies:TList()
		Return Self.TheModel.Enemies
	End Method

	Method GetTileAt:Tile(x:Int, y:Int)
		If x >= NUM_TILES_X Or y >= NUM_TILES_Y
			DebugLog "Invalid GetTileAt"
			DebugStop
		EndIf
		
		Return TheModel.Tiles[x, y]
	End Method

	Method numEnemies:Int()
		Return Self.TheModel.Enemies.Count()
	End Method
	
	Method spawnEnemy(minY:Int, maxY:Int)
		Self.TheModel.Enemies.AddLast(NewEnemy(HUD_HEIGHT, HUD_HEIGHT + ARENA_HEIGHT))
	End Method
	
	Method tickEnemies()
		For Local e:Enemy = EachIn Self.GetEnemies()
			e.Tick()
		Next
	End Method
	
	Method getFirstSuccessFulEnemy:Enemy()
		For Local e:Enemy = EachIn Self.GetEnemies()
			If e.getX() > ARENA_WIDTH
				Return e
			EndIf
		Next
		Return Null
	End Method
	
	Method checkForSuccessfulEnemies()
		Local e:Enemy = getFirstSuccessfulEnemy()
		While e
			Self.TheModel.Enemies.Remove(e)
			e = getFirstSuccessfulEnemy()
		Wend
	End Method
End Type

Function NewController:Controller()
	Local c:Controller = New Controller
	Return c
End Function