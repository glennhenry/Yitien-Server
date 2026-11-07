package com.yiTian.data.model
{
   import com.yiTian.data.vo.Vo_item;
   
   public class ModelChristmas
   {
      
      private static var _instance:ModelChristmas;
      
      public static var scoreShop_page_max:uint;
      
      public static var isLoadCom:Boolean;
      
      public var phase:uint;
      
      public var growupValue:uint;
      
      public var goodsList:Vector.<Vo_item>;
      
      public var giftList:Vector.<uint> = new Vector.<uint>();
      
      public function ModelChristmas()
      {
         super();
      }
      
      public static function get instance() : ModelChristmas
      {
         if(!_instance)
         {
            _instance = new ModelChristmas();
         }
         return _instance;
      }
      
      public static function getNeedScore(id:uint) : uint
      {
         return 10;
      }
      
      public static function isChristmasSnowmanScene(id:uint) : Boolean
      {
         if(id == 13401 || id == 13501 || id == 13601)
         {
            return true;
         }
         return false;
      }
      
      public function isCanGet(pos:uint) : Boolean
      {
         var i:uint = 0;
         for each(i in this.giftList)
         {
            if(i == pos)
            {
               return true;
            }
         }
         return false;
      }
   }
}

