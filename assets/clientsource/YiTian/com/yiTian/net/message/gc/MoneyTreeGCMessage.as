package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.MoneyTreeHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class MoneyTreeGCMessage
   {
      
      public function MoneyTreeGCMessage(index:Array)
      {
         super();
         index[MessageType.CG_MONEYTREE_ICON] = this.CG_MONEYTREE_ICON;
         index[MessageType.GC_MONEYTREE_OPENWIN] = this.GC_MONEYTREE_OPENWIN;
         index[MessageType.GC_MONEYTREE_PLANT] = this.GC_MONEYTREE_PLANT;
         index[MessageType.GC_MONEYTREE_GETWARD] = this.GC_MONEYTREE_GETWARD;
         index[MessageType.GC_MONEYTREE_WATER] = this.GC_MONEYTREE_WATER;
         index[MessageType.GC_MONEYTREE_BROCAST] = this.GC_MONEYTREE_BROCAST;
      }
      
      private function CG_MONEYTREE_ICON(patch:IDataInput) : void
      {
         var resulte:int = patch.readByte();
         var flag:int = patch.readByte();
         var time:int = patch.readInt();
         var isShowTime:Boolean = patch.readByte() == 1;
         MoneyTreeHandler.CG_MONEYTREE_ICON(resulte,flag,time,isShowTime);
      }
      
      private function GC_MONEYTREE_OPENWIN(patch:IDataInput) : void
      {
         var currentTree:int = patch.readByte();
         var growPer:Number = patch.readByte();
         var status:Array = patch.readUTF().split("_");
         MoneyTreeHandler.GC_MONEYTREE_OPENWIN(currentTree,growPer,status);
      }
      
      private function GC_MONEYTREE_PLANT(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         var index:int = patch.readByte();
         MoneyTreeHandler.GC_MONEYTREE_PLANT(reslut,index);
      }
      
      private function GC_MONEYTREE_WATER(patch:IDataInput) : void
      {
         var resulte:int = patch.readByte();
         MoneyTreeHandler.GC_MONEYTREE_WATER(resulte);
      }
      
      private function GC_MONEYTREE_GETWARD(patch:IDataInput) : void
      {
         var resulte:int = patch.readByte();
         var index:int = patch.readByte();
         MoneyTreeHandler.GC_MONEYTREE_GETWARD(resulte,index);
      }
      
      private function GC_MONEYTREE_BROCAST(patch:IDataInput) : void
      {
         var roleId:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         var level:int = patch.readByte();
         var money:int = patch.readInt();
         MoneyTreeHandler.GC_MONEYTREE_BROCAST(roleId,roleName,level,money);
      }
   }
}

