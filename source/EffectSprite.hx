package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.filters.ColorMatrixFilter;

class EffectSprite extends FlxSprite
{
  var paletteSprite:FlxSprite;
  var redArray:Array<Int>;
  var greenArray:Array<Int>;
  var blueArray:Array<Int>;

  public function new() {
    super(0,0);
    makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
    paletteSprite = new FlxSprite();
    paletteSprite.loadGraphic("assets/images/palette.png");

    redArray = new Array<Int>();
    greenArray = new Array<Int>();
    blueArray = new Array<Int>();
  }

  override public function draw():Void {
#if flash
    pixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point());
#else
    pixels.draw(FlxG.camera.canvas, new Matrix(1, 0, 0, 1, 0, 0));
#end
    for(i in 0...255) {
        redArray[i] = i << 16;
        greenArray[i] = i << 8;
        blueArray[i] = i;
    }

    for(x in 0...cast(paletteSprite.width,Int)) {
      var pixel:Int = paletteSprite.pixels.getPixel(x,0);
      var palettePixel:Int = paletteSprite.pixels.getPixel(x,Reg.palette);
      redArray[(pixel & 0xff0000) >> 16] = (palettePixel & 0xff0000) >> 16;
      greenArray[(pixel & 0xff00) >> 8] = (palettePixel & 0xff00) >> 8;
      blueArray[pixel & 0xff] = palettePixel & 0xff;
    }

    pixels.paletteMap(pixels, new Rectangle(0,0,width,height), new Point(0,0), redArray, greenArray, blueArray);
    
    resetFrameBitmapDatas();
    dirty = true;
    super.draw();
  }
}
