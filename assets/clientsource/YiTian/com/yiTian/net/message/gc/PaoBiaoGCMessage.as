package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.PaoBiaoHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.paobiao.PaoBiaoVO;
   import flash.utils.IDataInput;
   
   public class PaoBiaoGCMessage
   {
      
      public function PaoBiaoGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_PAOBIAO] = this.GC_PAOBIAO;
         index[MessageType.GC_YUNSONG] = this.GC_YUNSONG;
         index[MessageType.GC_JIEBIAO] = this.GC_JIEBIAO;
         index[MessageType.GC_JIEBIAO_RESULT] = this.GC_JIEBIAO_RESULT;
         index[MessageType.GC_YUNSONG_TIMES] = this.GC_YUNSONG_TIMES;
         index[MessageType.GC_PAOBIAO_NOTE] = this.GC_PAOBIAO_NOTE;
         index[MessageType.GC_PAOBIAO_EXP_BS] = this.GC_PAOBIAO_EXP_BS;
         index[MessageType.GC_ZHI_BIAO_SHOW_ICON] = this.GC_ZHI_BIAO_SHOW_ICON;
         index[MessageType.GC_ZHI_BIAO] = this.GC_ZHI_BIAO;
         index[MessageType.GC_JIE_BIAO_BEFORE] = this.GC_JIE_BIAO_BEFORE;
         index[MessageType.GC_DA_TING_SHEN_BIAO] = this.GC_DA_TING_SHEN_BIAO;
      }
      
      public function GC_PAOBIAO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PaoBiaoHandler.GC_PAOBIAO(result);
      }
      
      public function GC_PAOBIAO_EXP_BS(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var bs:int = patch.readInt();
         var exp:int = patch.readInt();
         PaoBiaoHandler.GC_PAOBIAO_EXP_BS(result,bs,exp);
      }
      
      public function GC_YUNSONG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PaoBiaoHandler.GC_YUNSONG(result);
      }
      
      public function GC_JIEBIAO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var otherId:Number = LongUtil.readLong(patch);
         var otherName:String = patch.readUTF();
         PaoBiaoHandler.GC_JIEBIAO(result,otherId,otherName);
      }
      
      public function GC_JIEBIAO_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var bId:int = patch.readInt();
         var isJie:int = patch.readByte();
         var otherNamer:String = patch.readUTF();
         var bs:int = patch.readInt();
         var exp:int = patch.readInt();
         PaoBiaoHandler.GC_JIEBIAO_RESULT(result,bId,otherNamer,isJie,bs,exp);
      }
      
      public function GC_YUNSONG_TIMES(patch:IDataInput) : void
      {
         var times:int = patch.readByte();
         PaoBiaoHandler.GC_YUNSONG_TIMES(times);
      }
      
      public function GC_PAOBIAO_NOTE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PaoBiaoHandler.GC_PAOBIAO_NOTE(result);
      }
      
      public function GC_ZHI_BIAO_SHOW_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var showEff:int = patch.readByte();
         PaoBiaoHandler.GC_ZHI_BIAO_SHOW_ICON(result,showEff);
      }
      
      public function GC_ZHI_BIAO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var state:int = patch.readByte();
         PaoBiaoVO.isCaiBiao = result;
         PaoBiaoHandler.GC_ZHI_BIAO(result,state);
      }
      
      public function GC_JIE_BIAO_BEFORE(patch:IDataInput) : void
      {
         var bindSilver:int = patch.readInt();
         var exp:int = patch.readInt();
         PaoBiaoHandler.GC_JIE_BIAO_BEFORE(bindSilver,exp);
      }
      
      public function GC_DA_TING_SHEN_BIAO(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         var startTime:String = patch.readUTF();
         var endTime:String = patch.readUTF();
         var add:int = patch.readByte();
         PaoBiaoHandler.GC_DA_TING_SHEN_BIAO(reslut,startTime,endTime,add);
      }
   }
}

