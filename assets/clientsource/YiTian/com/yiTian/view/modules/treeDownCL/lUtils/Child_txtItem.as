package com.yiTian.view.modules.treeDownCL.lUtils
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   
   public class Child_txtItem extends MoveRoundPan
   {
      
      private static var pool:Array = [];
      
      private var tf:MyTextField;
      
      public function Child_txtItem()
      {
         super();
      }
      
      public static function get instance() : Child_txtItem
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new Child_txtItem();
      }
      
      override public function update(data:Object = null) : void
      {
         if(!this.tf)
         {
            this.tf = ComponentUtil.getTextField("",this,{
               "y":30,
               "bold":true,
               "realWidth":290,
               "multiline":true,
               "wordWrap":true,
               "filters":[],
               "color":0,
               "leading":5
            });
         }
         this.tf.htmlText = data.toString();
      }
      
      override public function dispose() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         pool.push(this);
      }
   }
}

