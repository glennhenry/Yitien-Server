package com.yiTian.view.modules.guaji
{
   import com.utils.Util;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class View_wwsxMoveButton extends Sprite
   {
      
      private static var instance:View_wwsxMoveButton;
      
      private var bm_bg:Bitmap;
      
      private var _isUseFilters:Boolean = true;
      
      private var last:Number = 0;
      
      private var now:Number = 0;
      
      public function View_wwsxMoveButton()
      {
         super();
         if(Boolean(instance))
         {
            throw new Error("singlon error");
         }
         instance = this;
         this.init();
      }
      
      public static function getInstance() : View_wwsxMoveButton
      {
         if(instance)
         {
         }
         return instance;
      }
      
      private function drawRect16() : void
      {
         graphics.beginFill(16777215,0);
         graphics.drawRect(0,0,16,16);
         graphics.endFill();
      }
      
      public function update() : void
      {
         var time:int = Model_guajiInfo.getInstance().wawaTime;
         if(Model_guajiInfo.getInstance().wawaTime < 1)
         {
            UIManager.heroHead.removeBuff(this);
         }
         else
         {
            UIManager.heroHead.addBuff(this);
            if(Model_guajiInfo.getInstance().sxType == 2)
            {
               this.isUseFilters = false;
            }
            else
            {
               this.isUseFilters = true;
            }
         }
      }
      
      private function init() : void
      {
         this.drawRect16();
         this.bm_bg = Utils.getLoadBitmap("resource/image/buff/" + "46300" + ".png",this.bm_bg);
         addChild(this.bm_bg);
         addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandle);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandle);
         x = 90;
         y = 75;
         UIManager.heroHead.addBuff(this);
      }
      
      private function rollOverHandle(evt:MouseEvent) : void
      {
         GameScene.instance.addFrameCallBack(this.enterFrameHandle);
      }
      
      private function rollOutHandle(evt:MouseEvent) : void
      {
         GameScene.instance.removeFrameCallBack(this.enterFrameHandle);
         TipManager.hide();
      }
      
      public function get isUseFilters() : Boolean
      {
         return this._isUseFilters;
      }
      
      public function set isUseFilters(value:Boolean) : void
      {
         if(value == true)
         {
            filters = Util.disabled;
         }
         else
         {
            filters = [];
         }
         this._isUseFilters = value;
      }
      
      private function enterFrameHandle(interval:int) : void
      {
         var ins:Model_guajiInfo = null;
         var remainTime:Number = NaN;
         var str:String = this.formToTimeString(Model_guajiInfo.getInstance().wawaTime);
         if(Model_guajiInfo.getInstance().sxType == 2)
         {
            ins = Model_guajiInfo.getInstance();
            remainTime = ins.wawaTime - (getTimer() - ins.lastUpdateWawaTime) / 1000;
            if(remainTime <= 0)
            {
               str = "00:00:00";
            }
            else
            {
               str = this.formToTimeString(remainTime);
            }
         }
         if(!this._isUseFilters)
         {
            TipManager.update(LangConfig.getWord("21111",2,str));
         }
         else
         {
            TipManager.update(LangConfig.getWord("21112",2,str));
         }
      }
      
      private function formToTimeString(__time:Number, __insertHout:String = null, __insertMinute:String = null) : String
      {
         if(__insertHout == null)
         {
            __insertHout = LangConfig.getWord("10450",1);
         }
         if(__insertMinute == null)
         {
            __insertMinute = LangConfig.getWord("10451",1);
         }
         var __hour:uint = uint(__time / 3600 >> 0);
         var __minute:int = Math.round(__time % 3600 / 60);
         if(__minute >= 60)
         {
            __minute = 0;
            __hour += 1;
         }
         var __timeTxt:String = " ";
         if(__hour > 0)
         {
            __timeTxt += (__hour >= 10 || __hour == 0 ? __hour : "0" + __hour) + __insertHout;
         }
         return __timeTxt + ((__minute < 10 ? "0" + __minute.toString() : __minute.toString()) + __insertMinute);
      }
   }
}

