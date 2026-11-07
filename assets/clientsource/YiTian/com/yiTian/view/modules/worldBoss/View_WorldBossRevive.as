package com.yiTian.view.modules.worldBoss
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WorldBossCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class View_WorldBossRevive extends Panel
   {
      
      private static var _timer:Timer;
      
      private static var _instance:View_WorldBossRevive;
      
      private var _btnRevive:Button;
      
      private var _tfMain:MyTextField;
      
      private var _last:int = -1000;
      
      private var _count:int;
      
      private var _recordTime:int;
      
      public function View_WorldBossRevive()
      {
         super();
         bindParent = GameScene.modalLayer;
         init();
      }
      
      public static function get instance() : View_WorldBossRevive
      {
         return _instance = _instance || new View_WorldBossRevive();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":318,
            "height":200
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":270,
            "height":150
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":250,
            "height":80
         },Global.Img_Cdm);
         this._tfMain = ComponentUtil.getTextField("",this,{
            "x":160,
            "y":75,
            "color":13424242,
            "size":14
         });
         this._tfMain.autoSize = TextFieldAutoSize.CENTER;
         this._btnRevive = ComponentUtil.getButton("立刻复活","Button_SendGift",this,{
            "x":72,
            "y":146,
            "textColor":16184781,
            "callBack":this.reviveBtnClickHd
         },Global.Img_Cdm);
         TipManager.bind(this._btnRevive,"花费20元宝");
         Utils.loadTitle("lang/ch/WuHun_Imgs.swf","Title_ReLife",new Bitmap(),{
            "x":79,
            "y":5
         },this);
         Global.control.registerCallBack(Msg_WorldBoss.REVIVE_UPDATE,this.reviveMsgHd);
         _timer = new Timer(1000);
         _timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      private function reviveBtnClickHd(e:MouseEvent) : void
      {
         var now:int = getTimer();
         if(now - this._last < 1500)
         {
            return;
         }
         this._last = now;
         if(GameUnitManager.hero.money < Config_WorldBoss.REVIVE_YUANBAOCOST)
         {
            UIManager.centerBroadcast.addMsg("元宝不足，请及时充值");
         }
         else
         {
            WorldBossCGMessage.CG_WB_REVIVE(2);
         }
      }
      
      public function reviveMsgHd(type:int) : void
      {
         this._recordTime = getTimer();
         this._count = Config_WorldBoss.getReviveCountTime();
         if(type == 1)
         {
            ModalUIManager.UNPOP();
         }
         else if(type == 2)
         {
            ModalUIManager.POPUP(this);
            _timer.reset();
            _timer.start();
            this.updateRemain();
         }
         else
         {
            ModalUIManager.UNPOP();
         }
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         this.updateRemain();
      }
      
      public function updateRemain() : void
      {
         var now:int = getTimer();
         var remain:int = Math.ceil(this._count - (now - this._recordTime) / 1000);
         if(remain < 0)
         {
            remain = 0;
         }
         if(remain <= 0)
         {
            WorldBossCGMessage.CG_WB_REVIVE(1);
            ModalUIManager.UNPOP();
         }
         this._tfMain.htmlText = "<font color=\'#ffff00\' size=\'20\'>" + remain.toString() + "</font> " + "秒后您将自动复活";
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.onSceneChange);
         }
         else
         {
            _timer.stop();
            Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.onSceneChange);
         }
         super.visible = value;
      }
      
      private function onSceneChange() : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.WORLDBOSS)
         {
            Model_WorldBoss.updateRevive(1);
         }
      }
   }
}

