package com.yiTian.view.modules.tip.tips
{
   import flash.display.DisplayObject;
   
   public class View_displayObjectTip extends View_tip
   {
      
      public var hborder:int = 8;
      
      public var vborder:int = 8;
      
      public var tar:DisplayObject;
      
      public function View_displayObjectTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         if(this.tar != null)
         {
            if(this.tar != obj)
            {
               if(contains(obj as DisplayObject))
               {
                  removeChild(this.tar);
               }
            }
         }
         if(this.tar != obj)
         {
            addChild(obj as DisplayObject);
         }
         this.tar = obj as DisplayObject;
         this.tar.x = this.hborder;
         this.tar.y = this.vborder;
         border.width = this.tar.width + this.hborder * 2;
         border.height = this.tar.height + this.vborder * 2;
      }
   }
}

