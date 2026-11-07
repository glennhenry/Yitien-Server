package com.yiTian.view.modules.broadcast
{
   import com.ui.containers.list.IListItem;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.DisplayObject;
   
   public class CheckAllListItem extends IListItem
   {
      
      private var txt:MyTextField = ComponentUtil.getTextField("",this,{"color":14662240});
      
      private var line:DisplayObject = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":10,
         "y":19,
         "width":236,
         "height":2
      },Global.Img_Cdm);
      
      public function CheckAllListItem()
      {
         this.txt.wordWrap = true;
         this.txt.realWidth = 225;
         this.buttonMode = false;
         super();
      }
      
      override public function set data(value:Object) : void
      {
         super.data = value;
         this.txt.htmlText = value.htmlText;
         if(Boolean(this.txt.text))
         {
            this.line.y = this.txt.textHeight + 5;
         }
      }
      
      override public function get height() : Number
      {
         return this.line.y + this.line.height;
      }
   }
}

