package com.yiTian.view.modules.wuXing
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.IDelegate123Obj;
   import flash.utils.Dictionary;
   
   public class WuXingMter
   {
      
      public static var style:int;
      
      public static var tabStyArr:Array = ["TabButton_Jin","TabButton_Mu","TabButton_Shui","TabButton_Huo","TabButton_Tu"];
      
      public static var bmStyArr:Array = ["Icon_Jin","Icon_Mu","Icon_Shui","Icon_Huo","Icon_Tu"];
      
      public static var tabPropertyArr:Array = [{
         "x":172,
         "y":69
      },{
         "x":51,
         "y":160
      },{
         "x":99,
         "y":295
      },{
         "x":243,
         "y":295
      },{
         "x":290,
         "y":160
      }];
      
      public static var chongShuWorth:Array = [0,1000,2500,5000,7500];
      
      public static var idArr:Array = [[29005,300],[29105,200],[29205,400],[29305,200],[29405,100]];
      
      public static var type:int = 0;
      
      public static var underSign:int = 0;
      
      public static var colorArr:Array = ["#04ff00","#de45c7"];
      
      public static const non_descrip:String = "您还没有{0},是否花费{1}元宝继续修炼?";
      
      public static var tipsStr:String = "当前五行修炼：第{0}重\n五行全属性额外加成：\n金属性：{1}\n木属性：{2}\n水属性：{3}\n火属性：{4}\n土属性：{5}";
      
      public function WuXingMter()
      {
         super();
      }
      
      public static function getPan(cl:Class, func:Function) : void
      {
         var pan:IDelegate123Obj = null;
         pan = Singleton.getInstance(cl);
         Global.delegate.dosomething(pan,function():void
         {
            if(Boolean(func.length))
            {
               func(pan);
            }
            else
            {
               func();
            }
         });
      }
      
      public static function getChongShuWorth(totalWorth_t:int) : int
      {
         var key:String = null;
         var len:int = 0;
         var _index:int = 0;
         var bg:int = 0;
         var lt:int = 0;
         var dic:Dictionary = Data_lib.Wuxing_s;
         var dataArr:Array = [];
         for(key in dic)
         {
            dataArr.push(dic[key]);
         }
         len = int(dataArr.length);
         _index = 0;
         while(_index < len - 1)
         {
            bg = int(dataArr[_index][1]);
            lt = int(dataArr[_index + 1][1]);
            if(totalWorth_t >= bg && totalWorth_t < lt)
            {
               return _index + 1;
            }
            if(totalWorth_t >= dataArr[len - 1][1])
            {
               return 11;
            }
            _index++;
         }
         return 0;
      }
      
      public static function getCount() : int
      {
         var num1:int = CommandManager.get_bag_count(44587);
         var num2:int = CommandManager.get_bag_count(44588);
         if(num1 == 0)
         {
            if(num2 == 0)
            {
               return -1;
            }
            return 2;
         }
         if(num2 == 0)
         {
            return 1;
         }
         return 3;
      }
   }
}

