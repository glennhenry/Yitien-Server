package com.yiTian.view.modules.huangzuanchongwu
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.HuangZuanCWCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class View_hzcwPanel extends Panel123
   {
      
      private static var _instance:View_hzcwPanel;
      
      private var _childGrid:Child_grid;
      
      private var _exchangeBtn:Button;
      
      private var Button_Open:Button;
      
      private var Button_OpenYear:Button;
      
      private var _getedTF:MyTextField;
      
      private var closeBtn:Button;
      
      private var _choujiangBtn:Button;
      
      private var _curAwardIndex:int;
      
      private var _availibleTF:MyTextField;
      
      private var spImg:Sprite;
      
      private var itemId:int = 45542;
      
      private var modelMc:MovieClip;
      
      private var _init:Boolean = false;
      
      private var _vo:Model_hzcw;
      
      private var _isUpdate:Boolean = false;
      
      public function View_hzcwPanel()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/HZCW.swf","HZCWdm");
      }
      
      public static function get instance() : View_hzcwPanel
      {
         if(!_instance)
         {
            _instance = new View_hzcwPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var des1:MyTextField;
         var des:MyTextField;
         var cwTF:MyTextField;
         var btnStr1:String = null;
         var btnStr2:String = null;
         move = new Rectangle(0,0,682,38);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":682,
            "height":550
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":632,
            "height":500
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":608,
            "height":442
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Title_HZCW",this,{
            "x":261,
            "y":5
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Light_HZCW",this,{
            "x":37,
            "y":371
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Back_CJD",this,{
            "x":44,
            "y":59
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Back_CWXX",this,{
            "x":379,
            "y":52
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Text_CWXX",this,{
            "x":419,
            "y":59
         },Global.HZCWdm);
         ComponentUtil.getTextField("活动详情：全服累计最多抽取50000次，抽完活动自动关闭。",this,{
            "x":44,
            "y":409,
            "color":16711680,
            "size":14,
            "leading":0,
            "bold":true
         });
         des1 = ComponentUtil.getTextField("",this,{
            "x":433,
            "y":363,
            "color":16772287,
            "size":12,
            "leading":2
         });
         des1.htmlText = "<font color=\'#FFECBF\'>续费12次可兑换<font color=\'#00ff00\'>奶嘴龙变身卡</font></font>";
         des = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":435,
            "color":16777215,
            "size":12,
            "leading":3
         });
         des.htmlText = "<font color=\'#ffffff\'>1.在本界面开通或给好友开通【黄钻】特权，每次续费可获得一次抽取机会每次活动最多只能获得<font color=\'#FFCD2E\'>12次</font>抽取机会;";
         ComponentUtil.getTextField("2.续费成功后，请关闭界面再次打开，避免抽取次数不增加;",this,{
            "x":44,
            "y":452,
            "color":16777215,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField("3.微信支付暂时无法获得抽取机会。",this,{
            "x":44,
            "y":469,
            "color":16777215,
            "size":12,
            "leading":3
         });
         this._availibleTF = ComponentUtil.getTextField("可抽取次数：00次",this,{
            "x":160,
            "y":252,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":54,
            "y":69
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":135,
            "y":69
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":216,
            "y":69
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":297,
            "y":69
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":297,
            "y":150
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":297,
            "y":231
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":297,
            "y":312
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":216,
            "y":312
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":135,
            "y":312
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":54,
            "y":312
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":54,
            "y":231
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Grid_XZJZ",this,{
            "x":54,
            "y":150
         },Global.HZCWdm);
         ComponentUtil.getBitmap("Back_HZMaoPao",this,{
            "x":550,
            "y":110
         },Global.HZCWdm);
         cwTF = ComponentUtil.getTextField("",this,{
            "x":564,
            "y":117,
            "color":16777215,
            "size":12,
            "leading":3,
            "realWidth":180
         });
         cwTF.wordWrap = true;
         cwTF.multiline = true;
         cwTF.htmlText = "<font color=\'#f4cd31\' size = \'11\'>宠物</font><font color=\'#00CC00\'>基础攻击</font><font color=\'#F9FF00\'>+8%</font><br/><font color=\'#f4cd31\'>宠物</font><font color=\'#00CC00\'>基础防御</font><font color=\'#F9FF00\'>+8%</font><br/><font color=\'#f4cd31\'>宠物</font><font color=\'#00CC00\'>基础气血</font><font color=\'#F9FF00\'>+8%</font>";
         this._childGrid = new Child_grid();
         addChild(this._childGrid);
         ComponentUtil.setPropertie(this._childGrid,{
            "x":60,
            "y":83
         });
         this._exchangeBtn = ComponentUtil.getButton("","Button_HZCWDH",this,{
            "x":473,
            "y":335,
            "textColor":16771436,
            "callBack":this.exchangeFunc
         },Global.HZCWdm);
         this._choujiangBtn = ComponentUtil.getButton("","Button_HZCJ",this,{
            "x":154,
            "y":190,
            "textColor":16771436,
            "callBack":this.choujiangFunc
         },Global.HZCWdm);
         if(GameUnitManager.hero.huangZuanLvl > 0)
         {
            btnStr1 = "Button_XFHZ";
         }
         else
         {
            btnStr1 = "Button_KTHZ";
         }
         btnStr2 = "Button_HYKT";
         this.Button_Open = ComponentUtil.getButton("",btnStr1,this,{
            "x":177,
            "y":499,
            "textColor":16383744
         },ComponentUtil.domain);
         this.Button_OpenYear = ComponentUtil.getButton("",btnStr2,this,{
            "x":382,
            "y":499,
            "textColor":13434624
         },ComponentUtil.domain);
         this.setMouseOverOut(this.Button_Open);
         this.setMouseOverOut(this.Button_OpenYear);
         this.Button_Open.addEventListener(MouseEvent.CLICK,function():void
         {
            if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU)
            {
               View_hzTribute.sendType = "self";
               YellowDiaManager.buy(false,true,"UM121217191323351");
            }
         });
         this.Button_OpenYear.addEventListener(MouseEvent.CLICK,function():void
         {
            if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU)
            {
               View_hzTribute.sendType = "send";
               YellowDiaManager.buy(false,true,"UM121217191323351");
            }
         });
         this.playImg();
         this._getedTF = ComponentUtil.getTextField("",this,{
            "x":433,
            "y":379,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this._getedTF.htmlText = "已抽取：0次";
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":647,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.closeBtn.callBack = this.closeMenu;
         this._init = true;
         if(this._init && Boolean(this._vo))
         {
            this.update(this._vo.availibleCount,this._vo.getedCount,this._vo.status,this._vo.awardStr);
         }
      }
      
      public function setMouseOverOut(btn:Button) : void
      {
         btn.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
         {
            e.target.filters = Util.glowFFFFFF;
         });
         btn.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
         {
            e.target.filters = [];
         });
      }
      
      public function update(availibleTimes:int, getedTime:int, status:int, awardStr:String) : void
      {
         this._vo = new Model_hzcw();
         this._vo.availibleCount = availibleTimes;
         this._vo.getedCount = getedTime;
         this._vo.status = status;
         this._vo.awardStr = awardStr;
         if(!this._init)
         {
            return;
         }
         if(availibleTimes > 0)
         {
            this._choujiangBtn.enabled = true;
         }
         else
         {
            this._choujiangBtn.enabled = false;
         }
         this.updateTips(status);
         this.getedTimes(getedTime,availibleTimes);
         this.updateGridStatus();
         this._isUpdate = true;
         this.visible = true;
      }
      
      private function updateGridStatus() : void
      {
         var arr:Array = null;
         var i:int = 0;
         var idx:int = 0;
         if(Boolean(this._vo))
         {
            if(Boolean(this._vo.awardStr) && this._vo.awardStr != "-1")
            {
               arr = this._vo.awardStr.split(",");
               i = 0;
               while(i < arr.length)
               {
                  idx = int(arr[i]) + 1;
                  this._curAwardIndex = Data_lib.hzcw[idx][2];
                  this._childGrid.gridStatus = this._curAwardIndex - 1;
                  i++;
               }
            }
         }
      }
      
      private function exchangeFunc(e:MouseEvent) : void
      {
         if(Boolean(this._vo) && this._vo.status == 0)
         {
            UIManager.centerBroadcast.addMsg("未达兑换条件");
            return;
         }
         HuangZuanCWCGMessage.CG_HZCW_DUIHUAN();
      }
      
      private function choujiangFunc(e:MouseEvent) : void
      {
         HuangZuanCWCGMessage.CG_HZCW_CHOUJIANG();
      }
      
      public function getAward() : void
      {
         this._childGrid.getAward(this._curAwardIndex - 1);
         if(this._vo.availibleCount > 0)
         {
            this._choujiangBtn.enabled = true;
         }
         else
         {
            this._choujiangBtn.enabled = false;
         }
      }
      
      public function run(itemIndex:int, func:Function) : void
      {
         this._curAwardIndex = Data_lib.hzcw[itemIndex + 1][2];
         if(Boolean(this._vo))
         {
            --this._vo.availibleCount;
            ++this._vo.getedCount;
            this.getedTimes(this._vo.getedCount,this._vo.availibleCount);
            this._choujiangBtn.enabled = false;
         }
         this._childGrid.beginMove(this._curAwardIndex,func);
      }
      
      private function closeMenu(e:*) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(Boolean(this.modelMc))
            {
               this.modelMc.play();
            }
            if(this._isUpdate)
            {
               super.visible = value;
               return;
            }
            HuangZuanCWCGMessage.CG_HZCW_SHOWPANEL();
         }
         else
         {
            if(Boolean(this.modelMc))
            {
               this.modelMc.stop();
            }
            super.visible = value;
            this._isUpdate = false;
         }
      }
      
      private function updateTips(status:int) : void
      {
         var tips:String = "";
         if(status == 1)
         {
            this._exchangeBtn.enabled = true;
            this._exchangeBtn.filters = [];
            tips = "<font color=\'#ff0000\'>可领取</font>";
         }
         else if(status == 0)
         {
            this._exchangeBtn.enabled = true;
            this._exchangeBtn.filters = Util.disabled;
            tips = "<font color=\'#ff0000\'>请续费满12次领取</font>";
         }
         else if(status == 2)
         {
            this._exchangeBtn.enabled = false;
            this._exchangeBtn.filters = [];
         }
         TipManager.bind(this._exchangeBtn,tips);
      }
      
      private function playImg() : void
      {
         if(!this.spImg)
         {
            this.spImg = new Sprite();
            addChild(this.spImg);
            this.spImg.x = 460;
            this.spImg.y = 182;
            this.spImg.addEventListener(MouseEvent.MOUSE_OVER,this.onHint);
            this.spImg.addEventListener(MouseEvent.MOUSE_OUT,this.removeHint);
         }
         var cl:Class = Global.HZCWdm.getDefinition("Model") as Class;
         this.modelMc = new cl() as MovieClip;
         this.spImg.addChild(this.modelMc);
         this.modelMc.play();
      }
      
      private function onHint(e:MouseEvent) : void
      {
         var point:Point = null;
         var vo:Vo_item = null;
         if(Boolean(this.spImg))
         {
            point = this.localToGlobal(new Point(this.spImg.x,this.spImg.y));
            vo = new Vo_item();
            vo.id = this.itemId;
            vo.Init_lib();
            TipManager.update(vo);
            TipManager.view_tip.x = point.x + this.spImg.height / 2;
            TipManager.view_tip.y = point.y + this.spImg.width / 2;
         }
      }
      
      private function removeHint(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function getedTimes(times:int, avaiCount:int) : void
      {
         this._getedTF.htmlText = "<font color=\'#FFECBF\'>已抽取：<font color=\'#FFCD2E\'>" + times + "</font>次</font>";
         this._availibleTF.text = "可抽取次数：" + avaiCount + "次";
      }
      
      public function exchangeSucuess(status:int) : void
      {
         this.updateTips(status);
         var vo:Vo_item = new Vo_item();
         vo.id = this.itemId;
         vo.Init_lib();
         UIManager.centerBroadcast.addMsg("兑换成功，恭喜您获得" + vo.str_name + "*1",1);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 682) / 2;
         y = (Global.stage.stageHeight - 550) / 2;
      }
   }
}

