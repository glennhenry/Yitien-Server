package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class View_invideBang extends Panel
   {
      
      private static var isFirstOpen:Boolean = true;
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      private var Informat_text:MyTextField;
      
      private var Inter_text:MyTextField;
      
      public var partyId:Number;
      
      public function View_invideBang()
      {
         super();
      }
      
      public function get DESCRIBE() : String
      {
         return LangConfig.getWord("29186",2);
      }
      
      override protected function initStaticView() : void
      {
         var back1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":298,
            "height":180
         },Global.Img_Cdm);
         var back2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":250,
            "height":130
         },Global.Img_Cdm);
         var back3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":86,
            "y":88,
            "width":130,
            "height":22
         },Global.Img_Cdm);
         move = new Rectangle(0,0,247,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":260,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":60,
            "y":130,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":168,
            "y":130,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Informat_text = ComponentUtil.getTextField(LangConfig.getWord("29186",2),this,{
            "x":95,
            "y":58,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.Inter_text = ComponentUtil.getTextField(this.DESCRIBE,this,{
            "x":96,
            "y":89,
            "color":14662240,
            "size":12,
            "realWidth":112,
            "leading":0
         });
         this.Inter_text.type = TextFieldType.INPUT;
         this.Inter_text.align = TextFormatAlign.CENTER;
         this.Inter_text.addEventListener(FocusEvent.FOCUS_IN,this.foInHandle);
         this.Inter_text.addEventListener(FocusEvent.FOCUS_OUT,this.foOutHandle);
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.okHandle);
         this.Button_Cancel.addEventListener(MouseEvent.CLICK,this.cloHandle);
         super.CloseButton.addEventListener(MouseEvent.CLICK,this.cloHandle);
      }
      
      private function okHandle(e:MouseEvent) : void
      {
         if(this.Inter_text.text == "")
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29185",2));
            return;
         }
         var heroName:String = this.Inter_text.text;
         BangCGMessage.CG_BANG_INVIDE_M(this.partyId,heroName);
      }
      
      private function foInHandle(e:FocusEvent) : void
      {
         if(this.Inter_text.text == this.DESCRIBE)
         {
            this.Inter_text.text = "";
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.Inter_text.text = this.DESCRIBE;
         }
         else if(isFirstOpen)
         {
            isFirstOpen = false;
            ComponentUtil.getBitmap("Title_BangInvite",this,{
               "x":69,
               "y":5
            },Global.Bang_Imgsdm);
         }
      }
      
      private function foOutHandle(e:FocusEvent) : void
      {
         if(this.Inter_text.text == "")
         {
            this.Inter_text.text = this.DESCRIBE;
         }
      }
      
      private function cloHandle(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function mHandle(e:MouseEvent) : void
      {
         var my_tf:MyTextField = e.target as MyTextField;
         if(my_tf.text == LangConfig.getWord("50037",5))
         {
            my_tf.text = "";
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

