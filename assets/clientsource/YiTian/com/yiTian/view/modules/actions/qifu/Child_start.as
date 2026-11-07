package com.yiTian.view.modules.actions.qifu
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_start extends Sprite
   {
      
      private var startVec:Vector.<Start> = new Vector.<Start>(Model_qifu.START_LEN);
      
      private var nowStartIndex:int;
      
      public function Child_start()
      {
         var start:Start = null;
         super();
         ComponentUtil.getBitmap("Text_QFXing",this,{
            "x":0,
            "y":0
         },Global.QiFudm);
         var j:int = 0;
         while(j < this.startVec.length)
         {
            start = new Start(75 + 43 * j,0);
            addChild(start);
            ComponentUtil.setPropertie(start,{"tabIndex":j + 1});
            start.addEventListener(MouseEvent.CLICK,this.cliHd);
            this.startVec[j] = start;
            start.selecte = false;
            j++;
         }
         ComponentUtil.getTextField("注:祈福星越多越容易抽到珍稀道具，每日零点清零",this,{
            "x":0,
            "y":26,
            "color":3461909,
            "size":12,
            "leading":0
         });
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var i:int = 0;
         var s:Start = null;
         var start:Start = e.target as Start;
         var index:int = int(start.tabIndex);
         var _index:int = this.checkLongestIndex();
         if(index == _index)
         {
            start.selecte = !start.selecte;
         }
         else
         {
            this.reset();
            i = 0;
            while(i < index)
            {
               s = this.startVec[i];
               s.selecte = true;
               i++;
            }
         }
         this.nowStartIndex = index;
      }
      
      private function checkLongestIndex() : int
      {
         var _num:int = 0;
         var s:Start = null;
         var i:int = 0;
         while(i < this.startVec.length)
         {
            s = this.startVec[i];
            if(s.selecte)
            {
               _num = i;
            }
            i++;
         }
         return _num + 1;
      }
      
      public function set start(value:int) : void
      {
         var s:Start = null;
         this.reset();
         var i:int = 0;
         while(i < value)
         {
            s = this.startVec[i];
            s.selecte = true;
            i++;
         }
      }
      
      private function reset() : void
      {
         var start:Start = null;
         for each(start in this.startVec)
         {
            start.selecte = false;
         }
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class Start extends Sprite
{
   
   private var bm:Bitmap;
   
   private var _selecte:Boolean = false;
   
   private var _startX:int;
   
   private var _startY:int;
   
   public function Start(_x:int, _y:int)
   {
      super();
      this._startX = _x;
      this._startY = _y;
      ComponentUtil.setPropertie(this,{
         "x":this._startX,
         "y":this._startY
      });
      this.bm = new Bitmap();
      addChild(this.bm);
      buttonMode = true;
      mouseChildren = false;
      mouseEnabled = false;
      addEventListener(MouseEvent.MOUSE_DOWN,this.downHd);
   }
   
   private function downHd(e:MouseEvent) : void
   {
      scaleX = 0.8;
      scaleY = 0.8;
      x = this._startX + 2;
      y = this._startY + 2;
      Global.stage.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void
      {
         Global.stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee);
         onUp();
      });
   }
   
   private function onUp() : void
   {
      scaleX = 1;
      scaleY = 1;
      x = this._startX;
      y = this._startY;
   }
   
   public function set selecte(value:Boolean) : void
   {
      this._selecte = value;
      if(value)
      {
         this.bm.bitmapData = ComponentUtil.getBitmapData("StartFull",Global.Img_Cdm);
      }
      else
      {
         this.bm.bitmapData = ComponentUtil.getBitmapData("StartEmpty",Global.Img_Cdm);
      }
   }
   
   public function get selecte() : Boolean
   {
      return this._selecte;
   }
}
