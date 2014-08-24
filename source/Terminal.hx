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

class Terminal extends FlxSprite
{
  public var id:Int;

  public function new(X:Float, Y:Float, id:Int) {
    super(X,Y);
    this.id = id;

    loadGraphic("assets/images/terminal.png", true, 16, 22);
  }
}

