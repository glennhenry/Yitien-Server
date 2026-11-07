package com.yiTian.view.modules.actions.qifu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import flash.display.Sprite;
   
   public class TxtGongGaoItem extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var tf:MyTextField;
      
      public function TxtGongGaoItem()
      {
         super();
         this.tf = ComponentUtil.getTextField("",this,{
            "realWidth":206,
            "multiline":true,
            "wordWrap":true,
            "size":13
         });
      }
      
      public static function get instance() : TxtGongGaoItem
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new TxtGongGaoItem();
      }
      
      public function update(str:String) : void
      {
         this.tf.htmlText = str;
      }
      
      override public function get height() : Number
      {
         return this.tf.textHeight + 4;
      }
      
      public function dispose() : void
      {
         this.tf.text = "";
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         pool.push(this);
      }
   }
}

