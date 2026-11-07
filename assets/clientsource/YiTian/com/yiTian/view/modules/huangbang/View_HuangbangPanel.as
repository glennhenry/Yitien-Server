package com.yiTian.view.modules.huangbang
{
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HuangbangCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class View_HuangbangPanel extends Panel
   {
      
      public var tou:Child_ShaiziContainer;
      
      private var bg:Bitmap = new Bitmap();
      
      public var shaizi:Child_ShakerItem;
      
      private var lastClickTime:uint;
      
      private var isInit:Boolean = false;
      
      public function View_HuangbangPanel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_HuangbangPanel
      {
         return Singleton.getInstance(View_HuangbangPanel);
      }
      
      override protected function initStaticView() : void
      {
         addChild(this.bg);
         Utils.getLoadBitmap("resource/image/huangbang/Back_SZDK.png",this.bg,{
            "x":5,
            "y":110
         });
      }
      
      override protected function initDynamicView() : void
      {
         var jumpLoopItem:Child_ShakerItem = null;
         super.initDynamicView();
         bAutoRemove = false;
         this.shaizi = new Child_ShakerItem();
         this.shaizi.update("shaizi","点击投骰");
         this.shaizi.x = 60;
         this.shaizi.y = 100;
         addChild(this.shaizi);
         jumpLoopItem = new Child_ShakerItem();
         jumpLoopItem.update("tiao","点击跳圈");
         jumpLoopItem.x = 190;
         jumpLoopItem.y = 100;
         addChild(jumpLoopItem);
         this.shaizi.addEventListener(MouseEvent.CLICK,this.shaker);
         jumpLoopItem.addEventListener(MouseEvent.CLICK,this.jump);
         this.tou = new Child_ShaiziContainer();
         this.tou.x = 14;
         this.tou.y = 50;
         addChild(this.tou);
         this.tou.visible = false;
      }
      
      public function showShake() : void
      {
         if(Model_Huangbang.currentCount >= 100)
         {
            this.shaizi.hideGuideByClick();
            return;
         }
         this.shaizi.showShake();
      }
      
      private function shaker(e:MouseEvent) : void
      {
         if(Model_Huangbang.currentLoop == Enum_Huangbang.MAX_QUALITY)
         {
            UIManager.centerBroadcast.addMsg("已到最大圈，不需要进行投骰");
            this.shaizi.hideGuideByClick();
            return;
         }
         if(Model_Huangbang.canClickShake == false)
         {
            return;
         }
         UIManager.wuXingProm.show(function():void
         {
            if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < int(Model_Huangbang.silverArr[Model_Huangbang.currentLoop + Enum_Huangbang.SILVER_OFFSET]))
            {
               UIManager.centerBroadcast.addMsg("银子不够");
               return;
            }
            HuangbangCGMessage.CG_SHAKER();
         },"是否花费<font color=\'" + ColorConstant.getColorStr(ColorConstant.YELLOW) + "\'>" + Model_Huangbang.silverArr[Model_Huangbang.currentLoop + Enum_Huangbang.SILVER_OFFSET] + "银两（优先使用绑银）</font>摇动骰子？",Enum_Huangbang.HUANGBANG_NUM + Model_Huangbang.silverArr[Model_Huangbang.currentLoop + Enum_Huangbang.SILVER_OFFSET]);
      }
      
      public function jump(e:MouseEvent = null) : void
      {
         if(Model_Huangbang.canClickShake == false)
         {
            return;
         }
         if(Model_Huangbang.currentLoop == Enum_Huangbang.MAX_QUALITY)
         {
            UIManager.centerBroadcast.addMsg("已到最大圈，不需要进行跳圈");
            return;
         }
         View_Alert.show("是否花费<font color=\'" + ColorConstant.getColorStr(ColorConstant.YELLOW) + "\'>" + Model_Huangbang.loopArr[Model_Huangbang.currentLoop + Enum_Huangbang.SILVER_OFFSET] + "跳跃令或" + Model_Huangbang.goldArr[Model_Huangbang.currentLoop + Enum_Huangbang.GOLD_OFFSET] + "元宝</font>跳转至<font color=\'" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\'>" + Model_Huangbang.loopArr[Model_Huangbang.currentLoop + Enum_Huangbang.GOLD_OFFSET] + "</font>任务品质圈",View_Alert.OK_CANCAL,function():void
         {
            HuangbangCGMessage.CG_JUMP_HUANGBANG();
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(!this.isInit)
            {
               this.isInit = true;
               if(!Global.HuangBang_Imgdm)
               {
                  this.load();
               }
               else
               {
                  this.initT();
                  this.visible = true;
               }
               return;
            }
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         }
         super.visible = value;
      }
      
      private function onFrame(interval:int) : void
      {
         Global.control.sendNotification(Enum_MsgType.FXQ_FRAME,interval);
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push(["lang/ch/HuangBang_Img.swf",this.touLoadZiComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function initT() : void
      {
         this.tou.init();
      }
      
      private function touLoadZiComplete(info:Object) : void
      {
         Global.HuangBang_Imgdm = info.applicationDomain;
         this.initT();
         this.visible = true;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 300;
         y = Global.stage.stageHeight - 300;
      }
   }
}

