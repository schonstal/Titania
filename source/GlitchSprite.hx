package;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.filters.ColorMatrixFilter;
import flixel.addons.effects.FlxGlitchSprite;

class GlitchSprite extends FlxGroup
{
  var sprite:FlxSprite;
  var glitch:FlxGlitchSprite;

  public function new() {
    super();
    sprite = new FlxSprite();
    sprite.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
  }

  public function glitchOut():Void {
#if flash
    sprite.pixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point());
#else
    sprite.pixels.draw(FlxG.camera.canvas, new Matrix(1, 0, 0, 1, 0, 0));
#end
    
    sprite.resetFrameBitmapDatas();
    sprite.dirty = true;

    glitch = new FlxGlitchSprite(sprite);
    glitch.size = 1;
    glitch.strength = 30;

    add(glitch);
  }

  override public function draw():Void {
    super.draw();
  }
}
