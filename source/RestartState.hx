package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.text.FlxText;

class RestartState extends FlxState
{
  var panicText:FlxText;

  override public function create():Void {
    super.create();
    FlxG.sound.muted = false;

    var bgSprite:FlxSprite = new FlxSprite();
    bgSprite.makeGraphic(FlxG.width, FlxG.height, 0xff091327);

    panicText = new FlxText(0,0,FlxG.width,"FATAL ERROR: Critical fault!
Program data is corrupt.

[   342.545660004] 0ff0b000 000d005 0000bc000 0ff0b050
[    46.543543054] 02457890 0432005 043244200 04320442
[  1245.243240004] 00b23400 00d3c05 000004230 00004a22

00 43 5a 8b e9 ff 00 00 00 00 00 00 00 00 00

Failed to sync... restarting.");

    panicText.setFormat("assets/fonts/437.ttf");
    panicText.size = 16;
    panicText.color = 0xff999999;
    add(panicText);
    
    if(Reg.level <= 1) panicText.visible = false;

    new FlxTimer().start(1, function(t):Void {
      panicText.visible = false;

      new FlxTimer().start(0.5, function(t):Void {
        Reg.level++;
        FlxG.switchState(new BadingState());
      });
    });
  }
}
