SuperStrict

Include "utilities.bmx"
Include "sprite.bmx"
Include "button.bmx"
Include "enemy.bmx"
Include "view.bmx"
Include "controller.bmx"
Include "model.bmx"
Include "tile.bmx"

Graphics SCREEN_WIDTH, SCREEN_HEIGHT

Local theView:View = NewView()
Local theController:Controller = NewController()
Local theModel:Model = NewModel()
setMVC(theView, theController, theModel)

Local cont:Int = True
While cont
	If AppTerminate() Or KeyHit(KEY_ESCAPE) cont = False
	
	theController.Tick()
	
	theView.Draw()
Wend

Function setMVC(theView:View, theController:Controller, theModel:Model)
	theView.TheController = theController
	theController.TheView = theView
	theController.TheModel = theModel
End Function