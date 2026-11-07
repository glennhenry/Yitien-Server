package com.yiTian.data.model
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.HtmlUtil;
   import flash.utils.Dictionary;
   
   public class Model_chat
   {
      
      public static var data:Dictionary = new Dictionary();
      
      public static var chat_save:Array = [];
      
      public static var txtArr:Array = new Array();
      
      public static var SC_str:String = getStr();
      
      public function Model_chat()
      {
         super();
      }
      
      public static function getStr() : String
      {
         var key:String = null;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var arr:Array = null;
         var i:int = 0;
         var str:String = "";
         var _dic:Dictionary = Data_lib.sc_data;
         var _arr:Array = [];
         for(key in _dic)
         {
            _arr.push(_dic[key]);
         }
         arr = [];
         i = 0;
         while(i < _arr.length)
         {
            if(_arr[i][2] == 1)
            {
               voI = new Vo_item();
               voI.id = _arr[i][0];
               voI.Init_lib();
               voI.count = _arr[i][1];
               arr.push([voI.str_name,voI.count,voI.color]);
            }
            else if(_arr[i][2] == 2)
            {
               voE = new Vo_equip();
               voE.id = _arr[i][0];
               voE.Init_lib();
               voE.count = _arr[i][1];
               arr.push([voE.str_name,voE.count,voE.color]);
            }
            i++;
         }
         i = 0;
         while(i < arr.length)
         {
            str += HtmlUtil.font(arr[i][0] + "X" + arr[i][1],Model_shop.get_color_arr[arr[i][2] - 1],13) + "\n";
            i++;
         }
         return HtmlUtil.font(HtmlUtil.bold(" 首充大礼包"),"#ff9900",15) + "\n" + str;
      }
   }
}

