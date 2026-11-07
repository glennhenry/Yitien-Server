package com.yiTian.view.modules.friends
{
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class View_FlowerItem extends Sprite
   {
      
      public static var path1:String = "resource/image/friend/Flowers9.png";
      
      public static var path2:String = "resource/image/friend/Flowers99.png";
      
      public static var path3:String = "resource/image/friend/Flowers999.png";
      
      public static var pathList:Array = new Array(path1,path2,path3);
      
      public var type:int;
      
      public var flowerNum:int;
      
      public function View_FlowerItem(num:int = 0, _type:int = 0)
      {
         var bg:Bitmap = null;
         super();
         bg = Utils.getLoadBitmap(pathList[_type]);
         this.buttonMode = true;
         this.addChild(bg);
         this.flowerNum = num;
         this.type = _type;
      }
   }
}

