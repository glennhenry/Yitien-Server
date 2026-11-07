package com.yiTian.view.modules.shenBing
{
   import com.ui.controls.Button;
   import com.ui.controls.MaskProgressBar;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ShenBingCGMessage;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_ShenBingPanel extends Panel123
   {
      
      private var _back:DisplayObject;
      
      private var _cardSlotGrids:Array = [];
      
      private var _cardSlotUpdateBtns:Array = [];
      
      private var _idleGrids:Array = [];
      
      private var _idleUpdateBtns:Array = [];
      
      private var _tfcuiLianInfo:MyTextField;
      
      private var _tfCurAtb:MyTextField;
      
      private var _pb:MaskProgressBar;
      
      private var _tfExp:MyTextField;
      
      private var _bmCurrentChuiLian:Bitmap2;
      
      private var _btnCuiLian:Button;
      
      private var _btnCuiLian2:Button;
      
      private var _btnAtb:Button;
      
      private var _tfNumStone:MyTextField;
      
      private var _btnSkillStore:Button;
      
      private var _tfIntroduce:MyTextField;
      
      private var _spItemCostIcon:Sprite;
      
      private var infoTps:Child_shenbingTipInfo;
      
      private var _tfCurAtb_Def:MyTextField;
      
      private var start:Number = 0;
      
      private var end:Number = 0;
      
      private var maxExp:int = 0;
      
      private var flag:Boolean = false;
      
      private var _oldLv:int;
      
      private var _twnObj:Object = {};
      
      private var _curWeaponLv:int = -1;
      
      private var weaponSp:Sprite = new Sprite();
      
      private var _bmWeapon:Bitmap2 = new Bitmap2();
      
      public function View_ShenBingPanel()
      {
         super();
         regResource("lang/ch/ShenBing.swf","ShenBingdm");
      }
      
      override protected function initUI2() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         var posArr:Array = null;
         var bmBar:Bitmap = null;
         var btn:Button = null;
         posArr = [47,75,47,187,47,294,305,75,305,187,305,294];
         this._back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":704,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("BG_SBD",this,{
            "x":24,
            "y":46,
            "alpha":0.9
         },Global.ShenBingdm);
         ComponentUtil.getBitmap("Title_SB",this,{
            "x":272,
            "y":5
         },Global.ShenBingdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":474,
            "y":119,
            "width":91,
            "height":21
         },Global.Img_Cdm);
         this._spItemCostIcon = new Sprite();
         this._spItemCostIcon.x = 432;
         this._spItemCostIcon.y = 112;
         addChild(this._spItemCostIcon);
         ComponentUtil.getBitmap("Ico_JNSP34",this._spItemCostIcon,null,Global.ShenBingdm);
         TipManager.bind(this._spItemCostIcon,"神兵技能碎片(<font color=\'#33ff33\'>华山祝福产出</font>)：可用来兑换和升级神兵技能");
         ComponentUtil.getBitmap("Icons_Prompt",this,{
            "x":384,
            "y":68
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":667,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getTextField("卡槽一",this,{
            "x":49,
            "y":125,
            "color":15856113
         });
         ComponentUtil.getTextField("卡槽二",this,{
            "x":49,
            "y":239,
            "color":15856113
         });
         ComponentUtil.getTextField("卡槽三",this,{
            "x":49,
            "y":344,
            "color":15856113
         });
         ComponentUtil.getTextField("卡槽四",this,{
            "x":308,
            "y":125,
            "color":15856113
         });
         ComponentUtil.getTextField("卡槽五",this,{
            "x":308,
            "y":239,
            "color":15856113
         });
         ComponentUtil.getTextField("卡槽六",this,{
            "x":308,
            "y":344,
            "color":15856113
         });
         addChild(this.weaponSp);
         this.weaponSp.x = 198;
         this.weaponSp.addChild(this._bmWeapon);
         ComponentUtil.getTextField("刻印后的技能才能发挥威力",this,{
            "x":413,
            "y":69,
            "color":15856113,
            "size":14
         });
         this._tfIntroduce = ComponentUtil.getTextField("",this,{
            "x":593,
            "y":69,
            "color":15788617,
            "size":14
         });
         this._tfIntroduce.mouseEnabled = true;
         this._tfIntroduce.htmlText = HtmlUtil.createLink("玩法介绍");
         TipManager.bind(this._tfIntroduce,ShenBingUtil.SB_INTRODUCE);
         ComponentUtil.getTextField("注：刻印的技能数量越多，技能触发的几率越大",this,{
            "x":391,
            "y":426,
            "color":15856113
         });
         ComponentUtil.getTextField("←拖动神兵至卡槽后刻印",this,{
            "x":440,
            "y":155,
            "size":14,
            "color":16777011
         });
         this._tfcuiLianInfo = ComponentUtil.getTextField("",this,{
            "x":153,
            "y":352
         });
         this._tfCurAtb = ComponentUtil.getTextField("",this,{
            "x":153,
            "y":370
         },"left");
         this._tfCurAtb_Def = ComponentUtil.getTextField("",this,{
            "x":193,
            "y":370
         },"left");
         this._tfCurAtb_Def.mouseEnabled = true;
         TipManager.bind(this._tfCurAtb_Def,"神兵技能加成属性");
         this._tfNumStone = ComponentUtil.getTextField("",this,{
            "x":516,
            "y":120
         },"center");
         move = new Rectangle(0,0,this._back.width,38);
         i = 0;
         while(i < posArr.length / 2)
         {
            grid = new View_Grid();
            grid.set_bmp_bg(View_Grid.GRID_SHENBING);
            grid.set_bmp_select(null);
            grid.type = Enum_type_grid.SHENBING_USEING_SKILL;
            grid.x = posArr[i * 2];
            grid.y = posArr[i * 2 + 1];
            grid.bmp_icon.x = -3;
            grid.bmp_icon.y = -4;
            addChild(grid);
            btn = ComponentUtil.getButton("","BT_SJ",this,{
               "x":grid.x + 33,
               "y":grid.y + 33,
               "callBack":this.updateSkillHd,
               "visible":false
            },Global.ShenBingdm);
            this._cardSlotGrids.push(grid);
            this._cardSlotUpdateBtns.push(btn);
            grid.addEventListener(MouseEvent.MOUSE_DOWN,this.gridMouseDownHandler);
            grid.addEventListener(MouseEvent.MOUSE_UP,this.gridMouseUpHandler);
            grid.tabIndex = i + 1;
            i += 1;
         }
         i = 0;
         while(i < 16)
         {
            grid = new View_Grid();
            grid.set_bmp_over();
            grid.set_bmp_bg();
            grid.set_bmp_select();
            grid.type = Enum_type_grid.SHENBING_IDLE_SKILL;
            grid.x = 424 + i % 4 * 50;
            grid.y = 192 + int(i / 4) * 46;
            addChild(grid);
            this._idleGrids.push(grid);
            grid.addEventListener(MouseEvent.MOUSE_DOWN,this.idleGridMouseDownHandler);
            grid.addEventListener(MouseEvent.MOUSE_UP,this.idleGridMouseUpHandler);
            grid.doubleClickEnabled = true;
            grid.addEventListener(MouseEvent.DOUBLE_CLICK,this.doubleClickHd);
            grid.tabIndex = i + 1;
            btn = ComponentUtil.getButton("","BT_SJ",this,{
               "x":grid.x + 20,
               "y":grid.y + 20,
               "callBack":this.updateSkillHd2,
               "visible":false
            },Global.ShenBingdm);
            this._idleUpdateBtns.push(btn);
            i += 1;
         }
         bmBar = ComponentUtil.getBitmap("BG_HT",null,null,Global.ShenBingdm);
         this._pb = new MaskProgressBar();
         this._pb.realWidth = 221;
         this._pb.x = 87;
         this._pb.y = 405;
         this._pb.bar = bmBar;
         this._pb.init();
         this._pb.persent = 0;
         addChild(this._pb);
         this._pb.addEventListener(MouseEvent.MOUSE_MOVE,this.pbMouseMoveHandler);
         this._pb.addEventListener(MouseEvent.ROLL_OUT,this.pbRollOutHandler);
         this._tfExp = ComponentUtil.getTextField("",this._pb,{
            "x":110,
            "y":-3,
            "color":16777011
         },TextFieldAutoSize.CENTER);
         this._btnAtb = ComponentUtil.getButton("","BT_Shu",this,{
            "x":285,
            "y":379,
            "textColor":16771436,
            "callBack":this.atbClickHd
         },Global.ShenBingdm);
         this._btnCuiLian = ComponentUtil.getButton("淬 炼","Button_RedFour",this,{
            "x":94,
            "y":424,
            "textColor":16771436,
            "callBack":this.cuiLianClickHd
         },Global.Img_Cdm);
         TipManager.bind(this._btnCuiLian,"普通淬炼需要消耗<font color=\'#33ff33\'>1</font>个玉牌(<font color=\'#33ff33\'>秘境产出</font>)");
         this._btnCuiLian2 = ComponentUtil.getButton("十倍淬炼","BT_OrangeFive",this,{
            "x":214,
            "y":424,
            "textColor":16771436,
            "callBack":this.cuiLian2ClickHd
         },Global.ShenBingdm);
         TipManager.bind(this._btnCuiLian2,"十倍淬炼需要消耗<font color=\'#33ff33\'>10</font>个玉牌(<font color=\'#33ff33\'>秘境产出</font>)");
         this._btnSkillStore = ComponentUtil.getButton("技能兑换","BT_DH",this,{
            "x":587,
            "y":118,
            "textColor":16771436,
            "callBack":this.btnSkillStoreClickHd
         },Global.ShenBingdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":this._back.width - 40,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         Global.control.registerCallBack(MSG_ShenBing.SHENBING_LV_CHANGE,this.shenBingLvHandler);
         Global.control.registerCallBack(MSG_ShenBing.CARDSLOT_CHANGE,this.cardSlotChangeHandler);
         Global.control.registerCallBack(MSG_ShenBing.IDLE_SKILL_CHANGE,this.updateBagSkills);
         this.cardSlotChangeHandler();
         this.updateBagSkills();
         this.shenBingLvHandler();
         this._btnAtb.addEventListener(MouseEvent.MOUSE_OVER,this.shenBingRollOverHandler);
         this._btnAtb.addEventListener(MouseEvent.ROLL_OUT,this.shenBingRollOutHandler);
         this.infoTps = new Child_shenbingTipInfo();
         ComponentUtil.setPropertie(this.infoTps,{
            "x":270,
            "y":360
         });
         this.addChild(this.infoTps);
      }
      
      protected function pbRollOutHandler(event:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      protected function pbMouseMoveHandler(event:MouseEvent) : void
      {
         var needExp:int = 0;
         if(Model_ShenBing._curLevel >= Data_lib.sbcl.getLength())
         {
            TipManager.update("<font color=\'#ffff33\'>您的神兵已满级</font>");
         }
         else
         {
            needExp = int(Data_lib.sbcl[Model_ShenBing._curLevel][Enum_ShenBing.SB_CUILIAN_EXP]);
            TipManager.update("<font color=\'#ffff33\'>神兵淬炼经验：" + Model_ShenBing._curExp.toString() + "/" + needExp + "</font>");
         }
      }
      
      protected function doubleClickHd(event:MouseEvent) : void
      {
      }
      
      private function atbClickHd(e:MouseEvent) : void
      {
      }
      
      private function cuiLianClickHd(e:MouseEvent) : void
      {
         if(Model_ShenBing._curLevel >= Data_lib.sbcl.getLength())
         {
            UIManager.centerBroadcast.addMsg("您的神兵已达到满级");
            return;
         }
         if(CommandManager.get_bag_count(ShenBingUtil.YUPAI_ID) >= 1)
         {
            ShenBingCGMessage.CG_CUILIAN(1,1);
         }
         else
         {
            View_Alert.show("<font color=\'#ffffff\'>您的<font color=\'#ffff33\'>玉牌</font>不足，是否前往<font color=\'#ffff33\'>秘境</font>获取</font>",View_Alert.OK_CANCAL,function():void
            {
               UIManager.sm_shop.visible = !UIManager.sm_shop.visible;
            });
         }
      }
      
      private function cuiLian2ClickHd(e:MouseEvent) : void
      {
         if(Model_ShenBing._curLevel >= Data_lib.sbcl.getLength())
         {
            UIManager.centerBroadcast.addMsg("您的神兵已达到满级");
            return;
         }
         if(CommandManager.get_bag_count(ShenBingUtil.YUPAI_ID) >= 10)
         {
            ShenBingCGMessage.CG_CUILIAN(1,2);
         }
         else
         {
            View_Alert.show("<font color=\'#ffffff\'>您的<font color=\'#ffff33\'>玉牌不足</font>，是否前往<font color=\'#ffff33\'>秘境</font>获取</font>",View_Alert.OK_CANCAL,function():void
            {
               UIManager.sm_shop.visible = !UIManager.sm_shop.visible;
            });
         }
      }
      
      protected function idleGridMouseUpHandler(event:MouseEvent) : void
      {
         if(!UIManager.isDrag)
         {
            return;
         }
         var srcGrid:View_Grid = UIManager.dragObj.grid;
         var curGrid:View_Grid = event.target as View_Grid;
         if(curGrid == srcGrid)
         {
            return;
         }
         if(Boolean(srcGrid) && Boolean(srcGrid.vo) && srcGrid.type == Enum_type_grid.SHENBING_USEING_SKILL)
         {
            ShenBingCGMessage.CG_SWAP_SKILL(2,srcGrid.tabIndex,curGrid.tabIndex);
         }
         else if(Boolean(srcGrid) && Boolean(srcGrid.vo) && srcGrid.type == Enum_type_grid.SHENBING_IDLE_SKILL)
         {
            ShenBingCGMessage.CG_SWAP_SKILL(4,srcGrid.tabIndex,curGrid.tabIndex);
         }
      }
      
      protected function idleGridMouseDownHandler(event:MouseEvent) : void
      {
         var target:View_Grid = event.target as View_Grid;
         if(Boolean(target) && Boolean(target.vo))
         {
            UIManager.startDrag(event);
         }
      }
      
      protected function gridMouseUpHandler(event:MouseEvent) : void
      {
         if(!UIManager.isDrag)
         {
            return;
         }
         var srcGrid:View_Grid = UIManager.dragObj.grid;
         var curGrid:View_Grid = event.target as View_Grid;
         if(curGrid == srcGrid)
         {
            return;
         }
         if(Boolean(srcGrid) && Boolean(srcGrid.vo) && srcGrid.type == Enum_type_grid.SHENBING_IDLE_SKILL)
         {
            if(curGrid.tabIndex > Model_ShenBing._cardSlotSkills.length)
            {
               UIManager.centerBroadcast.addMsg("该卡槽尚未激活，无法装备神兵技能");
            }
            else
            {
               ShenBingCGMessage.CG_SWAP_SKILL(1,srcGrid.tabIndex,curGrid.tabIndex);
            }
         }
         else if(Boolean(srcGrid) && Boolean(srcGrid.vo) && srcGrid.type == Enum_type_grid.SHENBING_USEING_SKILL)
         {
            if(curGrid.tabIndex > Model_ShenBing._cardSlotSkills.length)
            {
               UIManager.centerBroadcast.addMsg("该卡槽尚未激活，无法装备神兵技能");
            }
            else
            {
               ShenBingCGMessage.CG_SWAP_SKILL(3,srcGrid.tabIndex,curGrid.tabIndex);
            }
         }
      }
      
      protected function gridMouseDownHandler(event:MouseEvent) : void
      {
         var target:View_Grid = event.target as View_Grid;
         if(Boolean(target) && Boolean(target.vo))
         {
            UIManager.startDrag(event);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = value;
            this.updateNumStone();
            ShenBingCGMessage.CG_SHENBING();
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.updateNumStone);
            Global.control.registerCallBack(MSG_ShenBing.GRID_ENABLED,this.showGridEff);
            Global.control.registerCallBack(MSG_ShenBing.CUIRLIAN_LEVEL_UP,this.showCuiLianEff);
            this.updateWeapon();
            this.showGridEff();
            this.tweenWeapon();
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.updateNumStone);
            Global.control.removeCallBack(MSG_ShenBing.GRID_ENABLED,this.showGridEff);
            Global.control.removeCallBack(MSG_ShenBing.CUIRLIAN_LEVEL_UP,this.showCuiLianEff);
            Tween.stop(this.weaponSp);
            Model_specialD.visFalseComp(this,ShenBingUtil._tipBtn,this.superHide);
         }
      }
      
      private function superHide() : void
      {
         super.visible = false;
      }
      
      private function shenBingLvHandler() : void
      {
         this._tfcuiLianInfo.htmlText = LangConfig.reTxt("淬炼等级：<font color=\'#33ff33\'>{0}</font>",Model_ShenBing._curLevel);
         this.updateShenbingTip();
         if(Model_ShenBing._curLevel >= Data_lib.sbcl.getLength())
         {
            this._pb.persent = 1;
            this._tfExp.htmlText = "已满级";
         }
         else
         {
            this.maxExp = Data_lib.sbcl[Model_ShenBing._curLevel][Enum_ShenBing.SB_CUILIAN_EXP];
            this.start = this._pb.persent;
            this.end = Model_ShenBing._curExp / this.maxExp;
            if(this._oldLv < Model_ShenBing._curLevel)
            {
               this.end += 1;
            }
            if(this.flag)
            {
               Tween.to(this._twnObj,600,{"persent":[this.start,this.end]},this.twnCompleteFun,null,this.twnObjTickFun);
            }
            else
            {
               this._pb.persent = Model_ShenBing._curExp / this.maxExp;
            }
            this.flag = true;
            this._tfExp.htmlText = Model_ShenBing._curExp.toString() + "/" + this.maxExp;
         }
         this._oldLv = Model_ShenBing._curLevel;
      }
      
      private function twnCompleteFun() : void
      {
         this._tfExp.htmlText = Model_ShenBing._curExp.toString() + "/" + this.maxExp;
         this._pb.persent = Model_ShenBing._curExp / this.maxExp;
      }
      
      private function twnObjTickFun(p:Number) : void
      {
         var value:Number = this.start + Math.sin(p * Math.PI / 2) * (this.end - this.start);
         value %= 1;
         this._pb.persent = value;
      }
      
      private function shenBingRollOverHandler(e:MouseEvent) : void
      {
         var curTxt:Array = null;
         var nxtTxt:Array = null;
         var maxLv:int = int(Data_lib.sbcl.toArray().length);
         if(Model_ShenBing._curLevel == 0)
         {
            curTxt = ["没有附加属性"];
            nxtTxt = ShenBingUtil.explainAtbStrNxt(Data_lib.sbcl[Model_ShenBing._curLevel + 1][Enum_ShenBing.SB_CUILIAN_ATTRIBUTE]);
         }
         else
         {
            if(Model_ShenBing._curLevel > maxLv)
            {
               return;
            }
            curTxt = ShenBingUtil.explainAtbStrNxt(Data_lib.sbcl[Model_ShenBing._curLevel][Enum_ShenBing.SB_CUILIAN_ATTRIBUTE]);
            if(Model_ShenBing._curLevel == maxLv)
            {
               nxtTxt = ["<font color=\'#ff3333\'>神兵已满级</font>"];
            }
            else
            {
               nxtTxt = ShenBingUtil.explainAtbStrNxt(Data_lib.sbcl[Model_ShenBing._curLevel + 1][Enum_ShenBing.SB_CUILIAN_ATTRIBUTE]);
            }
         }
         TipManager.update(LangConfig.reTxt("<font size=\'12\'>当前神兵淬炼属性：</font>\n{0}\n<font size=\'12\'>下一级属性：</font>\n{1}",curTxt.join(" \n"),nxtTxt.join(" \n")));
      }
      
      private function shenBingRollOutHandler(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function updateShenbingTip() : void
      {
         var sbEf:Array = null;
         var temp:Array = null;
         if(Boolean(this._tfCurAtb))
         {
            sbEf = ShenBingUtil.explainAtbStr(Data_lib.sbcl[Model_ShenBing._curLevel][Enum_ShenBing.SB_CUILIAN_ATTRIBUTE],"{0}<font color=\'#33ff33\'>+{1}</font>");
            if(sbEf.length == 3)
            {
               temp = sbEf.pop();
               this._tfCurAtb_Def.htmlText = temp.join("\n");
            }
            this._tfCurAtb.htmlText = sbEf.join("\n");
            this._tfCurAtb.x = 230 - this._tfCurAtb.width - 60 / 3;
            this._tfCurAtb_Def.x = this._tfCurAtb.x + this._tfCurAtb.width;
         }
      }
      
      private function cardSlotChangeHandler() : void
      {
         var gridChangeEvent:Event = null;
         var vo:Vo_ShenBingSkill = null;
         var grid:View_Grid = null;
         if(Boolean(this.infoTps))
         {
            this.infoTps.updateTipInfo();
         }
         this.updateShenbingTip();
         var data:Array = Model_ShenBing._cardSlotSkills;
         if(data == null)
         {
            return;
         }
         gridChangeEvent = new Event(Event.CHANGE);
         var i:int = 0;
         while(i < data.length)
         {
            vo = data[i];
            grid = this._cardSlotGrids[i] as View_Grid;
            grid.removeEventListener(MouseEvent.ROLL_OVER,this.gridRollOverHd1);
            grid.removeEventListener(MouseEvent.ROLL_OVER,this.gridRollOverHd2);
            grid.removeEventListener(MouseEvent.ROLL_OUT,this.gridRollOutHd);
            if(vo != null && vo.id != 0)
            {
               grid.set_bmp_over(true,View_Grid.GRID_SHENBING_OVER);
               grid.set_bmp_bg(View_Grid.GRID_SHENBING);
               this._cardSlotUpdateBtns[i].visible = !vo.isMaxQuality();
               grid.vo = vo;
               grid.filters = ShenBingUtil.filterss[vo.quality];
               grid.dispatchEvent(gridChangeEvent);
            }
            else
            {
               grid.set_bmp_over(true,View_Grid.GRID_SHENBING_OVER);
               grid.set_bmp_bg(View_Grid.GRID_SHENBING);
               grid.vo = null;
               this._cardSlotUpdateBtns[i].visible = false;
               grid.addEventListener(MouseEvent.ROLL_OVER,this.gridRollOverHd1);
               grid.addEventListener(MouseEvent.ROLL_OUT,this.gridRollOutHd);
               grid.dispatchEvent(gridChangeEvent);
               grid.filters = null;
            }
            i += 1;
         }
         var j:int = i;
         while(j < this._cardSlotGrids.length)
         {
            grid = this._cardSlotGrids[j] as View_Grid;
            grid.set_bmp_bg(View_Grid.GRID_SHENBING_LOCK);
            grid.vo = null;
            this._cardSlotUpdateBtns[i].visible = false;
            grid.removeEventListener(MouseEvent.ROLL_OVER,this.gridRollOverHd1);
            grid.addEventListener(MouseEvent.ROLL_OVER,this.gridRollOverHd2);
            grid.addEventListener(MouseEvent.ROLL_OUT,this.gridRollOutHd);
            grid.dispatchEvent(gridChangeEvent);
            grid.filters = null;
            j += 1;
         }
         this.updateWeapon();
      }
      
      public function updateWeapon() : void
      {
         var weaponLv:int = Model_ShenBing.shenBingLv;
         if(this._curWeaponLv == weaponLv)
         {
            return;
         }
         if(weaponLv >= 0)
         {
            this._bmWeapon.load(ShenBingUtil.getWeaponURl(),1,this.bmCompleteHd);
         }
         this._curWeaponLv = weaponLv;
      }
      
      private function bmCompleteHd(opt:* = null) : void
      {
         this._bmWeapon.x = -this._bmWeapon.width / 2;
         this._bmWeapon.y = -this._bmWeapon.height / 2;
      }
      
      protected function gridRollOutHd(event:Event) : void
      {
         TipManager.hide();
      }
      
      protected function gridRollOverHd1(event:Event) : void
      {
         var p:Point = null;
         var target:DisplayObject = event.target as DisplayObject;
         TipManager.update(LangConfig.reTxt("激活状态：<font color=\'#ffff33\'>已激活"));
         p = target.localToGlobal(new Point(38,0));
         TipManager.view_tip.x = p.x;
         TipManager.view_tip.y = p.y;
      }
      
      protected function gridRollOverHd2(event:Event) : void
      {
         var target:DisplayObject = event.target as DisplayObject;
         var txt:String = ShenBingUtil.getConditionString(this._cardSlotGrids.indexOf(target));
         TipManager.update(LangConfig.reTxt("激活状态：<font color=\'#ff3333\'>未激活</font><br>开启条件：{0}",txt));
         var p:Point = target.localToGlobal(new Point(38,0));
         TipManager.view_tip.x = p.x;
         TipManager.view_tip.y = p.y;
      }
      
      private function updateBagSkills() : void
      {
         var gridChangeEvent:Event = null;
         var vo:Vo_ShenBingSkill = null;
         var grid:View_Grid = null;
         var btn:Button = null;
         var data:Array = Model_ShenBing._idleSkills;
         if(data == null)
         {
            return;
         }
         gridChangeEvent = new Event(Event.CHANGE);
         var i:int = 0;
         while(i < 16)
         {
            vo = data[i];
            grid = this._idleGrids[i] as View_Grid;
            grid.vo = vo;
            btn = this._idleUpdateBtns[i] as Button;
            btn.visible = grid.vo != null && !vo.isMaxQuality();
            grid.dispatchEvent(gridChangeEvent);
            i += 1;
         }
      }
      
      private function updateSkillHd(e:MouseEvent) : void
      {
         var index:int = this._cardSlotUpdateBtns.indexOf(e.target);
         var targetGrid:View_Grid = this._cardSlotGrids[index];
         ShenBingUtil.askOpenUpdateView(targetGrid);
      }
      
      private function updateSkillHd2(e:MouseEvent) : void
      {
         var index:int = this._idleUpdateBtns.indexOf(e.target);
         var targetGrid:View_Grid = this._idleGrids[index];
         if(Boolean(Model_ShenBing._cardSlotSkills))
         {
            ShenBingUtil.askOpenUpdateView(targetGrid);
         }
      }
      
      private function btnSkillStoreClickHd(e:MouseEvent) : void
      {
         ShenBingUtil.askOpenSkillStore();
      }
      
      private function updateNumStone() : void
      {
         var num:int = CommandManager.get_bag_count(ShenBingUtil.SHENBING_CHIP_ID);
         this._tfNumStone.text = "×" + num.toString();
      }
      
      override public function get width() : Number
      {
         return this._back.width;
      }
      
      override public function get height() : Number
      {
         return this._back.height;
      }
      
      public function show(prm:* = null) : void
      {
         this.visible = true;
      }
      
      public function hide(prm:* = null) : void
      {
         this.visible = false;
      }
      
      private function tweenWeapon() : void
      {
         Tween.to(this.weaponSp,4000,{"y":[210,225]},this.tweenWeapon,null,this.twnEasingFun);
      }
      
      private function twnEasingFun(p:Number) : Number
      {
         return Math.sin(p * Math.PI * 2);
      }
      
      public function showGridEff() : void
      {
         var index:int = 0;
         var targetGrid:View_Grid = null;
         var arr:Array = Model_ShenBing._enabledGridIndexs;
         for each(index in arr)
         {
            targetGrid = this._cardSlotGrids[index - 1];
            if(Boolean(targetGrid))
            {
               EffectManager.addEffect("35076",targetGrid,1500,-28,-28);
               UIManager.centerBroadcast.addMsg(LangConfig.reTxt("恭喜你开启了第{0}个神兵卡槽",index),1);
            }
         }
         arr.splice(0);
      }
      
      public function showCuiLianEff() : void
      {
         var effBm:Bitmap = new Bitmap();
         var effBmd:BitmapData = new BitmapData(this._btnAtb.width,this._btnAtb.height,true,0);
         effBmd.draw(this._btnAtb);
         this._btnAtb.addChild(effBm);
         effBm.bitmapData = effBmd;
         Tween.to(effBm,1000,{
            "alpha":[1,0],
            "x":[0,-effBm.width / 2],
            "y":[0,-effBm.height / 2],
            "scaleX":[1,2],
            "scaleY":[1,2]
         },this.effBmComplete);
      }
      
      private function effBmComplete(bm:Bitmap) : void
      {
         bm.scaleX = bm.scaleY = 1;
         bm.x = bm.y = 0;
         bm.alpha = 0;
         bm.bitmapData.dispose();
         bm.parent.removeChild(bm);
      }
   }
}

