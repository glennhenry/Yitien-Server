package com.yiTian.view.modules.battle
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HeadBuffIcon extends Sprite
   {
      
      private static var pool:Array = [];
      
      public var iconBm:Bitmap;
      
      public var id:String;
      
      public function HeadBuffIcon()
      {
         super();
         this.iconBm = new Bitmap();
         addChild(this.iconBm);
      }
      
      public static function getObj() : HeadBuffIcon
      {
         var rest:HeadBuffIcon = Boolean(pool.length) ? pool.pop() : new HeadBuffIcon();
         rest.init();
         return rest;
      }
      
      public function dispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.move);
         removeEventListener(MouseEvent.ROLL_OUT,this.out);
         pool.push(this);
      }
      
      private function init() : void
      {
         addEventListener(MouseEvent.MOUSE_MOVE,this.move);
         addEventListener(MouseEvent.ROLL_OUT,this.out);
      }
      
      private function move(e:MouseEvent) : void
      {
         TipManager.update(Data_lib.buffer[this.id][Vo_Buffer.BATTLE_TIP]);
      }
      
      private function out(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function load() : void
      {
         Utils.getLoadBitmap("resource/image/buff/" + Data_lib.buffer[this.id][Vo_Buffer.BATTLE_ICON] + ".png",this.iconBm);
      }
   }
}

