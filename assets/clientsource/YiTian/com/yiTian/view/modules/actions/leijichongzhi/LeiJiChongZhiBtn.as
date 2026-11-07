package com.yiTian.view.modules.actions.leijichongzhi
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class LeiJiChongZhiBtn
   {
      
      private static var iconBtn:MainUIBtn;
      
      private static var eff:Effect;
      
      public function LeiJiChongZhiBtn()
      {
         super();
      }
      
      public static function showIcon() : void
      {
         if(!iconBtn)
         {
            iconBtn = new MainUIBtn("resource/image/leijichongzhi/leijichongzhi.png");
            UIManager.mainUiBtnContainer.addBTN(iconBtn);
            iconBtn.addEventListener(MouseEvent.CLICK,onClick);
         }
      }
      
      private static function onClick(e:MouseEvent) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(LeiJiChongZhiPan.instance,function():void
         {
            LeiJiChongZhiPan.instance.visible = !LeiJiChongZhiPan.instance.visible;
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
      
      public static function addEff() : void
      {
         if(Boolean(iconBtn))
         {
            if(!eff)
            {
               eff = EffectManager.addEffect("35343",iconBtn,1000,32,29,true);
            }
         }
      }
      
      public static function removeEff() : void
      {
         if(Boolean(iconBtn))
         {
            if(Boolean(eff))
            {
               EffectManager.removeEffect(eff);
            }
         }
      }
   }
}

