package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.addons.effects.FlxGlitchSprite;

class PlayState extends FlxState
{
  var rooms:Dynamic = {};
  var glitchSprite:GlitchSprite;

  override public function create():Void {
    super.create();
    rooms.quarters = new Room("assets/tilemaps/quarters.tmx");
    rooms.hub = new Room("assets/tilemaps/hub.tmx");
    add(rooms.quarters.foregroundTiles);
    add(new EffectSprite());
    glitchSprite = new GlitchSprite();
    add(glitchSprite);
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    if (FlxG.keys.justPressed.RIGHT) {
      remove(rooms.quarters.foregroundTiles);
      add(rooms.hub.foregroundTiles);
    }
    if (FlxG.keys.justPressed.LEFT) {
      remove(rooms.hub.foregroundTiles);
      add(rooms.quarters.foregroundTiles);
    }
    if (FlxG.keys.justPressed.SPACE) {
      glitchSprite.glitchOut();
    }
    super.update();
  }
}
