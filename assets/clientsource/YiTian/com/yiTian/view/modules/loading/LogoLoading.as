package com.yiTian.view.modules.loading
{
   import com.yiTian.Global;
   import com.yiTian.utils.MassLoader;
   import flash.display.Sprite;
   
   public class LogoLoading extends Sprite
   {
      
      public static var isInit:Boolean;
      
      private static var _instance:LogoLoading;
      
      private var _logo:Logo;
      
      private var _isLoading:Boolean;
      
      public function LogoLoading()
      {
         super();
         this.loadLogo();
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
               _logo.y = Global.stage.stageHeight / 2 - 90;
               if(_isLoading)
               {
                  begin();
               }
            }
         });
      }
      
      public function begin() : void
      {
         this._isLoading = true;
         if(Boolean(this._logo))
         {
            this._logo.begin();
         }
      }
      
      public function end() : void
      {
         this._isLoading = false;
         if(Boolean(this._logo))
         {
            this._logo.end();
         }
      }
      
      public function resize() : void
      {
         if(Boolean(this._logo))
         {
            this._logo.x = (Global.stage.stageWidth - 205) / 2;
            this._logo.y = Global.stage.stageHeight / 2 - 90;
         }
      }
   }
}

