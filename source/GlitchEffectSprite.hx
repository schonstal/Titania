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

class GlitchEffectSprite extends FlxGroup
{
  var sprite:FlxSprite;
  var horizontalGlitch:FlxGlitchSprite;
  var count:Int = 0;

  public function new() {
    super();
    sprite = new FlxSprite();
    sprite.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

    horizontalGlitch = new FlxGlitchSprite(sprite);
    horizontalGlitch.size = 1;
    horizontalGlitch.strength = 3;
    horizontalGlitch.delay = 0;

    add(horizontalGlitch);

  }

  override public function draw():Void {
#if flash
    sprite.framePixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point());
#else
    sprite.pixels.draw(FlxG.camera.canvas, new Matrix(1, 0, 0, 1, 0, 0));
#end
    super.draw();
  }
}
