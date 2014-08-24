package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flash.geom.Point;
import flash.geom.Rectangle;
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
    var redArray:Array<Int> = new Array<Int>();
    var greenArray:Array<Int> = new Array<Int>();
    var blueArray:Array<Int> = new Array<Int>();

    for(i in 0...255) {
        redArray[i] = i << 16;
        greenArray[i] = i << 8;
        blueArray[i] = i;
    }
    redArray[0x7D] = 0x00330000;
    greenArray[0x7D] = 0x0000ff00;
    blueArray[0x7D] = 0x00000033;
    redArray[0x55] = 0x00ff0000;
    greenArray[0x55] = 0x00000000;
    blueArray[0x55] = 0x000000ff;

    pixels.paletteMap(pixels, new Rectangle(0,0,width,height), new Point(0,0), redArray, greenArray, blueArray);
    
    resetFrameBitmapDatas();
    dirty = true;
    super.draw();
  }
}
