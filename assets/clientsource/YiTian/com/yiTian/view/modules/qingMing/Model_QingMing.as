package com.yiTian.view.modules.qingMing
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QingmingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Tween;
   import flash.geom.Point;
   
   public class Model_QingMing
   {
      
      public static var battleId:int;
      
      public static var battleResult:int;
      
      public static var rewardCount:int;
      
      public static var bindNpc:Npc;
      
      public static var needFresh:Boolean;
      
      public static var _curLv:int = 1;
      
      public static var silverArr:Array = [];
      
      public static var modelIdArr:Array = [56307,56306,56309,56308];
      
      public static var ghostNameArr:Array = ["","鬼灵","鬼将","鬼王","鬼仙"];
      
      public static var data:Array = [];
      
      public static var tipStr:String = "不在活动时间内";
      
      public static var ghostNameColorArr:Array = ["#04ff00","#33CCFF","#de45c7","#ff7700"];
      
      public static var _refreshTimes:int = 0;
      
      private static var iconArr:Array = [];
      
      public function Model_QingMing()
      {
         super();
      }
      
      public static function set qualityUpdate(lv:int) : void
      {
         _curLv = lv;
         Global.control.sendNotification(Msg_QingMing.QUALITY_UPDATE,lv);
      }
      
      public static function set remainUpdate(v:int) : void
      {
         _refreshTimes = v;
         Global.control.sendNotification(Msg_QingMing.REMAIN_UPDATE,v);
      }
      
      public static function setStaticData() : void
      {
         var i:String = null;
         silverArr = [0];
         for(i in Data_lib.zhuaGuiReward)
         {
            silverArr.push(Data_lib.zhuaGuiReward[i][3]);
         }
      }
      
      public static function onCatchGhostResult(battleId:int) : void
      {
         if(battleId == Model_QingMing.battleId)
         {
            Model_QingMing.battleId = 0;
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,Model_QingMing.onCatchGhostResult);
            switch(Model_QingMing.battleResult)
            {
               case 1:
                  UIManager.centerBroadcast.addMsg("成功抓鬼,奖励经验果*" + rewardCount);
                  View_zhuaGuiPanel.instance.removeGui();
                  flyIcon();
                  data = [];
                  if(_refreshTimes == 0)
                  {
                     ZhuaGuiIconTip.hide();
                  }
                  break;
               case 2:
                  UIManager.centerBroadcast.addMsg("抓鬼失败");
            }
         }
      }
      
      public static function flyIcon() : void
      {
         var p:Point = null;
         var bm:Bitmap2 = null;
         var i:int = 0;
         var dir:String = "resource/image/icon/44467.png";
         var disPoint:Point = UIManager.mainMenu.getbagPoint();
         p = new Point(GameUnitManager.hero.global_x - CameraManager.sightX,GameUnitManager.hero.global_y - CameraManager.sightY);
         i = 0;
         while(i < 7)
         {
            if(Boolean(iconArr[i]))
            {
               bm = iconArr[i];
               bm.x = p.x + i * 15;
               bm.y = p.y + i * 15 - 100;
            }
            else
            {
               bm = new Bitmap2();
               bm.load(dir);
               bm.x = p.x + i * 15;
               bm.y = p.y + i * 15 - 100;
               iconArr[i] = bm;
            }
            GameScene.upUILayer.addChild(bm);
            Tween.to(bm,2500,{
               "x":[bm.x,disPoint.x],
               "y":[bm.y,disPoint.y]
            },function(bm:Bitmap2):void
            {
               if(Boolean(bm.parent))
               {
                  bm.parent.removeChild(bm);
               }
            },null,Tween.SIN);
            i++;
         }
      }
      
      public static function catchGhost(id:int) : void
      {
         if(Model_team.hasTeam() == true)
         {
            if(Model_team.isCap() == false)
            {
               UIManager.centerBroadcast.addMsg("需要队长点击才能发起战斗");
               return;
            }
            if(Model_team.isAway() == true)
            {
               UIManager.centerBroadcast.addMsg("队伍中有人暂离，不能抓鬼");
               return;
            }
            if(Model_team.isOffLine() == true)
            {
               UIManager.centerBroadcast.addMsg("队伍中有人离线，不能抓鬼");
               return;
            }
         }
         QingmingCGMessage.CG_QINGMING_CATCHGHOSE(id);
      }
   }
}

