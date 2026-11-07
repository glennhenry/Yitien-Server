package com.yiTian.view.modules.touzijijin
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TouZiJiJinCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_TZJJPanel extends Panel123
   {
      
      private static var _instance:View_TZJJPanel;
      
      public static var btnIndex:int = 0;
      
      private var itemVec:Vector.<GridItemView> = new Vector.<GridItemView>();
      
      private var closeBtn:Button;
      
      private var price:int;
      
      private var priceTF:MyTextField;
      
      private var rengouNum:int;
      
      private var rengouDes:MyTextField;
      
      private var txtBg:Shape;
      
      private var txtInput:MyTextField;
      
      private var btnUp:Button;
      
      private var btnDown:Button;
      
      private var btnBuy:Button;
      
      private var buyMaxNum:int = 50;
      
      private var canBuyNum:int = 50;
      
      private var tipTF:MyTextField;
      
      private var _isUpdated:Boolean = false;
      
      private var rengouTF:MyTextField;
      
      private var fanliTF:MyTextField;
      
      private var type:int = 0;
      
      private var des:MyTextField;
      
      public function View_TZJJPanel()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/touzijijin.swf","TZJJ_Imgsdm");
      }
      
      public static function get instance() : View_TZJJPanel
      {
         if(!_instance)
         {
            _instance = new View_TZJJPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var item:GridItemView = null;
         move = new Rectangle(0,0,793,45);
         ComponentUtil.getBitmap("Back_YTTZ",this,{
            "x":0,
            "y":0
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":0,
            "y":301,
            "width":744,
            "height":285
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":0,
            "y":303,
            "width":745,
            "height":31
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_DJJL",this,{
            "x":497,
            "y":306
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getBitmap("Text_FLBL",this,{
            "x":259,
            "y":306
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getBitmap("Text_JGRGS",this,{
            "x":111,
            "y":193
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getBitmap("Text_JJRGS",this,{
            "x":121,
            "y":305
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getBitmap("Text_YTTZJH",this,{
            "x":99,
            "y":9
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getBitmap("Text_ZGFL",this,{
            "x":62,
            "y":67
         },Global.TZJJ_Imgsdm);
         this.priceTF = ComponentUtil.getTextField("0",this,{
            "x":192,
            "y":192,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.rengouDes = ComponentUtil.getTextField("0/50",this,{
            "x":192,
            "y":219,
            "color":16755712,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("(最多可认购50份)",this,{
            "x":235,
            "y":219,
            "color":16755712,
            "size":12,
            "leading":0
         });
         var des2:MyTextField = ComponentUtil.getTextField("",this,{
            "x":112,
            "y":244,
            "color":65280,
            "size":12,
            "leading":3
         });
         des2.htmlText = "<font color=\'#00ff00\'>认购期内购买多少封红利，立即返还红利<font color=\'#ffff00\'>130%</font>等值的基金！<font color=\'#ff0000\'>（注：该活动不参与任何消费活动）</font></font>";
         this.des = ComponentUtil.getTextField("",this,{
            "x":112,
            "y":260,
            "color":65280,
            "size":12,
            "leading":3
         });
         this.des.htmlText = "<font color=\'#00ff00\'>在认购期内购买的红利封数累计达到一定要求，在返利期可再额外领取对应的道具奖励一份.</font><font color=\'#fe0000\'>(注：只能领取一种累计奖励)</font>";
         ComponentUtil.getTextField("（例:认购期买20封红利，立返26000基金，同时返利期只能领“累计购买20~49封”的奖励，其他累计购买奖励不能领取）",this,{
            "x":100,
            "y":276,
            "color":65280,
            "size":12,
            "leading":3
         });
         this.tipTF = ComponentUtil.getTextField("认购已结束，返利期可领奖",this,{
            "x":445,
            "y":155,
            "color":16711680
         });
         this.tipTF.visible = false;
         this.rengouTF = ComponentUtil.getTextField("",this,{
            "x":110,
            "y":138,
            "color":327424,
            "size":12,
            "leading":3
         });
         this.fanliTF = ComponentUtil.getTextField("",this,{
            "x":110,
            "y":155,
            "color":327424,
            "size":12,
            "leading":3
         });
         this.txtBg = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":271,
            "y":190,
            "width":62,
            "height":23
         },Global.Img_Cdm);
         this.txtInput = ComponentUtil.getTextField("1",this,{
            "x":280,
            "y":192,
            "color":16777215,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER,
            "maxChars":3,
            "type":TextFieldType.INPUT,
            "realWidth":34,
            "realHeight":18
         });
         this.btnUp = ComponentUtil.getButton("","Button_Nup",this,{
            "x":313,
            "y":191,
            "textColor":16771436,
            "name":"up"
         },Global.TZJJ_Imgsdm);
         this.btnDown = ComponentUtil.getButton("","Button_Ndown",this,{
            "x":313,
            "y":201,
            "textColor":16771436,
            "name":"down"
         },Global.TZJJ_Imgsdm);
         this.btnBuy = ComponentUtil.getButton("认购","Button_Buy",this,{
            "x":336,
            "y":188,
            "textColor":16771436
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getBitmap("Line_GMJJ",this,{
            "x":240,
            "y":304
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getBitmap("Line_GMJJ",this,{
            "x":343,
            "y":304
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getBitmap("Dot_JJTS",this,{
            "x":99,
            "y":196
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getBitmap("Dot_JJTS",this,{
            "x":99,
            "y":223
         },Global.TZJJ_Imgsdm);
         var len:int = int(Data_lib.touzijijin.getLength());
         this.buyMaxNum = Data_lib.touzijijin[len][0];
         this.canBuyNum = this.buyMaxNum;
         var dataArr:Array = Data_lib.touzijijin.toArray();
         var i:int = 0;
         while(i < len)
         {
            item = new GridItemView();
            ComponentUtil.setPropertie(item,{
               "x":7,
               "y":334 + i * 50
            });
            item.initData(dataArr[i],i);
            addChild(item);
            this.itemVec.push(item);
            i++;
         }
         ComponentUtil.getBitmap("Line_YTTZ",this,{
            "x":0,
            "y":580
         },Global.TZJJ_Imgsdm);
         ComponentUtil.getBitmap("TZRW",this,{
            "x":-172,
            "y":-30
         },Global.TZJJ_Imgsdm);
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":737,
            "y":55,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = this.closeMenu;
         this.txtInput.addEventListener(Event.CHANGE,this.changedHandle);
         this.btnUp.callBack = this.btnDown.callBack = this.btnChangeHd;
         this.btnBuy.callBack = this.buyHd;
         this._isUpdated = false;
      }
      
      protected function changedHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(this.canBuyNum <= 0)
         {
            this.txtInput.text = "0";
            return;
         }
         var num:int = int(tf.text);
         num = num > this.canBuyNum ? this.canBuyNum : num;
         num = num < 1 ? 1 : num;
         tf.text = num.toString();
      }
      
      private function btnChangeHd(e:MouseEvent) : void
      {
         if(this.canBuyNum <= 0)
         {
            this.txtInput.text = "0";
            return;
         }
         var _counts:int = int(this.txtInput.text);
         switch(e.target.name)
         {
            case "up":
               _counts++;
               _counts = _counts > this.canBuyNum ? this.canBuyNum : _counts;
               break;
            case "down":
               _counts--;
               _counts = _counts < 1 ? 1 : _counts;
         }
         this.txtInput.text = _counts.toString();
      }
      
      public function update(arr:Array) : void
      {
         this.type = arr[0];
         if(this.type == 1)
         {
            this.txtBg.visible = this.txtInput.visible = this.btnUp.visible = this.btnDown.visible = this.btnBuy.visible = true;
            this.tipTF.visible = false;
         }
         else
         {
            this.txtBg.visible = this.txtInput.visible = this.btnUp.visible = this.btnDown.visible = this.btnBuy.visible = false;
            if(this.type == 2)
            {
               this.tipTF.visible = true;
            }
            else
            {
               this.tipTF.visible = false;
            }
         }
         this.rengouTF.text = "认购期:" + arr[1][0] + "至" + arr[1][1];
         this.fanliTF.text = "返利期:" + arr[1][2] + "至" + arr[1][3];
         this.price = arr[2];
         this.priceTF.text = this.price + "元宝";
         this.canBuyNum = this.buyMaxNum - arr[3];
         this.rengouDes.text = arr[3] + "/" + this.buyMaxNum;
         if(arr[3] >= this.buyMaxNum)
         {
            this.txtInput.text = "0";
         }
         var status:int = int(arr[4]);
         var index:int = int(arr[5]);
         if(this.type == 2)
         {
            if(status == 1)
            {
               View_TouZiJiJin_Icon.instance.effectBegin();
            }
            else
            {
               View_TouZiJiJin_Icon.instance.effectEnd();
            }
         }
         else
         {
            View_TouZiJiJin_Icon.instance.effectEnd();
         }
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            if(i == index - 1)
            {
               this.itemVec[i].setEnable(status);
            }
            else
            {
               this.itemVec[i].setEnable(0);
            }
            i++;
         }
         this._isUpdated = true;
         if(this._isUpdated)
         {
            this.visible = true;
         }
      }
      
      public function updateHaveBuyNum() : void
      {
         this.canBuyNum -= int(this.txtInput.text);
         if(this.canBuyNum < 0)
         {
            this.canBuyNum = 0;
         }
         var haveBuyNum:int = this.buyMaxNum - this.canBuyNum;
         if(haveBuyNum > 50)
         {
            haveBuyNum = 50;
         }
         this.rengouDes.text = haveBuyNum + "/" + this.buyMaxNum;
         if(int(this.txtInput.text) > this.canBuyNum)
         {
            this.txtInput.text = this.canBuyNum.toString();
         }
      }
      
      public function getAward() : void
      {
         View_TouZiJiJin_Icon.instance.effectEnd();
         this.itemV[View_TZJJPanel.btnIndex].setEnable(2);
         this.itemV[View_TZJJPanel.btnIndex].flyIcon();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(this._isUpdated)
            {
               super.visible = value;
               return;
            }
            TouZiJiJinCGMessage.CG_TouZiJiJin_CLICKICON();
         }
         else
         {
            super.visible = false;
            this._isUpdated = false;
         }
      }
      
      private function buyHd(e:MouseEvent) : void
      {
         var str:String;
         if(this.canBuyNum > 0 && this.canBuyNum < int(this.txtInput.text))
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>超过认购上限</font></a>",1);
            return;
         }
         if(this.canBuyNum <= 0)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>已达认购上限</font></a>",1);
            return;
         }
         str = "<font color=\'#ffffff\'>确定认购<font color=\'#ffff00\'>" + int(this.txtInput.text) + "封</font><font color=\'#00ff00\'>红利</font>,共消费<font color=\'#ffff00\'>" + int(this.txtInput.text) * this.price + "</font>元宝<br/><font color=\'#ff0000\'>注：该活动不参与任何消费活动</font></font>";
         View_Alert.show(str,View_Alert.OK_CANCAL,function():void
         {
            switch(type)
            {
               case 0:
                  UIManager.centerBroadcast.addMsg("活动未开始",1);
                  return;
               case 1:
                  trace("认购期");
                  break;
               case 3:
                  trace("中间时期只显示不做任何操作");
                  break;
               case 2:
                  trace("返利期");
                  return;
            }
            if(int(txtInput.text) * price > GameUnitManager.hero.money)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>元宝不足，请充值</font></a>",1);
               return;
            }
            TouZiJiJinCGMessage.CG_TouZiJiJin_RENGOU(int(txtInput.text));
         },null,null,null,330,"","",TextFormatAlign.CENTER);
      }
      
      public function get itemV() : Vector.<GridItemView>
      {
         if(Boolean(this.itemVec))
         {
            return this.itemVec;
         }
         return new Vector.<GridItemView>();
      }
      
      private function closeMenu(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 1050 + 230) / 2;
         y = (Global.stage.stageHeight - 726 + 100) / 2;
      }
   }
}

