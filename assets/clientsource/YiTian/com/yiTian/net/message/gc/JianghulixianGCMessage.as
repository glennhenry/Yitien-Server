package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.JianghulixianHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class JianghulixianGCMessage
   {
      
      public function JianghulixianGCMessage(_index:Array)
      {
         super();
         _index[MessageType.GC_Jianghulixian_UPDATE_MENU] = this.GC_Jianghulixian_UPDATE_MENU;
         _index[MessageType.GC_Jianghulixian_SET_RESULT] = this.GC_Jianghulixian_SET_RESULT;
         _index[MessageType.GC_Jianghulixian_CHANGE_CARD_RESULT] = this.GC_Jianghulixian_CHANGE_CARD_RESULT;
      }
      
      public function GC_Jianghulixian_UPDATE_MENU(_patch:IDataInput) : void
      {
         var num:int = _patch.readByte();
         JianghulixianHandler.GC_Jianghulixian_UPDATE_MENU(num);
      }
      
      public function GC_Jianghulixian_SET_RESULT(_patch:IDataInput) : void
      {
         var num:int = _patch.readByte();
         var type:int = _patch.readByte();
         var cardStr:String = _patch.readUTF();
         var cardType:String = _patch.readUTF();
         JianghulixianHandler.GC_Jianghulixian_SET_RESULT(num,type,cardStr.split(","),cardType.split(","));
      }
      
      public function GC_Jianghulixian_CHANGE_CARD_RESULT(_patch:IDataInput) : void
      {
         var cardStr:String = _patch.readUTF();
         var cardType:String = _patch.readUTF();
         JianghulixianHandler.GC_Jianghulixian_CHANGE_CARD_RESULT(cardStr.split(","),cardType.split(","));
      }
   }
}

