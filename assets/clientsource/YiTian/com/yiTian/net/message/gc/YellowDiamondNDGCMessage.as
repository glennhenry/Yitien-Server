package com.yiTian.net.message.gc
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.YellowDia_ND_Handler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.utils.IDataInput;
   
   public class YellowDiamondNDGCMessage
   {
      
      public function YellowDiamondNDGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_YELLOW_DIAMOND_SHOW_BUTTON] = this.GC_YELLOW_DIAMOND_SHOW_BUTTON;
         index[MessageType.GC_YELLOW_DIAMOND_START] = this.GC_YELLOW_DIAMOND_START;
         index[MessageType.GC_YELLOW_REQUEST_INITDATA] = this.GC_YELLOW_REQUEST_INITDATA;
         index[MessageType.GC_YELLOW_CHAT] = this.GC_YELLOW_CHAT;
      }
      
      private function GC_YELLOW_DIAMOND_SHOW_BUTTON(patch:IDataInput) : void
      {
         var show:int = patch.readByte();
         YellowDia_ND_Handler.GC_YELLOW_DIAMOND_SHOW_BUTTON(show);
      }
      
      private function GC_YELLOW_DIAMOND_START(patch:IDataInput) : void
      {
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         var job:int = patch.readByte();
         var paiXuHao:int = patch.readByte();
         var goodsID:int = patch.readInt();
         var count:int = patch.readShort();
         YellowDia_ND_Handler.GC_YELLOW_DIAMOND_START(name,job,paiXuHao,goodsID,count);
      }
      
      private function GC_YELLOW_REQUEST_INITDATA(patch:IDataInput) : void
      {
         var name:String = null;
         var job:int = 0;
         var ID:int = 0;
         var goodsCount:int = 0;
         var tempArr:Array = null;
         var shengYu:int = patch.readByte();
         var isOver:String = patch.readUTF();
         var startTime:String = patch.readUTF();
         var endTime:String = patch.readUTF();
         var len:int = patch.readShort();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            name = Model_heFu.repNameByHero(patch.readUTF());
            job = patch.readByte();
            ID = patch.readInt();
            goodsCount = patch.readShort();
            tempArr = [];
            tempArr.push(name,job,ID,goodsCount);
            arr.push(tempArr);
            i++;
         }
         YellowDia_ND_Handler.GC_YELLOW_REQUEST_INITDATA(arr,shengYu,isOver,startTime,endTime);
      }
      
      private function GC_YELLOW_CHAT(patch:IDataInput) : void
      {
         var job:int = patch.readByte();
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         var id:int = patch.readInt();
         var goodsCount:int = patch.readShort();
         var str:String = "<font color=\'#" + Enum_job.JOBCOLOR[job] + "\'>" + name + "</font>获得 " + Enum_BroadCastTool.instance.getColorStr(Data_lib.item[id][Enum_lib_item.STR_NAME],Data_lib.item[id][Enum_lib_item.COLOR]) + " " + goodsCount.toString() + "件";
         UIManager.triggleBroadcast.addMsg(str);
      }
   }
}

