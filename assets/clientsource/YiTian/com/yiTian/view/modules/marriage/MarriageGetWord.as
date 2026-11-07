package com.yiTian.view.modules.marriage
{
   import com.utils.Util;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.utils.Dictionary;
   
   public class MarriageGetWord
   {
      
      public static var result:Array;
      
      public static var ringType:int;
      
      public static var strBase:String;
      
      public static var strNum:String;
      
      public static var strPer:String;
      
      public static var dataBase:Dictionary;
      
      public static var index:int;
      
      public static var info:String;
      
      public static var type:int;
      
      public static var isInit:Boolean = false;
      
      public static var data:Array = null;
      
      public function MarriageGetWord()
      {
         super();
      }
      
      public static function init() : void
      {
         var tempData:Dictionary = null;
         var list:Array = null;
         if(!isInit)
         {
            data = new Array();
            tempData = Data_lib.marriage;
            for each(list in tempData)
            {
               data.push(list);
            }
            dataBase = Data_lib.attribute;
            isInit = true;
         }
      }
      
      public static function getAttributeInfo(lv:int, ringId:int) : Array
      {
         init();
         ringType = getRingType(ringId);
         info = data[lv][ringType + 1];
         result = spltInfo(info);
         return result;
      }
      
      public static function getNextAttributeInfo(lv:int, ringId:int) : Array
      {
         init();
         ringType = getRingType(ringId);
         index = lv + 1;
         if(index > 8)
         {
            return new Array();
         }
         info = data[index][ringType + 1];
         result = spltInfo(info,true);
         return result;
      }
      
      public static function getQMDIndex(value:int) : int
      {
         var qinmiLv:int = 0;
         init();
         var src:Array = MarriageGetWord.data;
         var i:int = 0;
         while(i < src.length)
         {
            if(value >= src[i][0])
            {
               qinmiLv = i;
            }
            i += 1;
         }
         return qinmiLv;
      }
      
      private static function spltInfo(info:String, isDisable:Boolean = false) : Array
      {
         var array:Array = info.split(",");
         var resSrcStr:String = LangConfig.getWord("1081",0);
         if(isDisable)
         {
            resSrcStr = resSrcStr.replace(/\#[a-zA-Z0-9]{6}/gi,"#999999");
         }
         var i:int = 0;
         while(i < array.length)
         {
            array[i] = array[i].split("_");
            strBase = dataBase[array[i][0]][0];
            strNum = array[i][1].toString();
            type = dataBase[array[i][0]][1];
            strPer = type == 1 ? "" : "%";
            array[i] = Util.rep(resSrcStr,strBase,strNum + strPer);
            i++;
         }
         return array;
      }
      
      public static function getMarriageName(ringId:int) : String
      {
         var tmp:Array = [29267,29268,29269];
         var lv:int = getRingType(ringId);
         return Enum_BroadCastTool.instance.getColorStr(LangConfig.getWord(tmp[lv - 1],2),lv + 1);
      }
      
      private static function getRingType(ringId:int) : int
      {
         var ringType:int = 0;
         switch(ringId)
         {
            case MarriageConfig.RING_PLATINUM:
               ringType = 1;
               break;
            case MarriageConfig.RING_GOLD:
               ringType = 2;
               break;
            case MarriageConfig.RING_DIAMOND:
               ringType = 3;
               break;
            default:
               ringType = 0;
         }
         return ringType;
      }
   }
}

