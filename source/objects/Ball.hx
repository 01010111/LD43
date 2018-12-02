package objects;

import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import zero.flxutil.ecs.Entity;

class Ball extends Entity
{

	var parent:FlxSprite;

	public var state:EBallState;
	public var available:Bool = false;

	public function new()
	{
		super();
		loadGraphic(AssetPaths.ball__png, true, 12, 12);
		animation.add('idle', [0]);
		animation.add('power', [1, 2, 3, 4, 5, 6, 7, 8], 48);
		elasticity = 0.75;
		set_state(HELD);
	}

	public function set_state(state:EBallState)
	{
		available = false;
		switch (state) {
			case HELD: do_held();
			case THROWN: do_thrown();
		}
		this.state = state;
	}

	function do_held() 
	{
		velocity.set();
		allowCollisions = 0x0000;
		available = false;
		acceleration.y = 0;
	}

	function do_thrown() 
	{
		allowCollisions = 0x1111;
		acceleration.y = 400;
		new FlxTimer().start(0.1, (_) -> available = true);
	}

	public function set_parent(parent:FlxSprite) this.parent = parent;

	public function fire(p:FlxPoint)
	{
		set_state(THROWN);
		velocity.copyFrom(p);
	}

	override public function update(dt:Float)
	{
		switch (state) {
			case HELD: setPosition(parent.x + (parent.facing == FlxObject.LEFT? - 6 : 6), parent.y - 2);
			case THROWN: 
		}
		super.update(dt);
	}

}

enum EBallState
{
	HELD;
	THROWN;
}