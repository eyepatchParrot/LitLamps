Type Sprite
	Field rect:Rect
	
	Method initSprite(x:Int, y:Int, w:Int, h:Int)
		Self.rect = newRect(x, y, w, h)
	End Method
	
	Method Tick()
	End Method
	
	Method Draw()
		SetColor(255, 255, 255)
		drawRectWithRect(rect)
	End Method
End Type

Function newSprite:Sprite(x:Int, y:Int, w:Int, h:Int)
	Local s:Sprite = New Sprite
	s.initSprite(x, y, w, h)
	Return s
End Function

Function tickSprites(sprites:TList)
	For Local s:Sprite = EachIn sprites
		s.Tick()
	Next
End Function

Function drawSprites(sprites:TList)
	For Local s:Sprite = EachIn sprites
		s.Draw()
	Next
End Function

Function getFirstSpriteWithCond:Sprite(sprites:TList, cond:Int(s:Sprite))
	For Local s:Sprite = EachIn sprites
		If cond(s) Return s
	Next
	Return Null
End Function