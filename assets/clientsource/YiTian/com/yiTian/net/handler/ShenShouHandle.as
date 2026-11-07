package com.yiTian.net.handler
{
   import com.yiTian.data.vo.Vo_shenshou;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.CollectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ShenshouCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.banhui.shenshou.ShenShouPaiHang;
   
   public class ShenShouHandle
   {
      
      public function ShenShouHandle()
      {
         super();
      }
      
      public static function GC_SHEN_SHOU(vo:Vo_shenshou) : void
      {
         UIManager.banghuiBack.bangShenShou.voData = vo;
         UIManager.banghuiBack.BeastButEffter = vo;
      }
      
      public static function GC_TIAO_ZHAN(t:int) : void
      {
         var str:String = null;
         switch(t)
         {
            case 1:
               str = LangConfig.getWord("30029",3);
               break;
            case 2:
               str = LangConfig.getWord("30030",3);
               break;
            case 3:
               str = LangConfig.getWord("30031",3);
               break;
            case 4:
               str = LangConfig.getWord("30032",3);
               break;
            case 5:
               str = LangConfig.getWord("30054",3);
               break;
            case 6:
               str = LangConfig.getWord("30055",3);
               break;
            case 7:
               str = LangConfig.getWord("30088",3);
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_TIP_BATTLE() : void
      {
         var sureHandle:Function = null;
         sureHandle = function():void
         {
            ShenshouCGMessage.CG_ENTER_BEAST();
         };
         View_Alert.show(LangConfig.getWord("30052",3),View_Alert.OK_CANCAL,sureHandle);
      }
      
      public static function GC_ENTER_BEAST(t:int) : void
      {
         var str:String = null;
         switch(t)
         {
            case 2:
               str = LangConfig.getWord("30033",3);
               break;
            case 3:
               str = LangConfig.getWord("30034",3);
               break;
            case 4:
               str = LangConfig.getWord("30035",3);
               break;
            case 5:
               str = LangConfig.getWord("30036",3);
               break;
            case 6:
               str = LangConfig.getWord("30053",3);
               break;
            case 7:
               str = LangConfig.getWord("30065",3);
               break;
            case 8:
               str = LangConfig.getWord("30076",3);
               break;
            case 9:
               str = LangConfig.getWord("30088",3);
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_FEED_BEAST(tyle:int, num:int, reCost:int, exFeedCost:int, remain:int) : void
      {
         var str:String = "";
         if(num == 0)
         {
            UIManager.feedBeast.visible = false;
            UIManager.banghuiBack.visible = false;
         }
         switch(tyle)
         {
            case 1:
               if(num > 0)
               {
                  UIManager.feedBeast.visible = true;
                  UIManager.feedBeast.updateStarNum(num,reCost,exFeedCost);
               }
               break;
            case 2:
               str = LangConfig.getWord("30036",3);
               break;
            case 3:
               str = LangConfig.getWord("30103",3);
               break;
            case 4:
               str = LangConfig.getWord("30038",3);
               break;
            case 5:
               str = LangConfig.getWord("30039",3);
               break;
            case 6:
               str = LangConfig.getWord("30049",3);
               break;
            case 7:
               str = LangConfig.getWord("30043",3);
               if(remain <= 0)
               {
                  UIManager.feedBeast.visible = false;
                  break;
               }
               UIManager.feedBeast.updateStarNum(num,reCost,exFeedCost);
               break;
            case 8:
               str = LangConfig.getWord("30047",3);
               UIManager.feedBeast.updateStarNum(num,reCost,exFeedCost);
               break;
            case 9:
               str = LangConfig.getWord("30041",3);
               UIManager.feedBeast.updateStarNum(num,reCost,exFeedCost);
         }
         if(str != "")
         {
            UIManager.centerBroadcast.addMsg(str);
         }
      }
      
      public static function GC_FEED_LEVEL(refresh:int, num:int, reCost:int) : void
      {
         var str:String = "";
         if(num == 0)
         {
            UIManager.feedBeast.visible = false;
            UIManager.banghuiBack.visible = false;
         }
         else
         {
            UIManager.feedBeast.updateStarNum(num,reCost);
         }
         switch(refresh)
         {
            case 1:
               str = LangConfig.getWord("30040",3);
               break;
            case 2:
               str = LangConfig.getWord("30041",3);
               break;
            case 3:
               str = LangConfig.getWord("30042",3);
               break;
            case 4:
               str = LangConfig.getWord("30036",3);
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_SSBX_BEGIN_COLLECT(result:int, id:Number) : void
      {
         var npc:Npc = null;
         if(result == 1)
         {
            npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
            if(Boolean(npc))
            {
               CollectManager.begin(npc,20000);
            }
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30060",3));
         }
         else if(result == 3 || result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30062",3));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30036",3));
         }
      }
      
      public static function GC_UPDATE_SHEN_SHOU_HP(curHP:String, maxHP:String) : void
      {
         if(Boolean(ShenShouPaiHang.shenShouNpc))
         {
            ShenShouPaiHang.shenShouNpc.updateShenShouHP(curHP,maxHP);
         }
      }
      
      public static function GC_BEAST_RANK() : void
      {
         if(UIManager.shenShouPaiHang.visible)
         {
            UIManager.shenShouPaiHang.update();
         }
      }
      
      public static function GC_GONG_JI_SHENSHOU(resutl:int, time:int) : void
      {
         if(resutl == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30063",3,time));
         }
         else if(resutl == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30064",3));
         }
         else if(resutl == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30076",3));
         }
         else if(resutl == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30036",3));
         }
      }
   }
}

