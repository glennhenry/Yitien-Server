package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   
   public class ZaHuoDianHandle
   {
      
      public function ZaHuoDianHandle()
      {
         super();
      }
      
      public static function GC_ZAHUODIAN_QUERY(goods:Array, goods_len:int) : void
      {
         var tem_goods_arr:Array = null;
         var tem_item:Vo_item = null;
         var i:int = 0;
         var tem_equip:Vo_equip = null;
         var j:int = 0;
         var temp_goods_arr:Array = null;
         var temp_item:Vo_item = null;
         if(Model_shop.longShopType == false)
         {
            tem_goods_arr = changedOrderHandle(goods,0);
            if(tem_goods_arr[0][2] == 1)
            {
               if(!Model_shop.ZHD_data_arr[Model_shop.get_shop_id])
               {
                  Model_shop.ZHD_data_arr[Model_shop.get_shop_id] = [];
               }
               if(!Model_shop.YP_data_arr[Model_shop.get_shop_id])
               {
                  Model_shop.YP_data_arr[Model_shop.get_shop_id] = [];
               }
               Model_shop.YP_data_arr[Model_shop.get_shop_id] = [];
               Model_shop.ZHD_data_arr[Model_shop.get_shop_id] = [];
               i = 0;
               while(i <= tem_goods_arr.length - 1)
               {
                  tem_item = new Vo_item();
                  tem_item.Init_sever_ZHD(tem_goods_arr[i]);
                  tem_item.shopPrice = tem_goods_arr[i][3];
                  if(Model_shop.title_str == "ZAHUODIAN")
                  {
                     Model_shop.ZHD_data_arr[Model_shop.get_shop_id].push(tem_item);
                  }
                  else if(Model_shop.title_str == "YPDIAN")
                  {
                     Model_shop.YP_data_arr[Model_shop.get_shop_id].push(tem_item);
                  }
                  i++;
               }
               UIManager.zaHuoDian.visible = true;
               UIManager.zaHuoDian._totalPage = int(goods_len / 10) + int(goods_len % 10 != 0);
               UIManager.zaHuoDian.update(1,1);
            }
            else if(tem_goods_arr[0][2] == 2)
            {
               if(!Model_shop.ZB_data_arr[Model_shop.get_shop_id])
               {
                  Model_shop.ZB_data_arr[Model_shop.get_shop_id] = [];
               }
               j = 0;
               while(j <= tem_goods_arr.length - 1)
               {
                  tem_equip = new Vo_equip();
                  tem_equip.Init_sever_ZB(tem_goods_arr[j]);
                  tem_equip.gridId = tem_goods_arr[j][0];
                  tem_equip.price = Model_shop.getPriceByID(tem_equip.id);
                  tem_equip.shopPrice = tem_goods_arr[j][3];
                  Model_shop.ZB_data_arr[Model_shop.get_shop_id].push(tem_equip);
                  j++;
               }
               UIManager.zaHuoDian.visible = true;
               UIManager.zaHuoDian._totalPage = int(goods_len / 10) + int(goods_len % 10 != 0);
               UIManager.zaHuoDian.update(1,2);
            }
         }
         else
         {
            temp_goods_arr = changedOrderHandle(goods,0);
            if(!Model_shop.ZHD_data_arr[Model_shop.get_shop_id])
            {
               Model_shop.ZHD_data_arr[Model_shop.get_shop_id] = [];
            }
            if(!Model_shop.YP_data_arr[Model_shop.get_shop_id])
            {
               Model_shop.YP_data_arr[Model_shop.get_shop_id] = [];
            }
            Model_shop.YP_data_arr[Model_shop.get_shop_id] = [];
            Model_shop.ZHD_data_arr[Model_shop.get_shop_id] = [];
            i = 0;
            while(i <= goods_len - 1)
            {
               temp_item = new Vo_item();
               temp_item.Init_sever_ZHD(temp_goods_arr[i]);
               temp_item.shopPrice = temp_goods_arr[i][3];
               if(Model_shop.title_str == "ZAHUODIAN")
               {
                  Model_shop.ZHD_data_arr[Model_shop.get_shop_id].push(temp_item);
               }
               else if(Model_shop.title_str == "YPDIAN")
               {
                  Model_shop.YP_data_arr[Model_shop.get_shop_id].push(temp_item);
               }
               i++;
            }
            UIManager.long_way_shop._totalPage = int(goods_len / 10) + int(goods_len % 10 != 0);
            UIManager.long_way_shop.update(1,1);
         }
      }
      
      public static function changedOrderHandle(_arr:Array, _id:int) : Array
      {
         var temp:Array = null;
         var j:int = 0;
         var i:int = 0;
         while(i < _arr.length - 1)
         {
            j = 0;
            while(j < _arr.length - 1)
            {
               if(_arr[j][_id] > _arr[j + 1][_id])
               {
                  temp = _arr[j];
                  _arr[j] = _arr[j + 1];
                  _arr[j + 1] = temp;
               }
               j++;
            }
            i++;
         }
         return _arr;
      }
      
      public static function changedOrderHd(_arr:Array, _id:int) : Array
      {
         var temp:Array = null;
         var j:int = 0;
         var i:int = 0;
         while(i < _arr.length - 1)
         {
            j = 0;
            while(j < _arr.length - 1)
            {
               if(_arr[j][_id] < _arr[j + 1][_id])
               {
                  temp = _arr[j];
                  _arr[j] = _arr[j + 1];
                  _arr[j + 1] = temp;
               }
               j++;
            }
            i++;
         }
         return _arr;
      }
      
      public static function GC_ZAHUODIAN_BUY(rs:int) : void
      {
         if(Boolean(rs))
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#00cc33\'>" + LangConfig.getWord("12",0) + "</font></a>");
         }
      }
      
      public static function GC_ZAHUODIAN_SELL(rs:int) : void
      {
         if(Boolean(rs))
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#00cc33\'>" + LangConfig.getWord("108",0) + "</font></a>");
         }
      }
   }
}

