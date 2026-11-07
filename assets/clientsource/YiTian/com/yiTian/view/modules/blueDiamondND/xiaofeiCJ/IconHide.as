package com.yiTian.view.modules.blueDiamondND.xiaofeiCJ
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.geom.Rectangle;
   
   public class IconHide extends Panel123
   {
      
      private static var isInit:Boolean = false;
      
      public function IconHide()
      {
         super();
      }
      
      public static function get instance() : IconHide
      {
         return Singleton.getInstance(IconHide);
      }
      
      override protected function initUI2() : void
      {
         var btn:Button = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":458,
            "height":308
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":410,
            "height":259
         },Global.Img_Cdm);
         move = new Rectangle(0,0,457,38);
         btn = ComponentUtil.getButton("确定","Button_TwoBule91",this,{
            "x":184,
            "y":265,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":34,
            "y":50,
            "width":390,
            "height":211
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_Img",this,{
            "x":39,
            "y":55
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":426,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         btn.callBack = CloseButton.callBack = function():void
         {
            visible = false;
         };
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":149,
            "y":5
         },Global.Img_Cdm);
         isInit = true;
      }
      
      public function show() : void
      {
         if(!isInit)
         {
            this.initUI2();
         }
         if(!visible)
         {
            visible = true;
         }
         pop();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 380) / 2;
         y = (Global.stage.stageHeight - 200) / 2;
      }
   }
}

