package com.yiTian.view.modules.treeDownCL
{
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.actions.xsHaoli.LinkManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   
   public class TreeIcon
   {
      
      private static var icon:MainUIBtn;
      
      private static var eff:Effect;
      
      public function TreeIcon()
      {
         super();
      }
      
      public static function show(value:Boolean) : void
      {
         if(!icon)
         {
            icon = new MainUIBtn("resource/image/treeDownCL/tree.png");
         }
         LinkManager.jump(showPanel,icon,false);
         effCtrl(value);
      }
      
      public static function showPanel() : void
      {
         if(Boolean(Model_team.isTeam[GameUnitManager.hero.id]))
         {
            UIManager.centerBroadcast.addMsg("组队状态不能进入");
            return;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("请先退出副本");
            return;
         }
         if(GameUnitManager.hero.level < 35)
         {
            UIManager.centerBroadcast.addMsg("等级不够，需要35级才能参与");
            return;
         }
         TreeOutsidePan.instance.update(Model_treeCL._actionIsStart ? 2 : 1);
      }
      
      public static function hide() : void
      {
         if(Boolean(icon))
         {
            UIManager.mainUiBtnContainer.removeBTN(icon);
         }
         effCtrl(false);
      }
      
      public static function effCtrl(value:Boolean) : void
      {
         if(value)
         {
            if(!eff)
            {
               eff = EffectManager.addEffect("35343",icon,1000,32,29,true);
            }
         }
         else
         {
            if(Boolean(eff))
            {
               EffectManager.removeEffect(eff);
            }
            eff = null;
         }
      }
   }
}

