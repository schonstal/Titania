package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.addons.effects.FlxGlitchSprite;
import flixel.system.FlxSound;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;//.EaseFunction;
import flixel.util.FlxTimer;

class SpeechGroup extends FlxGroup
{
  var messageQueue:Array<String> = [];
  var speechBubble:FlxSprite;
  var speechText:FlxText;

  var talking:Bool = false;
  var messageIndex:Int = 0;
  var currentMessage:String = "";
  var talkingSound:FlxSound;

  var textColor:Int = 0xfff5d966;

  
  public function new() {
    super();
    speechBubble = new FlxSprite();
    speechBubble.loadGraphic("assets/images/computer.png");
    speechBubble.x = FlxG.width/2 - speechBubble.width/2;
    speechBubble.y = 12;
    speechBubble.alpha = 0;
    add(speechBubble);

    speechText = new FlxText(speechBubble.x + 56, 24, 112);
    speechText.setFormat("assets/fonts/04b03.ttf");
    speechText.color = 0xfff5d966;
    add(speechText);
    
    talkingSound = FlxG.sound.load("assets/sounds/talking.wav", 0.6);
  }

  public function say(text:String):Void {
    if(!talking) {
      displayMessages();
      talking = true;
    }
    var sentences:Array<String> = text.split("##");
    for (s in sentences) {
      messageQueue.unshift(s);
    }
  }

  override public function update():Void {
    if(!talking && messageQueue.length > 0) displayMessages();
    super.update();
  }

  private function displayMessages():Void {
    FlxTween.tween(speechBubble, { alpha: 1, y: 18 }, 0.25, {
      ease: FlxEase.quadOut,
      onComplete: function(t:FlxTween):Void {
        readMessages();
      }
    });
  }

  private function doneReading():Void {
    speechText.text = "";
    currentMessage = "";
    messageIndex = 0;
    talking = false;
    FlxTween.tween(speechBubble, { alpha: 0, y: 12 }, 0.25);
  }

  private function readMessages():Void {
    if (currentMessage == "") {
      messageIndex = 0;
      currentMessage = messageQueue.pop();
    }
      
    if(messageIndex > currentMessage.length - 1) {
      messageIndex = 0;
      currentMessage = messageQueue.pop();
      if(currentMessage != null) {
        new FlxTimer().start(1, function(t):Void {
          speechText.text = "";
          readMessages();
        });
        return;
      }
    }

    if (currentMessage == null) {
      new FlxTimer().start(1, function(t):Void {
        doneReading();
      });
      return;
    }
    talkingSound.play(true);
    speechText.text += currentMessage.charAt(messageIndex);
    messageIndex++;
    new FlxTimer().start(0.05, function(t):Void {
      readMessages();
    });
  }
}
