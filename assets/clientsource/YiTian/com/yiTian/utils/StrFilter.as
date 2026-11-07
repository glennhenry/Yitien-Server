package com.yiTian.utils
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.Dictionary;
   
   public class StrFilter
   {
      
      private static var dic:Dictionary;
      
      private static var functionList:Array = new Array();
      
      private static var isLoading:Boolean = false;
      
      public function StrFilter()
      {
         super();
      }
      
      public static function load(_str:String, callBack:Function) : void
      {
         var url:String = null;
         var request:URLRequest = null;
         var loader:URLLoader = null;
         if(Util.talk_words != null)
         {
            if(Boolean(Util.talk_words.length))
            {
               if(callBack != null)
               {
                  callBack(_str);
               }
            }
            return;
         }
         functionList.push({
            "fun":callBack,
            "str":_str
         });
         if(!isLoading)
         {
            url = (Boolean(Global.config.resUrl) ? Global.config.resUrl : "") + MassLoader.makePath("lang/" + Global.config.lang + "/words");
            request = new URLRequest(url);
            request.method = URLRequestMethod.GET;
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            loader.addEventListener(Event.COMPLETE,function(evt:Event):void
            {
               var obj:Object = null;
               var fun:Function = null;
               var load:URLLoader = evt.currentTarget as URLLoader;
               load.removeEventListener(Event.COMPLETE,arguments.callee);
               load.data.uncompress();
               var str:String = load.data.toString();
               trace(str);
               init(str);
               isLoading = false;
               while(Boolean(functionList.length))
               {
                  obj = functionList.pop();
                  if(obj != null)
                  {
                     fun = obj.fun;
                     if(fun != null)
                     {
                        fun(obj.str);
                     }
                  }
               }
            });
            loader.load(request);
            isLoading = true;
         }
      }
      
      public static function init(str:String) : void
      {
         var reg:RegExp = null;
         var arr:Array = str.split("、");
         var len:int = int(arr.length);
         Util.talk_words = [];
         var i:int = 0;
         while(i < len)
         {
            str = arr[i];
            if(str != "")
            {
               reg = new RegExp(str,"gi");
               Util.talk_words.push(reg);
            }
            i++;
         }
      }
      
      public static function replace(str:String) : String
      {
         return replacewords(Util.talk_words,str);
      }
      
      private static function replacewords(array:Array, str:String) : String
      {
         var len:int = int(array.length);
         var i:int = 0;
         while(i < len)
         {
            if(Boolean(array[i]))
            {
               str = str.replace(array[i],"*");
            }
            i++;
         }
         return str;
      }
      
      private static function takeUnRegisterString_(array:Array, str:String) : void
      {
         var boolean:Boolean = false;
         var newStr:String = null;
         var len:int = int(array.length);
         var i:int = 0;
         while(i < len)
         {
            if(array[i].lastIndex != 0)
            {
               array[i].lastIndex = 0;
            }
            boolean = Boolean(array[i].test(str));
            newStr = str.substr(0,str.length);
            if(boolean == true)
            {
               newStr.replace(array[i],cleanFunc);
            }
            i++;
         }
      }
      
      private static function cleanFunc(... arg) : String
      {
         var strx:String = (arg[0].split(" ") as Array).join("");
         if(dic[strx] == null)
         {
            dic[strx] = strx;
         }
         return strx;
      }
      
      public static function takeUnRegisterString(str:String) : String
      {
         var j:String = null;
         var index:int = 0;
         dic = new Dictionary();
         var unstr:String = LangConfig.getWord("10596",1);
         takeUnRegisterString_(Util.talk_words,str);
         for(j in dic)
         {
            unstr += j + " , ";
         }
         index = unstr.lastIndexOf(",");
         if(index == -1)
         {
            index = unstr.length;
         }
         else
         {
            index = index;
         }
         return unstr.substr(0,index);
      }
      
      private static function hasUnRegisterString_(array:Array, str:String) : Boolean
      {
         var len:int = int(array.length);
         var i:int = 0;
         while(i < len)
         {
            if(array[i].lastIndex != 0)
            {
               array[i].lastIndex = 0;
            }
            if(Boolean(array[i].test(str)))
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public static function hasUnRegisterString(str:String) : Boolean
      {
         if(hasUnRegisterString_(Util.talk_words,str))
         {
            return true;
         }
         return false;
      }
      
      public static function sliceStr(str:String, len:int) : String
      {
         return str.length > len ? str.slice(0,len) + ".." : str;
      }
      
      private function toXingString(index:int) : String
      {
         var s:String = "";
         var i:int = 0;
         while(i < index)
         {
            s += "*";
            i++;
         }
         return s;
      }
   }
}

