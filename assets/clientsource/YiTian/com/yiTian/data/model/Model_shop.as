package com.yiTian.data.model
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   
   public class Model_shop
   {
      
      public static var get_shop_id:int;
      
      public static var data:Array = [];
      
      public static var ZHD_data_arr:Array = [];
      
      public static var ZB_data_arr:Array = [];
      
      public static var YP_data_arr:Array = [];
      
      public static var title_str:String = "";
      
      public static var longShopData:Array = [];
      
      public static var longShopType:Boolean = false;
      
      public static var getColorArr:Array = ["0xffffff","0x04ff00","0x33ccff","0xff00ff","0xff7700"];
      
      public static var get_color_arr:Array = ["#ffffff","#04ff00","#33ccff","#ff00ff","#ff7700","#fe0000"];
      
      public static var get_bangJob_color_arr:Array = ["#ff5d38","#04ff00","#33ccff","#ff00ff","#ff7700"];
      
      public function Model_shop()
      {
         super();
      }
      
      public static function getPriceByID(id:int) : int
      {
         try
         {
            return Data_lib.item[id][Enum_lib_item.PRICE];
         }
         catch(e:Error)
         {
            return Data_lib.equip[id][10];
         }
      }
   }
}

