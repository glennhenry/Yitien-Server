package com.yiTian.view.modules.moneyTree
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MoneyTreeCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   
   public class Icon_MoneyTree extends Sprite
   {
      
      private static var _instance:Icon_MoneyTree;
      
      private var _bm:Bitmap;
      
      private var bm:Bitmap;
      
      private var _flag:int;
      
      private var timeTF:MyTextField;
      
      private var _time:int;
      
      private var timer:Timer;
      
      private var _isShowTime:Boolean;
      
      public function Icon_MoneyTree()
      {
         super();
         this.buttonMode = true;
      }
      
      public static function get instance() : Icon_MoneyTree
      {
         if(!_instance)
         {
            _instance = new Icon_MoneyTree();
         }
         return _instance;
      }
      
      public function init(resulte:int, flag:int, time:int, isShowTime:Boolean) : void
      {
         this._isShowTime = isShowTime;
         if(resulte != 1)
         {
            if(Boolean(this.timer))
            {
               this.timer.stop();
               this.timer.removeEventListener(TimerEvent.TIMER,this.timerHandler);
            }
            if(Boolean(this._bm))
            {
               UIManager.mainUiBtnContainer.removeBTN(this);
            }
            return;
         }
         this._flag = flag;
         this._time = time;
         if(this._time > 0 && !this.timer)
         {
            this.timer = new Timer(1000);
            this.timer.start();
            this.timer.addEventListener(TimerEvent.TIMER,this.timerHandler);
         }
         if(GameUnitManager.hero.level < 19)
         {
            this._isShowTime = true;
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.showBtn);
         }
         else
         {
            this.showBtn();
         }
      }
      
      private function showBtn() : void
      {
         if(GameUnitManager.hero.level < 19)
         {
            return;
         }
         if(Boolean(this._bm))
         {
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,this.showBtn);
         this._bm = new Bitmap();
         this._bm = Utils.getLoadBitmap("resource/image/mainIcon/Icon_YQS.png",this._bm,null,this.flyIcon);
         addChild(this._bm);
         UIManager.mainUiBtnContainer.addBTN(this);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.timeTF = ComponentUtil.getTextField("",this,{
            "x":32,
            "y":57,
            "color":16776960,
            "size":12,
            "leading":0
         },TextFieldAutoSize.CENTER);
         this.timeTF.visible = this._isShowTime;
      }
      
      protected function timerHandler(event:TimerEvent) : void
      {
         --this._time;
         if(this._time <= 0)
         {
            this.timeTF.text = "";
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER,this.timerHandler);
            return;
         }
         if(Boolean(this.timeTF))
         {
            this.timeTF.text = this.getMSBySecond4(this._time);
         }
      }
      
      private function flyIcon() : void
      {
         var effBmComplete:Function;
         var p:Point = null;
         if(this._flag == 1)
         {
            effBmComplete = function(bm:Bitmap):void
            {
               var effBmEnd:Function = null;
               effBmEnd = function(bm:Bitmap):void
               {
                  if(Boolean(bm) && Boolean(bm.parent))
                  {
                     bm.scaleX = bm.scaleY = 1;
                     bm.x = bm.y = 0;
                     bm.alpha = 0;
                     bm.bitmapData = null;
                     bm.parent.removeChild(bm);
                  }
               };
               if(Boolean(bm) && Boolean(bm.parent))
               {
                  bm.parent.removeChild(bm);
               }
               Icon_MoneyTree.instance.addChild(bm);
               Tween.to(bm,1000,{
                  "alpha":[1,0],
                  "x":[0,-bm.width / 2],
                  "y":[0,-bm.height / 2],
                  "scaleX":[1,2],
                  "scaleY":[1,2]
               },effBmEnd);
            };
            this.bm = new Bitmap();
            this.bm = Utils.getLoadBitmap("resource/image/mainIcon/Icon_YQS.png",this.bm);
            GameScene.uiLayer.addChild(this.bm);
            this._flag = 0;
            p = UIManager.mainUiBtnContainer.getT(this);
            Tween.to(this.bm,1000,{
               "x":[Global.stage.stageWidth / 2,p.x],
               "y":[Global.stage.stageHeight / 2,p.y]
            },effBmComplete);
         }
      }
      
      private function clickHandle(e:MouseEvent) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_MoneyTree.instance,function():void
         {
            View_MoneyTree.instance.visible = !View_MoneyTree.instance.visible;
            MoneyTreeCGMessage.CG_MONEYTREE_OPENWIN();
         });
      }
      
      public function setStatus() : void
      {
         this._isShowTime = false;
         this.timeTF.visible = this._isShowTime;
      }
      
      public function getMSBySecond4(second:Number, division:String = "天时分秒") : String
      {
         var h:int = 0;
         var hour:int = 0;
         var h1:int = 0;
         var m:int = 0;
         var min:int = 0;
         var m1:int = 0;
         var s:int = 0;
         var sec:int = 0;
         var result:String = "";
         var day:String = uint(second / (3600 * 24)) + "";
         if(int(day) >= 1)
         {
            result = day + "天";
            h = second % (3600 * 24);
            if(h == 0)
            {
               return result + "0时";
            }
            hour = int(h / 3600);
            result = result + hour + "时";
         }
         else
         {
            h1 = int(uint(second / 3600));
            if(h1 >= 1)
            {
               result = h1 + "时";
               m = int(second % 3600);
               if(m == 0)
               {
                  return result + "0分";
               }
               min = int(m / 60);
               result = result + min + "分";
            }
            else
            {
               m1 = int(second / 60);
               if(m1 >= 0)
               {
                  result = m1 + "分";
                  s = int(second % 60);
                  if(s == 0)
                  {
                     return result + "0秒";
                  }
                  sec = s;
                  result = result + s + "秒";
               }
            }
         }
         return result;
      }
   }
}

