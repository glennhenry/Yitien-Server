package com.yiTian.view.modules.tianmingjj
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.ui.Mouse;
   
   public class TianMingJJCursorManager
   {
      
      private static var tempBmd:BitmapData;
      
      public static var isShow:Boolean;
      
      private static var cursor:Bitmap = new Bitmap();
      
      public function TianMingJJCursorManager()
      {
         super();
      }
      
      public static function show(cursorType:String, dm:ApplicationDomain = null) : void
      {
         if(Boolean(dm))
         {
            tempBmd = ComponentUtil.getBitmapData(cursorType,dm);
            cursor.bitmapData = tempBmd;
         }
         else
         {
            cursor = Utils.getLoadBitmap(cursorType,cursor);
         }
         cursor.x = Global.stage.mouseX;
         cursor.y = Global.stage.mouseY;
         GameScene.instance.addChild(cursor);
         Mouse.hide();
         Global.stage.addEventListener(MouseEvent.MOUSE_MOVE,move);
         isShow = true;
      }
      
      private static function move(e:MouseEvent) : void
      {
         cursor.x = Global.stage.mouseX;
         cursor.y = Global.stage.mouseY;
         e.updateAfterEvent();
      }
      
      public static function hide() : void
      {
         if(GameScene.instance.contains(cursor))
         {
            GameScene.instance.removeChild(cursor);
         }
         Global.stage.removeEventListener(MouseEvent.MOUSE_MOVE,move);
         Mouse.show();
         isShow = false;
      }
   }
}

