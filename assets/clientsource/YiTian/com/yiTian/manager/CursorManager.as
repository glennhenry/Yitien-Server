package com.yiTian.manager
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class CursorManager
   {
      
      public static var isShow:Boolean;
      
      private static var cursor:Bitmap = new Bitmap();
      
      public function CursorManager()
      {
         super();
      }
      
      public static function show(cursorType:String) : void
      {
         if(!CursorManager[cursorType])
         {
            CursorManager[cursorType] = ComponentUtil.getBitmapData("cursor_" + cursorType);
         }
         cursor.bitmapData = CursorManager[cursorType];
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

