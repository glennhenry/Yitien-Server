package com.yiTian.view.modules.shengDanXuYuan
{
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class ChristmasWish_Btn
   {
      
      private static var _instance:ChristmasWish_Btn;
      
      private var wishBtn:MainUIBtn;
      
      private var inTime:Boolean;
      
      public function ChristmasWish_Btn()
      {
         super();
      }
      
      public static function get instance() : ChristmasWish_Btn
      {
         if(!_instance)
         {
            _instance = new ChristmasWish_Btn();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.wishBtn = new MainUIBtn("resource/image/shengDanXuYuan/christmasWish.png");
      }
      
      public function show() : void
      {
         this.inTime = true;
      }
      
      public function hide() : void
      {
         if(View_ChristmasWish.instance.visible)
         {
            View_ChristmasWish.instance.visible = false;
         }
         this.inTime = false;
      }
      
      public function onClick(event:MouseEvent = null) : void
      {
         if(!this.inTime)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80199",8));
            return;
         }
         View_ChristmasWish.instance.visible = !View_ChristmasWish.instance.visible;
      }
   }
}

