package com.yiTian.view.modules.actions.liushiwanjiazhaohui
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class ZhaoHuiBtn
   {
      
      public static var icon:MainUIBtn;
      
      public static var eff:Effect;
      
      public function ZhaoHuiBtn()
      {
         super();
      }
      
      public static function show() : void
      {
         if(!icon)
         {
            icon = new MainUIBtn("resource/image/liushiwanjiazhaohui/kongjiandali.png");
            eff = EffectManager.addEffect("35343",icon,1000,32,29,true);
            UIManager.mainUiBtnContainer.addBTN(icon);
            icon.addEventListener(MouseEvent.CLICK,onClickHandle);
         }
      }
      
      public static function onClickHandle(e:MouseEvent) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(WanjiaBackPan.instance,function():void
         {
            WanjiaBackPan.instance.update(WanjiaBackPan.instance._value);
         });
         if(Boolean(eff))
         {
            EffectManager.removeEffect(eff);
            eff = null;
         }
      }
      
      public static function hide() : void
      {
         if(Boolean(icon))
         {
            UIManager.mainUiBtnContainer.removeBTN(icon);
            icon = null;
         }
         if(Boolean(eff))
         {
            EffectManager.removeEffect(eff);
            eff = null;
         }
      }
   }
}

