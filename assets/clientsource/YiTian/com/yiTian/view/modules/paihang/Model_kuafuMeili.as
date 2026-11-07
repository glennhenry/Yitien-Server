package com.yiTian.view.modules.paihang
{
   import com.yiTian.utils.HtmlUtil;
   
   public class Model_kuafuMeili
   {
      
      private static var _str:String;
      
      public function Model_kuafuMeili()
      {
         super();
      }
      
      public static function get descrip() : String
      {
         if(!_str)
         {
            _str = HtmlUtil.font("玩法介绍：\n","#f9ff00") + "1.跨服鲜花分为两个榜单。一个是男榜单，一个是女榜单。\n" + "2.开始时间在每周一的00:00开始至每周日的24:00截止。\n" + "3.活动期间赠送本服玩家的也算在跨服鲜花数量内。\n" + "4.每周日24:00统计出活动期间内收到鲜花数量最多的四十三名玩家。\n" + "5.四十三名玩家获得礼包奖励的同时还可获得额外的称谓和专属时装奖励。";
         }
         return _str;
      }
   }
}

