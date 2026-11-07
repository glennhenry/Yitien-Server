package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_guangMingDingChallengePnl extends Panel123
   {
      
      private static const SX:Number = 566;
      
      private static const SY:Number = 810;
      
      private static const EX:Number = 762;
      
      private static const JUMPY:Number = 100;
      
      private var _spLv:Sprite;
      
      private var _bg:DisplayObject;
      
      private var _tfReward:MyTextField;
      
      private var _btnChangllenge:Button;
      
      private var _lastLv:int = -1;
      
      private var bmpool:Array = [];
      
      private var _u:Role;
      
      private var tmpObj:Object = {};
      
      private var dir:Number;
      
      private var _gridCont:Sprite;
      
      private var grids:Array = [];
      
      private var _tzLast:int;
      
      private var _uu:Npc;
      
      public function View_guangMingDingChallengePnl()
      {
         super();
         regResource("lang/ch/GuangMingDing_Img.swf","GuangMingDing_Imgdm");
         bAutoRemove = false;
      }
      
      override protected function initUI2() : void
      {
         this._bg = ComponentUtil.getBitmap("Back_Next",this,{
            "x":0,
            "y":17
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getTextField("该层可使用武林秘籍",this,{
            "x":277,
            "y":50,
            "color":5894668,
            "size":16,
            "bold":true
         });
         move = new Rectangle(0,17,this._bg.width,this._bg.height);
         ComponentUtil.getTextField("当前奖励",this,{
            "x":316,
            "y":162,
            "color":8842580,
            "size":16,
            "leading":0,
            "bold":true
         });
         this._tfReward = ComponentUtil.getTextField("",this,{
            "x":this._bg.width / 2,
            "y":192
         });
         this._tfReward.autoSize = TextFieldAutoSize.CENTER;
         this._btnChangllenge = ComponentUtil.getButton("","Button_TiaoZhan",this,{
            "x":284,
            "y":230,
            "textColor":16184781,
            "callBack":function():void
            {
               tiaoZhan();
            }
         },Global.GuangMingDing_Imgdm);
         this._spLv = new Sprite();
         this._gridCont = new Sprite();
         this._gridCont.y = 85;
         this._gridCont.x = this._bg.width / 2 + 10;
         addChild(this._gridCont);
         this.updateRemainBuff();
         addEventListener(MouseEvent.CLICK,this.clickHd);
         this.updateChangllengeBtn();
         this.updateFloor();
      }
      
      private function clickHd(e:MouseEvent) : void
      {
         if(!(e.target is Button) && (this._bg as Bitmap).bitmapData.getPixel32(mouseX,mouseY) < 4177526784)
         {
            GameScene.instance.downEvent(e);
         }
      }
      
      public function updateFloor() : void
      {
         var lv:int = 0;
         var bms:Array = null;
         var o:String = null;
         var i:int = 0;
         var bm:Bitmap = null;
         var bm2:Bitmap = null;
         var bm3:Bitmap = null;
         if(SceneConfig.getSceneType() != SceneConfig.GMD)
         {
            lv = 1;
         }
         else
         {
            lv = int(Data_lib.ycgmd[Global.sceneID][Enum_guangMingDing.LIB_MAP_FLOOR]);
         }
         if(this._lastLv == lv)
         {
            return;
         }
         this._lastLv = lv;
         while(Boolean(this._spLv.numChildren))
         {
            bm = this._spLv.getChildAt(0) as Bitmap;
            this._spLv.removeChild(bm);
            this.bmpool.push(bm);
         }
         var lvstr:String = lv.toString();
         var a:Array = lvstr.split("");
         if(a.length >= 3)
         {
            a.splice(1,0,"100");
         }
         else if(a.length >= 2)
         {
            a.splice(1,0,"10");
            if(lv < 20)
            {
               a.splice(0,1);
            }
         }
         a.unshift("Di");
         a.push("Ceng");
         bms = [];
         for each(o in a)
         {
            if(o != "0")
            {
               if(o.length < 2)
               {
                  o = "0" + o;
               }
               bm2 = Boolean(this.bmpool.length) ? this.bmpool.pop() : new Bitmap();
               bm2.bitmapData = ComponentUtil.getBitmapData("Text_" + o.toString(),Global.GuangMingDing_Imgdm);
               bms.push(bm2);
            }
         }
         i = 0;
         while(i < bms.length)
         {
            bm3 = bms[i];
            bm3.x = i * 26;
            this._spLv.addChild(bm3);
            i += 1;
         }
         addChild(this._spLv);
         this._spLv.x = (this._bg.width - this._spLv.width) / 2;
         this._tfReward.htmlText = GuangMingDingConfig.getRewardArrs(lv).join("       ");
         Global.control.registerCallBack(Msg_guangMingDing.MJ_UPDATE,this.updateRemainBuff);
         Global.control.registerCallBack(Msg_guangMingDing.MJ_USEING_UPDATE,this.updateUseingEffs);
      }
      
      public function updateChangllengeBtn() : void
      {
         if(Model_team.hasTeam() && Model_team.isCap() || !Model_team.hasTeam())
         {
            this._btnChangllenge.visible = true;
         }
         else
         {
            this._btnChangllenge.visible = false;
         }
      }
      
      public function show(p:* = null) : void
      {
         this.visible = true;
      }
      
      public function hide(p:* = null) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.updateFloor();
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.askChangeVis);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.askChangeVis);
            Global.control.registerCallBack(Enum_MsgType.ADD_NPC_SCENE,this.onAddNpc);
            Global.control.registerCallBack(Enum_MsgType.TEAM_CHANGE,this.onTeamChange);
            Global.control.registerCallBack(Enum_MsgType.NPC_INTERACTION,this.tiaoZhan);
            UIManager.questTraceView.visible = false;
            UIManager.newMainBtnContainer.visible = false;
            this.updateChangllengeBtn();
            GuangMingDingConfig.closeSomePnl();
         }
         else
         {
            Model_guangMingDing.updateMJUseingInfo({});
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.askChangeVis);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.askChangeVis);
            Global.control.removeCallBack(Enum_MsgType.ADD_NPC_SCENE,this.onAddNpc);
            Global.control.removeCallBack(Enum_MsgType.TEAM_CHANGE,this.onTeamChange);
            Global.control.removeCallBack(Enum_MsgType.NPC_INTERACTION,this.tiaoZhan);
            Global.control.sendNotification(Msg_guangMingDing.CHANPANEL_HIDE,this);
            if(!UIManager.questTraceView.visible)
            {
               UIManager.questTraceView.visible = true;
               UIManager.newMainBtnContainer.visible = true;
               UIManager.questTraceView.resetPosition();
            }
         }
         super.visible = value;
      }
      
      private function onAddNpc(u:Role) : void
      {
         if(u is Npc && (u as Npc).npcType == Enum_npc_type.GMD)
         {
            this._u = u;
            u.way = 3;
            Tween.to(this.tmpObj,1000,{"percent":[0,1]},this.tweenFin,null,this.tweenFun);
         }
      }
      
      private function tweenFin(p:Number) : void
      {
      }
      
      private function tweenFun(p:Number) : Number
      {
         var jumpPercent:Number = NaN;
         if(Boolean(this._u) && this._u is Npc)
         {
            jumpPercent = Math.sin(p * Math.PI);
            this._u.global_x = p * (EX - SX) + SX;
            this._u.global_y = jumpPercent * -JUMPY + SY;
            this._u.align();
         }
         return p;
      }
      
      public function askChangeVis() : void
      {
         this.updateChangllengeBtn();
         if(SceneConfig.getSceneType() != SceneConfig.GMD)
         {
            if(visible)
            {
               Global.delegate.dosomething(this,this.hide);
            }
            GuangMingDingConfig.closeSomePnl();
         }
         else if(!visible)
         {
            Global.delegate.dosomething(this,this.show);
         }
         this.updateFloor();
      }
      
      public function onTeamChange() : void
      {
         this.updateChangllengeBtn();
      }
      
      public function updateRemainBuff() : void
      {
         var i:int = 0;
         var j:int = 0;
         var mjInfo:Array = null;
         var id:int = 0;
         var remain:int = 0;
         var vo:Vo_MiJi = null;
         var gItem:gridItem = null;
         var gItem2:gridItem = null;
         var mjInfos:Object = Model_guangMingDing._mjInfo;
         var mapId:int = GuangMingDingConfig.lvToLibKey(Model_guangMingDing._floor);
         var canUseMJs:Array = Util.splicObj(Data_lib.ycgmd[mapId][Enum_guangMingDing.LIB_MAP_MJID],"_") as Array;
         i = 0;
         while(i < canUseMJs.length)
         {
            mjInfo = mjInfos[i];
            id = parseInt(canUseMJs[i]);
            remain = 0;
            if(!mjInfos[id])
            {
               remain = int(Data_lib.Gmd_mj[id][Enum_guangMingDing.LIB_MJ_FREETIMES]);
            }
            else
            {
               remain = int(mjInfos[id][Enum_guangMingDing.SERV_MJ_FREEREMAIN]);
            }
            remain = Math.max(0,remain);
            gItem = this.grids[i];
            if(!gItem)
            {
               gItem = new gridItem();
               gItem.grid._vo = new Vo_MiJi();
               this.grids[i] = gItem;
               gItem.grid.mouseChildren = false;
               gItem.grid.buttonMode = true;
            }
            this._gridCont.addChild(gItem);
            vo = gItem.grid.vo as Vo_MiJi;
            vo.id = id;
            vo.freeCount = remain;
            vo.extraType = 1;
            gItem.grid.vo = vo;
            gItem.tf.htmlText = Data_lib.Gmd_mj[id][Enum_guangMingDing.LIB_MJ_NAME];
            gItem.x = (i - canUseMJs.length / 2) * 75 + 8;
            gItem.visible = true;
            gItem.grid.addEventListener(MouseEvent.CLICK,this.mjItemClickHd);
            i += 1;
         }
         j = this.grids.length - 1;
         while(j >= i)
         {
            gItem2 = this.grids[j];
            gItem2.visible = false;
            j -= 1;
         }
         this.updateUseingEffs();
      }
      
      public function updateUseingEffs() : void
      {
         addEventListener(Event.EXIT_FRAME,this.updateUseingEffIm);
      }
      
      private function updateUseingEffIm(e:Event) : void
      {
         var gItem:gridItem = null;
         var grid:View_MiJiGrid = null;
         removeEventListener(Event.EXIT_FRAME,this.updateUseingEffIm);
         var map:Object = Model_guangMingDing._useingInfo;
         var i:int = 0;
         while(i < this.grids.length)
         {
            gItem = this.grids[i];
            grid = gItem.grid;
            if(Boolean(gItem.visible) && Boolean(map[grid.vo.id]))
            {
               gItem.isEffect = true;
               grid.vo.isEffecting = true;
            }
            else
            {
               gItem.isEffect = false;
               grid.vo.isEffecting = false;
            }
            i += 1;
         }
      }
      
      private function mjItemClickHd(e:MouseEvent) : void
      {
         var maxFreeTimes:int;
         var mjTxt:String;
         var cost:int;
         var txt:String;
         var target:View_MiJiGrid = null;
         var vo:Vo_MiJi = null;
         if(SceneConfig.getSceneType() != SceneConfig.GMD)
         {
            return;
         }
         target = e.target as View_MiJiGrid;
         vo = target.vo as Vo_MiJi;
         if((target.parent as gridItem).isEffect)
         {
            UIManager.centerBroadcast.addMsg("您已使用该秘籍");
            return;
         }
         if(target.vo.freeCount > 0)
         {
            GuangMingDingCGMessage.CG_GMD_USE_MIJI(target._vo.id);
            return;
         }
         maxFreeTimes = vo.getMaxFreeTimes();
         mjTxt = "<font color=\'#33ff33\'>" + Data_lib.Gmd_mj[vo.id][Enum_guangMingDing.LIB_MJ_NAME] + "</font>";
         cost = int(Data_lib.Gmd_mj[vo.id][Enum_guangMingDing.LIB_MJ_MEMONYCOST]);
         txt = "{0}次免费次数已用完，继续使用{1}需要花费{2}元宝？";
         View_gmdUseMiJiPromt.instance.applyFun(LangConfig.reTxt(txt,maxFreeTimes,mjTxt,cost),function():void
         {
            if(target.vo.freeCount <= 0 && GameUnitManager.hero.money < Data_lib.Gmd_mj[vo.id][Enum_guangMingDing.LIB_MJ_MEMONYCOST])
            {
               UIManager.centerBroadcast.addMsg("元宝不足，请及时充值");
            }
            else
            {
               GuangMingDingCGMessage.CG_GMD_USE_MIJI(vo.id);
            }
         });
      }
      
      private function tiaoZhan(p:* = null) : void
      {
         var u:GameUnit = null;
         if(SceneConfig.getSceneType() != SceneConfig.GMD)
         {
            return;
         }
         if(Model_team.hasTeam())
         {
            if(!Model_team.isCap())
            {
               UIManager.centerBroadcast.addMsg("队长才能进行挑战");
               return;
            }
            if(Model_team.isAway() || Model_team.isOffLine())
            {
               UIManager.centerBroadcast.addMsg("所有队友在线并且跟随才能挑战");
               return;
            }
         }
         var now:int = getTimer();
         if(now - this._tzLast < 3000)
         {
            UIManager.centerBroadcast.addMsg("您的操作太频繁，请稍等片刻");
            return;
         }
         this._tzLast = now;
         var has:Boolean = false;
         var hero:Hero = GameUnitManager.hero;
         if(SceneConfig.GMD == SceneConfig.getSceneType())
         {
            for each(u in GameUnitManager.list)
            {
               if(u is Npc && (u as Npc).npcType == Enum_npc_type.GMD)
               {
                  Tween.stop(this.tmpObj);
                  this._uu = u as Npc;
                  this._uu.way = Util.getWay(hero.x,hero.y,this._uu.x,this._uu.y);
                  this._uu.show();
                  Tween.curTo(this._uu,800,{
                     "global_x":hero.global_x,
                     "global_y":hero.global_y
                  },this.onToComplete,this.onTweenFrame,Tween.SIN06);
                  has = true;
               }
            }
         }
         if(MapManager.isFubenFinish && Model_guangMingDing._floor != 100)
         {
            UIManager.centerBroadcast.addMsg("该层敌人已被消灭，请前往下一层挑战");
         }
      }
      
      private function onToComplete(u:Role) : void
      {
         GuangMingDingCGMessage.CG_GMD_BEGIN_CHALLENGE(this._uu.id);
      }
      
      private function onTweenFrame() : void
      {
         if(Boolean(this._u))
         {
            this._u.align();
         }
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 570;
         y = Global.stage.stageHeight - 370;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.gameUnit.magic.Effect;
import com.yiTian.manager.EffectManager;
import com.yiTian.manager.TipManager;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.guangMingDing.View_MiJiGrid;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

class gridItem extends Sprite
{
   
   public var grid:View_MiJiGrid;
   
   public var tf:MyTextField;
   
   private var eff:Effect;
   
   private var _isEffect:Boolean = false;
   
   public function gridItem()
   {
      super();
      this.grid = new View_MiJiGrid();
      this.grid.setBG(View_Grid.GRID_OPEN);
      addChild(this.grid);
      this.tf = ComponentUtil.getTextField("",this,{
         "x":18,
         "y":45,
         "color":16776977
      });
      this.tf.autoSize = TextFieldAutoSize.CENTER;
      this.grid.addEventListener(MouseEvent.MOUSE_MOVE,this.tipShow);
      this.grid.addEventListener(MouseEvent.ROLL_OUT,this.tipHide);
   }
   
   public function get isEffect() : Boolean
   {
      return this._isEffect;
   }
   
   public function set isEffect(v:Boolean) : void
   {
      if(v)
      {
         if(!this.eff)
         {
            this.eff = EffectManager.addEffect("35175",this.grid,2000,20,21,true);
         }
         this.grid.filters = Util.disabled;
      }
      else
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
         this.grid.filters = null;
      }
      this._isEffect = v;
   }
   
   public function tipShow(p:* = null) : void
   {
      TipManager.update(this.grid.vo);
   }
   
   public function tipHide(p:* = null) : void
   {
      TipManager.hide();
   }
}
