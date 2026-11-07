package com.yiTian.data.model
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_Jianghulixian;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.jianghulixian.View_Jianghulixian_icon;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   
   public class Model_Jianghulixian
   {
      
      private static var _leftTimes:int;
      
      public static var cardArr:Array = [];
      
      public static var cardTypeArr:Array = [];
      
      public function Model_Jianghulixian()
      {
         super();
      }
      
      public static function get leftTimes() : int
      {
         return _leftTimes;
      }
      
      public static function set leftTimes(value:int) : void
      {
         _leftTimes = value;
         Global.control.sendNotification(Enum_Jianghulixian.Jianghulixian_UPDATE_LEFT_TIME,null);
         if(_leftTimes > 0)
         {
            UIManager.mainUiBtnContainer.addBTN(View_Jianghulixian_icon.instance);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.JiangHuLiXian,1]);
         }
         else
         {
            UIManager.mainUiBtnContainer.removeBTN(View_Jianghulixian_icon.instance);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.JiangHuLiXian,2]);
         }
      }
   }
}

