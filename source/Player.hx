package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;

class Player extends FlxSprite
{
  public static var START_X:Float = 57;
  public static var START_Y:Float = 172;

  public static var WALL_LEFT:Int = 1 << 1;
  public static var WALL_RIGHT:Int = 1 << 2;
  public static var WALL_UP:Int = 1 << 3;
  public static var WALL:Int = WALL_LEFT|WALL_RIGHT|WALL_UP;

  public static var RUN_SPEED:Float = 100;

  private var _speed:Point;
  private var _gravity:Float = 600; 

  private var _jumpPressed:Bool = false;
  private var _grounded:Bool = false;
  private var _jumping:Bool = false;
  private var _landing:Bool = false;
  private var _justLanded:Bool = false;

  private var _groundedTimer:Float = 0;
  private var _groundedThreshold:Float = 0.07;
  
  private var collisionFlags:Int = 0;

  private var jumpTimer:Float = 0;
  private var jumpThreshold:Float = 0.1;

  public var dead:Bool = false;

  public var lockedToFlags:Int = 0;

  public var jumpAmount:Float = 300;


  private var deadTimer:Float = 0;
  private var deadThreshold:Float = 0.4;
  private var flying = false;

  var jumpSound:FlxSound;

  public function new(X:Float=0,Y:Float=0) {
    super(X,Y);
    loadGraphic("assets/images/player.png", true, 32, 32);
    animation.add("idle", [0, 0, 0, 0, 0, 0, 1, 2, 3], 15, true);
    animation.add("run", [6, 7, 8, 9, 10, 11], 15, true);
    animation.add("run from landing", [8, 9, 10, 11, 6, 7], 15, true);
    animation.add("jump start", [12], 15, true);
    animation.add("jump peak", [13], 15, true);
    animation.add("jump fall", [14], 15, true);
    animation.add("jump land", [15], 15, false);
    animation.add("die", [18]);
    animation.play("idle");

    width = 12;
    height = 20;

    offset.y = 12;
    offset.x = 10;

    _speed = new Point();
    _speed.y = 215;
    _speed.x = 800;

    acceleration.y = _gravity;

    maxVelocity.y = 325;
    maxVelocity.x = RUN_SPEED;

    jumpSound = FlxG.sound.load("assets/sounds/jump.wav");
  }

  public function init():Void {
    x = START_X;
    y = START_Y;

    _jumpPressed = false;
    _grounded = false;
    _jumping = false;
    _landing = false;
    _justLanded = false;

    _groundedTimer = 0;
    collisionFlags = 0;

    jumpTimer = 0;

    lockedToFlags = 0;

    velocity.x = velocity.y = 0;
    acceleration.x = 0;
    acceleration.y = _gravity;
    exists = true;

    facing = FlxObject.RIGHT;
  }

  public function playRunAnim():Void {
    if(!_jumping && !_landing) {
      if(_justLanded) animation.play("run from landing");
      else animation.play("run");
    }
  }

  override public function update():Void {
    if(!dead) {
      //Check for jump input, allow for early timing
      jumpTimer += FlxG.elapsed;
      if(FlxG.keys.justPressed.W || FlxG.keys.justPressed.UP) {
        _jumpPressed = true;
        jumpTimer = 0;
        _grounded = false;
      }
      if(jumpTimer > jumpThreshold) {
        _jumpPressed = false;
      }

      if(collidesWith(WALL_UP)) {
        if(!_grounded) {
          animation.play("jump land");
          _landing = true;
          _justLanded = true;
        }
        _grounded = true;
        _jumping = false;
        _groundedTimer = 0;
      } else {
        _groundedTimer += FlxG.elapsed;
        if(_groundedTimer >= _groundedThreshold) {
          _grounded = false;
        }
      }

      if(_landing && animation.finished) {
        _landing = false;
      }

      if(FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) {
        acceleration.x = -_speed.x * (velocity.x > 0 ? 4 : 1);
        facing = FlxObject.LEFT;
        playRunAnim();
      } else if(FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) {
        acceleration.x = _speed.x * (velocity.x < 0 ? 4 : 1);
        facing = FlxObject.RIGHT;
        playRunAnim();
      } else if (Math.abs(velocity.x) < 50) {
        if(!_jumping && !_landing) animation.play("idle");
        velocity.x = 0;
        acceleration.x = 0;
        _justLanded = false;
      } else {
        _justLanded = false;
        var drag:Float = 3;
        if (velocity.x > 0) {
          acceleration.x = -_speed.x * drag;
        } else if (velocity.x < 0) {
          acceleration.x = _speed.x * drag;
        }
      }

      if(_jumpPressed) {
          if(_grounded) {
            jumpSound.play();
            animation.play("jump start");
            _jumping = true;
            velocity.y = -_speed.y;
            _jumpPressed = false;
          }
      }

      if(velocity.y < -1) {
        if(jumpPressed() && velocity.y > -25) {
          animation.play("jump peak");
        }
      } else if (velocity.y > 1) {
        if(velocity.y > 100) {
          animation.play("jump fall");
        }
      }


      if(FlxG.keys.pressed.LEFT) {
        jumpAmount--;
      }
      if(FlxG.keys.pressed.RIGHT) {
        jumpAmount++;
      }
          
      if(!jumpPressed() && velocity.y < 0)
        acceleration.y = _gravity * 3;
      else
        acceleration.y = _gravity;
    } else {
      deadTimer += FlxG.elapsed;
      if(deadTimer >= deadThreshold && !flying) {
        velocity.y = -125;
        acceleration.y = 400;
        flying = true;
      }
    }
    super.update();

    if(x < 0) x = FlxG.camera.width - width;
    if(x + width > FlxG.camera.width) x = 0;
  }

  public function jumpPressed():Bool {
    return FlxG.keys.pressed.W || FlxG.keys.pressed.SPACE || FlxG.keys.pressed.UP;
  }

  public function resetFlags():Void {
    collisionFlags = 0;
  }

  public function die():Void {
    animation.play("die");
    deadTimer = 0;
    dead = true;
    acceleration.y = acceleration.x = velocity.x = velocity.y = 0;
  }

  public function setCollidesWith(bits:Int):Void {
    collisionFlags |= bits;
  }

  public function collidesWith(bits:Int):Bool {
    return (collisionFlags & bits) > 0;
  }
}
