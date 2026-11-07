package com.yiTian.view.modules.xiaoxiaole
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_xiaoxiaole;
   import com.yiTian.data.model.Model_xiaoxiaole;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Pool;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class GeZi extends Sprite implements IGrid_xxl
   {
      
      private var _node:XXLNode;
      
      private var model:Model_xiaoxiaole = Model_xiaoxiaole.getInstance();
      
      private var icon:Bitmap;
      
      private var colorStr:String;
      
      private var _isSelected:Boolean;
      
      public function GeZi()
      {
         super();
         this.icon = new Bitmap();
         this.icon.x = 0;
         this.icon.y = 41;
         this.addChild(this.icon);
      }
      
      public function init() : void
      {
      }
      
      public function get node() : XXLNode
      {
         return this._node;
      }
      
      public function setdate() : void
      {
         var imges:Class = null;
         var bdt:BitmapData = null;
         var str:String = Enum_xiaoxiaole.CLASSNAME[this._node.value];
         if(Boolean(str.length))
         {
            imges = Global.ChiBangdm.getDefinition(str) as Class;
            bdt = new imges(0,0);
         }
         this.icon.bitmapData = null;
         this.icon.bitmapData = bdt;
      }
      
      public function update(node:XXLNode) : void
      {
         var imges:Class = null;
         var bdt:BitmapData = null;
         this._node = node;
         var str:String = Enum_xiaoxiaole.CLASSNAME[node.value];
         if(Boolean(str.length))
         {
            imges = Global.ChiBangdm.getDefinition(str) as Class;
            bdt = new imges(0,0);
         }
         this.colorStr = str;
         this.icon.bitmapData = bdt;
         this.addEventListener(MouseEvent.ROLL_OVER,this.onOver);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
      }
      
      public function playEffect(type:String, endFunc:Function, value:int = 10, times:int = 300) : void
      {
         if(value != 10)
         {
            this._node.value = value;
         }
         EffectManager.addEffect(type,this,times,20,61,false,3,endFunc);
      }
      
      protected function onOut(event:MouseEvent) : void
      {
         this.filters = [];
      }
      
      protected function onOver(event:MouseEvent) : void
      {
         this.filters = Util.glowFFFF00;
      }
      
      private function onDown(event:MouseEvent) : void
      {
         trace(this.localToGlobal(new Point(mouseX,mouseY)));
         trace(this.localToGlobal(new Point(0,0)));
      }
      
      private function onUp(event:MouseEvent) : void
      {
         trace(this.localToGlobal(new Point(mouseX,mouseY)));
         trace(this.localToGlobal(new Point(0,0)));
      }
      
      public function isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function dispose() : void
      {
         this.filters = [];
         if(this.hasEventListener(MouseEvent.ROLL_OUT))
         {
            this.removeEventListener(MouseEvent.ROLL_OUT,this.onOut);
         }
         if(this.hasEventListener(MouseEvent.ROLL_OVER))
         {
            this.removeEventListener(MouseEvent.ROLL_OVER,this.onOver);
         }
         this.parent.removeChild(this);
         Pool.saveObject(this);
      }
      
      public function getClicd() : GeZi
      {
         return Pool.getObject(GeZi);
      }
   }
}

