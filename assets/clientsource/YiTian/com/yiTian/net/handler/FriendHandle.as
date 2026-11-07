package com.yiTian.net.handler
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.effects.Effect_flower;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Pool;
   import com.yiTian.view.modules.friends.Child_FriendItem;
   import com.yiTian.view.modules.friends.Enum_Friend;
   import com.yiTian.view.modules.friends.Model_Friends;
   import com.yiTian.view.modules.friends.View_AddFriendTip;
   import com.yiTian.view.modules.friends.View_FriendSelectedMenu;
   import com.yiTian.view.modules.friends.View_ReceiveWindows;
   import com.yiTian.view.modules.friends.View_ZhuFuATip;
   import com.yiTian.view.modules.friends.View_inviteReward;
   import com.yiTian.view.modules.friends.blessVo;
   import com.yiTian.view.modules.mainUIBtnContainer.View_TipBtnContainer;
   import flash.utils.IDataInput;
   
   public class FriendHandle
   {
      
      private static var job_color_arr:Array = ["#ff5d38","#1ecbf8","#83e200","#e230ce"];
      
      public function FriendHandle()
      {
         super();
      }
      
      public static function GC_GET_FRIEND_INFO(friendArr:Array) : void
      {
         var o:Object = null;
         var vo_info:Vo_unit = null;
         for each(o in friendArr)
         {
            vo_info = new Vo_unit();
            vo_info.id = o[0];
            vo_info.name = o[1];
            vo_info.level = o[2];
            vo_info.job = o[3];
            vo_info.sex = o[4];
            vo_info.banghui = o[5];
            if(o[6] == 1)
            {
               vo_info.isOnline = true;
            }
            else
            {
               vo_info.isOnline = false;
            }
            vo_info.qinmidu = o[7];
            vo_info.areaid = o[8];
            vo_info.relation = o[9];
            vo_info.diaLvl = o[10];
            vo_info.isYearDia = o[11];
            vo_info.huangZLvl = o[12];
            vo_info.isHuangZYear = o[13];
            vo_info.isHuiyuan = o[14];
            vo_info.isHuiyuanYear = o[15];
            vo_info.superLan = o[16];
            vo_info.superLanYear = o[17];
            vo_info.isSuperHuang = o[18];
            vo_info.zone = o[19];
            if(vo_info.relation >= 1)
            {
               if(true)
               {
                  vo_info.name = Model_heFu.repNameByHero(vo_info.name);
               }
               Model_Friends.addFriendVo(vo_info);
               if(vo_info.relation == 1)
               {
                  UIManager.friendPanel.addItemAt(vo_info,0);
               }
               else if(vo_info.relation == 2)
               {
                  UIManager.friendPanel.addItemAt(vo_info,2);
               }
               else if(vo_info.relation == Enum_Friend.QFRIEND)
               {
                  UIManager.friendPanel.addItemAt(vo_info,1);
               }
               else if(vo_info.relation == Enum_Friend.CROSS_SERV_FRIEND)
               {
                  UIManager.friendPanel.addItemAt(vo_info,Model_Friends.CROSS_FRIEND);
               }
               else if(vo_info.relation == Enum_Friend.CROSS_SERV_HEAT)
               {
                  UIManager.friendPanel.addItemAt(vo_info,Model_Friends.CROSS_HEAT);
               }
            }
         }
         Model_Friends.refresh();
         UIManager.friendPanel.updateLabelText();
      }
      
      private static function getOrderHd(_arr:Array) : Array
      {
         var i:int = 0;
         var _arrLine:Array = [];
         var _arrLineNot:Array = [];
         i = 0;
         while(i < _arr.length)
         {
            if(Boolean(_arr[i].inOnline))
            {
               _arrLine.push(_arr[i]);
            }
            else
            {
               _arrLineNot.push(_arr[i]);
            }
            i++;
         }
         _arrLine = ZaHuoDianHandle.changedOrderHd(_arrLine,7);
         _arrLineNot = ZaHuoDianHandle.changedOrderHd(_arrLineNot,7);
         return _arrLine.concat(_arrLineNot);
      }
      
      public static function GC_ADD_FRIEND_A_RE(result:int, name:String) : void
      {
         var info_str:String = LangConfig.getWord((23100 + result).toString(),2,name);
         UIManager.centerBroadcast.addMsg(info_str);
      }
      
      public static function GC_ADD_FRIEND_B_TIP(id:Number, name:String, type:int) : void
      {
         if(!UIManager.isInit)
         {
            return;
         }
         name = Model_heFu.repNameByHero(name);
         if(Model_Friends.hasFriendQuest(id) == false)
         {
            Model_Friends.addFriendQuest(id,name,type);
         }
         Model_Friends.hasNewQuest = true;
         var tipCtnIns:View_TipBtnContainer = UIManager.tipBtnContainer;
         var tipIns:View_AddFriendTip = View_AddFriendTip.getInstance();
         if(!tipCtnIns.hasItem(tipIns))
         {
            tipCtnIns.addItem(tipIns);
         }
      }
      
      public static function GC_ADD_FRIEND_RESULT_TIP(resultFlag:int, dir:int, name:String) : void
      {
         var str_info:String = null;
         if(!UIManager.isInit)
         {
            return;
         }
         switch(resultFlag)
         {
            case 0:
               str_info = "error";
               break;
            case 1:
               if(dir == 1)
               {
                  str_info = LangConfig.getWord("23201",2,name);
                  break;
               }
               str_info = LangConfig.getWord("23202",2,name);
               Model_Friends.removeFriendQuest(name);
               UIManager.friQuestPanel.updateByModel();
               break;
            case 2:
               str_info = LangConfig.getWord("23203",2,name);
               break;
            case 3:
               str_info = LangConfig.getWord("23204",2,name);
               break;
            case 4:
               str_info = "对方好友已满";
               break;
            default:
               return;
         }
         UIManager.centerBroadcast.addMsg(str_info);
      }
      
      public static function GC_ADD_PER_FRIEND_AT_LIST(friend:Array) : void
      {
         var vo_info:Vo_unit = new Vo_unit();
         vo_info.id = friend[0];
         vo_info.name = friend[1];
         vo_info.level = friend[2];
         vo_info.job = friend[3];
         vo_info.sex = friend[4];
         vo_info.banghui = friend[5];
         if(friend[6] == 1)
         {
            vo_info.isOnline = true;
         }
         else
         {
            vo_info.isOnline = false;
         }
         vo_info.qinmidu = friend[7];
         vo_info.areaid = friend[8];
         vo_info.relation = friend[9];
         vo_info.diaLvl = friend[10];
         vo_info.isYearDia = friend[11];
         vo_info.huangZLvl = friend[12];
         vo_info.isHuangZYear = friend[13];
         vo_info.isHuiyuan = friend[14];
         vo_info.isHuiyuanYear = friend[15];
         vo_info.superLan = friend[16];
         vo_info.superLanYear = friend[17];
         vo_info.isSuperHuang = friend[18];
         if(true)
         {
            vo_info.name = Model_heFu.repNameByHero(vo_info.name);
         }
         Model_Friends.addFriendVo(vo_info);
         if(vo_info.relation == Enum_Friend.CROSS_SERV_FRIEND)
         {
            UIManager.friendPanel.addItemAt(vo_info,Model_Friends.CROSS_FRIEND);
         }
         else if(vo_info.relation == Enum_Friend.CROSS_SERV_HEAT)
         {
            UIManager.friendPanel.addItemAt(vo_info,Model_Friends.CROSS_HEAT);
         }
         else
         {
            UIManager.friendPanel.addItemAt(vo_info,vo_info.relation - 1);
         }
         var str_info:String = LangConfig.getWord("23205",2,vo_info.name);
         UIManager.selfBroadcast.addMsg(str_info);
         Global.control.sendNotification(Enum_MsgType.MSG_FRIEND_C,null);
      }
      
      public static function GC_FRIEND_LINE_TIP(type:int, relation:int, id:Number) : void
      {
         var state:Boolean = false;
         var target:Vo_unit = null;
         var fi1:Child_FriendItem = null;
         var fi3:Child_FriendItem = null;
         var fi2:Child_FriendItem = null;
         if(!UIManager.isInit)
         {
            return;
         }
         var isSortQFriend:Boolean = false;
         if(relation == 1)
         {
            isSortQFriend = Model_Friends.getFriendVoById(id) != null;
            target = Model_Friends.getFriendVoById(id);
            if(!target)
            {
               return;
            }
            switch(type)
            {
               case 1:
                  UIManager.selfBroadcast.addMsg(LangConfig.getWord("23206",2,target.name));
                  state = true;
                  break;
               case 2:
                  UIManager.selfBroadcast.addMsg(LangConfig.getWord("23207",2,target.name));
                  state = false;
            }
            target.isOnline = state;
            Model_Friends.refresh();
            fi1 = Model_Friends.getViewItemByRelationId(target.relation,target.id);
            if(type == 1)
            {
               fi1.setOnLineType();
               UIManager.friendPanel.bubbleSort(0);
               UIManager.friendPanel.resetAllPosition();
            }
            else
            {
               fi1.setOffLineType();
               UIManager.friendPanel.bubbleSort(0);
               UIManager.friendPanel.resetAllPosition();
            }
            UIManager.friendPanel.updateLabelText();
         }
         if(relation == Enum_Friend.QFRIEND)
         {
            target = Model_Friends.getQFriendVoById(id);
            if(!target)
            {
               return;
            }
            switch(type)
            {
               case 1:
                  state = true;
                  break;
               case 2:
                  state = false;
            }
            target.isOnline = state;
            Model_Friends.refresh();
            fi3 = Model_Friends.getViewItemByRelationId(Model_Friends.QQFRIEND + 1,target.id);
            if(target.isOnline)
            {
               fi3.setOnLineType();
               UIManager.friendPanel.bubbleSort(1);
               UIManager.friendPanel.resetAllPosition();
            }
            else
            {
               fi3.setOffLineType();
               UIManager.friendPanel.bubbleSort(1);
               UIManager.friendPanel.resetAllPosition();
            }
            UIManager.friendPanel.updateLabelText();
         }
         else if(relation == 2)
         {
            isSortQFriend = Model_Friends.getHeatVoById(id) != null;
            target = Model_Friends.getHeatVoById(id);
            if(!target)
            {
               return;
            }
            switch(type)
            {
               case 1:
                  state = true;
                  break;
               case 2:
                  state = false;
            }
            target.isOnline = state;
            Model_Friends.refresh();
            fi2 = Model_Friends.getViewItemByRelationId(3,target.id);
            if(target.isOnline)
            {
               fi2.setOnLineType();
               UIManager.friendPanel.bubbleSort(2);
               UIManager.friendPanel.resetAllPosition();
            }
            else
            {
               fi2.setOffLineType();
               UIManager.friendPanel.bubbleSort(2);
               UIManager.friendPanel.resetAllPosition();
            }
            UIManager.friendPanel.updateLabelText();
         }
         if(relation == Enum_Friend.CROSS_SERV_FRIEND)
         {
            target = Model_Friends.getCrossFriendVoById(id);
            if(!target)
            {
               return;
            }
            switch(type)
            {
               case 1:
                  state = true;
                  break;
               case 2:
                  state = false;
            }
            target.isOnline = state;
            Model_Friends.refresh();
            fi1 = Model_Friends.getViewItemByRelationId(Model_Friends.CROSS_FRIEND + 1,target.id);
            if(target.isOnline)
            {
               fi1.setOnLineType();
               UIManager.friendPanel.bubbleSort(Model_Friends.CROSS_FRIEND);
               UIManager.friendPanel.resetAllPosition();
            }
            else
            {
               fi1.setOffLineType();
               UIManager.friendPanel.bubbleSort(Model_Friends.CROSS_FRIEND);
               UIManager.friendPanel.resetAllPosition();
            }
            UIManager.friendPanel.updateLabelText();
         }
         if(relation == Enum_Friend.CROSS_SERV_HEAT)
         {
            target = Model_Friends.getCrossHeatVoById(id);
            if(!target)
            {
               return;
            }
            switch(type)
            {
               case 1:
                  state = true;
                  break;
               case 2:
                  state = false;
            }
            target.isOnline = state;
            Model_Friends.refresh();
            fi1 = Model_Friends.getViewItemByRelationId(Model_Friends.CROSS_HEAT + 1,target.id);
            if(target.isOnline)
            {
               fi1.setOnLineType();
            }
            else
            {
               fi1.setOffLineType();
            }
            UIManager.friendPanel.bubbleSort(Model_Friends.CROSS_HEAT);
            UIManager.friendPanel.resetAllPosition();
            UIManager.friendPanel.updateLabelText();
         }
      }
      
      public static function GC_DEL_FRIEND_RESULT(type:int, dir:int, id:Number) : void
      {
         var target:Vo_unit = null;
         if(type == 1)
         {
            target = Model_Friends.getFriendVoById(id);
            if(!target)
            {
               return;
            }
            if(dir == 1)
            {
               UIManager.selfBroadcast.addMsg(LangConfig.getWord("23208",2,target.name));
            }
            else
            {
               UIManager.selfBroadcast.addMsg(LangConfig.getWord("23209",2,target.name));
            }
            Model_Friends.friendArr.splice(Model_Friends.friendArr.indexOf(target),1);
            Model_Friends.refresh();
            UIManager.friendPanel.deleteChildByNameIndex(target.name,0);
         }
         else if(type == 2)
         {
            target = Model_Friends.getHeatVoById(id);
            if(!target)
            {
               return;
            }
            if(dir == 1)
            {
               UIManager.selfBroadcast.addMsg(LangConfig.getWord("23208",2,target.name));
            }
            else
            {
               UIManager.selfBroadcast.addMsg(LangConfig.getWord("23209",2,target.name));
            }
            Model_Friends.heatArr.splice(Model_Friends.heatArr.indexOf(target),1);
            Model_Friends.refresh();
            UIManager.friendPanel.deleteChildByNameIndex(target.name,2);
         }
         else if(type == Enum_Friend.CROSS_SERV_FRIEND)
         {
            target = Model_Friends.getCrossFriendVoById(id);
            if(!target)
            {
               return;
            }
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("23208",2,target.name));
            Model_Friends.crossFriendArr.splice(Model_Friends.crossFriendArr.indexOf(target),1);
            Model_Friends.refresh();
            UIManager.friendPanel.deleteChildByNameIndex(target.name,Model_Friends.CROSS_FRIEND);
         }
         else if(type == Enum_Friend.CROSS_SERV_HEAT)
         {
            target = Model_Friends.getCrossHeatVoById(id);
            if(!target)
            {
               return;
            }
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("23110",2,target.name));
            Model_Friends.crossHeatArr.splice(Model_Friends.crossHeatArr.indexOf(target),1);
            Model_Friends.refresh();
            UIManager.friendPanel.deleteChildByNameIndex(target.name,Model_Friends.CROSS_HEAT);
         }
         Global.control.sendNotification(Enum_MsgType.MSG_FRIEND_C,null);
      }
      
      public static function GC_ADD_CONTACT_BY_TYPE(result:int, contactArr:Array) : void
      {
         var index:int = 0;
         if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29398",2));
            return;
         }
         if(result == Enum_Friend.CROSS_SERV_FRIEND)
         {
            UIManager.centerBroadcast.addMsg("添加跨服好友成功");
         }
         var vo_info:Vo_unit = new Vo_unit();
         vo_info.id = contactArr[0];
         vo_info.name = Model_heFu.repNameByHero(contactArr[1]);
         vo_info.level = contactArr[2];
         vo_info.job = contactArr[3];
         vo_info.sex = contactArr[4];
         vo_info.banghui = contactArr[5];
         if(contactArr[6] == 1)
         {
            vo_info.isOnline = true;
         }
         else
         {
            vo_info.isOnline = false;
         }
         vo_info.qinmidu = contactArr[7];
         vo_info.areaid = contactArr[8];
         vo_info.relation = contactArr[9];
         vo_info.diaLvl = contactArr[10];
         vo_info.isYearDia = contactArr[11];
         vo_info.huangZLvl = contactArr[12];
         vo_info.isHuangZYear = contactArr[13];
         vo_info.isHuiyuan = contactArr[14];
         vo_info.isHuiyuanYear = contactArr[15];
         vo_info.superLan = contactArr[16];
         vo_info.superLanYear = contactArr[17];
         vo_info.isSuperHuang = contactArr[18];
         if(vo_info.relation == 2 && result != 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord((23110 + result).toString(),2,vo_info.name));
            return;
         }
         if(vo_info.relation == 2)
         {
            Model_Friends.addFriendVo(vo_info);
            index = 2;
         }
         else if(vo_info.relation == Enum_Friend.QFRIEND)
         {
            Model_Friends.addFriendVo(vo_info);
            index = 1;
         }
         else if(vo_info.relation == Enum_Friend.CROSS_SERV_FRIEND)
         {
            Model_Friends.addFriendVo(vo_info);
            index = Model_Friends.CROSS_FRIEND;
         }
         else if(vo_info.relation == Enum_Friend.CROSS_SERV_HEAT)
         {
            Model_Friends.addFriendVo(vo_info);
            index = Model_Friends.CROSS_HEAT;
         }
         UIManager.friendPanel.addItemAt(vo_info,index);
         View_FriendSelectedMenu.getInstance().resetMode();
      }
      
      public static function GC_ADD_FRIEND_DELAY_TIP(name:String) : void
      {
      }
      
      public static function GC_BLESS_ADD(array:Array) : void
      {
         var container:View_TipBtnContainer;
         var tipViewer:View_ZhuFuATip;
         var temp:blessVo = null;
         var compare:Function = null;
         var isSort:Boolean = false;
         compare = function(a:blessVo, b:blessVo):int
         {
            if(a.lastBless > b.lastBless)
            {
               return -1;
            }
            if(a.lastBless < b.lastBless)
            {
               return 1;
            }
            return 0;
         };
         if(!UIManager.isInit)
         {
            return;
         }
         array.sort(compare);
         while(array.length > 0)
         {
            temp = array.shift();
            isSort = false;
            if(array.length <= 1)
            {
               isSort = true;
            }
            UIManager.zhufuPanel.addInfo(temp,-1,isSort);
         }
         container = UIManager.tipBtnContainer;
         tipViewer = View_ZhuFuATip.instance;
         if(!container.hasItem(tipViewer))
         {
            UIManager.mainUiBtnContainer.addBTN(tipViewer);
         }
      }
      
      public static function GC_BLESS_RESULT(result:int, type:int, name:String, exp:int, id:Number, lv:int) : void
      {
         var str:String = null;
         var arr:Array = [1,2,3,5];
         switch(result)
         {
            case 1:
               str = LangConfig.getWord("23121",2,arr[type].toString(),exp.toString());
               UIManager.zhufuPanel.delInfoByIdLv(id,lv);
               break;
            case 2:
               str = LangConfig.getWord("23122",2);
               break;
            default:
               str = "";
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_BLESS_DEL(id:int, lv:int) : void
      {
         UIManager.zhufuPanel.delInfoByIdLv(id,lv);
      }
      
      public static function GC_FRIEND_MESSAGE_CHANGE(patch:IDataInput) : void
      {
         var o:Object = null;
         var fi:Child_FriendItem = null;
         if(!UIManager.isInit)
         {
            return;
         }
         var id:Number = LongUtil.readLong(patch);
         var msgType:int = patch.readByte();
         switch(msgType)
         {
            case 1:
               o = patch.readShort();
               break;
            case 2:
               o = patch.readInt();
               break;
            case 3:
               o = patch.readInt();
               break;
            case 4:
               o = patch.readUTF();
               break;
            case 5:
               o = patch.readUTF();
               break;
            case 6:
               o = patch.readUTF();
               break;
            case 7:
               o = patch.readByte();
         }
         Model_Friends.updateInfoById(msgType,id,o);
         for each(fi in Model_Friends.viewItemVecArr[0])
         {
            fi.updataQinMi();
         }
         for each(fi in Model_Friends.viewItemVecArr[Model_Friends.CROSS_FRIEND])
         {
            fi.updataQinMi();
         }
         Model_Friends.refresh();
         UIManager.friendPanel.bubbleSort(0);
         UIManager.friendPanel.resetAllPosition();
      }
      
      public static function GC_JOINFRIENDS(data:Array) : void
      {
         UIManager.joinFriendsPanel.update(data);
      }
      
      public static function GC_JOINFRIENDS_ALL(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23125",2));
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23126",2));
         }
      }
      
      public static function GC_INVITE_INFO(arr:Array, num:int) : void
      {
         var i:int = 0;
         while(i < arr.length)
         {
            UIManager.inviteReward.setStateAtIndex(i,arr[i]);
            i += 1;
         }
         UIManager.inviteReward.inviteNum = num;
      }
      
      public static function GC_GET_INVITE_REWARD(index:int) : void
      {
         UIManager.inviteReward.setStateAtIndex(index - 1,3);
         UIManager.inviteReward.showBezAt(index - 1);
      }
      
      public static function GC_FRIEND_CHONGZHI(array:Array) : void
      {
      }
      
      public static function GC_FRIENDS_INVITED_INTERFACE(array:Array) : void
      {
         var i:int = 0;
         while(i < array.length)
         {
            UIManager.inviteReward.setStateAtIndex(i,array[i]);
            i++;
         }
         UIManager.inviteReward.checkPlayEff();
      }
      
      public static function GC_GET_FRIENDS_INVITED(index:int, status:int) : void
      {
         var pnl:View_inviteReward = UIManager.inviteReward;
         if(pnl.visible)
         {
            pnl.setStateAtIndex(index,status);
            if(status == -1)
            {
               pnl.showBezAt(index);
            }
         }
         pnl.checkPlayEff();
      }
      
      public static function GC_FRIENDS_ICON() : void
      {
         UIManager.special_btn.joinIconEff(true);
      }
      
      public static function GC_SEND_FLOWER() : void
      {
      }
      
      public static function GC_GET_FLOWER(data:Object) : void
      {
         var pnl:View_ReceiveWindows = null;
         if(Boolean(data))
         {
            if(data.hasOwnProperty("nm") && data.hasOwnProperty("flowerNum"))
            {
               if(data.nm == "1")
               {
                  pnl = Pool.getObject(View_ReceiveWindows);
                  pnl.restart(data);
                  pnl.visible = true;
               }
               else
               {
                  UIManager.selfBroadcast.addMsg("您的魅力真大，有匿名者赠送给您" + data.flowerNum.toString() + "朵鲜花");
               }
            }
         }
      }
      
      public static function GC_FlOWER_BROADCAST(data:Object) : void
      {
         var senderName:String = null;
         var ss:String = null;
         if(!data)
         {
            return;
         }
         var getterName:String = data.getterName;
         if(data.nm == "2")
         {
            senderName = LangConfig.getWord("29264",2) + data.quhao;
         }
         else
         {
            senderName = data.senderName;
         }
         var num:int = int(data.flowerNum);
         var message:String = LangConfig.getWord("29262",2).replace("%getter",getterName).replace("%sender",senderName).replace("%num",num);
         var message2:String = LangConfig.getWord("29263",2).replace("%getter",getterName).replace("%sender",senderName).replace("%num",num);
         UIManager.triggleBroadcast.addMsg(message2);
         if(data.iskuafu == 0)
         {
            UIManager.chatPanel.addMessage(7,message,"",0,0,0,0);
         }
         else if(data.iskuafu == 1)
         {
            ss = "<font color=\'#FF0000\'> 跨服:   </font><font color = \'#00FF00\'>" + getterName + "</font>收到了<font color = \'#00FF00\'>" + senderName + "</font>赠送的<font color = \'#FF0000\'>" + num + "</font>朵鲜花，魅力实在太大了。</font>";
            UIManager.chatPanel.add(ss,0,8);
            if(num > 1)
            {
               UIManager.chatPanel.addMessage(7,message,"",0,0,0,0);
            }
         }
      }
      
      public static function effHd() : void
      {
         Effect_flower.addFlower();
      }
      
      public static function GC_ADD_FRIEND_SERV(roleID:Number, roleName:String) : void
      {
         if(!UIManager.isInit)
         {
            return;
         }
         if(Model_Friends.hasFriendQuest(roleID) == false)
         {
            Model_Friends.addFriendQuest(roleID,roleName,1);
         }
         Model_Friends.hasNewQuest = true;
         var tipCtnIns:View_TipBtnContainer = UIManager.tipBtnContainer;
         var tipIns:View_AddFriendTip = View_AddFriendTip.getInstance();
         if(!tipCtnIns.hasItem(tipIns))
         {
            tipCtnIns.addItem(tipIns);
         }
      }
      
      public static function GC_ACCEPT_FRIEND(result:int) : void
      {
      }
      
      public static function GC_CROSS_TIP(result:int, senderName:String, targetName:String) : void
      {
         var rep:String = null;
         if(result == 1)
         {
            rep = "添加失败，{1}与你为同一服务器";
         }
         else if(result == 2)
         {
            rep = "添加失败，不存在角色名为{1}的玩家";
         }
         else if(result == 3)
         {
            rep = "添加失败，您在{1}的黑名单内";
         }
         else if(result == 4)
         {
            rep = "添加失败，{1}与你为同一服务器";
         }
         else if(result == 5)
         {
            rep = "请按照正确的格式输入";
         }
         if(rep != null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.reTxt(rep,senderName,targetName));
         }
      }
   }
}

