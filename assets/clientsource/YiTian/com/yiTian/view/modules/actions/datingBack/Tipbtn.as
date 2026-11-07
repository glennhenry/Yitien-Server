package com.yiTian.view.modules.actions.datingBack
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class Tipbtn
   {
      
      private static var tipB:MainUIBtn;
      
      private static var _type:int;
      
      private static var _day:int;
      
      private static var isShow:Boolean = false;
      
      public function Tipbtn()
      {
         super();
      }
      
      public static function show(type:int, day:int) : void
      {
         _type = type;
         _day = day;
         if(!tipB)
         {
            tipB = new MainUIBtn("resource/image/qqGameBack/Icon_YTHG.png");
            UIManager.mainUiBtnContainer.addBTN(tipB);
            tipB.addEventListener(MouseEvent.CLICK,handle);
         }
      }
      
      private static function handle(e:MouseEvent) : void
      {
         isShow = !isShow;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(QQGameBackPan.instance,function():void
         {
            QQGameBackPan.instance.show(_type,_day);
         });
      }
      
      public static function hide() : void
      {
         if(Boolean(tipB))
         {
            UIManager.mainUiBtnContainer.removeBTN(tipB);
         }
         tipB = null;
      }
   }
}

