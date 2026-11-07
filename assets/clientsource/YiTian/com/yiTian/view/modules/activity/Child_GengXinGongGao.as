package com.yiTian.view.modules.activity
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.manager.LangConfig;
   import flash.display.Sprite;
   
   public class Child_GengXinGongGao extends Sprite
   {
      
      private var canvas:Canvas;
      
      private var queDingBtn:Button;
      
      private var arr:Array;
      
      private var tfy:Number = 0;
      
      public function Child_GengXinGongGao()
      {
         var tf:MyTextField = null;
         super();
         this.canvas = new Canvas(550,332);
         this.canvas.scrollAutoType = ScrollAutoType.TO_TOP;
         this.canvas.y = 14;
         addChild(this.canvas);
         this.arr = LangConfig.getWord("1173",0).split("_");
         var i:int = 0;
         while(i < this.arr.length)
         {
            tf = ComponentUtil.getTextField("",this,{
               "x":0,
               "y":this.tfy,
               "color":16743936,
               "size":12,
               "leading":5
            });
            tf.multiline = true;
            tf.htmlText = this.arr[i];
            this.canvas.addChild(tf);
            this.tfy = tf.y + tf.height + 12;
            i++;
         }
         this.canvas.align();
      }
   }
}

