SuperStrict

Const SCREEN_WIDTH:Int = 800
Const SCREEN_HEIGHT:Int = 600

Graphics SCREEN_WIDTH, SCREEN_HEIGHT

Local enemies:TList = CreateList()

Local cont:Int = True
While cont
	If AppTerminate() Or KeyHit(KEY_ESCAPE) cont = False

	If enemies.Count() < 1
		Local newEnemy:Enemy = newEnemy(20, SCREEN_WIDTH - 20)
		enemies.AddLast(newEnemy)
	End If
	
	tickSprites(enemies)

'	TODO: Get conditions working	
'	Local s:Sprite = getFirstSpriteWithCond(enemies, isEnemySuccessful)
'	While s != Null
'		enemies.Remove(s)
'		s = getFirstSpriteWithCond(enemies, isEnemySuccessful)
'	Wend

	Cls
	drawBackground()
	drawSprites(enemies)
	Flip
Wend

Function drawBackground()
	Local sz_bg:Int = 20
	DrawRect(0, 0, SCREEN_WIDTH, sz_bg)
	DrawRect(0, SCREEN_HEIGHT - sz_bg, SCREEN_WIDTH, sz_bg)
End Function

Type Rect
	Field x:Int, y:Int, w:Int, h:Int
End Type

Function newRect:Rect(x:Int, y:Int, w:Int, h:Int)
	Local r:Rect = New Rect
	r.x = x
	r.y = y
	r.w = w
	r.h = h
	Return r
End Function

Function drawRectWithRect(r:Rect)
	DrawRect r.x, r.y, r.w, r.h
End Function

Type Sprite
	Field rect:Rect
	
	Method Tick()
	End Method
End Type

Function tickSprites(sprites:TList)
	For Local s:Sprite = EachIn sprites
		s.Tick()
	Next
End Function

Function drawSprites(sprites:TList)
	For Local s:Sprite = EachIn sprites
		drawRectWithRect(s.rect)
	Next
End Function

Function getFirstSpriteWithCond:Sprite(sprites:TList, cond:Int(s:Sprite))
	For Local s:Sprite = EachIn sprites
		If cond(s) Return s
	Next
	Return Null
End Function

Type Enemy Extends Sprite
	Field spd:Int = 1

	Method Tick()
		rect.x = rect.x + spd
	End Method
End Type

Function newEnemy:Enemy(minY:Int, maxY:Int)
	Local newY:Int = Rand(minY, maxY)
	Local newEnemy:Enemy = New Enemy
	newEnemy.rect = newRect(0, newY, 20, 20)
	Return newEnemy
End Function

Function isEnemySuccessful:Int(s:Sprite)
	Return s.rect.x > SCREEN_WIDTH
End Function