package com.yiTian.view.modules.shenMiShop
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SMSCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_mutilTips extends Panel
   {
      
      private static var isFirstOpen:Boolean = true;
      
      private var Button_Flash:Button;
      
      private var Number_text:MyTextField;
      
      private var Cost_text:MyTextField;
      
      private var input_num:int;
      
      private var total_cost:int;
      
      public function View_mutilTips()
      {
         super();
         bindParent = GameScene.popupLayer;
      }
      
      override protected function initStaticView() : void
      {
         GameScene.popupLayer.addChild(this);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":343,
            "height":195
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":295,
            "height":145
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":192,
            "y":59,
            "width":60,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60280",6),this,{
            "x":80,
            "y":150,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60281",6),this,{
            "x":105,
            "y":60,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60282",6),this,{
            "x":105,
            "y":85,
            "color":11904647,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,262,38);
         this.Button_Flash = ComponentUtil.getButton(LangConfig.getWord("19",0),"Button_Orange",this,{
            "x":135,
            "y":115,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":309,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Number_text = ComponentUtil.getTextField("1",this,{
            "x":189,
            "y":60,
            "color":14662240,
            "realWidth":62,
            "realHeight":18
         });
         this.Number_text.align = TextAlign.CENTER;
         this.Number_text.type = TextFieldType.INPUT;
         this.Number_text.maxChars = 4;
         this.Number_text.restrict = ".0-9";
         this.Number_text.addEventListener(Event.CHANGE,this.changedHandle);
         this.Cost_text = ComponentUtil.getTextField(LangConfig.getWord("20",0),this,{
            "x":194,
            "y":85,
            "color":14662240
         });
         this.Cost_text.textColor = 16383744;
         this.Button_Flash.callBack = this.freHandle;
      }
      
      private function changedHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(int(tf.text) < 1)
         {
            tf.text = "1";
         }
         else if(int(tf.text) > 999)
         {
            tf.text = "999";
         }
         tf.setSelection(tf.text.length,tf.text.length);
         this.input_num = int(tf.text);
         this.change_cost(this.input_num);
      }
      
      private function change_cost(_num:int) : void
      {
         this.Cost_text.text = String(_num * 10) + LangConfig.getWord("21",0);
         this.total_cost = _num * 10;
      }
      
      private function freHandle(e:MouseEvent) : void
      {
         if(this.total_cost > GameUnitManager.hero.money)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22",0));
            return;
         }
         SMSCGMessage.CG_SMS_MUL_REFRESH(int(this.Number_text.text));
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.input_num = 20;
            this.total_cost = 200;
            this.Cost_text.text = LangConfig.getWord("23",0);
            this.Number_text.text = "20";
            if(isFirstOpen)
            {
               isFirstOpen = false;
               ComponentUtil.getBitmap("Title_Fresh",this,{
                  "x":92,
                  "y":5
               },Global.SMShop_Imgsdm);
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

