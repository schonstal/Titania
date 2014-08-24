package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class PlayState extends FlxState
{
  var rooms:Object = {};

  override public function create():Void {
    super.create();
    rooms["quarters"] = new Room("assets/tilemaps/quarters.tmx");
    rooms["hub"] = new Room("assets/tilemaps/hub.tmx");
    add(room.foregroundTiles);
    add(new EffectSprite());
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
  } 
}
