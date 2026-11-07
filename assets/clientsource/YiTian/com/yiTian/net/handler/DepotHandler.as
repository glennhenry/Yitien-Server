package com.yiTian.net.handler
{
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.ModelManager;
   import com.yiTian.utils.Utils;
   
   public class DepotHandler
   {
      
      public function DepotHandler()
      {
         super();
      }
      
      public static function GC_DEPOT_TIDY(result:int, equips:Array, items:Array) : void
      {
         if(result == 1)
         {
            ModelManager.depot.init(equips,items);
            CommandManager.update_depot();
            Utils.print("仓库数据初始化");
         }
         else if(result == 2)
         {
            ModelManager.depot.update(equips,items);
            CommandManager.update_depot();
            Utils.print("仓库数据更新");
         }
         else if(result == 3)
         {
            ModelManager.depot.tidy(equips,items);
            CommandManager.update_depot();
            Utils.print("仓库整理完成");
         }
         else
         {
            if(result != 4)
            {
               throw new Error("仓库数据获取失败");
            }
            Utils.print("仓库整理冷却中");
         }
      }
      
      public static function GC_DEPOT_EMPTY(result:int, arr_gridId:Array) : void
      {
         if(result == 1)
         {
            ModelManager.depot.empty_some(arr_gridId);
            CommandManager.update_depot();
            Utils.print("清空仓库格子  ",arr_gridId);
         }
         else
         {
            Utils.print("清空仓库格子失败" + arr_gridId);
         }
      }
      
      public static function GC_DEPOT_EXTENSION(result:int, canUse:int) : void
      {
         if(result == 1)
         {
            ModelManager.depot.canUse = canUse;
            Utils.print("仓库可用数  ",canUse);
         }
         else
         {
            Utils.print("仓库扩充失败");
         }
      }
   }
}

