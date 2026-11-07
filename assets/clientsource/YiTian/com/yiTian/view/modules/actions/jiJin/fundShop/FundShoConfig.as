package com.yiTian.view.modules.actions.jiJin.fundShop
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_store;
   import flash.utils.Dictionary;
   
   public class FundShoConfig
   {
      
      public static var dataDic:Dictionary = new Dictionary();
      
      public function FundShoConfig()
      {
         super();
      }
      
      public static function init() : void
      {
         var key:String = null;
         var i:int = 0;
         var _arr:Array = null;
         var _vo:Vo_store = null;
         var dic:Dictionary = Data_lib.funShop;
         var dataArr:Array = [];
         for(key in dic)
         {
            _arr = [];
            _vo = new Vo_store();
            _vo.jiJinGoodsId = int(key);
            _vo.sign = dic[key][1];
            _vo.type = 1;
            _vo.paiXu = int(key);
            _vo.wpid = dic[key][2];
            _vo.price_type = -1;
            _vo.sold_num = dic[key][3];
            _vo.boughtLimit = dic[key][5];
            _vo.now_price = dic[key][6];
            _vo.boughtLvl = dic[key][7];
            _vo.job = dic[key][8];
            _vo.init_store();
            dataArr.push(_vo);
         }
         i = 1;
         while(i <= 4)
         {
            dataDic[i] = piPei(i,dataArr);
            i++;
         }
         trace(dataDic[1],dataDic[2],dataDic[3],dataDic[4]);
      }
      
      private static function piPei(_key:int, _arr:Array) : Array
      {
         var _vo:Vo_store = null;
         var len:int = int(_arr.length);
         if(!len)
         {
            return [];
         }
         var _dataArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            _vo = _arr[i];
            if(_vo.sign == _key)
            {
               _dataArr.push(_vo);
            }
            i++;
         }
         return changedOrderHandle(_dataArr);
      }
      
      public static function changedOrderHandle(_arr:Array) : Array
      {
         var compare:Function = null;
         compare = function(a:Vo_store, b:Vo_store):int
         {
            if(a.paiXu < b.paiXu)
            {
               return -1;
            }
            if(a.paiXu > b.paiXu)
            {
               return 1;
            }
            return 0;
         };
         _arr.sort(compare);
         return _arr;
      }
   }
}

