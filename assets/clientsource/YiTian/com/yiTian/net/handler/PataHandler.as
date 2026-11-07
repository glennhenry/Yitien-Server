package com.yiTian.net.handler
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.vo_otherRoleInfo;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.DailyRemainManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PataCGMessage;
   import com.yiTian.utils.YTJSONParser;
   import com.yiTian.view.modules.newRolePan.ComparePan;
   import com.yiTian.view.modules.pata.PaTaDiaoXiang;
   import com.yiTian.view.modules.pata.PataVO;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   
   public class PataHandler
   {
      
      private static const diZuoDX:Array = [56901,56904,56907,56910,56913];
      
      private static const DiZuoTZ:Array = [56920,56921,56922,56923,56924];
      
      private static var effFlag:Boolean = false;
      
      public function PataHandler()
      {
         super();
      }
      
      public static function GC_OVERLORD(pataTimes:int, overlordsList:String, tiaoGuoCiShu:int) : void
      {
         PataVO.pataTimes = pataTimes;
         PataVO.overlordListStr = overlordsList;
         PataVO.tiaoGuoCiShu = tiaoGuoCiShu;
         PataVO.dataHandle();
         UIManager.pataOverlordViewPanel.update();
         var t:int = GameUnitManager.hero.vip == 3 ? 3 : 2;
         DailyRemainManager.setCount(DailyRemainManager.PA_TA,t - PataVO.pataTimes);
      }
      
      public static function GC_UPDATE_TIMES(pataTimes:int) : void
      {
         PataVO.pataTimes = pataTimes;
         var t:int = GameUnitManager.hero.vip == 3 ? 3 : 2;
         DailyRemainManager.setCount(DailyRemainManager.PA_TA,t - PataVO.pataTimes);
      }
      
      public static function GC_TTF_ENTRANCE(result:int) : void
      {
         if(result == 1)
         {
            UIManager.pataOverlordViewPanel.visible = false;
         }
         else if(result == -1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10379",1) + "</font>");
         }
      }
      
      public static function GC_LEAVE_TTF(result:int, fuBenFlat:int) : void
      {
         PataVO.fuBenFlat = fuBenFlat;
         if(result == 1)
         {
            UIManager.mainUiBtnContainer.hideLeaveBtn();
            PataVO.turnoffHandup();
            UIManager.smallMap.removeTip(7);
         }
      }
      
      public static function GC_OVERLORD_LAYER_INFO(result:int, layers:int, overlordsInfo:String, tiaoGuoCiShu:int, type:int) : void
      {
         if(!effFlag && GameUnitManager.hero.level >= 50 && (!Model_team.hasTeam() || Model_team.isCap()))
         {
            UIManager.smallMap.addTip(7,240000);
         }
         effFlag = true;
         PataVO.type = type;
         PataVO.layers = layers;
         PataVO.tiaoGuoCiShu = tiaoGuoCiShu;
         if(result == 1)
         {
            PataVO.start();
            if(PataVO.layers % 12 == 0)
            {
               PataVO.overlordListStr = overlordsInfo;
               PataVO.dataHandle();
               showDiaoXiang(layers);
            }
         }
         UIManager.smallMap.setTitle();
         UIManager.mappanel.curMap.setTitle();
      }
      
      public static function GC_ENTER_TTF(result:int, roleId:Number, roleName:String) : void
      {
         switch(result)
         {
            case -2:
               UIManager.centerBroadcast.addMsg(LangConfig.reTxt("{0}未达等级要求",roleName));
               break;
            case -3:
               UIManager.centerBroadcast.addMsg(LangConfig.reTxt("{0}未达等级要求",roleName));
               break;
            case -1:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10387",1) + "</font>");
               break;
            case 1:
               PataCGMessage.CG_ENTER_TTF_TIMES();
         }
      }
      
      public static function GC_SKIP_BATTLE(result:int, tiaoGuoCiShu:int) : void
      {
         PataVO.tiaoGuoCiShu = tiaoGuoCiShu;
         if(result == 1)
         {
            BattleManager.jumpBattle();
         }
         else if(result == -1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10388",1) + "</font>");
         }
      }
      
      public static function GC_CHALLENGE_OVERLORD(result:int, layers:int, overlordsStr:String) : void
      {
         if(layers % 12 == 0)
         {
            PataVO.layersOverlordsArr[layers / 12 - 1] = overlordsStr;
            PataVO.overlordsInfo = overlordsStr;
            showDiaoXiang(layers);
         }
      }
      
      private static function showDiaoXiang(layers:int) : void
      {
         var unit:GameUnit = null;
         var diaoXiang:PaTaDiaoXiang = null;
         var index:int = 0;
         var a:Array = null;
         var xx:String = null;
         var yy:String = null;
         var i:uint = 0;
         while(i < 4)
         {
            unit = GameUnitManager.findUnit(i,UnitType.FUBEN_DIAOXIANG);
            if(Boolean(unit))
            {
               GameUnitManager.removeUnit(unit);
            }
            i++;
         }
         if(PataVO.type == 0)
         {
            index = 12100;
         }
         else
         {
            if(PataVO.type != 1)
            {
               return;
            }
            index = 19000;
         }
         var diaoXiangInfo:Object = YTJSONParser.instance.parseStringToObject(Data_lib.sceneData[index + layers % 1000][10]);
         var stoneInfo:Object = YTJSONParser.instance.parseStringToObject(Data_lib.sceneData[index + layers % 1000][11]);
         var layIndex:int = layers % 1000 / 12 - 1;
         var tempA:Array = PataVO.layersOverlordsArr[layIndex].split("|");
         i = 0;
         while(i < 4)
         {
            diaoXiang = GameUnitManager.findUnit(i,UnitType.FUBEN_DIAOXIANG) as PaTaDiaoXiang;
            if(!Boolean(diaoXiang))
            {
               diaoXiang = GameUnitManager.getUnit(UnitType.FUBEN_DIAOXIANG) as PaTaDiaoXiang;
               xx = (Number(diaoXiangInfo.x) + i * Number(diaoXiangInfo.offsetX)).toString();
               yy = (Number(diaoXiangInfo.y) + i * Number(diaoXiangInfo.offsetY)).toString();
               if(i < 3)
               {
                  if(Boolean(tempA[i]))
                  {
                     a = tempA[i].split("_");
                     diaoXiang.init(i,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[11],a[12],xx,yy,diZuoDX[layIndex],layers);
                  }
                  else
                  {
                     diaoXiang.init(i,null,null,null,null,null,null,null,null,null,null,null,null,xx,yy,diZuoDX[layIndex],layers);
                  }
               }
               else
               {
                  diaoXiang.init(i,null,null,null,null,null,null,null,null,null,null,null,null,stoneInfo.x,stoneInfo.y,DiZuoTZ[layIndex],layers);
               }
               GameUnitManager.addUnit(diaoXiang);
            }
            i++;
         }
      }
      
      public static function GC_CHALLENGE_OVERLORD_STATE(result:int, state:int) : void
      {
         if(result == 1)
         {
            UIManager.pataTipPanel.visible = true;
            true;
            if(state == 1)
            {
               UIManager.pataTipPanel.countDown(true);
            }
            else if(state == -1)
            {
               UIManager.pataTipPanel.countDown(false);
            }
         }
         else if(result == -1)
         {
            if(state == 1)
            {
               PataCGMessage.CG_CHALLENGE_OVERLORD(-1,PataVO.layers,1);
            }
            else if(state == -1)
            {
               PataCGMessage.CG_CHALLENGE_OVERLORD(2,PataVO.layers,1);
            }
         }
      }
      
      public static function GC_OVERLORD_INFO(id:int, name:String, level:int, sex:int, job:int, equips:Array) : void
      {
         var voR:vo_otherRoleInfo = null;
         voR = new vo_otherRoleInfo();
         voR.roleId = id;
         voR.roleName = name;
         voR.roleLevel = level;
         voR.roleSex = sex;
         voR.roleJob = job;
         voR.equipArr = equips;
         WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
         {
            pan.update(voR);
         });
      }
   }
}

