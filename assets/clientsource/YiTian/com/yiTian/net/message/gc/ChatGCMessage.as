package com.yiTian.net.message.gc
{
   import com.utils.ColorConstant;
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.ChatHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.chatM.face.Model_face;
   import com.yiTian.view.modules.jingJiChang.View_jingJiChang;
   import flash.utils.IDataInput;
   
   public class ChatGCMessage
   {
      
      public static var _otherRoleId:int;
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      private var i:int;
      
      private var j:int;
      
      public function ChatGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_CHAT] = this.GC_CHAT;
         index[MessageType.GC_SID_CHAT] = this.GC_SID_CHAT;
         index[MessageType.GC_SID_CHAT_SEND] = this.GC_SID_CHAT_SEND;
         index[MessageType.GC_KUAFU_CHAT] = this.GC_KUAFU_CHAT;
         index[MessageType.GC_SHOW] = this.GC_SHOW;
         index[MessageType.GC_SID_CHAT_BLACKNAME] = this.GC_SID_CHAT_BLACKNAME;
         index[MessageType.GC_SC_BROAR] = this.GC_SC_BROAR;
         index[MessageType.GC_XUANYAO] = this.GC_XUANYAO;
         index[MessageType.GC_BECOME_WUHUN] = this.GC_BECOME_WUHUN;
         index[MessageType.GC_SYSCHAT_LUCKYNUM] = this.GC_SYSCHAT_LUCKYNUM;
         index[MessageType.GC_QuanFuGongGao] = this.GC_QuanFuGongGao;
         index[MessageType.GC_FACES_ICON_INFO] = this.GC_FACES_ICON_INFO;
         index[MessageType.GC_FACES_ICON_INFO_TISHI] = this.GC_FACES_ICON_INFO_TISHI;
      }
      
      public function GC_SID_CHAT_BLACKNAME(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ChatHandler.GC_SID_CHAT_BLACKNAME(result);
      }
      
      public function GC_CHAT(patch:IDataInput) : void
      {
         var chatStatus:int = patch.readByte();
         if(!chatStatus)
         {
            return;
         }
         var chatType:int = patch.readByte();
         var roleId:Number = LongUtil.readLong(patch);
         var sex:int = patch.readByte();
         var roleName:String = patch.readUTF();
         var job:int = patch.readByte();
         var vip:int = patch.readByte();
         var diaLvl:int = patch.readByte();
         var isYearDia:int = patch.readByte();
         var huangZLv:int = patch.readByte();
         var isHuangZYear:int = patch.readByte();
         var huiyuan:int = patch.readByte();
         var huiyuanYear:int = patch.readByte();
         var superLan:int = patch.readByte();
         var superLanYear:int = patch.readByte();
         var isSuperHuang:int = 0;
         var chatContact:String = patch.readUTF();
         isSuperHuang = patch.readByte();
         var isTongBu:int = patch.readByte();
         var faceInfo:String = Boolean(patch.bytesAvailable) ? patch.readUTF() : "";
         Utils.print(faceInfo);
         ChatHandler.GC_CHAT(chatStatus,chatType,roleId,sex,roleName,vip,chatContact,job,diaLvl,isYearDia,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang,isTongBu,faceInfo);
      }
      
      public function GC_SID_CHAT(patch:IDataInput) : void
      {
         var chatStatus:int = patch.readByte();
         if(chatStatus == -1)
         {
            ChatHandler.GC_SID_CHAT_M();
            return;
         }
         if(chatStatus == -2)
         {
            UIManager.centerBroadcast.addMsg("对方等级小于30级，不能私聊");
            return;
         }
         if(chatStatus == -3)
         {
            UIManager.centerBroadcast.addMsg("40级以下玩家最多与3个陌生人发起聊天",1);
            return;
         }
         if(chatStatus == -11)
         {
            UIManager.centerBroadcast.addMsg("对方不是您的跨服好友，不能进行私聊",1);
            return;
         }
         var otherRoleIcon:int = patch.readInt();
         var isFriend:int = patch.readByte();
         var otherRoleMap:String = patch.readUTF();
         var otherRoleId:Number = LongUtil.readLong(patch);
         var otherRoleName:String = patch.readUTF();
         var sex:int = patch.readByte();
         var job:int = patch.readByte();
         var horse:int = patch.readInt();
         var body:int = patch.readInt();
         var weapon:int = patch.readInt();
         var vipLv:int = patch.readByte();
         var crossType:int = patch.readByte();
         var wingId:int = patch.readInt();
         var faceInfo:String = Boolean(patch.bytesAvailable) ? patch.readUTF() : "";
         Utils.print(faceInfo);
         ChatHandler.GC_SID_CHAT(chatStatus,otherRoleIcon,isFriend,otherRoleMap,otherRoleId,otherRoleName,sex,job,body,weapon,horse,vipLv,crossType,wingId);
      }
      
      public function GC_SID_CHAT_SEND(patch:IDataInput) : void
      {
         var chatStatus:int = patch.readByte();
         var roleId:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         var sex:int = patch.readByte();
         var job:int = patch.readByte();
         var time:int = patch.readInt();
         var chatContact:String = patch.readUTF();
         var horse:int = patch.readInt();
         var body:int = patch.readInt();
         var weapon:int = patch.readInt();
         var vipLv:int = patch.readByte();
         var crossType:int = patch.readByte();
         var wingId:int = patch.readInt();
         var faceInfo:String = Boolean(patch.bytesAvailable) ? patch.readUTF() : "";
         Utils.print(faceInfo);
         ChatHandler.GC_SID_CHAT_SEND(chatStatus,roleId,roleName,time,chatContact,sex,job,body,weapon,horse,vipLv,crossType,wingId,faceInfo);
      }
      
      public function GC_KUAFU_CHAT(patch:IDataInput) : void
      {
         var chatStatus:int = patch.readByte();
         var roleId:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         var sex:int = patch.readByte();
         var job:int = patch.readByte();
         var time:int = patch.readInt();
         var chatContact:String = patch.readUTF();
         var horse:int = patch.readInt();
         var body:int = patch.readInt();
         var weapon:int = patch.readInt();
         var vipLv:int = patch.readByte();
         var isKuaFu:int = patch.readByte();
         var wingId:int = patch.readInt();
         var faceInfo:String = Boolean(patch.bytesAvailable) ? patch.readUTF() : "";
         Utils.print(faceInfo);
         ChatHandler.GC_SID_CHAT_SEND(chatStatus,roleId,roleName,time,chatContact,sex,job,body,weapon,horse,vipLv,isKuaFu,wingId,faceInfo);
      }
      
      public function GC_SHOW(patch:IDataInput) : void
      {
         var len:int = 0;
         var result:int = patch.readByte();
         var equips:Array = [];
         var array_EQUIP:Array = [];
         array_EQUIP.push(LongUtil.readLong(patch));
         array_EQUIP.push(patch.readInt());
         array_EQUIP.push(LongUtil.readLong(patch));
         array_EQUIP.push(patch.readByte());
         array_EQUIP.push(patch.readByte());
         array_EQUIP.push(patch.readByte());
         array_EQUIP.push(patch.readByte());
         array_EQUIP.push(patch.readInt());
         array_EQUIP.push(patch.readByte());
         array_EQUIP.push(patch.readInt());
         array_EQUIP.push(patch.readShort());
         len = patch.readByte();
         var temp_basic:Array = [];
         this.j = 0;
         while(this.j < len)
         {
            temp_basic.push(patch.readByte());
            temp_basic.push(patch.readInt());
            temp_basic.push(patch.readInt());
            ++this.j;
         }
         array_EQUIP.push(temp_basic);
         len = patch.readByte();
         var temp_intensify:Array = [];
         this.j = 0;
         while(this.j < len)
         {
            temp_intensify.push(patch.readByte());
            temp_intensify.push(patch.readInt());
            ++this.j;
         }
         array_EQUIP.push(temp_intensify);
         len = patch.readByte();
         var temp_extra:Array = [];
         this.j = 0;
         while(this.j < len)
         {
            temp_extra.push(patch.readByte());
            temp_extra.push(patch.readInt());
            temp_extra.push(patch.readByte());
            temp_extra.push(patch.readInt());
            ++this.j;
         }
         array_EQUIP.push(temp_extra);
         len = patch.readByte();
         var temp_stoneId:Array = [];
         this.j = 0;
         while(this.j < len)
         {
            temp_stoneId.push(patch.readInt());
            ++this.j;
         }
         array_EQUIP.push(temp_stoneId);
         var extra_polish:String = patch.readUTF();
         array_EQUIP.push(extra_polish);
         var isGrey:int = patch.readByte();
         var skillId:int = patch.readInt();
         var skillGrade:int = patch.readByte();
         var jingLianCount:int = patch.readByte();
         array_EQUIP.push(isGrey);
         array_EQUIP.push(skillId);
         array_EQUIP.push(skillGrade);
         array_EQUIP.push(jingLianCount);
         var czLen:int = patch.readByte();
         var temp_jingLian_arr:Array = [];
         this.j = 0;
         while(this.j < czLen)
         {
            temp_jingLian_arr.push(patch.readByte());
            temp_jingLian_arr.push(patch.readInt());
            ++this.j;
         }
         array_EQUIP.push(temp_jingLian_arr);
         array_EQUIP.push(patch.readInt());
         array_EQUIP.push(patch.readByte());
         array_EQUIP.push(patch.readByte());
         array_EQUIP.push(patch.readByte());
         array_EQUIP.push(patch.readByte());
         equips.push(array_EQUIP);
         ChatHandler.showHandle(equips);
      }
      
      public function GC_SC_BROAR(patch:IDataInput) : void
      {
         var roleId:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         var day:int = patch.readInt();
         ChatHandler.GC_SC_BROAR(roleId,name,day);
      }
      
      public function GC_BECOME_WUHUN(patch:IDataInput) : void
      {
         var roleId:Number = LongUtil.readLong(patch);
         var job:int = patch.readByte();
         var name:String = patch.readUTF();
         ChatHandler.GC_BECOME_WUHUN(roleId,name,job);
      }
      
      public function GC_XUANYAO(patch:IDataInput) : void
      {
         var name1:String = Model_heFu.repNameByHero(patch.readUTF());
         var name2:String = Model_heFu.repNameByHero(patch.readUTF());
         var st:String = LangConfig.getWord("1139",0,HtmlUtil.font(name1 + "：",ColorConstant.getColorStr(ColorConstant.BLUE)),HtmlUtil.font(name2,ColorConstant.getColorStr(ColorConstant.GREEN)));
         --View_jingJiChang._xuanYaoTimes;
         if(View_jingJiChang._xuanYaoTimes <= 0)
         {
            View_jingJiChang._xuanYaoTimes = 0;
         }
         UIManager.laba_panel.update("",st,1,0,0,0,0,0,0,0,0,0,1);
      }
      
      public function GC_SYSCHAT_LUCKYNUM(patch:IDataInput) : void
      {
         var content:String = patch.readUTF();
         UIManager.chatPanel.addSysMessage(content);
      }
      
      public function GC_QuanFuGongGao(patch:IDataInput) : void
      {
         var roleId:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         var resultId:int = patch.readByte();
         ChatHandler.GC_QuanFuGongGao(roleId,name,resultId);
      }
      
      private function GC_FACES_ICON_INFO(patch:IDataInput) : void
      {
         var ss:String = null;
         var voim:Vo_item = null;
         var data:String = patch.readUTF();
         var arr:Array = data.split(",");
         Model_face.data = [];
         var i:int = 0;
         while(i < arr.length)
         {
            ss = arr[i];
            voim = new Vo_item();
            voim.id = int(ss.split("_")[0]);
            voim.Init_lib();
            if(voim.face_icon_id != 0)
            {
               Model_face.data.push([voim.face_icon_id,ss.split("_")[1]]);
            }
            i++;
         }
         Model_face.counts();
      }
      
      private function GC_FACES_ICON_INFO_TISHI(patch:IDataInput) : void
      {
         UIManager.centerBroadcast.addMsg("已有相同表情包，请过期后再使用",1);
      }
   }
}

