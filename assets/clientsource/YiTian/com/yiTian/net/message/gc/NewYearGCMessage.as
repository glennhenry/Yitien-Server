package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.net.handler.NewYearHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.canggao.CangGaoPanel;
   import com.yiTian.view.modules.newYear.NewYearVO;
   import com.yiTian.view.modules.newYear.View_newYearActPnl;
   import flash.utils.IDataInput;
   
   public class NewYearGCMessage
   {
      
      public function NewYearGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_NIANGAOMAIL_BUY_ITEM] = this.GC_NIANGAOMAIL_BUY_ITEM;
         index[MessageType.GC_OPEN_NIANSHOU] = this.GC_NIANSHOUDATA;
         index[MessageType.GC_GET_NIANSHOU] = this.CG_USENIANSHOUTOKEN;
         index[MessageType.GC_SMS_GET_INDEX] = this.GC_SMS_GET_INDEX;
      }
      
      public function GC_NIANGAOMAIL_BUY_ITEM(patch:IDataInput) : void
      {
         var r:int = patch.readByte();
         NewYearHandle.GC_NIANGAOMAIL_BUY_ITEM(r);
      }
      
      public function GC_NIANSHOUDATA(patch:IDataInput) : void
      {
         var remainTimes:int = patch.readByte();
         var jifen:int = patch.readInt();
         NewYearHandle.GC_NIANSHOUDATA(remainTimes,jifen);
      }
      
      public function CG_USENIANSHOUTOKEN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var remainTimes:int = patch.readByte();
         var jifen:int = patch.readInt();
         var addCouunt:int = patch.readByte();
         NewYearHandle.CG_USENIANSHOUTOKEN(result,remainTimes,jifen,addCouunt);
      }
      
      public function GC_SMS_GET_INDEX(patch:IDataInput) : void
      {
         var targetPnl:View_newYearActPnl = null;
         NewYearVO.SMSIndex = patch.readInt();
         if(Singleton.hasInstance(View_newYearActPnl))
         {
            targetPnl = Singleton.getInstance(View_newYearActPnl);
            if(!targetPnl.isInit)
            {
               return;
            }
            Global.delegate.dosomething(targetPnl,targetPnl.updateMiJingTimes);
         }
         if(CangGaoPanel.isInit)
         {
            CangGaoPanel.instance.updateTip();
         }
      }
   }
}

