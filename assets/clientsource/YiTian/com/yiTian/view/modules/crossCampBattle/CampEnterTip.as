package com.yiTian.view.modules.crossCampBattle
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_CrossType;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CampEnterTip extends Panel123
   {
      
      private var txtTip:MyTextField;
      
      private var btnOk:Button;
      
      private var bg:DisplayObject;
      
      private var shape:Sprite;
      
      public function CampEnterTip()
      {
         super();
         regResource("lang/ch/ZhuaGui.swf","ZhuaGuidm");
      }
      
      public static function get instance() : CampEnterTip
      {
         return Singleton.getInstance(CampEnterTip);
      }
      
      override protected function initUI2() : void
      {
         this.shape = new Sprite();
         addChildAt(this.shape,0);
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":298,
            "height":160
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":39,
            "width":250,
            "height":112
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":68,
            "y":5
         },Global.Img_Cdm);
         this.txtTip = ComponentUtil.getTextField("",this,{
            "x":38,
            "y":54,
            "color":13816530,
            "size":12,
            "leading":8
         });
         this.txtTip.wordWrap = true;
         this.txtTip.realWidth = this.bg.width - 60;
         this.btnOk = ComponentUtil.getButton("确定进入","Button_Four",this,{
            "x":115,
            "y":113,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":261,
            "y":6,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         this.btnOk.addEventListener(MouseEvent.CLICK,this.onOk);
      }
      
      public function updateTxtTip(str:String) : void
      {
         if(!this.txtTip)
         {
            return;
         }
         this.txtTip.htmlText = str;
      }
      
      public function show(tip:String, btnStr:String, btnName:String = "ok") : void
      {
         visible = true;
         this.btnOk.name = btnName;
         this.btnOk.label = btnStr;
         this.updateTxtTip(tip);
      }
      
      private function hide(prm:* = null) : void
      {
         visible = false;
      }
      
      private function onOk(e:MouseEvent) : void
      {
         this.hide();
         if(this.btnOk.name == "enter")
         {
            Global.crossType = Enum_CrossType.CROSS_CAMP_BATTLE;
            CrossClanBattleCGMessage.CG_ENTER_BATTLE_SCENE(Global.crossType,"");
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
         this.shape.graphics.clear();
         this.shape.graphics.beginFill(0,0.5);
         this.shape.graphics.drawRect(-x,-y,Global.stage.stageWidth + x,Global.stage.stageHeight + y);
         this.shape.graphics.endFill();
      }
      
      override public function get height() : Number
      {
         return this.bg.height;
      }
      
      override public function get width() : Number
      {
         return this.bg.width;
      }
   }
}

