package com.yiTian.view.modules.rechargeFeedback.reChangeBack
{
   import com.ui.controls.Button;
   import com.ui.controls.MaskProgressBar2;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_RechargeFeedback;
   import com.yiTian.data.model.Model_RechargeFeedback;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_chargeBackPan extends Panel123
   {
      
      private var reCBItemVec:Vector.<FBackItem> = new Vector.<FBackItem>();
      
      private var reChList:View_fdBackList;
      
      private var progressBar:MaskProgressBar2;
      
      private var progressTxt:MyTextField;
      
      private var tipTF:MyTextField;
      
      private var countBackTf:MyTextField;
      
      private var nowFBackItem:FBackItem;
      
      private var itemArr:Array;
      
      public function View_chargeBackPan()
      {
         super();
         regResource("lang/ch/CZHKDL.swf","CZHKDLdm");
      }
      
      override protected function initStaticView() : void
      {
         var ChongZhiBtn:Button;
         var i:int = 0;
         var item:FBackItem = null;
         move = new Rectangle(0,0,897,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":1,
            "width":897,
            "height":502
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":847,
            "height":452
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":50,
            "width":823,
            "height":157
         },Global.CZHKDLdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":211,
            "width":823,
            "height":267
         },Global.CZHKDLdm);
         ComponentUtil.getBitmap("Title_HuiKui",this,{
            "x":368,
            "y":5
         },Global.CZHKDLdm);
         ComponentUtil.getBitmap("Back_CZLBD",this,{
            "x":37,
            "y":390
         },Global.CZHKDLdm);
         ComponentUtil.getBitmap("Back_CZWZD",this,{
            "x":44,
            "y":59
         },Global.CZHKDLdm);
         ComponentUtil.getBitmap("Text_CZHKZ",this,{
            "x":46,
            "y":68
         },Global.CZHKDLdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":862,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.countBackTf = ComponentUtil.getTextField("新服活动倒计时：7天",this,{
            "x":90,
            "y":118,
            "color":16777215,
            "size":14,
            "leading":0
         });
         this.tipTF = ComponentUtil.getTextField("还需充值1000元宝，您就能领取1000元宝礼包！",this,{
            "x":90,
            "y":139,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ChongZhiBtn = ComponentUtil.getButton("","Button_Recharge",this,{
            "x":719,
            "y":154,
            "textColor":16771436
         },Global.CZHKDLdm);
         ChongZhiBtn.callBack = function():void
         {
            UIManager.yuanBaoXiang.visible = true;
         };
         this.progressBar = new MaskProgressBar2(ComponentUtil.getScaleBitmap("HuiKuiProgress",[6,7,42,2],null,{
            "x":96,
            "y":169,
            "width":585,
            "height":16
         },Global.CZHKDLdm),ComponentUtil.getScaleBitmap("HuiKuiProgress_Back",[32,15,61,4],null,{
            "x":71,
            "y":160,
            "width":639,
            "height":34
         },Global.CZHKDLdm));
         addChild(this.progressBar);
         this.progressTxt = ComponentUtil.getTextField("0/0",this,{
            "x":392,
            "y":165,
            "color":16777215,
            "size":14,
            "leading":0
         },"center");
         i = 0;
         while(i < 7)
         {
            item = new FBackItem();
            addChild(item);
            item.init(i + 1);
            item.tabIndex = i + 1;
            ComponentUtil.setPropertie(item,{
               "x":44 + 116 * i,
               "y":218
            });
            this.reCBItemVec.push(item);
            item.addEventListener(MouseEvent.CLICK,this.cliHd);
            i++;
         }
         this.reChList = new View_fdBackList();
         addChild(this.reChList);
         ComponentUtil.setPropertie(this.reChList,{
            "x":82,
            "y":416
         });
      }
      
      public function cliHd(e:MouseEvent) : void
      {
         var panItem:FBackItem = null;
         if(e.target is FBackItem)
         {
            panItem = e.target as FBackItem;
         }
         else
         {
            panItem = e.target.parent as FBackItem;
         }
         if(this.nowFBackItem == panItem)
         {
            return;
         }
         if(Boolean(this.nowFBackItem))
         {
            this.nowFBackItem.choose = false;
         }
         panItem.choose = true;
         this.nowFBackItem = panItem;
         this.reChList.init(this.nowFBackItem.tabIndex,this.getItemList(this.nowFBackItem.tabIndex));
      }
      
      public function getItemList(type:int) : Array
      {
         this.itemArr = Data_lib.czfk[type][1].toString().split(",");
         var len:int = int(this.itemArr.length);
         var i:int = 0;
         while(i < len)
         {
            this.itemArr[i] = this.itemArr[i].split("_");
            i++;
         }
         return this.itemArr;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.reCBItemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function getAward() : void
      {
         this.reChList.getAward();
      }
      
      public function updateData() : void
      {
         var item:FBackItem = null;
         var i:int = 0;
         var status:Array = Model_RechargeFeedback.statusArr;
         while(i < View_fdBackList.LEN)
         {
            item = this.reCBItemVec[i];
            item.upBtn(status[i]);
            i++;
         }
      }
      
      public function upTip(day:int) : void
      {
         var nextMoney:int = 0;
         var needMoney:int = 0;
         var nextTarget:int = Model_RechargeFeedback.nowTarget + 1;
         if(nextTarget > Enum_RechargeFeedback.MAX_TARGET)
         {
            nextMoney = int(Data_lib.czfk[Enum_RechargeFeedback.MAX_TARGET][0]);
            this.tipTF.htmlText = LangConfig.getWord("80221",8);
            this.countBackTf.visible = false;
         }
         else
         {
            nextMoney = int(Data_lib.czfk[nextTarget][0]);
            needMoney = nextMoney - Model_RechargeFeedback.nowRecharge;
            this.countBackTf.htmlText = "新服活动倒计时：" + HtmlUtil.fontNoSize(day.toString() + "天","#00ff00");
            this.tipTF.htmlText = "还需充值" + HtmlUtil.font(needMoney.toString() + "元宝","#ffff00") + "，您就能领取" + nextMoney.toString() + "元宝的礼包！";
         }
         this.progressBar.persent = Model_RechargeFeedback.nowRecharge / nextMoney;
         this.progressTxt.text = Model_RechargeFeedback.nowRecharge.toString() + "/" + nextMoney;
      }
   }
}

