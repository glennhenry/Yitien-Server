package com.yiTian.view.modules.guide
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.UIBase123;
   import com.yiTian.view.modules.mainUIBtnContainer.IMainUiBtn;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   
   public class View_new_push extends UIBase123
   {
      
      private var bg:Bitmap;
      
      private var tf:MyTextField;
      
      private var bm:Bitmap;
      
      private var _icon:IMainUiBtn;
      
      public function View_new_push()
      {
         super();
         bindParent = GameScene.uiLayer;
         regResource("lang/ch/newPush.swf","newPush");
      }
      
      override protected function initUI2() : void
      {
         this.bg = ComponentUtil.getBitmap("newFun",this,null,Global.newPush);
         this.bm = new Bitmap();
         this.bm.x = 156;
         this.bm.y = 4;
         addChild(this.bm);
         this.tf = ComponentUtil.getTextField("",this,{
            "realWidth":282,
            "x":45,
            "y":145,
            "bold":true,
            "size":14,
            "color":14742817,
            "align":TextFormatAlign.CENTER
         });
         buttonMode = true;
      }
      
      public function update(icon:IMainUiBtn, disc:String) : void
      {
         this._icon = icon;
         Utils.getLoadBitmap(icon.bmUrl,this.bm);
         this.tf.text = disc;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = Global.stage.stageHeight * 0.1;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      public function show() : void
      {
         this.visible = true;
         addEventListener(MouseEvent.CLICK,this.hide);
         Tween.to(this,500,{
            "scaleX":[0.1,1],
            "scaleY":[0.1,1],
            "x":[Global.stage.stageWidth / 2,(Global.stage.stageWidth - this.bg.width) / 2],
            "y":[Global.stage.stageHeight * 0.2,Global.stage.stageHeight * 0.1]
         });
      }
      
      public function hide(e:MouseEvent) : void
      {
         this.bm.bitmapData = null;
         removeEventListener(MouseEvent.CLICK,this.hide);
         this.visible = false;
         this.bmFly();
      }
      
      private function bmFly() : void
      {
         var flybm:Bitmap = null;
         var fromPoint:Point = null;
         flybm = Utils.getLoadBitmap(this._icon.bmUrl);
         fromPoint = localToGlobal(new Point(this.bm.x,this.bm.y));
         flybm.x = fromPoint.x;
         flybm.y = fromPoint.y;
         Global.stage.addChild(flybm);
         var toPoint:Point = new Point(this._icon.x + UIManager.mainUiBtnContainer.x,this._icon.y + UIManager.mainUiBtnContainer.y);
         Tween.to(flybm,1000,{
            "x":[fromPoint.x,toPoint.x],
            "y":[fromPoint.y,toPoint.y]
         },this.flyComp);
      }
      
      private function flyComp(flybm:Bitmap) : void
      {
         this._icon.visible = true;
         Tween.to(flybm,400,{
            "scaleX":[1,2],
            "scaleY":[1,2],
            "alpha":[1,0],
            "x":[flybm.x,flybm.x - flybm.width / 2],
            "y":[flybm.y,flybm.y - flybm.height / 2]
         },this.removeBm);
      }
      
      private function removeBm(flybm:Bitmap) : void
      {
         flybm.parent.removeChild(flybm);
         flybm.bitmapData = null;
      }
   }
}

