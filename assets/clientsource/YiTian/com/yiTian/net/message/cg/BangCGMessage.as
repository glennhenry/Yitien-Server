package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class BangCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      private static var lastInvteTime:int = -120000;
      
      public function BangCGMessage()
      {
         super();
      }
      
      public static function CG_BANG_SEARCH(partyName:String, leaderName:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(partyName);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(leaderName));
         SocketManager.send(MessageType.CG_BANG_SEARCH,bytebuff);
      }
      
      public static function CG_BANG_PAGE_SEARCH(flag:int, partyName:String, leaderName:String, cur_page:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(flag);
         bytebuff.writeUTF(partyName);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(leaderName));
         bytebuff.writeShort(cur_page);
         SocketManager.send(MessageType.CG_BANG_PAGE_SEARCH,bytebuff);
      }
      
      public static function CG_BANG_BUILD(partyName:String, declaration:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(partyName);
         bytebuff.writeUTF(declaration);
         SocketManager.send(MessageType.CG_BANG_BUILD,bytebuff);
      }
      
      public static function CG_BANG_CHECK(party_id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,party_id);
         SocketManager.send(MessageType.CG_BANG_CHECK,bytebuff);
      }
      
      public static function CG_BANG_APPLY(party_id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,party_id);
         SocketManager.send(MessageType.CG_BANG_APPLY,bytebuff);
      }
      
      public static function CG_BANG_INVIDE_M(party_id:Number, heroName:String) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,party_id);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(heroName));
         SocketManager.send(MessageType.CG_BANG_INVIDE_M,bytebuff);
      }
      
      public static function CG_BANG_INVIDE_N(choise:int, partyId:Number, invide_roleId:Number) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(choise);
         LongUtil.writeLong(bytebuff,partyId);
         LongUtil.writeLong(bytebuff,invide_roleId);
         SocketManager.send(MessageType.CG_BANG_INVIDE_N,bytebuff);
      }
      
      public static function CG_BANG_CHECK_SELF(type:int, cur_page:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeShort(cur_page);
         SocketManager.send(MessageType.CG_BANG_CHECK_SELF,bytebuff);
      }
      
      public static function CG_BANG_CHANGED_ANNOUNCEMENT(flag:int, partyId:Number, content:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(flag);
         LongUtil.writeLong(bytebuff,partyId);
         bytebuff.writeUTF(content);
         SocketManager.send(MessageType.CG_BANG_CHANGED_ANNOUNCEMENT,bytebuff);
      }
      
      public static function CG_BANG_RIGHT(flag:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(flag);
         SocketManager.send(MessageType.CG_BANG_RIGHT,bytebuff);
      }
      
      public static function CG_BANG_RENMING(roleId:Number, position:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         bytebuff.writeByte(position);
         SocketManager.send(MessageType.CG_BANG_RENMING,bytebuff);
      }
      
      public static function CG_BANG_TUIWEI() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BANG_TUIWEI,bytebuff);
      }
      
      public static function CG_GET_BANG_LIST(curPage:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(curPage);
         SocketManager.send(MessageType.CG_GET_BANG_LIST,bytebuff);
      }
      
      public static function CG_BANG_EXPEL(roleId:Number, cur_page:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         bytebuff.writeShort(cur_page);
         SocketManager.send(MessageType.CG_BANG_EXPEL,bytebuff);
      }
      
      public static function CG_BANG_LEADER_RIGHT(roleId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         SocketManager.send(MessageType.CG_BANG_LEADER_RIGHT,bytebuff);
      }
      
      public static function CG_BANG_EVENT_CHECK(partyId:Number, cur_page:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,partyId);
         bytebuff.writeShort(cur_page);
         SocketManager.send(MessageType.CG_BANG_EVENT_CHECK,bytebuff);
      }
      
      public static function CG_BANG_ENTER_PLANT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BANG_ENTER_PLANT,bytebuff);
      }
      
      public static function CG_BANG_APPLY_N(applyId:Number, isAgree:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,applyId);
         bytebuff.writeByte(isAgree);
         SocketManager.send(MessageType.CG_BANG_APPLY_N,bytebuff);
      }
      
      public static function CG_CLOSE_PARTY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_CLOSE_PARTY,bytebuff);
      }
      
      public static function CG_UPDATE_BUILDING(buildingType:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(buildingType);
         SocketManager.send(MessageType.CG_UPDATE_BUILDING,bytebuff);
      }
      
      public static function CG_ENTER_BUILDING(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_ENTER_BUILDING,bytebuff);
      }
      
      public static function CG_BUY_BANGSHOPITEM(gridId:int, itemId:int, count:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(gridId);
         bytebuff.writeInt(itemId);
         bytebuff.writeInt(count);
         SocketManager.send(MessageType.CG_BUY_BANGSHOPITEM,bytebuff);
      }
      
      public static function CG_SHAKE_MONEY_TREE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SHAKE_MONEY_TREE,bytebuff);
      }
      
      public static function CG_RESEARCH_ZF(type:int, zfType:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeByte(zfType);
         SocketManager.send(MessageType.CG_RESEARCH_ZF,bytebuff);
      }
      
      public static function CG_MONEYTREEINFO() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MONEYTREEINFO,bytebuff);
      }
      
      public static function CG_BANG_PLANT_CHUCHONG(type:int, id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_BANG_PLANT_CHUCHONG,bytebuff);
      }
      
      public static function CG_BANG_PLANT_CAIJI(type:int, xiGuaId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeInt(xiGuaId);
         SocketManager.send(MessageType.CG_BANG_PLANT_CAIJI,bytebuff);
      }
      
      public static function CG_ASK_BIND_QQGROUP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ASK_BIND_QQGROUP,bytebuff);
      }
      
      public static function CG_ASK_HANDLE_QQGROUP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ASK_HANDLE_QQGROUP,bytebuff);
      }
      
      public static function CG_ASK_IN_QQGROUP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ASK_IN_QQGROUP,bytebuff);
      }
      
      public static function CG_TONGBU_TO_QQGROUP(type:int) : void
      {
         Utils.print(type,"看看看啊");
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_TONGBU_TO_QQGROUP,bytebuff);
      }
      
      public static function CG_BANG_QQGROUP_SAVE(unionid:String, groupOpenId:String, type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(unionid);
         bytebuff.writeUTF(groupOpenId);
         bytebuff.writeInt(type);
         SocketManager.send(MessageType.CG_BANG_QQGROUP_SAVE,bytebuff);
      }
      
      public static function TRY_JIANGHU_INVITE() : void
      {
         var cost:int = 0;
         cost = 50000;
         View_Alert.show(LangConfig.reTxt("<font color=\'#ffffaa\'>你确定要花费{0}银两发送帮会招募信息吗？</font>",cost),View_Alert.OK_CANCAL,function():void
         {
            var now:int = getTimer();
            var interval:int = now - lastInvteTime;
            if(interval > 120000)
            {
               if(GameUnitManager.hero.silver >= cost)
               {
                  CG_JIANGHU_INVITE();
                  lastInvteTime = now;
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("银两不足");
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.reTxt("邀请冷却时间未到，还需等待{0}秒",Math.ceil((120000 - interval) / 1000)));
            }
         });
      }
      
      public static function CG_JIANGHU_INVITE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_JIANGHU_INVITE,bytebuff);
      }
   }
}

