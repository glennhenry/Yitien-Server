package com.yiTian.data.model
{
   import com.yiTian.data.vo.Vo_TuanGouItem;
   import com.yiTian.data.vo.Vo_TuanGou_Dial_Goods_Item;
   import com.yiTian.data.vo.Vo_TuanGou_Goods_Item;
   import com.yiTian.data.vo.Vo_TuanGou_Player;
   
   public class Model_TuanGou
   {
      
      public static var vecDial:Vector.<int>;
      
      public static var tuanGouVo:Vo_TuanGou_Goods_Item;
      
      public static var maoPaoStr:String;
      
      public static var vecItemVo:Vector.<Vo_TuanGouItem> = new Vector.<Vo_TuanGouItem>();
      
      public static var keepObj:Object = {
         "weekCount":0,
         "surplus":0,
         "playerCount":0,
         "suffer":115,
         "biLi":45
      };
      
      public static var vecPlayAwards:Vector.<Vo_TuanGou_Player> = new Vector.<Vo_TuanGou_Player>();
      
      public static const count:int = 10;
      
      public static var nameVec:Vector.<String> = new Vector.<String>(0);
      
      public static var vecTemp:Array = [41027,41081,41084,41087,41001,41004,41007,41011,41014,41017,41021,41024];
      
      public static var vecWheelGoods:Vector.<Vo_TuanGou_Dial_Goods_Item> = new Vector.<Vo_TuanGou_Dial_Goods_Item>();
      
      public function Model_TuanGou()
      {
         super();
      }
      
      public static function dialItemData() : void
      {
      }
   }
}

