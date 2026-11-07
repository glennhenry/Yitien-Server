package com.yiTian.view.modules.huaShanLunJian.util
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HuaShanCGMessage;
   import com.yiTian.net.message.gc.BattleGCMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class HuaShanUtil
   {
      
      private static var _labelsArr:Array;
      
      private static var _colArr:Array;
      
      private static var _lunNameArr:Array;
      
      private static var _zhufuLabel:Array;
      
      private static var _tipStrArr:Array;
      
      private static var strDisc:Array;
      
      private static var loader:URLLoader;
      
      public static const TEAMROLEVOFFSET:Number = 98;
      
      public static const TEAMROLEHOFFSET:Number = 98;
      
      public static const TEAMROLEROTATE:Number = 1.75;
      
      public static const ROLESCALE:Number = 0.55;
      
      public static const TEAMVOFFSET:Number = 160 + 124;
      
      public static const TEAMHOFFSET:Number = 220 - 72;
      
      public static const OTHERLISTMAXITEM:int = 20;
      
      public static const TEAMVNUM:int = 3;
      
      public static const TEAMHNUM:int = 2;
      
      public static const NUMLISTPAIHANG:int = 12;
      
      public static const NUMBUBBLEPLAYER:int = 32;
      
      public static const ZXBMDIR:String = "Cross_Shezhi_bg";
      
      public static const BMTIPBTNDIR:String = "resource/image/extralPng/hslj.png";
      
      public static const WINNERBMDIR:Array = ["Winner_Ren","Winner_Di","Winner_Tian","Winner_Xian","Winner_Shen","Winner_Xuan","Winner_Zun","Winner_Ming","Winner_Shi","Winner_Zu"];
      
      private static var lastTimeOutIndex:int = 0;
      
      public static var isReadBattleDataOfBabySkill:Boolean = true;
      
      public function HuaShanUtil()
      {
         super();
      }
      
      public static function getNext(value:uint) : uint
      {
         return value / 2;
      }
      
      public static function REQTEAMINFO() : void
      {
         HuaShanCGMessage.CG_HS_TEAMREQ();
      }
      
      public static function getPre(value:uint) : Array
      {
         return [value * 2,value * 2 + 1];
      }
      
      public static function getWhoWin(srcInt:int) : int
      {
         var r:int = 0;
         if(srcInt == 0)
         {
            return 0;
         }
         var numP1:int = 0;
         var numP2:int = 0;
         while(srcInt > 0)
         {
            r = srcInt % 10;
            if(r == 1)
            {
               numP1++;
            }
            else
            {
               numP2++;
            }
            srcInt /= 10;
         }
         if(numP1 > numP2)
         {
            return 1;
         }
         if(numP2 > numP1)
         {
            return 2;
         }
         return 0;
      }
      
      public static function getScore(srcInt:int, dump:String = " : ") : String
      {
         var r:int = 0;
         var numP1:int = 0;
         var numP2:int = 0;
         while(srcInt > 0)
         {
            r = srcInt % 10;
            if(r == 1)
            {
               numP1++;
            }
            else
            {
               numP2++;
            }
            srcInt /= 10;
         }
         return numP1.toString() + dump + numP2.toString();
      }
      
      public static function finPlayerInfoByID(id:Number, srcArr:Array) : Array
      {
         var arr:Array = null;
         for each(arr in srcArr)
         {
            if(equalID(id,arr[Enum_HuaShan.CONT_ID]))
            {
               return arr;
            }
         }
         return null;
      }
      
      public static function get xuanBaSaiRep() : String
      {
         return Global.kuafuzhanCenterServAddress + "crossFightData/final/{0}/{1}/{2}/{3}/{4}";
      }
      
      public static function get taoTaiSaiRep() : String
      {
         return Global.kuafuzhanCenterServAddress + "crossFightData/eliminate/{0}/{1}";
      }
      
      public static function get labelsArr() : Array
      {
         if(!_labelsArr)
         {
            _labelsArr = ["<font color=\'#44ff44\'>" + LangConfig.getWord("29360",2) + "</font>","<font color=\'#33ccff\'>" + LangConfig.getWord("29361",2) + "</font>","<font color=\'#ff33ff\'>" + LangConfig.getWord("29362",2) + "</font>","<font color=\'#ff7700\'>仙榜</font>","<font color=\'#ff7700\'>神榜</font>","<font color=\'#ff7700\'>玄榜</font>","<font color=\'#ee4444\'>尊榜</font>","<font color=\'#ff4444\'>冥榜</font>","<font color=\'#eeaa33\'>始榜</font>","<font color=\'#ffaa44\'>祖榜</font>"];
         }
         return _labelsArr;
      }
      
      public static function get lunNameArr() : Array
      {
         if(!_lunNameArr)
         {
            _lunNameArr = [LangConfig.getWord("29363",2),LangConfig.getWord("29364",2),LangConfig.getWord("29365",2),LangConfig.getWord("29366",2),LangConfig.getWord("29367",2)];
         }
         return _lunNameArr;
      }
      
      public static function get zhufuLabels() : Array
      {
         if(!_zhufuLabel)
         {
            _zhufuLabel = [LangConfig.getWord("29368",2),LangConfig.getWord("29369",2),LangConfig.getWord("29370",2)];
         }
         return _zhufuLabel;
      }
      
      public static function get tipStrArr() : Array
      {
         if(!_tipStrArr)
         {
            _tipStrArr = ["",LangConfig.getWord("29383",2),LangConfig.getWord("29384",2),LangConfig.getWord("29385",2),LangConfig.getWord("29386",2),LangConfig.getWord("29387",2),LangConfig.getWord("29388",2),LangConfig.getWord("29389",2),LangConfig.getWord("29390",2),LangConfig.getWord("29391",2),LangConfig.getWord("29392",2),LangConfig.getWord("29393",2),LangConfig.getWord("29394",2)];
         }
         return _tipStrArr;
      }
      
      public static function getXiaZhuSrc(index:int) : Array
      {
         var infos:Array = null;
         var costItemInfos:Array = null;
         var myLV:int = GameUnitManager.hero.level;
         var key:String = (int(myLV / 10) * 10).toString();
         if(Boolean(Data_lib.huaShanXiaZhu[key]))
         {
            infos = Data_lib.huaShanXiaZhu[key];
            costItemInfos = [];
            return Util.splicObj(Data_lib.huaShanXiaZhu[key][index],",_") as Array;
         }
         return null;
      }
      
      public static function getZhuFuRewardStr(index:int) : String
      {
         strDisc = strDisc || ["<font color=\'#ffff00\'>祝福的玩家晋级可获得：</font><br>   <font color=\'#33ff33\'>小银票*3</font>#sb<br><font color=\'#cccc00\'>祝福的玩家失败则获得：</font><br>   <font color=\'#33ff33\'>小银票*2</font>","<font color=\'#ffff00\'>祝福的玩家晋级可获得：</font><br>   <font color=\'#33ff33\'>小银票*3</font><br>   <font color=\'#ff9933\'>附橙石*3</font>#sb<br><font color=\'#cccc00\'>祝福的玩家失败则获得：</font><br>   <font color=\'#33ff33\'>小银票*2</font><br>   <font color=\'#ff9933\'>附橙石*2</font>","<font color=\'#ffff00\'>祝福的玩家晋级可获得：</font><br>   <font color=\'#ff33ff\'>特级经验丹*3</font><br>   <font color=\'#ff9933\'>附橙石*9</font>#sb<br><font color=\'#cccc00\'>祝福的玩家失败则获得：</font><br>   <font color=\'#ff33ff\'>特级经验丹*2</font><br>   <font color=\'#ff9933\'>附橙石*6</font>"];
         var hasSbChip:Boolean = GameUnitManager.hero.level >= 70;
         return strDisc[index].replace("#sb",hasSbChip ? "<br>   <font color=\'#ff33ff\'>神兵技能碎片*1</font>" : "");
      }
      
      public static function getStepTime(count:int) : int
      {
         return 700;
      }
      
      public static function isMatchOver(matchArr:Array) : Boolean
      {
         return matchArr[4][0][Enum_HuaShan.NODE_STATE] == Enum_HuaShan.STATE_FINISH;
      }
      
      public static function isPlayerSiftedOut(roldId:Number, matchRoles:Array, matchArr:Array) : Boolean
      {
         var role:Array = null;
         var nodeInfo:Array = null;
         var winnderIndex:int = 0;
         var lun:int = 0;
         var len:int = int(matchRoles.length);
         var i:int = 0;
         while(i < len)
         {
            role = matchRoles[i];
            if(equalID(roldId,role[Enum_HuaShan.CONT_ID]))
            {
               while(lun < 5)
               {
                  i >>= 1;
                  nodeInfo = matchArr[lun][i];
                  winnderIndex = int(nodeInfo[Enum_HuaShan.NODE_WINWAY]);
                  if(winnderIndex == 1 && equalID(roldId,nodeInfo[Enum_HuaShan.NODE_ID2]))
                  {
                     return true;
                  }
                  if(winnderIndex == 2 && equalID(roldId,nodeInfo[Enum_HuaShan.NODE_ID1]))
                  {
                     return true;
                  }
                  lun += 1;
               }
               return false;
            }
            i += 1;
         }
         return true;
      }
      
      public static function equalID(realID:Number, addingID:Number) : Boolean
      {
         if(realID < 1000000)
         {
            return realID == addingID % 1000000;
         }
         return realID == addingID;
      }
      
      public static function getOverMatchByID(roleID:Number) : Array
      {
         var arr1:Array = null;
         var len2:int = 0;
         var j:int = 0;
         var matchInfo:Array = null;
         if(Singleton.hasInstance(Model_HuaShan) == false)
         {
            return null;
         }
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         if(!model.curMatchInfoArr)
         {
            return null;
         }
         var len1:int = int(model.curMatchInfoArr.length);
         var i:int = 0;
         loop0:
         while(i < len1)
         {
            arr1 = model.curMatchInfoArr[i];
            len2 = int(arr1.length);
            j = 0;
            while(true)
            {
               if(j >= len2)
               {
                  i += 1;
                  continue loop0;
               }
               matchInfo = model.curMatchInfoArr[i][j];
               if(matchInfo[Enum_HuaShan.NODE_STATE] == Enum_HuaShan.STATE_READY && (matchInfo[Enum_HuaShan.NODE_ID1] == roleID || matchInfo[Enum_HuaShan.NODE_ID2] == roleID))
               {
                  break;
               }
               j += 1;
            }
            return [[i,j],matchInfo];
         }
         return null;
      }
      
      public static function getBlessAbbArr(lv:int, star:int) : Array
      {
         var key:String = (lv * 100 + star).toString();
         var dic:Dictionary = Data_lib.huaShanZhuFuAtb;
         return Data_lib.huaShanZhuFuAtb[key];
      }
      
      public static function getBlessAbbStr(lv:int, star:int) : String
      {
         var arr:Array = null;
         var atbType:int = 0;
         var atbValue:int = 0;
         var tmp:String = null;
         var infos:Array = getBlessAbbArr(lv,star);
         if(!infos)
         {
            return "";
         }
         if(infos[3] == "0")
         {
            return LangConfig.getWord("29373",2);
         }
         var infoArr:Array = Util.splicObj(infos[3],",_") as Array;
         var atbStr:String = "";
         for each(arr in infoArr)
         {
            atbType = int(arr[0]);
            atbValue = int(arr[1]);
            tmp = "   " + Data_lib.attribute[atbType][0] + "+" + atbValue;
            atbStr += tmp;
         }
         return atbStr;
      }
      
      public static function getEmptyPlayer() : Array
      {
         var players:Array = [];
         var ss:Array = [0,"",1,1,1,"",1,0,0,0,0];
         var i:int = 0;
         while(i < 32)
         {
            players.push(ss);
            i += 1;
         }
         return players;
      }
      
      public static function getEmpthMatchInfo() : Array
      {
         var len2:int = 0;
         var tmp:Array = null;
         var jj:int = 0;
         var matchInfoArr:Array = [];
         var ss:Array = [0,0,0,0];
         var j:int = 0;
         while(j < 5)
         {
            len2 = Math.pow(2,4 - j);
            tmp = [];
            jj = 0;
            while(jj < len2)
            {
               tmp.push(ss);
               jj += 1;
            }
            matchInfoArr.push(tmp);
            j += 1;
         }
         return matchInfoArr;
      }
      
      public static function questServ(url:String) : void
      {
         Utils.print(url);
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29416",2));
            return;
         }
         if(lastTimeOutIndex != 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29374",2));
            return;
         }
         if(!loader)
         {
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
         }
         var urlRequest:URLRequest = new URLRequest(url);
         loader.load(urlRequest);
         loader.addEventListener(Event.COMPLETE,questCompleteHd);
         loader.addEventListener(IOErrorEvent.IO_ERROR,errorHd);
         lastTimeOutIndex = setTimeout(onTimeOut,4000);
      }
      
      private static function onTimeOut() : void
      {
         if(lastTimeOutIndex != 0)
         {
            clearTimeout(lastTimeOutIndex);
         }
         lastTimeOutIndex = 0;
      }
      
      private static function questCompleteHd(event:Event) : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         if(model.jie <= 63)
         {
            isReadBattleDataOfBabySkill = false;
         }
         var bytes:ByteArray = (event.target as URLLoader).data;
         var msgID:int = bytes.readInt();
         BattleGCMessage.GC_BATTLE(bytes);
         loader.removeEventListener(Event.COMPLETE,questCompleteHd);
         loader.close();
      }
      
      private static function errorHd(event:Event) : void
      {
         loader.removeEventListener(Event.COMPLETE,questCompleteHd);
         loader.close();
      }
      
      public function getBangType(lv:int) : int
      {
         var rest:int = 0;
         if(lv < 50)
         {
            rest = 0;
         }
         else if(lv >= 50 && lv < 70)
         {
            rest = 1;
         }
         else if(lv >= 70 && lv < 90)
         {
            rest = 2;
         }
         else if(lv >= 90 && lv < 110)
         {
            rest = 3;
         }
         else if(lv >= 110 && lv < 120)
         {
            rest = 4;
         }
         else if(lv >= 120 && lv < 130)
         {
            rest = 5;
         }
         else if(lv >= 130 && lv < 140)
         {
            rest = 6;
         }
         else if(lv >= 140 && lv < 145)
         {
            rest = 7;
         }
         else if(lv >= 145 && lv < 150)
         {
            rest = 8;
         }
         else if(lv >= 150 && lv < 155)
         {
            rest = 9;
         }
         else if(lv >= 155)
         {
            rest = 10;
         }
         return rest;
      }
   }
}

