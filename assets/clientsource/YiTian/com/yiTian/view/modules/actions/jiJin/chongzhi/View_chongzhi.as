package com.yiTian.view.modules.actions.jiJin.chongzhi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_chongzhi extends Panel123
   {
      
      private var chongL:View_chongList;
      
      private var wuHunIt:View_wuHunItem;
      
      private var moneyTf:MyTextField;
      
      private var maskSp:Sprite;
      
      private var perTf:MyTextField;
      
      private var tfLvl:MyTextField;
      
      private var huangLStr:String;
      
      private var lockBtn:Button;
      
      private var unlockBtn:Button;
      
      private var maskSpr:Sprite;
      
      private var infoSpr:Sprite;
      
      private var tips:MyTextField;
      
      private var eff:Effect;
      
      private var _lvl:int;
      
      public var isCheAll:Boolean = false;
      
      public var isNeedAutoOpenCZ:Boolean;
      
      public function View_chongzhi()
      {
         super();
         regResource("lang/ch/JiJin_Imgs.swf","JiJin_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var ssBmp:Bitmap;
         var backspr:Sprite = null;
         var sst:String = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":887,
            "height":570
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":839,
            "height":520
         },Global.Img_Cdm);
         move = new Rectangle(0,0,881,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":853,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         backspr = new Sprite();
         addChild(backspr);
         backspr.buttonMode = true;
         ComponentUtil.setPropertie(backspr,{
            "x":33,
            "y":49
         });
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            sst = "Diamond_Bule";
            this.huangLStr = "蓝钻";
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            sst = "Diamond_Member";
            this.huangLStr = "官网";
         }
         else
         {
            this.huangLStr = "黄钻";
            sst = "Diamond_Yellow";
         }
         ComponentUtil.getBitmap(sst,backspr,{
            "x":0,
            "y":0
         },Global.JiJin_Imgsdm);
         backspr.addEventListener(MouseEvent.CLICK,this.linkToYellowDia);
         this.infoSpr = new Sprite();
         ComponentUtil.getBitmap("Back_Inf",this,{
            "x":224 + 41,
            "y":49
         },Global.JiJin_Imgsdm);
         this.tfLvl = ComponentUtil.getTextField("您当前的级别：00级",this.infoSpr,{
            "x":240 + 45,
            "y":70 + 5,
            "color":16770048,
            "size":12,
            "leading":0
         });
         this.moneyTf = ComponentUtil.getTextField("再充值xx元宝，您讲成为0级白金武魂，" + this.huangLStr + "用户充值打0.0折",this.infoSpr,{
            "x":240 + 45,
            "y":116 + 5,
            "color":16711538,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("注：充值同一账号全服有效（数据有延迟）",this.infoSpr,{
            "x":435 + 15,
            "y":70 + 5,
            "color":16760204,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("ProgressBack",this.infoSpr,{
            "x":241 + 45,
            "y":92 + 5
         },Global.JiJin_Imgsdm);
         ssBmp = ComponentUtil.getBitmap("Progress",this.infoSpr,{
            "x":263 + 45,
            "y":98 + 5
         },Global.JiJin_Imgsdm);
         this.maskSp = new Sprite();
         this.maskSp.graphics.beginFill(0,0);
         this.maskSp.graphics.drawRect(0,0,20,374);
         this.maskSp.graphics.endFill();
         addChild(this.maskSp);
         ComponentUtil.setPropertie(this.maskSp,{
            "x":263 + 45,
            "y":98 + 5
         });
         ssBmp.mask = this.maskSp;
         if(!this.eff)
         {
            this.eff = EffectManager.addEffect("35172",this.infoSpr,600,this.maskSp.x,this.maskSp.y + 3,true);
         }
         this.perTf = ComponentUtil.getTextField("1/10",this.infoSpr,{
            "x":430 - 164 + 45,
            "y":93 + 5,
            "color":16777215,
            "size":12,
            "leading":0,
            "realWidth":367,
            "align":TextAlign.CENTER
         });
         this.chongL = new View_chongList();
         this.chongL.x = 238 + 45 - 18;
         this.chongL.y = 139 + 11;
         addChild(this.chongL);
         this.wuHunIt = new View_wuHunItem();
         this.wuHunIt.x = 239 + 45 + 104;
         this.wuHunIt.y = 296 + 77;
         addChild(this.wuHunIt);
         ComponentUtil.getBitmap("Title_ChongZhi",this,{
            "x":363,
            "y":5
         },Global.JiJin_Imgsdm);
         this.maskSpr = new Sprite();
         this.addChild(this.infoSpr);
         this.addChild(this.maskSpr);
         ComponentUtil.getBitmap("Text_BJWH",this.maskSpr,{
            "x":331,
            "y":94
         },Global.JiJin_Imgsdm);
         this.lockBtn = ComponentUtil.getButton("","Button_VIP",this.maskSpr,{
            "x":668,
            "y":83,
            "textColor":16771436
         },Global.JiJin_Imgsdm);
         this.tips = ComponentUtil.getTextField("点击锁头隐藏充值",this.infoSpr,{
            "x":695,
            "y":75,
            "color":16770048,
            "size":12,
            "leading":0
         });
         this.unlockBtn = ComponentUtil.getButton("","Button_UnLock",this.infoSpr,{
            "x":795,
            "y":72
         },Global.JiJin_Imgsdm);
         this.lockBtn.callBack = function():void
         {
            if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
            {
               UIManager.bagPwdPutIn.visible = true;
            }
         };
         this.unlockBtn.callBack = function():void
         {
            var type:int = Model_bag.pwdLockState;
            if(type == Model_bag.PWD_STATE_UNLOCK_T)
            {
               View_Alert.show(LangConfig.getWord("20014",11),View_Alert.OK_CANCAL,function():void
               {
                  UIManager.bagPwdSetter.visible = true;
               },null,null,null,310,LangConfig.getWord("20017",11),LangConfig.getWord("20018",11),TextAlign.CENTER);
            }
            else if(type == Model_bag.PWD_STATE_UNLOCK_F)
            {
               View_Alert.show("是否隐藏充值信息?",View_Alert.OK_CANCAL,function():void
               {
                  BagCGMessage.CG_BAG_PWD_LOCK_UP();
               },null,null,null,310,LangConfig.getWord("29034",2),LangConfig.getWord("29035",2));
            }
            else if(type == Model_bag.PWD_STATE_LOCK_T)
            {
               UIManager.bagPwdPutIn.visible = true;
            }
         };
         TipManager.bind(this.unlockBtn,"点击锁头隐藏充值");
         if(GameUnitManager.hero.level < 30)
         {
            this.unlockBtn.visible = false;
            this.tips.visible = false;
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.refreshBtn);
         }
      }
      
      private function refreshBtn() : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            this.unlockBtn.visible = true;
            this.tips.visible = true;
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,this.refreshBtn);
         }
      }
      
      public function update(chongMo:int, lvl:int, statusArr:Array) : void
      {
         if(!visible)
         {
            this.visible = true;
         }
         this._lvl = lvl;
         if(this._lvl == 0)
         {
            this.tfLvl.htmlText = "您当前的级别：无";
         }
         else
         {
            this.tfLvl.htmlText = "您当前的级别：" + HtmlUtil.font(lvl + "级白金武魂。",FundMter.colorArr[lvl]);
         }
         this.wuHunIt.show(chongMo,statusArr,lvl);
         this.money = chongMo;
      }
      
      public function getAward(_index:int) : void
      {
         this.wuHunIt.getAward(_index);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            FundMter.isShowChongzhiIng = true;
            this.updateMIMA();
         }
         else
         {
            FundMter.isShowChongzhiIng = false;
         }
      }
      
      public function openCZ() : void
      {
         if(!this.isNeedAutoOpenCZ)
         {
            return;
         }
         this.chongL.buyItem(0);
         this.isNeedAutoOpenCZ = false;
      }
      
      private function linkToYellowDia(e:MouseEvent) : void
      {
         if(Global.pf == "qqgame" || Global.pf == Enum_SPStr.QQ3366)
         {
            View_hzTribute.sendType = "self";
            YellowDiaManager.buy();
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            navigateToURL(new URLRequest("http://pay.qq.com/qqvip/index2.0.shtml?aid=vip.youxi.webgame.YT.qplus"));
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf) || Enum_SPStr.isUnion(Global.pf))
         {
            if(Global.pf == "union-10042-16" && Global.pf == "union-10042-15")
            {
               navigateToURL(new URLRequest("http://pay.qq.com/qqvip/index2.0.shtml?aid=vip.youxi.webgame.YT.qplus"));
            }
            else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE)
            {
               View_hzTribute.sendType = "self";
               YellowDiaManager.buy();
            }
            else
            {
               navigateToURL(new URLRequest("http://pay.qq.com/qzone/index.shtml?aid=game100621282.yop&paytime=year"));
            }
         }
      }
      
      public function set money(value:int) : void
      {
         var maxNum:int = 0;
         var lvStr:int = 0;
         if(value >= 0 && value < 100000)
         {
            maxNum = 100000;
            lvStr = 1;
         }
         else if(value >= 100000 && value < 200000)
         {
            maxNum = 200000;
            lvStr = 2;
         }
         else if(value >= 200000 && value < 1000000)
         {
            maxNum = 1000000;
            lvStr = 3;
         }
         else
         {
            maxNum = 1000000;
            lvStr = 3;
         }
         var chaJia:int = maxNum - value;
         if(Boolean(this.maskSp))
         {
            this.maskSp.width = 374 * (value / maxNum >= 1 ? 1 : value / maxNum);
         }
         Tween.to(this.eff,200,{"px":[this.eff.px,this.maskSp.x + this.maskSp.width - 5]});
         if(Boolean(this.perTf))
         {
            this.perTf.text = value + "/" + maxNum;
         }
         if(Global.pf != Enum_SPStr.PENGYOU && Global.pf != Enum_SPStr.QZONE && Global.pf != Enum_SPStr.QQGAME && Global.pf != Enum_SPStr.QQ3366 && Enum_SPStr.isIwan(Global.pf) == false)
         {
            this.moneyTf.htmlText = "再充值" + chaJia + "元宝，您将成为" + HtmlUtil.font(lvStr + "级白金武魂。",FundMter.colorArr[lvStr]);
         }
         else
         {
            this.moneyTf.htmlText = "再充值" + chaJia + "元宝，您将成为" + HtmlUtil.font(lvStr + "级白金武魂",FundMter.colorArr[lvStr]) + "，" + this.huangLStr + "用户充值打8折";
         }
         if(value >= 1000000)
         {
            this.perTf.visible = false;
            this.moneyTf.htmlText = HtmlUtil.font("您已满级","#fe0000");
         }
      }
      
      public function updateMIMA() : void
      {
         var isLock:Boolean = false;
         isLock = Model_bag.pwdLockState == Model_bag.PWD_STATE_UNLOCK_T ? true : Model_bag.pwdLockState == Model_bag.PWD_STATE_UNLOCK_F;
         this.infoSpr.visible = isLock;
         this.maskSpr.visible = !isLock;
         this.wuHunIt.tfCheckTf.visible = isLock;
      }
   }
}

