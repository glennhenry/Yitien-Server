package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.TuanGouHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class TuanGouGCMessage
   {
      
      public function TuanGouGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_TUANGOU_OPEN_OR_COLOSE] = this.GC_TUANGOU_OPEN_OR_COLOSE;
         index[MessageType.GC_TUANGOU_DIAL] = this.GC_TUANGOU_DIAL;
         index[MessageType.GC_TUANGOU_ALL] = this.GC_TUANGOU_ALL;
         index[MessageType.GC_TUANGOU_ITEM] = this.GC_TUANGOU_ITEM;
         index[MessageType.GC_TUANGOU_TAKE_GOODS] = this.GC_TUANGOU_TAKE_GOODS;
         index[MessageType.GC_TUANGOU_REQUEST_START] = this.GC_TUANGOU_REQUEST_START;
         index[MessageType.GC_TUANGOU_WHEEL_DATA] = this.GC_TUANGOU_WHEEL_DATA;
         index[MessageType.GC_TUANGOU_MAOPAO] = this.GC_TUANGOU_MAOPAO;
      }
      
      private function GC_TUANGOU_OPEN_OR_COLOSE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         TuanGouHandler.GC_TUANGOU_OPEN_OR_COLOSE(result);
      }
      
      private function GC_TUANGOU_DIAL(patch:IDataInput) : void
      {
         var result1:int = patch.readByte();
         var result2:int = patch.readByte();
         var result3:int = patch.readInt();
         var result4:int = patch.readInt();
         var result5:int = patch.readInt();
         TuanGouHandler.GC_TUANGOU_DIAL(result1,result2,result3,result4,result5);
      }
      
      private function test(patch:IDataInput) : void
      {
         var xiaBiao:int = 0;
         var tag:int = 0;
         var len:int = patch.readByte();
         var dialArr:Vector.<int> = new Vector.<int>();
         var i:int = 0;
         while(i < len)
         {
            xiaBiao = patch.readInt();
            tag = patch.readInt();
            dialArr.push(xiaBiao,tag);
            i++;
         }
      }
      
      private function GC_TUANGOU_ALL(patch:IDataInput) : void
      {
         var name:String = null;
         var n:int = 0;
         var goodID:int = 0;
         var goodCount:int = 0;
         var temp:Array = null;
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            name = patch.readUTF();
            n = patch.readByte();
            goodID = patch.readInt();
            goodCount = patch.readInt();
            temp = [];
            temp.push(name,n,goodID,goodCount);
            arr.push(temp);
            i++;
         }
         TuanGouHandler.GC_TUANGOU_ALL(arr);
      }
      
      private function GC_TUANGOU_ITEM(patch:IDataInput) : void
      {
         var id:int = 0;
         var yiShou:int = 0;
         var tempArr:Array = null;
         var j:int = 0;
         var id2:int = 0;
         var takeCount:int = 0;
         var tempArr2:Array = null;
         var arr:Array = [];
         var arr2:Array = [];
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            id = patch.readInt();
            yiShou = patch.readInt();
            tempArr = [];
            tempArr.push(id,yiShou);
            arr.push(tempArr);
            i++;
         }
         var len2:int = patch.readByte();
         if(len2 != 0)
         {
            j = 0;
            while(j < len2)
            {
               id2 = patch.readInt();
               takeCount = patch.readInt();
               tempArr2 = [];
               tempArr2.push(id2,takeCount);
               arr2.push(tempArr2);
               j++;
            }
         }
         TuanGouHandler.GC_TUANGOU_ITEM(arr,arr2);
      }
      
      private function GC_TUANGOU_TAKE_GOODS(patch:IDataInput) : void
      {
         var itemId:int = 0;
         var suffer:int = 0;
         var succeed:int = patch.readByte();
         if(succeed == 1)
         {
            itemId = patch.readInt();
            suffer = patch.readInt();
            TuanGouHandler.GC_TUANGOU_TAKE_GOODS(itemId,suffer);
         }
         else
         {
            TuanGouHandler.GC_TUANGOU_TAKE_GOODS_ERROR(succeed);
         }
      }
      
      private function GC_TUANGOU_REQUEST_START(patch:IDataInput) : void
      {
         var xiaBiao:int = 0;
         var succeed:int = patch.readByte();
         if(succeed == 1)
         {
            xiaBiao = patch.readByte();
            TuanGouHandler.GC_TUANGOU_REQUEST_START(xiaBiao);
         }
         else
         {
            TuanGouHandler.GC_TUAN_REQUEST_START_ERROR(succeed);
         }
      }
      
      private function GC_TUANGOU_WHEEL_DATA(patch:IDataInput) : void
      {
         var xiaBiao:int = 0;
         var biaoJi:int = 0;
         var tempArr:Array = null;
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            xiaBiao = patch.readByte();
            biaoJi = patch.readByte();
            tempArr = [];
            tempArr.push(xiaBiao,biaoJi);
            arr.push(tempArr);
            i++;
         }
         TuanGouHandler.GC_TUANGOU_WHEEL_DATA(arr);
      }
      
      private function GC_TUANGOU_MAOPAO(patch:IDataInput) : void
      {
         var goodsID:int = patch.readInt();
         var count:int = patch.readInt();
         var type:int = patch.readByte();
         TuanGouHandler.GC_TUANGOU_MAOPAO(goodsID,count,type);
      }
   }
}

