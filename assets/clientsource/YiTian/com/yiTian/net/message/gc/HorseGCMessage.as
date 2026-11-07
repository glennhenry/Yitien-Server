package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.HorseHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class HorseGCMessage
   {
      
      public function HorseGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_HORSE_PARTS_INFO] = this.GC_HORSE_PARTS_INFO;
         index[MessageType.GC_HORSE_QIANGHUA_INFO] = this.GC_HORSE_QIANGHUA_INFO;
         index[MessageType.GC_HORSE_LIB] = this.GC_HORSE_LIB;
         index[MessageType.GC_HORSEDUANZAO] = this.GC_HORSEDUANZAO;
         index[MessageType.GC_HORSE_JINJIE] = this.GC_HORSE_JINJIE;
         index[MessageType.GC_HORSE_QIANGHUA] = this.GC_HORSE_QIANGHUA;
         index[MessageType.GC_HORSE_LIB_ENABLE] = this.GC_HORSE_LIB_ENABLE;
         index[MessageType.GC_HORSE_JINJIE_INFO] = this.GC_HORSE_JINJIE_INFO;
         index[MessageType.GC_HORSE_SHOW_AND_HIDE] = this.GC_HORSE_SHOW_AND_HIDE;
         index[MessageType.GC_STARSIGN] = this.GC_STARSIGN;
         index[MessageType.GC_STARSIGN_ATB] = this.GC_STARSIGN_ATB;
         index[MessageType.GC_ENABLE_STARSIGN] = this.GC_ENABLE_STARSIGN;
         index[MessageType.GC_XINGLEI_UPDATE] = this.GC_XINGLEI_UPDATE;
         index[MessageType.GC_STARSIGN_BREAK_REST] = this.GC_STARSIGN_BREAK_REST;
         index[MessageType.GC_LUCK_BREAK_UPDATE] = this.GC_LUCK_BREAK_UPDATE;
      }
      
      public function GC_HORSE_PARTS_INFO(patch:IDataInput) : void
      {
         var lv:int = 0;
         var exp:int = 0;
         var infos:Array = [];
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            lv = patch.readInt();
            exp = patch.readInt();
            infos.push(lv,exp);
            i += 1;
         }
         var atbs:String = patch.readUTF();
         var curAtbs:String = patch.readUTF();
         HorseHandler.GC_HORSE_PARTS_INFO(infos,atbs,curAtbs);
      }
      
      public function GC_HORSE_QIANGHUA_INFO(patch:IDataInput) : void
      {
         var luck:int = patch.readByte();
         var horseStar:int = patch.readByte();
         var hId:int = patch.readInt();
         HorseHandler.GC_HORSE_QIANGHUA_INFO(luck,horseStar,hId);
      }
      
      public function GC_HORSE_LIB(patch:IDataInput) : void
      {
         var horseId:int = 0;
         var horseState:int = 0;
         var len:int = patch.readByte();
         var infos:Array = [];
         var i:int = 0;
         while(i < len)
         {
            horseId = patch.readInt();
            horseState = patch.readByte();
            infos.push(horseId,horseState);
            i += 1;
         }
         var curRide:int = patch.readInt();
         HorseHandler.GC_HORSE_LIB(infos,curRide);
      }
      
      public function GC_HORSEDUANZAO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         HorseHandler.GC_HORSEDUANZAO(result);
      }
      
      public function GC_HORSE_JINJIE(patch:IDataInput) : void
      {
         HorseHandler.GC_HORSE_JINJIE();
      }
      
      public function GC_HORSE_QIANGHUA(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         HorseHandler.GC_HORSE_QIANGHUA(result);
      }
      
      public function GC_HORSE_LIB_ENABLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         HorseHandler.GC_HORSE_LIB_ENABLE(result);
      }
      
      public function GC_HORSE_JINJIE_INFO(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         HorseHandler.GC_HORSE_JINJIE_INFO(id);
      }
      
      public function GC_HORSE_SHOW_AND_HIDE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         HorseHandler.GC_HORSE_SHOW_AND_HIDE(result);
      }
      
      public function GC_STARSIGN(patch:IDataInput) : void
      {
         var signLv:int = patch.readByte();
         var signID:int = patch.readInt();
         HorseHandler.GC_STARSIGN(signLv,signID);
      }
      
      public function GC_ENABLE_STARSIGN(patch:IDataInput) : void
      {
         var rest:int = patch.readByte();
         var preID:int = patch.readInt();
         var aftID:int = patch.readInt();
         HorseHandler.GC_ENABLE_STARSIGN(rest,preID,aftID);
      }
      
      public function GC_XINGLEI_UPDATE(patch:IDataInput) : void
      {
         var value:int = patch.readInt();
         HorseHandler.GC_XINGLEI_UPDATE(value);
      }
      
      public function GC_STARSIGN_BREAK_REST(patch:IDataInput) : void
      {
         var rest:int = patch.readByte();
         HorseHandler.GC_STARSIGN_BREAK_REST(rest);
      }
      
      public function GC_STARSIGN_ATB(patch:IDataInput) : void
      {
         var equipType:int = 0;
         var percent:String = null;
         var numAtbType:int = 0;
         var atbs:Array = null;
         var j:int = 0;
         var atbType:int = 0;
         var atbValue:int = 0;
         var numEquipType:int = patch.readInt();
         var equipAtbs:Array = [];
         var i:int = 0;
         while(i < numEquipType)
         {
            equipType = patch.readByte();
            percent = patch.readUTF();
            numAtbType = patch.readByte();
            atbs = [];
            j = 0;
            while(j < numAtbType)
            {
               atbType = patch.readInt();
               atbValue = patch.readInt();
               atbs.push([atbType,atbValue]);
               j += 1;
            }
            equipAtbs.push([equipType,percent,atbs]);
            i += 1;
         }
         HorseHandler.GC_STARSIGN_ATB(equipAtbs);
      }
      
      public function GC_LUCK_BREAK_UPDATE(patch:IDataInput) : void
      {
         var percent:int = patch.readInt();
         var remainTime:int = patch.readInt();
         HorseHandler.GC_LUCK_BREAK_UPDATE(percent,remainTime);
      }
   }
}

