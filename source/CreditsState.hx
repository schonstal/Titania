package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;

class CreditsState extends FlxState
{
  var bgSprite:FlxSprite;
  var effectSprite:EffectSprite;
  var nameText:FlxSprite;

  override public function create():Void {
    super.create();
    Reg.palette = 1;

    var bgSprite:FlxSprite = new FlxSprite();
    bgSprite.loadGraphic("assets/images/creditsScreen.png");
    add(bgSprite);

    effectSprite = new EffectSprite();
    add(effectSprite);

    FlxG.camera.fade(FlxColor.BLACK,1,true);
  }
  
  override public function update():Void {
    super.update();
  }
}
