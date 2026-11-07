package com.yiTian.view.modules.qplus
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.SingleLoader;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   
   public class QQShare extends Sprite
   {
      
      private static var _instance:QQShare;
      
      private var fixCoord:Boolean = false;
      
      private var coord:Point;
      
      private var closeButton:Button;
      
      private var _source:String;
      
      public function QQShare()
      {
         super();
         this.resize();
         if(Global.Store_Imgsdm == null)
         {
            SingleLoader.add("lang/ch/Store_Imgs.swf",function(info:Object):void
            {
               Global.Store_Imgsdm = info.applicationDomain;
               init();
            });
         }
         else
         {
            this.init();
         }
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
      }
      
      public static function get instance() : QQShare
      {
         if(!_instance)
         {
            _instance = new QQShare();
            ExternalInterface.call("loadIFrame","");
            GameScene.sysLayer.addChild(_instance);
         }
         return _instance;
      }
      
      private function init() : void
      {
         ComponentUtil.getScaleBitmap("Store_Back2",[50,30,4,1],this,{
            "x":0,
            "y":0,
            "width":172,
            "height":106
         },Global.Store_Imgsdm);
         this.closeButton = ComponentUtil.getButton("","Button_SClose",this,{
            "x":143,
            "y":2,
            "textColor":16184781
         },Global.Store_Imgsdm);
         this.closeButton.addEventListener(MouseEvent.CLICK,this.clkHandle);
      }
      
      private function clkHandle(evt:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function moveIFrame() : void
      {
         var localPt:Point = new Point(50,46);
         var globalPt:Point = this.localToGlobal(localPt);
         ExternalInterface.call("moveIFrame",globalPt.x,globalPt.y);
      }
      
      public function setFrameCoord(p:Point) : void
      {
         this.fixCoord = true;
         this.coord = p;
         ExternalInterface.call("moveIFrame",p.x + 3,p.y + 28);
         x = p.x;
         y = p.y;
      }
      
      public function set source(str:String) : void
      {
         ExternalInterface.call("loadIFrame",str);
      }
      
      public function get source() : String
      {
         return this._source;
      }
      
      override public function set visible(visible:Boolean) : void
      {
         super.visible = visible;
         if(visible)
         {
            ExternalInterface.call("showIFrame");
         }
         else
         {
            ExternalInterface.call("hideIFrame");
         }
      }
      
      private function resize() : void
      {
         x = (Global.stage.stageWidth - 400) / 2;
         y = (Global.stage.stageHeight - 300) / 2;
         if(!this.fixCoord)
         {
            this.moveIFrame();
         }
         else
         {
            this.setFrameCoord(this.coord);
         }
      }
   }
}

