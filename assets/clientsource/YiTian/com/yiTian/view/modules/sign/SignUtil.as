package com.yiTian.view.modules.sign
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SignCGMessage;
   import flash.display.Sprite;
   
   public class SignUtil
   {
      
      private static var eff:Effect;
      
      public function SignUtil()
      {
         super();
      }
      
      public static function askShowSignPanel(p:* = null) : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            Global.delegate.dosomething(View_SignPanel.instance,View_SignPanel.instance.visible ? View_SignPanel.instance.hide : View_SignPanel.instance.show);
            SignCGMessage.CG_SIGN_INFO();
         }
         else
         {
            UIManager.centerBroadcast.addMsg("等级未达30，请加油练级哦");
         }
      }
      
      public static function showSingleTips(effId:String, target:Sprite, x:Number, y:Number) : void
      {
         removeSingleTips();
         eff = EffectManager.addEffect(effId,target,1000,x,y,true);
      }
      
      public static function removeSingleTips() : void
      {
         if(Boolean(eff))
         {
            EffectManager.removeEffect(eff);
            eff = null;
         }
      }
   }
}

