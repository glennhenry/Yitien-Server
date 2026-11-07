package com.yiTian.view.modules.newRechargeFeedback
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_NewRechargeFeedback;
   import com.yiTian.data.model.Model_NewRechargeFeedback;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.NewRechargeFeedbackCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_NewRechargeFeedback extends Panel123
   {
      
      private static var _instance:View_NewRechargeFeedback;
      
      private var back:Sprite;
      
      public var bar:View_NewFeedBackBar;
      
      public var itemList:View_NewFeedBackList;
      
      private var tipTF:MyTextField;
      
      private var itemVec:Vector.<NewFeedbackItem>;
      
      private const LEN:int = 7;
      
      private var titleBg:Bitmap;
      
      public function View_NewRechargeFeedback()
      {
         super();
         init();
      }
      
      public static function get instance() : View_NewRechargeFeedback
      {
         if(!_instance)
         {
            _instance = new View_NewRechargeFeedback();
         }
         return _instance;
      }
      
      public function upData() : void
      {
         var item:NewFeedbackItem = null;
         var i:int = 0;
         var status:Array = Model_NewRechargeFeedback.statusArr;
         while(i < this.LEN)
         {
            item = this.itemVec[i];
            item.upBtn(status[i]);
            i++;
         }
      }
      
      public function upTip(day:int) : void
      {
         var nextMoney:int = 0;
         var str:String = null;
         var needMoney:int = 0;
         var nextTarget:int = Model_NewRechargeFeedback.nowTarget + 1;
         if(nextTarget > Enum_NewRechargeFeedback.MAX_TARGET)
         {
            nextMoney = int(Data_lib.gcfk[Enum_NewRechargeFeedback.MAX_TARGET][0]);
            this.tipTF.htmlText = LangConfig.getWord("80221",8);
         }
         else
         {
            str = LangConfig.getWord("80229",8);
            nextMoney = int(Data_lib.gcfk[nextTarget][0]);
            needMoney = nextMoney - Model_NewRechargeFeedback.nowRecharge;
            this.tipTF.htmlText = LangConfig.reTxt(str,day,needMoney,nextMoney);
         }
         this.bar.go(Model_NewRechargeFeedback.nowRecharge,nextMoney);
      }
      
      override protected function initStaticView() : void
      {
         this.back = new Sprite();
         addChild(this.back);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.back,{
            "x":0,
            "y":0,
            "width":832 + 38,
            "height":441 + 30
         },Global.Img_Cdm);
         move = new Rectangle(0,0,width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":width - 38,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.tipTF = ComponentUtil.getTextField("",this,{
            "x":54,
            "y":337 - 250,
            "color":13420973,
            "size":12,
            "leading":10
         });
         this.tipTF.multiline = true;
      }
      
      private function creatGrid() : void
      {
         var item:NewFeedbackItem = null;
         this.itemVec = new Vector.<NewFeedbackItem>(this.LEN);
         var i:int = 0;
         while(i < 7)
         {
            item = new NewFeedbackItem();
            item.show(i + 1);
            addChild(item);
            ComponentUtil.setPropertie(item,{
               "x":62 + i * 107,
               "y":180
            });
            this.itemVec[i] = item;
            i++;
         }
         this.itemVec[0].onClick();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.NewHuiKui_Imgsdm)
            {
               regResource(Enum_NewRechargeFeedback.FEEDBACK_SOURCE,"NewHuiKui_Imgsdm");
               preFun();
            }
            else if(!this.titleBg)
            {
               this.initUI2();
            }
            else
            {
               NewRechargeFeedbackCGMessage.CG_NEW_OPEN_FEEDBACK();
            }
         }
      }
      
      override protected function initUI2() : void
      {
         if(Boolean(this.bar))
         {
            return;
         }
         ComponentUtil.getBitmap("Back_Img",this.back,{
            "x":24,
            "y":40
         },Global.NewHuiKui_Imgsdm);
         this.bar = new View_NewFeedBackBar();
         addChild(this.bar);
         ComponentUtil.setPropertie(this.bar,{
            "x":55,
            "y":130
         });
         this.itemList = new View_NewFeedBackList();
         addChild(this.itemList);
         ComponentUtil.setPropertie(this.itemList,{
            "x":90,
            "y":350
         });
         this.creatGrid();
         this.titleBg = ComponentUtil.getBitmap("Title_HuiKui",this,{
            "x":368,
            "y":5
         },Global.NewHuiKui_Imgsdm);
         ComponentUtil.getButton("","Button_Recharge",this,{
            "x":682,
            "y":120,
            "textColor":16184781,
            "callBack":function(event:MouseEvent):void
            {
               UIManager.yuanBaoXiang.visible = true;
            }
         },Global.NewHuiKui_Imgsdm);
         NewRechargeFeedbackCGMessage.CG_NEW_OPEN_FEEDBACK();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

