package com.yiTian.view.modules.marriage
{
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.TimeLineLL;
   
   public class MarriageConfig
   {
      
      private static var mMSA:Array;
      
      public static var startUsing:Boolean = true;
      
      public static const BREAK_COST:int = 1000;
      
      public static const RING_PLATINUM:int = 46441;
      
      public static const RING_GOLD:int = 46442;
      
      public static const RING_DIAMOND:int = 46443;
      
      public static var ring_idList:Array = new Array(RING_PLATINUM,RING_GOLD,RING_DIAMOND);
      
      public static var hongBao_id:int = 46450;
      
      public static var hongBao_costList:Array = new Array(99,999,9999);
      
      public static var hongBao_numList:Array = new Array(9,99,999);
      
      public static var cashGift_idList:Array = new Array(46444,46445,46446);
      
      public static var cashGift_costList:Array = new Array(8,88,888);
      
      public static var bless_costList:Array = new Array(8,88,888);
      
      public static var bless_idList:Array = new Array(46447,46448,46449);
      
      public static const CAMERA_X_MALE:int = 1639;
      
      public static const CAMERA_Y_MALE:int = 692;
      
      public static const CAMERA_X_FEMALE:int = 1778;
      
      public static const CAMERA_Y_FEMALE:int = 634;
      
      public function MarriageConfig()
      {
         super();
      }
      
      public static function playMarriageScript(maleName:String, femaleName:String, id1:Number, id2:Number) : void
      {
         var px:Number = NaN;
         var py:Number = NaN;
         var cameraStr:String = null;
         var scriptStr:String = "0||createUnit(name1|51094|3|1|1037|479);0||createUnit(name2|51095|3|1|1111|453);";
         scriptStr += "1000||addEffAtRole(name1|35101|1000|0|0|0);";
         scriptStr += "1000||addEffAtRole(name2|35101|1000|0|0|0);";
         scriptStr += "4000||unitMove(name1|10000|1381|865);4000||unitMove(name2|10000|1467|831);";
         scriptStr += "16000||unitMove(name1|10000|1658|706);16000||unitMove(name2|10000|1782|650);";
         scriptStr += "2000||setUnitTalk(name1|/29" + LangConfig.getWord("60213",6) + "|6000|5000);";
         scriptStr += "10000||setUnitTalk(name2|/29" + LangConfig.getWord("60214",6) + "|4000|5000);";
         scriptStr += "27000||setUnitTalk(name2|/29" + LangConfig.getWord("60215",6) + "|3000|5000);";
         scriptStr += "28500||setUnitTalk(name1|/17" + LangConfig.getWord("60216",6) + "|3000|5000);";
         scriptStr += "38000||setUnitTalk(name1|/33/33/33/33/33|5000|20000);";
         scriptStr += "38000||setUnitTalk(name2|/33/33/33/33/33|5000|20000);";
         var myID:Number = GameUnitManager.hero.id;
         if(id1 == myID || id2 == myID)
         {
            px = GameUnitManager.hero.global_x;
            py = GameUnitManager.hero.global_y;
            cameraStr = "0||lockCamera();";
            cameraStr += "0||cameraFormTo(px|py|1037|479|2500);";
            cameraStr += "4000||cameraFormTo(1037|479|1381|865|10000);";
            cameraStr += "16000||cameraFormTo(1381|865|1658|706|10000);";
            cameraStr = cameraStr.replace("px",px.toString());
            cameraStr = cameraStr.replace("py",py.toString());
            scriptStr += cameraStr;
         }
         scriptStr = scriptStr.replace(/name1/g,maleName);
         scriptStr = scriptStr.replace(/name2/g,femaleName);
         var sm:TimeLineLL = Singleton.getInstance(TimeLineLL);
         sm.playScript(scriptStr);
      }
      
      public static function get marriageNameStrArr() : Array
      {
         return mMSA || (mMSA = [LangConfig.getWord("29276",2),LangConfig.getWord("29277",2),LangConfig.getWord("29278",2)]);
      }
   }
}

