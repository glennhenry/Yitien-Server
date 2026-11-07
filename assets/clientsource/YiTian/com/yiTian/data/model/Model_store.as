package com.yiTian.data.model
{
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import flash.utils.Dictionary;
   
   public class Model_store
   {
      
      public static var store_data_sava:Dictionary = new Dictionary();
      
      public static var store_youhui_data:Dictionary = new Dictionary();
      
      public function Model_store()
      {
         super();
      }
      
      public static function getCount(wp_id:int) : int
      {
         var count:int = 0;
         var vec:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[wp_id]);
         var i:int = 0;
         while(i < vec.length)
         {
            count += vec[i].count;
            i++;
         }
         return count;
      }
   }
}

