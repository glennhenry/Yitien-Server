package com.yiTian.view.modules.guaji
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_GuaJi;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.CountStandTimeManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GuaJiCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.guangMingDing.Model_guangMingDing;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_guajiPanel extends Panel
   {
      
      private var titleBg:Bitmap;
      
      private var tf_tile:MyTextField;
      
      private var tf_gainExp:MyTextField;
      
      private var tf_timeCount:MyTextField;
      
      private var tf_expPercent:MyTextField;
      
      private var tf_lingqiPercent:MyTextField;
      
      private var btn_qysx:Button;
      
      private var btn_lqqd:Button;
      
      private var btn_lwjh:Button;
      
      private var sc_starTime:Child_starContainer;
      
      private var _gainExp:uint;
      
      private var _timeCount:uint;
      
      private var _expPercent:uint;
      
      private var _lingqiPercent:uint;
      
      private var _starTime:uint;
      
      private var _tip:MyTextField;
      
      private var bm:Bitmap;
      
      private var _runner:MovieClip;
      
      private var jydEffContainer:Sprite;
      
      private var jydEff:Effect;
      
      public function View_guajiPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var backGround:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":313,
            "height":280
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":265,
            "height":230
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":170,
            "width":255,
            "height":95
         },Global.Img_Cdm);
         move = new Rectangle(0,0,280,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":279,
            "y":6
         },Global.Img_Cdm);
         this.tf_tile = ComponentUtil.getTextField("",this,{
            "x":102,
            "y":49,
            "color":16711935
         });
         this.tf_gainExp = ComponentUtil.getTextField(LangConfig.getWord("21102",2),this,{
            "x":102,
            "y":71,
            "color":16776960
         });
         this.tf_timeCount = ComponentUtil.getTextField(LangConfig.getWord("21103",2),this,{
            "x":102,
            "y":90,
            "color":16776960
         });
         this.tf_expPercent = ComponentUtil.getTextField(LangConfig.getWord("21104",2),this,{
            "x":34,
            "y":114,
            "color":14662240
         });
         this.tf_lingqiPercent = ComponentUtil.getTextField(LangConfig.getWord("21105",2),this,{
            "x":34,
            "y":142,
            "color":1466224
         });
         this.btn_qysx = ComponentUtil.getButton(LangConfig.getWord("21106",2),"Button_Four",this,{
            "x":204,
            "y":111,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_lqqd = ComponentUtil.getButton(LangConfig.getWord("21107",2),"Button_Four",this,{
            "x":204,
            "y":139,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_lwjh = ComponentUtil.getButton(LangConfig.getWord("21108",2),"Button_Orange",this,{
            "x":204,
            "y":178,
            "textColor":16184781
         },Global.Img_Cdm);
         this._tip = ComponentUtil.getTextField("",this,{
            "x":34,
            "y":208,
            "color":14662240,
            "realWidth":250,
            "wordWrap":true
         });
         this._tip.leading = 2;
         this._tip.multiline = true;
         this._tip.htmlText = LangConfig.getWord("21101",2);
         this.sc_starTime = new Child_starContainer();
         this.sc_starTime.x = 45;
         this.sc_starTime.y = 180;
         addChild(this.sc_starTime);
         this.jydEffContainer = new Sprite();
         addChild(this.jydEffContainer);
         this.jydEffContainer.addEventListener(MouseEvent.MOUSE_MOVE,this.jydMoveHd);
         this.jydEffContainer.addEventListener(MouseEvent.ROLL_OUT,this.jydOutHd);
         this.bm = new Bitmap();
         this.bm.x = 24;
         this.bm.y = 43;
         this.jydEffContainer.addChild(this.bm);
      }
      
      private function jydMoveHd(e:MouseEvent) : void
      {
         var mdl:Model_guajiInfo = Model_guajiInfo.getInstance();
         TipManager.update(mdl.getRealGJDTipStr());
      }
      
      private function jydOutHd(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      override protected function initDynamicView() : void
      {
         this.btn_qysx.callBack = this.qysxClickHandle;
         this.btn_lqqd.callBack = this.lqqdClickHandle;
         this.btn_lwjh.callBack = this.lwjhClickHandle;
         CloseButton.addEventListener(MouseEvent.CLICK,this.closeBtnClickHandle);
         bAutoRemove = false;
         Global.control.registerCallBack(Enum_MsgType.MSG_GUAJIA,this.requestGJ);
         Global.control.registerCallBack(Enum_MsgType.MSG_CANCELGJ,this.cancelGJ);
      }
      
      private function requestGJ(param:Object) : void
      {
         var hero:Hero = GameUnitManager.hero;
         if(hero.status != Status.NOMAL)
         {
            return;
         }
         if(UIManager.npcDialog.visible)
         {
            return;
         }
         if(hero.level < 30)
         {
            return;
         }
         if(hero.action == Action.RUN)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29204",2));
            return;
         }
         if(GameUnitManager.hero.status != Status.SIT && !Model_guangMingDing.isTeamShow)
         {
            if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
            {
               return;
            }
            if(SceneConfig.getSceneType() == SceneConfig.HUANGBANG)
            {
               return;
            }
            if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
            {
               return;
            }
            if(SceneConfig.getSceneType() != SceneConfig.COMMON)
            {
               CountStandTimeManager.reset();
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29205",2));
               return;
            }
            GuaJiCGMessage.CG_GUAJI_REQUEST();
         }
      }
      
      private function cancelGJ(param:Object) : void
      {
         var sxType:int = 0;
         sxType = Model_guajiInfo.getInstance().sxType;
         if(sxType == 1 && GameUnitManager.hero.lqColor == 0)
         {
            GuaJiCGMessage.CG_GUAJI_CANCEL("");
            return;
         }
         if(Model_team.teamMumberInfo_data_save.length <= 0)
         {
            View_Alert.show(LangConfig.getWord("21109",2),View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
            {
               if(sxType == 3 || sxType == 4)
               {
                  GuaJiCGMessage.CG_GUAJI_CANCEL(Model_guajiInfo.getInstance().currentSXName);
               }
               else
               {
                  GuaJiCGMessage.CG_GUAJI_CANCEL("");
               }
            });
            return;
         }
         if(sxType == 1 || sxType == 2)
         {
            GuaJiCGMessage.CG_GUAJI_CANCEL("");
         }
         else if(sxType == 3 || sxType == 4)
         {
            GuaJiCGMessage.CG_GUAJI_CANCEL(Model_guajiInfo.getInstance().currentSXName);
         }
      }
      
      public function cancel(evt:MouseEvent = null) : void
      {
         var sxType:int = Model_guajiInfo.getInstance().sxType;
         if(sxType == 1 || sxType == 2)
         {
            GuaJiCGMessage.CG_GUAJI_CANCEL("");
         }
         else if(sxType == 3 || sxType == 4)
         {
            GuaJiCGMessage.CG_GUAJI_CANCEL(Model_guajiInfo.getInstance().currentSXName);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 310) / 2 + 250;
         y = (Global.stage.stageHeight - 280) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.GuaJi_Imgsdm)
            {
               this.load();
            }
            else
            {
               if(!this.titleBg)
               {
                  this.sourceComplete();
               }
               this.tryPlayRunner();
            }
            Model_guajiInfo.getInstance().updateGJDBuff();
         }
         else
         {
            if(Boolean(this.jydEff))
            {
               EffectManager.removeEffect(this.jydEff);
               this.jydEff = null;
            }
            this.tryStopRunner();
         }
         Model_guajiInfo.getInstance().upGJDBuffFilters();
      }
      
      private function tryPlayRunner() : void
      {
         if(GameUnitManager.hero.level >= 40)
         {
            if(this._runner == null)
            {
               this._runner = ComponentUtil.getDisplayObject("huxianmc",this,{
                  "x":250,
                  "y":260
               },Global.GuaJi_Imgsdm) as MovieClip;
               this._runner.addEventListener(MouseEvent.CLICK,this.kpClickHander);
               this._runner.buttonMode = true;
               addChild(this._runner);
            }
            this._runner.play();
         }
      }
      
      private function tryStopRunner() : void
      {
         if(this._runner != null)
         {
            this._runner.stop();
         }
      }
      
      private function kpClickHander(e:MouseEvent) : void
      {
         KuPaoUtil.askOpenGuidePnl();
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_GuaJi.GUAJISOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         if(Boolean(info))
         {
            Global.GuaJi_Imgsdm = info.applicationDomain;
         }
         this.titleBg = ComponentUtil.getBitmap("Title_GuaJi",this,{
            "x":76,
            "y":5
         },Global.GuaJi_Imgsdm);
         this.bm.bitmapData = ComponentUtil.getBitmapData("jydbuffbg",Global.GuaJi_Imgsdm);
         this.tryPlayRunner();
      }
      
      public function set btnEnabled(value:Boolean) : void
      {
         this.btn_qysx.enabled = value;
         this.btn_lqqd.enabled = value;
         this.btn_lwjh.enabled = value;
      }
      
      public function set gainExp(value:uint) : void
      {
         var strTitle:String = null;
         this._gainExp = value;
         if(Global.pf == "qqgame")
         {
            if(GameUnitManager.hero.ylDiaLvl > 0)
            {
               strTitle = LangConfig.getWord("29407",2) + "(" + LangConfig.getWord("60135",6) + LangConfig.getWord("29409",2) + "10%)";
            }
            else
            {
               strTitle = LangConfig.getWord("29407",2) + "(" + LangConfig.getWord("60136",6) + LangConfig.getWord("29409",2) + "8%)";
            }
         }
         else if(Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG)
         {
            strTitle = LangConfig.getWord("29407",2) + "(" + LangConfig.getWord("60137",6) + LangConfig.getWord("29409",2) + "10%)";
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            strTitle = LangConfig.getWord("29407",2) + "(" + LangConfig.getWord("60138",6) + LangConfig.getWord("29409",2) + "10%)";
         }
         else if(Enum_SPStr.isUnion(Global.pf))
         {
            strTitle = LangConfig.getWord("29407",2);
         }
         else if(Global.pf == Enum_SPStr.QQ3366)
         {
            if(GameUnitManager.hero.ylDiaLvl > 0 || GameUnitManager.hero.superLan > 0)
            {
               strTitle = LangConfig.getWord("29407",2) + "(" + LangConfig.getWord("60135",6) + LangConfig.getWord("29409",2) + "10%)";
            }
            else
            {
               strTitle = LangConfig.getWord("29407",2) + "(" + "3366" + LangConfig.getWord("29409",2) + "8%)";
            }
         }
         else if(Global.pf == Enum_SPStr.CHITU)
         {
            strTitle = LangConfig.getWord("29407",2) + "(" + "盒子用户" + LangConfig.getWord("29409",2) + "8%)";
         }
         else
         {
            strTitle = LangConfig.getWord("29407",2);
         }
         this.tf_gainExp.htmlText = LangConfig.getWord("21102",2,value.toString());
         this.tf_tile.htmlText = strTitle;
      }
      
      public function get gainExp() : uint
      {
         return this._gainExp;
      }
      
      public function set timeCount(value:uint) : void
      {
         this._timeCount = value;
         var str_time:String = this.formToTimeString(value);
         var str_timeCount:String = LangConfig.getWord("21103",2,str_time);
         this.tf_timeCount.htmlText = HtmlUtil.font(str_timeCount,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
      }
      
      public function get timeCount() : uint
      {
         return this._timeCount;
      }
      
      public function setGjdType(v:int = -1) : void
      {
         if(v == -1 && Boolean(this.jydEff))
         {
            EffectManager.removeEffect(this.jydEff);
            this.jydEff = null;
            return;
         }
         if(Boolean(this.jydEff))
         {
            EffectManager.removeEffect(this.jydEff);
         }
         var arr:Array = [35115,35116,35117,35118,35119];
         var id:int = int(arr[v]);
         this.jydEff = EffectManager.addEffect(id.toString(),this.jydEffContainer,2000,65,90,true);
      }
      
      public function set expPercent(value:uint) : void
      {
         this._expPercent = value;
         this.tf_expPercent.htmlText = HtmlUtil.font(LangConfig.getWord("21104",2),ColorConstant.getColorStr(ColorConstant.GREEN),12) + HtmlUtil.font(value.toString() + "%",ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
      }
      
      public function get expPercent() : uint
      {
         return this._expPercent;
      }
      
      public function set lingqiPercent(value:uint) : void
      {
         this._lingqiPercent = value;
         this.tf_lingqiPercent.htmlText = HtmlUtil.font(LangConfig.getWord("21105",2),ColorConstant.getColorStr(ColorConstant.BLUE),12) + HtmlUtil.font(value.toString() + "%",ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
      }
      
      public function get lingqiPercent() : uint
      {
         return this._lingqiPercent;
      }
      
      public function set starTime(value:uint) : void
      {
         this._starTime = value;
         var count:Number = value / 900;
         this.sc_starTime.value = count;
      }
      
      private function closeBtnClickHandle(evt:MouseEvent) : void
      {
         this.cancelGJ(null);
      }
      
      private function qysxClickHandle(evt:MouseEvent) : void
      {
         if(Model_guajiInfo.getInstance().sxType == 1)
         {
            UIManager.qysxPanel.visible = true;
            GuaJiCGMessage.CG_GUAJI_OTHERROLE_INFO(2);
         }
         else
         {
            UIManager.qysxExpInfoPanel.visible = true;
         }
      }
      
      private function lqqdClickHandle(evt:MouseEvent) : void
      {
         GuaJiCGMessage.CG_GUAJI_OTHERROLE_INFO(1);
      }
      
      private function lwjhClickHandle(evt:MouseEvent) : void
      {
         if(this._starTime >= 900)
         {
            GuaJiCGMessage.GC_GET_XINGXINGEXP();
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("21110",2));
         }
      }
      
      private function getRoundMin(min:Number, round:Number = 0.9) : uint
      {
         var intSecond:int = int(min);
         var sub:Number = min - intSecond;
         if(sub < round)
         {
            return intSecond;
         }
         return intSecond + 1;
      }
      
      private function formToTimeString(_time:Number, _insertHout:String = null, _insertMinute:String = null) : String
      {
         if(_insertHout == null)
         {
            _insertHout = " " + LangConfig.getWord("10450",1) + " ";
         }
         if(_insertMinute == null)
         {
            _insertMinute = " " + LangConfig.getWord("10451",1);
         }
         var _hour:uint = uint(_time / 60 / 60 >> 0);
         var _minute:uint = this.getRoundMin(_time / 60) % 60;
         var _timeTxt:String = " ";
         _timeTxt += (_hour > 100 ? _hour.toString() : (100 + _hour).toString().substr(1)) + _insertHout;
         return _timeTxt + ((_minute < 10 ? "0" + _minute.toString() : _minute.toString()) + _insertMinute);
      }
   }
}

