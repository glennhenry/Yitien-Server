package com.yiTian.view.modules.crossCampBattle
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_CrossType;
   import com.yiTian.net.message.cg.CrossCampBattleCGMessage;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_CrossCampMainPanel extends Panel123
   {
      
      private var bg:DisplayObject;
      
      private var btnMatch:Button;
      
      private var time:int;
      
      private var lastTime:uint;
      
      private var startBigmap:Bitmap;
      
      private var stopBigmap:Bitmap;
      
      private var enterBigmap:Bitmap;
      
      private var txtTime:MyTextField;
      
      public function View_CrossCampMainPanel()
      {
         super();
         regResource("lang/ch/JCYB.swf","crossCampBattle_Imgdm");
      }
      
      public static function get instance() : View_CrossCampMainPanel
      {
         return Singleton.getInstance(View_CrossCampMainPanel);
      }
      
      override protected function initUI2() : void
      {
         var helBtn:Button;
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":716,
            "height":463
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":666,
            "height":413
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":682,
            "y":6,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_JCYB",this,{
            "x":37,
            "y":52
         },Global.crossCampBattle_Imgdm);
         ComponentUtil.getBitmap("Title_JCYB",this,{
            "x":278,
            "y":5
         },Global.crossCampBattle_Imgdm);
         this.btnMatch = ComponentUtil.getButton("","Button_JCYB",this,{
            "x":295,
            "y":378,
            "textColor":16771436
         },Global.crossCampBattle_Imgdm);
         this.enterBigmap = ComponentUtil.getBitmap("Text_JRJC",this,{
            "x":320,
            "y":391
         },Global.crossCampBattle_Imgdm);
         this.startBigmap = ComponentUtil.getBitmap("Text_KSPP",this,{
            "x":320,
            "y":384
         },Global.crossCampBattle_Imgdm);
         this.stopBigmap = ComponentUtil.getBitmap("Text_QXPP",this,{
            "x":320,
            "y":384
         },Global.crossCampBattle_Imgdm);
         this.txtTime = ComponentUtil.getTextField("00：00：00",this,{
            "x":328,
            "y":403,
            "color":16777215,
            "size":14,
            "leading":0
         });
         helBtn = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":this.bg.width - 58,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         helBtn.addEventListener(MouseEvent.CLICK,function():void
         {
            View_CrossCampBattleRulePanel.instance.visible = true;
         });
         this.enterBigmap.visible = false;
         this.startBigmap.visible = true;
         this.stopBigmap.visible = false;
         this.btnMatch.name = "startMatch";
         this.btnMatch.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(e:MouseEvent) : void
      {
         switch(this.btnMatch.name)
         {
            case "startMatch":
               CrossCampBattleCGMessage.CG_MATCH(Enum_CrossCampBattle.START);
               break;
            case "stopMatch":
               CrossCampBattleCGMessage.CG_MATCH(Enum_CrossCampBattle.CANCEL);
               break;
            case "enter":
               if(Model_CrossCampBattle.notEnterScene() == true)
               {
                  return;
               }
               Global.crossType = Enum_CrossType.CROSS_CAMP_BATTLE;
               CrossClanBattleCGMessage.CG_ENTER_BATTLE_SCENE(Global.crossType,"");
         }
      }
      
      public function setBtnName(value:Boolean) : void
      {
         if(!this.btnMatch)
         {
            return;
         }
         if(this.time <= 0)
         {
            this.btnMatch.name = "enter";
            return;
         }
         if(value == true)
         {
            this.btnMatch.name = "stopMatch";
         }
         else if(Model_CrossCampBattle.isMatch == false)
         {
            this.btnMatch.name = "startMatch";
         }
      }
      
      public function update(time:int) : void
      {
         visible = true;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         this.time = time;
         this.setBtnLable();
      }
      
      private function frameStep() : void
      {
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 1000)
         {
            --this.time;
            this.lastTime = now;
            this.setBtnLable();
         }
      }
      
      public function showEnterBitmap() : void
      {
         this.time = 0;
         this.setBtnLable();
      }
      
      private function setBtnLable() : void
      {
         if(this.time <= 0)
         {
            this.btnMatch.name = "enter";
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         }
         if(this.btnMatch.name == "startMatch")
         {
            this.enterBigmap.visible = false;
            this.startBigmap.visible = true;
            this.stopBigmap.visible = false;
            this.txtTime.htmlText = DateUtil.getHMSBySecond2(this.time);
         }
         else if(this.btnMatch.name == "stopMatch")
         {
            this.enterBigmap.visible = false;
            this.startBigmap.visible = false;
            this.stopBigmap.visible = true;
            this.txtTime.htmlText = DateUtil.getHMSBySecond2(this.time);
         }
         else
         {
            this.enterBigmap.visible = true;
            this.startBigmap.visible = false;
            this.stopBigmap.visible = false;
            this.txtTime.htmlText = "";
         }
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
      }
   }
}

