package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxTimer;

class BadingState extends FlxState
{
  var badingSprite:FlxSprite;

  override public function create():Void {
    super.create();

    var badingSprite:FlxSprite = new FlxSprite();
    badingSprite.loadGraphic("assets/images/logo.png");
    add(badingSprite);

    FlxG.sound.play("assets/sounds/bading.mp3");

    new FlxTimer().start(1, function(t):Void {
      FlxG.switchState(new MenuState());
    });
  }
  
  override public function update():Void {
    super.update();
  }
}
