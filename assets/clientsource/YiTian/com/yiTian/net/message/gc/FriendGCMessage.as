package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.gameUnit.role.LZBmp;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FriendHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.friends.Enum_Friend;
   import com.yiTian.view.modules.friends.Model_Friends;
   import com.yiTian.view.modules.friends.blessVo;
   import com.yiTian.view.modules.playerExtend.FriendCheckVo;
   import flash.utils.IDataInput;
   
   public class FriendGCMessage
   {
      
      public function FriendGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_FRIEND_LIST] = this.GC_GET_FRIEND_INFO;
         index[MessageType.GC_ADD_FRIEND_A_TIP] = this.GC_ADD_FRIEND_TIP;
         index[MessageType.GC_ADD_FRIEND_B_TIP] = this.GC_ADD_FRIEND_B_TIP;
         index[MessageType.GC_ADD_FRIEND_RESULT_TIP] = this.GC_ADD_FRIEND_RESULT_TIP;
         index[MessageType.GC_ADD_PER_FRIEND_AT_LIST] = this.GC_ADD_PER_FRIEND_AT_LIST;
         index[MessageType.GC_FRIEND_ONLINE_STATE_CHANGE] = this.GC_FRIEND_ONLINE_STATE_CHANGE;
         index[MessageType.GC_DEL_FRIEND_RESULT] = this.GC_DEL_FRIEND_RESULT;
         index[MessageType.GC_ADD_CONTACT_BY_TYPE] = this.GC_ADD_CONTACT_BY_TYPE;
         index[MessageType.GC_ADD_FRIEND_DELAY_TIP] = this.GC_ADD_FRIEND_DELAY_TIP;
         index[MessageType.GC_BLESS_ADD] = this.GC_BLESS_ADD;
         index[MessageType.GC_BLESS_RESULT] = this.GC_BLESS_RESULT;
         index[MessageType.GC_BLESS_DEL] = this.GC_BLESS_DEL;
         index[MessageType.GC_FRIEND_MESSAGE_CHANGE] = this.GC_FRIEND_MESSAGE_CHANGE;
         index[MessageType.GC_JOINFRIENDS] = this.GC_JOINFRIENDS;
         index[MessageType.GC_JOINFRIENDS_ALL] = this.GC_JOINFRIENDS_ALL;
         index[MessageType.GC_INVITE_INFO] = this.GC_INVITE_INFO;
         index[MessageType.GC_GET_INVITE_REWARD] = this.GC_GET_INVITE_REWARD;
         index[MessageType.GC_FRIEND_CHONGZHI] = this.GC_FRIEND_CHONGZHI;
         index[MessageType.GC_FRIENDS_INVITED_INTERFACE] = this.GC_FRIENDS_INVITED_INTERFACE;
         index[MessageType.GC_GET_FRIENDS_INVITED] = this.GC_GET_FRIENDS_INVITED;
         index[MessageType.GC_FRIENDS_ICON] = this.GC_FRIENDS_ICON;
         index[MessageType.GC_SEND_FLOWER] = this.GC_SEND_FLOWER;
         index[MessageType.GC_GET_FLOWER] = this.GC_GET_FLOWER;
         index[MessageType.GC_FlOWER_BROADCAST] = this.GC_FlOWER_BROADCAST;
         index[MessageType.GC_FLOWER_EFFECT] = this.GC_FLOWER_EFFECT;
         index[MessageType.GC_ADD_FRIEND_SERV] = this.GC_ADD_FRIEND_SERV;
         index[MessageType.GC_ACCEPT_FRIEND] = this.GC_ACCEPT_FRIEND;
         index[MessageType.GC_DEL_CROSSFRIEND] = this.GC_DEL_CROSSFRIEND;
         index[MessageType.GC_ADD_CROSSCONTACT] = this.GC_ADD_CROSSCONTACT;
         index[MessageType.GC_CROSS_TIP] = this.GC_CROSS_TIP;
         index[MessageType.GC_FRIENDS_ADD] = this.GC_FRIENDS_ADD;
      }
      
      public function GC_GET_FRIEND_INFO(patch:IDataInput) : void
      {
         var i_index:int = 0;
         var id:Number = NaN;
         var roleName:String = null;
         var lv:int = 0;
         var sex:int = 0;
         var job:int = 0;
         var area:String = null;
         var isOnline:int = 0;
         var i3:int = 0;
         var i4:int = 0;
         var relation:int = 0;
         var diaLvl:int = 0;
         var isYearD:int = 0;
         var huangZLvl:int = 0;
         var isHuangZYear:int = 0;
         var isHuiyuan:int = 0;
         var isHuiyuanYear:int = 0;
         var superLan:int = 0;
         var superLanYear:int = 0;
         var isSuperHuang:int = 0;
         var array_FRIEND:Array = null;
         var zone:int = 0;
         var result:int = patch.readByte();
         var friends_len:int = patch.readShort();
         var friends:Array = [];
         i_index = 0;
         while(i_index < friends_len)
         {
            id = LongUtil.readLong(patch);
            roleName = patch.readUTF();
            lv = patch.readShort();
            sex = patch.readByte();
            job = patch.readByte();
            area = patch.readUTF();
            isOnline = patch.readByte();
            i3 = patch.readInt();
            i4 = patch.readInt();
            relation = patch.readByte();
            diaLvl = patch.readByte();
            isYearD = patch.readByte();
            huangZLvl = patch.readByte();
            isHuangZYear = patch.readByte();
            isHuiyuan = patch.readByte();
            isHuiyuanYear = patch.readByte();
            superLan = patch.readByte();
            superLanYear = patch.readByte();
            isSuperHuang = 0;
            array_FRIEND = [];
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSuperHuang = patch.readByte();
            }
            zone = patch.readInt();
            array_FRIEND.push(id,roleName,lv,sex,job,area,isOnline,i3,i4,relation,diaLvl,isYearD,huangZLvl,isHuangZYear,isHuiyuan,isHuiyuanYear,superLan,superLanYear,isSuperHuang,zone);
            friends.push(array_FRIEND);
            i_index++;
         }
         friends.sortOn("7",Array.NUMERIC | Array.DESCENDING);
         FriendCheckVo.dataArr = friends;
         FriendHandle.GC_GET_FRIEND_INFO(friends);
      }
      
      public function GC_ADD_FRIEND_B_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         var type:int = Boolean(patch.bytesAvailable) ? patch.readByte() : 1;
         FriendHandle.GC_ADD_FRIEND_B_TIP(id,name,type);
      }
      
      public function GC_ADD_FRIEND_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         FriendHandle.GC_ADD_FRIEND_A_RE(result,name);
      }
      
      public function GC_ADD_FRIEND_RESULT_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var dir:int = patch.readByte();
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         FriendHandle.GC_ADD_FRIEND_RESULT_TIP(result,dir,name);
      }
      
      public function GC_ADD_PER_FRIEND_AT_LIST(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var friend:Array = [];
         friend.push(LongUtil.readLong(patch));
         friend.push(patch.readUTF());
         friend.push(patch.readShort());
         friend.push(patch.readByte());
         friend.push(patch.readByte());
         friend.push(patch.readUTF());
         friend.push(patch.readByte());
         friend.push(patch.readInt());
         friend.push(patch.readInt());
         friend.push(patch.readByte());
         friend.push(patch.readByte());
         friend.push(patch.readByte());
         friend.push(patch.readByte());
         friend.push(patch.readByte());
         friend.push(patch.readByte());
         friend.push(patch.readByte());
         friend.push(patch.readByte());
         friend.push(patch.readByte());
         var isSuperHuang:int = 0;
         if(LZBmp.isUsingSuperHuangZuan)
         {
            isSuperHuang = patch.readByte();
         }
         friend.push(isSuperHuang);
         friend.push(patch.readInt());
         FriendCheckVo.dataArr = friend;
         FriendHandle.GC_ADD_PER_FRIEND_AT_LIST(friend);
      }
      
      public function GC_FRIEND_ONLINE_STATE_CHANGE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var relation:int = patch.readByte();
         var id:Number = LongUtil.readLong(patch);
         FriendHandle.GC_FRIEND_LINE_TIP(result,relation,id);
      }
      
      public function GC_DEL_FRIEND_RESULT(patch:IDataInput) : void
      {
         var target:Vo_unit = null;
         var result:int = patch.readByte();
         var type:int = patch.readByte();
         var dir:int = patch.readByte();
         var id:Number = LongUtil.readLong(patch);
         target = Model_Friends.getFriendVoById(id);
         FriendHandle.GC_DEL_FRIEND_RESULT(type,dir,id);
      }
      
      public function GC_ADD_CONTACT_BY_TYPE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var contact:Array = new Array();
         var roleID:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         var roleLevel:int = patch.readShort();
         var roleJob:int = patch.readByte();
         var roleSex:int = patch.readByte();
         var partyName:String = patch.readUTF();
         var onLine:int = patch.readByte();
         var qmd:int = patch.readInt();
         var mapID:int = patch.readInt();
         var relation:int = patch.readByte();
         var lanZhuanLevel:int = patch.readByte();
         var nianFeiLanZhuan:int = patch.readByte();
         var huangZhuanLevel:int = patch.readByte();
         var nianFeiHuangZhuan:int = patch.readByte();
         var vip:int = patch.readByte();
         var nianFeiVip:int = patch.readByte();
         var hahuaLanZhuan:int = patch.readByte();
         var nianFeiHaoHuaLanZhuan:int = patch.readByte();
         var isSuperHuang:int = 0;
         if(LZBmp.isUsingSuperHuangZuan)
         {
            isSuperHuang = patch.readByte();
         }
         if(relation != Enum_Friend.CROSS_SERV_FRIEND && relation != Enum_Friend.CROSS_SERV_HEAT)
         {
            roleName = Model_heFu.repNameByHero(roleName);
         }
         contact = [roleID,roleName,roleLevel,roleJob,roleSex,partyName,onLine,qmd,mapID,relation,lanZhuanLevel,nianFeiLanZhuan,huangZhuanLevel,nianFeiHuangZhuan,vip,nianFeiVip,hahuaLanZhuan,nianFeiHaoHuaLanZhuan,isSuperHuang];
         FriendCheckVo.dataArr = contact;
         FriendHandle.GC_ADD_CONTACT_BY_TYPE(result,contact);
      }
      
      public function GC_ADD_FRIEND_DELAY_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:Number = LongUtil.readLong(patch);
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         FriendHandle.GC_ADD_FRIEND_DELAY_TIP(name);
      }
      
      public function GC_BLESS_ADD(patch:IDataInput) : void
      {
         var temp:blessVo = null;
         var length:int = patch.readByte();
         var array:Array = new Array();
         var i:int = 0;
         while(i < length)
         {
            temp = new blessVo();
            temp.targetId = LongUtil.readLong(patch);
            temp.targetName = Model_heFu.repNameByHero(patch.readUTF());
            temp.targetLv = patch.readShort();
            temp.rewardExp = patch.readInt();
            temp.lastLv = patch.readShort();
            temp.lastBless = patch.readByte();
            temp.date = patch.readInt();
            array.push(temp);
            i++;
         }
         FriendHandle.GC_BLESS_ADD(array);
      }
      
      public function GC_BLESS_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var type:int = patch.readByte();
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         var exp:int = patch.readInt();
         var id:Number = LongUtil.readLong(patch);
         var lv:int = patch.readShort();
         FriendHandle.GC_BLESS_RESULT(result,type,name,exp,id,lv);
      }
      
      public function GC_BLESS_DEL(patch:IDataInput) : void
      {
         var id:Number = LongUtil.readLong(patch);
         var lv:int = patch.readShort();
         FriendHandle.GC_BLESS_DEL(id,lv);
      }
      
      public function GC_FRIEND_MESSAGE_CHANGE(patch:IDataInput) : void
      {
         FriendHandle.GC_FRIEND_MESSAGE_CHANGE(patch);
      }
      
      public function GC_JOINFRIENDS(patch:IDataInput) : void
      {
         var dataItem:Array = null;
         var len:int = patch.readByte();
         var data:Array = [];
         while(Boolean(len--))
         {
            dataItem = [];
            dataItem.push(LongUtil.readLong(patch));
            dataItem.push(patch.readByte());
            dataItem.push(patch.readByte());
            dataItem.push(patch.readUTF());
            data[len] = dataItem;
         }
         FriendHandle.GC_JOINFRIENDS(data);
      }
      
      public function GC_JOINFRIENDS_ALL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         FriendHandle.GC_JOINFRIENDS_ALL(result);
      }
      
      public function GC_INVITE_INFO(patch:IDataInput) : void
      {
         var arr:Array = [];
         var i:int = 0;
         while(i < 4)
         {
            arr.push(patch.readByte());
            i += 1;
         }
         var num:int = patch.readShort();
         FriendHandle.GC_INVITE_INFO(arr,num);
      }
      
      public function GC_GET_INVITE_REWARD(patch:IDataInput) : void
      {
         var id:int = patch.readByte();
         FriendHandle.GC_GET_INVITE_REWARD(id);
      }
      
      public function GC_FRIEND_CHONGZHI(patch:IDataInput) : void
      {
         var id:Number = NaN;
         var count:int = 0;
         var len:int = patch.readShort();
         var array:Array = [];
         var i:int = 0;
         while(i < len)
         {
            id = LongUtil.readLong(patch);
            count = patch.readByte();
            array.push([id,count]);
            i += 1;
         }
         FriendHandle.GC_FRIEND_CHONGZHI(array);
      }
      
      public function GC_FRIENDS_INVITED_INTERFACE(patch:IDataInput) : void
      {
         var array:Array = [];
         var i:int = 0;
         while(i < 7)
         {
            array.push(patch.readByte());
            i++;
         }
         FriendHandle.GC_FRIENDS_INVITED_INTERFACE(array);
      }
      
      public function GC_GET_FRIENDS_INVITED(patch:IDataInput) : void
      {
         var index:int = patch.readByte();
         var status:int = patch.readByte();
         FriendHandle.GC_GET_FRIENDS_INVITED(index,status);
      }
      
      public function GC_FRIENDS_ICON(patch:IDataInput) : void
      {
         FriendHandle.GC_FRIENDS_ICON();
      }
      
      public function GC_SEND_FLOWER(patch:IDataInput) : void
      {
         var _SafeStr_1:int = patch.readByte();
         if(_SafeStr_1 == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29253",2));
         }
         else if(_SafeStr_1 == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29254",2));
         }
         else if(_SafeStr_1 == 3)
         {
            UIManager.centerBroadcast.addMsg("不能给自己送鲜花");
         }
      }
      
      public function GC_GET_FLOWER(patch:IDataInput) : void
      {
         var data:Object = new Object();
         data.nm = patch.readByte();
         data.job = patch.readByte();
         data.id = LongUtil.readLong(patch);
         data.name = Model_heFu.repNameByHero(patch.readUTF());
         data.flowerNum = patch.readInt();
         FriendHandle.GC_GET_FLOWER(data);
      }
      
      public function GC_FlOWER_BROADCAST(patch:IDataInput) : void
      {
         var data:Object = new Object();
         data.nm = patch.readByte();
         data.senderJob = patch.readByte();
         data.senderName = Model_heFu.repNameByHero(patch.readUTF());
         data.getterJob = patch.readByte();
         data.getterName = Model_heFu.repNameByHero(patch.readUTF());
         data.flowerNum = patch.readInt();
         var i:int = (data.senderName as String).indexOf(".");
         if(i != -1)
         {
            data.quhao = (data.senderName as String).slice(i);
         }
         else
         {
            data.quhao = "";
         }
         data.iskuafu = patch.readByte();
         FriendHandle.GC_FlOWER_BROADCAST(data);
      }
      
      public function GC_FLOWER_EFFECT(patch:IDataInput) : void
      {
         FriendHandle.effHd();
      }
      
      public function GC_ADD_FRIEND_SERV(patch:IDataInput) : void
      {
         var roleID:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         FriendHandle.GC_ADD_FRIEND_SERV(roleID,roleName);
      }
      
      public function GC_ACCEPT_FRIEND(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         FriendHandle.GC_ACCEPT_FRIEND(result);
      }
      
      public function GC_CROSS_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var senderName:String = patch.readUTF();
         var targetName:String = patch.readUTF();
         FriendHandle.GC_CROSS_TIP(result,senderName,targetName);
      }
      
      private function GC_FRIENDS_ADD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var value:int = patch.readInt();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("您的跨服好友列表人数已达上限。");
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("恭喜你，你可添加的好友数量增加到" + value);
         }
      }
      
      public function GC_DEL_CROSSFRIEND(patch:IDataInput) : void
      {
      }
      
      public function GC_ADD_CROSSCONTACT(patch:IDataInput) : void
      {
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "get"
 */
