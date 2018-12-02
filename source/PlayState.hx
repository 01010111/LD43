package;

import flixel.FlxState;
import flixel.group.FlxGroup;
import objects.*;

class PlayState extends FlxState
{

	var objects:FlxGroup;
	var level:FlxGroup;

	override public function create():Void
	{
		bgColor = 0xFF415D66;
		super.create();

		objects = new FlxGroup();

		var ball = new Ball();
		objects.add(ball);

		var skele = new Skeleman(64, 64);
		objects.add(skele);

		ball.set_parent(skele);
		skele.set_ball(ball);

		level = new FlxGroup();

		var floor = new FlxSprite(0, FlxG.height - 32);
		floor.makeGraphic(FlxG.width, 32, 0xFF000000);
		floor.immovable = true;
		level.add(floor);
		
		var ceiling = new FlxSprite(0, 0);
		ceiling.makeGraphic(FlxG.width, 32, 0xFF000000);
		ceiling.immovable = true;
		level.add(ceiling);
		
		var wall_l = new FlxSprite(0, 0);
		wall_l.makeGraphic(32, FlxG.height, 0xFF000000);
		wall_l.immovable = true;
		level.add(wall_l);
		
		var wall_r = new FlxSprite(FlxG.width - 32, 0);
		wall_r.makeGraphic(32, FlxG.height, 0xFF000000);
		wall_r.immovable = true;
		level.add(wall_r);
		
		add(level);
		add(objects);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(level, objects);
	}
}
