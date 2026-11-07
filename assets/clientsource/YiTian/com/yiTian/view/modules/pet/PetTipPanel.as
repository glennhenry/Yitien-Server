package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class PetTipPanel extends Panel
   {
      
      private var tipInfo:MyTextField;
      
      private var Button_OK:Button;
      
      private var firstTime:Boolean = true;
      
      public function PetTipPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":318,
            "height":187
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":29,
            "y":45,
            "width":260,
            "height":130
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,40);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":284,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("10125",1),"Button_Orange",this,{
            "x":120,
            "y":125,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_OK.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            CloseButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         });
         this.tipInfo = ComponentUtil.getTextField(LangConfig.getWord("10126",1),this,{
            "x":43,
            "y":71,
            "color":16184781,
            "size":12,
            "leading":0
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.update();
            if(this.firstTime)
            {
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Title_Sawy",new Bitmap(),{
                  "x":79,
                  "y":5
               },this);
               this.firstTime = false;
            }
         }
      }
      
      private function update() : void
      {
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

