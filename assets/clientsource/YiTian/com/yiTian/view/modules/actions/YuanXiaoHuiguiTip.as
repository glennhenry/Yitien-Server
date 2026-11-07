package com.yiTian.view.modules.actions
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ActionsCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class YuanXiaoHuiguiTip
   {
      
      public static var _instance:YuanXiaoHuiguiTip;
      
      private var tipBtn:MainUIBtn;
      
      private var eff:Effect;
      
      public function YuanXiaoHuiguiTip()
      {
         super();
      }
      
      public static function get instance() : YuanXiaoHuiguiTip
      {
         if(!_instance)
         {
            _instance = new YuanXiaoHuiguiTip();
         }
         return _instance;
      }
      
      public function show() : void
      {
         if(!this.tipBtn)
         {
            this.tipBtn = new MainUIBtn("resource/image/yuanXiaoHuiGui/yuanXiaoHuiGu.png");
            UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
            this.tipBtn.addEventListener(MouseEvent.CLICK,this.cliHd);
            ActionsCGMessage.CG_OPEN_BACKPLAYER_PAN();
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         this.removeEff();
         ActionsCGMessage.CG_OPEN_BACKPLAYER_PAN();
      }
      
      private function removeEff() : void
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
      }
      
      public function remove() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.tipBtn);
         }
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
      }
   }
}

