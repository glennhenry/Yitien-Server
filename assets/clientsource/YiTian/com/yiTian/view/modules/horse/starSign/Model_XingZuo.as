package com.yiTian.view.modules.horse.starSign
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_xingZuo;
   import com.yiTian.data.vo.Vo_XingZuoCountAtb;
   import flash.utils.getTimer;
   
   public class Model_XingZuo
   {
      
      public static var luckPercent:int;
      
      public static var luckServRemainSec:int;
      
      public static var luckRecordTime:int;
      
      public static var equipAtbs:Array;
      
      public static var signLevel:int = 0;
      
      public static var signIndex:int = -1;
      
      public static var curSignIndex:int = -1;
      
      public static var nextSignIndex:int = 10000;
      
      public static var xingLei:int = 0;
      
      public static var isAfterTuPo:int = 0;
      
      public static var pnlShowTimes:int = 0;
      
      public static var myXingZuoAtbVo:Vo_XingZuoCountAtb = new Vo_XingZuoCountAtb();
      
      public static const XINGYUNID:int = 45467;
      
      public static const XINGYUNLUCKYID:int = 45468;
      
      public static const MSG_XINGZUO_INFO:String = "xingZuo_info";
      
      public static const MSG_XINGZUO_CHANGE:String = "xingZuo_Change";
      
      public static const MSG_XINGLEI_CHANGE:String = "xingLei_change";
      
      public static const MSG_XINGZUO_EQUIP_ATB_UPDATE:String = "xingzuo_myEquipAtb_update";
      
      public static const MSG_XZBREAK_LUCK_UPDATE:String = "xzBreak_luck_update";
      
      public static const LASTXINGXINGID:int = 21051;
      
      public static const LASTXINGZUOID:int = 11;
      
      public static const BG_LINK:Array = ["Back_XZSZ","Back_XZBY","Back_XZTM","Back_XZJN","Back_XZSY","Back_XZTT","Back_XZTX","Back_XZSP","Back_XZFH","Back_XZHT","Back_XZLQ","Back_XZTL","Back_XZTL"];
      
      public function Model_XingZuo()
      {
         super();
      }
      
      public static function setXingZuoLevel(signLv:int, signID:int) : void
      {
         var nextIndex:int = 0;
         signLevel = signLv;
         curSignIndex = signID;
         var startIndex:int = int(Data_lib.xingZuo[signLv][5]);
         if(startIndex > curSignIndex)
         {
            nextSignIndex = signIndex = startIndex;
         }
         else if(signID == 0)
         {
            nextSignIndex = signIndex = startIndex;
         }
         else
         {
            signIndex = signID;
            nextIndex = int(Data_lib.xingZuoStar[signID][Enum_xingZuo.LIB_NEXTID]);
            nextSignIndex = nextIndex;
         }
         Global.control.sendNotification(MSG_XINGZUO_INFO,null);
      }
      
      public static function updateOpenStar(rest:int, preID:int, afterID:int) : void
      {
         Global.control.sendNotification(MSG_XINGZUO_CHANGE,[rest,preID,afterID]);
      }
      
      public static function updateXingLei(value:int) : void
      {
         xingLei = value;
         Global.control.sendNotification(MSG_XINGLEI_CHANGE,value);
      }
      
      public static function updateMyEquipAtbs(eequipAtbs:Array) : void
      {
         equipAtbs = eequipAtbs;
         tryUpdateEquipVo();
         Global.control.sendNotification(MSG_XINGZUO_EQUIP_ATB_UPDATE,eequipAtbs);
      }
      
      private static function tryUpdateEquipVo() : void
      {
         if(equipAtbs != null && signIndex != -1)
         {
            myXingZuoAtbVo.level = signLevel;
            myXingZuoAtbVo.xingxingIndex = curSignIndex;
            myXingZuoAtbVo.servData = equipAtbs;
            myXingZuoAtbVo.initLib();
         }
      }
      
      public static function updateLuckPercent(_luckPercent:int, _remainTime:int) : void
      {
         luckPercent = _luckPercent;
         luckServRemainSec = _remainTime;
         luckRecordTime = getTimer();
         Global.control.sendNotification(MSG_XZBREAK_LUCK_UPDATE,[_luckPercent,_remainTime]);
      }
   }
}

