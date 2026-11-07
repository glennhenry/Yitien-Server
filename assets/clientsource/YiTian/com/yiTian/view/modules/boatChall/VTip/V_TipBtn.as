package com.yiTian.view.modules.boatChall.VTip
{
   import com.utils.Util;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class V_TipBtn extends MainUIBtn
   {
      
      public function V_TipBtn(url:String)
      {
         super(url);
         addEventListener(MouseEvent.CLICK,this.clickEvent);
         addEventListener(MouseEvent.MOUSE_OVER,this.btnOnMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.btnOnMouseOut);
      }
      
      public function show(_parent:* = null) : void
      {
         _parent.addChild(this);
      }
      
      public function hide(_parent:* = null) : void
      {
         _parent.removeChild(this);
      }
      
      protected function clickEvent(e:* = null) : void
      {
      }
      
      protected function btnOnMouseOver(e:* = null) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorWhite2;
      }
      
      protected function btnOnMouseOut(e:* = null) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorNomal;
      }
   }
}

