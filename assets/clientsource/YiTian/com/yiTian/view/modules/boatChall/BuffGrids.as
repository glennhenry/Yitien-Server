package com.yiTian.view.modules.boatChall
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BuffGrids extends Sprite
   {
      
      private static var pool:Array = [];
      
      private static var list:Array = [];
      
      private static const sourceArr:Array = ["","","","",""];
      
      public function BuffGrids()
      {
         super();
         GameScene.uiLayer.addChild(this);
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
         this.resize();
      }
      
      public static function get instance() : BuffGrids
      {
         return Singleton.getInstance(BuffGrids);
      }
      
      public function update(str:String) : void
      {
         var bb:Bitmap = null;
         var index:String = null;
         this.clear();
         var arr:Array = str.split("_");
         var i:int = 0;
         while(i < arr.length)
         {
            bb = this.getBM();
            index = arr[i];
            Utils.getLoadBitmap("resource/image/boat/buff_" + index + ".png",bb,{
               "x":70 * i,
               "y":0
            });
            addChild(bb);
            list.push(bb);
            i++;
         }
         if(!visible)
         {
            visible = true;
         }
      }
      
      private function clear() : void
      {
         var bm:Bitmap = null;
         while(Boolean(list.length))
         {
            bm = list.pop();
            if(Boolean(bm) && Boolean(bm.parent))
            {
               bm.parent.removeChild(bm);
            }
            pool.push(bm);
         }
      }
      
      public function getBM() : Bitmap
      {
         return pool.pop() || new Bitmap();
      }
      
      private function resize() : void
      {
         x = (Global.stage.stageWidth - 350) / 2;
         y = 100;
      }
   }
}

