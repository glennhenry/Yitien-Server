package com.yiTian.view.modules.guangMingDing
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Door;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.net.message.cg.GuaJiCGMessage;
   import com.yiTian.utils.AStar;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.kuafujingjichang.DRKFjoinPanel;
   import com.yiTian.view.modules.kuafujingjichang.DRKFlawPanel;
   import com.yiTian.view.modules.kuafujingjichang.DRKFlistPanel;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.qiJu.View_JoinQiJu;
   import flash.events.MouseEvent;
   
   public class GuangMingDingConfig
   {
      
      public static var bmBtn:BitmapBtn;
      
      private static var _rewardNames:Array;
      
      private static var _staticRewards:Array;
      
      public static const STATIE_JUMPPOINT_ID:int = -9527;
      
      public static const LV_REQUIRE:int = 50;
      
      public static const HALL_INFO_QUEST_INTERVAL:uint = 5000;
      
      public static const INVITE_LV:int = 40;
      
      public function GuangMingDingConfig()
      {
         super();
      }
      
      public static function lvToLibKey(lv:Number) : Number
      {
         return 12409 + lv;
      }
      
      public static function getRemainTimsTxt(time:int) : String
      {
         return LangConfig.reTxt("今日剩余次数：<font color=\'#ffff33\'>{0}次</font>",time);
      }
      
      public static function getRecordTxt(lv:int) : String
      {
         return LangConfig.reTxt("历史最高层数：<font color=\'#ffff33\'>{0}层</font>",lv);
      }
      
      public static function addTipBtn() : void
      {
         if(GameUnitManager.hero.level < 50)
         {
            return;
         }
         if(!bmBtn)
         {
            bmBtn = new BitmapBtn(true);
            bmBtn.init(4,4,46,46);
            bmBtn.setBgDir("resource/image/ycgmd/mainIcon.png");
            bmBtn.clickCallBack = btnClick;
            bmBtn.buttonMode = true;
         }
         UIManager.mainUiBtnContainer.addBTN(bmBtn);
         bmBtn.showTime(1);
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.GuangMingDing,1]);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.GuangMingDing,1]);
      }
      
      public static function removeTipBtn() : void
      {
         if(Boolean(bmBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(bmBtn);
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.GuangMingDing,0]);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.GuangMingDing,2]);
      }
      
      public static function btnClick(e:MouseEvent) : void
      {
         var st:int = SceneConfig.getSceneType();
         if(st != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("非副本地图才能进入光明顶队伍大厅",2);
         }
         else if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg("请先离开队伍",2);
         }
         else
         {
            GuangMingDingCGMessage.CG_GMD_HALL_INFO();
         }
      }
      
      public static function isCanJoin() : Boolean
      {
         if(GameUnitManager.hero.level < 50)
         {
            UIManager.centerBroadcast.addMsg("等级达到50才能进行勇闯光明顶哦");
            return false;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("请先离开副本");
            return false;
         }
         if(GameUnitManager.hero.paoBiao > 0)
         {
            UIManager.centerBroadcast.addMsg("您正在跑镖，无法参与勇闯光明顶");
            return false;
         }
         return true;
      }
      
      public static function resetNpcPos() : void
      {
         var list:Array = GameUnitManager.list;
         var i:int = 0;
         while(i < list.length)
         {
            if(list[i] is Npc && (list[i] as Npc).npcType == Enum_npc_type.GMD)
            {
               list[i].global_x = 762;
               list[i].global_y = 810;
               list[i].align();
            }
            i += 1;
         }
      }
      
      public static function createJumpPoint() : void
      {
         var k:Number = NaN;
         var px:Number = NaN;
         var py:Number = NaN;
         var indexX_door:int = 0;
         var indexY_door:int = 0;
         var i:int = 0;
         var j:int = 0;
         var temp1:int = 0;
         var temp2:int = 0;
         if(SceneConfig.getSceneType() != SceneConfig.GMD)
         {
            return;
         }
         var staticID:int = GuangMingDingConfig.STATIE_JUMPPOINT_ID;
         var d:Door = GameUnitManager.findUnit(staticID,UnitType.JUMP_POINT) as Door;
         if(!d)
         {
            d = GameUnitManager.getUnit(UnitType.JUMP_POINT) as Door;
            k = GuangMingDingConfig.lvToLibKey(Model_guangMingDing._floor);
            px = Number(Data_lib.ycgmd[k][Enum_guangMingDing.LIB_MAP_X]);
            py = Number(Data_lib.ycgmd[k][Enum_guangMingDing.LIB_MAP_Y]);
            d.init(staticID,px,py,0,true,35001,500);
            Door.list[staticID] = d;
            GameUnitManager.addUnit(d);
            indexX_door = px / AStar.size;
            indexY_door = py / AStar.size;
            i = -1;
            while(i <= 1)
            {
               j = -1;
               while(j <= 1)
               {
                  temp1 = indexX_door + i;
                  temp2 = indexY_door + j;
                  if(temp2 >= 0 && temp1 >= 0 && temp2 < AStar._grid.numRows && temp1 < AStar._grid.numCols)
                  {
                     AStar._grid.getNode(temp1,temp2).jumpArea = true;
                     AStar._grid.getNode(temp1,temp2).jumpLink = d;
                     AStar.jump_position.push([temp1,temp2,d]);
                  }
                  j++;
               }
               i++;
            }
         }
      }
      
      public static function cantCreateTeam() : Boolean
      {
         if(Model_guangMingDing.isHallShow || Model_guangMingDing.isTeamShow)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80150",8));
            return true;
         }
         return false;
      }
      
      public static function checkToCancelGuaJi() : void
      {
         if(GameUnitManager.hero.status == Status.SIT || UIManager.guajiPanel.visible == true)
         {
            GuaJiCGMessage.CG_GUAJI_CANCEL("");
         }
      }
      
      public static function get rewardNames() : Array
      {
         return _rewardNames = _rewardNames || ["经验","绑银","凡品五行丹"];
      }
      
      public static function getRewardArrs(lv:int, rep:String = "{0}：<font color=\'#33ff33\'>{1}</font>") : Array
      {
         var value:String = null;
         var k:Number = lvToLibKey(lv);
         if(!Data_lib.ycgmd[k])
         {
            return null;
         }
         var a:Array = Util.splicObj(Data_lib.ycgmd[k][Enum_guangMingDing.LIB_MAP_REWARD],"_") as Array;
         var result:Array = [];
         var i:int = 0;
         while(i < a.length)
         {
            value = a[i];
            if(value != "0")
            {
               result.push(Util.rep(rep,rewardNames[i],value));
            }
            i += 1;
         }
         return result;
      }
      
      public static function getStaticRewards() : Array
      {
         return _staticRewards = _staticRewards || [46382,46383,44587];
      }
      
      public static function getIntroduceTxt() : String
      {
         return "<font color=\'#ffff33\'>1、</font>挑战成功的层数越高获得的奖励越大，奖励最后以邮件发放。<br><font color=\'#ffff33\'>" + "2、</font>合理的使用武林秘籍可以让你挑战更高的层数，每个秘籍有<font color=\'#33ff33\'>2次</font>的免费使用次数。<br><font color=\'#ffff33\'>" + "3、</font>每层只能复活<font color=\'#33ff33\'>10次</font>。<br><font color=\'#ffff33\'>" + "4、</font>挑战难度较高，建议组队参与。<br>" + "<font color=\'#ffff33\'>5、</font>每个玩家拥有<font color=\'#33ff33\'>3次</font>跳过战斗的次数。";
      }
      
      public static function closeSomePnl() : void
      {
         if(UIManager.team.visible)
         {
            UIManager.team.visible = false;
         }
         if(UIManager.inviteTip.visible)
         {
            UIManager.inviteTip.visible = false;
         }
         if(UIManager.teamSearchPanel.visible)
         {
            UIManager.teamSearchPanel.visible = false;
         }
         if(DRKFjoinPanel.instance.visible)
         {
            DRKFjoinPanel.instance.visible = false;
         }
         if(DRKFlawPanel.instance.visible)
         {
            DRKFlawPanel.instance.visible = false;
         }
         if(DRKFlistPanel.instance.visible)
         {
            DRKFlistPanel.instance.visible = false;
         }
         if(ModalUIManager.isShow)
         {
            ModalUIManager.UNPOP();
         }
         if(View_JoinQiJu.instance.visible)
         {
            View_JoinQiJu.instance.visible = false;
         }
      }
   }
}

