package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
  override public function create():Void {
    var text:FlxText = new FlxText(0, 0, FlxG.width, "test");
    text.setFormat("assets/fonts/04b03.ttf");
    add(text);
    super.create();
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    if (FlxG.mouse.justPressed) {
      FlxG.switchState(new PlayState());
    }
    super.update();
  }
}
