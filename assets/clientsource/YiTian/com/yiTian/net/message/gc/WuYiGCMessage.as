package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.wuyi.wuyiVO;
   import flash.utils.IDataInput;
   
   public class WuYiGCMessage
   {
      
      public function WuYiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_WUYI_BTN] = this.GC_WUYI_BTN;
         index[MessageType.GC_WUYI_TIME] = this.GC_WUYI_TIME;
      }
      
      public function GC_WUYI_BTN(patch:IDataInput) : void
      {
         var see:int = patch.readByte();
         UIManager.wyBtn.show(see);
      }
      
      public function GC_WUYI_TIME(patch:IDataInput) : void
      {
         var pnl:Panel123;
         wuyiVO.starTime = patch.readInt();
         wuyiVO.endTime = patch.readInt();
         pnl = UIManager.wuyi;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            UIManager.wuyi.visible = true;
            UIManager.wuyi.open();
         });
      }
   }
}

