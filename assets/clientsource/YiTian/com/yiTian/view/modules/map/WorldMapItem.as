package com.yiTian.view.modules.map
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.utils.MassLoader;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WorldMapItem extends Sprite
   {
      
      private var horseSpr:Sprite;
      
      private var houseSpr:Sprite;
      
      private var _sceneId:int;
      
      public function WorldMapItem(sceneId:int, x:int, y:int)
      {
         var horseBm:Bitmap;
         var houseBm:Bitmap;
         super();
         this._sceneId = sceneId;
         this.x = x;
         this.y = y;
         this.horseSpr = new Sprite();
         if(sceneId == 13401)
         {
            this.horseSpr.x = 12;
            this.horseSpr.y = 8;
         }
         else if(sceneId == 13801 || sceneId == 13901 || sceneId == 14001)
         {
            this.horseSpr.x = -5;
            this.horseSpr.y = 4;
         }
         else
         {
            this.horseSpr.x = 3;
            this.horseSpr.y = 5;
         }
         horseBm = new Bitmap();
         this.horseSpr.addChild(horseBm);
         MassLoader.add("resource/image/worldMap/horse.png",function(info:Object):void
         {
            info.obj.bitmapData = (info.content as Bitmap).bitmapData;
         },null,MassLoader.LEVEL1,horseBm);
         TipManager.bind(this.horseSpr,LangConfig.getWord("10527",1));
         this.horseSpr.addEventListener(MouseEvent.ROLL_OVER,this.horseOver);
         this.horseSpr.addEventListener(MouseEvent.ROLL_OUT,this.horseOut);
         this.horseSpr.addEventListener(MouseEvent.CLICK,this.fly);
         this.houseSpr = new Sprite();
         addChild(this.houseSpr);
         addChild(this.horseSpr);
         houseBm = new Bitmap();
         this.houseSpr.addChild(houseBm);
         MassLoader.add("resource/image/worldMap/" + sceneId + ".png",function(info:Object):void
         {
            info.obj.bitmapData = (info.content as Bitmap).bitmapData;
         },null,MassLoader.LEVEL1,houseBm);
         TipManager.bind(this.houseSpr,LangConfig.getWord("10528",1));
         this.houseSpr.addEventListener(MouseEvent.ROLL_OVER,this.houseOver);
         this.houseSpr.addEventListener(MouseEvent.ROLL_OUT,this.houseOut);
         this.houseSpr.addEventListener(MouseEvent.CLICK,this.go);
         buttonMode = true;
      }
      
      public function horseOver(e:MouseEvent) : void
      {
         this.horseSpr.filters = Util.glow000000;
      }
      
      public function horseOut(e:MouseEvent) : void
      {
         this.horseSpr.filters = null;
      }
      
      public function houseOver(e:MouseEvent) : void
      {
         this.houseSpr.filters = Util.glowFFFF00;
      }
      
      public function houseOut(e:MouseEvent) : void
      {
         this.houseSpr.filters = null;
      }
      
      private function go(e:MouseEvent) : void
      {
         GameUnitManager.hero.autoMoveLocation(this._sceneId);
      }
      
      private function fly(e:MouseEvent) : void
      {
         if(Boolean(GameUnitManager.hero.captainId) && Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10529",1));
            return;
         }
         if(Boolean(GameUnitManager.hero.paoBiao))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10530",1));
            return;
         }
         var count:int = CommandManager.get_bag_count(46232);
         if(Boolean(count))
         {
            SceneCGMessage.CG_USE_SXF(this._sceneId);
         }
         else if(Boolean(Global.isSendUseYB))
         {
            SceneCGMessage.CG_USE_SXF(this._sceneId);
         }
         else
         {
            WorldSendPrompt.instance.show(this.useYBCheckBack);
         }
      }
      
      private function useYBCheckBack(isDefault:Boolean) : void
      {
         SceneCGMessage.CG_USE_SXF(this._sceneId);
         if(isDefault)
         {
            Global.isSendUseYB = 1;
         }
      }
   }
}

