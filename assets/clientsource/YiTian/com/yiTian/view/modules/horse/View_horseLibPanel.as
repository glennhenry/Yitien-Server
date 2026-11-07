package com.yiTian.view.modules.horse
{
   import Layout.VGroup;
   import com.ui.controls.Tapper;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.HorseCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.activity.DefaultTappBtnFac;
   import com.yiTian.view.modules.horse.starSign.Model_XingZuo;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class View_horseLibPanel extends Panel123
   {
      
      private var _tapper:Tapper;
      
      private var _bg:DisplayObject;
      
      public var libPan:Child_horseJinJieLib;
      
      public var cardPan:Child_horseCardLib;
      
      public var xingZuoPan:Child_horseXZLib;
      
      private var _hasStarSign:Boolean = false;
      
      public function View_horseLibPanel()
      {
         super();
         regResource(HorseConfig.HORSE_SWFURL,"ZuoQi_c01_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":756,
            "height":566
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("ZQTuJian",this,{
            "x":325,
            "y":2
         },Global.ZuoQi_c01_Imgsdm);
         this._tapper = new Tapper(new DefaultTappBtnFac(),Global.stage,new VGroup(6,0,0,0,0,76));
         this._tapper.x = 24;
         this._tapper.y = 46;
         addChild(this._tapper);
         this.libPan = new Child_horseJinJieLib();
         this.cardPan = new Child_horseCardLib();
         this._tapper.appendTapper({
            "label":LangConfig.getWord("29477",2),
            "style":"TabButton_Four",
            "dm":Global.Img_Cdm
         },this.libPan);
         this._tapper.appendTapper({
            "label":LangConfig.getWord("29478",2),
            "style":"TabButton_Four",
            "dm":Global.Img_Cdm
         },this.cardPan);
         move = new Rectangle(0,0,this._bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":724,
            "y":8,
            "callBack":this.hide
         },Global.Img_Cdm);
      }
      
      private function tryAddStarSignTap() : void
      {
         if(this._hasStarSign)
         {
            return;
         }
         if(Model_XingZuo.signIndex != -1)
         {
            this._hasStarSign = true;
            this.xingZuoPan = new Child_horseXZLib();
            this._tapper.appendTapper({
               "label":"星座坐骑",
               "style":"TabButton_Four",
               "dm":Global.Img_Cdm
            },this.xingZuoPan);
         }
      }
      
      public function show(index:int = 1) : void
      {
         this._tapper.setSelectedIndex(index);
         this.visible = true;
         pop(Global.stage.mouseX / Global.stage.stageWidth,Global.stage.mouseY / Global.stage.stageHeight);
         HorseCGMessage.CG_HORSE_LIB();
         this.tryAddStarSignTap();
      }
      
      public function hide(param:* = null) : void
      {
         this.visible = false;
      }
      
      private function onFrame(i:int) : void
      {
         Global.control.sendNotification(HorseConfig.HorseLibPanelFrame,i);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
            Global.control.registerCallBack("abbb",this.tryAddStarSignTap);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
            Global.control.removeCallBack("abbb",this.tryAddStarSignTap);
         }
         super.visible = value;
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
   }
}

