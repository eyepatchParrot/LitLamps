Const SCREEN_WIDTH:Int  = 800
Const SCREEN_HEIGHT:Int = 600
Const HUD_WIDTH:Int    = 700
Const HUD_HEIGHT:Int   = 20
Const ARENA_WIDTH:Int  = 700
Const ARENA_HEIGHT:Int = 580
Const MENU_WIDTH:Int   = 100
Const MENU_HEIGHT:Int  = 600
Const BUTTON_TOWER:Int  = 0
Const TOOL_TOWER:Int  = 0

Type View
	Field TheController:Controller
	Field buttons:TList
	Field selectedTool:Int
	Field mouseWasDown:Int
		
	Method Draw()
		tickButtons()
		checkForClickedButtons()
		checkForToolUse()
	
		Cls
		drawEnemies()
		drawTiles()
		drawBackground()
		drawHud()
		drawMenu()
		drawTool()
		Flip
	End Method
	
	Method tickButtons()
		For Local b:Button = EachIn Self.buttons
			b.Tick()
		Next
	End Method
	
	Method checkForClickedButtons()
		For Local b:Button = EachIn Self.buttons
			If b.HasBeenClicked
				Select b.ID
					Case BUTTON_TOWER
						selectedTool = TOOL_TOWER
						b.HasBeenClicked = False
				End Select
			EndIf
		Next
	End Method
	
	Method checkForToolUse()
		If Not MouseDown(MOUSE_LEFT) And Self.mouseWasDown And isMouseOverTile()
			Self.mouseWasDown = False
			Self.useTool()
		Else If MouseDown(MOUSE_LEFT)
			Self.mouseWasDown = True
		EndIf
	End Method
	
	Method useTool()
		Local t:Tile = Self.getSelectedTile()
		Select selectedTool
			Case TOOL_TOWER
				Self.TheController.BuyTowerAt(t)
		End Select
	End Method
					
	
	Method drawEnemies()
		SetColor 255, 0, 0
		For Local e:Sprite = EachIn Self.TheController.GetEnemies()
			DrawRect e.GetX(), e.GetY(), e.GetW(), e.GetH()
		Next
	End Method
	
	Method drawTiles()
		For Local i:Int = 0 Until NUM_TILES_X
			For Local j:Int = 0 Until NUM_TILES_Y
				Local t:Tile = Self.TheController.GetTileAt(i, j)
				Select t.contains
					Case CONTAINS_TOWER
						SetColor 0, 0, 200
						Self.drawRectAt(t)
				End Select
			Next
		Next
	End Method

	Method drawBackground()
		Local sz_bg:Int = 20
		SetColor 255, 255, 255
		DrawRect(0, HUD_HEIGHT, SCREEN_WIDTH, sz_bg)
		DrawRect(0, HUD_HEIGHT + ARENA_HEIGHT - sz_bg, SCREEN_WIDTH, sz_bg)
	End Method
	
	Method drawHud()
		SetColor 255, 255, 255
		Local moneyText:String = "Money : " + String(Self.TheController.GetMoney())
		DrawText moneyText, 10, 0
	End Method
	
	Method drawMenu()
		SetColor 100, 100, 100
		DrawRect(ARENA_WIDTH, 0, MENU_WIDTH, MENU_HEIGHT)
		
		drawButtons()
	End Method
	
	Method drawButtons()
		For Local b:Button = EachIn Self.buttons
			b.Draw()
		Next
	End Method
	
	Method drawTool()
		If Self.isMouseOverTile()
			Local selectedTile:Tile = Self.getSelectedTile()
			If Self.canUseSelectedToolAt(selectedTile)
				SetColor 0, 100, 0
			Else
				SetColor 100, 0, 0
			EndIf
			Self.drawRectAt(selectedTile)
		EndIf
	End Method
	
	Method getSelectedTile:Tile()
		If Not Self.isMouseOverTile()
			DebugLog "Mouse must be over valid tile for getSelectedTile() to make sense."
			DebugStop
		EndIf
		Local tileX:Int = MouseX() / Self.getTileWidth()
		Local tileY:Int = (MouseY() - HUD_HEIGHT) / Self.getTileHeight()
		Return Self.TheController.GetTileAt(tileX, tileY)
	End Method
		
	Method isMouseOverTile:Int()
		Return MouseX() < ARENA_WIDTH And MouseY() < (ARENA_HEIGHT + HUD_HEIGHT) And MouseY() > HUD_HEIGHT
	End Method
		
	Method drawRectAt(t:Tile)
		Local tileW:Int = Self.getTileWidth()
		Local tileH:Int = Self.getTileHeight()
		Local drawX:Int = t.x * tileW
		Local drawY:Int = t.y * tileH + HUD_HEIGHT
		DrawRect drawX, drawY, tileW, tileH
	End Method
	
	Method getTileWidth:Int()
		Return ARENA_WIDTH / NUM_TILES_X
	End Method
	
	Method getTileHeight:Int()
		Return ARENA_HEIGHT / NUM_TILES_Y
	End Method
	
	Method canUseSelectedToolAt:Int(selectedTile:Tile)
		Select Self.selectedTool
			Case TOOL_TOWER
				Return selectedTile.contains = CONTAINS_NOTHING
		End Select
		
		Return False
	End Method
End Type

Function NewView:View()
	Local v:View = New View
	v.buttons = CreateList()
	Local menuX:Int = ARENA_WIDTH
	v.buttons.AddLast(NewButton(menuX + 50, 50, 20, 20, BUTTON_TOWER))

	Return v
End Function