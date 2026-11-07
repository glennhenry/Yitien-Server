package com.yiTian.view.modules.actions.qifu
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QifuCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class QifuTip
   {
      
      private static var _instance:QifuTip;
      
      private var tipBtn:MainUIBtn;
      
      public function QifuTip()
      {
         super();
      }
      
      public static function get instance() : QifuTip
      {
         if(!_instance)
         {
            _instance = new QifuTip();
         }
         return _instance;
      }
      
      public function show() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.upHd);
         }
         else
         {
            this.showTip();
         }
      }
      
      private function showTip() : void
      {
      }
      
      private function upHd() : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            this.showTip();
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var pan:QifuPan = null;
         QifuCGMessage.CG_OPEN_QIFU_PAN();
         pan = Singleton.getInstance(QifuPan) as QifuPan;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
         {
            pan.visible = true;
         });
      }
      
      public function hide() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.tipBtn);
         }
      }
   }
}

