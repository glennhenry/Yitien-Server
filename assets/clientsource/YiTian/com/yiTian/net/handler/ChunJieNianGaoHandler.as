package com.yiTian.net.handler
{
   import com.utils.ColorConstant;
   import com.yiTian.data.model.Model_ChunJieNianGao;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Alert;
   
   public class ChunJieNianGaoHandler
   {
      
      private static var showTips:Boolean = true;
      
      private static var checkObj:Object = {};
      
      public function ChunJieNianGaoHandler()
      {
         super();
      }
      
      public static function GC_ChunJieNianGao_Result(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("物品已过期");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      public static function GC_ChunJieNianGao_Count(type:int, count:int) : void
      {
         if(type == 3)
         {
            Model_ChunJieNianGao.NianGaoCount = count;
         }
         else if(type == 4)
         {
            Model_ChunJieNianGao.YuanXiaoCount = count;
         }
      }
      
      public static function GC_ChunJieNianGao_EAT(freeTimes:int, chargeTimes:int, gridId:int) : void
      {
         if(showTips && chargeTimes > 0)
         {
            View_Alert.show("是否花费" + HtmlUtil.fontNoSize(String(chargeTimes * 15),ColorConstant.getColorStr(ColorConstant.GREEN)) + "元宝食用元宵" + chargeTimes + "个？<br/>" + HtmlUtil.fontNoSize("（每天免费食用10个）",ColorConstant.getColorStr(ColorConstant.RED)),2,function():void
            {
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,gridId,freeTimes + chargeTimes);
            },function():void
            {
               showTips = true;
            },checkObj,null,310,"","","center",showTips);
            View_Alert.instance.showCheckBox = function():void
            {
               if(View_Alert.instance.data == checkObj)
               {
                  showTips = !showTips;
               }
            };
         }
         else
         {
            BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,gridId,freeTimes + chargeTimes);
         }
      }
   }
}

