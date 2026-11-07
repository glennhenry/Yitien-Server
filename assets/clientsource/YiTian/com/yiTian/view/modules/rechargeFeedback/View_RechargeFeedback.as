package com.yiTian.view.modules.rechargeFeedback
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_RechargeFeedback;
   import com.yiTian.data.model.Model_RechargeFeedback;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RechargeFeedbackCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_RechargeFeedback extends Panel123
   {
      
      private static var _instance:View_RechargeFeedback;
      
      public var bar:View_FeedBackBar;
      
      public var itemList:View_FeedBackList;
      
      private var tipTF:MyTextField;
      
      private var itemVec:Vector.<FeedbackItem>;
      
      private const LEN:int = 7;
      
      private var titleBg:Bitmap;
      
      public function View_RechargeFeedback()
      {
         super();
         init();
      }
      
      public static function get instance() : View_RechargeFeedback
      {
         if(!_instance)
         {
            _instance = new View_RechargeFeedback();
         }
         return _instance;
      }
      
      public function upData() : void
      {
         var item:FeedbackItem = null;
         var i:int = 0;
         var status:Array = Model_RechargeFeedback.statusArr;
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
         var nextTarget:int = Model_RechargeFeedback.nowTarget + 1;
         if(nextTarget > Enum_RechargeFeedback.MAX_TARGET)
         {
            nextMoney = int(Data_lib.czfk[Enum_RechargeFeedback.MAX_TARGET][0]);
            this.tipTF.htmlText = LangConfig.getWord("80221",8);
         }
         else
         {
            str = LangConfig.getWord("80222",8);
            nextMoney = int(Data_lib.czfk[nextTarget][0]);
            needMoney = nextMoney - Model_RechargeFeedback.nowRecharge;
            this.tipTF.htmlText = LangConfig.reTxt(str,day,needMoney,nextMoney);
         }
         this.bar.go(Model_RechargeFeedback.nowRecharge,nextMoney);
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":832,
            "height":441
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Diamond01",[11,11,1,1],this,{
            "x":24,
            "y":40,
            "width":784,
            "height":391
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":764,
            "height":280
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Diamond02",[3,3,1,1],this,{
            "x":45,
            "y":208,
            "width":742,
            "height":112
         },Global.Img_Cdm);
         move = new Rectangle(0,0,832,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":798,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.tipTF = ComponentUtil.getTextField("",this,{
            "x":54,
            "y":337,
            "color":13420973,
            "size":12,
            "leading":10
         });
         this.tipTF.multiline = true;
      }
      
      private function creatGrid() : void
      {
         var item:FeedbackItem = null;
         this.itemVec = new Vector.<FeedbackItem>(this.LEN);
         var i:int = 0;
         while(i < 7)
         {
            item = new FeedbackItem();
            item.show(i + 1);
            addChild(item);
            ComponentUtil.setPropertie(item,{
               "x":44 + i * 107,
               "y":60
            });
            this.itemVec[i] = item;
            i++;
         }
         this.itemVec[0].select();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         Utils.print("充值回馈0");
         if(value)
         {
            Utils.print("充值回馈1");
            if(!Global.HuiKui_Imgsdm)
            {
               Utils.print("充值回馈2");
               regResource(Enum_RechargeFeedback.FEEDBACK_SOURCE,"HuiKui_Imgsdm");
               preFun();
            }
            else
            {
               Utils.print("充值回馈3");
               if(!this.titleBg)
               {
                  this.initUI2();
               }
               else
               {
                  Utils.print("充值回馈4");
                  RechargeFeedbackCGMessage.CG_OPEN_FEEDBACK();
               }
            }
         }
      }
      
      override protected function initUI2() : void
      {
         if(Boolean(this.bar))
         {
            return;
         }
         ComponentUtil.getBitmap("List_Back",this,{
            "x":55,
            "y":218
         },Global.HuiKui_Imgsdm);
         this.bar = new View_FeedBackBar();
         addChild(this.bar);
         ComponentUtil.setPropertie(this.bar,{
            "x":44,
            "y":387
         });
         this.itemList = new View_FeedBackList();
         addChild(this.itemList);
         ComponentUtil.setPropertie(this.itemList,{
            "x":55,
            "y":223
         });
         this.creatGrid();
         this.titleBg = ComponentUtil.getBitmap("Title_HuiKui",this,{
            "x":368,
            "y":5
         },Global.HuiKui_Imgsdm);
         ComponentUtil.getButton("","Button_Recharge",this,{
            "x":678,
            "y":379,
            "textColor":16184781,
            "callBack":function(event:MouseEvent):void
            {
               UIManager.yuanBaoXiang.visible = true;
            }
         },Global.HuiKui_Imgsdm);
         RechargeFeedbackCGMessage.CG_OPEN_FEEDBACK();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

