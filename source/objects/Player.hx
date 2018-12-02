package objects;

import zero.flxutil.ecs.Entity;
import zero.flxutil.input.Controller;

class Player extends Entity
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

}