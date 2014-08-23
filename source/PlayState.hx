package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class PlayState extends FlxState
{
  var room:Room;

  override public function create():Void {
    super.create();
    room = new Room("assets/tilemaps/quarters.tmx");
    add(room.foregroundTiles);
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
  } 
}
