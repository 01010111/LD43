package objects;

import flixel.FlxObject;
import flixel.math.FlxPoint;
import zero.flxutil.ecs.Entity;
import zero.flxutil.input.Controller;
import zero.flxutil.input.PlayerController;
import zero.flxutil.ecs.components.*;

using zero.ext.flx.FlxSpriteExt;

class Skeleman extends Entity
{

	var controller:Controller;
	var ball:Ball;

	public function new(x:Float, y:Float, controller:Controller)
	{
		this.controller = controller;
		controller.add();
		super({
			x: x, y: y,
			components: [
				new PlatformerJumper({
					controller: controller,
					jump_power: 300,
					jump_button: FACE_A,
					coyote_time: 0.075
				}),
				new PlatformerWalker({
					controller: controller,
					walk_speed: 150,
					acceleration_force: 800,
					drag_force: 800
				}),
				new PlatformerAnimator(),
			]
		});
		loadGraphic(AssetPaths.skullman__png, true, 16, 20);
		animation.add('idle', [0, 1, 2, 1], 10);
		animation.add('walk', [3, 3, 4, 5, 6, 6, 7, 8], 30);
		animation.add('fall', [9]);
		animation.add('jump', [10]);
		acceleration.y = 800;
		this.set_facing_flip_horizontal();
		this.make_anchored_hitbox(12, 14);
	}

	public function set_ball(ball:Ball) this.ball = ball;

	override public function update(dt:Float)
	{
		super.update(dt);

		if (ball.state == HELD && controller.just_pressed(FACE_B)) ball.fire(get_ball_velocity());
		if (ball.available) FlxG.overlap(this, ball, (e:FlxSprite, b:Ball) -> b.set_state(HELD));
	}

	function get_ball_velocity():FlxPoint
	{
		return (facing == FlxObject.LEFT ? 180 : 0).vector_from_angle(400).to_flx();
	}

}