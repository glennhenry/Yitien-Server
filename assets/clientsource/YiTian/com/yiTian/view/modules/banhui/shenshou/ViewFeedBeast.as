package com.yiTian.view.modules.banhui.shenshou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_shenshou;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ShenshouCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   
   public class ViewFeedBeast extends Panel
   {
      
      private static var starNum:int = 5;
      
      private var starEmptyBm:Bitmap = new Bitmap();
      
      private var starFullBm:Bitmap = new Bitmap();
      
      private var fixWid:int = 32;
      
      private var fixHei:int = 50;
      
      private var starArr:Array = new Array();
      
      private var starText:MyTextField;
      
      private var tipText:MyTextField;
      
      private var refreshBtn:Button;
      
      private var feedBtn:Button;
      
      private var refreshTxt:MyTextField;
      
      private var feedTxt:MyTextField;
      
      private var back:ScaleBitmap;
      
      private var starFullArr:Array = new Array();
      
      private var starEmptyArr:Array = new Array();
      
      private var challState:int;
      
      private var isfirstEn:Boolean = false;
      
      private var reCostTxt:MyTextField;
      
      private var feedCostTxt:MyTextField;
      
      private var exFeedCost:int = 0;
      
      private var whitefull:Bitmap;
      
      private var urlStr:String = "resource/image/star/";
      
      private var urlFullArr:Array = ["whiteFull.png","greenFull.png","brueFull.png","purpleFull.png","orangeFull.png"];
      
      private var urlEmptyArr:Array = ["whiteEmpty.png","greenEmpty.png","blueEmpty.png","purpleEmpty.png","orangeEmpty.png"];
      
      private var colArr:Array = ["#ffffff","#04ff00","#33CCFF","#de45c7","#ff7700"];
      
      private var growValueArr:Array = [10,20,30,50,100];
      
      private var fateChestArr:Array = [46566,46567,46568,46569,46570];
      
      public function ViewFeedBeast()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":370,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":322,
            "height":160
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         this.whitefull = new Bitmap();
         addChild(this.whitefull);
         Utils.getLoadBitmap("resource/image/star/whiteFull.png",this.whitefull,{
            "x":110,
            "y":this.fixHei
         });
         this.addEmpty(int(1));
         this.starText = ComponentUtil.getTextField("",this,{
            "x":56,
            "y":85,
            "size":12,
            "leading":0
         });
         this.starText.multiline = true;
         this.starText.htmlText = this.getStarGift(0);
         this.refreshTxt = ComponentUtil.getTextField("",this,{
            "x":133,
            "y":127,
            "size":12,
            "leading":0
         });
         this.reCostTxt = ComponentUtil.getTextField("",this,{
            "x":210,
            "y":127,
            "color":13369344,
            "size":12,
            "leading":0
         });
         this.feedTxt = ComponentUtil.getTextField("",this,{
            "x":133,
            "y":150,
            "size":12,
            "leading":0
         });
         this.feedCostTxt = ComponentUtil.getTextField("",this,{
            "x":190,
            "y":150,
            "color":13369344,
            "size":12,
            "leading":0
         });
         this.tipText = ComponentUtil.getTextField("",this,{
            "x":82,
            "y":175,
            "size":12,
            "leading":0
         });
         this.tipText.htmlText = LangConfig.getWord("30106",3);
         this.tipText.link("#de45c7");
         this.tipText.mouseEnabled = true;
         this.tipText.addEventListener(TextEvent.LINK,this.tipHandle);
         this.refreshTxt.htmlText = "<a href=\'event:myEvent\'>" + LangConfig.getWord("30045",3) + "</a>";
         this.feedTxt.htmlText = "<a href=\'event:myEvent\'>" + LangConfig.getWord("30046",3) + "</a>";
         this.refreshTxt.link();
         this.feedTxt.link();
         this.refreshTxt.mouseEnabled = true;
         this.feedTxt.mouseEnabled = true;
         this.refreshTxt.addEventListener(TextEvent.LINK,this.refreshStar);
         this.feedTxt.addEventListener(TextEvent.LINK,this.feedSure);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":336,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      private function initT() : void
      {
         ComponentUtil.getBitmap("Title_BangFeed",this,{
            "x":105,
            "y":5
         },Global.Bang_Imgsdm);
         ComponentUtil.getBitmap("Icon_Meat14",this,{
            "x":118,
            "y":154
         },Global.Bang_Imgsdm);
         ComponentUtil.getBitmap("Icon_Fresh14",this,{
            "x":118,
            "y":132
         },Global.Bang_Imgsdm);
      }
      
      private function tipHandle(eve:TextEvent) : void
      {
         UIManager.openVipPanel.visible = true;
      }
      
      private function refreshStar(eve:TextEvent) : void
      {
         if(this.starFullArr.length == 5)
         {
            View_Alert.show(LangConfig.getWord("30051",3),View_Alert.OK);
            return;
         }
         if(Model_shenshou.challBoo == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30042",3));
            return;
         }
         ShenshouCGMessage.CG_FEED_LEVEL();
      }
      
      private function feedSure(eve:TextEvent) : void
      {
         var sureHandle:Function;
         var t:int = Model_shenshou.challBoo;
         if(Model_shenshou.challBoo == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30038",3));
            return;
         }
         if(Model_shenshou.feedState == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30103",3));
            return;
         }
         if(this.exFeedCost > 0)
         {
            sureHandle = function():void
            {
               ShenshouCGMessage.CG_FEED_BEAST(2);
            };
            View_Alert.show(LangConfig.getWord("30084",3,this.exFeedCost),View_Alert.OK_CANCAL,sureHandle);
         }
         else
         {
            ShenshouCGMessage.CG_FEED_BEAST(2);
         }
      }
      
      public function updateStarNum(num:int, reCost:int, exFedCost:int = 0) : void
      {
         if(!visible)
         {
            return;
         }
         this.reCostTxt.text = "(" + reCost.toString() + LangConfig.getWord("30085",3) + ")";
         this.feedCostTxt.text = "(" + String(num * 2000) + LangConfig.getWord("30086",3) + ")";
         this.starText.htmlText = this.getStarGift(num - 1);
         this.exFeedCost = exFedCost;
         var len:int = int(this.starFullArr.length);
         if(num == len && num != 1)
         {
            return;
         }
         this.removeStarNum();
         this.addFull(num);
         this.addEmpty(num);
      }
      
      private function getStarGift(id:int) : String
      {
         var desc:String = null;
         var starDesc:String = String(id + 1) + LangConfig.getWord("30104",3);
         var growValue:String = String(this.growValueArr[id]);
         var propId:int = int(this.fateChestArr[id]);
         var propName:String = Data_lib.item[propId][Enum_lib_item.STR_NAME];
         var col:String = String(this.colArr[id]);
         starDesc = "<font color=\'" + col + "\'>" + starDesc + "</font>";
         propName = "<font color=\'" + col + "\'>" + propName + "</font>";
         return starDesc + LangConfig.getWord("30105",3,growValue,propName);
      }
      
      private function addEmpty(t:int) : void
      {
         var curBit:Bitmap = null;
         var str:String = this.urlEmptyArr[t - 1];
         var url:String = this.urlStr + str;
         var i:int = t;
         while(i < starNum)
         {
            curBit = new Bitmap();
            addChild(curBit);
            this.starEmptyArr.push(curBit);
            Utils.getLoadBitmap(url,curBit,{
               "x":110 + i * this.fixWid,
               "y":this.fixHei
            });
            i++;
         }
      }
      
      private function addFull(t:int) : void
      {
         var url:String = null;
         var curBit:Bitmap = null;
         var str:String = String(this.urlFullArr[t - 1]);
         var i:int = 0;
         while(i < t)
         {
            url = this.urlStr + str;
            curBit = new Bitmap();
            addChild(curBit);
            this.starFullArr.push(curBit);
            Utils.getLoadBitmap(url,curBit,{
               "x":110 + i * this.fixWid,
               "y":this.fixHei
            });
            i++;
         }
      }
      
      public function removeStarNum() : void
      {
         var bitFull:Bitmap = null;
         var bitEmpty:Bitmap = null;
         while(this.starFullArr.length > 0)
         {
            bitFull = this.starFullArr[0] as Bitmap;
            if(this.contains(bitFull))
            {
               this.removeChild(bitFull);
            }
            this.starFullArr.shift();
         }
         while(this.starEmptyArr.length > 0)
         {
            bitEmpty = this.starEmptyArr[0] as Bitmap;
            if(this.contains(bitEmpty))
            {
               this.removeChild(bitEmpty);
            }
            this.starEmptyArr.shift();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.isfirstEn)
            {
               this.isfirstEn = true;
               if(!Global.Bang_Imgsdm)
               {
                  SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
                  {
                     Global.Bang_Imgsdm = info.applicationDomain;
                     initT();
                  });
               }
               else
               {
                  this.initT();
               }
            }
            UIManager.banghuiBack.bangShenShou.removeFeedEff();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

