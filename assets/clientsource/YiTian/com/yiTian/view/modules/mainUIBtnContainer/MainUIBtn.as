package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.view.modules.yellowDiamond.Model_txAction;
   import com.yiTian.view.modules.yellowDiamond.View_yellowDiamond;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class MainUIBtn extends IMainUiBtn
   {
      
      public static var _stop:Boolean = false;
      
      public static var isPlaying:Boolean = false;
      
      private const btnW:Number = 50;
      
      private const btnH:Number = 50;
      
      private var eff:Effect;
      
      public var bmp:Bitmap2;
      
      private var countDownTxt:MyTextField;
      
      private var leftSeconds:int;
      
      private var t_interval:int;
      
      private var autoHide:Boolean;
      
      private var bool:Boolean = false;
      
      private var _timeArr:Array = [];
      
      private var overStr:String;
      
      private var outStr:String;
      
      public function MainUIBtn(url:String, pro:Object = null, callBack:Function = null, addBtnCall:Function = null, canHide:Boolean = false)
      {
         super();
         bmUrl = url;
         this.bmp = new Bitmap2();
         addChild(this.bmp);
         ComponentUtil.setPropertie(this.bmp,pro);
         this.graphics.beginFill(16777215,0);
         this.graphics.drawRect(0,0,this.btnW,this.btnH);
         this.graphics.endFill();
         this.bmp.load(url);
         this.buttonMode = true;
         this.countDownTxt = ComponentUtil.getTextField("",this,{
            "x":32,
            "y":this.height,
            "color":16776960
         },"center");
         this.countDownTxt.mouseEnabled = false;
         if(canHide)
         {
            Global.control.registerCallBack(Enum_mainUIBtn_hide.MOVE_TO_HIDE,this.onHide);
         }
      }
      
      public function setSource(url:String) : void
      {
         bmUrl = url;
         this.bmp.load(url);
      }
      
      public function showEff() : void
      {
         if(_stop)
         {
            this.stop();
            return;
         }
         this._timeArr.push(setTimeout(this.play,500));
      }
      
      public function stop() : void
      {
         if(Boolean(this._timeArr.length))
         {
            clearTimeout(this._timeArr.shift());
         }
         var overStr:String = Model_txAction.instance.overStr;
         isPlaying = false;
         this.bmp.load("resource/image/Diamond/" + overStr + ".png");
      }
      
      private function play() : void
      {
         var str:String;
         this.bmp.bitmapData = null;
         if(!this.overStr)
         {
            this.overStr = Model_txAction.instance.overStr;
         }
         if(!this.outStr)
         {
            this.outStr = Model_txAction.instance.outStr;
         }
         str = this.bool ? this.overStr : this.outStr;
         isPlaying = true;
         this.bmp.load("resource/image/Diamond/" + str + ".png",MassLoader.LEVEL3,function():void
         {
            bool = !bool;
            clearTimeout(_timeArr.shift());
            showEff();
         });
         if(!View_yellowDiamond.isFirstOpen)
         {
            _stop = UIManager.yellowDiamond.listenToCanGet();
         }
      }
      
      private function onHide() : void
      {
         UIManager.mainUiBtnContainer.partPauseRemove(this,1);
      }
      
      public function effectBegin() : void
      {
         if(!this.eff)
         {
            this.eff = EffectManager.addEffect("35343",this,1000,32,29,true);
         }
      }
      
      public function effectEnd() : void
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
      }
      
      public function setCountDown(seconds:int, autoHide:Boolean = false) : void
      {
         this.leftSeconds = seconds;
         this.autoHide = autoHide;
         this.t_interval = 0;
         this.setCountDownTxt(this.leftSeconds);
         if(this.leftSeconds > 0)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCountDown);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCountDown);
         }
      }
      
      private function onCountDown(interval:int) : void
      {
         var pastSeconds:int = 0;
         this.t_interval += interval;
         if(this.t_interval >= 1000)
         {
            pastSeconds = this.t_interval / 1000;
            this.leftSeconds -= pastSeconds;
            this.setCountDownTxt(this.leftSeconds);
            this.t_interval %= 1000;
            if(this.leftSeconds <= 0)
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCountDown);
            }
         }
      }
      
      private function setCountDownTxt(seconds:uint) : void
      {
         var days:int = 0;
         var hours:int = 0;
         var minutes:int = 0;
         var leftSeconds:int = 0;
         if(seconds > 0)
         {
            days = seconds / 3600 / 24;
            hours = seconds / 3600 % 24;
            if(days > 0)
            {
               this.countDownTxt.text = days + "天" + hours + "时";
            }
            else
            {
               minutes = seconds / 60 % 60;
               if(hours > 0)
               {
                  this.countDownTxt.text = hours + "时" + minutes + "分";
               }
               else
               {
                  leftSeconds = seconds % 60;
                  this.countDownTxt.text = minutes + "分" + leftSeconds + "秒";
               }
            }
         }
         else
         {
            this.countDownTxt.text = "";
            if(this.autoHide)
            {
               if(Boolean(this.stage))
               {
                  this.parent.removeChild(this);
               }
               this.effectEnd();
            }
         }
      }
   }
}

