package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.WingHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class WingGCMessage
   {
      
      public function WingGCMessage(index:Array)
      {
         super();
         index[MessageType.CG_HAVE_WING] = this.CG_HAVE_WING;
         index[MessageType.GC_WING_OPEN] = this.GC_WING_OPEN;
         index[MessageType.GC_WING_TIPS] = this.GC_WING_TIPS;
         index[MessageType.GC_WING_BLESS_MENU] = this.GC_WING_BLESS_MENU;
         index[MessageType.GC_WING_BUY] = this.GC_WING_BUY;
         index[MessageType.GC_WING_UP_LEVEL] = this.GC_WING_UP_LEVEL;
         index[MessageType.GC_WING_UP_COST] = this.GC_WING_UP_COST;
         index[MessageType.GC_WING_CHANGE_MODEL] = this.GC_WING_CHANGE_MODEL;
         index[MessageType.GC_WING_SHOW_AND_HIDE] = this.GC_WING_SHOW_AND_HIDE;
         index[MessageType.GC_WING_USE_RESULT] = this.GC_WING_USE_RESULT;
         index[MessageType.GC_WING_BUFF_TIME] = this.GC_WING_BUFF_TIME;
      }
      
      public function CG_HAVE_WING(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         WingHandler.CG_HAVE_WING(flag);
      }
      
      public function GC_WING_OPEN(patch:IDataInput) : void
      {
         var wingId:int = 0;
         var bless:int = 0;
         var blessTime:int = 0;
         var flag:int = patch.readByte();
         if(flag == 1)
         {
            wingId = patch.readInt();
            bless = patch.readInt();
            blessTime = patch.readInt();
            WingHandler.GC_WING_OPEN(flag,wingId,bless,blessTime);
         }
         else if(flag == 2)
         {
            WingHandler.GC_WING_OPEN(flag);
         }
      }
      
      public function GC_WING_TIPS(patch:IDataInput) : void
      {
         WingHandler.GC_WING_TIPS();
      }
      
      public function GC_WING_BLESS_MENU(patch:IDataInput) : void
      {
         var wingId:int = patch.readInt();
         var bless:int = patch.readInt();
         var blessTime:int = patch.readInt();
         WingHandler.GC_WING_BLESS_MENU(wingId,bless,blessTime);
      }
      
      public function GC_WING_BUY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WingHandler.GC_WING_BUY(result);
      }
      
      public function GC_WING_UP_LEVEL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WingHandler.GC_WING_UP_LEVEL(result);
      }
      
      public function GC_WING_UP_COST(patch:IDataInput) : void
      {
         var count:int = patch.readInt();
         WingHandler.GC_WING_UP_COST(count);
      }
      
      public function GC_WING_CHANGE_MODEL(patch:IDataInput) : void
      {
         WingHandler.GC_WING_CHANGE_MODEL(patch.readByte());
      }
      
      public function GC_WING_SHOW_AND_HIDE(patch:IDataInput) : void
      {
         WingHandler.GC_WING_SHOW_AND_HIDE(patch.readByte());
      }
      
      public function GC_WING_USE_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var itemId:int = patch.readInt();
         WingHandler.GC_WING_USE_RESULT(result,itemId);
      }
      
      public function GC_WING_BUFF_TIME(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var count:int = patch.readInt();
         var modelId:int = patch.readInt();
         var itemId:int = patch.readInt();
         WingHandler.GC_WING_BUFF_TIME(result,count,modelId,itemId);
      }
   }
}

