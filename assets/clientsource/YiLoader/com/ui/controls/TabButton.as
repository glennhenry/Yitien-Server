package com.ui.controls
{
   import com.utils.ComponentUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class TabButton extends Sprite
   {
      
      private var _normalSkin:BitmapData;
      
      private var _selectedSkin:BitmapData;
      
      private var _overSkin:Bitmap;
      
      private var _curSkin:Bitmap;
      
      private var label:MyTextField;
      
      private var link:Sprite;
      
      private var isChoose:Boolean;
      
      private var _index:int;
      
      private var defaultColor:uint = 16773818;
      
      private var _normalColor:uint = this.defaultColor;
      
      private var _chooseColor:uint = this.defaultColor;
      
      public function TabButton(text:String, skin:String = "tab", dm:ApplicationDomain = null)
      {
         super();
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         this._curSkin = ComponentUtil.getBitmap("",this,null,dm);
         this._overSkin = ComponentUtil.getBitmap("",this,null,dm);
         this._normalSkin = ComponentUtil.getBitmapData(skin + "_up",dm);
         this._selectedSkin = ComponentUtil.getBitmapData(skin + "_down",dm);
         this._overSkin.bitmapData = ComponentUtil.getBitmapData(skin + "_over",dm);
         this._overSkin.blendMode = BlendMode.SCREEN;
         this._overSkin.visible = false;
         this._curSkin.bitmapData = this._normalSkin;
         this.label = ComponentUtil.getTextField("",this,{"color":this.defaultColor});
         this.text = text;
         addEventListener(MouseEvent.ROLL_OVER,this.ROLL_OVER);
         addEventListener(MouseEvent.ROLL_OUT,this.ROLL_OUT);
      }
      
      public function set binding(sprite:Sprite) : void
      {
         this.link = sprite;
      }
      
      public function get binding() : Sprite
      {
         return this.link;
      }
      
      public function set textColor(value:uint) : void
      {
         this._normalColor = value;
         this.label.textColor = value;
      }
      
      public function set chooseColor(value:uint) : void
      {
         this._chooseColor = value;
      }
      
      public function set text(value:String) : void
      {
         this.label.text = value;
         this.label.x = (this._curSkin.width - this.label.width) / 2;
         this.label.y = (this._curSkin.height - this.label.height) / 2;
      }
      
      public function set_htmlText(value:String) : void
      {
         this.label.htmlText = value;
         this.label.x = (this._curSkin.width - this.label.width) / 2;
         this.label.y = (this._curSkin.height - this.label.height) / 2;
      }
      
      public function get text() : String
      {
         return this.label.text;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(value:int) : void
      {
         this._index = value;
      }
      
      public function set choose(value:Boolean) : void
      {
         if(value)
         {
            this._curSkin.bitmapData = this._selectedSkin;
            this.label.textColor = this._chooseColor;
         }
         else
         {
            this._curSkin.bitmapData = this._normalSkin;
            this.label.textColor = this._normalColor;
         }
         if(Boolean(this.link))
         {
            this.link.visible = value;
         }
         this.isChoose = value;
         if(value)
         {
            this._overSkin.visible = false;
         }
      }
      
      public function get choose() : Boolean
      {
         return this.isChoose;
      }
      
      private function ROLL_OVER(e:MouseEvent) : void
      {
         if(this.isChoose)
         {
            return;
         }
         this._overSkin.visible = true;
      }
      
      private function ROLL_OUT(e:MouseEvent) : void
      {
         if(this.isChoose)
         {
            return;
         }
         this._overSkin.visible = false;
      }
   }
}

