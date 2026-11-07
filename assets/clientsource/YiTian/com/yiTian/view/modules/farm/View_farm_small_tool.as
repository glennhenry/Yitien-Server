package com.yiTian.view.modules.farm
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   internal class View_farm_small_tool extends Sprite
   {
      
      public static const typeName:Array = ["","can_pick","need_water"];
      
      public static const type_can_pick:uint = 1;
      
      public static const type_need_water:uint = 2;
      
      private var bg:Bitmap;
      
      private var pic:Bitmap;
      
      public var _type:uint;
      
      private var flag:Boolean = true;
      
      private var distance_max:Number = 4;
      
      private var distance:Number = 0;
      
      public function View_farm_small_tool()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.pic = new Bitmap();
         this.addChild(this.pic);
         this.pic.x = 2;
         this.pic.y = 2;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
      }
      
      public function set type(value:uint) : void
      {
         this._type = value;
         if(this._type == 0)
         {
            this.pic.bitmapData = null;
            return;
         }
         this.pic.bitmapData = ComponentUtil.getBitmapData(typeName[this._type],Global.ShanZhuang_Imgsdm);
      }
      
      public function updatePosition() : void
      {
         if(this._type == 0)
         {
            return;
         }
         if(this.flag)
         {
            if(this.distance < this.distance_max)
            {
               this.distance += 0.2;
               this.pic.y = this.distance;
            }
            else
            {
               this.flag = false;
            }
         }
         else if(this.distance > 0)
         {
            this.distance -= 0.2;
            this.pic.y = this.distance;
         }
         else
         {
            this.flag = true;
         }
      }
      
      private function onOver(evt:MouseEvent) : void
      {
         filters = Util.glowFFFF00;
      }
      
      private function onOut(evt:MouseEvent) : void
      {
         filters = null;
      }
   }
}

