SuperStrict

Include "utilities.bmx"
Include "sprite.bmx"
Include "button.bmx"
Include "enemy.bmx"

Const SCREEN_WIDTH:Int = 800
Const SCREEN_HEIGHT:Int = 600
Const HUD_WIDTH:Int = 700
Const HUD_HEIGHT:Int = 20
Const ARENA_WIDTH:Int = 700
Const ARENA_HEIGHT:Int = 580
Const MENU_WIDTH:Int = 100
Const MENU_HEIGHT:Int = 600

Graphics SCREEN_WIDTH, SCREEN_HEIGHT

Local enemies:TList = CreateList()
Local buttons:TList = CreateList()

Local towerButton:Button = newButton(ARENA_WIDTH + 50, 50, 20, 20)
buttons.AddLast(towerButton)

Local cont:Int = True
While cont
	If AppTerminate() Or KeyHit(KEY_ESCAPE) cont = False

	If enemies.Count() < 1
		Local newEnemy:Enemy = newEnemy(HUD_HEIGHT, HUD_HEIGHT + ARENA_HEIGHT)
		enemies.AddLast(newEnemy)
	End If
	
	tickSprites(enemies)
	tickSprites(buttons)

	Local s:Sprite = getFirstSpriteWithCond(enemies, isEnemySuccessful)
	While s
		enemies.Remove(s)
		s = getFirstSpriteWithCond(enemies, isEnemySuccessful)
	Wend
	

	Cls
	drawSprites(enemies)
	drawBackground()
	drawMenu()
	drawSprites(buttons)
	Flip
Wend

Function drawBackground()
	Local sz_bg:Int = 20
	DrawRect(0, HUD_HEIGHT, SCREEN_WIDTH, sz_bg)
	DrawRect(0, HUD_HEIGHT + ARENA_HEIGHT - sz_bg, SCREEN_WIDTH, sz_bg)
End Function

Function drawMenu()
	SetColor 100, 100, 100
	DrawRect(ARENA_WIDTH, 0, MENU_WIDTH, MENU_HEIGHT)
	SetColor 255, 255, 255
End Function