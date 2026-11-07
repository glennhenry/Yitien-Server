package com.yiTian.view.modules.actions.liushiBack
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.LiuShiBackCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class LiushiBackBtn
   {
      
      private static var iconBtn:MainUIBtn;
      
      public function LiushiBackBtn()
      {
         super();
      }
      
      public static function showIcon() : void
      {
         if(!iconBtn)
         {
            iconBtn = new MainUIBtn("resource/image/xiazhehuigui/xiazhehuigui.png");
            UIManager.mainUiBtnContainer.addBTN(iconBtn);
            iconBtn.addEventListener(MouseEvent.CLICK,onClick);
         }
      }
      
      private static function onClick(e:MouseEvent) : void
      {
         LiuShiBackCGMessage.CG_LIUSHIBACK_OPEN();
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(LiushiBackPan.instance,function():void
         {
            LiushiBackPan.instance.visible = !LiushiBackPan.instance.visible;
         });
      }
      
      public static function remove() : void
      {
         if(Boolean(iconBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(iconBtn);
         }
         iconBtn = null;
      }
   }
}

