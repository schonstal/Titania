package;

import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;


/**
 * Modified from Samuel Batista's example source
 */
class Room extends TiledMap
{
  // For each "Tile Layer" in the map, you must define a "tileset"
  // property which contains the name of a tile sheet image 
  // used to draw tiles in that layer (without file extension).
  // The image file must be located in the directory specified bellow.
  private inline static var c_PATH_LEVEL_TILESHEETS = "assets/images/tiles/";

  // Do we reload objects?
  public var dirty:Bool = true;
  
  // Array of tilemaps used for collision
  public var foregroundTiles:FlxGroup;
  public var backgroundTiles:FlxGroup;
  public var exits:FlxGroup;
  public var doors:FlxGroup;
  public var terminals:FlxGroup;
  public var doorSymbols:FlxGroup;
  public var doorTriggers:FlxGroup;
  public var terminalSymbols:FlxGroup;
  public var images:FlxGroup;
  public var crashers:FlxGroup;
  public var dialogs:FlxGroup;
  public var pellets:FlxGroup;
  public var background:FlxSprite;

  private var collidableTileLayers:Array<FlxTilemap>;

  
  public function new(tiles:Dynamic) {
    super(tiles);
    
    foregroundTiles = new FlxGroup();
    backgroundTiles = new FlxGroup();
    exits = new FlxGroup();
    doors = new FlxGroup();
    doorSymbols = new FlxGroup();
    doorTriggers = new FlxGroup();
    terminalSymbols = new FlxGroup();
    terminals = new FlxGroup();
    images = new FlxGroup();
    crashers = new FlxGroup();
    dialogs = new FlxGroup();
    pellets = new FlxGroup();
    
    // Load Tile Maps
    for (tileLayer in layers) {
      var tileSheetName:String = tileLayer.properties.get("tileset");
      
      if (tileSheetName == null) {
        throw "'tileset' property not defined for the '" + tileLayer.name +
              "' layer. Please add the property to the layer.";
      }
        
      var tileSet:TiledTileSet = null;
      for (ts in tilesets) {
        if (ts.name == tileSheetName) {
          tileSet = ts;
          break;
        }
      }
      
      if (tileSet == null) {
        throw "Tileset '" + tileSheetName +
              " not found. Did you mispell the 'tilesheet' property in " +
              tileLayer.name + "' layer?";
      }
        
      var imagePath       = new Path(tileSet.imageSource);
      var processedPath   = c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;
      
      var tilemap:FlxTilemap = new FlxTilemap();
      tilemap.widthInTiles = width;
      tilemap.heightInTiles = height;
      tilemap.loadMap(tileLayer.tileArray,
                      processedPath,
                      tileSet.tileWidth,
                      tileSet.tileHeight,
                      FlxTilemapAutoTiling.OFF,
                      1, 1, 1);
      
      if (tileLayer.properties.contains("nocollide")) {
        backgroundTiles.add(tilemap);
      } else {
        if (collidableTileLayers == null) {
          collidableTileLayers = new Array<FlxTilemap>();
        }
        
        foregroundTiles.add(tilemap);
        collidableTileLayers.push(tilemap);
      }
    }
    background = new FlxSprite();
    background.loadGraphic("assets/images/backgrounds/" + properties.background + ".png");
  } // new()
  
  public function loadObjects(state:PlayState) {
    if (!dirty) return;

    for (group in objectGroups) {
      for (o in group.objects) {
        loadObject(o, group, state);
      }
    }
    dirty = false;
  }
  
  private function loadObject(o:TiledObject, g:TiledObjectGroup, state:PlayState) {
    var x:Int = o.x;
    var y:Int = o.y;
    
    // objects in tiled are aligned bottom-left (top-left in flixel)
    if (o.gid != -1) {
      y -= g.map.getGidOwner(o.gid).tileHeight;
    }
    
    switch (o.type.toLowerCase()) {
      case "exit":
        var exit = new ExitObject(x, y, o.width, o.height, o.custom.get("room"));
        exits.add(exit);
      case "door":
        var door = new Door(x, y, Std.parseInt(o.custom.get("id")));
        var doorSymbol = new DoorSymbol(x, y, Std.parseInt(o.custom.get("id")));
        doors.add(door);
        doorSymbols.add(doorSymbol);
        //var doorTrigger = new DoorTrigger(x - DoorTrigger.WIDTH, y + (48 - DoorTrigger.HEIGHT), door);
        //doorTriggers.add(doorTrigger);
      case "terminal":
        var terminal = new Terminal(x, y, Std.parseInt(o.custom.get("id")));
        var doorSymbol = new DoorSymbol(x, y, Std.parseInt(o.custom.get("id")));
        terminals.add(terminal);
        terminalSymbols.add(doorSymbol);
      case "image":
        var image:FlxSprite = new FlxSprite(x, y, "assets/images/" + o.custom.get("file") + ".png");
        images.add(image);
      case "crash":
        var crasher:Crasher = new Crasher(x, y, o.width, o.height);
        crashers.add(crasher);
      case "dialog":
        var dialog:Dialog = new Dialog(x, y, o.width, o.height, o.custom.get("text"));
        dialogs.add(dialog);
      case "pellet":
        var pellet:Pellet = new Pellet(x, y);
        pellets.add(pellet);
    }
  }
  
  public function collideWithLevel(obj:FlxObject,
                                   ?notifyCallback:FlxObject->FlxObject->Void,
                                   ?processCallback:FlxObject->FlxObject->Bool):Bool {
    if (collidableTileLayers != null) {
      for (map in collidableTileLayers) {
        // IMPORTANT: Always collide the map with objects, not the other way around. 
        //        This prevents odd collision errors (collision separation code off by 1 px).
        return FlxG.overlap(map,
                            obj,
                            notifyCallback,
                            processCallback != null ? processCallback : FlxObject.separate);
      }
    }
    return false;
  }
}
