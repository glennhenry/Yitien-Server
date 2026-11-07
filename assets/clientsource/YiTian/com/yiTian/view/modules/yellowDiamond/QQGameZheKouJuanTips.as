package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.New_mainBtnContainer;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   
   public class QQGameZheKouJuanTips
   {
      
      private static var _ins:QQGameZheKouJuanTips;
      
      public var tips:MainUIBtn;
      
      public function QQGameZheKouJuanTips()
      {
         super();
      }
      
      public static function get ins() : QQGameZheKouJuanTips
      {
         if(!_ins)
         {
            _ins = new QQGameZheKouJuanTips();
         }
         return _ins;
      }
      
      public function showTip() : void
      {
         if(!this.tips)
         {
            if(New_mainBtnContainer.isUsingNewBtn)
            {
               this.tips = new MainUIBtn("resource/image/Diamond/daTingZheKou_l.png");
               UIManager.newMainBtnContainer.addBtn(this.tips);
            }
            else
            {
               this.tips = new MainUIBtn("resource/image/Diamond/daTingZheKou.png",{
                  "x":(65 - 54) / 2,
                  "y":(70 - 54) / 2
               });
               UIManager.mainUiBtnContainer.addBTN(this.tips);
            }
            this.tips.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               ExternalInterface.call("getJinQuan");
            });
         }
      }
   }
}

