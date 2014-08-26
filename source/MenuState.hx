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
  var indexButton:FlxButton;
  var effectSprite:EffectSprite;
  var glitchSprite:GlitchSprite;

  override public function create():Void {
    menuGraphic = new FlxSprite();
    menuGraphic.loadGraphic("assets/images/titleScreen.png");
    add(menuGraphic);

    FlxG.debugger.drawDebug = true;
    super.create();

    if(Reg.level == 5) {
      indexButton = new FlxButton(89,130, function():Void{
        glitchSprite.glitchOut();
      });
      indexButton.loadGraphic("assets/images/inbox.png", true, 92, 16);
      indexButton.width = 150;
      indexButton.offset.x = -7;
      indexButton.height = 20;
      indexButton.offset.y = -5;
      add(indexButton);
    } else {
      startGameButton = new FlxButton(89,130, function():Void{
        FlxG.switchState(new AlarmState());
      });
      startGameButton.loadGraphic("assets/images/startGame.png", true, 136, 10);
      startGameButton.width = 150;
      startGameButton.offset.x = -7;
      startGameButton.height = 20;
      startGameButton.offset.y = -5;
      add(startGameButton);
    }

    add(new Cursor());

    effectSprite = new EffectSprite();
    effectSprite.paletteRate = 0.2;
    add(effectSprite);

    glitchSprite = new GlitchSprite();
    add(glitchSprite);

    Reg.palette = 1;
    FlxG.sound.play("assets/sounds/spacestation.mp3", 0.75, true);
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
  }
}
