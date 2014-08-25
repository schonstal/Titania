package;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.filters.ColorMatrixFilter;
import flixel.addons.effects.FlxGlitchSprite;
import flixel.addons.effects.FlxGlitchSprite.FlxGlitchDirection;
import flixel.util.FlxTimer;

class Door extends FlxSprite
{
  public var id:Int;
  var closed:Bool;

  public function new(X:Float, Y:Float, id:Int) {
    super(X,Y);
    this.id = id;

    closed = !Reg.openDoors[id];
    solid = closed;

    loadGraphic("assets/images/door.png", true, 16, 48);
    animation.add("closed", [0]);
    animation.add("open", [1, 2, 3, 4, 5], 10, false);
    animation.add("opened", [5]);
    animation.play(closed ? "closed" : "opened");
    immovable = true;
  }

  public override function update():Void {
    super.update();
    if(Reg.openDoors[id] && closed) {
      closed = false;
      new FlxTimer().start(0.5, function(t):Void {
        animation.play("open");
        FlxG.sound.play("assets/sounds/door.wav");
        new FlxTimer().start(0.2, function(t):Void {
          solid = false;
        });
      });
    }
  }

  public function open():Void {
  }
}
