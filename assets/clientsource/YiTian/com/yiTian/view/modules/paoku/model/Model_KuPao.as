package com.yiTian.view.modules.paoku.model
{
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.KuPaoCGMessage;
   import com.yiTian.scene.GameScene;
   import flash.utils.getTimer;
   
   public class Model_KuPao
   {
      
      public static var numFloatUse:int;
      
      public static var numDoubleUse:int;
      
      public static var numShieldUse:int;
      
      public static var numDieFLoatUse:int;
      
      public static var heroX:int;
      
      public static var heroY:int;
      
      public static var gameingCoin:int;
      
      public static var movePixel:int;
      
      public static var heroState:int;
      
      public static var comboJumpTime:int;
      
      public static var globalRankInfos:Array;
      
      public static var validateNum:Number;
      
      public static var itemsInfo:Array;
      
      public static var friendRanks:Array;
      
      public static var _rankInfo:Array;
      
      public static var _myRank:int;
      
      public static var _myScore:int;
      
      public static var _pageIndex:int;
      
      public static var _maxPage:int;
      
      public static var _dbLength:int;
      
      public static var _lastRequestHpTime:int;
      
      public static const HP_UPDATE:String = "kupao_hu";
      
      public static const ITEMS_UDATE:String = "kupao_iu";
      
      public static const FRIENDRANK_UPDATE:String = "kupao_fru";
      
      public static const RANKUPDATE:String = "kupao_u";
      
      public static const INDEX_STARTFLOAT:int = 0;
      
      public static const INDEX_DOUBLESCROE:int = 1;
      
      public static const INDEX_ENDFLOAT:int = 2;
      
      public static const INDEX_BULLET_SHEILD:int = 3;
      
      public static const INDEX_F_RANK:int = 0;
      
      public static const INDEX_F_NAME:int = 1;
      
      public static const INDEX_F_SCORE:int = 2;
      
      public static const INDEX_F_ROLEID:int = 3;
      
      public static const INDEX_F_METER:int = 4;
      
      public static var isDrawRect:Boolean = false;
      
      public static var speedMul:Number = 1.3;
      
      public static var numPixelMeter:int = 70;
      
      public static var gameing:Boolean = false;
      
      public static var isFloating:Boolean = false;
      
      public static var itemTimes:Array = [1,1,1,1];
      
      public static var hp:int = -1;
      
      public static var score:int = -1;
      
      public static var recordScore:int = -1;
      
      public static var _isInGame:Boolean = false;
      
      public static var servRemainRecord:int = -1;
      
      public function Model_KuPao()
      {
         super();
      }
      
      public static function getNumTool(type:int) : int
      {
         if(itemsInfo == null)
         {
            return 0;
         }
         return int(itemsInfo[type]);
      }
      
      public static function getMeter() : int
      {
         return movePixel / numPixelMeter;
      }
      
      public static function updateItemTimes(times:Array) : void
      {
         itemTimes = times;
      }
      
      public static function updateHp(value:int, remainTime:int = -1) : void
      {
         hp = value;
         Global.control.sendNotification(HP_UPDATE,value);
         if(remainTime != -1)
         {
            Model_KuPao._lastRequestHpTime = getTimer();
            servRemainRecord = remainTime * 1000;
         }
         checkHp();
      }
      
      public static function updateItems(info:Array) : void
      {
         itemsInfo = info;
         Global.control.sendNotification(ITEMS_UDATE,info);
      }
      
      public static function updatePerItem(itemIndex:int, state:int) : void
      {
         if(Boolean(itemsInfo))
         {
            itemsInfo[itemIndex] = state;
            Global.control.sendNotification(ITEMS_UDATE,itemsInfo);
         }
      }
      
      public static function updateFriendRanks(info:Array) : void
      {
         friendRanks = info;
         Global.control.sendNotification(FRIENDRANK_UPDATE,info);
      }
      
      public static function updateRank(info:Array, myRank:int, myScore:int) : void
      {
         _rankInfo = info;
         _myRank = myRank;
         _myScore = myScore;
         Global.control.sendNotification(RANKUPDATE,null);
      }
      
      public static function checkHp() : void
      {
         if(hp == -1)
         {
            return;
         }
         if(hp < 5 && servRemainRecord >= 0)
         {
            GameScene.instance.addFrameCallBack(checkHpTipFunc);
         }
         else
         {
            GameScene.instance.removeFrameCallBack(checkHpTipFunc);
         }
      }
      
      public static function getRemainTime() : int
      {
         var now:int = getTimer();
         return servRemainRecord - (now - _lastRequestHpTime);
      }
      
      public static function checkHpTipFunc(inter:int) : void
      {
         var now:int = getTimer();
         var remainTime:int = servRemainRecord - (now - _lastRequestHpTime);
         if(remainTime <= 0)
         {
            KuPaoCGMessage.CG_KP_REQUESTHP();
            GameScene.instance.removeFrameCallBack(checkHpTipFunc);
         }
      }
   }
}

