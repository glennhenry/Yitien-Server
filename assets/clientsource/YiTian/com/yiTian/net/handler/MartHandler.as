package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_mart;
   import com.yiTian.data.vo.Vo_Mart;
   import com.yiTian.data.vo.Vo_mart_buy;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MartCGMessage;
   import com.yiTian.view.modules.jingmaiHang.Child_HotSearch;
   import com.yiTian.view.modules.jingmaiHang.View_JiMaiHang;
   
   public class MartHandler
   {
      
      public function MartHandler()
      {
         super();
      }
      
      public static function GC_MART_SOLD(eve_num:int, totalPage:int, typeArr:Array, items:Array, equips:Array, dataArr:Array, label:String = "") : void
      {
         var mart:Vo_Mart = null;
         var temArr:Array = [];
         var i:int = 0;
         while(i <= dataArr.length - 1)
         {
            mart = new Vo_Mart();
            mart.Init_Mart(dataArr[i]);
            temArr.push(mart);
            i++;
         }
         if(totalPage < 1)
         {
            if(View_JiMaiHang.isSearchType == 1)
            {
               UIManager.centerBroadcast.addMsg("暂无此类型商品上架！");
            }
            totalPage = 1;
         }
         UIManager.JMH_panel.update_sold_item(eve_num,totalPage,typeArr,items,equips,temArr);
      }
      
      public static function GC_MARTBUY(mart_buy_arr:Array, totalPage:int, eve_num:int) : void
      {
         var vo_buy:Vo_mart_buy = null;
         var temArr:Array = [];
         var i:int = 0;
         while(i < mart_buy_arr.length)
         {
            vo_buy = new Vo_mart_buy();
            vo_buy.Init_Mart(mart_buy_arr[i]);
            temArr.push(vo_buy);
            i++;
         }
         if(totalPage < 1)
         {
            if(View_JiMaiHang.isSearchType == 1)
            {
               UIManager.centerBroadcast.addMsg("暂无此类型商品上架！");
            }
            totalPage = 1;
         }
         UIManager.JMH_panel.update_mart_buy_item(temArr,totalPage,eve_num);
      }
      
      public static function GC_MY_BUY(mart_myBuy_arr:Array, eve_num:int) : void
      {
         var vo_buy:Vo_mart_buy = null;
         var temArr:Array = [];
         var i:int = 0;
         while(i < eve_num)
         {
            vo_buy = new Vo_mart_buy();
            vo_buy.Init_Mart(mart_myBuy_arr[i]);
            temArr.push(vo_buy);
            i++;
         }
         UIManager.JMH_panel.update_my_buy_item(temArr,eve_num);
      }
      
      public static function GC_MYSOLD(result:int) : void
      {
         if(result == -1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("407",0) + "</font></a>");
         }
         else
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("408",0) + "</font></a>");
            UIManager.sold_set.visible = false;
            MartCGMessage.CG_MY_SOLD();
         }
      }
      
      public static function GC_MY_SOLD(eve_num:int, typeArr:Array, items:Array, equips:Array, dataArr:Array) : void
      {
         var mart:Vo_Mart = null;
         var temArr:Array = [];
         var i:int = 0;
         while(i <= dataArr.length - 1)
         {
            mart = new Vo_Mart();
            mart.Init_Mart(dataArr[i]);
            temArr.push(mart);
            i++;
         }
         UIManager.JMH_panel.update_my_sold_item(eve_num,typeArr,items,equips,temArr);
      }
      
      public static function GC_MYBUY(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("409",0) + "</font></a>");
            UIManager.sold_set.visible = false;
            MartCGMessage.CG_MY_BUY();
         }
         else if(result == -1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("410",0) + "</font></a>");
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("402",0));
         }
      }
      
      public static function GC_CANCLE_SOLD(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("411",0) + "</font></a>");
            UIManager.JMH_panel.cancle_update_my_sold();
            MartCGMessage.CG_MY_SOLD();
         }
      }
      
      public static function GC_CANCLE_BUY(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("411",0) + "</font></a>");
            UIManager.JMH_panel.cancle_update_my_sold();
            MartCGMessage.CG_MY_BUY();
         }
      }
      
      public static function GC_SOLD(result:int, martId:int, _num:int, _cur_pg:int) : void
      {
         var seartType:int = 0;
         Model_mart.max = 0;
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("108",0));
            UIManager.selectNum.visible = false;
            if(_num == 0)
            {
               UIManager.JMH_panel._mart_sold_buy.updata_single(martId,_num);
               seartType = UIManager.JMH_panel._mart_sold_buy._type;
               if(Boolean(View_JiMaiHang.isSearched["buy"]))
               {
                  if(View_JiMaiHang.isSearchType == 0)
                  {
                     MartCGMessage.CG_SEARCH(1,UIManager.JMH_panel._mart_sold_buy.Seach_Name_text.text,0,0,0,0,_cur_pg,View_JiMaiHang.searchPrice["buy"]);
                  }
                  else
                  {
                     MartCGMessage.CG_SEARCH(1,Child_HotSearch.Seach_Name_text,0,0,0,0,_cur_pg,View_JiMaiHang.searchPrice["sell"]);
                  }
               }
               else
               {
                  MartCGMessage.CG_MARTBUY(seartType,_cur_pg,View_JiMaiHang.searchPrice["buy"]);
               }
               UIManager.selectNum.visible = false;
            }
            else
            {
               UIManager.JMH_panel._mart_sold_buy.updata_single(martId,_num);
            }
            UIManager.JMH_panel.update_money();
         }
         else if(result == -1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("412",0));
         }
         else if(result == -2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("413",0));
         }
      }
      
      public static function GC_BUY(res:int, martId:int, _num:int, _cur_pg:int) : void
      {
         var seartType:int = 0;
         if(res == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("12",0));
            UIManager.selectNum.visible = false;
            if(_num == 0)
            {
               UIManager.JMH_panel._mart_sold_buy.updata_single(martId,_num);
               seartType = UIManager.JMH_panel._mart_sold_buy._type;
               if(Boolean(View_JiMaiHang.isSearched["sell"]))
               {
                  if(View_JiMaiHang.isSearchType == 0)
                  {
                     MartCGMessage.CG_SEARCH(1,UIManager.JMH_panel._mart_sold_buy.Seach_Name_text.text,0,0,0,0,_cur_pg,View_JiMaiHang.searchPrice["sell"]);
                  }
                  else
                  {
                     MartCGMessage.CG_SEARCH(1,Child_HotSearch.Seach_Name_text,0,0,0,0,_cur_pg,View_JiMaiHang.searchPrice["sell"]);
                  }
               }
               else
               {
                  MartCGMessage.CG_MARTSOLD(seartType,_cur_pg,View_JiMaiHang.searchPrice["sell"]);
               }
            }
            else
            {
               UIManager.JMH_panel._mart_sold_buy.updata_single(martId,_num);
            }
            UIManager.JMH_panel.update_money();
         }
         else if(res == -1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("414",0));
         }
         else if(res == -3)
         {
            UIManager.centerBroadcast.addMsg("此物品已下架或已被购买");
         }
      }
   }
}

