package com.yiTian.view.modules.qingMing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_scene_type;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ZhuaGuiTip extends Panel123
   {
      
      private var txtTip:MyTextField;
      
      private var btnOk:Button;
      
      private var btnCancel:Button;
      
      private var bg:DisplayObject;
      
      public function ZhuaGuiTip()
      {
         super();
         regResource("lang/ch/ZhuaGui.swf","ZhuaGuidm");
      }
      
      public static function get instance() : ZhuaGuiTip
      {
         return Singleton.getInstance(ZhuaGuiTip);
      }
      
      override protected function initUI2() : void
      {
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
         ComponentUtil.getBitmap("Title_XYCMTS",this,{
            "x":68,
            "y":5
         },Global.ZhuaGuidm);
         this.txtTip = ComponentUtil.getTextField("",this,{
            "x":38,
            "y":54,
            "color":13816530,
            "size":12,
            "leading":8
         });
         this.txtTip.wordWrap = true;
         this.txtTip.realWidth = this.bg.width - 60;
         this.btnOk = ComponentUtil.getButton("前往","Button_Four",this,{
            "x":58,
            "y":113,
            "textColor":16771436
         },Global.Img_Cdm);
         this.btnCancel = ComponentUtil.getButton("取消","Button_Four",this,{
            "x":168,
            "y":114,
            "textColor":16771436
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":261,
            "y":6,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         this.btnOk.addEventListener(MouseEvent.CLICK,this.onOk);
         this.btnCancel.addEventListener(MouseEvent.CLICK,this.onCancel);
      }
      
      public function updateTxtTip(str:String) : void
      {
         if(!this.txtTip)
         {
            return;
         }
         this.txtTip.htmlText = str;
      }
      
      public function show() : void
      {
         visible = true;
         this.updateTxtTip(Model_QingMing.tipStr);
      }
      
      private function hide(prm:* = null) : void
      {
         visible = false;
      }
      
      private function onOk(e:MouseEvent) : void
      {
         this.hide();
         if(Global.sceneType == Enum_scene_type.FUBEN && !MapManager.isFubenFinish || GameUnitManager.hero.status == Status.SIT)
         {
            UIManager.centerBroadcast.addMsg("当前状态不能抓鬼");
            return;
         }
         GameUnitManager.hero.autoMove(Msg_QingMing.ZHUAGUI_NPCID,UnitType.NPC);
      }
      
      private function onCancel(e:MouseEvent) : void
      {
         this.hide();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
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

