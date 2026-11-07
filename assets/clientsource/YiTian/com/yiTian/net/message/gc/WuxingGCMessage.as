package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import com.yiTian.view.modules.wuXing.WuxingPan;
   import flash.utils.IDataInput;
   
   public class WuxingGCMessage
   {
      
      private var succeFailDescrip:Array = ["修炼失败","修炼成功","等级不够"];
      
      public function WuxingGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_OPEN_WUXINGPAN] = this.GC_OPEN_WUXINGPAN;
         index[MessageType.GC_XIUXING_WUXING] = this.GC_XIUXING_WUXING;
      }
      
      public function GC_OPEN_WUXINGPAN(patch:IDataInput) : void
      {
         var dataArr:Array = null;
         var totalZhanLi:int = 0;
         var sId:int = 0;
         var sWorth:int = 0;
         var leiJiWorth:int = 0;
         var len:int = patch.readByte();
         dataArr = [];
         var i:int = 0;
         while(i < len)
         {
            sId = patch.readInt();
            sWorth = patch.readInt();
            leiJiWorth = patch.readInt();
            dataArr.push([sId,sWorth,leiJiWorth]);
            i++;
         }
         totalZhanLi = patch.readInt();
         WuXingMter.getPan(WuxingPan,function(pan:WuxingPan):void
         {
            pan.update(dataArr,totalZhanLi);
         });
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            pan.updateWuXingTip(dataArr);
         });
      }
      
      public function GC_XIUXING_WUXING(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var str:String = HtmlUtil.font(HtmlUtil.bold(this.succeFailDescrip[result]),"#f9ff00",14);
         UIManager.centerBroadcast.addMsg(str);
         if(result == 1)
         {
            WuXingMter.getPan(WuxingPan,function(pan:WuxingPan):void
            {
               pan.updateSucce();
            });
         }
      }
   }
}

