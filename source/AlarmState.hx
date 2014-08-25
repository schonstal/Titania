package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * A FlxState which can be used for the game's menu.
 */
class AlarmState extends FlxState
{
  var alarmText:FlxText;

  override public function create():Void {
    super.create();
    var bgSprite:FlxSprite = new FlxSprite();
    bgSprite.makeGraphic(FlxG.width, FlxG.height, 0xff091327);
    alarmText = new FlxText(48, 180, FlxG.width, "TITANIA OUTPOST\nSeptember 16th, 2214");
    alarmText.setFormat("assets/fonts/04b03.ttf");
    alarmText.color = 0xffba446b;
    add(alarmText);
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
  }
}
