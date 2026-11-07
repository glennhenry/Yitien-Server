package com.yiTian.view.modules.worldBoss
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.battle.BattleBloodBar;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   
   public class View_WorldBossBloodPnl extends Panel
   {
      
      private static var _instance:View_WorldBossBloodPnl;
      
      public var _bmBossHead:Bitmap2;
      
      public var _tfBossName:MyTextField;
      
      public var _tfRemainNumBlood:MyTextField;
      
      public var _tfHp:MyTextField;
      
      public var _tfChuanGong:MyTextField;
      
      public var _bossBlood:BattleBloodBar;
      
      private var _bmBg:Bitmap;
      
      private var _bgSP:Sprite;
      
      private var _bloodSp:Sprite;
      
      private var _yuanBao:Sprite;
      
      private var _liQuan:Sprite;
      
      private var _timer:Timer;
      
      private var _isInit:Boolean = false;
      
      private var _isFirstShow:Boolean = true;
      
      private var _lastPercent:int = 1;
      
      private var shpMask:Shape = new Shape();
      
      public function View_WorldBossBloodPnl()
      {
         super();
         bAutoRemove = false;
         this._bgSP = new Sprite();
         addChild(this._bgSP);
         this._bmBg = new Bitmap();
         this._bgSP.addChild(this._bmBg);
         this._bloodSp = new Sprite();
         addChild(this._bloodSp);
         this._bossBlood = new BattleBloodBar();
         this._bossBlood.y = 65;
         this._bloodSp.addChild(this._bossBlood);
         this._tfHp = ComponentUtil.getTextField("",this,{
            "x":195,
            "y":68,
            "color":16776960
         });
         this._tfHp.autoSize = TextFieldAutoSize.CENTER;
         this._tfRemainNumBlood = ComponentUtil.getTextField("",this,{
            "x":409,
            "y":62,
            "size":14,
            "bold":true,
            "color":14518272
         });
         this._tfRemainNumBlood.autoSize = TextFieldAutoSize.CENTER;
         this._tfBossName = ComponentUtil.getTextField("",this,{
            "x":376,
            "y":33,
            "color":16383744,
            "size":14,
            "bold":true
         });
         this._tfBossName.autoSize = TextFieldAutoSize.RIGHT;
         this._tfChuanGong = ComponentUtil.getTextField("",this,{
            "x":303,
            "y":115,
            "color":16724787,
            "size":18,
            "bold":true
         });
         this._tfChuanGong.filters = [new GlowFilter(0,1,2,2,10),new DropShadowFilter(2,315,13404245)];
         this._yuanBao = new Sprite();
         this._liQuan = new Sprite();
         addChild(this._yuanBao);
         addChild(this._liQuan);
         var _temp_1:* = this._yuanBao;
         this._liQuan.buttonMode = true;
         _temp_1.buttonMode = true;
         this._bmBossHead = new Bitmap2();
         addChild(this._bmBossHead);
         this._bmBossHead.load("resource/image/worldBoss/1.png",1,this.onHeadComplete);
         this._yuanBao.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this._yuanBao.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this._liQuan.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this._liQuan.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this._yuanBao.addEventListener(MouseEvent.CLICK,this.yuanBaoClickHd);
         this._liQuan.addEventListener(MouseEvent.CLICK,this.liQuanClickHd);
         Global.control.registerCallBack(Msg_WorldBoss.BOSS_INFO_UPDATE,this.onBossInfoUpdate);
         Global.control.registerCallBack(Msg_WorldBoss.CHUANGONG_UPDATE,this.onUpdateChuangong);
         Global.control.registerCallBack(Msg_WorldBoss.BOSSID_UPDATE,this.updateBossID);
         this.onUpdateChuangong(0);
         this.updateBossID();
         this._timer = new Timer(5000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      public static function get instance() : View_WorldBossBloodPnl
      {
         return _instance = _instance || new View_WorldBossBloodPnl();
      }
      
      private function onHeadComplete(info:Object) : void
      {
         this._bmBossHead.x = 50 + 529 - 110 - this._bmBossHead.width / 2;
         this._bmBossHead.y = 86 - this._bmBossHead.height;
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         if(Model_WorldBoss._autoChallenge && Model_WorldBoss._reviveType != 2 && SceneConfig.getSceneType() == SceneConfig.WORLDBOSS)
         {
            WorldBossUtil.autoChallenge();
         }
      }
      
      private function yuanBaoClickHd(e:MouseEvent) : void
      {
         if(View_YBCGPrompt.instance.visible)
         {
            View_YBCGPrompt.instance.visible = false;
         }
         else
         {
            View_YBCGPrompt.instance.show();
         }
         View_LQCGPrompt.instance.visible = false;
      }
      
      private function liQuanClickHd(e:MouseEvent) : void
      {
         if(View_LQCGPrompt.instance.visible)
         {
            View_LQCGPrompt.instance.visible = false;
         }
         else
         {
            View_LQCGPrompt.instance.show();
         }
         View_YBCGPrompt.instance.visible = false;
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorWhite2;
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorNomal;
      }
      
      public function initDymic() : void
      {
         var bm:Bitmap = null;
         var patch:String = null;
         var url:String = null;
         if(this._isInit)
         {
            return;
         }
         this._isInit = true;
         patch = Config_WorldBoss.SRCURL;
         Utils.loadTitle(patch,"ProgressBack",new Bitmap(),{
            "x":this._bossBlood.x - 10,
            "y":this._bossBlood.y - 6
         },this._bgSP);
         Utils.loadTitle(patch,"HeadBack",new Bitmap(),{"x":385},this._bloodSp);
         var i:int = 1;
         while(i <= 10)
         {
            url = "Progress_WH" + Enum_BroadCastTool.instance.getBitStr(i);
            bm = new Bitmap();
            Utils.loadTitle(patch,url,bm,null);
            this._bossBlood.appendBar(bm);
            i += 1;
         }
         this.shpMask.graphics.beginFill(255,0);
         this.shpMask.graphics.drawRoundRect(-404,0,404,24,60,30);
         this.shpMask.x = 404;
         this.shpMask.graphics.endFill();
         this._bossBlood.addChild(this.shpMask);
         Utils.loadTitle(patch,"Text_ChuanGong",new Bitmap(),{
            "x":238 - 42,
            "y":115
         },this._bloodSp);
         Utils.loadTitle(patch,"Text_GongJiLi",new Bitmap(),{
            "x":285 - 42,
            "y":115
         },this._bloodSp);
         Utils.loadTitle(patch,"LQChuanGong",new Bitmap(),{
            "x":175 - 42,
            "y":97
         },this._liQuan);
         Utils.loadTitle(patch,"YBChuanGong",new Bitmap(),{
            "x":97 - 42,
            "y":97
         },this._yuanBao);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this._isFirstShow = true;
            this._timer.start();
            this.initDymic();
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,this.onBattleEnd);
            Global.control.registerCallBack(Enum_MsgType.ADD_NPC_SCENE,this.onAddNpc);
         }
         else
         {
            Model_WorldBoss.setAutoChallenge(false);
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,this.onBattleEnd);
            Global.control.removeCallBack(Enum_MsgType.ADD_NPC_SCENE,this.onAddNpc);
            this._timer.stop();
         }
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 535) / 2;
      }
      
      public function onBossInfoUpdate() : void
      {
         var percent:Number = Model_WorldBoss._bossHpCur / Model_WorldBoss._bossHpMax;
         percent = Math.max(percent,0);
         if(this._isFirstShow)
         {
            this._bossBlood.percent = percent;
            this._tfHp.text = Model_WorldBoss._bossHpCur.toString() + "/" + Model_WorldBoss._bossHpMax.toString();
            this._tfRemainNumBlood.text = "×" + this._bossBlood.playIndex.toString();
            this._bossBlood.bars[this._bossBlood.playIndex].mask = this.shpMask;
            this.shpMask.scaleX = this._bossBlood.curPercent;
         }
         else
         {
            Tween.curTo(this._bossBlood,700,{"percent":percent},null,this.onTick);
         }
         this._isFirstShow = false;
      }
      
      private function updateBossID() : void
      {
         var bID:Number = Model_WorldBoss._bossID;
         var color:int = Model_WorldBoss._color;
         if(bID != 0)
         {
            this._tfBossName.htmlText = Enum_BroadCastTool.instance.getColorStr(Data_lib.npc[bID][Npc.NAME],color + 1);
         }
      }
      
      private function onUpdateChuangong(v:int) : void
      {
         this._tfChuanGong.text = "+" + (v * 10).toString() + "%";
      }
      
      private function onTick() : void
      {
         this._tfHp.text = (this._bossBlood.percent * Model_WorldBoss._bossHpMax >> 0).toString() + "/" + Model_WorldBoss._bossHpMax.toString();
         this.shpMask.scaleX = this._bossBlood.curPercent;
         this._bossBlood.bars[this._bossBlood.playIndex].mask = this.shpMask;
         this._tfRemainNumBlood.text = "×" + this._bossBlood.playIndex.toString();
      }
      
      private function onBattleEnd() : void
      {
         if(Model_WorldBoss._autoChallenge && Model_WorldBoss._reviveType != 2 && SceneConfig.getSceneType() == SceneConfig.WORLDBOSS)
         {
            WorldBossUtil.autoChallenge();
         }
      }
      
      private function onAddNpc(npc:Npc) : void
      {
         if(npc.npcType == Enum_npc_type.WORLDBOSS)
         {
            npc.way = 4;
            if(Model_WorldBoss._autoChallenge && Model_WorldBoss._reviveType != 2 && SceneConfig.getSceneType() == SceneConfig.WORLDBOSS)
            {
               WorldBossUtil.autoChallenge();
            }
         }
      }
   }
}

