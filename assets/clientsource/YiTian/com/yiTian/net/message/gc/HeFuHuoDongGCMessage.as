package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_HeFuHuoDong;
   import com.yiTian.net.handler.HeFuHuoDongHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class HeFuHuoDongGCMessage
   {
      
      public function HeFuHuoDongGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_HeFuHuoDong_ICON] = this.GC_HeFuHuoDong_ICON;
         index[MessageType.GC_HeFuHuoDong_HeFu_OPEN] = this.GC_HeFuHuoDong_HeFu_OPEN;
         index[MessageType.GC_HeFuHuoDong_HeFu_GET] = this.GC_HeFuHuoDong_HeFu_GET;
         index[MessageType.GC_HeFuHuoDong_HuiGui_OPEN] = this.GC_HeFuHuoDong_HuiGui_OPEN;
         index[MessageType.GC_HeFuHuoDong_HuiGui_GET] = this.GC_HeFuHuoDong_HuiGui_GET;
         index[MessageType.GC_HeFuHuoDong_ChongZhi_OPEN] = this.GC_HeFuHuoDong_ChongZhi_OPEN;
         index[MessageType.GC_HeFuHuoDong_ChongZhi_GET] = this.GC_HeFuHuoDong_ChongZhi_GET;
         index[MessageType.GC_HeFuHuoDong_ZaiXian_OPEN] = this.GC_HeFuHuoDong_ZaiXian_OPEN;
         index[MessageType.GC_HeFuHuoDong_ZaiXian_YaoJiang] = this.GC_HeFuHuoDong_ZaiXian_YaoJiang;
         index[MessageType.GC_HeFuHuoDong_ZaiXian_GET1] = this.GC_HeFuHuoDong_ZaiXian_GET1;
         index[MessageType.GC_HeFuHuoDong_ZaiXian_GET2] = this.GC_HeFuHuoDong_ZaiXian_GET2;
      }
      
      private function GC_HeFuHuoDong_ICON(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         trace("128001>>>>",flag);
         if(flag == 1)
         {
            Model_HeFuHuoDong.startTime = patch.readInt();
            Model_HeFuHuoDong.endTime = patch.readInt();
         }
         HeFuHuoDongHandle.TurnOn(flag);
      }
      
      private function GC_HeFuHuoDong_HeFu_OPEN(patch:IDataInput) : void
      {
         var i:* = undefined;
         var str:String = patch.readUTF();
         trace("128011>>>>",str);
         var arr:Array = str.split("_");
         for each(i in arr)
         {
            i = Number(i);
         }
         HeFuHuoDongHandle.HeFu(arr);
         trace("128011>>>>",arr);
      }
      
      private function GC_HeFuHuoDong_HeFu_GET(patch:IDataInput) : void
      {
         var id:int = patch.readByte();
         var status:int = patch.readByte();
         trace("128013>>",id,status);
         HeFuHuoDongHandle.UpdateGet(0,id,status);
      }
      
      private function GC_HeFuHuoDong_HuiGui_OPEN(patch:IDataInput) : void
      {
         var i:* = undefined;
         var str:String = patch.readUTF();
         trace("128021>>>>",str);
         var arr:Array = str.split("_");
         for each(i in arr)
         {
            i = Number(i);
         }
         HeFuHuoDongHandle.HuiGui(arr);
         trace("128021>>>>",arr);
      }
      
      private function GC_HeFuHuoDong_HuiGui_GET(patch:IDataInput) : void
      {
         var id:int = patch.readByte();
         var status:int = patch.readByte();
         trace("128023>>",id,status);
         HeFuHuoDongHandle.UpdateGet(1,id,status);
      }
      
      private function GC_HeFuHuoDong_ChongZhi_OPEN(patch:IDataInput) : void
      {
         var i:* = undefined;
         var str:String = patch.readUTF();
         var count:int = patch.readInt();
         trace("128031>>>>",count,str);
         var arr:Array = str.split("_");
         for each(i in arr)
         {
            i = Number(i);
         }
         HeFuHuoDongHandle.ChongZhi(count,arr);
         trace("128031>>>>",arr);
      }
      
      private function GC_HeFuHuoDong_ChongZhi_GET(patch:IDataInput) : void
      {
         var id:int = patch.readByte();
         var status:int = patch.readByte();
         trace("128033>>",id,status);
         HeFuHuoDongHandle.UpdateGet(2,id,status);
      }
      
      private function GC_HeFuHuoDong_ZaiXian_OPEN(patch:IDataInput) : void
      {
         var arr:Array = null;
         var str:String = null;
         var i:int = 0;
         var haveOnlineTime:int = patch.readInt();
         var keepOnlineTime:int = patch.readInt();
         var canGetLiQuan:int = patch.readInt();
         var haveGetLiQuan:int = patch.readInt();
         var ChouJiangStatus:int = patch.readByte();
         var ChouJiangTimes:int = patch.readInt();
         var nowDay:int = patch.readInt();
         var flag:int = patch.readByte();
         if(Boolean(flag))
         {
            str = patch.readUTF();
            arr = str.split("_");
            i = 0;
            while(Boolean(arr[i]))
            {
               arr[i] = Number(arr[i]);
               i++;
            }
         }
         trace("128041>>",haveOnlineTime,keepOnlineTime,canGetLiQuan,haveGetLiQuan,ChouJiangStatus,ChouJiangTimes + "抽奖次",nowDay,flag,arr);
         HeFuHuoDongHandle.ZaiXian(haveOnlineTime,keepOnlineTime,canGetLiQuan,haveGetLiQuan,ChouJiangStatus,ChouJiangTimes,nowDay,flag,arr);
      }
      
      private function GC_HeFuHuoDong_ZaiXian_YaoJiang(patch:IDataInput) : void
      {
         var times:int = patch.readInt();
         var itemStr:String = patch.readUTF();
         trace(">>摇奖返回",times,itemStr);
         HeFuHuoDongHandle.YaoJiang(times,itemStr);
      }
      
      private function GC_HeFuHuoDong_ZaiXian_GET1(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         HeFuHuoDongHandle.UpdateGet(5,1,flag);
      }
      
      private function GC_HeFuHuoDong_ZaiXian_GET2(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         var totalLiQuan:int = patch.readInt();
         Model_HeFuHuoDong.arr5[3] = totalLiQuan;
         HeFuHuoDongHandle.UpdateGet(5,2,flag);
      }
   }
}

