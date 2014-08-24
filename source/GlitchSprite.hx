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

class GlitchSprite extends FlxGroup
{
  var sprite:FlxSprite;
  var verticalGlitch:FlxGlitchSprite;
  var horizontalGlitch:FlxGlitchSprite;
  var count:Int = 0;

  public function new() {
    super();
    sprite = new FlxSprite();
    sprite.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
  }

  public function glitchOut():Void {

    horizontalGlitch = new FlxGlitchSprite(sprite);
    horizontalGlitch.size = 30;
    horizontalGlitch.strength = 10;
    horizontalGlitch.delay = 0;

    add(horizontalGlitch);

    verticalGlitch = new FlxGlitchSprite(horizontalGlitch);
    verticalGlitch.size = 20;
    verticalGlitch.strength = 10;
    verticalGlitch.delay = 0;
    verticalGlitch.direction = FlxGlitchDirection.VERTICAL;

    add(verticalGlitch);

    new FlxTimer().start(1, function(t):Void {
      Reg.level++;
      FlxG.switchState(new BadingState());
    });
  }

  override public function update():Void {
    super.update();
  }

  override public function draw():Void {
    if(verticalGlitch == null) return;
#if flash
    sprite.framePixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point());
#else
    sprite.pixels.draw(FlxG.camera.canvas, new Matrix(1, 0, 0, 1, 0, 0));
#end
    
    super.draw();
    if (verticalGlitch != null) {
      count++;
      if (count > 1) {
        verticalGlitch.delay = 100000;
        horizontalGlitch.delay = 100000;
      }
    }
  }
}
