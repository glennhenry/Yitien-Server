package com.yiTian.view.modules.chatM
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.gameUnit.role.LZBmp;
   import com.yiTian.utils.MassLoader;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class RitfM extends Sprite
   {
      
      private static var isLoading:Boolean;
      
      private static var pool:Array = [];
      
      private static const FACE_ICON_SIZE:int = 24;
      
      private static var functionList:Array = new Array();
      
      public var _realWid:int;
      
      private var tf:TextField;
      
      private var handle:Function;
      
      private var data:Object;
      
      private var bmp:Bitmap;
      
      private var chatType:int;
      
      private var LZbmp:LZBmp;
      
      private var faceTextFormat:TextFormat;
      
      private var reg:RegExp = /\/\d{2}/;
      
      private var faces:Array = [];
      
      public function RitfM()
      {
         super();
         this.bmp = ComponentUtil.getBitmap("Chat_board",this,null,Global.chat_testdm);
         this.createTextField();
         this.LZbmp = new LZBmp();
         addChild(this.LZbmp);
      }
      
      public static function get instance() : RitfM
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new RitfM();
      }
      
      private function createTextField() : void
      {
         this.faceTextFormat = new TextFormat("Tahoma",12,16774309);
         this.faceTextFormat.leading = 6;
         this.tf = new TextField();
         this.tf.multiline = true;
         this.tf.wordWrap = true;
         this.tf.condenseWhite = false;
         this.tf.filters = Util.glow000000;
         this.tf.selectable = false;
         this.tf.x = 1.5;
         this.tf.y = 1;
         addChild(this.tf);
         this.tf.defaultTextFormat = this.faceTextFormat;
      }
      
      private function rest() : void
      {
         if(Boolean(this.bmp))
         {
            this.bmp.visible = false;
         }
         if(Boolean(this.LZbmp))
         {
            this.LZbmp.bitmapData = null;
         }
      }
      
      public function init(dataStr:String, dataLink:Object, callBack:Function) : void
      {
         this.handle = callBack;
         this.data = dataLink;
         this.htmlText = dataStr;
         if(Boolean(dataLink))
         {
            if(this.data.chat_type == 101)
            {
               this.bmp.visible = true;
               this.bmp.width = 62;
            }
            else if(this.data.chat_type == 1 || this.data.chat_type == 2 || this.data.chat_type == 3 || this.data.chat_type == 4)
            {
               this.bmp.visible = true;
               this.bmp.width = 38;
            }
            else if(this.data.chat_type == 102)
            {
               this.bmp.visible = true;
               this.bmp.width = 38;
            }
            this.chatType = this.data.chat_type;
            if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isIwan(Global.pf))
            {
               this.LZbmp.bmp = ChatMter.addDia(this.data.diaLvl,this.data.isYearDia,this.data.hzLvl,this.data.isYearHz,this.data.isHuiyuan,this.data.isHuiYuanYear,this.data.superLan,this.data.superLanYear,this.LZbmp,this.bmp,this.chatType);
            }
         }
      }
      
      public function set realWid(value:int) : void
      {
         this._realWid = value;
         this.tf.width = this._realWid;
      }
      
      public function get realWid() : int
      {
         return this._realWid;
      }
      
      public function set htmlText(text:String) : void
      {
         this.clearFace();
         this.tf.defaultTextFormat = this.faceTextFormat;
         this.tf.htmlText = text;
         this.tf.addEventListener(TextEvent.LINK,this.link);
         this.setFaces();
      }
      
      private function setFaces() : void
      {
         var value:int = 0;
         var splitArr:Array = this.tf.text.split(/(\/\d{2})/);
         if(!splitArr || splitArr.length == 0)
         {
            return;
         }
         var lastIndex:int = 0;
         var count:int = 1;
         var i:int = 0;
         while(i < splitArr.length)
         {
            value = int(String(splitArr[i]).slice(1,3));
            if(this.reg.test(splitArr[i]) && value > 0 && value <= 36)
            {
               this.tf.replaceText(lastIndex,lastIndex + 3,"      ");
               if(Boolean(this.tf.getCharBoundaries(lastIndex)) && this.tf.getCharBoundaries(lastIndex).x >= width - FACE_ICON_SIZE)
               {
                  this.tf.replaceText(lastIndex,lastIndex,"\n");
                  lastIndex += 1;
               }
               this.addFace(value.toString(),this.tf.getCharBoundaries(lastIndex),this.addImg);
               lastIndex += 6;
               if(count == 5)
               {
                  break;
               }
               count++;
            }
            else
            {
               lastIndex += String(splitArr[i]).length;
            }
            i++;
         }
      }
      
      private function addFace(imgid:String, rect:Rectangle, callBack:Function = null) : void
      {
         if(Boolean(Global.faceDm))
         {
            if(callBack != null)
            {
               callBack(imgid,rect);
            }
            return;
         }
         functionList.push({
            "imgid":imgid,
            "rect":rect,
            "fun":callBack
         });
         if(!isLoading)
         {
            MassLoader.add("lang/" + Global.config.lang + "/FaceIcons.swf",function(info:Object):void
            {
               var obj:Object = null;
               var fun:Function = null;
               isLoading = false;
               Global.faceDm = info.applicationDomain;
               while(Boolean(functionList.length))
               {
                  obj = functionList.pop();
                  if(obj != null)
                  {
                     fun = obj.fun;
                     if(fun != null)
                     {
                        fun(obj.imgid,obj.rect);
                     }
                  }
               }
            });
            isLoading = true;
         }
      }
      
      private function addImg(imgid:String, rect:Rectangle) : void
      {
         var facey:Number = NaN;
         var face:MovieClip = null;
         facey = rect.y - 6;
         var faceClass:Class = Global.faceDm.getDefinition("Face" + imgid) as Class;
         face = new faceClass();
         face.x = rect.x;
         face.y = facey;
         this.faces.push(face);
         addChild(face);
      }
      
      override public function get height() : Number
      {
         return this.tf.textHeight + 4;
      }
      
      public function clearFace() : void
      {
         var face:MovieClip = null;
         for each(face in this.faces)
         {
            removeChild(face);
         }
         this.faces.length = 0;
      }
      
      public function dispose() : void
      {
         this.clearFace();
         this.data = null;
         if(Boolean(this.bmp))
         {
            this.bmp.visible = false;
         }
         this.handle = null;
         if(this.tf.hasEventListener(TextEvent.LINK))
         {
            this.tf.removeEventListener(TextEvent.LINK,this.link);
         }
         pool.push(this);
      }
      
      private function link(e:TextEvent) : void
      {
         if(this.handle != null)
         {
            this.handle.call(null,e,this.data);
         }
      }
   }
}

