package com.yiTian.view.modules.broadcast
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   
   public class TFPool
   {
      
      private static var _instance:TFPool;
      
      private var vec:Vector.<MyTextField>;
      
      public function TFPool()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singlon error");
         }
         this.init();
         _instance = this;
      }
      
      public static function get instance() : TFPool
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.vec = new Vector.<MyTextField>();
      }
      
      public function getTF() : MyTextField
      {
         var tf:MyTextField = null;
         if(this.vec.length > 0)
         {
            tf = this.vec.pop();
         }
         else
         {
            tf = ComponentUtil.getTextField("");
         }
         return tf;
      }
      
      public function addTF(item:MyTextField) : void
      {
         item.bold = false;
         item.text = "";
         item.alpha = 1;
         item.color = 0;
         var _temp_1:* = item;
         item.y = 0;
         _temp_1.x = 0;
         this.vec.push(item);
      }
   }
}

