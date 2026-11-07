package com.yiTian.view.modules.test
{
   import com.utils.LongUtil;
   import flash.utils.ByteArray;
   
   public class Model_Pak
   {
      
      public function Model_Pak()
      {
         super();
      }
      
      public static function getByteArr(data:Array) : ByteArray
      {
         var bt:ByteArray = new ByteArray();
         bt.length = 0;
         var len:int = int(data.length);
         var i:int = 0;
         while(i < len)
         {
            switch(data[i][0])
            {
               case "INT":
                  bt.writeInt(int(data[i][1]));
                  break;
               case "short":
                  bt.writeShort(int(data[i][1]));
                  break;
               case "Byte":
                  bt.writeByte(int(data[i][1]));
                  break;
               case "UTF":
                  bt.writeUTF(String(data[i][1]));
                  break;
               case "Long":
                  LongUtil.writeLong(bt,Number(data[i][1]));
            }
            i++;
         }
         return bt;
      }
      
      public static function getRealType(content:String, type:String) : *
      {
         switch(type)
         {
            case "INT":
               return int(content);
            case "short":
               return int(content);
            case "Byte":
               return int(content);
            case "UTF":
               return String(content);
            case "Long":
               return Number(content);
            default:
               return 0;
         }
      }
   }
}

