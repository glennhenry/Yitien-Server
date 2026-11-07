package com.yiTian.view.modules.friends
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_AddFriendTip extends Sprite
   {
      
      private static var instance:View_AddFriendTip;
      
      private var _bm:Bitmap;
      
      public function View_AddFriendTip()
      {
         super();
         if(Boolean(instance))
         {
            throw new Error("singlon error");
         }
         instance = this;
         this.init();
      }
      
      public static function getInstance() : View_AddFriendTip
      {
         if(instance)
         {
         }
         return instance;
      }
      
      private function init() : void
      {
         this._bm = new Bitmap();
         this._bm = Utils.getLoadBitmap("resource/image/myPath/" + "you" + ".png",this._bm);
         addChild(this._bm);
         mouseChildren = false;
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      override public function set visible(value:Boolean) : void
      {
      }
      
      protected function clickHandle(evt:MouseEvent) : void
      {
         UIManager.friQuestPanel.show();
         evt.stopPropagation();
      }
   }
}

