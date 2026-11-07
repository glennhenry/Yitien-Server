package com.yiTian.view.modules.activity
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.horse.View_horsePanel;
   import com.yiTian.view.modules.pet.PetPanel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_ThreeTopicAct extends Panel123
   {
      
      private static var _instance:View_ThreeTopicAct;
      
      private static var SOURCE_URL:String = "lang/ch/ThreeTopicAct.swf";
      
      private static var COLOR1:uint = 15063965;
      
      private var back:Sprite;
      
      private var backBitmap:ScaleBitmap;
      
      private var horseBtn:Sprite;
      
      private var petBtn:Sprite;
      
      private var equipBtn:Sprite;
      
      private var mountTF:MyTextField;
      
      private var petTF:MyTextField;
      
      private var equipTF:MyTextField;
      
      private var titleBg:Bitmap;
      
      public function View_ThreeTopicAct()
      {
         super();
         init();
      }
      
      public static function get instance() : View_ThreeTopicAct
      {
         return Boolean(_instance) ? _instance : (_instance = new View_ThreeTopicAct());
      }
      
      override protected function initStaticView() : void
      {
         this.back = new Sprite();
         addChild(this.back);
         this.backBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.back,{
            "x":0,
            "y":0,
            "width":559,
            "height":554
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.back,{
            "x":25,
            "y":47,
            "width":510,
            "height":499
         },Global.Img_Cdm);
         move = new Rectangle(0,0,559,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":522,
            "y":6
         },Global.Img_Cdm);
      }
      
      override protected function initUI2() : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_SDZTHD",this,{
            "x":200,
            "y":6
         },Global.SHDdm);
         ComponentUtil.getBitmap("BG_HD",this,{
            "x":27,
            "y":49
         },Global.SHDdm);
         this.horseBtn = new Sprite();
         this.horseBtn.buttonMode = true;
         addChild(this.horseBtn);
         ComponentUtil.getBitmap("BT_LJJJ_up",this.horseBtn,{
            "x":400,
            "y":249
         },Global.SHDdm);
         this.horseBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.horseBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRollHandler);
         this.horseBtn.addEventListener(MouseEvent.ROLL_OUT,this.onRollHandler);
         this.petBtn = new Sprite();
         this.petBtn.buttonMode = true;
         addChild(this.petBtn);
         ComponentUtil.getBitmap("BT_MSTS_up",this.petBtn,{
            "x":400,
            "y":357
         },Global.SHDdm);
         this.petBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.petBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRollHandler);
         this.petBtn.addEventListener(MouseEvent.ROLL_OUT,this.onRollHandler);
         this.equipBtn = new Sprite();
         this.equipBtn.buttonMode = true;
         addChild(this.equipBtn);
         ComponentUtil.getBitmap("BT_LJQH",this.equipBtn,{
            "x":400,
            "y":478
         },Global.SHDdm);
         this.equipBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.equipBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRollHandler);
         this.equipBtn.addEventListener(MouseEvent.ROLL_OUT,this.onRollHandler);
         ComponentUtil.getTextField("活动时间:5月3日-5月9日",this,{
            "x":342,
            "y":162,
            "color":COLOR1,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.mountTF = ComponentUtil.getTextField("",this,{
            "x":179,
            "y":189,
            "size":12,
            "leading":5
         });
         this.mountTF.realWidth = 320;
         this.mountTF.wordWrap = true;
         this.mountTF.htmlText = "      活动期间，玩家将坐骑成功进阶到一个新等级，则赠送相应下一等级的坐骑进阶丹1颗！\n" + "<font color=\'#EEF460\'>如:玩家将坐骑进阶到麒麟，则赠送赠送真龙进阶丹1颗！</font>\n" + "<font color=\'#EEF460\'>（奖励以邮件形式发送）</font>";
         this.petTF = ComponentUtil.getTextField("",this,{
            "x":179,
            "y":316,
            "size":12,
            "leading":5
         });
         this.petTF.realWidth = 320;
         this.petTF.wordWrap = true;
         this.petTF.htmlText = "      活动期间，玩家将宠物成长等级提升到<font color=\'#EEF460\'>7级</font>，赠送<font color=\'#EEF460\'>高级成长丹5颗</font>！" + "<font color=\'#EEF460\'>（奖励以邮件形式发送）</font>";
         this.equipTF = ComponentUtil.getTextField("",this,{
            "x":179,
            "y":433,
            "size":12,
            "leading":7
         });
         this.equipTF.realWidth = 320;
         this.equipTF.wordWrap = true;
         this.equipTF.htmlText = "      活动期间，拥有<font color=\'#EEF460\'>+8套</font>或<font color=\'#EEF460\'>+8套以上</font>装备的玩家" + "（<font color=\'#EEF460\'>不括包坐骑和时装</font>），" + "系统将赠送<font color=\'#EEF460\'>高级强化石6个</font>和" + HtmlUtil.font("高级幸运符3个！","#EEF460") + "<font color=\'#EEF460\'>（奖励以邮件形式发送）</font>";
         ComponentUtil.setPropertie(this.titleBg,{
            "x":(this.width - this.titleBg.width) / 2,
            "y":6
         });
      }
      
      private function onClickHandler(e:MouseEvent) : void
      {
         var pnl1:View_horsePanel = null;
         var target:Sprite = e.currentTarget as Sprite;
         switch(target)
         {
            case this.horseBtn:
               pnl1 = Singleton.getInstance(View_horsePanel);
               Global.delegate.dosomething(pnl1,function():void
               {
                  pnl1.show(1);
               });
               break;
            case this.petBtn:
               if(Boolean(UIManager.petPanel.petVO))
               {
                  UIManager.petPanel.visible = !UIManager.petPanel.visible;
                  if(UIManager.petPanel.visible)
                  {
                     UIManager.petPanel.openView(PetPanel.LIANHUA,0);
                  }
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
               break;
            case this.equipBtn:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(0);
                  break;
               }
               UIManager.castPanel.openView(0);
         }
      }
      
      private function onRollHandler(e:MouseEvent) : void
      {
         var target:DisplayObject = e.target as DisplayObject;
         switch(e.type)
         {
            case MouseEvent.ROLL_OVER:
               target.transform.colorTransform = Util.colorWhite2;
               break;
            case MouseEvent.ROLL_OUT:
               target.transform.colorTransform = Util.colorNomal;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.SHDdm)
            {
               regResource(SOURCE_URL,"SHDdm");
               preFun();
            }
            else if(!this.titleBg)
            {
               this.initUI2();
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
         return 559;
      }
      
      override public function get height() : Number
      {
         return 554;
      }
   }
}

