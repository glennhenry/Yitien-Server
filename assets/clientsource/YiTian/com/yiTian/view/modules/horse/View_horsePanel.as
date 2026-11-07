package com.yiTian.view.modules.horse
{
   import Layout.VGroup;
   import com.ui.controls.Tapper;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.activity.DefaultTappBtnFac;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class View_horsePanel extends Panel123
   {
      
      private var _tapper:Tapper;
      
      private var _bg:DisplayObject;
      
      public var horsePart:Child_horsePartTap;
      
      public var horseJinJie:Child_horseJinjieTap;
      
      public var qiangHua:Child_horseQiangHuaTap;
      
      public function View_horsePanel()
      {
         super();
         regResource(HorseConfig.HORSE_SWFURL,"ZuoQi_c01_Imgsdm");
         regResource("lang/ch/wordEffects.swf","wordEffect");
      }
      
      override protected function initUI2() : void
      {
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":644,
            "height":382
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":23,
            "y":67,
            "width":597,
            "height":305
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_ZuoQi",this,{
            "x":239,
            "y":5
         },Global.ZuoQi_c01_Imgsdm);
         this._tapper = new Tapper(new DefaultTappBtnFac(),Global.stage,new VGroup(0,0,0,0,0,75));
         this._tapper.x = 29;
         this._tapper.y = 46;
         addChild(this._tapper);
         this._tapper.appendTapper({
            "label":LangConfig.getWord("29456",2),
            "style":"TabButton_Four",
            "dm":Global.Img_Cdm
         },this.horsePart = new Child_horsePartTap());
         this._tapper.appendTapper({
            "label":LangConfig.getWord("29457",2),
            "style":"TabButton_Four",
            "dm":Global.Img_Cdm
         },this.horseJinJie = new Child_horseJinjieTap());
         this._tapper.appendTapper({
            "label":LangConfig.getWord("29458",2),
            "style":"TabButton_Four",
            "dm":Global.Img_Cdm
         },this.qiangHua = new Child_horseQiangHuaTap());
         move = new Rectangle(0,0,this.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":611,
            "y":8,
            "callBack":this.hide
         },Global.Img_Cdm);
      }
      
      public function show(index:int = 0) : void
      {
         this.visible = true;
         this._tapper.setSelectedIndex(index);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         Global.control.sendNotification(Model_horse.HORSEPNL_VIS_CHANGE,true);
         pop(Global.stage.mouseX / Global.stage.stageWidth,Global.stage.mouseY / Global.stage.stageHeight);
      }
      
      public function hide(param:* = null) : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         Global.control.sendNotification(Model_horse.HORSEPNL_VIS_CHANGE,false);
         this.visible = false;
      }
      
      private function onFrame(i:int) : void
      {
         Global.control.sendNotification(HorseConfig.HorsePanelFrame,i);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            Model_specialD.visFalseComp(this,HorseUtil._mainBtn,this.superHide);
         }
         else
         {
            super.visible = value;
         }
      }
      
      private function superHide() : void
      {
         super.visible = false;
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

