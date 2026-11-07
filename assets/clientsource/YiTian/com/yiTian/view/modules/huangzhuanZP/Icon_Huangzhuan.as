package com.yiTian.view.modules.huangzhuanZP
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HuangzhuanZPCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class Icon_Huangzhuan
   {
      
      private static var _instance:Icon_Huangzhuan;
      
      private var btn:MainUIBtn;
      
      public function Icon_Huangzhuan()
      {
         super();
      }
      
      public static function get instance() : Icon_Huangzhuan
      {
         if(!_instance)
         {
            _instance = new Icon_Huangzhuan();
         }
         return _instance;
      }
      
      public function init(reslut:int) : void
      {
         if(reslut == 0)
         {
            if(Boolean(this.btn))
            {
               UIManager.mainUiBtnContainer.removeBTN(this.btn);
            }
            return;
         }
         this.btn = new MainUIBtn("resource/image/mainIcon/Icon_HZZP.png");
         UIManager.mainUiBtnContainer.addBTN(this.btn);
         this.btn.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(event:MouseEvent) : void
      {
         HuangzhuanZPCGMessage.CG_HZZP_OPENWIN();
      }
   }
}

