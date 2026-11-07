package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class View_AiDeBaoBao_secondHalfOKMenu extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_secondHalfOKMenu;
      
      private var timer:Timer;
      
      private var txt:MyTextField;
      
      private const t:int = 3;
      
      public function View_AiDeBaoBao_secondHalfOKMenu()
      {
         super();
         super.init();
      }
      
      public static function get instance() : View_AiDeBaoBao_secondHalfOKMenu
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_secondHalfOKMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getBitmap("Back_DDJH",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         this.txt = ComponentUtil.getTextField("",this,{
            "x":211,
            "y":203,
            "color":16776960,
            "size":18,
            "leading":0
         },"center");
         this.txt.htmlText = "<font color=\'#00ff00\'>3</font>秒后关闭...";
         this.timer = new Timer(1000);
         this.timer.addEventListener(TimerEvent.TIMER,this.onCountDown);
      }
      
      private function onCountDown(e:TimerEvent) : void
      {
         if(this.timer.currentCount == 3)
         {
            this.timer.reset();
            this.txt.htmlText = "<font color=\'#00ff00\'>3</font>秒后关闭...";
            this.visible = false;
         }
         this.txt.htmlText = "<font color=\'#00ff00\'>" + String(this.t - this.timer.currentCount) + "</font>秒后关闭...";
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.timer.start();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

