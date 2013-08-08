Type Enemy Extends Sprite
	Field spd:Int = 2
	
	Method initEnemy(minY:Int, maxY:Int)
		Local newY:Int = Rand(minY, maxY)
		initSprite(0, newY, 20, 20)
	End Method

	Method Tick()
		rect.x = rect.x + spd
	End Method
End Type

Function NewEnemy:Enemy(minY:Int, maxY:Int)
	Local newEnemy:Enemy = New Enemy
	newEnemy.initEnemy(minY, maxY)
	Return newEnemy
End Function

Function isEnemySuccessful:Int(s:Sprite)
	Return s.rect.x > ARENA_WIDTH
End Function
