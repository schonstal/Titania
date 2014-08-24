package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.addons.effects.FlxGlitchSprite;

class PlayState extends FlxState
{
  var rooms:Dynamic = {};
  var glitchSprite:GlitchSprite;
  var player:Player;

  override public function create():Void {
    super.create();
    rooms.quarters = new Room("assets/tilemaps/quarters.tmx");
    rooms.hub = new Room("assets/tilemaps/hub.tmx");

    player = new Player();
    player.init();
    add(player);

    add(rooms.quarters.foregroundTiles);

    //FX
    add(new EffectSprite());
    glitchSprite = new GlitchSprite();
    add(glitchSprite);

    FlxG.debugger.drawDebug = true;
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
    
    player.resetFlags();

    FlxG.collide(rooms.quarters.foregroundTiles, player, function(tile:FlxObject, player:Player):Void {
      if((player.touching & FlxObject.FLOOR) > 0) {
        player.setCollidesWith(Player.WALL_UP);
      }
    });
  }
}
