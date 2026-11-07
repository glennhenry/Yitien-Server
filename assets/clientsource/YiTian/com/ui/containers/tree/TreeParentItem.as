package com.ui.containers.tree
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.DmManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TreeParentItem extends Sprite
   {
      
      private static var closeBMD:BitmapData;
      
      private static var openBMD:BitmapData;
      
      private var bitmap:Bitmap;
      
      private var word:MyTextField;
      
      private var _click:Function;
      
      private var _isExpand:Boolean;
      
      public function TreeParentItem(wid:int)
      {
         super();
         if(!closeBMD)
         {
            closeBMD = ComponentUtil.getBitmapData("Button_NumberUp_up",DmManager.Img_Cdm);
         }
         if(!openBMD)
         {
            openBMD = ComponentUtil.getBitmapData("Button_NumberDown_up",DmManager.Img_Cdm);
         }
         this.bitmap = new Bitmap();
         addChild(this.bitmap);
         this.word = ComponentUtil.getTextField("",this,{"color":ColorConstant.getColorInt(10)});
         this.word.width = wid - this.bitmap.width - 5;
         this.word.height = ITreeItem.itemHeight;
         this.word.x = 20;
         addChild(this.word);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
         buttonMode = true;
      }
      
      public function init(title:String) : void
      {
         this._isExpand = true;
         this.bitmap.bitmapData = openBMD;
         this.word.text = title;
      }
      
      public function mouseDown(e:MouseEvent) : void
      {
         this._isExpand = !this._isExpand;
         this.bitmap.bitmapData = this._isExpand ? openBMD : closeBMD;
         this._click();
      }
      
      public function set click(fun:Function) : void
      {
         this._click = fun;
      }
      
      public function dispose() : void
      {
         this.bitmap.bitmapData = null;
         this.word.text = "";
      }
   }
}

