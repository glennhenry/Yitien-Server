package com.yiTian.view.modules.worldBoss
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.UIBase;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.events.TimerEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   
   public class View_PrePareCountDown extends UIBase
   {
      
      private static var _instace:*;
      
      private var _tfRemain:MyTextField;
      
      private var _timer:Timer;
      
      public function View_PrePareCountDown()
      {
         super();
         init();
         bindParent = GameScene.sysLayer;
         this.visible = false;
         this.resetPosition();
      }
      
      public static function get instance() : View_PrePareCountDown
      {
         return _instace = _instace || new View_PrePareCountDown();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":-82,
            "y":-20,
            "width":160,
            "height":80
         },Global.Img_Cdm);
         var tf:MyTextField = ComponentUtil.getTextField("",this,{
            "size":14,
            "color":16777011,
            "bold":true,
            "realWidth":0
         });
         tf.autoSize = TextFieldAutoSize.CENTER;
         tf.text = "即将开始";
         this._tfRemain = ComponentUtil.getTextField("",this,{
            "size":20,
            "y":20,
            "color":16777011,
            "bold":true
         });
         this._tfRemain.autoSize = TextFieldAutoSize.CENTER;
         this._timer = new Timer(2000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTick);
         Global.control.registerCallBack(Msg_WorldBoss.SCENE_INFO_UPDATE,this.onSceneInfoUpdate);
      }
      
      private function onSceneInfoUpdate() : void
      {
         if(!WorldBossUtil.checkStart())
         {
            this.updateRemain();
            this._timer.start();
         }
      }
      
      protected function onTick(event:TimerEvent) : void
      {
         this.updateRemain();
      }
      
      public function updateRemain() : void
      {
         var remain:int = Model_WorldBoss.getLocalRemain() / 1000;
         if(remain <= 1800)
         {
            this.visible = false;
         }
         else
         {
            if(!visible)
            {
               this.visible = visible || true;
            }
            remain -= 1800;
            this._tfRemain.text = Enum_BroadCastTool.instance.getBitStr(remain / 60) + ":" + Enum_BroadCastTool.instance.getBitStr(remain % 60);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.updateRemain();
            this._timer.start();
         }
         else
         {
            this._timer.stop();
         }
      }
      
      override public function resetPosition() : void
      {
         x = int((Global.stage.stageWidth - 80) * 0.5);
         y = int((Global.stage.stageHeight - 100) * 0.5);
      }
   }
}

