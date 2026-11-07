package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.HuangZuanXianGouHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class HZXianGouGCMessage
   {
      
      public function HZXianGouGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_HZXG_SHOW_ICON] = this.GC_HZXG_SHOW_ICON;
         index[MessageType.GC_HZXG_SHOW_PANEL] = this.GC_HZXG_SHOW_PANEL;
         index[MessageType.GC_HZXG_GETAWARD] = this.GC_HZXG_GETAWARD;
      }
      
      public function GC_HZXG_SHOW_ICON(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         var isLight:int = patch.readByte();
         HuangZuanXianGouHandle.IconSwitch(flag,isLight);
      }
      
      public function GC_HZXG_SHOW_PANEL(patch:IDataInput) : void
      {
         var dataArr:Array = [];
         var isSuperHZ:int = patch.readByte();
         var leftNum:int = patch.readShort();
         dataArr.push(leftNum);
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            dataArr.push(patch.readByte());
            i++;
         }
         HuangZuanXianGouHandle.showPanel(isSuperHZ,dataArr);
      }
      
      public function GC_HZXG_GETAWARD(patch:IDataInput) : void
      {
         var arr:Array = [];
         var i:int = 0;
         while(i < 3)
         {
            arr.push(patch.readByte());
            i++;
         }
         HuangZuanXianGouHandle.getAward(arr);
      }
   }
}

