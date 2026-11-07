package com.yiTian.view.modules.guide
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class View_Arrow extends Sprite
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const CENTER:String = "center";
      
      private var bg:DisplayObject;
      
      private var tf:MyTextField;
      
      private var _direct:String;
      
      public function View_Arrow(direct:String)
      {
         super();
         this._direct = direct;
         if(direct == LEFT)
         {
            this.bg = ComponentUtil.getDisplayObject("XSTiShi_Left",this);
            this.tf = ComponentUtil.getTextField("",this,{
               "realWidth":100,
               "wordWrap":true,
               "x":4,
               "y":4
            });
         }
         else if(direct != RIGHT)
         {
            if(direct == CENTER)
            {
               this.bg = ComponentUtil.getDisplayObject("XSTiShi_Center",this);
               this.tf = ComponentUtil.getTextField("",this,{
                  "realWidth":100,
                  "wordWrap":true,
                  "x":4,
                  "y":4
               });
            }
         }
      }
      
      public function show(text:String, bindSpr:Sprite, x:int, y:int) : void
      {
         this.tf.htmlText = text;
         if(this._direct == LEFT)
         {
            this.bg.width = this.tf.textWidth + 10;
            this.bg.height = this.tf.textHeight + 32;
         }
         else if(this._direct == CENTER)
         {
            this.bg.width = this.tf.textWidth + 45;
            this.bg.height = this.tf.textHeight + 10;
         }
         bindSpr.addChild(this);
         this.x = x;
         this.y = y;
      }
      
      public function hide() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
      }
      
      public function dispose() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
      }
   }
}

