package com.yiTian.view.modules.activity
{
   import com.ui.controls.AbstractFactoryBase;
   import com.ui.controls.TappButton;
   import com.utils.Util;
   
   public class DefaultTappBtnFac extends AbstractFactoryBase
   {
      
      public function DefaultTappBtnFac()
      {
         super();
      }
      
      override public function createEntityObj(info:*) : *
      {
         var entityTabbtn:TappButton = new TappButton(info.label,info.style,info.dm);
         if(Boolean(info.disable))
         {
            entityTabbtn.filters = Util.disabled;
         }
         return entityTabbtn;
      }
   }
}

