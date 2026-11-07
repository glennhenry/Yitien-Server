package com.yiTian.view.modules.worldBoss
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.model.Model_QiJu;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GuaJiCGMessage;
   import com.yiTian.net.message.cg.WorldBossCGMessage;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class WorldBossUtil
   {
      
      private static var _btn:BitmapBtn;
      
      private static var _bmAutoBattle:Bitmap2;
      
      public static const ICONURL:String = "resource/image/worldBoss/mainIcon.png";
      
      public static const STATIC_DURATAION:int = 1500;
      
      private static var _lastSceneClickTimer:int = -1500;
      
      private static var _autoBattle:Boolean = false;
      
      private static var _isFirstShow:Boolean = false;
      
      public function WorldBossUtil()
      {
         super();
      }
      
      public static function setBtnVis(v:Boolean) : void
      {
         if(v)
         {
            if(!_btn)
            {
               _btn = new BitmapBtn(true);
               _btn.init();
               _btn.setBgDir(ICONURL);
               _btn.buttonMode = true;
            }
            _btn.clickCallBack = btnClickHd;
            UIManager.mainUiBtnContainer.addBTN(_btn);
            _btn.extraObject = EffectManager.addEffect("35343",_btn,1000,32,29,true);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.ShiJieBOSS,1]);
         }
         else if(Boolean(_btn))
         {
            UIManager.mainUiBtnContainer.removeBTN(_btn);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.ShiJieBOSS,2]);
            if(Boolean(_btn.extraObject))
            {
               EffectManager.removeEffect(_btn.extraObject as Effect);
               _btn.extraObject = null;
            }
         }
      }
      
      public static function TRY_ENTERFUBEN() : void
      {
         var msg:String = null;
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            msg = "该场景不能进入副本";
         }
         else if(Model_team.hasTeam())
         {
            msg = "请先退出队伍再进入副本";
         }
         else if(GameUnitManager.hero.paoBiao > 0)
         {
            msg = "跑镖状态不能进入副本";
         }
         else if(Model_QiJu.isJoinPnlShow)
         {
            msg = "请先关闭珍龙棋局组队大厅";
         }
         if(msg != null)
         {
            UIManager.centerBroadcast.addMsg(msg);
            return;
         }
         if(GameUnitManager.hero.status == Status.SIT || UIManager.guajiPanel.visible)
         {
            GuaJiCGMessage.CG_GUAJI_CANCEL("");
         }
         WorldBossCGMessage.CG_WB_ENTERFUBEN();
      }
      
      public static function btnClickHd(e:MouseEvent) : void
      {
         View_Alert.show("是否传送至世界BOSS地图?",View_Alert.OK_CANCAL,WorldBossUtil.TRY_ENTERFUBEN);
      }
      
      public static function checkStart() : Boolean
      {
         var remain:int = Model_WorldBoss.getLocalRemain() / 1000;
         return remain <= 1800;
      }
      
      public static function autoChallenge() : Boolean
      {
         var u:Npc = null;
         var uu:GameUnit = null;
         if(Global.isInBattle)
         {
            return false;
         }
         for each(uu in GameUnitManager.list)
         {
            if(uu is Npc && (uu as Npc).npcType == Enum_npc_type.WORLDBOSS)
            {
               u = uu as Npc;
               break;
            }
         }
         if(u != null)
         {
            GameUnitManager.hero.target = u;
            return true;
         }
         return false;
      }
      
      public static function worldBossScenePass() : Boolean
      {
         if(!Model_WorldBoss._autoChallenge)
         {
            return true;
         }
         var now:int = getTimer();
         var duration:int = now - _lastSceneClickTimer;
         if(duration > STATIC_DURATAION)
         {
            _lastSceneClickTimer = now;
            UIManager.centerBroadcast.addMsg("再次点击退出自动挑战");
            return false;
         }
         Model_WorldBoss.setAutoChallenge(false);
         return true;
      }
      
      public static function setAutoBattle(v:Boolean) : void
      {
         if(v)
         {
            if(!_bmAutoBattle)
            {
               _bmAutoBattle = new Bitmap2();
               _bmAutoBattle.load("resource/image/quest/autoBattle.png");
               _bmAutoBattle.x = -90;
               _bmAutoBattle.y = -240;
            }
            GameUnitManager.hero.addChild(_bmAutoBattle);
         }
         else if(Boolean(_bmAutoBattle) && Boolean(_bmAutoBattle.parent))
         {
            _bmAutoBattle.parent.removeChild(_bmAutoBattle);
         }
      }
      
      public static function getAutoBattle() : Boolean
      {
         return _autoBattle;
      }
      
      public static function checkShowFirstIntroduce() : void
      {
         View_WorldBossIntroduce.instance.visible = true;
         _isFirstShow = false;
      }
      
      public static function get btn() : BitmapBtn
      {
         return _btn;
      }
   }
}

