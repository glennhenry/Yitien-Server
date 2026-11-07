package com.yiTian.view.modules.map
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_worldmap;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.MassLoader;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class WorldMap extends Sprite
   {
      
      private var tiptf:MyTextField;
      
      private var map:Bitmap;
      
      private var sendBtn:Button;
      
      private var worldItems:Array = [];
      
      private var _loaded:Boolean = false;
      
      public function WorldMap()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.tiptf = ComponentUtil.getTextField(LangConfig.getWord("10526",1),this,{
            "x":200,
            "y":47,
            "color":16776960
         });
         this.map = new Bitmap();
         this.map.x = 20;
         this.map.y = 73;
         addChild(this.map);
         this.visible = false;
      }
      
      private function loadMap() : void
      {
         var mapItem:WorldMapItem = null;
         var mapData:Array = null;
         var sceneId:String = null;
         var mapPosition:Array = null;
         MassLoader.add("resource/image/worldMap/worldMap.jpg",function(info:Object):void
         {
            info.obj.bitmapData = (info.content as Bitmap).bitmapData;
         },null,MassLoader.LEVEL1,this.map);
         for(sceneId in Data_lib.worldMap)
         {
            mapData = Data_lib.worldMap[sceneId];
            mapPosition = mapData[Enum_worldmap.MAPPOSITON].split("_");
            mapItem = new WorldMapItem(int(sceneId),20 + int(mapPosition[0]),73 + int(mapPosition[1]));
            addChild(mapItem);
            this.worldItems.push(mapItem);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this._loaded)
            {
               this.loadMap();
               this._loaded = true;
            }
         }
      }
   }
}

