package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.qqHallNationalDay.QqHallNationalDayIcon;
   
   public class QqHallNationalDayReturnHandler
   {
      
      public function QqHallNationalDayReturnHandler()
      {
         super();
      }
      
      public static function addIcon() : void
      {
         UIManager.mainUiBtnContainer.addBTN(QqHallNationalDayIcon.instance);
      }
      
      public static function removeIcon() : void
      {
         UIManager.mainUiBtnContainer.removeBTN(QqHallNationalDayIcon.instance);
      }
      
      public static function update(type:uint) : void
      {
         UIManager.qqHallNationalDay.update(type);
      }
   }
}

