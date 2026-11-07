package com.yiTian.view.modules.broadcast
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import flash.display.Sprite;
   
   public class RollItem extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var txt:MyTextField;
      
      public function RollItem()
      {
         super();
      }
      
      public static function getItem() : RollItem
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new RollItem();
      }
      
      public function set htmlText(value:String) : void
      {
         if(!this.txt)
         {
            this.txt = ComponentUtil.getTextField("",this);
            this.txt.wordWrap = true;
            this.txt.realWidth = 170;
         }
         this.txt.htmlText = value;
      }
      
      override public function get height() : Number
      {
         return this.txt.textHeight;
      }
      
      public function dispose() : void
      {
         if(Boolean(this.txt))
         {
            removeChild(this.txt);
            this.txt.dispose();
            this.txt = null;
         }
         y = 0;
         pool.push(this);
      }
   }
}

