package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.net.handler.ZhuTiZhouHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ZhuTiZhouGCMessage
   {
      
      public function ZhuTiZhouGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ZTZ_SHOWICON] = this.GC_ZTZ_SHOWICON;
         index[MessageType.GC_ZTZ_CHONGZHI] = this.GC_ZTZ_CHONGZHI;
         index[MessageType.GC_ZTZ_GETAWARD] = this.GC_ZTZ_GETAWARD;
         index[MessageType.GC_XSLB_GETAWARD] = this.GC_XSLB_GETAWARD;
         index[MessageType.GC_XSLB_SHOWICON] = this.GC_XSLB_SHOWICON;
         index[MessageType.GC_ZTZ_GONGGAO] = this.GC_ZTZ_GONGGAO;
      }
      
      public function GC_ZTZ_SHOWICON(patch:IDataInput) : void
      {
         var id:int = 0;
         var flagIcon:int = 0;
         var time:int = 0;
         var isGetted:int = 0;
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            id = patch.readByte();
            flagIcon = patch.readByte();
            if(flagIcon == 1)
            {
               time = patch.readInt();
               isGetted = patch.readByte();
               arr.push([id,flagIcon,time,isGetted]);
            }
            i++;
         }
         ZhuTiZhouHandler.showIcon(arr);
      }
      
      public function GC_ZTZ_CHONGZHI(patch:IDataInput) : void
      {
         var id:int = patch.readByte();
         var changeIcon:int = patch.readByte();
         var isSecuess:int = patch.readByte();
         var roleName:String = Model_heFu.repNameByHero(patch.readUTF());
         ZhuTiZhouHandler.chongZhi(id,changeIcon,isSecuess,roleName);
      }
      
      public function GC_ZTZ_GETAWARD(patch:IDataInput) : void
      {
         var id:int = 0;
         var leftTime:int = 0;
         var arr:Array = [];
         var result:int = patch.readByte();
         arr.push(result);
         if(result == 1)
         {
            id = patch.readByte();
            leftTime = patch.readInt();
            arr.push(id,leftTime);
         }
         ZhuTiZhouHandler.getAward(arr);
      }
      
      public function GC_XSLB_GETAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ZhuTiZhouHandler.libaoGetAward(result);
      }
      
      public function GC_XSLB_SHOWICON(patch:IDataInput) : void
      {
         var id:int = 0;
         var time:int = 0;
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            id = patch.readByte();
            time = patch.readInt();
            if(time != -1)
            {
               arr.push([id,time]);
            }
            i++;
         }
         ZhuTiZhouHandler.libaoShowIcon(arr);
      }
      
      public function GC_ZTZ_GONGGAO(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         ZhuTiZhouHandler.shouGongGao(flag);
      }
   }
}

