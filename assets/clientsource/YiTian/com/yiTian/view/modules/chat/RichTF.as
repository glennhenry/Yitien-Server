package com.yiTian.view.modules.chat
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.gameUnit.role.LZBmp;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.chatM.face.Model_face;
   import com.yiTian.view.modules.roleHead.View_HeroHead;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class RichTF extends Sprite
   {
      
      private static var isLoading:Boolean;
      
      private static var pool:Array = [];
      
      private static const FACE_ICON_SIZE:int = 24;
      
      public static var roleVipDic:Dictionary = new Dictionary();
      
      private static var functionList:Array = new Array();
      
      public static var dmDic:Dictionary = new Dictionary();
      
      private static const urlArr:Array = [50001,50002,50003,50004,50005];
      
      protected var tf:TextField;
      
      private var tf1:TextField;
      
      public var addHtmlText:String = "";
      
      private var myFacePattern:RegExp = /000/g;
      
      private var faceTextFormat:TextFormat;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var faces:Array;
      
      private var hoverColor:uint = 16776960;
      
      public var data:Object;
      
      private var handler:Function;
      
      private var _chatBack:Bitmap = new Bitmap();
      
      private var light:DisplayObject;
      
      private var _mask:DisplayObject;
      
      private var LZbmp:LZBmp = new LZBmp();
      
      private var chatType:int;
      
      private var pattern:RegExp = /(\/\d{2})/g;
      
      private var reg:RegExp = /\/\d{3}/;
      
      public function RichTF(_leading:int = 6)
      {
         super();
         this.faceTextFormat = new TextFormat("Tahoma",12,16774309);
         this.faceTextFormat.leading = _leading;
         blendMode = BlendMode.LAYER;
         this.faces = [];
         this.createTextField();
         this.getBack();
         addChildAt(this.LZbmp,numChildren - 1);
      }
      
      public static function getRichTF(_leading:int = 6) : RichTF
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new RichTF(_leading);
      }
      
      private function createTextField() : void
      {
         this.tf = new TextField();
         this.tf.width = 250;
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
      
      private function getBack() : void
      {
         this._chatBack = ComponentUtil.getBitmap("Chat_board",this,null,Global.Img_Cdm);
         this._chatBack.visible = false;
         addChildAt(this._chatBack,0);
      }
      
      public function set align(value:String) : void
      {
         this.faceTextFormat.align = value;
         this.tf.defaultTextFormat = this.faceTextFormat;
      }
      
      public function get TextWidth() : int
      {
         return this.tf.textWidth;
      }
      
      public function init(text:String, data:Object = null, fun:Function = null) : void
      {
         this.data = data;
         this._chatBack.visible = false;
         if(Boolean(this.LZbmp))
         {
            this.LZbmp.bitmapData = null;
         }
         if(Boolean(data))
         {
            if(data.chat_type == 101)
            {
               this._chatBack.visible = true;
               this._chatBack.width = 62;
            }
            else if(data.chat_type == 1 || data.chat_type == 2 || data.chat_type == 3 || data.chat_type == 4 || data.chat_type == 8)
            {
               this._chatBack.visible = true;
               this._chatBack.width = 38;
            }
            else if(data.chat_type == 102)
            {
               this._chatBack.visible = true;
               this._chatBack.width = 38;
            }
            this.chatType = data.chat_type;
            if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf) || Enum_SPStr.isIwan(Global.pf))
            {
               this.addDia(data.diaLvl,data.isYearDia,data.hzLvl,data.isYearHz,data.isHuiyuan,data.isHuiYuanYear,data.superLan,data.superLanYear,data.isSuperHuang);
            }
         }
         this.handler = fun;
         this.htmlText = text;
         this.tf.addEventListener(TextEvent.LINK,this.linkHandler);
      }
      
      private function playEff() : void
      {
         this.light = ComponentUtil.getDisplayObject("back",null,null,Global.effectWord);
         this.light.alpha = 0.1;
         this.light.y = this.tf.y + 8;
         this.light.blendMode = BlendMode.ADD;
         addChild(this.light);
         this.light.mask = this.tf;
         Tween.to(this.light,100,{"x":[this.tf.x,this.tf.x + this.tf.width]},function():void
         {
            removeChild(light);
            light = null;
         });
      }
      
      public function addDia(diaLvl:int, isYearDia:int, hzLvl:int = 0, isYearHz:int = 0, isHuiyuan:int = 0, isHuiyuanYear:int = 0, superLan:int = 0, superLanYear:int = 0, isSuperHuang:int = 0) : void
      {
         this.LZbmp.bitmapData = null;
         this.tf.x = 1.5;
         if(Global.pf == "qqgame" || Global.pf == Enum_SPStr.QQ3366)
         {
            if(superLanYear == 0 && superLan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getsuperLan(superLan),this.LZbmp.bmp,null,function():void
               {
                  resize(3);
               });
               return;
            }
            if(superLan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getsuperLanYear(superLan),this.LZbmp.bmp,null,function():void
               {
                  resize(3);
               });
               return;
            }
            if(isYearDia == 0 && diaLvl > 0)
            {
               Utils.getLoadBitmap(LZBmp.getLvlUrl(diaLvl),this.LZbmp.bmp,null,function():void
               {
                  resize(3);
               });
            }
            else if(diaLvl > 0)
            {
               Utils.getLoadBitmap(LZBmp.getYearUrl(diaLvl),this.LZbmp.bmp,null,function():void
               {
                  resize(3);
               });
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isPartUnion() || Enum_SPStr.isUnion(Global.pf))
         {
            if(isHuiyuanYear == 0 && isHuiyuan > 0)
            {
               Utils.getLoadBitmap(LZBmp.getQQHuiYuan(isHuiyuan),this.LZbmp.bmp,null,this.resize);
            }
            else if(isHuiyuan > 0)
            {
               Utils.getLoadBitmap(LZBmp.getQQHuiYuanYear(isHuiyuan),this.LZbmp.bmp,null,this.resize);
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(Boolean(isSuperHuang))
            {
               if(isYearHz == 0 && hzLvl > 0)
               {
                  Utils.getLoadBitmap(LZBmp.getLvlUrl_superH(hzLvl),this.LZbmp.bmp,null,function():void
                  {
                     resize(3);
                  });
               }
               else if(hzLvl > 0)
               {
                  Utils.getLoadBitmap(LZBmp.getYearUrl_superH(hzLvl),this.LZbmp.bmp,null,function():void
                  {
                     resize(3);
                  });
               }
            }
            else if(isYearHz == 0 && hzLvl > 0)
            {
               Utils.getLoadBitmap(LZBmp.getLvlUrl_h(hzLvl),this.LZbmp.bmp,null,function():void
               {
                  resize(3);
               });
            }
            else if(hzLvl > 0)
            {
               Utils.getLoadBitmap(LZBmp.getYearUrl_h(hzLvl),this.LZbmp.bmp,null,function():void
               {
                  resize(3);
               });
            }
         }
      }
      
      private function resize(_space:int = 0) : void
      {
         this.LZbmp.x = this._chatBack.x + this._chatBack.width;
         if(this.chatType == 6)
         {
            this.LZbmp.x = 0;
         }
         this.LZbmp.y = _space;
         setChildIndex(this.LZbmp,numChildren - 1);
      }
      
      override public function set width(value:Number) : void
      {
         this.tf.width = value;
      }
      
      override public function get width() : Number
      {
         return this.tf.width;
      }
      
      override public function get height() : Number
      {
         return this.tf.textHeight + 6;
      }
      
      public function set htmlText(text:String) : void
      {
         this.clearFace();
         this.tf.defaultTextFormat = this.faceTextFormat;
         this.tf.htmlText = text;
         if(Boolean(this.data))
         {
            if(this.data.chat_type == 103)
            {
               this.playEff();
            }
         }
         this.setFaces();
         if(this.tf.textHeight > 100)
         {
            this.tf.height = this.tf.textHeight + 12;
         }
         this._height = this.tf.textHeight + 12;
      }
      
      private function setFaces() : void
      {
         var value:int = 0;
         var splitArr:Array = this.tf.text.split(/(\/\d{3})/);
         if(!splitArr || splitArr.length == 0)
         {
            return;
         }
         var lastIndex:int = 0;
         var count:int = 1;
         var __len:int = 36;
         var _name:String = "";
         if(Boolean(this.data) && Boolean(this.data.name))
         {
            _name = this.data.name;
            if(roleVipDic[this.data.name] > 0)
            {
               __len = 72;
            }
            else
            {
               __len = 36;
            }
         }
         else
         {
            _name = View_HeroHead.playerName;
            if(roleVipDic[_name] > 0)
            {
               __len = 72;
            }
            else
            {
               __len = 36;
            }
         }
         var i:int = 0;
         while(i < splitArr.length)
         {
            value = int(String(splitArr[i]).slice(1,4));
            if(this.reg.test(splitArr[i]) && value > 0 && value <= __len || this.reg.test(splitArr[i]) && this.areaHandler(value,_name))
            {
               this.tf.replaceText(lastIndex,lastIndex + 4,"      ");
               if(Boolean(this.tf.getCharBoundaries(lastIndex)) && this.tf.getCharBoundaries(lastIndex).x >= this.width - FACE_ICON_SIZE)
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
      
      private function areaHandler(value:int, _name:String) : Boolean
      {
         var id:int = 0;
         var _arr:Array = null;
         var arr:Array = Model_face.chatRoleHasOwnedFaceInfo[_name];
         for each(id in arr)
         {
            _arr = Model_face.startEndArr[id - 50001];
            if(Boolean(_arr) && Boolean(value >= _arr[0]) && value <= _arr[1])
            {
               return true;
            }
         }
         return false;
      }
      
      private function addFace(imgid:String, rect:Rectangle, callBack:Function = null) : void
      {
         var obj:Object = null;
         var _eUrl:String = null;
         if(this.getDmByIndex(int(imgid)) != null)
         {
            if(callBack != null)
            {
               if(int(imgid) < 37)
               {
                  callBack(imgid,rect,Global.faceDm);
               }
               else
               {
                  callBack(imgid,rect,dmDic[this.getIndexByImgId(int(imgid))]);
               }
            }
            return;
         }
         functionList.push({
            "imgid":imgid,
            "rect":rect,
            "fun":callBack
         });
         while(Boolean(functionList.length))
         {
            obj = functionList.pop();
            if(obj == null)
            {
               functionList.splice(functionList.indexOf(obj),1);
            }
            else if(!this.getDmByIndex(obj.imgid))
            {
               _eUrl = int(obj.imgid) < 37 ? "" : "_" + this.getIndexByImgId(obj.imgid);
               MassLoader.add("lang/ch/FaceIcons" + _eUrl + ".swf",function(info:Object):void
               {
                  if(info.obj.imgid < 37)
                  {
                     Global.faceDm = info.applicationDomain;
                  }
                  else
                  {
                     dmDic[getIndexByImgId(info.obj.imgid)] = info.applicationDomain;
                  }
                  var fun:Function = info.obj.fun;
                  if(fun != null)
                  {
                     fun(info.obj.imgid,info.obj.rect,info.applicationDomain);
                  }
               },null,MassLoader.LEVEL2,obj);
            }
         }
      }
      
      private function getDmByIndex(index:int) : ApplicationDomain
      {
         if(index < 37)
         {
            return Global.faceDm;
         }
         return dmDic[this.getIndexByImgId(index)];
      }
      
      private function getIndexByImgId(imgid:int) : int
      {
         return int(int((imgid - 37) / 36) + 50001);
      }
      
      private function getLenByIndex(index:int) : Object
      {
         var obj:Object = new Object();
         obj.max = int(index - 50001) * 36 + 73;
         obj.min = int(index - 50001) * 36 + 36;
         return obj;
      }
      
      private function addImg(imgid:String, rect:Rectangle, dm:ApplicationDomain = null) : void
      {
         var face:MovieClip = null;
         var facey:Number = rect.y - 6;
         var imgidMM:int = int(imgid);
         var faceClass:Class = dm.getDefinition("Face" + imgidMM) as Class;
         face = new faceClass();
         face.x = rect.x;
         face.y = facey;
         this.faces.push(face);
         addChild(face);
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
      
      private function linkHandler(e:TextEvent) : void
      {
         if(this.handler != null)
         {
            this.handler.call(null,e,this.data);
         }
      }
      
      public function dispose() : void
      {
         this.clearFace();
         this.data = null;
         if(Boolean(this.LZbmp))
         {
            this.LZbmp.bitmapData = null;
         }
         this.handler = null;
         if(this.tf.hasEventListener(TextEvent.LINK))
         {
            this.tf.removeEventListener(TextEvent.LINK,this.linkHandler);
         }
         pool.push(this);
      }
   }
}

