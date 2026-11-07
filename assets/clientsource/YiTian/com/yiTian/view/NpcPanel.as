package com.yiTian.view
{
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.Utils;
   
   public class NpcPanel extends Panel
   {
      
      private static var nowNpcP:NpcPanel;
      
      public static const TYPE_DEL_NPC:int = 1;
      
      public static const TYPE_HERO_RUN:int = 2;
      
      public var bindNpc:Npc;
      
      public function NpcPanel()
      {
         super();
      }
      
      public static function checkVisible(npc:Npc, type:int = 1) : void
      {
         if(Boolean(nowNpcP))
         {
            if(!nowNpcP.bindNpc)
            {
               return;
            }
            if(type == TYPE_DEL_NPC && nowNpcP.bindNpc == npc)
            {
               nowNpcP.visible = false;
               return;
            }
            if(type == TYPE_HERO_RUN)
            {
               if(Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,nowNpcP.bindNpc.global_x,nowNpcP.bindNpc.global_y) >= 600000)
               {
                  nowNpcP.visible = false;
               }
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!visible)
         {
            if(nowNpcP == this)
            {
               this.bindNpc = null;
               nowNpcP = null;
            }
         }
         else
         {
            if(Boolean(nowNpcP) && nowNpcP != this)
            {
               nowNpcP.visible = false;
            }
            nowNpcP = this;
         }
      }
      
      public function show(npc:Npc) : void
      {
         this.bindNpc = npc;
      }
   }
}

