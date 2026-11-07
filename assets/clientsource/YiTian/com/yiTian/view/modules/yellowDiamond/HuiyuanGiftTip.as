package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class HuiyuanGiftTip
   {
      
      private static var _instance:HuiyuanGiftTip;
      
      public static var huiYuanSign:Boolean = true;
      
      private var tipBtn:MainUIBtn;
      
      public function HuiyuanGiftTip()
      {
         super();
      }
      
      public static function get instance() : HuiyuanGiftTip
      {
         if(!_instance)
         {
            _instance = new HuiyuanGiftTip();
         }
         return _instance;
      }
      
      public function show() : void
      {
         if(Global.pf != Enum_SPStr.GUANWANG && !Enum_SPStr.isUnion(Global.pf))
         {
            return;
         }
         if(!this.tipBtn)
         {
            this.tipBtn = new MainUIBtn("resource/image/Diamond/huiYuan.png");
            this.tipBtn.addEventListener(MouseEvent.CLICK,this.cliHd);
         }
         UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var pan:View_qqHuiyuan = View_qqHuiyuan.instance;
         pan.init();
      }
      
      public function remove() : void
      {
         if(Boolean(this.tipBtn) && UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.tipBtn);
         }
      }
   }
}

