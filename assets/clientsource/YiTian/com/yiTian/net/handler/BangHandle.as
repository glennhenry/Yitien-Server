package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.model.Model_npc;
   import com.yiTian.data.vo.Vo_bangMem;
   import com.yiTian.data.vo.Vo_banghuiList;
   import com.yiTian.data.vo.Vo_partyInfo;
   import com.yiTian.data.vo.Vo_party_apply_list;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.actions.huoYueDu.HuoYueMter;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.banhui.BangMap;
   import com.yiTian.view.modules.banhui.View_bangJoin;
   import com.yiTian.view.modules.banhui.View_bangList;
   import com.yiTian.view.modules.banhui.model_bang.Model_plant;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class BangHandle
   {
      
      public function BangHandle()
      {
         super();
      }
      
      public static function GC_BANG_SEARCH(type:int, partyName:String, leaderName:String, cur_page:int, total_page:int, size:int, dataArr:Array) : void
      {
         var temItem:Vo_banghuiList = null;
         var bangList:View_bangList = null;
         Model_bang.bang_search_type = type;
         Model_bang.bang_search_condition_first = partyName;
         Model_bang.bang_search_condition_second = leaderName;
         var temArr:Array = [];
         var i:int = 0;
         while(i < size)
         {
            temItem = new Vo_banghuiList();
            temItem.init_bang_list(dataArr[i]);
            temArr.push(temItem);
            i++;
         }
         if(!GameUnitManager.hero.partyId)
         {
            bangList = UIManager.bangList;
            if(!bangList.visible)
            {
               bangList.visible = true;
            }
            bangList.BangName_text.text = bangList.DEFAULTTEXT1;
            bangList.BZName_text.text = bangList.DEFAULTTEXT2;
            bangList._totalPage = total_page;
            bangList.update(temArr,cur_page,total_page,size);
         }
         else if(UIManager.banghuiBack.bangInerList.visible)
         {
            UIManager.banghuiBack.bangInerList.update(temArr,cur_page,total_page,size);
         }
      }
      
      public static function GC_BANG_BUILD(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("558",0) + "</font>");
            if(UIManager.bangList.visible)
            {
               UIManager.bangList.visible = false;
            }
            if(UIManager.bangCreate.visible)
            {
               UIManager.bangCreate.visible = false;
            }
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("559",0) + "</font>");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("560",0) + "</font>");
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("561",0) + "</font>");
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("562",0) + "</font>");
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("8",0) + "</font>");
         }
         Global.control.sendNotification(Enum_MsgType.MSG_BANG_JOIN,1);
      }
      
      public static function GC_BANG_CHECK(partyId:Number, partyName:String, leaderName:String, partyLvl:int, partyMenNum:int, partyMemNumLimit:int, fortune:int, declaration:String) : void
      {
         if(!UIManager.bang_check.visible)
         {
            UIManager.bang_check.visible = true;
         }
         UIManager.bang_check.update(partyId,partyName,leaderName,partyLvl,partyMenNum,partyMemNumLimit,fortune,declaration);
         UIManager.bang_check.parent.setChildIndex(UIManager.bang_check,UIManager.bang_check.parent.numChildren - 1);
      }
      
      public static function GC_BANG_APPLY_M(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("563",0));
            if(UIManager.bang_check.visible)
            {
               UIManager.bang_check.visible = false;
            }
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("564",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("565",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("560",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("566",0));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("567",0));
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("568",0));
         }
         else if(result == 8)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("569",0));
         }
         else if(result == 9)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30077",3));
         }
      }
      
      public static function GC_BANG_APPLY_N(result:int) : void
      {
         if(result != 1)
         {
            if(result == 2)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("570",0) + "</font>");
            }
            else if(result == 3)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("571",0) + "</font>");
            }
            else if(result == 4)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("572",0) + "</font>");
            }
            else if(result == 6)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30077",3));
            }
         }
      }
      
      public static function GC_BANG_EVENT_INVIDE_O(arr:Array) : void
      {
         var apply_vo:Vo_party_apply_list = null;
         var apply_item_arr:Array = [];
         var i:int = 0;
         while(i < arr.length)
         {
            apply_vo = new Vo_party_apply_list();
            apply_vo.init(arr[i]);
            apply_item_arr.push(apply_vo);
            i++;
         }
         View_bangJoin.dataArr = apply_item_arr;
         if(UIManager.bangJoinList.visible)
         {
            UIManager.bangJoinList.updataTotal();
            UIManager.bangJoinList.updataItem(UIManager.bangJoinList.cur_page);
         }
      }
      
      public static function GC_BANG_MAIN_UI_INFO(data_arr:Array) : void
      {
         UIManager.banghuiBack.bang_info.update_party_ui_info(data_arr);
      }
      
      public static function GC_BANG_SELF_INFO(data_arr:Array) : void
      {
         UIManager.banghuiBack.bang_info.update_self_info(data_arr);
         var info:Vo_partyInfo = Model_bang.partyInfo;
         if(!info)
         {
            return;
         }
         info.party_position = data_arr[0];
         info.party_self_gong = data_arr[1];
         info.party_gong = data_arr[2];
         UIManager.banghuiBack.bang_members.updateByModel();
      }
      
      public static function GC_BANG_APPLY_INFO(arr:Array) : void
      {
         var apply_vo:Vo_party_apply_list = null;
         var apply_item_arr:Array = [];
         var i:int = 0;
         while(i < arr.length)
         {
            apply_vo = new Vo_party_apply_list();
            apply_vo.init(arr[i]);
            apply_item_arr.push(apply_vo);
            i++;
         }
         View_bangJoin.dataArr = apply_item_arr;
         if(UIManager.bangJoinList.visible)
         {
            UIManager.bangJoinList.updataTotal();
            UIManager.bangJoinList.updataItem(UIManager.bangJoinList.cur_page);
         }
      }
      
      public static function GC_BANG_INVIDE_BACK(result:int, invide_name:String) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1134",0));
            if(UIManager.invide_bang.visible)
            {
               UIManager.invide_bang.visible = false;
            }
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("573",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("574",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(invide_name + LangConfig.getWord("564",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("575",0));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("576",0));
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("572",0));
         }
         else if(result != 8)
         {
            if(result == 9)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("577",0));
            }
         }
      }
      
      public static function GC_BANG_INVIDE_BACK_N(partyId:Number, partyName:String, invide_hero_id:Number) : void
      {
         if(!UIManager.bang_prompt.visible)
         {
            UIManager.bang_prompt.visible = true;
         }
         UIManager.bang_prompt.invide_host = partyName;
         UIManager.bang_prompt.partyId = partyId;
         UIManager.bang_prompt.heroId = invide_hero_id;
         UIManager.bang_prompt.updateText(1);
         UIManager.bang_prompt.parent.setChildIndex(UIManager.bang_prompt,UIManager.bang_prompt.parent.numChildren - 1);
      }
      
      public static function GC_BANG_CHECK_SELF(party_arr:Array, apllyItem_arr:Array, partyType:int) : void
      {
         var apply_vo:Vo_party_apply_list = null;
         var vo_party_info:Vo_partyInfo = new Vo_partyInfo();
         vo_party_info.init(party_arr);
         Model_bang.partyInfo = vo_party_info;
         Model_bang.partyType = partyType;
         var apply_item_arr:Array = [];
         var i:int = 0;
         while(i < apllyItem_arr.length)
         {
            apply_vo = new Vo_party_apply_list();
            apply_vo.init(apllyItem_arr[i]);
            apply_item_arr.push(apply_vo);
            i++;
         }
         View_bangJoin.dataArr = apply_item_arr;
         if(UIManager.bangJoinList.visible)
         {
            UIManager.bangJoinList.updataTotal();
            UIManager.bangJoinList.updataItem(UIManager.bangJoinList.cur_page);
         }
         if(!UIManager.banghuiBack.visible)
         {
            UIManager.banghuiBack.visible = true;
         }
         UIManager.banghuiBack.bang_info.update(vo_party_info,apply_item_arr);
         if(Model_bang.partyType == 0)
         {
            if(HuoYueMter.isOpenBangShenShou)
            {
               HuoYueMter.isOpenBangShenShou = false;
               UIManager.banghuiBack.Button_ShenShou.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
         }
      }
      
      public static function GC_BANG_CHANGED_ANNOUNCEMENT(result:int) : void
      {
         if(result == 1)
         {
         }
      }
      
      public static function GC_BANG_RIGHT(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("578",0) + "</font>");
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("579",0) + "</font>");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("580",0) + "</font>");
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("581",0) + "</font>");
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("582",0) + "</font>");
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("583",0) + "</font>");
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("584",0) + "</font>");
            Global.control.sendNotification(Enum_MsgType.MSG_BANG_LEAVE,1);
            if(UIManager.banghuiBack.visible)
            {
               UIManager.banghuiBack.visible = false;
            }
         }
         else if(result == 8)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("585",0) + "</font>");
         }
         else if(result == 9)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("586",0) + "</font>");
         }
         else if(result == 10)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30077",3));
         }
         if(UIManager.bang_prompt.visible)
         {
            UIManager.bang_prompt.visible = false;
         }
      }
      
      public static function GC_BANG_MEMBER_INFO(cur_page:int, total_page:int, size:int, party_mem_arr:Array) : void
      {
         var mem_vo:Vo_bangMem = null;
         var mem_arr:Array = [];
         trace(party_mem_arr);
         var i:int = 0;
         while(i < size)
         {
            mem_vo = new Vo_bangMem();
            mem_vo.init(party_mem_arr[i]);
            mem_arr.push(mem_vo);
            i++;
         }
         if(UIManager.bang_prompt.visible)
         {
            UIManager.bang_prompt.visible = false;
         }
         UIManager.banghuiBack.bang_members.update(cur_page,total_page,size,mem_arr);
      }
      
      public static function GC_BANG_LEADER_RIGHT(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("587",0) + "</font>");
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("588",0) + "</font>");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("589",0) + "</font>");
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("590",0) + "</font>");
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg("跨服帮会战不能禅让");
         }
         if(UIManager.bang_prompt.visible)
         {
            UIManager.bang_prompt.visible = false;
         }
      }
      
      public static function GC_BANG_KAICHU() : void
      {
         UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("591",0) + "</font>");
         Global.control.sendNotification(Enum_MsgType.MSG_BANG_LEAVE,2);
      }
      
      public static function GC_BANG_LEADER_APPOINTMENT(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("592",0) + "</font>");
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("593",0) + "</font>");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("594",0) + "</font>");
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("595",0) + "</font>");
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("596",0) + "</font>");
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg("跨服帮会战不能任命");
         }
      }
      
      public static function GC_BANG_LEADER_ABDICATION(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("597",0) + "</font>");
            UIManager.bang_prompt.visible = false;
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("598",0) + "</font>");
         }
      }
      
      public static function GC_BANG_LEADER_EXPEL(rs:int) : void
      {
         if(rs == 1)
         {
            UIManager.centerBroadcast.addMsg("><font color=\'#f9ff00\'>" + LangConfig.getWord("599",0) + "</font>");
         }
         else if(rs == 2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("600",0) + "</font>");
         }
         else if(rs == 3)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("601",0) + "</font>");
         }
         else if(rs == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("602",0));
         }
         else if(rs == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("603",0));
         }
         else if(rs == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30077",3));
         }
         if(UIManager.bang_prompt.visible)
         {
            UIManager.bang_prompt.visible = false;
         }
      }
      
      public static function GC_BANG_EVENT_CHECK(cur_page:int, total_page:int, size:int, event_Arr:Array) : void
      {
         if(!UIManager.bang_event.visible)
         {
            UIManager.bang_event.visible = true;
         }
         UIManager.bang_event.parent.setChildIndex(UIManager.bang_event,UIManager.bang_event.parent.numChildren - 1);
         UIManager.bang_event.update(cur_page,total_page,size,event_Arr);
      }
      
      public static function GC_BANG_INFO_SIMPLE(forturn:int, contribute:int, contributeCount:int) : void
      {
         var vo_party_info:Vo_partyInfo = Model_bang.partyInfo;
         if(!vo_party_info)
         {
            return;
         }
         vo_party_info.party_forturn = forturn;
         vo_party_info.party_gong = contributeCount;
         vo_party_info.party_self_gong = contribute;
         UIManager.banghuiBack.bang_info.update(vo_party_info,null);
         Model_bang.partyInfo.party_gong = contributeCount;
         Model_bang.partyInfo.party_self_gong = contribute;
         UIManager.banghuiBack.bang_zhanfa.updateByModel();
         UIManager.bang_store.updateGong();
      }
      
      public static function GC_BANG_BUILDING_INFO(result:int, levelArr:Array, moneyTreeShakeTimes:int, moneyTreeShakeTimes15:int, treeSelfCD:int, treeGlobalCD:int) : void
      {
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("604",0));
         }
         Model_bang.bangBuildingLevel = levelArr;
         Model_bang.treeGlobalCD = treeGlobalCD;
         Model_bang.treeSelfCD = treeSelfCD;
         var currentTime:int = getTimer();
         Model_bang.lastTreeGlobalCD = currentTime;
         Model_bang.lastTreeSelfCD = currentTime;
         Model_bang.moneyTreeShakeTimes15 = moneyTreeShakeTimes15;
         var mapInstance:BangMap = UIManager.banghuiBack.bang_map;
         mapInstance.shakeMoneyTreeCount = moneyTreeShakeTimes;
         var length:int = int(levelArr.length);
         var index:int = 0;
         while(index < length)
         {
            mapInstance.updateBuildingLevelInfo(index + 1,levelArr[index]);
            index++;
         }
      }
      
      public static function GC_BANG_EVENT_INVIDE_M(result:int, party_name:String) : void
      {
         if(result != 1)
         {
            if(result == 2)
            {
            }
         }
      }
      
      public static function GC_UPDATE_BUILDING(updateResult:int, buildingType:int, level:int) : void
      {
         var mapInstance:BangMap = null;
         if(updateResult == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("605",0));
            mapInstance = UIManager.banghuiBack.bang_map;
            Model_bang.bangBuildingLevel[buildingType - 1] = level;
            mapInstance.updateBuildingLevelInfo(buildingType,Model_bang.bangBuildingLevel[buildingType - 1]);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("606",0));
            var _loc5_:int = updateResult;
            switch(0)
            {
            }
         }
      }
      
      public static function GC_BANGSHOP_INFO(result:int, array:Array) : void
      {
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("607",0));
         }
         Model_bang.bangShopSellItemArr = array;
         sort(array);
         UIManager.bang_store.updateByModel(1);
      }
      
      private static function sort(array:Array) : void
      {
         var i:int = 0;
         var j:int = 0;
         var temp:Object = null;
         var id1:int = 0;
         var id2:int = 0;
         var typei:int = 0;
         var typej:int = 0;
         var dlb:Dictionary = Data_lib.item;
         var len:int = int(array.length);
         i = 0;
         while(i < len)
         {
            j = 0;
            while(j < len - 1)
            {
               id1 = int(array[j].itemId);
               id2 = int(array[j + 1].itemId);
               if(id1 > id2)
               {
                  temp = array[j];
                  array[j] = array[j + 1];
                  array[j + 1] = temp;
               }
               j++;
            }
            i++;
         }
         i = 0;
         while(i < len)
         {
            j = 0;
            while(j < len - 1)
            {
               typei = int(dlb[array[j].itemId][2]);
               typej = int(dlb[array[j + 1].itemId][2]);
               if(typei > typej)
               {
                  temp = array[j];
                  array[j] = array[j + 1];
                  array[j + 1] = temp;
               }
               j++;
            }
            i++;
         }
      }
      
      public static function GC_BUY_BANGSHOPITEM(result:int, gridId:int, itemId:int, count:int) : void
      {
         var remainCount:int = 0;
         var str:String = null;
         var obj:Object = null;
         var obj2:Object = null;
         var voArr:Array = Model_bang.bangShopSellItemArr;
         switch(result)
         {
            case 1:
               remainCount = 0;
               for each(obj in voArr)
               {
                  if(obj.gridId == gridId)
                  {
                     remainCount = obj.itemSellCount - count;
                     obj.itemSellCount = count;
                  }
               }
               str = LangConfig.getWord("456",0);
               UIManager.centerBroadcast.addMsg(str);
               break;
            default:
               for each(obj2 in voArr)
               {
                  if(obj2.gridId == gridId)
                  {
                     obj2.itemSellCount = count;
                  }
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("607",0));
         }
         UIManager.bang_store.updateByModel(-1);
      }
      
      public static function GC_SHAKE_MONEY_TREE(result:int, moneyTreeShakeTimes:int, moneyTreeShakeTimes15:int, treeSelfCD:int, treeGlobalCD:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("608",0));
               UIManager.bangMoneyTree.addeffect();
               Model_bang.treeGlobalCD = treeGlobalCD;
               Model_bang.treeSelfCD = treeSelfCD;
               var currentTime:int = getTimer();
               Model_bang.lastTreeGlobalCD = currentTime;
               Model_bang.lastTreeSelfCD = currentTime;
               Model_bang.moneyTreeShakeTimes15 = moneyTreeShakeTimes15;
               UIManager.bangMoneyTree.update(moneyTreeShakeTimes);
               UIManager.bangMoneyTree.updateTimer(treeGlobalCD);
               return;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("609",0));
               return;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("610",0));
               return;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("611",0));
               return;
            default:
               return;
         }
      }
      
      public static function GC_BANG_SEARCH_FAIL(result:int) : void
      {
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("612",0) + "</font>");
         }
      }
      
      public static function GC_BANG_ZF_INFO(result:int, mainTownLv:int, selfZFArr:Array, bangZFArr:Array) : void
      {
         switch(result)
         {
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("613",0));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("614",0));
         }
         Model_bang.bangBuildingLevel[0] = mainTownLv;
         var index:int = 0;
         while(index < bangZFArr.length)
         {
            Model_bang.bangZFLevelArr[bangZFArr[index][0] - 1] = bangZFArr[index][1];
            index++;
         }
         var index2:int = 0;
         while(index2 < selfZFArr.length)
         {
            Model_bang.selfZFLevelArr[selfZFArr[index2][0] - 1] = selfZFArr[index2][1];
            index2++;
         }
         UIManager.banghuiBack.bang_zhanfa.updateByModel();
      }
      
      public static function GC_BANG_RESEARCH_ZF(result:int, zfType:int, level:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("615",0));
               break;
            default:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("616",0));
         }
         var typeIndex:int = zfType - 1;
         Model_bang.bangZFLevelArr[typeIndex] = level;
         UIManager.banghuiBack.bang_zhanfa.updateByModel();
      }
      
      public static function GC_BANG_LEARN_ZF(result:int, zfType:int, level:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("721",0));
               break;
            default:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("722",0));
         }
         var typeIndex:int = zfType - 1;
         Model_bang.selfZFLevelArr[typeIndex] = level;
         UIManager.banghuiBack.bang_zhanfa.updateByModel();
      }
      
      public static function GC_MONEYTREEINFO(count:int, lv:int, treeCD15:int) : void
      {
         Model_bang.moneyTreeShakeTimes15 = int(count / 15);
         Model_bang.bangBuildingLevel[4] = lv;
         UIManager.bangMoneyTree.update(count % 15);
         UIManager.bangMoneyTree.updateTimer(treeCD15);
      }
      
      public static function GC_BANG_ENTER_PLANT(dataArr:Array) : void
      {
         var bangNpc:Npc = null;
         if(SceneConfig.getSceneType() != SceneConfig.BANGPLANT)
         {
            return;
         }
         var i:int = 0;
         while(i < dataArr.length)
         {
            bangNpc = GameUnitManager.findUnit(dataArr[i][0],UnitType.NPC) as Npc;
            if(!bangNpc)
            {
               bangNpc = GameUnitManager.getUnit(UnitType.NPC) as Npc;
            }
            bangNpc.init_bang(dataArr[i][0],dataArr[i][1]);
            GameUnitManager.addUnit(bangNpc);
            i++;
         }
      }
      
      public static function GC_BANG_PLANT_CHUCHONG(result:int) : void
      {
         switch(result)
         {
            case 1:
               if(Boolean(Model_npc._npc))
               {
                  Model_npc._npc.beginCollect(LangConfig.getWord("810",0),1);
               }
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("811",0));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("812",0));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("931",0));
         }
      }
      
      public static function GC_BANG_PLANT_CAIJI(result:int) : void
      {
         switch(result)
         {
            case 1:
               if(Boolean(Model_npc._npc))
               {
                  Model_npc._npc.beginCollect(LangConfig.getWord("813",0),2);
               }
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("814",0));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("815",0));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("932",0));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("952",0));
         }
      }
      
      public static function GC_SHOW_PLANT_ICON(result:int) : void
      {
         if(result == 1)
         {
            Model_plant.instance.show_plant_btn(true);
            Model_actDaily.getInstance().updateAct(7,true);
         }
         else if(result == 2)
         {
            Model_plant.instance.remove_plant_btn();
            Model_actDaily.getInstance().updateAct(7,false);
         }
      }
      
      public static function GC_PLANT_TIPS(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("967",0));
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("968",0));
         }
      }
      
      public static function GC_BANG_TIPS_INT_OUT(result:int, roleId:Number, roleName:String) : void
      {
         UIManager.chatPanel.addBangMess(result,roleId,roleName);
      }
      
      public static function GC_BANG_APPLY_EFF(result:int) : void
      {
      }
      
      public static function GC_JIANGHU_INVITE(partyName:String, partyID:Number) : void
      {
         var msgContent:String = LangConfig.reTxt("<font color=\'#33ff33\'>帮会招募：</font><font color=\'#f9dd00\'>{0}</font>向江湖朋友发出帮派邀请，有意者<font color=\'#ffff00\'>{1}</font>",partyName,HtmlUtil.createLink("【点击申请】",true,"apply"));
         UIManager.chatPanel.addItem(msgContent,jianghuInviteClickHd,{
            "partyID":partyID,
            "chat_type":101
         },[1]);
      }
      
      private static function jianghuInviteClickHd(e:TextEvent, data:*) : void
      {
         GameScene.instance.onTextEventLink();
         if(e.text == "apply")
         {
            BangCGMessage.CG_BANG_CHECK(data.partyID as Number);
         }
      }
      
      public static function GC_PARTY_TYPE(type:int) : void
      {
         Model_bang.partyType = type;
      }
   }
}

