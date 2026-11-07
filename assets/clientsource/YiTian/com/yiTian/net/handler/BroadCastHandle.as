package com.yiTian.net.handler
{
   import com.utils.ColorConstant;
   import com.utils.LongUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.Enum_lib_reward;
   import com.yiTian.data.config.Enum_TianmingJJ;
   import com.yiTian.data.config.Enum_xingZuo;
   import com.yiTian.data.config.valuable.Enum_lib_equip;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.WulinDaHui.Model_wuLin;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.banhui.model_bang.Model_plant;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.firework.Enum_Firework;
   import com.yiTian.view.modules.firework.FireworkPanel;
   import com.yiTian.view.modules.horse.HorseUtil;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanBubblePanel;
   import com.yiTian.view.modules.keJu.Keju_XSBtn;
   import com.yiTian.view.modules.worldBoss.Model_WorldBoss;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BroadCastHandle
   {
      
      private static var txtLib:Array = ["power","att","def","hp","mp"];
      
      public function BroadCastHandle()
      {
         super();
      }
      
      public static function GC_BROADCAST(msgId:int, patch:IDataInput) : void
      {
         var dataArr:Array;
         var bct:Enum_BroadCastTool;
         var str:String = null;
         var content:String = null;
         var links:String = null;
         var result:int = 0;
         var type:int = 0;
         var roleName:String = null;
         var count:int = 0;
         var role_name:String = null;
         var role_id:Number = NaN;
         var namelength:int = 0;
         var namekg:String = null;
         var i:int = 0;
         var _str:String = null;
         var useName:String = null;
         var role_name1:String = null;
         var index:int = 0;
         var bytes:ByteArray = null;
         var xzID:int = 0;
         var xzStr:String = null;
         if(Global.sceneMap == 14401 && msgId != 20132)
         {
            return;
         }
         if(msgId == 30001)
         {
            content = patch.readUTF();
            links = patch.readUTF();
            if(links != "")
            {
               content = HtmlUtil.link(content,links);
            }
            UIManager.systemBroadcast.addMsg(content);
            return;
         }
         if(msgId == 20132)
         {
            result = patch.readByte();
            if(result == 1)
            {
               UIManager.actBroadcast.addMsg(HtmlUtil.fontNoSize("跨服赛龙舟活动马上开始了，帮会的大侠们赶紧组织起来准备比赛","#ffff00"));
            }
            else if(result == 2)
            {
               UIManager.actBroadcast.addMsg("跨服龙舟赛结束了，大侠们下次继续努力");
            }
            return;
         }
         dataArr = Data_lib.broadCast[msgId];
         if(Boolean(dataArr) && Boolean(dataArr.length))
         {
            type = int(dataArr[0]);
         }
         bct = Enum_BroadCastTool.instance;
         switch(type)
         {
            case 1:
               str = bct.replaceColor(bct.patchToStr(msgId,patch));
               UIManager.actBroadcast.addMsg(str);
               break;
            case 2:
               if(msgId == 20032)
               {
                  roleName = Model_heFu.repNameByHero(patch.readUTF());
                  count = patch.readShort();
                  if(count < 50)
                  {
                     str = LangConfig.getWord("991",0,roleName,HtmlUtil.font(count.toString(),"#fe0000",18));
                  }
                  else
                  {
                     str = LangConfig.getWord("992",0,roleName,HtmlUtil.font(count.toString(),"#fe0000",18));
                  }
               }
               else
               {
                  if(msgId == 20033)
                  {
                     role_name = patch.readUTF();
                     role_name = Model_heFu.repNameByHero(role_name);
                     role_id = LongUtil.readLong(patch);
                     namelength = role_name.length;
                     namekg = "            ";
                     i = 0;
                     while(i < 6 - namelength)
                     {
                        namekg += "  ";
                        i++;
                     }
                     _str = HtmlUtil.font("      ★--★--★--★--★--★--★--★--★--★","#ff0000") + "\n" + namekg + "竞技霸主" + HtmlUtil.link(HtmlUtil.font(HtmlUtil.underLine(role_name),"#3888e9"),"jingjichang") + "驾到" + "\n" + HtmlUtil.font("      ★--★--★--★--★--★--★--★--★--★","#ff0000");
                     UIManager.chatPanel.add(_str,role_id,0,role_name);
                     break;
                  }
                  if(msgId == 20034)
                  {
                     str = specialHandle(patch);
                  }
                  else if(msgId == 20052)
                  {
                     str = airingGift(patch);
                  }
                  else if(msgId == 20066)
                  {
                     str = LangConfig.getWord("30124",3);
                  }
                  else if(msgId == 20119)
                  {
                     str = Enum_TianmingJJ.getBroad(1,patch.readUTF());
                  }
                  else if(msgId == 20120)
                  {
                     str = Enum_TianmingJJ.getBroad(2,patch.readUTF(),patch.readUTF());
                  }
                  else if(msgId == 20124)
                  {
                     useName = patch.readUTF();
                     str = Enum_Firework.getBroad(useName,patch.readByte());
                     Global.delegate.dosomething(FireworkPanel.instance,function():void
                     {
                        FireworkPanel.instance.show(useName);
                     });
                  }
                  else if(msgId == 20131)
                  {
                     role_name1 = patch.readUTF();
                     index = patch.readByte();
                     str = "<font color=\'#04ff00\'>恭喜玩家<font color=\'#ffff00\'>" + role_name1 + "</font>进行了<font color=\'#ffff00\'>" + Data_lib.zhutizhou[index][0] + "</font>活动获得了巨多的奖励！我也要奖励</font>";
                  }
                  else
                  {
                     str = bct.replaceColor(bct.patchToStr(msgId,patch));
                  }
               }
               UIManager.triggleBroadcast.addMsg(str);
               break;
            default:
               str = LangConfig.getWord("621",0) + msgId.toString() + ",type:" + type.toString();
               UIManager.triggleBroadcast.addMsg(str);
         }
         switch(msgId)
         {
            case 10002:
               Model_actDaily.getInstance().diaoyu(true);
               Model_actDaily.getInstance().updateAct(1,true);
               UIManager.smallMap.addTip(0);
               break;
            case 10004:
               Model_actDaily.getInstance().kunlun(true);
               UIManager.smallMap.addTip(0);
               Model_actDaily.getInstance().updateAct(2,true);
               break;
            case 10005:
               Model_actDaily.getInstance().updateAct(0,true);
               UIManager.smallMap.addTip(0);
               break;
            case 11001:
               Model_actDaily.getInstance().diaoyu(false);
               Model_actDaily.getInstance().updateAct(1,false);
               break;
            case 11003:
               Model_actDaily.getInstance().updateAct(2,false);
               Model_actDaily.getInstance().kunlun(false);
               KLMountianHandle.GC_INFO_REFRESH_FLAG(1);
               break;
            case 10006:
               Model_actDaily.getInstance().bangzhan(true);
               Model_actDaily.getInstance().updateAct(3,true);
               UIManager.smallMap.addTip(0);
               break;
            case 10007:
               Model_actDaily.getInstance().updateAct(3,true);
               UIManager.smallMap.addTip(0);
               UIManager.bbRanks.isStart = 1;
               UIManager.bbRanks.updateActTime(1800);
               UIManager.bbRanks.updateKuangTime(180);
               break;
            case 10008:
               Model_actDaily.getInstance().updateAct(4,true);
               UIManager.smallMap.addTip(0);
               Model_wuLin.instance.show_wulin_btn(true);
               break;
            case 11008:
               Model_actDaily.getInstance().updateAct(4,false);
               Model_wuLin.instance.remove_wulin_btn();
               break;
            case 11009:
               GuaJiHandle.GC_5XGUAJITIMEON();
               break;
            case 13006:
               GuaJiHandle.GC_5XGUAJITIMEON(true);
               break;
            case 11007:
               UIManager.bbRanks.isStart = 0;
               Model_actDaily.getInstance().updateAct(3,false);
               Model_actDaily.getInstance().bangzhan(false);
               break;
            case 20021:
               Model_actDaily.getInstance().updateAct(0,false);
               break;
            case 20018:
               if(SceneConfig.getSceneType() == SceneConfig.KUNLUN)
               {
                  UIManager.kunlun_inside.updateTime(-1,300);
               }
               break;
            case 11010:
               Model_plant.instance.show_plant_btn(true);
               Model_actDaily.getInstance().updateAct(7,true);
               UIManager.smallMap.addTip(0);
               break;
            case 11011:
               Model_plant.instance.remove_plant_btn();
               Model_actDaily.getInstance().updateAct(7,false);
               break;
            case 20107:
               Model_plant.instance.remove_plant_btn();
               Model_actDaily.getInstance().updateAct(9,true);
               UIManager.smallMap.addTip(0);
               break;
            case 20111:
               Model_plant.instance.remove_plant_btn();
               Model_actDaily.getInstance().updateAct(9,false);
               UIManager.smallMap.removeTip(0);
               break;
            case 13007:
               Model_actDaily.getInstance().updateAct(10,true);
               UIManager.smallMap.addTip(0);
               break;
            case 13008:
               Model_actDaily.getInstance().updateAct(10,false);
               UIManager.smallMap.removeTip(0);
               Keju_XSBtn.instance.canJoin(false);
               break;
            case 20083:
               Model_WorldBoss.updateRemain(1800 - 1);
               break;
            case 20128:
               bytes = patch as ByteArray;
               if(Boolean(bytes))
               {
                  bytes.position = 4;
                  roleName = bytes.readUTF();
                  xzID = bytes.readInt();
                  xzStr = Data_lib.xingZuo[xzID][Enum_xingZuo.LIB_XZ_NAME];
                  UIManager.chatPanel.addItem(Util.rep(" <font color=\'#aaff77\'>系统</font>   恭喜玩家<font color=\'#55ff55\'>{0}</font>获得<font color=\'#ffff00\'>{1}坐骑</font>，" + HtmlUtil.createLink("<font color=\'#55ff55\'>【我也要坐骑】</font>"),roleName,xzStr),handleChatTextClick,{"chat_type":102},[1]);
               }
         }
      }
      
      public static function handleChatTextClick(... prm) : void
      {
         GameScene.instance.onTextEventLink();
         HorseUtil.openHorsePnl();
      }
      
      private static function airingGift(patch:IDataInput) : String
      {
         var rewardName:String = null;
         var name:String = patch.readUTF();
         var rewardId:int = patch.readInt();
         var arr:Array = Data_lib.rouletteReward[rewardId];
         var id:int = int(arr[Enum_lib_reward.REWARDID]);
         var num:int = int(arr[Enum_lib_reward.REWARDNUM]);
         if(arr[Enum_lib_reward.REWARDTYPE] == 1)
         {
            rewardName = Data_lib.item[id][Enum_lib_item.STR_NAME];
         }
         else
         {
            rewardName = Data_lib.equip[id][Enum_lib_equip.STR_NAME];
         }
         return LangConfig.getWord("30107",3,name,rewardName,num);
      }
      
      private static function specialHandle(patch:IDataInput) : String
      {
         var id:int = 0;
         var temVo:Vo_item = null;
         var s:String = null;
         var roleName:String = patch.readUTF();
         var data:String = patch.readUTF();
         var temArr:Array = data.split("_");
         var i:int = 0;
         var dataStr:String = "";
         var str:String = "";
         while(i < temArr.length)
         {
            id = int(temArr[i].toString());
            temVo = new Vo_item();
            temVo.id = id;
            temVo.Init_lib();
            s = i == temArr.length - 2 ? "" : "、";
            str += HtmlUtil.font(temVo.str_name,Model_shop.get_color_arr[temVo.color - 1],18) + temArr[i + 1] + "个" + s;
            i += 2;
         }
         return LangConfig.getWord("996",0,"<font color=\'#04ff00\'>" + roleName + "</font>",str);
      }
      
      public static function GC_GET_ITEM(objArr:Array) : void
      {
         var arr:Array = null;
         for each(arr in objArr)
         {
            UIManager.selfBroadcast.showGetItemGC(arr);
         }
      }
      
      public static function GC_SB_SHOW(array:Array) : void
      {
         var obj:Object = null;
         for each(obj in array)
         {
            switch(obj.isShow)
            {
               case 1:
                  switch(obj.index)
                  {
                     case 3:
                        UIManager.smallMap.addTip(obj.index,30000);
                        break;
                     default:
                        UIManager.smallMap.addTip(obj.index);
                  }
                  break;
               case 2:
                  UIManager.smallMap.removeTip(obj.index);
            }
         }
      }
      
      public static function GC_LINK_BC(btnType:int, remainTime:int) : void
      {
         switch(btnType)
         {
            case 1:
               Model_actDaily.getInstance().diaoyu(true);
               Model_actDaily.getInstance().updateAct(1,true);
               UIManager.smallMap.addTip(0);
               break;
            case 2:
               Model_actDaily.getInstance().kunlun(true);
               Model_actDaily.getInstance().updateAct(2,true);
               UIManager.smallMap.addTip(0);
               break;
            case 3:
               Model_actDaily.getInstance().bangzhan(true);
               Model_actDaily.getInstance().updateAct(3,true);
               UIManager.smallMap.addTip(0);
         }
      }
      
      public static function HEROABB(arr:Array) : void
      {
         var arr1:Array = null;
         var i:int = 0;
         while(i < 5)
         {
            arr1 = [txtLib[i],arr[i]];
            UIManager.heroBroadcast.addItem(arr1);
            i++;
         }
      }
      
      public static function GC_GENERAL(msgID:int, infos:Array) : void
      {
         var hsbPnl:View_HuaShanBubblePanel = null;
         var mdl:Model_HuaShan = null;
         var oldType:int = 0;
         var result:int = 0;
         var which:int = 0;
         var kuangStr:String = null;
         var rep:String = null;
         var str:String = null;
         var d:Function = null;
         switch(msgID)
         {
            case 10001:
               UIManager.triggleBroadcast.addMsg(LangConfig.getWord("29396",2,Model_heFu.repNameByHero(infos[0]),Model_heFu.repNameByHero(infos[1])));
               break;
            case 10002:
               hsbPnl = Singleton.getInstance(View_HuaShanBubblePanel);
               mdl = Singleton.getInstance(Model_HuaShan);
               mdl.curPlayerInfoArr = HuaShanUtil.getEmptyPlayer();
               mdl.curMatchInfoArr = HuaShanUtil.getEmpthMatchInfo();
               mdl.jie = infos[0];
               if(infos[0] > mdl.countJie)
               {
                  mdl.countJie = infos[0];
               }
               oldType = mdl.bangType2;
               mdl.bangType2 = infos[1];
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(hsbPnl,function():void
               {
                  if(!hsbPnl.visible)
                  {
                     hsbPnl.visible = true;
                     hsbPnl.playLineShp(0);
                  }
                  else
                  {
                     hsbPnl.playLineShp(mdl.bangType2 - oldType,true);
                  }
                  hsbPnl.updateBangType();
                  hsbPnl.updateJie();
                  hsbPnl.updateMatchPlayer();
                  hsbPnl.updateBubbleMathViewer();
                  hsbPnl.uiVisible = false;
               });
               break;
            case 10003:
               result = int(infos[0]);
               which = int(infos[1]);
               kuangStr = HtmlUtil.fontNoSize(LangConfig.getWord((28810 + which).toString(),2),ColorConstant.getColorStr(ColorConstant.YELLOW));
               rep = LangConfig.getWord(result == 1 ? "29404" : "29405",2);
               UIManager.chatPanel.addStr(4,Util.rep(rep,kuangStr));
               break;
            case 10004:
               str = LangConfig.getWord("29406",2,infos[0]);
               d = function():void
               {
                  UIManager.centerBroadcast.addMsg(str,1);
                  Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,d);
               };
               if(Boolean(infos[1]))
               {
                  d();
                  break;
               }
               Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,d);
         }
      }
      
      public static function GC_SERVER_LOG(url:String) : void
      {
         if(!Enum_SPStr.isTencent(Global.pf))
         {
            return;
         }
      }
      
      public static function complete(e:Event) : void
      {
         Utils.print(e.target.data);
      }
      
      public static function error(e:IOErrorEvent) : void
      {
         Utils.print(e);
      }
   }
}

