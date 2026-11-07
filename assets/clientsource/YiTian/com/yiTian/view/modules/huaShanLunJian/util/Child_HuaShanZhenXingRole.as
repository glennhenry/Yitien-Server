package com.yiTian.view.modules.huaShanLunJian.util
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.data.config.Enum_job;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class Child_HuaShanZhenXingRole extends Sprite
   {
      
      private static const actionMap:Object = {
         20101:20101,
         20102:20101,
         20201:20231,
         20202:20231,
         20301:20331,
         20302:20331,
         20401:20431,
         20402:20431
      };
      
      private var bodyPart:RolePart;
      
      private var tf_nameBar:MyTextField;
      
      private var bodyContainer:Sprite;
      
      public var TID:Number;
      
      public var xIndex:int;
      
      public var yIndex:int;
      
      public var type:int;
      
      private var extraObj:Object;
      
      private var testTf:MyTextField;
      
      private var _timeOutIndex:int = 0;
      
      private var _mID:int;
      
      private var last:int;
      
      private var playSpeed:int;
      
      public function Child_HuaShanZhenXingRole()
      {
         super();
         this.bodyContainer = new Sprite();
         this.bodyPart = new RolePart();
         this.bodyContainer.addChild(this.bodyPart);
         this.bodyContainer.scaleX = this.bodyContainer.scaleY = HuaShanUtil.ROLESCALE;
         mouseChildren = false;
         addChild(this.bodyContainer);
         this.tf_nameBar = ComponentUtil.getTextField("",this,{
            "x":-100,
            "y":-85,
            "realWidth":200,
            "color":16764206
         });
         this.tf_nameBar.autoSize = TextFieldAutoSize.CENTER;
         addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
         addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
         this.testTf = ComponentUtil.getTextField("",this);
      }
      
      private function overHd(event:MouseEvent) : void
      {
         transform.colorTransform = Util.colorWhite2;
      }
      
      private function outHd(event:MouseEvent) : void
      {
         transform.colorTransform = Util.colorNomal;
      }
      
      public function setModelID(mId:int = 0) : void
      {
         this.playSpeed = 270;
         if(mId != 0)
         {
            this._mID = mId;
         }
         this.last = getTimer();
         this.bodyPart.modelDir = "modelRes/role/body/stand/" + this._mID.toString() + ".swf";
         this.bodyPart.updateAniIm();
         this.clearTime();
      }
      
      public function setAtt(time:int = 1500) : void
      {
         this.playSpeed = 50;
         this.last = getTimer();
         var sex:int = this._mID % 10;
         var shizhuang:int = this._mID / 10 % 10;
         var job:int = this._mID / 100 % 10;
         var skillBasicId:int = 20000 + sex + Enum_job.getBaseJob(job) * 100;
         if(Boolean(actionMap[skillBasicId]) && this.type == 1)
         {
            this.bodyPart.modelDir = "modelRes/role/body/attack/" + this._mID + "_" + actionMap[skillBasicId] + ".swf";
         }
         else
         {
            this.bodyPart.modelDir = "modelRes/role/body/attack/" + this._mID + ".swf";
         }
         this.bodyPart.reset();
         this.clearTime();
         this._timeOutIndex = setTimeout(this.onTimerOut,time);
      }
      
      private function onTimerOut() : void
      {
         this.clearTime();
         this.setModelID();
      }
      
      private function clearTime() : void
      {
         if(this._timeOutIndex != 0)
         {
            clearTimeout(this._timeOutIndex);
            this._timeOutIndex = 0;
         }
      }
      
      public function set way(value:int) : void
      {
         this.bodyPart.way = value;
      }
      
      public function set roleName(value:String) : void
      {
         this.tf_nameBar.htmlText = value;
      }
      
      public function update() : void
      {
         var now:int = getTimer();
         if(now - this.last >= this.playSpeed)
         {
            this.last = now;
            this.bodyPart.refresh();
         }
      }
   }
}

import com.utils.DisplayData;
import com.utils.ResObj;
import com.yiTian.manager.ResourceManager;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.utils.getTimer;

class RolePart extends Bitmap
{
   
   protected var _way:int;
   
   protected var current:int;
   
   protected var _modelDir:String;
   
   public function RolePart(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
   {
      super(bitmapData,pixelSnapping,smoothing);
   }
   
   public function set way(value:int) : void
   {
      this._way = value;
   }
   
   public function get way() : int
   {
      return this._way;
   }
   
   public function set modelDir(value:String) : void
   {
      this._modelDir = value;
   }
   
   public function reset() : void
   {
      this.current = 0;
      this.refresh();
   }
   
   public function updateAniIm() : void
   {
      this.refresh();
   }
   
   public function dispose() : void
   {
      bitmapData = null;
      this.current = 0;
   }
   
   public function refresh() : void
   {
      var res:ResObj = null;
      var data:DisplayData = null;
      var nowIndex:int = 0;
      var temp_i:int = 0;
      var isAttAction:Boolean = false;
      var curTime:int = getTimer();
      res = ResourceManager.resourceIndex[this._modelDir];
      if(Boolean(res))
      {
         res.lastUseTime = curTime;
      }
      else
      {
         ResourceManager.load(this._modelDir);
      }
      if(Boolean(res) && res.isLoad)
      {
         isAttAction = res.f != null;
         if(isAttAction && this.current >= res.f.length - 1)
         {
            nowIndex = int(this.current);
         }
         else
         {
            nowIndex = this.current + 1;
            nowIndex %= res.actionFrame;
         }
         if(nowIndex == this.current)
         {
            return;
         }
         this.current = nowIndex;
         if(res.way == 5)
         {
            temp_i = (this.way < 5 ? this.way : 8 - this.way) * res.actionFrame + this.current;
         }
         else if(res.way == 2)
         {
            if(this.way >= 1 && this.way <= 4)
            {
               temp_i = res.actionFrame + this.current;
            }
            else
            {
               temp_i = int(this.current);
            }
         }
         else
         {
            temp_i = int(this.current);
         }
         if(!isAttAction)
         {
            data = ResourceManager.find(res,temp_i);
         }
         else
         {
            data = ResourceManager.find(res,res.f[temp_i]);
         }
         bitmapData = data.p;
         y = data.y;
         if(this.way <= 4)
         {
            x = data.x;
            scaleX = 1;
         }
         else
         {
            x = -data.x;
            scaleX = -1;
         }
      }
      else
      {
         bitmapData = null;
      }
   }
}
