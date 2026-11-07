package com.yiTian.view.modules.worldBoss
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.WorldBossCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class View_WorldBossMapInfo extends Panel
   {
      
      private static var _instance:View_WorldBossMapInfo;
      
      private var _bgLayer:Sprite = new Sprite();
      
      private var _tfRemain:MyTextField;
      
      private var _timer:Timer;
      
      private var _tfMemberJoin:MyTextField;
      
      private var _btnBi:Button;
      
      public var _cbAutoJoinCheck:CheckBox;
      
      public function View_WorldBossMapInfo()
      {
         super();
         init();
         bAutoRemove = false;
      }
      
      public static function get instance() : View_WorldBossMapInfo
      {
         return _instance = _instance || new View_WorldBossMapInfo();
      }
      
      override protected function initStaticView() : void
      {
         addChild(this._bgLayer);
         var bm:Bitmap = new Bitmap();
         this._bgLayer.addChild(bm);
         Utils.loadTitle(Config_WorldBoss.SRCURL,"MapInf",bm,this._bgLayer);
         ComponentUtil.getTextField("武魂地图",this,{
            "x":78,
            "y":3,
            "color":9893119
         });
         ComponentUtil.getTextField("剩余时间：",this,{
            "x":48,
            "y":40,
            "color":11523767
         });
         ComponentUtil.getTextField("参与人数：",this,{
            "x":48,
            "y":63,
            "color":11523767
         });
         this._tfRemain = ComponentUtil.getTextField("",this,{
            "x":108,
            "y":40,
            "color":16776960
         });
         this._tfMemberJoin = ComponentUtil.getTextField("",this,{
            "x":108,
            "y":63,
            "color":16776960
         });
         this._btnBi = ComponentUtil.getButton(LangConfig.getWord("10496",1),"Button_Round",this,{
            "x":40,
            "y":96,
            "textColor":16184781,
            "callBack":this.biClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("退出武魂地图","Button_RedFive",this,{
            "x":73,
            "y":93,
            "textColor":16184781,
            "callBack":this.leaveClickHd
         },Global.Img_Cdm);
         this._timer = new Timer(2000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimerTick);
         Global.control.registerCallBack(Msg_WorldBoss.NUMMEMBER_UPDATE,this.memberUpdate);
         Global.control.registerCallBack(Msg_WorldBoss.SCENE_INFO_UPDATE,this.updateRemain);
         this.updateRemain();
         this._cbAutoJoinCheck = ComponentUtil.getCheckBox("","CheckBox01",this,{
            "x":53,
            "y":140
         },Global.Img_Cdm);
         this._cbAutoJoinCheck.htmlText = "<font color=\'#ffff33\'><b>自动参战</b></font>";
         this._cbAutoJoinCheck.clickFun = this.cbClickHd;
         this.onIsShowOtherPlayer();
         Global.control.registerCallBack(Msg_WorldBoss.AUTOCHALLENGE_CHANGE,this.onAutoChallenge);
      }
      
      private function cbClickHd(cb:CheckBox) : void
      {
         Model_WorldBoss.setAutoChallenge(cb.selected);
         if(Model_WorldBoss._autoChallenge)
         {
            if(Model_WorldBoss._reviveType != 2 && SceneConfig.getSceneType() == SceneConfig.WORLDBOSS)
            {
               WorldBossUtil.autoChallenge();
            }
         }
         else
         {
            GameUnitManager.hero.stopGo();
         }
      }
      
      private function onAutoChallenge(v:Boolean) : void
      {
         this._cbAutoJoinCheck.selected = v;
         WorldBossUtil.setAutoBattle(v);
      }
      
      private function biClickHd(e:MouseEvent) : void
      {
         GameUnitManager.isShowPlayer = !GameUnitManager.isShowPlayer;
         this.onIsShowOtherPlayer();
      }
      
      private function onIsShowOtherPlayer() : void
      {
         TipManager.bind(this._btnBi,"点击隐藏或者显示其他玩家");
      }
      
      private function updateRemain() : void
      {
         var txt:String = null;
         var now:int = getTimer();
         var remain:int = Model_WorldBoss.getLocalRemain() / 1000;
         remain = Math.max(0,remain);
         if(remain > 1800)
         {
            txt = "尚未开始";
         }
         else
         {
            txt = DateUtil.getHMSBySecond2(remain);
         }
         this._tfRemain.text = txt;
      }
      
      private function memberUpdate(num:int) : void
      {
         this._tfMemberJoin.text = num.toString();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this._timer.start();
         }
         else
         {
            this._timer.stop();
         }
         super.visible = value;
      }
      
      private function onTimerTick(e:TimerEvent) : void
      {
         this.updateRemain();
      }
      
      private function leaveClickHd(e:MouseEvent) : void
      {
         View_Alert.show("是否离开副本？",View_Alert.OK_CANCAL,function():void
         {
            if(SceneConfig.getSceneType() == SceneConfig.WORLDBOSS)
            {
               WorldBossCGMessage.CG_WB_LEAVE_FUBEN();
            }
         });
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 210;
         y = 10;
      }
   }
}

