package com.yiTian.view.modules.yellowDiamond
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_qqOnLine extends Panel
   {
      
      public static var awardType:int;
      
      private static const ITEM_LEN:int = 3;
      
      private static var isFirstOpen:Boolean = true;
      
      private static var isLoad:Boolean = false;
      
      public static var tx:int = 20;
      
      public static var ty:int = 50;
      
      private var back:DisplayObject;
      
      private var bmp:Bitmap;
      
      private var str:String;
      
      private var str2:String = "爱玩登陆游戏即可领取爱玩连续登录奖励" + "\n" + "若中途有中断爱玩登录则连续登陆天数记录将清零";
      
      private var str3:String = "盒子登陆游戏即可领取盒子连续登录奖励" + "\n" + "若中途有中断盒子登录则连续登陆天数记录将清零";
      
      private var itemVec:Vector.<OnLineItem> = new Vector.<OnLineItem>();
      
      private var tfDescrip:MyTextField;
      
      private var _daysType:int;
      
      private var timeOutArr:Array = [];
      
      public function View_qqOnLine()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var urlS:String = null;
         var i:int = 0;
         var item:OnLineItem = null;
         super.initStaticView();
         this.str = LangConfig.getWord("60371",6) + "\n" + LangConfig.getWord("60372",6);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":526,
            "height":276
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":478,
            "height":226
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":110,
            "width":458,
            "height":146
         },Global.Img_Cdm);
         move = new Rectangle(0,0,498,38);
         this.bmp = new Bitmap();
         addChild(this.bmp);
         this.bmp.x = 32;
         this.bmp.y = 50;
         if(Global.pf == Enum_SPStr.QQGAME)
         {
            urlS = this.str;
         }
         else if(Global.pf == Enum_SPStr.CHITU)
         {
            urlS = this.str3;
         }
         else
         {
            urlS = this.str2;
         }
         ComponentUtil.getTextField(urlS,this,{
            "x":105,
            "y":56,
            "color":14662240,
            "leading":3,
            "realWidth":388,
            "realHeight":40,
            "multiline":true,
            "wordWrap":true
         });
         i = 0;
         while(i < ITEM_LEN)
         {
            item = new OnLineItem();
            item.init();
            item.x = 23;
            item.y = 114 + i * 45;
            addChild(item);
            this.itemVec.push(item);
            i++;
         }
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":492,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         if(Global.pf == Enum_SPStr.QQGAME)
         {
            YelloDiaCGMessage.CG_OPEN_QQGIFT();
         }
         else if(Global.pf == Enum_SPStr.CHITU)
         {
            YelloDiaCGMessage.CG_OPEN_CHITU_GIFT();
         }
      }
      
      public function update(_days:int, status:int, _type:int) : void
      {
         if(status == 1)
         {
            UIManager.yellowDiamond.showQQgift();
         }
         else
         {
            UIManager.yellowDiamond.removeQQgift();
         }
         awardType = _type;
         this._daysType = _days;
         if(awardType == 1 || awardType == 3)
         {
            if(Global.pf == Enum_SPStr.CHITU)
            {
               awardType = 3;
            }
            else if(Global.pf == Enum_SPStr.QQGAME)
            {
               awardType = 1;
            }
         }
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            this.itemVec[i].setGridCount(i + 1);
            i++;
         }
         if(_days >= 3)
         {
            _days = 3;
         }
         if(_days == 1)
         {
            this.itemVec[0].data = {
               "day":_days,
               "status":status
            };
            this.itemVec[1].data = {
               "day":2,
               "status":0
            };
            this.itemVec[2].data = {
               "day":3,
               "status":0
            };
         }
         else if(_days == 2)
         {
            this.itemVec[0].data = {
               "day":1,
               "status":2
            };
            this.itemVec[1].data = {
               "day":_days,
               "status":status
            };
            this.itemVec[2].data = {
               "day":3,
               "status":0
            };
         }
         else if(_days >= 3)
         {
            this.itemVec[0].data = {
               "day":1,
               "status":2
            };
            this.itemVec[1].data = {
               "day":2,
               "status":2
            };
            this.itemVec[2].data = {
               "day":_days,
               "status":status
            };
         }
      }
      
      public function getGoods() : void
      {
         if(this._daysType < 4)
         {
            this.itemVec[this._daysType - 1].getGoods();
         }
         else
         {
            this.itemVec[2].getGoods();
         }
         UIManager.yellowDiamond.removeQQgift();
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               isFirstOpen = false;
               if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.CHITU)
               {
                  if(Global.pf == Enum_SPStr.QQGAME)
                  {
                     Utils.getLoadBitmap("resource/image/Diamond/QQ_Game.png",this.bmp,null,this.callEff);
                  }
                  else if(Global.pf == Enum_SPStr.CHITU)
                  {
                     Utils.getLoadBitmap("resource/image/Diamond/Icon_ChiTu.png",this.bmp);
                  }
               }
               if(!Global.QQGame_Imgsdm)
               {
                  SingleLoader.add("lang/ch/QQGame_Imgs.swf",function(info:Object):void
                  {
                     Global.QQGame_Imgsdm = info.applicationDomain;
                     showBmp();
                  });
               }
               else if(!isLoad)
               {
                  this.showBmp();
               }
            }
            else if(Global.pf == Enum_SPStr.QQGAME)
            {
               this.callEff();
            }
         }
      }
      
      private function showBmp() : void
      {
         if(Global.pf == Enum_SPStr.QQGAME)
         {
            ComponentUtil.getBitmap("Title_LeiJiAward",this,{
               "x":153,
               "y":5
            },Global.QQGame_Imgsdm);
         }
         else if(Enum_SPStr.isUnion(Global.pf))
         {
            ComponentUtil.getBitmap("Box",this,{
               "x":42,
               "y":50
            },Global.QQGame_Imgsdm);
            ComponentUtil.getBitmap("Title_AiWan",this,{
               "x":153,
               "y":5
            },Global.QQGame_Imgsdm);
         }
         else if(Global.pf == Enum_SPStr.CHITU)
         {
            ComponentUtil.getBitmap("Title_CTLJ",this,{
               "x":180,
               "y":5
            },Global.QQGame_Imgsdm);
         }
         isLoad = true;
      }
      
      public function callEff() : void
      {
         if(!visible)
         {
            if(Boolean(this.timeOutArr.length))
            {
               clearTimeout(this.timeOutArr.shift());
            }
            return;
         }
         this.timeOutArr.push(setTimeout(this._eff,2000));
      }
      
      public function _eff() : void
      {
         Tween.to(this.bmp,500,{
            "x":[tx + this.bmp.width / 2 - 15,tx],
            "y":[ty + this.bmp.height / 2,ty],
            "scaleX":[0,1],
            "scaleY":[0,1]
         },function():void
         {
            clearTimeout(timeOutArr.shift());
            callEff();
         });
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 522) / 2;
         y = (Global.stage.stageHeight - 271) / 2;
      }
   }
}

