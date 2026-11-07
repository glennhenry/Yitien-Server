package com.yiTian.view.modules.qplus
{
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ViewShareEvent extends Sprite
   {
      
      public static var instance:ViewShareEvent;
      
      public static const SHARELEN:int = 22;
      
      private static const ITEMLEN:int = 6;
      
      private static const dailyGoalId:Array = [1,2];
      
      private static const thirdGoalId:Array = [3,4,5,6];
      
      private static const fouthGoalId:Array = [7,8,9,10];
      
      private static const fifthGoalId:Array = [11,12,13,14];
      
      private static const sixthGoalId:Array = [15,16,17,18];
      
      private static const sevenGoalId:Array = [19,20,21,22];
      
      private var tabBtnArr:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var tabBtnLen:int = 5;
      
      private var shareItemArr:Vector.<ShareItem> = new Vector.<ShareItem>();
      
      public var isFirstShare:Boolean = false;
      
      private var curGoalId:Array;
      
      private var curStateArr:Array;
      
      private var curTabBtn:TabButton;
      
      public function ViewShareEvent()
      {
         super();
         this.init();
         instance = this;
      }
      
      private function init() : void
      {
         var i:int = 0;
         var firStr:int = 0;
         var u:int = 0;
         var labelBtn:String = null;
         var tabBtn:TabButton = null;
         var item:ShareItem = null;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":0,
            "y":0,
            "width":456,
            "height":344
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":2,
            "y":138,
            "width":452,
            "height":204
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":2,
            "y":2,
            "width":452,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":2,
            "y":119,
            "width":452,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":2,
            "y":22,
            "width":452,
            "height":95
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("30096",3),this,{
            "x":201,
            "y":2,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("30097",3),this,{
            "x":201,
            "y":120,
            "color":16764206,
            "size":12,
            "leading":0
         });
         firStr = 30;
         i = 0;
         while(i < this.tabBtnLen)
         {
            labelBtn = String(firStr) + LangConfig.getWord("30098",3);
            tabBtn = ComponentUtil.getTabButton(labelBtn,"TabButton_Four",this,{
               "y":156,
               "textColor":12232795,
               "chooseColor":16773818
            },Global.Img_Cdm);
            tabBtn.x = 30 + i * 78;
            tabBtn.addEventListener(MouseEvent.CLICK,this.tabClkHandle);
            this.tabBtnArr.push(tabBtn);
            firStr += 10;
            i++;
         }
         TabButton(this.tabBtnArr[0]).choose = true;
         u = 0;
         while(u < ITEMLEN)
         {
            item = new ShareItem();
            addChild(item);
            this.shareItemArr.push(item);
            item.x = 3;
            if(u < 2)
            {
               item.y = 22 + u * 50;
            }
            else
            {
               item.y = 177 + (u - 2) * 40;
            }
            u++;
         }
         this.curGoalId = thirdGoalId;
         this.setGoalText();
      }
      
      private function tabClkHandle(evt:MouseEvent) : void
      {
         var btn:TabButton = evt.currentTarget as TabButton;
         if(this.curTabBtn == btn)
         {
            return;
         }
         if(Boolean(this.curTabBtn))
         {
            this.curTabBtn.choose = false;
         }
         btn.choose = true;
         this.curTabBtn = btn;
         var str:String = btn.text;
         var order:int = int(str.substr(0,1));
         switch(order)
         {
            case 3:
               this.curGoalId = thirdGoalId;
               break;
            case 4:
               this.curGoalId = fouthGoalId;
               break;
            case 5:
               this.curGoalId = fifthGoalId;
               break;
            case 6:
               this.curGoalId = sixthGoalId;
               break;
            case 7:
               this.curGoalId = sevenGoalId;
         }
         this.setGoalText();
         this.setShare();
      }
      
      private function setGoalText() : void
      {
         var l:int = 0;
         var item:ShareItem = null;
         var arr:Array = null;
         var ary:Array = null;
         l = 0;
         while(l < ITEMLEN)
         {
            item = this.shareItemArr[l] as ShareItem;
            if(l < 2)
            {
               arr = Data_lib.qplusShare[int(dailyGoalId[l])];
               item.itemText(arr[0],arr[1],arr[2]);
               item.itemId = int(dailyGoalId[l]);
            }
            else
            {
               ary = Data_lib.qplusShare[int(this.curGoalId[l - 2])];
               item.itemText(ary[0],ary[1],ary[2]);
               item.itemId = int(this.curGoalId[l - 2]);
            }
            l++;
         }
      }
      
      private function setShare() : void
      {
         var t:int = 0;
         var item:ShareItem = null;
         if(!this.curStateArr)
         {
            return;
         }
         t = 0;
         while(t < ITEMLEN)
         {
            item = this.shareItemArr[t] as ShareItem;
            item.shareState = this.curStateArr[item.itemId - 1];
            if(this.curStateArr[item.itemId - 1] == 2 && this.isFirstShare == false)
            {
               this.isFirstShare = true;
               ViewMicroBlog.instance.closeZoneBtn();
            }
            t++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            TabButton(this.tabBtnArr[0]).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function set shareData(arr:Array) : void
      {
         this.curStateArr = arr;
         this.setShare();
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.Enum_SPStr;
import com.yiTian.manager.LangConfig;
import com.yiTian.net.message.cg.QplusShareCGMessage;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;
import flash.geom.Point;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.utils.getTimer;

class ShareItem extends Sprite
{
   
   private var _itemTxt:MyTextField;
   
   private var _shareBtn:Button;
   
   private var _bitBg:Bitmap;
   
   private var _itemStr:String;
   
   private var _shareTitle:String;
   
   private var _shareContent:String;
   
   private var _shareOutUrl:String;
   
   private var curStr:String = "YWanCheng";
   
   public var itemId:int;
   
   private var shareOutUrl:String = "http://app100621282.imgcache.qzoneapp.com/app100621282/qqshare/qqshare_131129-";
   
   public function ShareItem()
   {
      super();
      this.initItem();
   }
   
   private function initItem() : void
   {
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":0,
         "width":446,
         "height":2
      },Global.Img_Cdm);
      this._itemTxt = ComponentUtil.getTextField("一二三四五六七八九十一二三四五六七八九十一",this,{
         "x":14,
         "y":13,
         "color":16773818,
         "size":12,
         "leading":0
      });
      this._bitBg = ComponentUtil.getBitmap("YWanCheng",this,{
         "x":278,
         "y":10
      },Global.FengXiang_Imgsdm);
      this._shareBtn = ComponentUtil.getButton(LangConfig.getWord("30099",3),"Button_Four",this,{
         "x":370,
         "y":10,
         "textColor":16184781
      },Global.Img_Cdm);
      this._shareBtn.addEventListener(MouseEvent.CLICK,this.shareHandle);
   }
   
   private function shareHandle(evt:MouseEvent) : void
   {
      var loadurl:String = null;
      var encodeUrl:String = null;
      var loader:URLLoader = null;
      var url:URLRequest = null;
      Global.shareType = this.itemId;
      var p:Point = new Point(evt.stageX,evt.stageY);
      Global.sharePoint = p;
      this._shareOutUrl = this.shareOutUrl + this.itemId + ".gif";
      if(Global.pf == Enum_SPStr.QQGAME)
      {
         loadurl = "http://s2.app100621282.qqopenapp.com/interface.php?op=setfeed&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global._pf + "&txt=" + this._shareContent + "&r=" + getTimer();
         encodeUrl = encodeURI(loadurl);
         loader = new URLLoader();
         url = new URLRequest(encodeUrl);
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.load(url);
         QplusShareCGMessage.CG_SHARE_RESULT(Global.shareType);
         Global.control.sendNotification(Enum_MsgType.QPLUS_SHARE_EFFTER,Global.sharePoint);
      }
      else
      {
         ExternalInterface.call("share",encodeURI(LangConfig.getWord("29191",2)),encodeURI(this._shareTitle),encodeURI(this._shareContent),this._shareOutUrl);
      }
   }
   
   public function itemText(str:String, shareTitle:String, shareStr:String) : void
   {
      this._itemStr = str;
      this._shareTitle = shareTitle;
      this._shareContent = shareStr;
      this._itemTxt.text = str;
      if(Boolean(this._bitBg))
      {
         this._bitBg.x = this._itemTxt.x + this._itemTxt.width + 20;
      }
   }
   
   public function set shareState(state:int) : void
   {
      switch(state)
      {
         case 0:
            this._shareBtn.label = LangConfig.getWord("30100",3);
            this._shareBtn.enabled = false;
            this._shareBtn.mouseEnabled = false;
            this._shareBtn.visible = true;
            this._itemTxt.htmlText = "<font color=\'#999999\'>" + this._itemStr + "</font>";
            this.bitBgShow(false);
            break;
         case 1:
            this._shareBtn.label = LangConfig.getWord("30099",3);
            this._shareBtn.enabled = true;
            this._shareBtn.mouseEnabled = true;
            this._shareBtn.visible = true;
            this._itemTxt.htmlText = "<font color=\'#f9ff00\'>" + this._itemStr + "</font>";
            this.bitBgShow(true);
            break;
         case 2:
            this._shareBtn.visible = false;
            this.bitBgShow(true,"YLingQu");
            this._itemTxt.htmlText = "<font color=\'#04ff00\'>" + this._itemStr + "</font>";
      }
   }
   
   private function bitBgShow(value:Boolean, str:String = "YWanCheng") : void
   {
      var curX:Number = NaN;
      if(value)
      {
         if(!this._bitBg)
         {
            this._bitBg = ComponentUtil.getBitmap(str,this,{
               "x":278,
               "y":10
            },Global.FengXiang_Imgsdm);
         }
         else if(this.curStr != str)
         {
            curX = Number(this._bitBg.x);
            if(this.contains(this._bitBg))
            {
               removeChild(this._bitBg);
            }
            this._bitBg = null;
            this._bitBg = ComponentUtil.getBitmap(str,this,{
               "x":curX,
               "y":10
            },Global.FengXiang_Imgsdm);
            this.curStr = str;
         }
         addChild(this._bitBg);
      }
      else if(Boolean(this._bitBg) && Boolean(this.contains(this._bitBg)))
      {
         removeChild(this._bitBg);
      }
   }
}
