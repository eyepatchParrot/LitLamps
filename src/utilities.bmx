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
