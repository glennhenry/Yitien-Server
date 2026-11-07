package com.yiTian.view.modules.meirixg
{
   public class Enum_MeiRiXianGou
   {
      
      public static var moneyName:Array = ["","元宝","礼券","基金","银子","银两(优先扣绑银)"];
      
      public function Enum_MeiRiXianGou()
      {
         super();
      }
      
      public static function getHot(index:int) : String
      {
         var arr:Array = ["","Icon_JBYiZ","Icon_JBErZ","Icon_JBSanZ","Icon_JBSiZ","Icon_JBWuZ","Icon_JBLiuZ","Icon_JBQiZ","Icon_JBBaZ","Icon_JBJiuZ"];
         return arr[index];
      }
      
      public static function getMoneyIcon(index:int) : String
      {
         var arr:Array = ["","Icon_YuanBao","Icon_LiJuan","Icon_JiJin","Icon_YinZi","Icon_BangYin"];
         return arr[index];
      }
   }
}

