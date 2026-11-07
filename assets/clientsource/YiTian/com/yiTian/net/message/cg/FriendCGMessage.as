package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.comp.View_Alert;
   import flash.utils.ByteArray;
   
   public class FriendCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function FriendCGMessage()
      {
         super();
      }
      
      public static function CG_ADD_FRIEND(name:String = "name") : void
      {
         bytebuff.length = 0;
         if(name == null)
         {
            name = "";
         }
         if(name == "")
         {
            name = "name";
         }
         bytebuff.writeUTF(Model_heFu.correctRoleServName(name));
         SocketManager.send(MessageType.CG_ADD_A_FRIEND,bytebuff);
      }
      
      public static function CG_ADD_FIR_B_CHOOSE(id:Number, choose:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeByte(choose);
         SocketManager.send(MessageType.CG_ADD_FRIEND_B_CHOOSE,bytebuff);
      }
      
      public static function CG_DEL_FRIEND(type:int, id:Number) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.CG_DEL_FRIEND,bytebuff);
      }
      
      public static function CG_ADD_CONTACT_BY_TYPE(type:int, name:String) : void
      {
         var ok_fun:Function = null;
         ok_fun = function():void
         {
            bytebuff.length = 0;
            bytebuff.writeByte(type);
            bytebuff.writeUTF(Model_heFu.correctRoleServName(name));
            SocketManager.send(MessageType.CG_ADD_CONTACT_BY_TYPE,bytebuff);
         };
         View_Alert.show("是否确定将<font color=\'#04ff00\'>" + name + "</font>加入黑名单，此操作将会清空亲密值",View_Alert.OK_CANCAL,ok_fun);
      }
      
      public static function CG_SEND_BLESSING(blessType:int, targetId:Number, targetLv:int, date:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(blessType);
         LongUtil.writeLong(bytebuff,targetId);
         bytebuff.writeShort(targetLv);
         bytebuff.writeInt(date);
         SocketManager.send(MessageType.CG_BLESS_SEND,bytebuff);
      }
      
      public static function CG_CHANGE_SIGNED(str:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(str);
         SocketManager.send(MessageType.CG_SIGNED_CHANGE,bytebuff);
      }
      
      public static function CG_JOINFRIENDS() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_JOINFRIENDS,bytebuff);
      }
      
      public static function CG_JOINFRIENDS_ALL(data:Array) : void
      {
         bytebuff.length = 0;
         var len:int = int(data.length);
         bytebuff.writeByte(len);
         var i:uint = 0;
         while(i < len)
         {
            bytebuff.writeUTF(data[i]);
            i++;
         }
         SocketManager.send(MessageType.CG_JOINFRIENDS_ALL,bytebuff);
      }
      
      public static function CG_INVITE_INFO() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_INVITE_INFO,bytebuff);
      }
      
      public static function CG_GET_INVITE_REWARD(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_GET_INVITE_REWARD,bytebuff);
      }
      
      public static function CG_FRIEND_CHONGZHI() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FRIEND_CHONGZHI,bytebuff);
      }
      
      public static function CG_INVITE_FRIENDS() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_INVITE_FRIENDS,bytebuff);
      }
      
      public static function CG_FRIENDS_INVITED_INTERFACE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FRIENDS_INVITED_INTERFACE,bytebuff);
      }
      
      public static function CG_GET_FRIENDS_INVITED(index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(index);
         SocketManager.send(MessageType.CG_GET_FRIENDS_INVITED,bytebuff);
      }
      
      public static function CG_SEND_FLOWER(id:Number, nm:int, type:int, payType:int, name:String = "", isKuaFu:int = 0) : void
      {
         bytebuff.length = 0;
         if(GameUnitManager.hero.id == id)
         {
            UIManager.centerBroadcast.addMsg("不能自己送自己鲜花");
            return;
         }
         if(GameUnitManager.hero.level < 40)
         {
            UIManager.centerBroadcast.addMsg("等级不足40级，不能赠送鲜花");
            return;
         }
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeInt(nm);
         bytebuff.writeInt(type);
         bytebuff.writeInt(payType);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(name));
         bytebuff.writeByte(isKuaFu);
         SocketManager.send(MessageType.CG_SEND_FLOWER,bytebuff);
      }
      
      public static function CG_ADD_FRIEND_SERV(roleName:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(Model_heFu.correctRoleServName(roleName));
         SocketManager.send(MessageType.CG_ADD_FRIEND_SERV,bytebuff);
      }
      
      public static function CG_ACCEPT_SERV_FRIEND(roleID:Number, roleName:String, choose:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleID);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(roleName));
         bytebuff.writeByte(choose);
         SocketManager.send(MessageType.CG_ACCEPT_FRIEND,bytebuff);
      }
      
      public static function CG_DEL_CROSSFRIEND(id:Number, name:String) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(name));
         SocketManager.send(MessageType.CG_DEL_CROSSFRIEND,bytebuff);
      }
      
      public static function CG_ADD_CROSSCONTACT(roleId:Number, roleName:String) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(roleName));
         SocketManager.send(MessageType.CG_ADD_CROSSCONTACT,bytebuff);
      }
      
      public static function CG_DEL_CROSSHEAT(roleId:Number, roleName:String) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(roleName));
         SocketManager.send(MessageType.CG_DEL_CROSSHEAT,bytebuff);
      }
      
      public static function CG_CROSS_FRIENDTOHEAT(roleId:Number, roleName:String) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(roleName));
         SocketManager.send(MessageType.CG_CROSS_FRIENDTOHEAT,bytebuff);
      }
      
      public static function CG_CROSS_HEATTOFRIEND(roleId:Number, roleName:String) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(roleName));
         SocketManager.send(MessageType.CG_CROSS_HEATTOFRIEND,bytebuff);
      }
      
      public static function CG_FRIENDS_ADD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FRIENDS_ADD,bytebuff);
      }
   }
}

