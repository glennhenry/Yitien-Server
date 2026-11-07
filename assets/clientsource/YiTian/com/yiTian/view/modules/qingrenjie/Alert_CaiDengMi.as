package com.yiTian.view.modules.qingrenjie
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_mapTarItem;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class Alert_CaiDengMi extends Panel123
   {
      
      private var txtTip:MyTextField;
      
      private var btnOk:Button;
      
      private var btnCancel:Button;
      
      private var bg:DisplayObject;
      
      private var pp:Array = [[2336,3200],[4990,3060],[4788,1917],[3214,2015]];
      
      public function Alert_CaiDengMi()
      {
         super();
         init();
      }
      
      public static function get instance() : Alert_CaiDengMi
      {
         return Singleton.getInstance(Alert_CaiDengMi);
      }
      
      override protected function initStaticView() : void
      {
         var bm:Bitmap = null;
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":298 + 14,
            "height":160
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":39,
            "width":250 + 14,
            "height":112
         },Global.Img_Cdm);
         bm = new Bitmap();
         bm.x = 65;
         bm.y = 6;
         Utils.getLoadBitmap("resource/image/qingrenjie/Alert.png",bm);
         this.addChild(bm);
         this.txtTip = ComponentUtil.getTextField("",this,{
            "x":31,
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
            "x":271,
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
         this.txtTip.htmlText = "活动期间的<font color=\'#04ff00\'>10/12/14/16/18/20/22点</font>，在应天府花灯处猜<font color=\'#04ff00\'>10</font>个灯谜";
      }
      
      private function hide(prm:* = null) : void
      {
         visible = false;
      }
      
      private function onOk(e:MouseEvent) : void
      {
         var targetXY:Vo_mapTarItem = null;
         var mat:int = Math.random() * 4;
         if(Global.sceneID != 13401)
         {
            targetXY = new Vo_mapTarItem();
            targetXY.x = this.pp[mat][0];
            targetXY.y = this.pp[mat][1];
            GameUnitManager.hero.autoMoveLocation(13401,targetXY);
         }
         else
         {
            GameUnitManager.hero.go(this.pp[mat][0],this.pp[mat][1]);
         }
         View_QingRenJie.instance.visible = false;
         this.hide();
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

