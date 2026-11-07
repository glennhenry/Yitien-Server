package com.yiTian.view.modules.friends
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class View_ItemParent extends Sprite
   {
      
      private static const maskX:Number = 120;
      
      private static const maskY:Number = 20;
      
      private var icon:Bitmap;
      
      private var tf_label:MyTextField;
      
      private var _isEnable:Boolean;
      
      private var mouseArea:Sprite;
      
      private var bmd_close:BitmapData;
      
      private var bmd_open:BitmapData;
      
      public function View_ItemParent()
      {
         super();
         this.mouseArea = new Sprite();
         this.mouseArea.buttonMode = true;
         this.tf_label = ComponentUtil.getTextField("",this,{
            "x":25,
            "height":20
         });
         this.tf_label.mouseEnabled = false;
         this.bmd_close = ComponentUtil.getBitmapData("Tree_Open_up",Global.Img_Cdm);
         this.bmd_open = ComponentUtil.getBitmapData("Tree_Close_up",Global.Img_Cdm);
         this.icon = new Bitmap();
         this.icon.x = 1;
         this.icon.y = 2;
         addChild(this.icon);
      }
      
      public function enable() : void
      {
         this._isEnable = true;
         this.icon.bitmapData = this.bmd_close;
      }
      
      public function disable() : void
      {
         this._isEnable = false;
         this.icon.bitmapData = this.bmd_open;
      }
      
      public function get isEnabel() : Boolean
      {
         return this._isEnable;
      }
      
      public function set label(string:String) : void
      {
         this.tf_label.htmlText = HtmlUtil.font(string,ColorConstant.getColorStr(ColorConstant.WHITE),12);
      }
   }
}

