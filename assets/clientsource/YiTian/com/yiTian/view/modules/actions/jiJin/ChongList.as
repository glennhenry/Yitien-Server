package com.yiTian.view.modules.actions.jiJin
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.yellowDiamond.Model_txAction;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ChongList extends Sprite
   {
      
      private var chongItemVec:Vector.<ChongItem>;
      
      private var lvlTf:MyTextField;
      
      private var moTf:MyTextField;
      
      private var maskSp:Sprite;
      
      private var perTf:MyTextField;
      
      private var spr:Sprite;
      
      private var bmType:Bitmap;
      
      public function ChongList()
      {
         var i:int;
         var p:Bitmap;
         var item:ChongItem = null;
         this.chongItemVec = new Vector.<ChongItem>();
         super();
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":0,
            "y":0 - 42,
            "width":540,
            "height":350 + 42
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":10,
            "y":135,
            "width":520,
            "height":205
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":15,
            "y":247,
            "width":510,
            "height":88
         },Global.Img_Cdm);
         i = 0;
         while(i < 4)
         {
            item = new ChongItem();
            ComponentUtil.setPropertie(item,{
               "x":24 + 137 * i,
               "y":140
            });
            addChild(item);
            item.update(i + 1);
            this.chongItemVec.push(item);
            i++;
         }
         ComponentUtil.getTextField("您当前的级别：",this,{
            "x":25,
            "y":253,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.lvlTf = ComponentUtil.getTextField("1级",this,{
            "x":114,
            "y":253,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("注：充值同一账号全服有效(数据有延迟)",this,{
            "x":307,
            "y":253,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.bmType = ComponentUtil.getBitmap("fund_01",this,{
            "x":25,
            "y":270
         },Global.JiJin_Imgsdm);
         ComponentUtil.getBitmap("ProgressBack",this,{
            "x":103,
            "y":282
         },Global.JiJin_Imgsdm);
         this.moTf = ComponentUtil.getTextField("再充值00000元宝，您将成为00级白金武魂。",this,{
            "x":103,
            "y":310,
            "color":16764206,
            "size":12,
            "leading":0
         });
         p = ComponentUtil.getBitmap("Progress",this,{
            "x":122,
            "y":286
         },Global.JiJin_Imgsdm);
         this.maskSp = new Sprite();
         this.maskSp.graphics.beginFill(0,0);
         this.maskSp.graphics.drawRect(0,0,20,357);
         this.maskSp.graphics.endFill();
         ComponentUtil.setPropertie(this.maskSp,{
            "x":122,
            "y":286
         });
         addChild(this.maskSp);
         p.mask = this.maskSp;
         this.spr = new Sprite();
         addChild(this.spr);
         ComponentUtil.setPropertie(this.spr,{
            "x":10,
            "y":10
         });
         this.spr.mouseEnabled = true;
         this.spr.buttonMode = true;
         this.spr.visible = false;
         this.spr.addEventListener(MouseEvent.CLICK,function():void
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
         });
         ComponentUtil.getBitmap("Diamond_Bule",this.spr,{
            "x":0,
            "y":0
         },Global.JiJin_Imgsdm);
         this.perTf = ComponentUtil.getTextField("00000/00000",this,{
            "x":262,
            "y":282,
            "color":16777215,
            "size":12,
            "leading":0
         });
      }
      
      public function update(chongMo:int, lvl:int) : void
      {
         var maxNum:int = 0;
         var lvStr:int = 0;
         var ss:String = null;
         if(lvl == 0)
         {
            this.lvlTf.text = "无";
            this.bmType.bitmapData = ComponentUtil.getBitmapData("fund_01",Global.JiJin_Imgsdm);
            this.bmType.filters = Util.disabled;
         }
         else
         {
            this.lvlTf.htmlText = HtmlUtil.font(lvl + "级白金武魂",FundMter.colorArr[lvl]);
            ss = "fund_0" + lvl;
            this.bmType.bitmapData = ComponentUtil.getBitmapData(ss,Global.JiJin_Imgsdm);
            this.bmType.filters = [];
         }
         if(chongMo >= 0 && chongMo < 50000)
         {
            maxNum = 50000;
            lvStr = 1;
         }
         else if(chongMo >= 50000 && chongMo < 200000)
         {
            maxNum = 200000;
            lvStr = 2;
         }
         else if(chongMo >= 200000 && chongMo < 1000000)
         {
            maxNum = 1000000;
            lvStr = 3;
         }
         var chaJia:int = maxNum - chongMo;
         this.maskSp.width = 357 * (chongMo / maxNum);
         this.perTf.text = chongMo + "/" + maxNum;
         this.moTf.htmlText = "再充值" + chaJia + "元宝，您将成为" + HtmlUtil.font(lvStr + "级白金武魂。",FundMter.colorArr[lvStr]);
         if(lvl == 3)
         {
            this.perTf.visible = false;
            this.maskSp.width = 357;
            this.moTf.visible = false;
         }
      }
      
      public function set money(value:int) : void
      {
         var maxNum:int = 0;
         var lvStr:int = 0;
         if(value >= 0 && value < 50000)
         {
            maxNum = 50000;
            lvStr = 1;
         }
         else if(value >= 50000 && value < 200000)
         {
            maxNum = 200000;
            lvStr = 2;
         }
         else if(value >= 200000 && value < 1000000)
         {
            maxNum = 1000000;
            lvStr = 3;
         }
         var chaJia:int = maxNum - value;
         if(Boolean(this.maskSp))
         {
            this.maskSp.width = 357 * (value / maxNum);
         }
         if(Boolean(this.perTf))
         {
            this.perTf.text = value + "/" + maxNum;
         }
         if(Boolean(this.moTf))
         {
            this.moTf.htmlText = "再充值" + chaJia + "元宝，您将成为" + HtmlUtil.font(lvStr + "级白金武魂。",FundMter.colorArr[lvStr]);
         }
      }
   }
}

