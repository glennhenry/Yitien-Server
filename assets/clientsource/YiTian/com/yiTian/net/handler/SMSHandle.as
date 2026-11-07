package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_sms;
   import com.yiTian.data.vo.Vo_SMS;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SMSCGMessage;
   import com.yiTian.view.modules.shenMiShop.View_shenMiShop;
   
   public class SMSHandle
   {
      
      public function SMSHandle()
      {
         super();
      }
      
      public static function GC_OPEN_SMS_SHOP_BUY(arr1:Array, arr2:Array, fre_tm:int) : void
      {
         var vo_sms_onSells:Vo_SMS = null;
         var data_arr:Array = [];
         var i:int = 0;
         while(i < arr1.length)
         {
            vo_sms_onSells = new Vo_SMS();
            vo_sms_onSells.init_on_sells(arr1[i]);
            data_arr.push(vo_sms_onSells);
            i++;
         }
         data_arr = getOrderHandle(data_arr);
         if(Boolean(data_arr))
         {
            UIManager.sm_shop.update_onSells_and_txt(data_arr,arr2,fre_tm);
         }
      }
      
      private static function getOrderHandle(arr:Array) : Array
      {
         var j:int = 0;
         if(!arr)
         {
            return null;
         }
         var tempArr:Array = [];
         var i:int = 0;
         while(i < arr.length)
         {
            tempArr[arr[i].grid_id - 1] = arr[i];
            i++;
         }
         if(tempArr.length < 6)
         {
            j = 5;
            while(j >= tempArr.length - 1)
            {
               tempArr[j] = null;
               j--;
            }
         }
         return tempArr;
      }
      
      public static function GC_OPEN_SMS_SHOP_TREASURE(arr:Array) : void
      {
         var vo_sms_title:Vo_SMS = null;
         var data_of_title_arr:Array = [];
         var i:int = 0;
         while(i < arr.length)
         {
            vo_sms_title = new Vo_SMS();
            vo_sms_title.init_on_sells(arr[i]);
            data_of_title_arr.push(vo_sms_title);
            i++;
         }
         UIManager.sm_shop.update_title(data_of_title_arr);
      }
      
      public static function GC_SMS_SHOP_BUY(rs:int, wp_id:int) : void
      {
         if(rs == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("12",0));
         }
         if(wp_id >= 46252 && wp_id <= 46255)
         {
            UIManager.questDailyAccView.update();
         }
      }
      
      public static function GC_SMS_MUL_REFRESH(res:int) : void
      {
         View_shenMiShop.isMulSearch = true;
         if(!UIManager.search.visible)
         {
            UIManager.search.visible = true;
         }
         else
         {
            SMSCGMessage.CG_SMS_CHECK_MUL_REFRESH();
         }
      }
      
      public static function GC_SMS_CHECK_MUL_REFRESH(arr:Array) : void
      {
         Model_sms.taoed_goods_arr = arr;
         View_shenMiShop.isMulSearch = false;
         View_shenMiShop.isSearch = true;
         if(!Model_sms.taoed_goods_arr.length)
         {
            return;
         }
         if(UIManager.search.visible)
         {
            UIManager.search.update(Model_sms.taoed_goods_arr);
         }
      }
      
      public static function GC_SMS_MUL_BUY(rs:int, wpId:int, leftNum:int) : void
      {
         if(rs == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("12",0));
            UIManager.search.update_data_arr_handle(wpId,leftNum);
            UIManager.search.update(Model_sms.taoed_goods_arr);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("107",0));
         }
      }
   }
}

