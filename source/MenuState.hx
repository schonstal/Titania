package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
  var menuGraphic:FlxSprite;
  var startGameButton:FlxButton;
  var effectSprite:EffectSprite;

  override public function create():Void {
    menuGraphic = new FlxSprite();
    menuGraphic.loadGraphic("assets/images/titleScreen.png");
    add(menuGraphic);

    startGameButton = new FlxButton(89,130, function():Void{
      FlxG.switchState(new AlarmState());
    });
    startGameButton.loadGraphic("assets/images/startGame.png", true, 136, 10);
    startGameButton.width = 150;
    startGameButton.offset.x = -7;
    startGameButton.height = 20;
    startGameButton.offset.y = -5;
    add(startGameButton);
    FlxG.debugger.drawDebug = true;
    super.create();

    add(new Cursor());

    effectSprite = new EffectSprite();
    effectSprite.paletteRate = 0.2;
    add(effectSprite);
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
  }
}
