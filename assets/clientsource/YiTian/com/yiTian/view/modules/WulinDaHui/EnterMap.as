package com.yiTian.view.modules.WulinDaHui
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class EnterMap extends Panel
   {
      
      private var enterbtn:Button;
      
      private var paiHang:Button;
      
      private var cancel:Button;
      
      public function EnterMap()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":428,
            "height":464
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":380,
            "height":414
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":48,
            "width":360,
            "height":220
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":304,
            "width":360,
            "height":140
         },Global.Img_Cdm);
         move = new Rectangle(0,0,400,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":394,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.enterbtn = ComponentUtil.getButton(LangConfig.getWord("719",0),"Button_Two64",this,{
            "x":56,
            "y":274,
            "textColor":16773818
         },Global.Img_Cdm);
         this.paiHang = ComponentUtil.getButton(LangConfig.getWord("881",0),"Button_Two64",this,{
            "x":179,
            "y":274,
            "textColor":16773818
         },Global.Img_Cdm);
         this.cancel = ComponentUtil.getButton(LangConfig.getWord("5",0),"Button_Two64",this,{
            "x":302,
            "y":274,
            "textColor":16773818
         },Global.Img_Cdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.cancel.addEventListener(MouseEvent.CLICK,this.cliHandle);
         }
         else
         {
            this.cancel.removeEventListener(MouseEvent.CLICK,this.cliHandle);
         }
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

