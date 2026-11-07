package com.yiTian.view.modules.actions.newAct_0508
{
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class IconTip
   {
      
      public function IconTip()
      {
         super();
      }
      
      public static function showTip() : void
      {
         var b:MainUIBtn = null;
         if(GameUnitManager.hero.level >= 30)
         {
            b = new MainUIBtn("resource/image/newAddIcon/newAddIcon.png");
            UIManager.mainUiBtnContainer.addBTN(b);
            b.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               navigateToURL(new URLRequest("http://yi.qq.com/act/20130424gift/index.htm"),"_blank");
            });
         }
      }
   }
}

