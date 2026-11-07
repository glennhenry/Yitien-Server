package com.yiTian.data.model
{
   import com.yiTian.Global;
   
   public class Model_heFu
   {
      
      public static var myQHStr:String;
      
      public static var type:int = 1;
      
      public static var qhPattern:RegExp = /\.[ST][0-9]*/g;
      
      public static var zeroPattern:RegExp = /\.S[3-9]0*/;
      
      public static var sameQhPattern:RegExp = /\.[ST][0-9]*/;
      
      public static var TTestqttern:RegExp = /\.T[0-9]*/;
      
      public static var crossBattleNameTester:RegExp = /\.[0-9]+/;
      
      public static var endFontPattern:RegExp = /\<\/font\>/;
      
      public function Model_heFu()
      {
         super();
      }
      
      public static function correctRoleServName(name:String) : String
      {
         var qh:int = 0;
         var rest:String = null;
         var qhStr:String = null;
         var myQh:int = 0;
         var rqzqArr:Array = name.match(TTestqttern);
         if(rqzqArr != null)
         {
            qhStr = (rqzqArr[0] as String).slice(2,rqzqArr[0].length).replace(endFontPattern,"");
            qh = int(qhStr);
            if(qh < 30000)
            {
               qh = 30000 + qh;
            }
            rest = name.replace(TTestqttern,"") + ".S" + qh.toString();
         }
         else if(!sameQhPattern.test(name))
         {
            myQh = int(myQHStr);
            rest = name + ".S" + myQh.toString();
         }
         else
         {
            rest = name;
         }
         return rest;
      }
      
      public static function init() : void
      {
         myQHStr = Global.zoneid;
      }
      
      public static function repNameStr(str:String) : String
      {
         var i:int = 0;
         var temp:String = null;
         var qh:int = 0;
         var matchArr:Array = str.match(qhPattern);
         if(matchArr != null)
         {
            i = matchArr.length - 1;
            while(i >= 0)
            {
               temp = matchArr[i] as String;
               qh = int(temp.slice(2,temp.length));
               if(qh >= 30000)
               {
                  str = str.replace(temp,".T" + (qh - 30000).toString());
               }
               i--;
            }
         }
         return str;
      }
      
      public static function repName(name:String, nickName:String = ".S33", sp:String = ".S") : String
      {
         var nick2:String = null;
         var num:int = 0;
         var idx:int = name.indexOf(".S");
         if(idx != -1)
         {
            if(crossBattleNameTester.test(name))
            {
               name = name.slice(0,idx + 1) + "S" + name.slice(idx + 1,name.length);
            }
            nick2 = name.slice(idx + 2,name.length).replace(endFontPattern,"");
            if(nickName == nick2)
            {
               name = name.replace(qhPattern,"");
            }
            else
            {
               num = int(nick2);
               if(num >= 30000)
               {
                  name = name.replace(zeroPattern,".T");
               }
            }
         }
         return name;
      }
      
      public static function repNameByHero(name:String) : String
      {
         if(name == null || name == "")
         {
            return "";
         }
         return repName(name,myQHStr,".S");
      }
      
      public static function equalId(id1:Number, id2:Number, servID1:Number = 0, servID2:Number = 0) : Boolean
      {
         if(id1 == id2)
         {
            return true;
         }
         id1 %= 1000000000;
         id2 %= 1000000000;
         servID1 ||= parseInt((id1 / 1000000).toString());
         servID2 ||= parseInt((id2 / 1000000).toString());
         var roleID1:Number = parseInt((id1 % 1000000).toString());
         var roleID2:Number = parseInt((id2 % 1000000).toString());
         return servID1 == servID2 && roleID1 == roleID2;
      }
      
      public static function repNameUseSerID(name:String) : String
      {
         var nick2:String = null;
         var num:int = 0;
         var idx:int = name.indexOf(".S");
         if(idx != -1)
         {
            nick2 = name.slice(idx + 2,name.length);
            nick2 = nick2.replace(endFontPattern,"");
            num = int(nick2);
            if(num >= 30000)
            {
               name = name.replace(sameQhPattern,".T" + (num - 30000).toString());
            }
         }
         return name;
      }
      
      public static function repStr(str:String) : String
      {
         var tstr:String = null;
         var qh:int = 0;
         var newStr:String = null;
         var arr:Array = str.match(qhPattern);
         if(arr != null)
         {
            tstr = arr[0];
            qh = int(tstr.slice(2,str.length));
            if(qh > 30000)
            {
               qh -= 30000;
               newStr = ".T" + qh.toString();
               str = str.replace(qhPattern,newStr);
            }
         }
         return str;
      }
      
      public static function repsServName2(name:String) : String
      {
         var rqzqArr:Array = null;
         var num:int = 0;
         if(!/\.[0-9]/.test(name))
         {
            return name;
         }
         if(crossBattleNameTester.test(name))
         {
            rqzqArr = name.match(crossBattleNameTester);
            if(rqzqArr != null)
            {
               num = int(rqzqArr[0].slice(1,rqzqArr[0].length));
               if(num >= 30000)
               {
                  name = name.replace(crossBattleNameTester,".T" + num % 30000);
               }
               else
               {
                  name = name.replace(crossBattleNameTester,".S" + num);
               }
            }
         }
         return name;
      }
      
      public static function getQuHao(name:String) : int
      {
         var qhStr:String = null;
         var keyChar:String = null;
         if(sameQhPattern.test(name))
         {
            qhStr = name.match(sameQhPattern)[0];
            keyChar = qhStr.charAt(1);
            if(keyChar == "S")
            {
               return int(qhStr.slice(2,qhStr.length));
            }
            if(keyChar == "T")
            {
               return int(qhStr.slice(2,qhStr.length)) + 30000;
            }
         }
         return -1;
      }
      
      public static function compareServName(name1:String, name2:String) : Boolean
      {
         return correctRoleServName(name1) == correctRoleServName(name2);
      }
   }
}

