package com.yiTian.view.modules.battle
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_battleType;
   import com.yiTian.data.config.Enum_ChongChuJiangHu;
   import com.yiTian.data.config.Enum_Direct;
   import com.yiTian.data.model.Model_QiJu;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.net.message.cg.PataCGMessage;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.net.message.cg.WanAnSiCGMessage;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.guangMingDing.Model_guangMingDing;
   import com.yiTian.view.modules.pata.PataVO;
   import com.yiTian.view.modules.shenBing.Enum_ShenBing;
   import com.yiTian.view.modules.tianTi.TianTiManager;
   import com.yiTian.view.modules.wanansi.WanAnSiVO;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_BattleLayer extends Sprite
   {
      
      private static var lib:Dictionary = new Dictionary();
      
      private const positions:Array = [[68,176],[191,109],[314,42],[192.55,242],[315.55,175],[438.55,108],[317.15,308],[440.15,241],[563.35,174]];
      
      private var bgShape:Shape;
      
      public var gridLayer:Sprite;
      
      public var unitLayer:Sprite;
      
      public var uiLayer:Sprite;
      
      private var downuiLayer:Sprite;
      
      private var selfZFDisObj:View_zhengfa;
      
      public var targetDisObj:View_zhengfa;
      
      private var roundBg:Bitmap;
      
      private var roundBM:Bitmap;
      
      public var battleMenu:View_battle_menu;
      
      private var upuiShape:Shape;
      
      private var skillNameBg:ScaleBitmap;
      
      private var skillNameTf:MyTextField;
      
      private var jumpBtn:Button;
      
      private var jumpInfo:MyTextField;
      
      public var _bossHead:View_BossHeadMedPnl;
      
      public var isInit:Boolean = false;
      
      private var _sbLayer1:Sprite = new Sprite();
      
      private var _sbLayer2:Sprite = new Sprite();
      
      private var _teamEffDic1:Dictionary = new Dictionary();
      
      private var _teamEffDic2:Dictionary = new Dictionary();
      
      private var _teamEffectLayer:Sprite;
      
      private var selfGrids:Dictionary = new Dictionary();
      
      private var armyGrids:Dictionary = new Dictionary();
      
      private var selfRooms:Array;
      
      private var targetRooms:Array;
      
      private var list:Array = [];
      
      private var _isReplay:Boolean = false;
      
      private var beginEff:Effect;
      
      private var effBg:Shape;
      
      private var glintBm:Bitmap;
      
      private var interal:int;
      
      private var _direction:int;
      
      private var sbLayer:Sprite;
      
      private var _ids:Array = [];
      
      private var skillNameEff:Effect;
      
      public function View_BattleLayer()
      {
         super();
      }
      
      public function init() : void
      {
         if(this.isInit)
         {
            return;
         }
         if(!this.bgShape)
         {
            this.bgShape = new Shape();
            addChild(this.bgShape);
         }
         this._sbLayer1.mouseEnabled = this._sbLayer1.mouseChildren = this._sbLayer2.mouseChildren = this._sbLayer2.mouseEnabled = false;
         this.gridLayer = new Sprite();
         addChild(this.gridLayer);
         this.targetDisObj = new View_zhengfa(Enum_Direct.ARMY);
         this.gridLayer.addChild(this.targetDisObj);
         this.selfZFDisObj = new View_zhengfa(Enum_Direct.SELF);
         this.selfZFDisObj.x = 370;
         this.selfZFDisObj.y = 205;
         this.gridLayer.addChild(this.selfZFDisObj);
         this.addGrids();
         this.unitLayer = new Sprite();
         addChild(this.unitLayer);
         this.downuiLayer = new Sprite();
         addChild(this.downuiLayer);
         this.downuiLayer.visible = false;
         this.uiLayer = new Sprite();
         addChild(this.uiLayer);
         this._bossHead = new View_BossHeadMedPnl();
         this._bossHead.resetPosition();
         this.uiLayer.addChild(this._bossHead);
         this.roundBg = ComponentUtil.getBitmap("round",this.uiLayer,{"y":30},Global.battleDm);
         this.roundBM = new Bitmap();
         this.roundBM.y = 32;
         this.uiLayer.addChild(this.roundBM);
         this.jumpBtn = ComponentUtil.getButton("","Button_TGZD",this.uiLayer,{"y":100},Global.battleDm);
         this.jumpBtn.addEventListener(MouseEvent.CLICK,this.jumpBtnClick);
         this.jumpInfo = ComponentUtil.getTextField("3/15",this.uiLayer,{
            "y":this.jumpBtn.y + 30,
            "size":14,
            "color":12832335
         });
         this.battleMenu = new View_battle_menu();
         this.uiLayer.addChild(this.battleMenu);
         this.upuiShape = ComponentUtil.getShape(2500,2000,0,0.5);
         this.downuiLayer.addChild(this.upuiShape);
         this.upuiShape.visible = false;
         this.skillNameBg = ComponentUtil.getScaleBitmap("skillNameBg",[74,30,1,1],this.downuiLayer,{
            "width":280,
            "height":94
         },Global.UIdm);
         this.skillNameTf = ComponentUtil.getEmbedTF("",this.downuiLayer,{
            "color":16753152,
            "size":30,
            "align":"center",
            "font":"HYXueJunJ",
            "x":this.skillNameBg.x + 160,
            "y":this.skillNameBg.y + 80,
            "realWidth":200
         });
         this.skillNameTf.filters = [new GlowFilter(9444864,1,5,5,10)];
         this._teamEffectLayer = new Sprite();
         this._teamEffectLayer.mouseEnabled = this._teamEffectLayer.mouseChildren = false;
         addChild(this._teamEffectLayer);
         this.isInit = true;
         this.resize();
      }
      
      private function addGrids() : void
      {
         var index:String = null;
         var i:int = 0;
         while(i < 9)
         {
            index = 3 - int(i / 3) + "" + (3 - i % 3);
            this.armyGrids[index] = [this.positions[i][0],this.positions[i][1]];
            index = 1 + int(i / 3) + "" + (3 - i % 3);
            this.selfGrids[index] = [this.positions[i][0] + 370,this.positions[i][1] + 205];
            i++;
         }
      }
      
      public function getBattleGrid(position:int, direct:int) : Array
      {
         return direct == Enum_Direct.SELF ? this.selfGrids[position] : this.armyGrids[position];
      }
      
      public function setZF(selfZF:int, targetZF:int) : void
      {
         this.targetDisObj.zfId = targetZF;
         this.selfZFDisObj.zfId = selfZF;
      }
      
      public function setRound(round:int) : void
      {
         this.list.length = 0;
         this.decode(round);
         if(this.list.length == 1)
         {
            this.list.push(0);
         }
         if(Boolean(this.roundBM.bitmapData))
         {
            this.roundBM.bitmapData.dispose();
         }
         this.roundBM.bitmapData = new BitmapData(76,47,true,0);
         var j:int = this.list.length - 1;
         while(j >= 0)
         {
            if(!lib["y" + this.list[j]])
            {
               lib["y" + this.list[j]] = ComponentUtil.getBitmapData("y" + this.list[j],Global.battleDm);
            }
            Utils.point.x = (this.list.length - 1 - j) * 38;
            Utils.point.y = 0;
            Utils.rect.width = 38;
            Utils.rect.height = 47;
            this.roundBM.bitmapData.copyPixels(lib["y" + this.list[j]],Utils.rect,Utils.point,null,null,true);
            j--;
         }
      }
      
      private function decode(number:int) : void
      {
         if(number == 0)
         {
            return;
         }
         this.list.push(number % 10);
         this.decode(int(number / 10));
      }
      
      public function setJumpBattleBtn(type:int, isReplay:Boolean) : void
      {
         this._isReplay = isReplay;
         if(this._isReplay || (type == Enum_battleType.SHEN_SHOU || type == Enum_battleType.WU_LIN_SHAN_ZHUAN || type == Enum_battleType.BAOXIANG || type == Enum_battleType.QIJU) && GameUnitManager.hero.vip == 3)
         {
            this.jumpBtn.visible = true;
            this.jumpInfo.visible = false;
            return;
         }
         if(type == Enum_battleType.PATA)
         {
            this.jumpBtn.visible = true;
            if(GameUnitManager.hero.vip == 1)
            {
               this.jumpInfo.visible = true;
               this.jumpInfo.text = PataVO.tiaoGuoCiShu + " / 45";
            }
            else if(GameUnitManager.hero.vip == 2)
            {
               this.jumpInfo.visible = true;
               this.jumpInfo.text = PataVO.tiaoGuoCiShu + " / 75";
            }
            else if(GameUnitManager.hero.vip == 3)
            {
               this.jumpInfo.visible = false;
            }
            else
            {
               this.jumpInfo.visible = true;
               this.jumpInfo.text = PataVO.tiaoGuoCiShu + " / 15";
            }
         }
         else if(type == Enum_battleType.TIANTI && TianTiManager.curLv < TianTiManager.recordLv)
         {
            this.jumpBtn.visible = true;
            this.jumpInfo.visible = false;
         }
         else if(type == Enum_battleType.JINGJI && GameUnitManager.hero.vip == 3)
         {
            this.jumpBtn.visible = true;
            this.jumpInfo.visible = false;
         }
         else if(type == Enum_battleType.WANANSI && WanAnSiVO.layers >= Data_lib.sceneData[Global.sceneID][0])
         {
            this.jumpBtn.visible = true;
            this.jumpInfo.visible = false;
         }
         else if(type == Enum_battleType.CHUANG_GUAN)
         {
            this.jumpBtn.visible = false;
            this.jumpInfo.visible = false;
         }
         else if(type == Enum_battleType.KUAFUZHAN1)
         {
            this.jumpBtn.visible = true;
            this.jumpInfo.visible = false;
         }
         else if(type == Enum_battleType.QIJU)
         {
            if(GameUnitManager.hero.vip == 3)
            {
               this.jumpBtn.visible = true;
               this.jumpInfo.visible = false;
            }
         }
         else if(Enum_ChongChuJiangHu.CAN_JUMP && type == Enum_battleType.COMMON)
         {
            this.jumpBtn.visible = true;
            this.jumpInfo.visible = false;
         }
         else if(type == Enum_battleType.GuangMingDing && Model_guangMingDing.jumpLeftTimes > 0)
         {
            this.jumpBtn.visible = true;
            this.jumpInfo.visible = true;
            this.jumpInfo.text = Model_guangMingDing.jumpLeftTimes + " / 3";
         }
         else if(type == Enum_battleType.DRKF)
         {
            if(BattleManager._round < 6)
            {
               this.jumpBtn.visible = false;
               this.jumpInfo.visible = false;
               return;
            }
            this.jumpBtn.visible = true;
            this.jumpInfo.visible = false;
         }
         else
         {
            this.jumpBtn.visible = false;
            this.jumpInfo.visible = false;
         }
      }
      
      private function jumpBtnClick(e:MouseEvent) : void
      {
         if(this._isReplay == true)
         {
            BattleManager.end();
            return;
         }
         if(BattleManager.bType == Enum_battleType.QIJU)
         {
            if(Model_QiJu.skip_time > 0)
            {
               QiJuCGMessage.CG_SKIP_QIJU();
            }
            else
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10388",1) + "</font>");
            }
            return;
         }
         if(BattleManager.bType == Enum_battleType.KUAFUZHAN1)
         {
            BattleManager.end();
            return;
         }
         if(BattleManager.bType == 10)
         {
            BattleManager.end();
            return;
         }
         if(BattleManager.bType == Enum_battleType.JINGJI)
         {
            BattleManager.end();
            return;
         }
         if(BattleManager.bType == Enum_battleType.WANANSI)
         {
            WanAnSiCGMessage.CG_WANANSI_SKIP_BATTLE();
            return;
         }
         if(BattleManager.bType == Enum_battleType.COMMON && Enum_ChongChuJiangHu.CAN_JUMP)
         {
            BattleManager.end();
            return;
         }
         if(BattleManager.bType == Enum_battleType.GuangMingDing && Model_guangMingDing.jumpLeftTimes > 0)
         {
            GuangMingDingCGMessage.CG_GMD_JUMP_BATTLE();
            return;
         }
         if(BattleManager.bType == Enum_battleType.DRKF)
         {
            KuaFuJingJiChangCGMessage.CG_KUAFU_JUMPBATTLE();
            return;
         }
         if(GameUnitManager.hero.vip == 1)
         {
            if(PataVO.tiaoGuoCiShu > 44)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10388",1) + "</font>");
            }
            else
            {
               PataCGMessage.CG_SKIP_BATTLE();
            }
         }
         else if(GameUnitManager.hero.vip == 2)
         {
            if(PataVO.tiaoGuoCiShu > 74)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10388",1) + "</font>");
            }
            else
            {
               PataCGMessage.CG_SKIP_BATTLE();
            }
         }
         else if(GameUnitManager.hero.vip == 3)
         {
            PataCGMessage.CG_SKIP_BATTLE();
         }
         else if(PataVO.tiaoGuoCiShu > 14)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10388",1) + "</font>");
         }
         else
         {
            PataCGMessage.CG_SKIP_BATTLE();
         }
      }
      
      public function initSkill() : void
      {
         this.battleMenu.initSkill();
      }
      
      public function updateMenuInfo(hp:int, maxHp:int, mp:int, maxMp:int, angry:int) : void
      {
         this.battleMenu.updateInfo(hp,maxHp,mp,maxMp,angry);
      }
      
      public function playBeginEff() : void
      {
         if(!this.effBg)
         {
            this.effBg = ComponentUtil.getShape(2500,2000,0);
         }
         if(!this.glintBm)
         {
            this.glintBm = ComponentUtil.getBitmap("glint",null,null,Global.battleDm);
         }
         this.effBg.alpha = 1;
         addChild(this.effBg);
         this.beginEff = EffectManager.addEffect("zhuanchang",this,600,Global.stage.stageWidth / 2,Global.stage.stageHeight / 2,false);
         this.interal = setTimeout(this.removeEff,500);
      }
      
      private function removeEff() : void
      {
         clearTimeout(this.interal);
         addChild(this.glintBm);
         this.glintBm.alpha = 1;
         this.glintBm.scaleX = 0.2;
         this.glintBm.scaleY = 0.2;
         this.glintBm.x = (Global.stage.stageWidth - this.glintBm.width) / 2;
         this.glintBm.y = (Global.stage.stageHeight - this.glintBm.height) / 2;
         Tween.to(this.effBg,300,{"alpha":[1,0]},function():void
         {
            if(Boolean(effBg) && Boolean(effBg.parent))
            {
               removeChild(effBg);
            }
            beginEff = null;
         });
         Tween.to(this.glintBm,300,{
            "alpha":[1,0.5],
            "scaleX":[0.25,5],
            "scaleY":[0.25,5],
            "x":[Global.stage.stageWidth / 2 - 125,Global.stage.stageWidth / 2 - 2700],
            "y":[Global.stage.stageHeight / 2 - 180,Global.stage.stageHeight / 2 - 2200]
         },function():void
         {
            removeChild(glintBm);
         });
      }
      
      public function showShenBingIcon(ids:Array, direction:int) : void
      {
         var o:int = 0;
         if(direction == 1)
         {
            this.sbLayer = this._sbLayer1;
         }
         else
         {
            this.sbLayer = this._sbLayer2;
         }
         this._direction = direction;
         for each(o in ids)
         {
            this._ids.push(o);
         }
         addEventListener(Event.EXIT_FRAME,this.showIcon);
      }
      
      private function showIcon(e:Event) : void
      {
         var type:int = 0;
         var bufficon:Child_SbBattleBigIcon = null;
         removeEventListener(Event.EXIT_FRAME,this.showIcon);
         this.sbLayer.y = (Global.stage.stageHeight - this._ids.length * 150) / 2;
         this.clearShenBingIcon(this._direction);
         addChild(this.sbLayer);
         var map:Object = {};
         var i:int = 0;
         while(i < this._ids.length)
         {
            type = int(Data_lib.sbSkill[this._ids[i]][Enum_ShenBing.SKILL_TYPE]);
            if(!Boolean(map[type]))
            {
               bufficon = Pool.getObject(Child_SbBattleBigIcon);
               map[type] = true;
               bufficon.update(this._ids[i]);
               bufficon.y = i * 150;
               this.sbLayer.addChild(bufficon);
            }
            i += 1;
         }
         this._ids.splice(0);
         Tween.to(this.sbLayer,3000,{"alpha":[1,0]},this.twnComplete);
      }
      
      private function twnComplete(target:DisplayObject) : void
      {
         removeChild(target);
      }
      
      public function clearShenBingIcon(... directions) : void
      {
         var bufficon:Child_SbBattleBigIcon = null;
         if(directions.indexOf(1) >= 0)
         {
            Tween.stop(this._sbLayer1);
            if(Boolean(this._sbLayer1.parent))
            {
               this._sbLayer1.parent.removeChild(this._sbLayer1);
            }
            while(Boolean(this._sbLayer1.numChildren))
            {
               bufficon = this._sbLayer1.getChildAt(0) as Child_SbBattleBigIcon;
               this._sbLayer1.removeChild(bufficon);
               bufficon.dispose();
            }
         }
         if(directions.indexOf(2) >= 0)
         {
            Tween.stop(this._sbLayer2);
            if(Boolean(this._sbLayer2.parent))
            {
               this._sbLayer2.parent.removeChild(this._sbLayer2);
            }
            while(Boolean(this._sbLayer2.numChildren))
            {
               bufficon = this._sbLayer2.getChildAt(0) as Child_SbBattleBigIcon;
               this._sbLayer2.removeChild(bufficon);
               bufficon.dispose();
            }
         }
      }
      
      public function addTeamEff(force:int, effId:int, px:int = 0, py:int = 0, loop:Boolean = true, time:int = 1000) : void
      {
         px = force == 1 ? int(px + 200) : int(px - 170);
         py = force == 1 ? int(py + 160) : int(py - 46);
         var dic:Dictionary = force == 1 ? this._teamEffDic1 : this._teamEffDic2;
         if(loop == true)
         {
            if(!dic[effId])
            {
               dic[effId] = EffectManager.addEffect(effId.toString(),this._teamEffectLayer,time,px,py,loop);
            }
         }
         else
         {
            EffectManager.addEffect(effId.toString(),this._teamEffectLayer,time,px,py,loop);
         }
      }
      
      public function removeTeamEff(force:int, effId:int) : void
      {
         var dic:Dictionary = force == 1 ? this._teamEffDic1 : this._teamEffDic2;
         var eff:Effect = dic[effId];
         if(Boolean(eff))
         {
            EffectManager.removeEffect(dic[effId] as Effect);
         }
         delete dic[effId];
      }
      
      public function clearTeamEffct(dir:int = 3) : void
      {
         var k:String = null;
         var eff:Effect = null;
         if(Boolean(dir & 1))
         {
            for(k in this._teamEffDic1)
            {
               eff = this._teamEffDic1[k];
               EffectManager.removeEffect(eff);
               delete this._teamEffDic1[k];
            }
         }
         if(Boolean(dir & 2))
         {
            for(k in this._teamEffDic2)
            {
               eff = this._teamEffDic2[k];
               EffectManager.removeEffect(eff);
               delete this._teamEffDic2[k];
            }
         }
      }
      
      public function useSkill(skillName:String) : void
      {
         this.downuiLayer.visible = true;
         this.skillNameTf.text = skillName;
         this.upuiShape.visible = true;
         this.skillNameEff = EffectManager.addEffect("skillName",this.downuiLayer,400,this.skillNameBg.x + 150,this.skillNameBg.y + 50,false,MassLoader.LEVEL0);
         setTimeout(this.setSkillBackVisibleFalse,400);
         Tween.to(this.skillNameBg,200,{"alpha":[0.3,1]});
         Tween.to(this.skillNameTf,200,{"alpha":[0.3,1]});
      }
      
      private function setSkillBackVisibleFalse() : void
      {
         this.upuiShape.visible = false;
      }
      
      public function removeSkill() : void
      {
         if(this.skillNameBg.alpha != 0 || this.skillNameTf.alpha != 0)
         {
            Tween.curTo(this.skillNameBg,200,{"alpha":0});
            Tween.curTo(this.skillNameTf,200,{"alpha":0});
         }
      }
      
      public function clear() : void
      {
         this.clearShenBingIcon(1,2);
         this.clearTeamEffct();
         removeEventListener(Event.EXIT_FRAME,this.showIcon);
      }
      
      public function resize() : void
      {
         if(!this.isInit)
         {
            return;
         }
         this.bgShape.graphics.clear();
         this.bgShape.graphics.beginFill(0,0.8);
         this.bgShape.graphics.drawRect(0,0,Global.stage.stageWidth,Global.stage.stageHeight);
         this.bgShape.graphics.endFill();
         this.gridLayer.x = (Global.stage.stageWidth - 970) / 2;
         this.gridLayer.y = (Global.stage.stageHeight - 540) / 2 + 50;
         this.unitLayer.x = this.gridLayer.x;
         this.unitLayer.y = this.gridLayer.y;
         this.roundBg.x = Global.stage.stageWidth - this.gridLayer.y / 2 - this.roundBg.width;
         if(!this._bossHead.visible)
         {
            this.roundBg.y = this.gridLayer.y / 2;
         }
         else
         {
            this.roundBg.y = 140;
         }
         this.roundBM.x = this.roundBg.x + 55;
         this.roundBM.y = this.roundBg.y;
         this.jumpBtn.x = this.roundBg.x + 90;
         this.jumpBtn.y = this.roundBg.y + 70;
         this.jumpInfo.x = this.roundBg.x + 120;
         this.jumpInfo.y = this.jumpBtn.y + 35;
         this.battleMenu.x = (Global.stage.stageWidth - 400) / 2;
         this.battleMenu.y = Global.stage.stageHeight - 82;
         this.skillNameBg.x = (Global.stage.stageWidth - this.skillNameBg.width) / 2;
         this.skillNameBg.y = this.gridLayer.y / 2 - 50 > 0 ? this.gridLayer.y / 2 - 50 : 0;
         this.skillNameTf.x = this.skillNameBg.x + 50;
         this.skillNameTf.y = this.skillNameBg.y + 37;
         this._teamEffectLayer.x = Global.stage.stageWidth / 2;
         this._teamEffectLayer.y = Global.stage.stageHeight / 2;
         this._sbLayer1.x = Global.stage.stageWidth - 270;
         this._sbLayer2.x = 0;
      }
   }
}

