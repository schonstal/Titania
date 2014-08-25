package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.util.FlxTimer;

class BadingState extends FlxState
{
  var badingSprite:FlxSprite;
  var effectSprite:EffectSprite;

  override public function create():Void {
    super.create();

    var bgSprite:FlxSprite = new FlxSprite();
    bgSprite.makeGraphic(FlxG.width, FlxG.height, 0xff091327);

    var badingSprite:FlxSprite = new FlxSprite();
    badingSprite.loadGraphic("assets/images/logo.png");
    badingSprite.setFacingFlip(FlxObject.DOWN, false, true);
    if(Reg.level == 3) badingSprite.facing = FlxObject.DOWN;
    add(badingSprite);

    FlxG.sound.play("assets/sounds/bading.mp3");

    new FlxTimer().start(1.5, function(t):Void {
      badingSprite.visible = false;
      new FlxTimer().start(0.5, function(t):Void {
        FlxG.switchState(new MenuState());
      });
    });
    FlxG.mouse.visible = false;

    effectSprite = new EffectSprite();
    add(effectSprite);
  }
  
  override public function update():Void {
    super.update();
  }
}
