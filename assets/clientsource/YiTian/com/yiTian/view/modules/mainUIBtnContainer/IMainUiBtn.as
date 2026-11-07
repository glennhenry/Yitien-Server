package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class IMainUiBtn extends Sprite
   {
      
      public var bmUrl:String;
      
      private var tipBm:Bitmap;
      
      private var tipTF:MyTextField;
      
      public function IMainUiBtn()
      {
         super();
      }
      
      public function showTime(value:int) : void
      {
         if(value < 1)
         {
            if(Boolean(this.tipBm))
            {
               this.tipBm.visible = false;
               this.tipTF.visible = false;
            }
         }
         else
         {
            if(!this.tipBm)
            {
               this.tipBm = ComponentUtil.getBitmap("cishu_tis",this,{
                  "x":2,
                  "y":2
               },Global.New_Imgsdm);
               this.tipTF = ComponentUtil.getTextField("",this,{
                  "size":11,
                  "color":16771584,
                  "x":this.tipBm.x + this.tipBm.width / 2 - 2.5,
                  "y":5
               },"center");
            }
            this.tipBm.visible = true;
            this.tipTF.visible = true;
            this.tipTF.text = value + "";
         }
      }
   }
}

