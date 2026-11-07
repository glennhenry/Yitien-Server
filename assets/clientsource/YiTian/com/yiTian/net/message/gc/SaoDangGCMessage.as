package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.SaoDangHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.fubenSel.newAdd.ComposeItem;
   import flash.utils.IDataInput;
   
   public class SaoDangGCMessage
   {
      
      public function SaoDangGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_CONFIRM_CLEAN] = this.GC_CONFIRM_CLEAN;
         index[MessageType.GC_CURRENT_CLEAN_TIMES] = this.GC_CURRENT_CLEAN_TIMES;
         index[MessageType.GC_SAODANG_BAG_FULL_TISHI] = this.GC_SAODANG_BAG_FULL_TISHI;
         index[MessageType.GC_SAODAN_STOP] = this.GC_SAODAN_STOP;
         index[MessageType.GC_SAODANG_COMPOSEGOODS] = this.GC_SAODANG_COMPOSEGOODS;
         index[MessageType.GC_SAODANG_TILI_TIPS] = this.GC_SAODANG_TILI_TIPS;
      }
      
      private function GC_SAODANG_TILI_TIPS(patch:IDataInput) : void
      {
         var value:int = patch.readInt();
         UIManager.centerBroadcast.addMsg("自动使用体力药剂，体力增加" + value.toString());
      }
      
      private function GC_SAODAN_STOP(patch:IDataInput) : void
      {
         UIManager.saoDangFuben.stopSaoDang();
      }
      
      private function GC_SAODANG_COMPOSEGOODS(patch:IDataInput) : void
      {
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            type = patch.readByte();
            id = patch.readInt();
            count = patch.readInt();
            arr.push([type,id,count]);
            i++;
         }
         ComposeItem.instance.update(arr);
      }
      
      public function GC_CONFIRM_CLEAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         SaoDangHandle.GC_CONFIRM_CLEAN(result);
      }
      
      public function GC_CURRENT_CLEAN_TIMES(patch:IDataInput) : void
      {
         var type:int = 0;
         var wpid:int = 0;
         var wpNum:int = 0;
         var currenNum:int = patch.readByte();
         var lefeNum:int = patch.readByte();
         var exp:int = patch.readInt();
         var meridian:int = patch.readByte();
         var bindSilver:int = patch.readInt();
         var len:int = patch.readByte();
         var temArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            type = patch.readByte();
            wpid = patch.readInt();
            wpNum = patch.readByte();
            temArr.push([type,wpid,wpNum]);
            i++;
         }
         SaoDangHandle.GC_CURRENT_CLEAN_TIMES(currenNum,lefeNum,exp,meridian,bindSilver,temArr);
      }
      
      public function GC_SAODANG_BAG_FULL_TISHI(patch:IDataInput) : void
      {
         SaoDangHandle.GC_SAODANG_BAG_FULL_TISHI();
      }
   }
}

