package com.yiTian.view.modules.FeiXingQi
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DisplayData;
   import com.utils.ResObj;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class Child_FeiXingQiUnit extends Sprite
   {
      
      private var _way:int;
      
      private var bm_body:Bitmap;
      
      private var _actCounter:int;
      
      private var _aniTime:uint = 200;
      
      private var current:int = 0;
      
      public var state:int;
      
      private var _modelId:int;
      
      public var tileIndex:int;
      
      public var stepRemain:int;
      
      public var id:Number = 0;
      
      private var _tf_name:MyTextField;
      
      private var _name:String;
      
      private var parts:Sprite;
      
      private var _isPlay:Boolean = false;
      
      public var sex:int;
      
      public var job:int;
      
      public var targetIndex:int;
      
      public function Child_FeiXingQiUnit()
      {
         super();
         this.bm_body = new Bitmap();
         this.parts = new Sprite();
         this.parts.addChild(this.bm_body);
         this.parts.scaleX = this.parts.scaleY = Enum_FeiXingQi.ROLESCALE;
         addChild(this.parts);
         graphics.beginFill(0,0.3);
         graphics.drawEllipse(-9,-5,18,10);
         graphics.endFill();
         this._tf_name = ComponentUtil.getTextField("",this,{
            "x":-75,
            "y":-75,
            "realWidth":150
         });
         this._tf_name.autoSize = TextFieldAutoSize.CENTER;
      }
      
      public function StartAni() : void
      {
         if(this._isPlay)
         {
            return;
         }
         this._isPlay = true;
         Global.control.registerCallBack(Enum_MsgType.FXQ_FRAME,this.frameStep);
      }
      
      public function stopAni() : void
      {
         if(!this._isPlay)
         {
            return;
         }
         this._isPlay = false;
         Global.control.removeCallBack(Enum_MsgType.FXQ_FRAME,this.frameStep);
      }
      
      public function get isPlay() : Boolean
      {
         return this._isPlay;
      }
      
      public function frameStep(interval:int) : void
      {
         this._actCounter += interval;
         if(int(this.actCounter / this._aniTime) > 0)
         {
            this.updateAni("modelRes/role/body/" + Enum_FeiXingQi.STATUSDIR[this.state] + "/" + this._modelId.toString() + ".swf");
            this._actCounter %= this._aniTime;
         }
      }
      
      public function set uName(value:String) : void
      {
         value = Model_heFu.repNameByHero(value);
         this._tf_name.htmlText = value;
         this._name = value;
      }
      
      public function get uName() : String
      {
         return this._name;
      }
      
      public function set way(value:int) : void
      {
         this._way = value;
      }
      
      public function get way() : int
      {
         return this._way;
      }
      
      public function set modelId(value:int) : void
      {
         this._modelId = value;
      }
      
      public function set actCounter(value:int) : void
      {
         this._actCounter = 0;
      }
      
      public function get actCounter() : int
      {
         return this._actCounter;
      }
      
      public function set aniTime(value:uint) : void
      {
         this._aniTime = value;
      }
      
      public function resetAni() : void
      {
         this._actCounter = 0;
         this.current = 0;
         this.updateAni("modelRes/role/body/" + Enum_FeiXingQi.STATUSDIR[this.state] + "/" + this._modelId.toString() + ".swf");
      }
      
      public function updateAniIm() : void
      {
         this.updateAni("modelRes/role/body/" + Enum_FeiXingQi.STATUSDIR[this.state] + "/" + this._modelId.toString() + ".swf");
      }
      
      public function dispose() : void
      {
         visible = true;
         this.stopAni();
         Tween.stop(this);
         Model_FeiXingQi.unitsPool.push(this);
      }
      
      private function updateAni(url:String) : void
      {
         var res:ResObj = null;
         var data:DisplayData = null;
         var nowIndex:int = 0;
         var temp_i:int = 0;
         var curTime:int = getTimer();
         res = ResourceManager.resourceIndex[url];
         if(Boolean(res))
         {
            res.lastUseTime = curTime;
         }
         else
         {
            ResourceManager.load(url);
         }
         if(Boolean(res) && res.isLoad)
         {
            nowIndex = this.current + 1;
            nowIndex %= res.actionFrame;
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
                  temp_i = this.current;
               }
            }
            else
            {
               temp_i = this.current;
            }
            data = ResourceManager.find(res,temp_i);
            this.bm_body.bitmapData = data.p;
            this.bm_body.y = data.y;
            if(this.way <= 4)
            {
               this.bm_body.x = data.x;
               this.bm_body.scaleX = 1;
            }
            else
            {
               this.bm_body.x = -data.x;
               this.bm_body.scaleX = -1;
            }
         }
      }
   }
}

