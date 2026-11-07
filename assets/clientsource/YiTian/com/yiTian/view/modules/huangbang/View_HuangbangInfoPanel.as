package com.yiTian.view.modules.huangbang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.data.vo.quest.Vo_questStep;
   import com.yiTian.effects.Effect_quest;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HuangbangCGMessage;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.quest.View_quest_trace;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_HuangbangInfoPanel extends Panel123
   {
      
      private static const linkReg:RegExp = /(\(|\（)(\d|\/)*(\)|\）)/gi;
      
      private var bg:DisplayObject;
      
      private var btnHelp:Button;
      
      private var btnFastTen:Button;
      
      private var btnLookBack:Button;
      
      private var btnFast:Button;
      
      private var btnGiveUp:Button;
      
      private var countTF:MyTextField;
      
      private var tipTF:MyTextField;
      
      private var discriptTF:MyTextField;
      
      private var rewardTF:MyTextField;
      
      private var quest:Vo_quest;
      
      private var container:Sprite;
      
      private var colorIconArr:Array = [];
      
      public var eff:Effect;
      
      private var fristPoint:LoopPoint;
      
      private var isInHuangbang:Boolean;
      
      private var desStr:String = "";
      
      private var rewardStr:String = "";
      
      public function View_HuangbangInfoPanel()
      {
         super();
         regResource("lang/ch/HuangBang_Img.swf","HuangBang_Imgdm");
      }
      
      public static function get instance() : View_HuangbangInfoPanel
      {
         return Singleton.getInstance(View_HuangbangInfoPanel);
      }
      
      private static function jumpEnd() : void
      {
      }
      
      override protected function initStaticView() : void
      {
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         bAutoRemove = false;
      }
      
      override protected function initUI2() : void
      {
         this.bg = ComponentUtil.getBitmap("Zhou_Img",this,{
            "x":0,
            "y":0
         },Global.HuangBang_Imgdm);
         ComponentUtil.getScaleBitmap("Back_Inf",[2,2,2,2],this,{
            "x":65,
            "y":88,
            "width":206,
            "height":26
         },Global.HuangBang_Imgdm);
         ComponentUtil.getTextField("周任务次数：",this,{
            "x":70,
            "y":67,
            "color":0,
            "size":12,
            "leading":5,
            "filters":[]
         });
         this.btnFastTen = ComponentUtil.getButton("快速完成10次","Button_HBSix",this,{
            "x":62,
            "y":122,
            "textColor":16184781,
            "callBack":this.fastFinishTen
         },Global.HuangBang_Imgdm);
         this.btnLookBack = ComponentUtil.getButton("找回上周次数","Button_HBSix",this,{
            "x":173,
            "y":122,
            "textColor":16184781,
            "callBack":this.lookBack
         },Global.HuangBang_Imgdm);
         TipManager.bind(this.btnFastTen,"花费20元宝快速完成10个当前品质任务");
         TipManager.bind(this.btnLookBack,"找回上周剩余未完成的任务次数");
         ComponentUtil.getBitmap("Line",this,{
            "x":53,
            "y":160
         },Global.HuangBang_Imgdm);
         this.container = new Sprite();
         addChild(this.container);
         this.countTF = ComponentUtil.getTextField("000/000",this,{
            "x":145,
            "y":67,
            "color":3348992,
            "size":12,
            "leading":0,
            "filters":[]
         });
         this.tipTF = ComponentUtil.getTextField("",this.container,{
            "x":199,
            "y":169,
            "color":327424,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("当前周任务品质：",this,{
            "x":100,
            "y":91,
            "color":0,
            "size":12,
            "leading":0,
            "filters":[]
         });
         ComponentUtil.getTextField("当前任务",this.container,{
            "x":70,
            "y":169,
            "color":0,
            "size":12,
            "leading":0,
            "filters":[]
         });
         ComponentUtil.getScaleBitmap("Back_Inf",[2,2,2,2],this.container,{
            "x":65,
            "y":191,
            "width":206,
            "height":26
         },Global.HuangBang_Imgdm);
         this.discriptTF = ComponentUtil.getTextField("去应天府找",this.container,{
            "x":75,
            "y":195,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("任务奖励",this.container,{
            "x":70,
            "y":223,
            "color":0,
            "size":12,
            "leading":0,
            "filters":[]
         });
         ComponentUtil.getScaleBitmap("Back_Inf",[2,2,2,2],this.container,{
            "x":65,
            "y":245,
            "width":206,
            "height":26
         },Global.HuangBang_Imgdm);
         this.rewardTF = ComponentUtil.getTextField("经验：",this.container,{
            "x":75,
            "y":249,
            "color":0,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_Zoon",this,{
            "x":277,
            "y":30,
            "textColor":16184781
         },Global.HuangBang_Imgdm);
         this.btnHelp = ComponentUtil.getButton("","Button_Quest",this,{
            "x":256,
            "y":30,
            "textColor":16184781,
            "callBack":this.showHelpTip
         },Global.HuangBang_Imgdm);
         this.btnFast = ComponentUtil.getButton("快速完成","Button_HBBule",this.container,{
            "x":69,
            "y":281,
            "textColor":16184781,
            "callBack":this.fastFinish
         },Global.HuangBang_Imgdm);
         this.btnGiveUp = ComponentUtil.getButton("放弃任务","Button_HBRed",this.container,{
            "x":178,
            "y":281,
            "textColor":16184781,
            "callBack":this.giveUp
         },Global.HuangBang_Imgdm);
         var spr:Sprite = new Sprite();
         addChild(spr);
         spr.buttonMode = true;
         TipManager.bind(spr,"任务品质分绿蓝紫橙，越往里面的圈，任务品质越高，奖励越丰厚");
         this.colorIconArr.push(ComponentUtil.getBitmap("Icon_Lv",spr,{
            "x":197,
            "y":91
         },Global.HuangBang_Imgdm));
         this.colorIconArr.push(ComponentUtil.getBitmap("Icon_Lan",spr,{
            "x":197,
            "y":91
         },Global.HuangBang_Imgdm));
         this.colorIconArr.push(ComponentUtil.getBitmap("Icon_Zi",spr,{
            "x":197,
            "y":91
         },Global.HuangBang_Imgdm));
         this.colorIconArr.push(ComponentUtil.getBitmap("Icon_Cheng",spr,{
            "x":197,
            "y":91
         },Global.HuangBang_Imgdm));
         this.discriptTF.mouseEnabled = true;
         this.discriptTF.addEventListener(TextEvent.LINK,this.link);
         this.updateCount();
         this.checkBtnVisible(false);
         this.container.visible = false;
         this.setColor();
         Model_Huangbang.setSilverAndGoldData();
         Enum_explor.bindDic[Enum_explor.BTN_HUANGBANG_HELP] = this.btnHelp;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,this.onEnterSceneOk);
      }
      
      public function setColor() : void
      {
         var i:int = 0;
         while(i < this.colorIconArr.length)
         {
            this.colorIconArr[i].visible = false;
            i++;
         }
         if(Boolean(this.colorIconArr[Model_Huangbang.currentLoop]))
         {
            this.colorIconArr[Model_Huangbang.currentLoop].visible = true;
         }
      }
      
      private function fastFinish(e:MouseEvent) : void
      {
         View_Alert.show("是否花费<font color=\'" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\'>2元宝</font>快速完成该任务？",View_Alert.OK_CANCAL,function():void
         {
            HuangbangCGMessage.CG_FAST_FINISH_HUANGBANG(quest.id);
         });
      }
      
      private function giveUp(e:MouseEvent) : void
      {
         UIManager.wuXingProm.show(function():void
         {
            HuangbangCGMessage.CG_GIVE_UP_HUANGBANG(quest.id);
         },"放弃任务不返还次数，确定放弃？",Enum_Huangbang.HUANGBANG_NUM);
      }
      
      private function fastFinishTen(e:MouseEvent) : void
      {
         if(Model_Huangbang.canClickShake == false)
         {
            return;
         }
         if(Model_Huangbang.remainCount < 1)
         {
            UIManager.centerBroadcast.addMsg("本周周任务已完成");
            return;
         }
         UIManager.wuXingProm.show(function():void
         {
            if(GameUnitManager.hero.money < int(Model_Huangbang.remainCount < Enum_Huangbang.MAX_FINISH_COUNT ? Model_Huangbang.remainCount * 2 : Enum_Huangbang.MAX_QUALITY * 2))
            {
               UIManager.centerBroadcast.addMsg("元宝不足");
               return;
            }
            HuangbangCGMessage.CG_FAST_FINISH_HUANGBANG_TEN();
         },"是否花费<font color=\'" + ColorConstant.getColorStr(ColorConstant.YELLOW) + "\'>" + (Model_Huangbang.remainCount < Enum_Huangbang.MAX_FINISH_COUNT ? Model_Huangbang.remainCount * 2 : Enum_Huangbang.MAX_FINISH_COUNT * 2) + "元宝</font>快速完成<font color=\'" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\'>" + (Model_Huangbang.remainCount < Enum_Huangbang.MAX_FINISH_COUNT ? Model_Huangbang.remainCount : Enum_Huangbang.MAX_FINISH_COUNT) + "次</font>当前品质的任务？",Enum_Huangbang.HUANGBANG_NUM + int(Model_Huangbang.remainCount < Enum_Huangbang.MAX_FINISH_COUNT ? Model_Huangbang.remainCount * 2 : Enum_Huangbang.MAX_QUALITY * 2));
      }
      
      private function lookBack(e:MouseEvent) : void
      {
         HuangbangCGMessage.CG_GET_LASTWEEK_QUEST();
      }
      
      private function link(e:TextEvent) : void
      {
         var inter:int = 0;
         if(Model_Huangbang.canClickShake == false)
         {
            return;
         }
         Model_Huangbang.isClickQuest = true;
         Model_quest.doLink(e.text);
         GameScene.instance.onTextEventLink();
         Model_quest.curQuest = this.quest;
         Model_quest.AUTO_MOVE();
         if(GameUnitManager.hero.level < 30)
         {
            View_quest_trace.isTextLinking = true;
            inter = int(setTimeout(function():void
            {
               clearTimeout(inter);
               View_quest_trace.isTextLinking = false;
            },1));
         }
      }
      
      public function onEnterSceneOk() : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.HUANGBANG && this.isInHuangbang == true)
         {
            this.hide();
         }
      }
      
      public function goPoint(loopPoint:LoopPoint) : void
      {
         Model_Huangbang.Shaker = true;
         GameUnitManager.hero.lockTarget = loopPoint;
         GameUnitManager.hero.go(loopPoint.x,loopPoint.y);
         Model_Huangbang.Shaker = false;
      }
      
      public function jumpPoint(x:int, y:int) : void
      {
         var p:PP = Singleton.getInstance(PP);
         p._sx = GameUnitManager.hero.global_x;
         p._sy = GameUnitManager.hero.global_y;
         p._ex = x;
         p._ey = y;
         Tween.to(p,500,{"percent":[0,1]},jumpEnd);
      }
      
      public function leaveCb() : void
      {
         SceneCGMessage.CG_ASK_CHANGE_SCENE(13401,4000,3900);
         this.hide();
         HuangbangCGMessage.CG_EIXT_HUANGBANG();
      }
      
      private function showHelpTip(e:MouseEvent) : void
      {
         View_HuangbangHelpPanel.instance.visible = !View_HuangbangHelpPanel.instance.visible;
      }
      
      public function getBtnPoint(_target:Object) : Point
      {
         return localToGlobal(new Point(_target.x,_target.y));
      }
      
      private function checkBtnVisible(value:Boolean) : void
      {
         this.btnFast.visible = value;
         this.btnGiveUp.visible = value;
      }
      
      public function updateQuestStatus(questId:int, result:int) : void
      {
         var quest:Vo_quest = null;
         var step:Vo_questStep = null;
         var tempArr:Array = null;
         var linkstr:String = null;
         var desc:String = null;
         if(!this.tipTF || !this.quest)
         {
            return;
         }
         if(result == 0)
         {
            quest = new Vo_quest(questId);
            step = quest.continueStep[0];
            if(Boolean(step))
            {
               desc = step.descript;
               this.desStr = desc;
            }
            if(this.tipTF.htmlText != "已完成")
            {
               Effect_quest.getItem().play(Effect_quest.FINISH_QUEST);
            }
            tempArr = this.desStr.match(linkReg);
            linkstr = tempArr[tempArr.length - 1];
            if(linkstr != "" && linkstr != null)
            {
               this.desStr = this.desStr.replace(linkstr,"");
            }
            this.discriptTF.htmlText = this.desStr;
            this.tipTF.htmlText = "<font color=\'#ff0000\'>已完成</font>";
            this.checkBtnVisible(false);
            View_HuangbangPanel.instance.showShake();
            if(SceneConfig.getSceneType() != SceneConfig.HUANGBANG)
            {
               GameUnitManager.hero.autoMove(52678,UnitType.NPC);
            }
         }
         else
         {
            this.tipTF.htmlText = "已领取";
            this.checkBtnVisible(true);
         }
      }
      
      public function updateCount() : void
      {
         if(!this.countTF)
         {
            return;
         }
         this.countTF.htmlText = Model_Huangbang.currentCount + "/" + Model_Huangbang.totalCount;
      }
      
      public function updateText(str:String, quest:Vo_quest) : void
      {
         this.quest = quest;
         this.desStr = str;
         if(!this.discriptTF)
         {
            return;
         }
         this.update();
      }
      
      public function setReward(str:String) : void
      {
         this.rewardStr = str;
         if(Boolean(this.rewardTF))
         {
            this.rewardTF.htmlText = this.rewardStr;
         }
      }
      
      public function update() : void
      {
         this.updateCount();
         this.setColor();
         if(!this.quest)
         {
            return;
         }
         if(this.quest.status == 0)
         {
            if(Model_Huangbang.canAccept == true)
            {
               Model_Huangbang.canAccept = false;
               EffectManager.flyHuangbangEff(new Point(GameUnitManager.hero.global_x - CameraManager.sightX,GameUnitManager.hero.global_y - CameraManager.sightY),localToGlobal(new Point(this.rewardTF.x + 80,this.rewardTF.y - 20)));
               Effect_quest.getItem().play(Effect_quest.ACCEPT_QUEST);
            }
         }
         this.container.visible = true;
         this.discriptTF.htmlText = this.desStr;
         this.rewardTF.htmlText = this.rewardStr;
      }
      
      public function reset() : void
      {
         if(!this.discriptTF)
         {
            return;
         }
         this.updateCount();
         this.discriptTF.htmlText = "";
         this.rewardTF.htmlText = "";
         this.container.visible = false;
      }
      
      public function show() : void
      {
         var timeOut:int = 0;
         this.isInHuangbang = true;
         visible = true;
         UIManager.questTraceView.visible = false;
         UIManager.newMainBtnContainer.visible = false;
         UIManager.mainUiBtnContainer.visible = false;
         View_IconPanel.instance.visible = true;
         UIManager.smallMap.visible = false;
         View_HuangbangPanel.instance.visible = true;
         timeOut = int(setTimeout(function():void
         {
            if(Boolean(GameUnitManager.pet))
            {
               GameUnitManager.pet.visible = false;
            }
            clearTimeout(timeOut);
         },200));
         GameUnitManager.hero.way = 4;
         this.update();
         if(this.eff == null)
         {
            this.eff = EffectManager.addEffect(35234 + "",GameScene.gridLayer,1000,1179,820,true);
            this.eff.alpha = 0.7;
         }
      }
      
      public function hide() : void
      {
         this.isInHuangbang = false;
         visible = false;
         EffectManager.removeEffect(this.eff);
         this.eff = null;
         if(View_HuangbangHelpPanel.instance.visible)
         {
            View_HuangbangHelpPanel.instance.visible = false;
         }
         View_IconPanel.instance.visible = false;
         UIManager.questTraceView.visible = true;
         UIManager.newMainBtnContainer.visible = true;
         UIManager.mainUiBtnContainer.visible = true;
         UIManager.smallMap.visible = true;
         View_HuangbangPanel.instance.visible = false;
         if(Boolean(GameUnitManager.pet))
         {
            GameUnitManager.pet.visible = true;
         }
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - this.width;
         y = (Global.stage.stageHeight - this.height) / 2 - 100;
      }
      
      override public function get height() : Number
      {
         if(!this.bg)
         {
            return super.height;
         }
         return this.bg.height;
      }
      
      override public function get width() : Number
      {
         if(!this.bg)
         {
            return super.width;
         }
         return this.bg.width;
      }
   }
}

import com.yiTian.Global;
import com.yiTian.manager.CameraManager;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.view.modules.huangbang.Enum_Huangbang;
import com.yiTian.view.modules.huangbang.Model_Huangbang;

class PP
{
   
   public var _sx:Number;
   
   public var _sy:Number;
   
   public var _ex:Number;
   
   public var _ey:Number;
   
   private var _tickCallBack:Object;
   
   public function PP()
   {
      super();
   }
   
   public function set percent(value:Number) : void
   {
      var px:int = 0;
      px = this._sx + (this._ex - this._sx) * value;
      var py:int = this._sy + (this._ey - this._sy) * value;
      GameUnitManager.hero.global_x = px;
      GameUnitManager.hero.global_y = py;
      var jumpPercent:Number = Math.sin(value * Math.PI);
      GameUnitManager.hero.parts.y = -jumpPercent * 150;
      GameUnitManager.hero.align();
      CameraManager.wacthIm(px,py);
      if(value >= 1 && Model_Huangbang.currentLoop == Enum_Huangbang.MAX_QUALITY)
      {
         Global.control.sendNotification(Enum_Huangbang.JUMP_LAST_POINT,null);
      }
   }
}
