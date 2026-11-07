package com.yiTian.view.modules.friends
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_ZhuFuATip extends Sprite
   {
      
      private static var _instance:View_ZhuFuATip;
      
      private var _bg:Bitmap;
      
      public function View_ZhuFuATip()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singlton error");
         }
         this.init();
         _instance = this;
      }
      
      public static function get instance() : View_ZhuFuATip
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/myPath/" + "ZhuFu_Icon" + ".png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         var delegate:Delegate123;
         var pnl:View_ZhuFuPanel = null;
         evt.stopPropagation();
         delegate = Singleton.getInstance(Delegate123);
         pnl = UIManager.zhufuPanel;
         delegate.dosomething(pnl,function():void
         {
            pnl.visible = !pnl.visible;
         });
      }
   }
}

