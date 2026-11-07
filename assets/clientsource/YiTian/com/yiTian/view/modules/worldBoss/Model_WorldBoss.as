package com.yiTian.view.modules.worldBoss
{
   import com.yiTian.Global;
   import flash.utils.getTimer;
   
   public class Model_WorldBoss
   {
      
      public static var _numMember:int;
      
      public static var _servRemain:int;
      
      public static var _servRecordTime:int;
      
      public static var _maxPage:int;
      
      public static var _curPage:int;
      
      public static var _myRank:int;
      
      public static var _myDamagePercent:int;
      
      public static var _memberJoin:int;
      
      public static var _chuanGong:int;
      
      public static var _bossHpMax:int = 1;
      
      public static var _bossHpCur:int = 1;
      
      public static var _rankInfo:Array = [];
      
      public static var _rankTrace:Array = [];
      
      public static var _autoChallenge:Boolean = false;
      
      public static var _reviveType:int = -1;
      
      public static var _bossID:Number = 0;
      
      public static var _color:int = 1;
      
      public static var _LQ_NOTMIT:Boolean = false;
      
      public static var _YB_NOTMIT:Boolean = false;
      
      public function Model_WorldBoss()
      {
         super();
      }
      
      public static function updateBoss(maxHp:int, curHp:int) : void
      {
         _bossHpCur = curHp;
         _bossHpMax = maxHp;
         Global.control.sendNotification(Msg_WorldBoss.BOSS_INFO_UPDATE,null);
      }
      
      public static function updateRemain(remain:int) : void
      {
         _servRemain = remain;
         _servRecordTime = getTimer();
         Global.control.sendNotification(Msg_WorldBoss.SCENE_INFO_UPDATE,[_servRemain,_servRecordTime]);
      }
      
      public static function updateRank(maxPage:int, curPage:int, info:Array) : void
      {
         _rankInfo = info;
         _maxPage = maxPage;
         _curPage = curPage;
         Global.control.sendNotification(Msg_WorldBoss.DAMAGERANK_INFO_UPDATE,null);
      }
      
      public static function updateRankTrace(info:Array, myRank:int, myDamagePercent:int) : void
      {
         _rankTrace = info;
         _myRank = myRank;
         _myDamagePercent = myDamagePercent;
         Global.control.sendNotification(Msg_WorldBoss.DAMAGERANL_TRACE_INFO_UPDATE,null);
      }
      
      public static function updateMember(num:int) : void
      {
         _memberJoin = num;
         Global.control.sendNotification(Msg_WorldBoss.NUMMEMBER_UPDATE,num);
      }
      
      public static function updateChuanGong(num:int) : void
      {
         _chuanGong = num;
         Global.control.sendNotification(Msg_WorldBoss.CHUANGONG_UPDATE,num);
      }
      
      public static function getLocalRemain() : int
      {
         var now:int = getTimer();
         return _servRemain * 1000 - (now - Model_WorldBoss._servRecordTime);
      }
      
      public static function setAutoChallenge(v:Boolean) : void
      {
         _autoChallenge = v;
         Global.control.sendNotification(Msg_WorldBoss.AUTOCHALLENGE_CHANGE,v);
      }
      
      public static function updateRevive(type:int) : void
      {
         _reviveType = type;
         View_WorldBossRevive.instance;
         Global.control.sendNotification(Msg_WorldBoss.REVIVE_UPDATE,type);
      }
      
      public static function updateBossInfo(bossID:Number, color:int) : void
      {
         _bossID = bossID;
         _color = color;
         Global.control.sendNotification(Msg_WorldBoss.BOSSID_UPDATE,null);
      }
   }
}

