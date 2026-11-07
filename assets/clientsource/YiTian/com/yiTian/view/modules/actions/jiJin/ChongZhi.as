package com.yiTian.view.modules.actions.jiJin
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.yellowDiamond.Model_txAction;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ChongZhi extends Panel123
   {
      
      public static var isCheAll:Boolean = false;
      
      public static var isFirstLoad:Boolean = true;
      
      private var wuHunLvl:WuHunLvl;
      
      private var chongList:ChongList;
      
      private var tf:MyTextField;
      
      private var _lvl:int;
      
      private var mmBm:Bitmap;
      
      private var btn:Button;
      
      public function ChongZhi()
      {
         super();
         regResource("lang/ch/JiJin_Imgs.swf","JiJin_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":608,
            "height":578 + 38
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":560,
            "height":528 + 38
         },Global.Img_Cdm);
         move = new Rectangle(0,0,607,38);
         this.chongList = new ChongList();
         this.chongList.x = 34;
         this.chongList.y = 50 + 38;
         addChild(this.chongList);
         this.wuHunLvl = new WuHunLvl();
         this.wuHunLvl.x = 34;
         this.wuHunLvl.y = 400 + 38;
         addChild(this.wuHunLvl);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":574,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_ChongZhi",this,{
            "x":224,
            "y":5
         },Global.JiJin_Imgsdm);
         this.tf = ComponentUtil.getTextField("查看我的特权",this,{
            "x":470,
            "y":405 + 38,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.tf.mouseEnabled = true;
         this.tf.htmlText = HtmlUtil.link(HtmlUtil.underLine("查看我的特权"),"ss");
         this.tf.addEventListener(TextEvent.LINK,this.link);
      }
      
      private function link(e:TextEvent) : void
      {
         if(this.tf.text == "查看我的特权")
         {
            if(this._lvl == 0)
            {
               UIManager.centerBroadcast.addMsg("您还不是白金武魂，请充值成为白金武魂");
               return;
            }
            this.tf.htmlText = HtmlUtil.link(HtmlUtil.underLine("查看其它特权"),"mm");
            this.wuHunLvl.update(this._lvl);
         }
         else if(this.tf.text == "查看其它特权")
         {
            this.wuHunLvl.update(0);
            this.tf.htmlText = HtmlUtil.link(HtmlUtil.underLine("查看我的特权"),"ss");
         }
      }
      
      public function update(chongMo:int, lvl:int, statusArr:Array) : void
      {
         FundMter.chongZhiPan.update(chongMo,lvl,statusArr);
      }
      
      public function getAward(_index:int) : void
      {
         this.wuHunLvl.getAward(_index);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var backspr:Sprite = null;
         var st:String = null;
         var sst:String = null;
         super.visible = value;
         if(value)
         {
            if(isFirstLoad)
            {
               backspr = new Sprite();
               addChild(backspr);
               backspr.buttonMode = true;
               ComponentUtil.setPropertie(backspr,{
                  "x":15,
                  "y":0
               });
               if(Global.pf == "qqgame" || Global.pf == "3366")
               {
                  st = "openBlueBtn";
               }
               else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG)
               {
                  st = "Button_KTHuiYuan";
               }
               else
               {
                  st = "Button_HuangZhuan";
               }
               this.btn = ComponentUtil.getButton("",st,this,{
                  "x":310,
                  "y":64
               },ComponentUtil.domain);
               this.btn.addEventListener(MouseEvent.CLICK,this.linkToYellowDia);
               backspr.addEventListener(MouseEvent.CLICK,this.linkToYellowDia);
               if(Global.pf == "qqgame" || Global.pf == "3366")
               {
                  sst = "back2";
               }
               else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG)
               {
                  sst = "back3";
                  backspr.mouseEnabled = false;
                  backspr.buttonMode = false;
               }
               else
               {
                  sst = "back";
               }
               this.mmBm = Utils.getLoadBitmap("resource/image/chongzhi/" + sst + ".jpg",this.mmBm,{
                  "x":37,
                  "y":50
               });
               backspr.addChild(this.mmBm);
            }
         }
      }
      
      private function linkToYellowDia(e:MouseEvent) : void
      {
         if(Global.pf == "qqgame")
         {
            ExternalInterface.call("minipayOpenVIP");
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG)
         {
            navigateToURL(new URLRequest("http://pay.qq.com/qqvip/index2.0.shtml?aid=vip.youxi.webgame.YT.qplus"));
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isUnion(Global.pf) || Enum_SPStr.isIwan(Global.pf))
         {
            navigateToURL(new URLRequest("http://pay.qq.com/qzone/index.shtml?aid=game100621282.yop&paytime=year"));
         }
         else if(Global.pf == Enum_SPStr.QQ3366)
         {
            navigateToURL(new URLRequest(Model_txAction.QQ3366_URL));
         }
      }
      
      public function set chongMoney(value:int) : void
      {
         if(Boolean(this.wuHunLvl) && Boolean(this.chongList))
         {
            this.chongList.money = value;
            this.wuHunLvl.money = value;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 608) / 2;
         y = (Global.stage.stageHeight - 576) / 2;
      }
   }
}

