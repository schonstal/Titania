package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.util.FlxColor;

// For some reason FlxObject doesn't collide properly
class Dialog extends FlxSprite
{
  public var text:String;
  public var triggered:Bool = false;

  public function new(X:Float, Y:Float, Width:Float, Height:Float, text:String) {
    super(X,Y);
    this.text = text;
    makeGraphic(cast(Width, Int), cast(Height, Int), FlxColor.TRANSPARENT);
  }
}
