Type Sprite
	Field rect:Rect
	
	Method initSprite(x:Int, y:Int, w:Int, h:Int)
		Self.rect = newRect(x, y, w, h)
	End Method
	
	Method GetX:Int()
		Return rect.x
	End Method
	
	Method GetY:Int()
		Return rect.y
	End Method
	
	Method GetW:Int()
		Return rect.w
	End Method
	
	Method GetH:Int()
		Return rect.h
	End Method
	
	Method Tick()
	End Method
End Type

Function NewSprite:Sprite(x:Int, y:Int, w:Int, h:Int)
	Local s:Sprite = New Sprite
	s.initSprite(x, y, w, h)
	Return s
End Function