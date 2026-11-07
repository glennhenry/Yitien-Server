package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.BangHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.banhui.bBindQQGroup.BindPan;
   import com.yiTian.view.modules.qqPackage.QQGroupStaticFunctions;
   import flash.utils.IDataInput;
   
   public class BangGCMessage
   {
      
      private var i_index:int;
      
      private var ii_index:int;
      
      public function BangGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_BANG_SEARCH] = this.GC_BANG_SEARCH;
         index[MessageType.GC_BANG_BUILD] = this.GC_BANG_BUILD;
         index[MessageType.GC_BANG_CHECK] = this.GC_BANG_CHECK;
         index[MessageType.GC_BANG_APPLY_M] = this.GC_BANG_APPLY_M;
         index[MessageType.GC_BANG_APPLY_N] = this.GC_BANG_APPLY_N;
         index[MessageType.GC_BANG_INVIDE_BACK] = this.GC_BANG_INVIDE_BACK;
         index[MessageType.GC_BANG_CHANGED_ANNOUNCEMENT] = this.GC_BANG_CHANGED_ANNOUNCEMENT;
         index[MessageType.GC_BANG_MEMBER_INFO] = this.GC_BANG_MEMBER_INFO;
         index[MessageType.GC_BANG_LEADER_RIGHT] = this.GC_BANG_LEADER_RIGHT;
         index[MessageType.GC_BANG_LEADER_APPOINTMENT] = this.GC_BANG_LEADER_APPOINTMENT;
         index[MessageType.GC_BANG_LEADER_ABDICATION] = this.GC_BANG_LEADER_ABDICATION;
         index[MessageType.GC_BANG_LEADER_EXPEL] = this.GC_BANG_LEADER_EXPEL;
         index[MessageType.GC_BANG_EVENT_CHECK] = this.GC_BANG_EVENT_CHECK;
         index[MessageType.GC_BANG_CHECK_SELF] = this.GC_BANG_CHECK_SELF;
         index[MessageType.GC_BANG_EVENT_INVIDE_O] = this.GC_BANG_EVENT_INVIDE_O;
         index[MessageType.GC_BANG_INFO_SIMPLE] = this.GC_BANG_INFO_SIMPLE;
         index[MessageType.GC_BANG_INVIDE_BACK_N] = this.GC_BANG_INVIDE_BACK_N;
         index[MessageType.GC_BANG_EVENT_INVIDE_M] = this.GC_BANG_EVENT_INVIDE_M;
         index[MessageType.GC_BANG_RIGHT] = this.GC_BANG_RIGHT;
         index[MessageType.GC_BANG_BUILDING_INFO] = this.GC_BANG_BUILDING_INFO;
         index[MessageType.GC_UPDATE_BUILDING] = this.GC_UPDATE_BUILDING;
         index[MessageType.GC_BANGSHOP_INFO] = this.GC_BANGSHOP_INFO;
         index[MessageType.GC_BUY_BANGSHOPITEM] = this.GC_BUY_BANGSHOPITEM;
         index[MessageType.GC_SHAKE_MONEY_TREE] = this.GC_SHAKE_MONEY_TREE;
         index[MessageType.GC_BANG_ZF_INFO] = this.GC_BANG_ZF_INFO;
         index[MessageType.GC_BANG_RESEARCH_ZF] = this.GC_BANG_RESEARCH_ZF;
         index[MessageType.GC_BANG_LEARN_ZF] = this.GC_BANG_LEARN_ZF;
         index[MessageType.GC_BANG_KAICHU] = this.GC_BANG_KAICHU;
         index[MessageType.GC_BANG_MAIN_UI_INFO] = this.GC_BANG_MAIN_UI_INFO;
         index[MessageType.GC_BANG_SELF_INFO] = this.GC_BANG_SELF_INFO;
         index[MessageType.GC_BANG_APPLY_INFO] = this.GC_BANG_APPLY_INFO;
         index[MessageType.GC_MONEYTREEINFO] = this.GC_MONEYTREEINFO;
         index[MessageType.GC_BANG_ENTER_PLANT] = this.GC_BANG_ENTER_PLANT;
         index[MessageType.GC_BANG_PLANT_CHUCHONG] = this.GC_BANG_PLANT_CHUCHONG;
         index[MessageType.GC_BANG_PLANT_CAIJI] = this.GC_BANG_PLANT_CAIJI;
         index[MessageType.GC_SHOW_PLANT_ICON] = this.GC_SHOW_PLANT_ICON;
         index[MessageType.GC_BANG_TIPS_INT_OUT] = this.GC_BANG_TIPS_INT_OUT;
         index[MessageType.GC_PLANT_TIPS] = this.GC_PLANT_TIPS;
         index[MessageType.GC_BANG_APPLY_EFF] = this.GC_BANG_APPLY_EFF;
         index[MessageType.GC_BANG_SHAKE_TREE] = this.GC_BANG_SHAKE_TREE;
         index[MessageType.GC_JIANGHU_INVITE] = this.GC_JIANGHU_INVITE;
         index[MessageType.GC_PARTY_TYPE] = this.GC_PARTY_TYPE;
         index[MessageType.GC_ASK_HANDLE_QQGROUP] = this.GC_ASK_HANDLE_QQGROUP;
         index[MessageType.GC_ASK_IN_QQGROUP] = this.GC_ASK_IN_QQGROUP;
         index[MessageType.GC_BANG_JIEBANG_QQGROUP] = this.GC_BANG_JIEBANG_QQGROUP;
      }
      
      public function GC_BANG_SEARCH(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var result:int = patch.readByte();
         if(result != 1)
         {
            BangHandle.GC_BANG_SEARCH_FAIL(result);
            return;
         }
         var type:int = patch.readByte();
         var partyName:String = patch.readUTF();
         var leaderName:String = patch.readUTF();
         leaderName = Model_heFu.repNameByHero(leaderName);
         var cur_page:int = patch.readShort();
         var total_page:int = patch.readShort();
         var size:int = patch.readByte();
         var dataArr:Array = [];
         this.i_index = 0;
         while(this.i_index < size)
         {
            temArr = [];
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readShort());
            temArr.push(patch.readUTF());
            temArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            temArr.push(patch.readByte());
            temArr.push(patch.readShort());
            temArr.push(patch.readShort());
            dataArr.push(temArr);
            ++this.i_index;
         }
         BangHandle.GC_BANG_SEARCH(type,partyName,leaderName,cur_page,total_page,size,dataArr);
      }
      
      public function GC_BANG_BUILD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_BANG_BUILD(result);
      }
      
      public function GC_BANG_CHECK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(!result)
         {
            return;
         }
         var partyId:Number = LongUtil.readLong(patch);
         var partyName:String = patch.readUTF();
         var leaderName:String = patch.readUTF();
         leaderName = Model_heFu.repNameByHero(leaderName);
         var partyLvl:int = patch.readByte();
         var partyMenNum:int = patch.readShort();
         var partyMemNumLimit:int = patch.readShort();
         var fortune:int = patch.readInt();
         var declaration:String = patch.readUTF();
         BangHandle.GC_BANG_CHECK(partyId,partyName,leaderName,partyLvl,partyMenNum,partyMemNumLimit,fortune,declaration);
      }
      
      public function GC_BANG_APPLY_M(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_BANG_APPLY_M(result);
      }
      
      public function GC_BANG_APPLY_N(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_BANG_APPLY_N(result);
      }
      
      public function GC_BANG_INVIDE_BACK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var invideName:String = patch.readUTF();
         BangHandle.GC_BANG_INVIDE_BACK(result,invideName);
      }
      
      public function GC_BANG_INVIDE_BACK_N(patch:IDataInput) : void
      {
         var partyId:Number = LongUtil.readLong(patch);
         var partyName:String = patch.readUTF();
         var invide_hero_id:Number = LongUtil.readLong(patch);
         BangHandle.GC_BANG_INVIDE_BACK_N(partyId,partyName,invide_hero_id);
      }
      
      public function GC_BANG_EVENT_INVIDE_M(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var party_name:String = patch.readUTF();
         BangHandle.GC_BANG_EVENT_INVIDE_M(result,party_name);
      }
      
      public function GC_BANG_CHECK_SELF(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var result:int = patch.readByte();
         if(!result)
         {
            return;
         }
         var party_arr:Array = [];
         var partyType:int = patch.readByte();
         party_arr.push(LongUtil.readLong(patch));
         party_arr.push(patch.readUTF());
         party_arr.push(Model_heFu.repNameByHero(patch.readUTF()));
         party_arr.push(patch.readByte());
         party_arr.push(patch.readShort());
         party_arr.push(patch.readShort());
         party_arr.push(patch.readShort());
         party_arr.push(patch.readInt());
         party_arr.push(patch.readUTF());
         party_arr.push(patch.readUTF());
         party_arr.push(patch.readUTF());
         party_arr.push(patch.readUTF());
         party_arr.push(patch.readInt());
         party_arr.push(patch.readByte());
         party_arr.push(patch.readInt());
         party_arr.push(patch.readInt());
         party_arr.push(patch.readInt());
         party_arr.push(patch.readShort());
         var size:int = patch.readInt();
         var apllyItem_arr:Array = [];
         this.i_index = 0;
         while(this.i_index < size)
         {
            temArr = [];
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readUTF());
            temArr.push(patch.readShort());
            temArr.push(patch.readByte());
            apllyItem_arr.push(temArr);
            ++this.i_index;
         }
         var isBind:int = patch.readByte();
         Model_bang.isBindQQGroup = isBind;
         BangHandle.GC_BANG_CHECK_SELF(party_arr,apllyItem_arr,partyType);
      }
      
      public function GC_BANG_MAIN_UI_INFO(patch:IDataInput) : void
      {
         var party_arr:Array = [];
         party_arr.push(LongUtil.readLong(patch));
         party_arr.push(patch.readUTF());
         party_arr.push(Model_heFu.repNameByHero(patch.readUTF()));
         party_arr.push(patch.readByte());
         party_arr.push(patch.readShort());
         party_arr.push(patch.readShort());
         party_arr.push(patch.readShort());
         party_arr.push(patch.readInt());
         party_arr.push(patch.readUTF());
         party_arr.push(patch.readUTF());
         party_arr.push(patch.readUTF());
         party_arr.push(patch.readUTF());
         party_arr.push(patch.readInt());
         BangHandle.GC_BANG_MAIN_UI_INFO(party_arr);
      }
      
      public function GC_BANG_SELF_INFO(patch:IDataInput) : void
      {
         var party_arr:Array = [];
         party_arr.push(patch.readByte());
         party_arr.push(patch.readInt());
         party_arr.push(patch.readInt());
         party_arr.push(patch.readInt());
         BangHandle.GC_BANG_SELF_INFO(party_arr);
      }
      
      public function GC_BANG_APPLY_INFO(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var size:int = patch.readInt();
         var apllyItem_arr:Array = [];
         this.i_index = 0;
         while(this.i_index < size)
         {
            temArr = [];
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readUTF());
            temArr.push(patch.readShort());
            temArr.push(patch.readByte());
            apllyItem_arr.push(temArr);
            ++this.i_index;
         }
         BangHandle.GC_BANG_APPLY_INFO(apllyItem_arr);
      }
      
      public function GC_BANG_EVENT_INVIDE_O(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var size:int = patch.readInt();
         var apllyItem_arr:Array = [];
         this.i_index = 0;
         while(this.i_index < size)
         {
            temArr = [];
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readUTF());
            temArr.push(patch.readShort());
            temArr.push(patch.readByte());
            apllyItem_arr.push(temArr);
            ++this.i_index;
         }
         BangHandle.GC_BANG_EVENT_INVIDE_O(apllyItem_arr);
      }
      
      public function GC_BANG_CHANGED_ANNOUNCEMENT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_BANG_CHANGED_ANNOUNCEMENT(result);
      }
      
      public function GC_BANG_RIGHT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_BANG_RIGHT(result);
      }
      
      public function GC_BANG_MEMBER_INFO(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var result:int = patch.readByte();
         if(!result)
         {
            return;
         }
         var cur_page:int = patch.readShort();
         var total_page:int = patch.readShort();
         var size:int = patch.readByte();
         var party_mem_arr:Array = [];
         this.i_index = 0;
         while(this.i_index < size)
         {
            temArr = [];
            temArr.push(LongUtil.readLong(patch));
            temArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            temArr.push(patch.readByte());
            temArr.push(patch.readByte());
            temArr.push(patch.readShort());
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            party_mem_arr.push(temArr);
            ++this.i_index;
         }
         BangHandle.GC_BANG_MEMBER_INFO(cur_page,total_page,size,party_mem_arr);
      }
      
      public function GC_BANG_LEADER_RIGHT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_BANG_LEADER_RIGHT(result);
      }
      
      public function GC_BANG_KAICHU(patch:IDataInput) : void
      {
         BangHandle.GC_BANG_KAICHU();
      }
      
      public function GC_BANG_LEADER_APPOINTMENT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_BANG_LEADER_APPOINTMENT(result);
      }
      
      public function GC_BANG_LEADER_ABDICATION(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_BANG_LEADER_ABDICATION(result);
      }
      
      public function GC_BANG_LEADER_EXPEL(patch:IDataInput) : void
      {
         var rs:int = patch.readByte();
         BangHandle.GC_BANG_LEADER_EXPEL(rs);
      }
      
      public function GC_BANG_EVENT_CHECK(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var rs:int = patch.readByte();
         if(!rs)
         {
            return;
         }
         var cur_page:int = patch.readShort();
         var total_page:int = patch.readShort();
         var size:int = patch.readByte();
         var event_Arr:Array = [];
         this.i_index = 0;
         while(this.i_index < size)
         {
            temArr = [];
            temArr.push(patch.readUTF());
            temArr.push(patch.readInt());
            event_Arr.push(temArr);
            ++this.i_index;
         }
         BangHandle.GC_BANG_EVENT_CHECK(cur_page,total_page,size,event_Arr);
      }
      
      public function GC_BANG_INFO_SIMPLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var contribute:int = patch.readInt();
         var contributeCount:int = patch.readInt();
         var forturn:int = patch.readInt();
         BangHandle.GC_BANG_INFO_SIMPLE(forturn,contribute,contributeCount);
      }
      
      public function GC_BANG_BUILDING_INFO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var levelArr:Array = new Array();
         var index:int = 0;
         while(index < 5)
         {
            levelArr.push(patch.readByte());
            index++;
         }
         var moneyTreeShakeTimes:int = patch.readByte();
         var moneyTreeShakeTimes15:int = patch.readByte();
         var treeSelfCD:int = patch.readInt();
         var treeGlobalCD:int = patch.readInt();
         BangHandle.GC_BANG_BUILDING_INFO(result,levelArr,moneyTreeShakeTimes,moneyTreeShakeTimes15,treeSelfCD,treeGlobalCD);
      }
      
      public function GC_UPDATE_BUILDING(patch:IDataInput) : void
      {
         var updateResult:int = patch.readByte();
         var buildingType:int = patch.readByte();
         var level:int = patch.readByte();
         BangHandle.GC_UPDATE_BUILDING(updateResult,buildingType,level);
      }
      
      public function GC_BANGSHOP_INFO(patch:IDataInput) : void
      {
         var obj:Object = null;
         var result:int = patch.readByte();
         var length:int = patch.readByte();
         var array:Array = new Array();
         var index:int = 0;
         while(index < length)
         {
            obj = new Object();
            obj.gridId = patch.readInt();
            obj.itemId = patch.readInt();
            obj.itemType = patch.readByte();
            obj.itemSellCount = patch.readInt();
            obj.itemPrice = patch.readInt();
            array.push(obj);
            index++;
         }
         BangHandle.GC_BANGSHOP_INFO(result,array);
      }
      
      public function GC_BUY_BANGSHOPITEM(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var gridId:int = patch.readInt();
         var itemId:int = patch.readInt();
         var count:int = patch.readInt();
         BangHandle.GC_BUY_BANGSHOPITEM(result,gridId,itemId,count);
      }
      
      public function GC_SHAKE_MONEY_TREE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var moneyTreeShakeTimes:int = patch.readByte();
         var moneyTreeShakeTimes15:int = patch.readByte();
         var treeSelfCD:int = patch.readInt();
         var treeGlobalCD:int = patch.readInt();
         BangHandle.GC_SHAKE_MONEY_TREE(result,moneyTreeShakeTimes,moneyTreeShakeTimes15,treeSelfCD,treeGlobalCD);
      }
      
      public function GC_BANG_ZF_INFO(patch:IDataInput) : void
      {
         var zfType:int = 0;
         var level:int = 0;
         var type:int = 0;
         var blevel:int = 0;
         var result:int = patch.readByte();
         var mainTownLv:int = patch.readByte();
         var length1:int = patch.readByte();
         var selfArr:Array = new Array();
         var index1:int = 0;
         while(index1 < length1)
         {
            zfType = patch.readByte();
            level = patch.readByte();
            selfArr.push([zfType,level]);
            index1++;
         }
         var length2:int = patch.readByte();
         var bangArr:Array = new Array();
         var index2:int = 0;
         while(index2 < length2)
         {
            type = patch.readByte();
            blevel = patch.readByte();
            bangArr.push([type,blevel]);
            index2++;
         }
         BangHandle.GC_BANG_ZF_INFO(result,mainTownLv,selfArr,bangArr);
      }
      
      public function GC_BANG_RESEARCH_ZF(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var zfType:int = patch.readByte();
         var level:int = patch.readByte();
         BangHandle.GC_BANG_RESEARCH_ZF(result,zfType,level);
      }
      
      public function GC_BANG_LEARN_ZF(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var zfType:int = patch.readByte();
         var level:int = patch.readByte();
         BangHandle.GC_BANG_LEARN_ZF(result,zfType,level);
      }
      
      public function GC_MONEYTREEINFO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var count:int = patch.readShort();
         var lv:int = patch.readByte();
         var treeCD15:int = patch.readInt();
         BangHandle.GC_MONEYTREEINFO(count,lv,treeCD15);
      }
      
      public function GC_BANG_ENTER_PLANT(patch:IDataInput) : void
      {
         var arr:Array = null;
         var len:int = patch.readShort();
         var dataArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            arr = [];
            arr.push(patch.readInt());
            arr.push(patch.readByte());
            dataArr.push(arr);
            i++;
         }
         BangHandle.GC_BANG_ENTER_PLANT(dataArr);
      }
      
      public function GC_BANG_PLANT_CHUCHONG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_BANG_PLANT_CHUCHONG(result);
      }
      
      public function GC_BANG_PLANT_CAIJI(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_BANG_PLANT_CAIJI(result);
      }
      
      public function GC_SHOW_PLANT_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_SHOW_PLANT_ICON(result);
      }
      
      public function GC_PLANT_TIPS(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangHandle.GC_PLANT_TIPS(result);
      }
      
      public function GC_BANG_TIPS_INT_OUT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var roleId:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         roleName = Model_heFu.repNameByHero(roleName);
         BangHandle.GC_BANG_TIPS_INT_OUT(result,roleId,roleName);
      }
      
      public function GC_BANG_APPLY_EFF(patch:IDataInput) : void
      {
         var result:int = Boolean(patch.bytesAvailable) ? patch.readByte() : 1;
         BangHandle.GC_BANG_APPLY_EFF(result);
      }
      
      public function GC_BANG_SHAKE_TREE(patch:IDataInput) : void
      {
         var name:String = patch.readUTF();
         UIManager.chatPanel.addBangMess(3,0,name);
      }
      
      public function GC_JIANGHU_INVITE(patch:IDataInput) : void
      {
         var partyName:String = patch.readUTF();
         var partyID:Number = LongUtil.readLong(patch);
         BangHandle.GC_JIANGHU_INVITE(partyName,partyID);
      }
      
      public function GC_PARTY_TYPE(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         BangHandle.GC_PARTY_TYPE(type);
      }
      
      public function GC_ASK_HANDLE_QQGROUP(patch:IDataInput) : void
      {
         var type:int = 0;
         var yaoQing:int = 0;
         var QQGroup:String = null;
         type = patch.readByte();
         yaoQing = patch.readByte();
         QQGroup = patch.readUTF();
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(BindPan.instance,function():void
         {
            BindPan.instance.show(type,yaoQing,QQGroup);
         });
      }
      
      public function GC_ASK_IN_QQGROUP(patch:IDataInput) : void
      {
         var openId:String = null;
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            openId = patch.readUTF();
            Model_bang.banghuiMemberOpenID.push(openId);
            i++;
         }
         Utils.print(Model_bang.banghuiMemberOpenID,Model_bang.bangQQGroupUnionId,Model_bang.bangQQGroupOpenId);
         QQGroupStaticFunctions.inviteToAddGroup(Model_bang.banghuiMemberOpenID,Model_bang.bangQQGroupUnionId,Model_bang.bangQQGroupOpenId);
      }
      
      public function GC_BANG_JIEBANG_QQGROUP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("解绑不成功");
         }
         else if(result == 1)
         {
            View_Alert.show("成功解绑QQ群",View_Alert.OK,function():void
            {
               BangCGMessage.CG_BANG_CHANGED_ANNOUNCEMENT(2,Model_bang.bangHuiID,"帮会QQ群");
               BangCGMessage.CG_BANG_PAGE_SEARCH(1,"","",1);
               BangCGMessage.CG_ASK_HANDLE_QQGROUP();
            });
         }
      }
   }
}

