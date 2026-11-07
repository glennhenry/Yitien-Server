package com.yiTian.view.modules.goldLottery
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.model.Model_GoldCJ;
   import com.yiTian.data.vo.Vo_GoldCJ;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GoldCJCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ViewGoldCJ extends Panel123
   {
      
      private static var temNum1:int = 100;
      
      private static var temNum2:int = 990;
      
      private static var temNum3:int = 4900;
      
      private var titleBg:Bitmap;
      
      private var backBitmap:ScaleBitmap;
      
      private var backLayer:Sprite;
      
      private var txtLayer:Sprite;
      
      private var dymLayer:Sprite;
      
      private var rechargeBtn:Button;
      
      private var goldTxt:MyTextField;
      
      private var infoTxt:MyTextField;
      
      private var dateTxt:MyTextField;
      
      private var cjBtn_1:Button;
      
      private var cjBtn_2:Button;
      
      private var cjBtn_3:Button;
      
      private var barBmSprite:Sprite;
      
      private var maskBar:Sprite;
      
      private var _goldCJBtn:Sprite;
      
      private var c_a_bm:Bitmap;
      
      public var wheel:Child_GoldCJWheel;
      
      public var grids:Child_GoldCJGrid;
      
      public var rewardListPanel:Child_GoldCJRewardList;
      
      private var temBar:Bitmap;
      
      public function ViewGoldCJ()
      {
         super();
      }
      
      public function addGoldCJMainBtn() : void
      {
         if(!this._goldCJBtn)
         {
            this._goldCJBtn = new Sprite();
            this._goldCJBtn.graphics.beginFill(0,0);
            this._goldCJBtn.graphics.drawRect(0,0,65,70);
            this._goldCJBtn.graphics.endFill();
            this.c_a_bm = new Bitmap();
            this._goldCJBtn.addChild(this.c_a_bm);
            this._goldCJBtn.buttonMode = true;
            this._goldCJBtn.addEventListener(MouseEvent.CLICK,this.consumeAwardOnClick);
         }
         UIManager.mainUiBtnContainer.addBTN(this._goldCJBtn);
         Utils.getLoadBitmap("resource/image/extralPng/goldCJ_Btn_Img.png",this.c_a_bm);
      }
      
      public function removeGoldCJMainBtn() : void
      {
         if(Boolean(this._goldCJBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this._goldCJBtn);
         }
      }
      
      private function consumeAwardOnClick(e:MouseEvent) : void
      {
         UIManager.goldCJ.visible = !UIManager.goldCJ.visible;
      }
      
      override protected function initStaticView() : void
      {
         this.backLayer = new Sprite();
         addChild(this.backLayer);
         this.txtLayer = new Sprite();
         addChild(this.txtLayer);
         this.dymLayer = new Sprite();
         addChild(this.dymLayer);
         this.backBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.backLayer,{
            "x":0,
            "y":0,
            "width":738,
            "height":420
         },Global.Img_Cdm);
         move = new Rectangle(0,0,738,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":704,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         this.infoTxt = ComponentUtil.getTextField("                   幸运获得：                    x00",this.txtLayer,{
            "x":404,
            "y":70,
            "color":13424242,
            "size":12,
            "leading":6,
            "realWidth":300,
            "realHeight":165
         });
         this.infoTxt.text = "";
         this.cjBtn_1 = ComponentUtil.getButton(LangConfig.getWord("20045",11,Model_GoldCJ.LOTTERY_TYPE_1),"Button_Four",this.dymLayer,{
            "x":418,
            "y":247,
            "textColor":16184781,
            "callBack":this.onCJHandler
         },Global.Img_Cdm);
         this.cjBtn_2 = ComponentUtil.getButton(LangConfig.getWord("20045",11,Model_GoldCJ.LOTTERY_TYPE_2),"Button_Four",this.dymLayer,{
            "x":516,
            "y":247,
            "textColor":16184781,
            "callBack":this.onCJHandler
         },Global.Img_Cdm);
         this.cjBtn_3 = ComponentUtil.getButton(LangConfig.getWord("20045",11,Model_GoldCJ.LOTTERY_TYPE_3),"Button_Four",this.dymLayer,{
            "x":614,
            "y":247,
            "textColor":16184781,
            "callBack":this.onCJHandler
         },Global.Img_Cdm);
         ComponentUtil.getTextField(temNum1 + LangConfig.getWord("21",0),this.txtLayer,{
            "x":430,
            "y":271,
            "color":16758528,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(temNum2 + LangConfig.getWord("21",0),this.txtLayer,{
            "x":527,
            "y":271,
            "color":16758528,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(temNum3 + LangConfig.getWord("21",0),this.txtLayer,{
            "x":625,
            "y":271,
            "color":16758528,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("20046",11,"\n"),this.txtLayer,{
            "x":404,
            "y":291,
            "color":4959770,
            "size":12,
            "leading":3,
            "realWidth":66,
            "realHeight":35
         });
         this.dateTxt = ComponentUtil.getTextField(LangConfig.getWord("20056",11),this.txtLayer,{
            "x":465,
            "y":292,
            "color":13424242,
            "size":12,
            "leading":3
         });
         var txt2:MyTextField = ComponentUtil.getTextField("",this.txtLayer,{
            "x":465,
            "y":308,
            "color":13424242,
            "size":12,
            "leading":3,
            "realWidth":224,
            "realHeight":35,
            "wordWrap":true
         });
         txt2.htmlText = LangConfig.getWord("20047",11);
      }
      
      override protected function initUI2() : void
      {
         var temT1:MyTextField = null;
         this.titleBg = ComponentUtil.getBitmap("Title_YuanBaoCJ",this,{
            "x":289,
            "y":5
         },Global.YuanBaoCJ_Imgsdm);
         Global.control.registerCallBack(Enum_MsgType.ROLE_PAN_UPDATE,this.updateMoney);
         ComponentUtil.getScaleBitmap("Back_Inf",[24,24,2,2],this.backLayer,{
            "x":370,
            "y":50,
            "width":344,
            "height":350
         },Global.YuanBaoCJ_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this.backLayer,{
            "x":380,
            "y":240,
            "width":324,
            "height":150
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this.backLayer,{
            "x":380,
            "y":60,
            "width":324,
            "height":175
         },Global.Img_Cdm);
         this.wheel = new Child_GoldCJWheel();
         this.wheel.x = 24;
         this.wheel.y = 40;
         this.dymLayer.addChild(this.wheel);
         this.grids = new Child_GoldCJGrid();
         this.grids.x = 24;
         this.grids.y = 40;
         this.dymLayer.addChild(this.grids);
         this.wheel.gridView = this.grids;
         ComponentUtil.getBitmap("Back_Progress",this.backLayer,{
            "x":400,
            "y":363
         },Global.YuanBaoCJ_Imgsdm);
         this.maskBar = new Sprite();
         this.backLayer.addChild(this.maskBar);
         this.barBmSprite = new Sprite();
         this.backLayer.addChild(this.barBmSprite);
         this.temBar = ComponentUtil.getBitmap("Progress",this.barBmSprite,{
            "x":416,
            "y":365
         },Global.YuanBaoCJ_Imgsdm);
         this.maskBar.graphics.beginFill(16711680);
         this.maskBar.graphics.drawRect(0,0,this.temBar.width,this.temBar.height);
         this.maskBar.graphics.endFill();
         ComponentUtil.setPropertie(this.maskBar,{
            "x":this.temBar.x,
            "y":this.temBar.y
         });
         this.barBmSprite.mask = this.maskBar;
         this.barBmSprite.addEventListener(MouseEvent.ROLL_OVER,this.onShowTip);
         ComponentUtil.getBitmap("Progress_Point",this.backLayer,{
            "x":467 - 5,
            "y":365
         },Global.YuanBaoCJ_Imgsdm);
         temT1 = ComponentUtil.getTextField("",this.txtLayer,{
            "x":430,
            "y":346,
            "color":16758528,
            "size":12,
            "leading":0
         });
         temT1.htmlText = "一阶" + "<font color=\'#04ff00\'>(" + Model_GoldCJ.timesArr[0] + ")次</font>";
         ComponentUtil.getBitmap("Progress_Point",this.backLayer,{
            "x":541,
            "y":365
         },Global.YuanBaoCJ_Imgsdm);
         temT1 = ComponentUtil.getTextField("",this.txtLayer,{
            "x":519,
            "y":346,
            "color":16758528,
            "size":12,
            "leading":0
         });
         temT1.htmlText = "二阶" + "<font color=\'#04ff00\'>(" + Model_GoldCJ.timesArr[1] + ")次</font>";
         ComponentUtil.getBitmap("Progress_Point",this.backLayer,{
            "x":612 + 60,
            "y":364
         },Global.YuanBaoCJ_Imgsdm);
         temT1 = ComponentUtil.getTextField("",this.txtLayer,{
            "x":608 + 18,
            "y":344,
            "color":16758528,
            "size":12,
            "leading":0
         });
         temT1.htmlText = "三阶" + "<font color=\'#04ff00\'>(" + Model_GoldCJ.timesArr[2] + ")次</font>";
         ComponentUtil.getBitmap("Back_YuanBao",this.dymLayer,{
            "x":54,
            "y":46
         },Global.YuanBaoCJ_Imgsdm);
         this.goldTxt = ComponentUtil.getTextField("0000000",this.dymLayer,{
            "x":95 - 4,
            "y":46,
            "color":16765952,
            "size":12,
            "leading":0
         });
         this.goldTxt.text = GameUnitManager.hero.money + "";
         this.rechargeBtn = ComponentUtil.getButton("","Button_ChongZhi",this.dymLayer,{
            "x":289,
            "y":46,
            "textColor":16184781,
            "callBack":this.onRechargeHander
         },Global.YuanBaoCJ_Imgsdm);
         this.updateDate(Model_GoldCJ.dateStr);
         this.updateInfo(Model_GoldCJ.showInfoList.length,Model_GoldCJ.showInfoList);
         this.updateTimes(Model_GoldCJ.totalCJTimes);
         this.updateLockState();
         Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.updateMoney);
      }
      
      private function onCJHandler(e:MouseEvent) : void
      {
         var reqMoney:int = 0;
         if(Model_GoldCJ.rewardList.length > 0)
         {
            Model_GoldCJ.rewardList = [];
         }
         var target:Button = e.target as Button;
         switch(target)
         {
            case this.cjBtn_1:
               reqMoney = temNum1;
               Model_GoldCJ.curCJType = 1;
               break;
            case this.cjBtn_2:
               reqMoney = temNum2;
               Model_GoldCJ.curCJType = 2;
               break;
            case this.cjBtn_3:
               reqMoney = temNum3;
               Model_GoldCJ.curCJType = 3;
         }
         if(GameUnitManager.hero.money < reqMoney)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20051",11));
            return;
         }
         Model_GoldCJ.isRunning = true;
         this.setBtnEnable();
         GoldCJCGMessage.CG_GLOD_CJ_START_LOTTERY(Model_GoldCJ.curCJType);
      }
      
      private function onShowTip(e:MouseEvent) : void
      {
         TipManager.update(LangConfig.getWord("20059",11,Model_GoldCJ.totalCJTimes));
      }
      
      public function setBtnEnable() : void
      {
         if(Model_GoldCJ.isRunning)
         {
            this.cjBtn_1.enabled = false;
            this.cjBtn_2.enabled = false;
            this.cjBtn_3.enabled = false;
         }
         else
         {
            this.cjBtn_1.enabled = true;
            this.cjBtn_2.enabled = true;
            this.cjBtn_3.enabled = true;
         }
      }
      
      private function onRechargeHander(e:MouseEvent) : void
      {
         UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
      }
      
      private function updateMoney() : void
      {
         this.goldTxt.text = GameUnitManager.hero.money + "";
      }
      
      public function updateDate(dateStr:String) : void
      {
         if(!this.dateTxt)
         {
            return;
         }
         var dateArr:Array = dateStr.split("&");
         if(dateArr.length < 2)
         {
            this.dateTxt.htmlText = "";
            return;
         }
         this.dateTxt.htmlText = LangConfig.getWord("20056",11,dateArr[0] + " 10:00",dateArr[1] + " 23:59");
      }
      
      public function updateInfo(num:int, infoArr:Array) : void
      {
         var obj:Object = null;
         var a:Array = null;
         var str:String = null;
         if(!this.infoTxt || num == 0)
         {
            return;
         }
         this.infoTxt.htmlText = "";
         var temStr:String = "";
         var visVo:Vo_item = new Vo_item();
         var i:int = 0;
         while(i < num)
         {
            if(num > Model_GoldCJ.INFO_NUM)
            {
               i = num - (num - Model_GoldCJ.INFO_NUM);
            }
            obj = Model_GoldCJ.showInfoList[i];
            a = Model_GoldCJ.getArrByPos(obj.pos);
            visVo.id = a[0].split("_")[1];
            visVo.Init_lib();
            if(visVo.color == Enum_color.WHITE)
            {
               str = ColorConstant.getColorStr(ColorConstant.WHITE);
            }
            else if(visVo.color == Enum_color.GREEN)
            {
               str = ColorConstant.getColorStr(ColorConstant.GREEN);
            }
            else if(visVo.color == Enum_color.BLUE)
            {
               str = ColorConstant.getColorStr(ColorConstant.BLUE);
            }
            else if(visVo.color == Enum_color.PURPLE)
            {
               str = ColorConstant.getColorStr(ColorConstant.PURPLE);
            }
            else if(visVo.color == Enum_color.ORANGE)
            {
               str = ColorConstant.getColorStr(ColorConstant.ORANGE);
            }
            str = HtmlUtil.font(visVo.str_name,str);
            temStr += LangConfig.getWord("20044",11,obj.name,str) + (i == num - 1 ? "" : "\n");
            i++;
         }
         this.infoTxt.htmlText = temStr;
      }
      
      public function updateTimes(times:int) : void
      {
         var per:Number = times / Model_GoldCJ.MAX_CJ_TIMES;
         this.maskBar.scaleX = per;
      }
      
      public function updateLockState() : void
      {
         var vo:Vo_GoldCJ = null;
         var j:int = 0;
         var arr1:Array = Model_GoldCJ.voArr;
         var arr2:Array = Model_GoldCJ.lockStr.split("_");
         var i:int = 0;
         while(i < arr1.length)
         {
            vo = arr1[i] as Vo_GoldCJ;
            vo.isLock = Model_GoldCJ.STATE_UNLOCK;
            j = 0;
            while(j < arr2.length)
            {
               if(arr2[0] == "")
               {
                  break;
               }
               if(arr2[j] == vo.index)
               {
                  vo.isLock = Model_GoldCJ.STATE_LOCK;
               }
               j++;
            }
            this.grids.updateLock(vo.isLock,vo.index);
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.YuanBaoCJ_Imgsdm)
            {
               regResource(Model_GoldCJ.SOURCE_URL,"YuanBaoCJ_Imgsdm");
               preFun();
            }
            else
            {
               if(!this.titleBg)
               {
                  this.initUI2();
               }
               this.updateDate(Model_GoldCJ.dateStr);
               this.updateInfo(Model_GoldCJ.showInfoList.length,Model_GoldCJ.showInfoList);
               this.updateTimes(Model_GoldCJ.totalCJTimes);
               this.updateLockState();
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get width() : Number
      {
         return 738;
      }
      
      override public function get height() : Number
      {
         return 420;
      }
   }
}

