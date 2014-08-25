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

class Cursor extends FlxSprite
{
  public function new() {
    super();
    loadGraphic("assets/images/cursor.png");
  }

  override public function update():Void {
    x = FlxG.mouse.x;
    y = FlxG.mouse.y;
    super.update();
  }
}
