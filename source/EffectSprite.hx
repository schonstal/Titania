package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flash.geom.Point;
import flash.filters.ColorMatrixFilter;

class EffectSprite extends FlxSprite
{
  public function new() {
    super(0,0);
    makeGraphic(FlxG.width, FlxG.height, FlxColor.ORANGE);//TRANSPARENT);
  }

  override public function draw():Void {
#if flash
    pixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point());
#else
    pixels.draw(FlxG.camera.canvas, new Matrix(1, 0, 0, 1, 0, 0));
#end
    resetFrameBitmapDatas();
    dirty = true;
    super.draw();
  }
}
