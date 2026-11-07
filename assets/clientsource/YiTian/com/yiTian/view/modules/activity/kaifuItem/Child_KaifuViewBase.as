package com.yiTian.view.modules.activity.kaifuItem
{
   import com.yiTian.Global;
   import com.yiTian.view.UIBase123;
   
   public class Child_KaifuViewBase extends UIBase123
   {
      
      public function Child_KaifuViewBase()
      {
         super();
         bindParent = null;
      }
      
      public function show() : void
      {
         Global.delegate.dosomething(this,function():void
         {
            visible = true;
         });
      }
   }
}

