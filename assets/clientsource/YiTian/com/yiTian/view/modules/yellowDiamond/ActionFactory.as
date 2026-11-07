package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.txActivity.View_chaozhifanli;
   
   public class ActionFactory
   {
      
      public function ActionFactory()
      {
         super();
      }
      
      public static function doSomething(key:String) : void
      {
         switch(key)
         {
            case "fanliIconCtrl":
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_chaozhifanli.instance,function():void
               {
                  View_chaozhifanli.instance.visible = !View_chaozhifanli.instance.visible;
               });
         }
      }
   }
}

