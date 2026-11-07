package com.ui.controls
{
   import com.utils.Util;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class MyTextField extends TextField
   {
      
      private static var pool:Array = [];
      
      private var format:TextFormat = new TextFormat("Tahoma",12,16777215);
      
      private var _realWidth:int;
      
      private var _realHeight:int;
      
      public function MyTextField()
      {
         super();
         filters = Util.glow000000;
         this.defaultTextFormat = this.format;
      }
      
      public static function getTF() : MyTextField
      {
         var textField:MyTextField = null;
         if(Boolean(pool.length))
         {
            textField = pool.pop();
         }
         else
         {
            textField = new MyTextField();
         }
         return textField;
      }
      
      override public function set type(value:String) : void
      {
         if(value == TextFieldType.DYNAMIC)
         {
            selectable = false;
            mouseEnabled = false;
         }
         else
         {
            selectable = true;
            mouseEnabled = true;
         }
         super.type = value;
      }
      
      public function set realWidth(value:int) : void
      {
         autoSize = TextFieldAutoSize.NONE;
         super.width = value;
         this._realWidth = value;
      }
      
      public function set realHeight(value:int) : void
      {
         autoSize = TextFieldAutoSize.NONE;
         super.height = value;
         this._realHeight = value;
      }
      
      override public function set text(str:String) : void
      {
         super.text = str;
         if(this._realWidth != 0 && this._realHeight == 0)
         {
            height = textHeight + 4;
         }
      }
      
      override public function set htmlText(value:String) : void
      {
         super.htmlText = value;
         if(this._realWidth != 0 && this._realHeight == 0)
         {
            height = textHeight + 4;
         }
      }
      
      override public function set defaultTextFormat(format:TextFormat) : void
      {
         super.defaultTextFormat = format;
         this.format = format;
         this.setTextFormat(format);
      }
      
      public function set align(value:String) : void
      {
         this.format.align = value;
         this.defaultTextFormat = this.format;
      }
      
      public function set size(value:int) : void
      {
         this.format.size = value;
         this.defaultTextFormat = this.format;
      }
      
      public function set leading(value:int) : void
      {
         this.format.leading = value;
         this.defaultTextFormat = this.format;
      }
      
      public function set color(value:int) : void
      {
         this.format.color = value;
         this.defaultTextFormat = this.format;
      }
      
      public function set bold(value:Boolean) : void
      {
         this.format.bold = value;
         this.defaultTextFormat = this.format;
      }
      
      public function set underline(value:Boolean) : void
      {
         this.format.underline = value;
         this.defaultTextFormat = this.format;
      }
      
      public function set font(value:String) : void
      {
         this.format.font = value;
         this.defaultTextFormat = this.format;
      }
      
      public function dispose() : void
      {
         this._realWidth = 0;
         this._realHeight = 0;
         x = 0;
         y = 0;
         autoSize = TextFieldAutoSize.LEFT;
         this.type = TextFieldType.DYNAMIC;
         filters = Util.glow000000;
         wordWrap = false;
         multiline = false;
         embedFonts = false;
         this.text = "";
         this.color = 0;
         this.defaultTextFormat = new TextFormat("Tahoma",12,16777215);
         pool.push(this);
      }
      
      public function link(firCol:String = "#04ff00", secCol:String = "#33CCFF") : void
      {
         var style:StyleSheet = new StyleSheet();
         var link:Object = new Object();
         link.textDecoration = "underline";
         link.color = firCol;
         var hover:Object = new Object();
         hover.textDecoration = "none";
         hover.color = secCol;
         var active:Object = new Object();
         active.textDecoration = "underline";
         active.color = firCol;
         style.setStyle("a:link",active);
         style.setStyle("a:hover",hover);
         style.setStyle("a:active",active);
         super.styleSheet = style;
      }
   }
}

