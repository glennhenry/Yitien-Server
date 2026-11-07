package view
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.ProgressEvent;
   import flash.text.TextField;
   import manager.MassLoader;
   
   public class LogoLoading extends Sprite
   {
      
      public static var isInit:Boolean;
      
      private static var _instance:LogoLoading;
      
      private var _logo:Logo;
      
      private var _tipTF:TextField;
      
      private var bmd:BitmapData;
      
      private var _url:String;
      
      private var _fun:Function;
      
      private var _str:String;
      
      public function LogoLoading()
      {
         super();
         this._tipTF = ComponentUtil.getTextField(Model_initStr.LINK_SERVER + " (" + Util.rnd(10,70) + "%)",this,{
            "realWidth":200,
            "size":14,
            "bold":true
         });
         this.loadLogo();
         this.loadBm();
      }
      
      public static function get instance() : LogoLoading
      {
         if(!_instance)
         {
            _instance = new LogoLoading();
            isInit = true;
         }
         return _instance;
      }
      
      private function loadLogo() : void
      {
         MassLoader.add("resource/image/logo/loading.swf",function(info:Object):void
         {
            if(Boolean(info.content))
            {
               _logo = new Logo();
               addChild(_logo);
               _logo.play(info);
               _logo.x = (Global.stage.stageWidth - 205) / 2;
               _logo.y = _tipTF.y - 150;
            }
         });
      }
      
      private function loadBm() : void
      {
         MassLoader.add("resource/image/logo/di3.jpg",function(info:Object):void
         {
            if(Boolean(info.content))
            {
               bmd = (info.content as Bitmap).bitmapData;
               drawBack();
            }
         });
      }
      
      private function drawBack() : void
      {
         if(!this.bmd)
         {
            return;
         }
         graphics.clear();
         graphics.beginBitmapFill(this.bmd,null,true);
         graphics.drawRect(0,0,Global.stage.stageWidth,Global.stage.stageHeight);
         graphics.endFill();
      }
      
      private function begin() : void
      {
         this.resize();
      }
      
      public function load(url:String, str:String, fun:Function = null) : void
      {
         this.begin();
         this._url = url;
         this._fun = fun;
         this._str = str;
         this._load();
      }
      
      private function _load() : void
      {
         MassLoader.add(this._url,function(info:Object):void
         {
            _fun(info);
         },this.progressEvent);
      }
      
      private function progressEvent(e:ProgressEvent) : void
      {
         var progressNum:Number = e.bytesLoaded / e.bytesTotal;
         this._tipTF.text = this._str + " (" + uint(progressNum * 100) + "%)";
      }
      
      public function dispose() : void
      {
         var child:DisplayObject = null;
         if(Boolean(this.bmd))
         {
            this.bmd.dispose();
         }
         if(Boolean(this._logo))
         {
            this._logo.dispose();
         }
         graphics.clear();
         while(Boolean(numChildren))
         {
            child = getChildAt(0);
            removeChild(child);
         }
         isInit = false;
      }
      
      public function resize() : void
      {
         this.drawBack();
         this._tipTF.x = Global.stage.stageWidth / 2 - 60;
         this._tipTF.y = Global.stage.stageHeight / 2 + 60;
         if(Boolean(this._logo))
         {
            this._logo.x = (Global.stage.stageWidth - 205) / 2;
            this._logo.y = this._tipTF.y - 150;
         }
      }
   }
}

