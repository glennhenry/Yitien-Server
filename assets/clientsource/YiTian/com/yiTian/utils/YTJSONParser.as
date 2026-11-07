package com.yiTian.utils
{
   import flash.events.EventDispatcher;
   import org.hamcrest.core.throws;
   
   public class YTJSONParser extends EventDispatcher
   {
      
      public static const testStr:String = "{\"testArray\":\t\n[{\"head\":{\"PacketLen\":null,\"Cmdid\":4111}}, {\"head2\":{\"PacketLen\":null,\"Cmdid\":4111}}],\"head\":{\"PacketLen\":null,\"Cmdid\":4111,\"Seqid\":1782523,\"ServiceName\":\"OP_YT\",\"SendTime\":20130322,\"Version\":13,\"Authenticate\":\"\",\"Result\":0,\"RetErrMsg\":\"\"},\"body\":{\"AreaId\":10,\"Type\":2,\"PageNo\":0,\"Update\":0,\"StartTime\":1363622400,\"EndTime\":1364227199,\"ListCount\":20}}";
      
      private var _info:String;
      
      private var _currentIndex:uint;
      
      public function YTJSONParser()
      {
         super();
      }
      
      public static function get instance() : YTJSONParser
      {
         return Singleton.getInstance(YTJSONParser);
      }
      
      public function parseStringToObject(info:String) : Object
      {
         this._currentIndex = 0;
         this._info = info;
         return this.parse();
      }
      
      private function parse() : Object
      {
         var result:Object = null;
         var token:String = this.getNextToken();
         switch(token)
         {
            case "{":
               this.returnToPreToken();
               result = this.parseMap();
               break;
            case "\"":
               this.returnToPreToken();
               result = this.parseString();
               break;
            case "[":
               this.returnToPreToken();
               result = this.parseArray();
               break;
            default:
               result = token;
         }
         return result;
      }
      
      private function isEOF() : Boolean
      {
         return this._currentIndex >= this._info.length;
      }
      
      private function parseMap() : Object
      {
         var key:Object = null;
         var flag:Object = null;
         var value:Object = null;
         var map:Object = {};
         var token:String = this.getNextToken();
         while(token != "}")
         {
            key = this.parse();
            flag = this.getNextToken();
            if(flag != ":")
            {
               this.fireError("【" + flag + "】 is not a right token at parseMap");
            }
            value = this.parse();
            map[key] = value;
            token = this.getNextToken();
         }
         return map;
      }
      
      private function parseArray() : Array
      {
         var arr:Array = [];
         var token:Object = this.getNextToken();
         while(token != "]")
         {
            token = this.parse();
            if(token != "," && token != "]")
            {
               arr.push(token);
            }
         }
         return arr;
      }
      
      public function parseString() : String
      {
         var tmp:String = null;
         var result:String = "";
         var head:String = this.getNextToken();
         var ch:String = this.getNextChar();
         while(Boolean(ch) && ch != "\"")
         {
            if(ch == "\\")
            {
               tmp = this.getNextChar();
               if(tmp == "n")
               {
                  tmp = "\n";
               }
               else if(tmp == "t")
               {
                  tmp = "\t";
               }
               else if(tmp == "r")
               {
                  tmp = "\r";
               }
               result += tmp;
               ch = this.getNextChar();
            }
            else
            {
               result += ch;
               ch = this.getNextChar();
            }
         }
         return result;
      }
      
      public function returnToPreToken() : void
      {
         var ch:String = null;
         while(this._currentIndex >= 0)
         {
            this._currentIndex -= 1;
            ch = this._info.charAt(this._currentIndex);
            if(ch != "\n" && ch != " " && ch != "\t" && ch != "\r")
            {
               break;
            }
         }
      }
      
      private function skipWhiteSpace() : void
      {
         var ch:String = null;
         while(!this.isEOF())
         {
            ch = this.getNextChar();
            if(ch != "\n" && ch != " " && ch != "\t" && ch != "\r")
            {
               this._currentIndex -= 1;
               break;
            }
         }
      }
      
      private function getNextToken() : String
      {
         var ch:String = null;
         var token:String = "";
         this.skipWhiteSpace();
         while(!this.isEOF())
         {
            ch = this.getNextChar();
            if(ch == "\"" || ch == "{" || ch == "}" || ch == " " || ch == "," || ch == ":" || ch == "[" || ch == "]")
            {
               if(token != "")
               {
                  this._currentIndex -= 1;
                  break;
               }
               token = ch;
               break;
            }
            token += ch;
         }
         return token;
      }
      
      private function getNextChar() : String
      {
         if(this._currentIndex < this._info.length)
         {
            return this._info.charAt(this._currentIndex++);
         }
         return null;
      }
      
      public function fireError(msg:Object) : void
      {
         throws(new Error(msg));
      }
   }
}

