package com.event
{
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class TextField_h extends TextField
   {
      
      private static var s_textFormat:TextFormat;
      
      private static var s_defaultTextFormat:TextFormat = new TextFormat("Tahoma",12,16777215);
      
      private static var s_arr:Array = [new GlowFilter(0,1,2,2,10)];
      
      public function TextField_h($type:String = "dynamic")
      {
         super();
         type = $type;
         if(type == TextFieldType.DYNAMIC)
         {
            mouseEnabled = false;
         }
         autoSize = TextFieldAutoSize.LEFT;
         filters = s_arr;
         defaultTextFormat = s_defaultTextFormat;
      }
      
      public function set_TextFormat_leading(leading:int = 4) : void
      {
         s_textFormat = new TextFormat();
         s_textFormat.leading = leading;
         defaultTextFormat = s_textFormat;
      }
      
      public function set_TextFormat_bold(value:Boolean = true) : void
      {
         s_textFormat = new TextFormat();
         s_textFormat.bold = value;
         defaultTextFormat = s_textFormat;
      }
      
      override public function get width() : Number
      {
         return super.width;
      }
      
      override public function get height() : Number
      {
         return super.height;
      }
      
      public function set size(value:int) : void
      {
         s_defaultTextFormat.size = value;
         defaultTextFormat = s_defaultTextFormat;
      }
   }
}

