package com.yiTian.view.modules.horse
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import flash.events.MouseEvent;
   
   public class HorseUtil
   {
      
      public static var _mainBtn:BitmapBtn;
      
      public static var showIndex:int = 0;
      
      public function HorseUtil()
      {
         super();
      }
      
      public static function init() : void
      {
         if(GameUnitManager.hero.level >= HorseConfig.LV_REQUIRED)
         {
            addBtn();
         }
         else
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,lvUpHd);
         }
      }
      
      private static function lvUpHd() : void
      {
         if(GameUnitManager.hero.level >= HorseConfig.LV_REQUIRED)
         {
            addBtn();
            UIManager.special_btn.openHorse();
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,lvUpHd);
         }
      }
      
      private static function addBtn() : void
      {
         if(!_mainBtn)
         {
            _mainBtn = new BitmapBtn();
            _mainBtn.init();
            _mainBtn.buttonMode = true;
            _mainBtn.setBgDir("resource/image/horse/mainIcon.png");
            showIndex = 0;
            _mainBtn.clickCallBack = clickHd;
            _mainBtn.y = -20;
            UIManager.special_btn.appendItem(_mainBtn);
            _mainBtn.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
            _mainBtn.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
         }
      }
      
      private static function onRollOver(e:MouseEvent) : void
      {
         _mainBtn.filters = Util.glowBigFFff00;
      }
      
      private static function onRollOut(e:MouseEvent) : void
      {
         _mainBtn.filters = null;
      }
      
      public static function clickHd(e:MouseEvent = null) : void
      {
         var mainPnl:View_horsePanel = null;
         mainPnl = Singleton.getInstance(View_horsePanel);
         if(!mainPnl.visible)
         {
            Global.delegate.dosomething(mainPnl,function():void
            {
               mainPnl.show(showIndex);
            });
         }
         else
         {
            mainPnl.hide();
         }
      }
      
      public static function openHorsePnl() : void
      {
         if(GameUnitManager.hero.level < 15)
         {
            UIManager.centerBroadcast.addMsg("等级未达15，请加油练级哦亲");
            return;
         }
         var horsePnl:View_horsePanel = Singleton.getInstance(View_horsePanel);
         if(!horsePnl.visible)
         {
            Global.delegate.dosomething(horsePnl,horsePnl.show);
         }
         else
         {
            Global.delegate.dosomething(horsePnl,horsePnl.hide);
         }
      }
   }
}

