package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_sms;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.SMSHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class SMSGCMessage
   {
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      public function SMSGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_OPEN_SMS_SHOP_BUY] = this.GC_OPEN_SMS_SHOP_BUY;
         index[MessageType.GC_OPEN_SMS_SHOP_TREASURE] = this.GC_OPEN_SMS_SHOP_TREASURE;
         index[MessageType.GC_SMS_SHOP_BUY] = this.GC_SMS_SHOP_BUY;
         index[MessageType.GC_SMS_MUL_REFRESH] = this.GC_SMS_MUL_REFRESH;
         index[MessageType.GC_SMS_CHECK_MUL_REFRESH] = this.GC_SMS_CHECK_MUL_REFRESH;
         index[MessageType.GC_SMS_MUL_BUY] = this.GC_SMS_MUL_BUY;
         index[MessageType.GC_SHOW_SMS_GUIDE] = this.GC_SHOW_SMS_GUIDE;
      }
      
      public function GC_SHOW_SMS_GUIDE(patch:IDataInput) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            return;
         }
         Model_sms.showGuide = true;
         UIManager.special_btn.setMoveEff(0,true);
      }
      
      public function GC_OPEN_SMS_SHOP_BUY(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var temTXTarr:Array = null;
         var result:int = patch.readByte();
         if(!result)
         {
            return;
         }
         var refresh_tm:int = patch.readByte();
         var len:int = patch.readByte();
         var item_arr:Array = [];
         i_index = 0;
         while(i_index < len)
         {
            temArr = [];
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readByte());
            temArr.push(patch.readUTF());
            item_arr.push(temArr);
            ++i_index;
         }
         var len_txt:int = patch.readByte();
         var item_txt_arr:Array = [];
         i_index = 0;
         while(i_index < len_txt)
         {
            temTXTarr = [];
            temTXTarr.push(Model_heFu.repNameByHero(patch.readUTF()));
            temTXTarr.push(patch.readInt());
            temTXTarr.push(patch.readByte());
            temTXTarr.push(patch.readShort());
            item_txt_arr.push(temTXTarr);
            ++i_index;
         }
         SMSHandle.GC_OPEN_SMS_SHOP_BUY(item_arr,item_txt_arr,refresh_tm);
      }
      
      public function GC_OPEN_SMS_SHOP_TREASURE(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var result:int = patch.readByte();
         if(!result)
         {
            return;
         }
         var len:int = patch.readByte();
         var item_arr:Array = [];
         i_index = 0;
         while(i_index < len)
         {
            temArr = [];
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readByte());
            temArr.push(patch.readUTF());
            item_arr.push(temArr);
            ++i_index;
         }
         SMSHandle.GC_OPEN_SMS_SHOP_TREASURE(item_arr);
      }
      
      public function GC_SMS_SHOP_BUY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var wp_id:int = patch.readInt();
         SMSHandle.GC_SMS_SHOP_BUY(result,wp_id);
      }
      
      public function GC_SMS_MUL_REFRESH(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         SMSHandle.GC_SMS_MUL_REFRESH(result);
      }
      
      public function GC_SMS_CHECK_MUL_REFRESH(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var result:int = patch.readByte();
         var num:int = patch.readShort();
         var data_arr:Array = [];
         var i:int = 0;
         while(i < num)
         {
            temArr = [];
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readInt());
            temArr.push(patch.readShort());
            data_arr.push(temArr);
            i++;
         }
         SMSHandle.GC_SMS_CHECK_MUL_REFRESH(data_arr);
      }
      
      public function GC_SMS_MUL_BUY(patch:IDataInput) : void
      {
         var rs:int = patch.readByte();
         var wpId:int = patch.readInt();
         var leftNum:int = patch.readShort();
         SMSHandle.GC_SMS_MUL_BUY(rs,wpId,leftNum);
      }
   }
}

