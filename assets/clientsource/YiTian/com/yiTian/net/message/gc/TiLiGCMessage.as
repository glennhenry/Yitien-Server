package com.yiTian.net.message.gc
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.TiLiHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class TiLiGCMessage
   {
      
      public static var curTili:int;
      
      public function TiLiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_TILI_STORE_STATUS] = this.GC_TILI_STORE_STATUS;
         index[MessageType.GC_TILI_STORE_BOUGHT] = this.GC_TILI_STORE_BOUGHT;
         index[MessageType.GC_SHOW_TILI_ICON] = this.GC_SHOW_TILI_ICON;
         index[MessageType.GC_GET_TILI] = this.GC_GET_TILI;
         index[MessageType.GC_TILI_TISHI] = this.GC_TILI_TISHI;
         index[MessageType.GC_GETLI_BUY] = this.GC_GETLI_BUY;
         index[MessageType.GC_BUYTILI] = this.GC_BUYTILI;
      }
      
      public function GC_TILI_STORE_STATUS(patch:IDataInput) : void
      {
         var result1:int = patch.readByte();
         var result2:int = patch.readByte();
         var result3:int = patch.readByte();
         TiLiHandle.GC_TILI_STORE_STATUS(result1,result2,result3);
      }
      
      public function GC_TILI_STORE_BOUGHT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         TiLiHandle.GC_TILI_STORE_BOUGHT(result);
      }
      
      public function GC_SHOW_TILI_ICON(patch:IDataInput) : void
      {
         TiLiHandle.GC_SHOW_TILI_ICON();
      }
      
      public function GC_GET_TILI(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         TiLiHandle.GC_GET_TILI(result);
      }
      
      public function GC_TILI_TISHI(patch:IDataInput) : void
      {
         TiLiHandle.GC_TILI_TISHI();
      }
      
      public function GC_GETLI_BUY(patch:IDataInput) : void
      {
         var times:int = patch.readByte();
         var yb:int = 0;
         var tl:int = 0;
         var ss:String = "";
         if(times >= 0 && times < 8)
         {
            yb = int(Data_lib.tiliProm[times][1]);
            tl = int(Data_lib.tiliProm[times][0]);
            ss = LangConfig.getWord("1161",0,yb,tl);
         }
         else if(times == -1)
         {
            ss = LangConfig.getWord("1162",0);
         }
         UIManager.heroHead.updateTiliTip(ss,yb,tl,times);
      }
      
      public function GC_BUYTILI(patch:IDataInput) : void
      {
         var num:int = 0;
         var result:int = patch.readByte();
         if(result == 1)
         {
            num = GameUnitManager.hero.vigor - curTili;
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("12",0) + ",您的体力加了" + num,1);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1163",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1164",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1165",0));
         }
      }
   }
}

