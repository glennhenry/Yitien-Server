package com.yiTian.data.vo
{
   import com.utils.Util;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_xingZuo;
   import com.yiTian.data.config.valuable.Enum_equip_type;
   
   public class Vo_XingZuoCountAtb
   {
      
      public var servData:Array = [];
      
      public var level:int;
      
      public var xingxingIndex:int;
      
      public var _version:int = 0;
      
      public var staticAtbStr:String = "<font color=\'#55aaff\'>气血</font>：0</font>" + "\n<font color=\'#55aaff\'>内力：</font>0" + "\n<font color=\'#55aaff\'>攻击：</font>0";
      
      public var serverAtbStr:String;
      
      public var servStrs:Array = [];
      
      public function Vo_XingZuoCountAtb()
      {
         super();
      }
      
      public function initLib() : void
      {
         var tempArr:Array = null;
         var atbArr:Array = null;
         var type:int = 0;
         var value:int = 0;
         var str:String = null;
         var arr2:Array = null;
         var equipAtbs:Array = null;
         var equipType:int = 0;
         var percent:String = null;
         var atbbs:Array = null;
         var percentStr:String = null;
         var equipName:String = null;
         var j:int = 0;
         var atb:Array = null;
         var atbType:int = 0;
         var vv:int = 0;
         var atbName:String = null;
         var temp:String = null;
         ++this._version;
         this.staticAtbStr = "";
         var sumAtbStr:String = Data_lib.xingZuoStar[this.xingxingIndex][Enum_xingZuo.LIB_ATBSUM];
         var strArr:Array = [];
         if(sumAtbStr != "" && sumAtbStr != "0")
         {
            tempArr = Util.splicObj(sumAtbStr,",_") as Array;
            for each(atbArr in tempArr)
            {
               type = int(atbArr[0]);
               value = int(atbArr[1]);
               str = "<font color=\'#55aaff\'>" + Data_lib.attribute[type][0] + "：</font><font color=\'#55ff55\'>" + value + "</font>";
               strArr.push(str);
            }
         }
         this.staticAtbStr = strArr.join("\n");
         var arr1:Array = [];
         var i:int = 0;
         while(i < this.servData.length)
         {
            arr2 = [];
            equipAtbs = this.servData[i];
            equipType = int(equipAtbs[0]);
            percent = equipAtbs[1];
            atbbs = equipAtbs[2];
            percentStr = Number(percent) * 1000 + "‰";
            equipName = Enum_equip_type.TXT[equipType - 1];
            arr2.push("<font color=\'#55aaff\'>" + equipName + "：</font><font color=\'#55ff55\'>" + percentStr + "</font>");
            j = 0;
            while(j < atbbs.length)
            {
               atb = atbbs[j];
               atbType = int(atb[0]);
               vv = int(atb[1]);
               atbName = Data_lib.attribute[atbType][0];
               temp = "<font color=\'#55ff55\'>" + atbName + "</font><font color=\'#55ff55\'>+" + vv + "</font>";
               arr2.push(temp);
               j += 1;
            }
            if(arr2.length > 1)
            {
               arr2[1] = "<font color=\'#55ff55\'>【</font> " + arr2[1];
            }
            arr1.push(arr2);
            i += 1;
         }
         this.servStrs = arr1;
      }
   }
}

