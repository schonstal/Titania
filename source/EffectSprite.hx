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
  var bgPaletteSprite:FlxSprite;

  var redArray:Array<Int>;
  var greenArray:Array<Int>;
  var blueArray:Array<Int>;

  var rotatingPalette:Array<Int>;

  var previousPalette:Int = 0;

  public var paletteRate:Float = 0.1;
  private var paletteTimer:Float = 0;

  public function new() {
    super(0,0);
    makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
    paletteSprite = new FlxSprite();
    paletteSprite.loadGraphic("assets/images/palette.png");
    bgPaletteSprite = new FlxSprite();
    bgPaletteSprite.loadGraphic("assets/images/backgroundPalette.png");

    rotatingPalette = new Array<Int>();
    for (i in 0...cast(bgPaletteSprite.width, Int)) {
      rotatingPalette[i] = bgPaletteSprite.pixels.getPixel(i,Reg.palette);
    }

    redArray = new Array<Int>();
    greenArray = new Array<Int>();
    blueArray = new Array<Int>();
  }


  override public function update():Void {
    if (Reg.palette != previousPalette) {
      for (i in 0...cast(bgPaletteSprite.width, Int)) {
        rotatingPalette[i] = bgPaletteSprite.pixels.getPixel(i,Reg.palette);
      }
      previousPalette = Reg.palette;
    }
    paletteTimer += FlxG.elapsed;
    if (paletteTimer >= paletteRate) {
      rotatingPalette.unshift(rotatingPalette.pop());
      paletteTimer = 0;
    }
    super.update();
  }

  override public function draw():Void {
#if flash
    pixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point());
#else
    pixels.draw(FlxG.camera.canvas, new Matrix(1, 0, 0, 1, 0, 0));
#end
    for(i in 0...256) {
        redArray[i] = i << 16;
        greenArray[i] = i << 8;
        blueArray[i] = i;
    }

    for(x in 0...cast(paletteSprite.width,Int)) {
      var pixel:Int = paletteSprite.pixels.getPixel(x,0);
      var palettePixel:Int = paletteSprite.pixels.getPixel(x,Reg.palette);

      redArray[(pixel & 0xff0000) >> 16] = palettePixel & 0xff0000;
      greenArray[(pixel & 0xff00) >> 8] = palettePixel & 0xff00;
      blueArray[pixel & 0xff] = palettePixel & 0xff;
    }

    for(x in 0...cast(bgPaletteSprite.width,Int)) {
      var pixel:Int = bgPaletteSprite.pixels.getPixel(x,0);
      var palettePixel:Int = rotatingPalette[x]; 

      redArray[(pixel & 0xff0000) >> 16] = palettePixel & 0xff0000;
      greenArray[(pixel & 0xff00) >> 8] = palettePixel & 0xff00;
      blueArray[pixel & 0xff] = palettePixel & 0xff;
    }

    pixels.paletteMap(pixels, new Rectangle(0,0,width,height), new Point(0,0), redArray, greenArray, blueArray);
    
    resetFrameBitmapDatas();
    dirty = true;
    super.draw();
  }
}
