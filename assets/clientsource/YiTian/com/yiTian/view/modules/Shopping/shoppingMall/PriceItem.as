package com.yiTian.view.modules.Shopping.shoppingMall
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import flash.display.Sprite;
   
   public class PriceItem extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var tfLabel:MyTextField;
      
      private var tfInfo:MyTextField;
      
      public function PriceItem()
      {
         super();
         this.tfLabel = ComponentUtil.getTextField("",this,{"color":327424});
         this.tfInfo = ComponentUtil.getTextField("",this,{"color":16383744});
      }
      
      public static function get instance() : PriceItem
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new PriceItem();
      }
      
      public function updata(data1:String, data2:String) : void
      {
         this.tfLabel.htmlText = data1;
         this.tfInfo.htmlText = data2;
         this.tfInfo.x = this.tfLabel.x + this.tfLabel.textWidth + 3;
      }
      
      public function dispose() : void
      {
         this.tfLabel.text = "";
         this.tfInfo.text = "";
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         pool.push(this);
      }
   }
}

