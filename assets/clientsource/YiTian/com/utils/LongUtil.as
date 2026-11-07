package com.utils
{
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class LongUtil
   {
      
      private static var converDic:Dictionary;
      
      public static const BIT32NUM:Number = Math.pow(2,32);
      
      public function LongUtil()
      {
         super();
      }
      
      public static function readLong(bytes:IDataInput) : Number
      {
         var numStr:String = null;
         var hexStr:String = null;
         var newLong:String = null;
         var long:String = "";
         var i:int = 0;
         while(i < 8)
         {
            numStr = bytes.readUnsignedByte().toString(16);
            hexStr = numStr.length == 1 ? "0" + numStr : numStr;
            long += hexStr;
            i++;
         }
         var isFu:Boolean = parseInt("0x" + long.substr(0,1)) > 7;
         if(isFu)
         {
            newLong = "";
            i = 0;
            while(i < long.length)
            {
               newLong += converDic[long.charAt(i)];
               i++;
            }
            return -1 * (parseInt("0x" + newLong) + 1);
         }
         return parseInt("0x" + long);
      }
      
      public static function writeLong(bytes:IDataOutput, value:Number) : void
      {
         var subStr:String = null;
         var str2:String = null;
         var isFu:Boolean = value < 0;
         if(value < 0)
         {
            value += 1;
         }
         var str:String = value.toString(16);
         if(isFu)
         {
            str = str.substr(1);
         }
         var lgth:int = 16 - str.length;
         var i:int = 0;
         while(i < lgth)
         {
            str = "0" + str;
            i++;
         }
         if(isFu)
         {
            str2 = "";
            i = 0;
            while(i < str.length)
            {
               str2 += converDic[str.charAt(i)];
               i++;
            }
            subStr = str2.substr(0,8);
            bytes.writeInt(parseInt("0x" + subStr));
            subStr = str2.substr(8,8);
            bytes.writeInt(parseInt("0x" + subStr));
         }
         else
         {
            subStr = str.substr(0,8);
            bytes.writeInt(parseInt("0x" + subStr));
            subStr = str.substr(8,8);
            bytes.writeInt(parseInt("0x" + subStr));
         }
      }
      
      public static function initConverDic() : void
      {
         converDic = new Dictionary();
         converDic["0"] = "f";
         converDic["1"] = "e";
         converDic["2"] = "d";
         converDic["3"] = "c";
         converDic["4"] = "b";
         converDic["5"] = "a";
         converDic["6"] = "9";
         converDic["7"] = "8";
         converDic["8"] = "7";
         converDic["9"] = "6";
         converDic["a"] = "5";
         converDic["b"] = "4";
         converDic["c"] = "3";
         converDic["d"] = "2";
         converDic["e"] = "1";
         converDic["f"] = "0";
      }
   }
}

