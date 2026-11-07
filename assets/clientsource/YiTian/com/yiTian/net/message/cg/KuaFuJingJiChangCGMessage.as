package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.kuafujingjichang.DRKFlistPanel;
   import flash.utils.ByteArray;
   
   public class KuaFuJingJiChangCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function KuaFuJingJiChangCGMessage()
      {
         super();
      }
      
      public static function CG_KUAFUJJC_CLICK(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_KUAFUJJC_CLICK,byteBuff);
      }
      
      public static function CG_KUAFUOPEN_YES() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_KUAFUOPEN_YES,byteBuff);
      }
      
      public static function CG_KUAFUTEAM_NEW(type:int, name:String, password:String) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(type);
         byteBuff.writeUTF(name);
         byteBuff.writeUTF(password);
         SocketManager.send(MessageType.CG_KUAFUTEAM_NEW,byteBuff);
      }
      
      public static function CG_KUAFUTEAM_JOIN(id:int, password:String) : void
      {
         if(!password)
         {
            password = "";
         }
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeUTF(password);
         SocketManager.send(MessageType.CG_KUAFUTEAM_JOIN,byteBuff);
      }
      
      public static function CG_LEAVE_DRKFTEAM(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_LEAVE_DRKFTEAM,byteBuff);
      }
      
      public static function CG_CLOSE_DRKFLIST() : void
      {
         byteBuff.length = 0;
         if(DRKFlistPanel.instance.visible)
         {
            DRKFlistPanel.instance.visible = false;
         }
         SocketManager.send(MessageType.CG_CLOSE_DRKFLIST,byteBuff);
      }
      
      public static function CG_KUAFUTEAM_CHECK(team:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(team);
         SocketManager.send(MessageType.CG_KUAFUTEAM_CHECK,byteBuff);
      }
      
      public static function CG_KUAFUADD_QUICK() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_KUAFUADD_QUICK,byteBuff);
      }
      
      public static function CG_KUAFUTEAM_INVITED(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_KUAFUTEAM_INVITED,byteBuff);
      }
      
      public static function CG_KUAFUTEAM_YAOQING(id:Number) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,id);
         SocketManager.send(MessageType.CG_KUAFUTEAM_YAOQING,byteBuff);
      }
      
      public static function CG_DUIYUAN_READY(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_DUIYUAN_READY,byteBuff);
      }
      
      public static function CG_DUIZHANG_STAR() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_DUIZHANG_STAR,byteBuff);
      }
      
      public static function CG_BIANHUAN_LAW(id:int, weizhi:String) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeUTF(weizhi);
         SocketManager.send(MessageType.CG_BIANHUAN_LAW,byteBuff);
      }
      
      public static function CG_TEAM_TS(id:Number) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,id);
         SocketManager.send(MessageType.CG_TEAM_TS,byteBuff);
      }
      
      public static function CG_YAOQING_TONGYI(id:int, type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeInt(type);
         SocketManager.send(MessageType.CG_YAOQING_TONGYI,byteBuff);
      }
      
      public static function CG_PALYER_VALUE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_PALYER_VALUE,byteBuff);
      }
      
      public static function CG_SHOP_XIAYI(id:int, num:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeInt(num);
         SocketManager.send(MessageType.CG_SHOP_XIAYI,byteBuff);
      }
      
      public static function CG_TIAOZHAN_FAQI() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_TIAOZHAN_FAQI,byteBuff);
      }
      
      public static function CG_TIAOZHAN_CLICK(id:Number, quhao:int, teamid:int) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,id);
         byteBuff.writeInt(quhao);
         byteBuff.writeInt(teamid);
         SocketManager.send(MessageType.CG_TIAOZHAN_CLICK,byteBuff);
      }
      
      public static function CG_STAR_PAIHANG(type:int = 0) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_STAR_PAIHANG,byteBuff);
      }
      
      public static function CG_SATR_PINGJIA(type:int, teamLvl:int, teamIndex:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeInt(teamLvl);
         byteBuff.writeByte(teamIndex);
         SocketManager.send(MessageType.CG_SATR_PINGJIA,byteBuff);
      }
      
      public static function CG_KUAFU_JUMPBATTLE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_KUAFU_JUMPBATTLE,byteBuff);
      }
   }
}

