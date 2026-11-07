package com.yiTian.view.modules.canggao
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class CangGaoBtn
   {
      
      private static var _instance:CangGaoBtn;
      
      private var Btn:MainUIBtn;
      
      private var _eff:Effect;
      
      public function CangGaoBtn()
      {
         super();
         this.init();
      }
      
      public static function get instance() : CangGaoBtn
      {
         if(!_instance)
         {
            _instance = new CangGaoBtn();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.Btn = new MainUIBtn("resource/image/NianGao/niangao.png");
      }
      
      public function show() : void
      {
      }
      
      public function BtnClick(e:MouseEvent) : void
      {
         this.eff(false);
         if(UIManager.mainUiBtnContainer.hasBTN(this.Btn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.Btn);
         }
         UIManager.canggao.show();
         Global.delegate.dosomething(CangGaoPanel.instance,CangGaoPanel.instance.show);
      }
      
      public function eff(v:Boolean) : void
      {
         if(v && !this._eff)
         {
            this._eff = EffectManager.addEffect("35343",this.Btn,1000,32,29,true);
         }
         else if(!v && Boolean(this._eff))
         {
            EffectManager.removeEffect(this._eff);
         }
      }
   }
}

