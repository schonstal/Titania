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

class Pellet extends FlxSprite
{
  var pickedUp:Bool = false;

  public function new(X:Float, Y:Float) {
    super(X,Y);
    loadGraphic("assets/images/pellet.png", true, 16, 16);
    animation.add("float", [0, 1, 2, 1], 5);
    animation.play("float");
  }

  public function onCollisionEnter():Void {
    if(!pickedUp) {
      pickedUp = true;
      FlxG.sound.play("assets/sounds/pellet.wav");
      visible = false;
      FlxG.camera.flash(0x33ffffff, .33, true);
    }
  }
}
