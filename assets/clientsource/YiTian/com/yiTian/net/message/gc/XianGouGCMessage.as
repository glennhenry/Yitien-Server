package com.yiTian.net.message.gc
{
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_XianGou;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.handler.XianGouHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.HtmlUtil;
   import flash.utils.IDataInput;
   
   public class XianGouGCMessage
   {
      
      public function XianGouGCMessage(_index:Array)
      {
         super();
         _index[MessageType.GC_XianGou_TURN_ON] = this.GC_XianGou_TURN_ON;
         _index[MessageType.GC_XianGou_OPEN] = this.GC_XianGou_OPEN;
         _index[MessageType.GC_XianGou_BUY] = this.GC_XianGou_BUY;
      }
      
      private function upgradeTo31() : void
      {
         trace("upgradeTo31 111");
         if(GameUnitManager.hero.level >= 32)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.upgradeTo31);
            trace("upgradeTo31 222");
            XianGouHandler.TurnOnHandler();
         }
      }
      
      private function GC_XianGou_TURN_ON(_patch:IDataInput) : void
      {
         Model_XianGou.Turn_On = _patch.readByte();
         trace("402006>>",Model_XianGou.Turn_On);
         if(GameUnitManager.hero.level < 32)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.upgradeTo31);
            return;
         }
         XianGouHandler.TurnOnHandler();
      }
      
      private function GC_XianGou_OPEN(_patch:IDataInput) : void
      {
         trace("402002>>");
         var len:int = -1;
         var id:int = -1;
         var haveBuy:int = -1;
         var kucun:int = -1;
         var arr:Array = [];
         len = _patch.readInt();
         var i:int = 0;
         while(i < len)
         {
            id = _patch.readInt();
            haveBuy = _patch.readInt();
            kucun = _patch.readInt();
            trace("数组>>" + i + "商品序号>>" + id + "已购>>" + haveBuy + "库存>>" + kucun);
            arr.push([id,haveBuy,kucun]);
            i++;
         }
         Model_XianGou.ItemArr = arr;
         var startTime:int = _patch.readInt();
         var endTime:int = _patch.readInt();
         trace("开始时间：",startTime,DateUtil.getYMDHM(startTime));
         trace("结束时间：",endTime,DateUtil.getYMDHM(endTime));
         Model_XianGou.duringTime = DateUtil.getYMDHM(startTime) + HtmlUtil.font(" 到 ","#f9ff00") + DateUtil.getYMDHM(endTime);
         XianGouHandler.Init();
      }
      
      private function GC_XianGou_BUY(_patch:IDataInput) : void
      {
         var num:int = 0;
         var id:int = 0;
         num = _patch.readByte();
         id = _patch.readInt();
         trace("402004>>",num,id);
         XianGouHandler.returnFlag(num,id);
      }
   }
}

