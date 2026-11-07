package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   
   public class View_ColorPanel extends Panel123
   {
      
      protected var border:ScaleBitmap;
      
      private var colorArr:Array = [];
      
      public function View_ColorPanel()
      {
         super();
      }
      
      public static function get instance() : View_ColorPanel
      {
         return Singleton.getInstance(View_ColorPanel);
      }
      
      override protected function initUI2() : void
      {
         this.addBorder();
         this.colorArr = [Util.qhtz1,Util.qhtz2,Util.qhtz3,Util.red,Util.yellow];
         this.createItem();
         this.updateBorder();
      }
      
      private function createItem() : void
      {
         var item:IconColorItem = null;
         var i:int = 0;
         i = 0;
         while(i < 5)
         {
            item = new IconColorItem(i);
            item.updateColor(i,this.colorArr[i]);
            addChild(item);
            item.x = 10 + i % 3 * 50;
            item.y = 10 + int(i / 3) * 50;
            i++;
         }
      }
      
      public function updateBorder() : void
      {
         this.border.width = 165;
         this.border.height = 110;
      }
      
      final protected function addBorder(str:String = "Back_Floating") : void
      {
         if(!this.border)
         {
            this.border = ComponentUtil.getScaleBitmap(str,[8,9,4,2],this,{
               "x":0,
               "y":0,
               "width":87,
               "height":95
            },Global.Img_Cdm);
            addChild(this.border);
         }
      }
      
      final protected function removeBorder() : void
      {
         if(Boolean(this.border))
         {
            removeChild(this.border);
            this.border = null;
         }
      }
      
      public function show() : void
      {
         visible = true;
         if(!this.border)
         {
            this.initUI2();
         }
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
      }
   }
}

