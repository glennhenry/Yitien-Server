package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class View_AiDeBaoBao_serverTips extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_serverTips;
      
      private var countDown:MyTextField;
      
      private var leftTime:int = 3;
      
      private var timer:Timer;
      
      public function View_AiDeBaoBao_serverTips()
      {
         super();
         init();
      }
      
      public static function get instance() : View_AiDeBaoBao_serverTips
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_serverTips();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getBitmap("Back_TDTS",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         var txt1:MyTextField = ComponentUtil.getTextField("该服务器已经爆满，请选择其他服务器",this,{
            "x":115,
            "y":137,
            "color":853252,
            "size":14,
            "leading":6
         });
         txt1.filters = [];
         this.countDown = ComponentUtil.getTextField("",this,{
            "x":186,
            "y":160,
            "color":20763,
            "size":14,
            "leading":0
         });
         this.countDown.filters = [];
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":371,
            "y":50,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
         CloseButton.callBack = this.closeMenu;
         this.timer = new Timer(1000,3);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         if(this.timer.currentCount == 3)
         {
            this.visible = false;
         }
         else
         {
            this.countDown.text = String(this.leftTime - this.timer.currentCount) + "秒后自动返回";
         }
      }
      
      private function closeMenu(e:MouseEvent) : void
      {
         this.timer.stop();
         this.visible = false;
      }
      
      public function show() : void
      {
         this.timer.reset();
         this.countDown.text = this.leftTime + "秒后自动返回";
         this.visible = true;
         this.timer.start();
      }
   }
}

