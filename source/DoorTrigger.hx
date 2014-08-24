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

class DoorTrigger extends FlxSprite
{
  public static var WIDTH:Float  = 48;
  public static var HEIGHT:Float = 16;

  public var door:Door;

  var triggered:Bool = false;

  public function new(X:Float, Y:Float, door:Door) {
    super(X,Y);
    this.door = door;
    makeGraphic(cast((WIDTH * 2) + 16, Int), cast(HEIGHT, Int), FlxColor.TRANSPARENT);
  }

  public function openDoor():Void {
    triggered = true;
    door.open();
  }

  override public function update():Void {
    super.update();
//    if (!triggered) door.close();
  }
}
