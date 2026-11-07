package com.yiTian.view.modules.gongcehuodong
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class View_GongCeHuoDongIcon
   {
      
      private static var _instance:View_GongCeHuoDongIcon;
      
      private var icon:MainUIBtn;
      
      private var eff:Effect;
      
      public function View_GongCeHuoDongIcon()
      {
         super();
      }
      
      public static function get instance() : View_GongCeHuoDongIcon
      {
         if(!_instance)
         {
            _instance = new View_GongCeHuoDongIcon();
         }
         return _instance;
      }
      
      public function addIcon() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.add);
         }
         else
         {
            this.add();
         }
      }
      
      private function add() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,this.add);
         this.icon = new MainUIBtn("resource/image/duanwu/duanwu.png");
         UIManager.mainUiBtnContainer.addBTN(this.icon);
         this.icon.addEventListener(MouseEvent.CLICK,this.onClick);
         this.eff = EffectManager.addEffect("35343",this.icon,1000,32,29,true);
      }
      
      protected function onClick(event:MouseEvent) : void
      {
         Global.delegate.dosomething(View_GongCeHuoDongPanel.instance,function():void
         {
            View_GongCeHuoDongPanel.instance.visible = !View_GongCeHuoDongPanel.instance.visible;
         });
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
      }
   }
}

