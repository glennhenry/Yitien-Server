package com.yiTian.view.modules
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CaiDengMiCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_CaiDengMi_Menu extends Panel123
   {
      
      private static var _instance:View_CaiDengMi_Menu;
      
      private var titleTxt:MyTextField;
      
      private var curTitleTxt:MyTextField;
      
      private var curRightTitleTxt:MyTextField;
      
      private var answerTxtArr:Array;
      
      private var lightSprArr:Array;
      
      private var clickSprArr:Array;
      
      private var titleBm:Bitmap;
      
      private var curTitleId:int;
      
      private var curPlayingId:int;
      
      private var curChooseId:int;
      
      private var haveAnsweredCount:int;
      
      private var rightCount:int;
      
      private var isPlaying:Boolean = false;
      
      private var canAnswer:Boolean = true;
      
      private var startCount:int = 0;
      
      private var helBtn:Button;
      
      public function View_CaiDengMi_Menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/CDM.swf","CDMdm");
      }
      
      public static function get instance() : View_CaiDengMi_Menu
      {
         if(!_instance)
         {
            _instance = new View_CaiDengMi_Menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var txt:MyTextField;
         var txt1:MyTextField;
         var txt2:MyTextField;
         var i:int;
         var spr:Sprite = null;
         var click:Sprite = null;
         move = new Rectangle(0,0,705,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":705,
            "height":501
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":655,
            "height":451
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":670,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         this.helBtn = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":640,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         TipManager.bind(this.helBtn,"1.活动时间内的" + HtmlUtil.fontNoSize("10/12/14/16/18/20/22点",ColorConstant.getColorStr(ColorConstant.GREEN)) + "整，在应天府刷新4个花灯，" + HtmlUtil.fontNoSize("10分钟",ColorConstant.getColorStr(ColorConstant.GREEN)) + "后花灯消失。<br/>" + "2.玩家在花灯处可以猜灯谜，每次可以猜" + HtmlUtil.fontNoSize("10道",ColorConstant.getColorStr(ColorConstant.GREEN)) + "灯谜。<br/>" + "3.玩家猜完10道灯谜或者花灯消失后，" + HtmlUtil.fontNoSize("根据玩家猜对灯谜数量",ColorConstant.getColorStr(ColorConstant.GREEN)) + "邮件发送奖励。<br/>" + "4.奖励内容：<br/>" + "   猜对" + HtmlUtil.fontNoSize("0",ColorConstant.getColorStr(ColorConstant.GREEN)) + "道，获得" + HtmlUtil.fontNoSize("小银票*1",ColorConstant.getColorStr(ColorConstant.GREEN)) + "<br/>" + "   猜对" + HtmlUtil.fontNoSize("1-3",ColorConstant.getColorStr(ColorConstant.GREEN)) + "道，获得" + HtmlUtil.fontNoSize("元宵*1",ColorConstant.getColorStr(ColorConstant.GREEN)) + "<br/>" + "   猜对" + HtmlUtil.fontNoSize("4-6",ColorConstant.getColorStr(ColorConstant.GREEN)) + "道，获得" + HtmlUtil.fontNoSize("元宵*2",ColorConstant.getColorStr(ColorConstant
         .GREEN)) + "<br/>" + "   猜对" + HtmlUtil.fontNoSize("7-9",ColorConstant.getColorStr(ColorConstant.GREEN)) + "道，获得" + HtmlUtil.fontNoSize("元宵*3",ColorConstant.getColorStr(ColorConstant.GREEN)) + "<br/>" + "   猜对" + HtmlUtil.fontNoSize("10",ColorConstant.getColorStr(ColorConstant.GREEN)) + "道，获得" + HtmlUtil.fontNoSize("元宵*4",ColorConstant.getColorStr(ColorConstant.GREEN)));
         ComponentUtil.getBitmap("Back_CDM",this,{
            "x":37,
            "y":52
         },Global.CDMdm);
         txt = ComponentUtil.getTextField("",this,{
            "x":45,
            "y":448,
            "color":16184781,
            "size":12,
            "leading":4
         });
         txt.multiline = true;
         txt.htmlText = "注意：活动时间内的" + HtmlUtil.fontNoSize("10/12/14/16/18/20/22点",ColorConstant.getColorStr(ColorConstant.GREEN)) + "，在应天府花灯处猜灯谜，" + HtmlUtil.fontNoSize("10分钟",ColorConstant.getColorStr(ColorConstant.GREEN)) + "内猜完" + HtmlUtil.fontNoSize("10道",ColorConstant.getColorStr(ColorConstant.GREEN)) + "灯谜，" + HtmlUtil.fontNoSize("关闭界面或者掉<br/>线按照错误处理",ColorConstant.getColorStr(ColorConstant.GREEN)) + "，猜完灯谜" + HtmlUtil.fontNoSize("按照正确问题数量",ColorConstant.getColorStr(ColorConstant.GREEN)) + "发送奖励给玩家。";
         ComponentUtil.getBitmap("Title_CDM",this,{
            "x":272,
            "y":5
         },Global.CDMdm);
         this.titleBm = ComponentUtil.getBitmap("Back_TiMu",this,{
            "x":136,
            "y":163
         },Global.CDMdm);
         this.titleTxt = ComponentUtil.getTextField("",this,{
            "x":167,
            "y":167,
            "color":16776960,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.titleTxt.align = "center";
         this.titleTxt.width = 376;
         this.titleTxt.wordWrap = true;
         this.titleTxt.multiline = true;
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":484,
            "y":59,
            "width":108,
            "height":25
         },Global.Img_Cdm);
         txt1 = ComponentUtil.getTextField("当前第10题  （每小时每个玩家可以猜 10道题）",this,{
            "x":117,
            "y":62,
            "color":16184781,
            "size":12,
            "leading":0
         });
         txt1.htmlText = "当前第    题  " + HtmlUtil.fontNoSize("（每小时每个玩家可以猜10道题）",ColorConstant.getColorStr(ColorConstant.YELLOW));
         this.curTitleTxt = ComponentUtil.getTextField("1",this,{
            "x":161,
            "y":62,
            "color":327424,
            "size":12,
            "leading":0
         },"center");
         txt2 = ComponentUtil.getTextField("当前正确    题",this,{
            "x":497,
            "y":62,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.curRightTitleTxt = ComponentUtil.getTextField("1",this,{
            "x":552,
            "y":62,
            "color":16776960,
            "size":12,
            "leading":0
         },"center");
         this.lightSprArr = [];
         this.answerTxtArr = [];
         this.clickSprArr = [];
         i = 0;
         while(i < 4)
         {
            spr = new Sprite();
            addChild(spr);
            spr.x = 95 + i * 120;
            spr.y = 205;
            spr.mouseEnabled = false;
            spr.mouseChildren = false;
            ComponentUtil.getBitmap("Back_DengLongY",spr,null,Global.CDMdm);
            this.answerTxtArr.push(ComponentUtil.getTextField("",spr,{
               "x":76,
               "y":85,
               "color":16776960,
               "size":14,
               "leading":0
            },"center"));
            this.lightSprArr.push(spr);
            click = new Sprite();
            addChild(click);
            click.buttonMode = true;
            click.x = spr.x + 26;
            click.y = spr.y + 16;
            click.graphics.beginFill(0,0);
            click.graphics.drawRect(0,0,100,180);
            click.graphics.endFill();
            click.addEventListener(MouseEvent.CLICK,this.onAnswer);
            this.clickSprArr.push(click);
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(this.isPlaying && !value)
         {
            UIManager.centerBroadcast.addMsg("动画播放中，请稍等");
            return;
         }
         super.visible = value;
         if(value == false)
         {
            CaiDengMiCGMessage.CG_CaiDengMi_CHOISE(0);
         }
      }
      
      public function setData(titleId:int, haveAnsweredCount:int, rightCount:int) : void
      {
         this.canAnswer = true;
         this.curTitleId = titleId;
         this.haveAnsweredCount = haveAnsweredCount;
         this.rightCount = rightCount;
         if(!this.isPlaying)
         {
            this.setTitle();
         }
      }
      
      private function setTitle() : void
      {
         var i:* = undefined;
         Tween.to(this.titleTxt,1000,{
            "x":[0,167],
            "alpha":[0,1]
         });
         this.startCount = 0;
         for(i in this.lightSprArr)
         {
            Tween.to(this.lightSprArr[i],1000,{
               "x":[-5,95 + 120 * i],
               "alpha":[0,1]
            },this.onStartComplete);
         }
         this.titleTxt.text = Data_lib.caidengmi[this.curTitleId][0];
         this.curTitleTxt.text = String(this.haveAnsweredCount + 1);
         this.curRightTitleTxt.text = String(this.rightCount);
         this.answerTxtArr[0].text = Data_lib.caidengmi[this.curTitleId][1];
         this.answerTxtArr[1].text = Data_lib.caidengmi[this.curTitleId][2];
         this.answerTxtArr[2].text = Data_lib.caidengmi[this.curTitleId][3];
         this.answerTxtArr[3].text = Data_lib.caidengmi[this.curTitleId][4];
         if(this.titleTxt.height > 21)
         {
            this.titleBm.height = this.titleTxt.height + 10;
         }
         else
         {
            this.titleBm.height = 30;
         }
      }
      
      public function end() : void
      {
         var i:* = undefined;
         for(i in this.lightSprArr)
         {
            Tween.stop(this.lightSprArr[i]);
         }
         Tween.stop(this.titleTxt);
         this.lightSprArr[this.curPlayingId - 1].y = 205;
         this.lightSprArr[this.curPlayingId - 1].alpha = 1;
         this.isPlaying = false;
         super.visible = false;
      }
      
      private function onAnswer(e:MouseEvent) : void
      {
         var i:* = undefined;
         if(this.isPlaying)
         {
            UIManager.centerBroadcast.addMsg("动画播放中，请稍等");
            return;
         }
         if(!this.canAnswer)
         {
            return;
         }
         this.isPlaying = true;
         this.canAnswer = false;
         this.curPlayingId = Data_lib.caidengmi[this.curTitleId][6];
         for(i in this.lightSprArr)
         {
            if(i == this.curPlayingId - 1)
            {
               Tween.curTo(this.lightSprArr[i],1000,{
                  "y":100,
                  "alpha":0
               },this.onPlayingComplete);
            }
            else
            {
               Tween.curTo(this.lightSprArr[i],1000,{
                  "x":555,
                  "alpha":0
               });
            }
         }
         Tween.curTo(this.titleTxt,1000,{
            "x":334,
            "alpha":0
         });
         switch(e.currentTarget)
         {
            case this.clickSprArr[0]:
               CaiDengMiCGMessage.CG_CaiDengMi_CHOISE(1);
               break;
            case this.clickSprArr[1]:
               CaiDengMiCGMessage.CG_CaiDengMi_CHOISE(2);
               break;
            case this.clickSprArr[2]:
               CaiDengMiCGMessage.CG_CaiDengMi_CHOISE(3);
               break;
            case this.clickSprArr[3]:
               CaiDengMiCGMessage.CG_CaiDengMi_CHOISE(4);
         }
      }
      
      private function onPlayingComplete() : void
      {
         this.lightSprArr[this.curPlayingId - 1].y = 205;
         this.lightSprArr[this.curPlayingId - 1].alpha = 1;
         this.setTitle();
      }
      
      private function onStartComplete() : void
      {
         ++this.startCount;
         if(this.startCount == 4)
         {
            this.isPlaying = false;
         }
      }
   }
}

