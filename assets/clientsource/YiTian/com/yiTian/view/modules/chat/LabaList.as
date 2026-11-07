package com.yiTian.view.modules.chat
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Sprite;
   
   public class LabaList extends Sprite
   {
      
      private var txt:String;
      
      public function LabaList(wid:int, hei:int)
      {
         super();
         visible = true;
         this.init(wid,hei);
      }
      
      public function init(wid:int, hei:int) : void
      {
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "width":wid,
            "height":hei
         },Global.Img_Cdm);
      }
      
      public function addItem(text:String, txt_position:int, data:Object = null, fun:Function = null) : void
      {
         var rtf:RichTF = null;
         rtf = RichTF.getRichTF();
         rtf.width = 255;
         rtf.x = txt_position;
         rtf.init(text,data,fun);
         addChild(rtf);
      }
   }
}

