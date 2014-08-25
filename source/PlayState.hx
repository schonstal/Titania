package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.addons.effects.FlxGlitchSprite;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
  var rooms:Dynamic = {};
  var glitchEffectSprite:GlitchEffectSprite;
  var glitchSprite:GlitchSprite;
  var player:Player;
  var activeRoom:Room;
  var speechGroup:SpeechGroup;

  var iterationMusic:FlxSound;

  override public function create():Void {
    super.create();
    for(fileName in Reg.rooms) {
      Reflect.setField(rooms,
                       fileName,
                       new Room("assets/tilemaps/iteration/" + Reg.level + "/" + fileName + ".tmx"));
    }
    Reg.openDoors = [];

    player = new Player();
    player.init();
    add(player);

    glitchEffectSprite = new GlitchEffectSprite();

    switchRoom("quarters");

    //Palette Swap
    add(new EffectSprite());
    speechGroup = new SpeechGroup();
    add(speechGroup);

    //Glitch out
    glitchSprite = new GlitchSprite();
    add(glitchSprite);

    add(glitchEffectSprite);

    FlxG.debugger.drawDebug = true;
    if (Reg.level < 3) {
      FlxG.sound.play("assets/music/level1.mp3", 1, true);
    } else {
      FlxG.sound.play("assets/sounds/spacestation.mp3", 1, true);
    }
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    if (FlxG.keys.justPressed.RIGHT) {
      Reg.palette = 1;
    }
    if (FlxG.keys.justPressed.SPACE) {
      glitchSprite.glitchOut();
      //speechGroup.say("butts\nnuts##wub wub wub!");
    }
    touchCrashers();

    super.update();
    
    player.resetFlags();

    checkExits();
    touchWalls();
    touchDoors();
    checkDialogs();
  }

  private function touchWalls():Void {
    FlxG.collide(activeRoom.foregroundTiles, player, function(tile:FlxObject, player:Player):Void {
      if((player.touching & FlxObject.FLOOR) > 0) {
        player.setCollidesWith(Player.WALL_UP);
      }
    });
  }

  private function touchDoors():Void {
    FlxG.collide(activeRoom.doors, player);
    FlxG.overlap(activeRoom.terminals, player, function(terminal:Terminal, player:Player):Void {
      Reg.openDoors[terminal.id] = true;
    });
    FlxG.overlap(activeRoom.doorTriggers, player, function(doorTrigger:DoorTrigger, player:Player):Void {
      doorTrigger.openDoor();
    });
  }

  private function checkExits():Void {
    FlxG.overlap(activeRoom.exits, player, function(exit:ExitObject, player:Player):Void {
      if(player.x < 0) {
        player.x = FlxG.camera.width - player.width;
        switchRoom(exit.roomName);
      } else if(player.x + player.width > FlxG.camera.width) {
        player.x = 0;
        switchRoom(exit.roomName);
      }
    });
  }

  private function checkDialogs():Void {
    FlxG.overlap(activeRoom.dialogs, player, function(dialog:Dialog, player:Player):Void {
      if (!dialog.triggered) {
        dialog.triggered = true;
        if(Reg.level < 3)
        speechGroup.say(dialog.text);
      }
    });
  }

  private function touchCrashers():Void {
    if(FlxG.overlap(activeRoom.crashers, player)) {
      if(!FlxG.sound.muted) glitchSprite.glitchOut();
    }
  }

  public function switchRoom(roomName:String):Void {
    if (roomName == "quartersMirror" && Reg.level == 3) {
      glitchEffectSprite.visible = true;
    } else {
      glitchEffectSprite.visible = false;
    }
    if (activeRoom != null) {
      remove(activeRoom.foregroundTiles);
      remove(activeRoom.exits);
      remove(activeRoom.background);
      remove(activeRoom.images);
      remove(activeRoom.doors);
      remove(activeRoom.terminals);
      remove(activeRoom.terminalSymbols);
      remove(activeRoom.doorSymbols);
      remove(activeRoom.doorTriggers);
      remove(activeRoom.crashers);
      remove(activeRoom.dialogs);
    }
    remove(player);

    activeRoom = Reflect.field(rooms, roomName);
    activeRoom.loadObjects(this);
    add(activeRoom.background);
    add(activeRoom.images);
    add(activeRoom.terminals);
    add(activeRoom.terminalSymbols);
    add(player);
    add(activeRoom.foregroundTiles);
    add(activeRoom.exits);
    add(activeRoom.doors);
    add(activeRoom.doorSymbols);
    add(activeRoom.doorTriggers);
    add(activeRoom.crashers);
    add(activeRoom.dialogs);

    Reg.palette = Std.parseInt(activeRoom.properties.palette);
  }
}
