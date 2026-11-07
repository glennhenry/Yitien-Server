package com.yiTian.view.modules.guangMingDing
{
   import com.yiTian.Global;
   
   public class Model_guangMingDing
   {
      
      public static var remain:int;
      
      public static var record:int;
      
      public static var passWord:String;
      
      public static var curPage:int;
      
      public static var maxPage:int;
      
      public static var reviveTimes:int;
      
      public static var teamID:Number = -1;
      
      public static var teamInfo:Array = [];
      
      public static var jumpFlag:int = 0;
      
      public static var needShowDeadPnlAfterBattle:Boolean = false;
      
      public static var jumpInfo:String = "";
      
      public static var jumpLeftTimes:int = 0;
      
      public static var _floor:int = 1;
      
      public static var _mjInfo:Object = {};
      
      public static var _useingInfo:Object = {};
      
      public static var _disFloor:int = 1;
      
      public static var isHallShow:Boolean = false;
      
      public static var isTeamShow:Boolean = false;
      
      public static var teamPnlHideFlag:Boolean = true;
      
      public static var rewardLv:int = 0;
      
      public function Model_guangMingDing()
      {
         super();
      }
      
      public static function containMember(roleID:Number, memberArr:Array) : Boolean
      {
         var m:Array = null;
         for each(m in memberArr)
         {
            if(m[Enum_guangMingDing.MEMBER_ROLEID] == roleID)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function isLeader(roleID:Number) : Boolean
      {
         if(!teamInfo)
         {
            return false;
         }
         return teamInfo[0][Enum_guangMingDing.MEMBER_POSTION] == Enum_guangMingDing.MEMBER_TYPE_LEADER && teamInfo[0][Enum_guangMingDing.MEMBER_ROLEID] == roleID;
      }
      
      public static function isAllMemberReady() : Boolean
      {
         var i:int = 1;
         while(i < teamInfo.length)
         {
            if(teamInfo[i][Enum_guangMingDing.MEMBER_ISREAY] != 1)
            {
               return false;
            }
            i += 1;
         }
         return true;
      }
      
      public static function findInfoBytePlayerId(roldId:Number) : Array
      {
         var info:Array = null;
         for each(info in teamInfo)
         {
            if(info[Enum_guangMingDing.MEMBER_ROLEID] == roldId)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function updateFloor(floor:int, disFloor:int) : void
      {
         _floor = floor;
         _disFloor = disFloor;
         Global.control.sendNotification(Msg_guangMingDing.FLOOR_UPDATE,_floor);
      }
      
      public static function updateMJInfo(mjInfo:Object) : void
      {
         _mjInfo = mjInfo;
         Global.control.sendNotification(Msg_guangMingDing.MJ_UPDATE,mjInfo);
      }
      
      public static function updateMJUseingInfo(useingInfo:Object) : void
      {
         _useingInfo = useingInfo;
         Global.control.sendNotification(Msg_guangMingDing.MJ_USEING_UPDATE,useingInfo);
      }
   }
}

