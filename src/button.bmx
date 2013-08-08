Const BUTTONSTATE_CLICKABLE:Int   = 0
Const BUTTONSTATE_MOUSEOVER:Int   = 1
Const BUTTONSTATE_CLICKED:Int     = 2
Const BUTTONSTATE_UNCLICKABLE:Int = 3

Type Button Extends Sprite
	Field State:Int
	Field HasBeenClicked:Int
	Field ID:Int
	
	Method initButton(x:Int, y:Int, w:Int, h:Int, ID:Int)
		Self.initSprite(x, y, w, h)
		Self.State = BUTTONSTATE_CLICKABLE
		Self.HasBeenClicked = False
		Self.ID = ID
	End Method
	
	Method isMouseOver:Int()
		Return MouseX() > Self.rect.x And MouseX() < Self.rect.x + Self.rect.w And MouseY() > Self.rect.y And MouseY() < Self.rect.y + Self.rect.h
	End Method

	Method Tick()
		Select state
			Case BUTTONSTATE_CLICKABLE
				If isMouseOver() And Not MouseDown(MOUSE_LEFT)
					State = BUTTONSTATE_MOUSEOVER
				EndIf
			
			Case BUTTONSTATE_MOUSEOVER
				If isMouseOver() And MouseDown(MOUSE_LEFT)
					State = BUTTONSTATE_CLICKED
				Else If Not isMouseOver()
					State = BUTTONSTATE_CLICKABLE
				EndIf
			
			Case BUTTONSTATE_CLICKED
				If isMouseOver() And Not MouseDown(MOUSE_LEFT)
					HasBeenClicked = True
					State = BUTTONSTATE_CLICKABLE
				ElseIf Not isMouseOver() And Not MouseDown(MOUSE_LEFT)
					State = BUTTONSTATE_CLICKABLE
				EndIf
		End Select
	End Method
	
	Method Draw()
		Select Self.state
			Case BUTTONSTATE_CLICKABLE
				SetColor(0, 200, 0)
			
			Case BUTTONSTATE_MOUSEOVER
				SetColor(0, 255, 0)
			
			Case BUTTONSTATE_CLICKED
				SetColor(0, 150, 0)
				
			Case BUTTONSTATE_UNCLICKABLE
				SetColor(50, 150, 50)
			
		End Select
		
		drawRectWithRect(Self.rect)
	End Method
End Type

Function newButton:Button(x:Int, y:Int, w:Int, h:Int, ID:Int)
	Local newButton:Button = New Button
	newButton.initButton(x, y, w, h, ID)
	Return newButton
End Function

