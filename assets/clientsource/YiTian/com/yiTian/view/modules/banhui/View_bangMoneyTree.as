package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.IntervalTimer;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.banhui.BangBuilding.Child_MoneyTreeProcessBar15;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_bangMoneyTree extends Panel
   {
      
      private var bg:DisplayObject;
      
      private var pb:Child_MoneyTreeProcessBar15;
      
      private var btn_shake:Button;
      
      private var tf_info:MyTextField;
      
      private var tf_timer:MyTextField;
      
      private var iTimer:IntervalTimer;
      
      private var bmp:Bitmap;
      
      private var eff:Effect;
      
      private var lastTime:int;
      
      private var isInitB:Boolean = false;
      
      private var remain:int;
      
      private var _count:int;
      
      public function View_bangMoneyTree()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var bg1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":382,
            "height":434
         },Global.Img_Cdm);
         var bg2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":334,
            "height":384
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Prompt",[3,3,44,44],this,{
            "x":29,
            "y":340,
            "width":324,
            "height":79
         },Global.Img_Cdm);
         this.bmp = new Bitmap();
         addChild(this.bmp);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":342,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_info = ComponentUtil.getTextField("",this,{
            "x":35,
            "y":350,
            "color":780528,
            "bold":true,
            "size":12,
            "leading":8
         });
         this.btn_shake = ComponentUtil.getButton(LangConfig.getWord("50032",5),"Button_Four",this,{
            "x":273,
            "y":391,
            "textColor":16184781
         },Global.Img_Cdm);
         this.bmp.x = 26;
         this.bmp.y = 42;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.pb = new Child_MoneyTreeProcessBar15();
         this.pb.x = 85;
         this.pb.y = 398.5;
         addChild(this.pb);
         this.tf_timer = ComponentUtil.getTextField("",this.pb,{
            "y":-4,
            "realWidth":160,
            "color":16776960
         });
         this.tf_timer.autoSize = TextFieldAutoSize.CENTER;
         this.btn_shake.callBack = this.shakeClickHd;
      }
      
      private function shakeClickHd(evt:MouseEvent) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime > 3000)
         {
            this.lastTime = now;
            BangCGMessage.CG_SHAKE_MONEY_TREE();
         }
      }
      
      public function addeffect() : void
      {
         this.eff = EffectManager.addEffect("35086",this,1000,181,216,false);
         setChildIndex(this.eff,getChildIndex(this.btn_shake) - 1);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 378) / 2;
         y = (Global.stage.stageHeight - 431) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         super.visible = value;
         if(value)
         {
            BangCGMessage.CG_MONEYTREEINFO();
            if(!this.isInitB)
            {
               this.isInitB = true;
               arr = [];
               if(!Global.Bang_Imgsdm)
               {
                  SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
                  {
                     Global.Bang_Imgsdm = info.applicationDomain;
                     showTitl();
                     pb.init();
                  });
               }
               else
               {
                  ComponentUtil.getBitmap("Title_BangGarden",this,{
                     "x":111,
                     "y":5
                  },Global.Bang_Imgsdm);
                  this.pb.init();
               }
               Utils.getLoadBitmap("resource/image/bang/mTree.jpg",this.bmp);
               return;
            }
         }
         else if(Boolean(this.iTimer))
         {
            this.iTimer.stop();
         }
      }
      
      private function showTitl() : void
      {
         ComponentUtil.getBitmap("Title_BangGarden",this,{
            "x":111,
            "y":5
         },Global.Bang_Imgsdm);
      }
      
      private function onC(info:Object) : void
      {
         var bm:Bitmap = null;
         bm = info.content;
         bm.x = 15;
         bm.y = 45;
         addChildAt(bm,1);
         this.visible = true;
      }
      
      public function update(count:int = -1) : void
      {
         if(count != -1)
         {
            this._count = count;
         }
         this.pb.count = this._count;
         var lv:int = int(Model_bang.bangBuildingLevel[4]);
         var num_finish:int = Model_bang.moneyTreeShakeTimes15;
         var lvStr:String = LangConfig.getWord("29174",2) + lv.toString();
         var shakeInfo:String = LangConfig.getWord("29175",2) + Model_bang.moneyTreeShakeTimes15 + "/" + (lv + 3).toString();
         var extra:String = LangConfig.getWord("29176",2);
         var info:String = lvStr + "\n" + shakeInfo + "\n" + extra;
         this.tf_info.htmlText = info;
      }
      
      public function updateTimer(r:int) : void
      {
         this.remain = r;
         if(!this.iTimer)
         {
            this.iTimer = new IntervalTimer();
            this.iTimer.interval = 1000;
            this.iTimer.tickFun = this.tickFun;
         }
         if(r > 0)
         {
            this.iTimer.updateRecordTime = getTimer();
            this.tf_timer.visible = true;
            this.iTimer.start();
         }
         else
         {
            this.tf_timer.visible = false;
            this.tf_timer.text = "";
            this.iTimer.stop();
         }
      }
      
      private function tickFun() : void
      {
         if(!visible)
         {
            this.iTimer.stop();
         }
         var flagTime:int = this.iTimer.updateRecordTime;
         var now:int = getTimer();
         var remainS:int = this.remain - (now - flagTime) / 1000;
         if(remainS >= 0)
         {
            this.tf_timer.text = DateUtil.getMSBySecond3(remainS);
            this.tf_timer.visible = true;
         }
         else
         {
            this.tf_timer.visible = false;
            this.tf_timer.text = "";
            this.iTimer.stop();
         }
      }
   }
}

