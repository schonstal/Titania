package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.util.FlxColor;

// For some reason FlxObject doesn't collide properly
class Crasher extends FlxSprite
{
  public function new(X:Float, Y:Float, Width:Float, Height:Float) {
    super(X,Y);
    makeGraphic(cast(Width, Int), cast(Height, Int), FlxColor.TRANSPARENT);
  }
}
