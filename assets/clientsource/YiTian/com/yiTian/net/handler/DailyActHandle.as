package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_DailyACT;
   import com.yiTian.data.config.Enum_ShenMaoTanBao;
   import com.yiTian.data.config.Enum_YueBingShangCheng;
   import com.yiTian.data.model.Model_ShenMaoTanBao;
   import com.yiTian.data.vo.Vo_KFBP;
   import com.yiTian.data.vo.Vo_KFLevel;
   import com.yiTian.data.vo.Vo_KFWL;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.HaiDiXunBao.Enum_HaiDiXunBao;
   import com.yiTian.view.modules.HaiDiXunBao.View_HaiDiXunBao_panel;
   import com.yiTian.view.modules.MiJingCangZong.View_MiJingCangZong_explain;
   import com.yiTian.view.modules.MiJingCangZong.View_MiJingCangZong_menu;
   import com.yiTian.view.modules.ShenMaoTanBao.View_ShenMaoTanBao_menu;
   import com.yiTian.view.modules.YueBingShangCheng.View_YueBingShangCheng;
   import com.yiTian.view.modules.activity.Enum_KF;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.activity.kaifuItem.IBasekf;
   import com.yiTian.view.modules.activity.kaifuItem.KaiFuModuleMgr;
   import com.yiTian.view.modules.activity.kaifuItem.tuangou.AcitivityVo;
   import com.yiTian.view.modules.activity.kaifuItem.tuangou.Child_ShouChongTuanGou;
   import com.yiTian.view.modules.activity.kaifuItem.tuangou.Child_WuHunTuanGou;
   import com.yiTian.view.modules.activityGuide.ActivityGuideVo;
   import com.yiTian.view.modules.activityGuide.Child_ItemWard;
   import com.yiTian.view.modules.activityGuide.Enum_ActivityGuide;
   import com.yiTian.view.modules.activityGuide.Model_ActivityGuide;
   import com.yiTian.view.modules.activityGuide.View_ActivityGuidePanel;
   import flash.utils.Dictionary;
   
   public class DailyActHandle
   {
      
      public function DailyActHandle()
      {
         super();
      }
      
      public static function GC_KFHD_HIGHTLINE(id:int, status:int) : void
      {
         var ids:Array = [0,24,25,23];
         KaiFuModuleMgr.instance.setBtnEffect(ids[id],status);
      }
      
      public static function GC_KFHD_CJ_OPEN(status:String, counts:String) : void
      {
         var vo:Vo_KFLevel = null;
         var arr_status:Array = status.split("_");
         var arr_count:Array = counts.split("_");
         var vec:Vector.<Vo_KFLevel> = new Vector.<Vo_KFLevel>();
         var len:int = int(arr_status.length);
         var i:int = 0;
         while(i < len)
         {
            vo = new Vo_KFLevel();
            vo.index = i + 1;
            vo.remaind = arr_count[i];
            vo.status = arr_status[i];
            vec.push(vo);
            i++;
         }
         Model_actDaily.data_chongji = vec;
         if(Boolean(KaiFuModuleMgr.instance.getView(Enum_DailyACT.CHONGJI)))
         {
            (KaiFuModuleMgr.instance.getView(Enum_DailyACT.CHONGJI) as IBasekf).setdata();
         }
      }
      
      public static function GC_KFHD_CJ_GETAWARD(result:int) : void
      {
         var str:String = result == 0 ? "领取失败！" : "领取成功！";
         UIManager.centerBroadcast.addMsg(str);
         if(Boolean(result) && Boolean(KaiFuModuleMgr.instance.getView(Enum_DailyACT.CHONGJI)))
         {
            (KaiFuModuleMgr.instance.getView(Enum_DailyACT.CHONGJI) as IBasekf).iconFly();
         }
      }
      
      public static function GC_KFHD_BP_OPEN(vec:Vector.<Vo_KFBP>, showPage:int, showTime:String) : void
      {
         Model_actDaily.data_bangpai = vec;
         if(Boolean(KaiFuModuleMgr.instance.getView(Enum_DailyACT.BANGPAI)))
         {
            (KaiFuModuleMgr.instance.getView(Enum_DailyACT.BANGPAI) as IBasekf).setdata(showPage,showTime);
         }
      }
      
      public static function GC_KFHD_BP_GETAWARD(result:int) : void
      {
         var str:String = result == 1 ? "领取成功！" : "领取失败！";
         UIManager.centerBroadcast.addMsg(str);
         if(result == 1 && Boolean(KaiFuModuleMgr.instance.getView(Enum_DailyACT.BANGPAI)))
         {
            (KaiFuModuleMgr.instance.getView(Enum_DailyACT.BANGPAI) as IBasekf).iconFly();
         }
      }
      
      public static function GC_KFHD_WL_OPEN(vec:Vector.<Vo_KFWL>, status:int) : void
      {
         Model_actDaily.data_wulin = vec;
         if(Boolean(KaiFuModuleMgr.instance.getView(Enum_DailyACT.WULIN)))
         {
            (KaiFuModuleMgr.instance.getView(Enum_DailyACT.WULIN) as IBasekf).setdata(status);
         }
      }
      
      public static function GC_KFHD_WL_GETAWARD(result:int) : void
      {
         var str:String = result == 0 ? "领取失败！" : "领取成功！";
         UIManager.centerBroadcast.addMsg(str);
         if(Boolean(result) && Boolean(KaiFuModuleMgr.instance.getView(Enum_DailyACT.WULIN)))
         {
            (KaiFuModuleMgr.instance.getView(Enum_DailyACT.WULIN) as IBasekf).iconFly();
         }
      }
      
      public static function GC_KF_ZLSC_OPEN(type:int, status:String, count:String) : void
      {
         var obj:Object = null;
         var arrS:Array = status.split("_");
         var arrC:Array = count.split("_");
         var arr:Array = [];
         var len:int = int(arrS.length);
         var i:int = 0;
         while(i < len)
         {
            obj = new Object();
            obj.rank = i;
            obj.name = "";
            obj.status = arrS[i];
            obj.reamain = arrC[i];
            arr.push(obj);
            i++;
         }
         if(type == Enum_KF.TYPE_ZL)
         {
            Model_actDaily.kf_zl_data = arr;
            if(UIManager.actKaiFu.visible)
            {
               UIManager.actKaiFu.setInfoId(Enum_KF.ID_ZL);
            }
         }
         else
         {
            Model_actDaily.kf_sc_data = arr;
            if(UIManager.actKaiFu.visible)
            {
               UIManager.actKaiFu.setInfoId(Enum_KF.ID_BB);
            }
         }
      }
      
      public static function GC_KF_ZLSC_GETAWARD(type:int, index:int, reslut:int) : void
      {
         var taskID:int = type == Enum_KF.TYPE_SC ? int(49 + index) : int(44 + index);
         if(reslut == 1)
         {
            UIManager.actKaiFu.showGetAni(taskID);
         }
         else
         {
            addMsg(reslut);
         }
      }
      
      public static function GC_HORSE_GETAWARD(type:int, index:int, reslut:int) : void
      {
         var taskID:int = 39 + index;
         if(reslut == 1)
         {
            UIManager.actKaiFu.showGetAni(taskID);
         }
         else
         {
            addMsg(reslut);
         }
      }
      
      public static function GC_KF_TIPS_HORSE(reslut:int) : void
      {
         var index:int = Model_actDaily.kf_newTipArr.indexOf(Enum_KF.ID_HORSE);
         if(reslut == 1)
         {
            if(index == -1)
            {
               Model_actDaily.kf_newTipArr.push(Enum_KF.ID_HORSE);
            }
            if(UIManager.actKaiFu.visible)
            {
               UIManager.actKaiFu.reset();
               UIManager.actKaiFu.autoChoose();
            }
            else
            {
               UIManager.actKaiFu.setTip(true);
            }
         }
         else if(index != -1)
         {
            Model_actDaily.kf_newTipArr.splice(index,1);
            UIManager.actKaiFu.reset();
         }
      }
      
      public static function GC_KF_TIPS_ZL(reslut:int) : void
      {
         var index:int = Model_actDaily.kf_newTipArr.indexOf(Enum_KF.ID_ZL);
         if(reslut == 1)
         {
            if(index == -1)
            {
               Model_actDaily.kf_newTipArr.push(Enum_KF.ID_ZL);
            }
            if(UIManager.actKaiFu.visible)
            {
               UIManager.actKaiFu.reset();
               UIManager.actKaiFu.autoChoose();
            }
            UIManager.actKaiFu.setTip(true);
         }
         else if(index != -1)
         {
            Model_actDaily.kf_newTipArr.splice(index,1);
            UIManager.actKaiFu.reset();
         }
      }
      
      public static function GC_KF_TIPS_BB(reslut:int) : void
      {
         var index:int = Model_actDaily.kf_newTipArr.indexOf(Enum_KF.ID_BB);
         if(reslut == 1)
         {
            if(index == -1)
            {
               Model_actDaily.kf_newTipArr.push(Enum_KF.ID_BB);
            }
            if(UIManager.actKaiFu.visible)
            {
               UIManager.actKaiFu.reset();
               UIManager.actKaiFu.autoChoose();
            }
            UIManager.actKaiFu.setTip(true);
         }
         else if(index != -1)
         {
            Model_actDaily.kf_newTipArr.splice(index,1);
            UIManager.actKaiFu.reset();
         }
      }
      
      public static function GC_KF_HORSE_OPEN(arr:Array) : void
      {
         Model_actDaily.kf_horse_data = arr;
         if(UIManager.actKaiFu.visible)
         {
            UIManager.actKaiFu.setInfoId(Enum_KF.ID_HORSE);
         }
      }
      
      private static function addMsg(tt:int) : void
      {
         var str:String = null;
         switch(tt)
         {
            case 1:
               str = "活动已结束，无法领取奖励！";
               break;
            case 2:
               str = "不符合条件，无法领取！";
               break;
            case 3:
               str = "已领取过奖励，无法再次领取！";
               break;
            case 4:
               str = "背包已满，已经通过邮件发送！";
               break;
            case 5:
               str = "领取成功！";
               break;
            case 6:
               str = "可领取的名额不足！";
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_DAILYACT(array:Array, zmrTimes:int) : void
      {
         var ins:Model_actDaily = Model_actDaily.getInstance();
         ins.zmrTimes = zmrTimes;
         ins.rcrwArr.setData(array);
      }
      
      public static function GC_DAILYACT_CHANGE() : void
      {
      }
      
      public static function GC_KFHD(kfTime:int, curTime:int, kfDay:int, infos:Array) : void
      {
         var key:String = null;
         var info:Array = null;
         var startDay:int = 0;
         var endDay:int = 0;
         var ins:Model_actDaily = Model_actDaily.getInstance();
         var arr:Array = [];
         var i:int = 0;
         while(i + 1 < infos.length)
         {
            arr[infos[i] - 1] = infos[i + 1];
            i += 2;
         }
         ins.kfhdFinishArr = arr;
         ins.curTime = curTime;
         ins.kfTime = kfTime;
         Model_actDaily.KF_day = kfDay;
         UIManager.actKaiFu.setday(kfDay);
         UIManager.actKaiFu.updateBmBtn();
         if(UIManager.actKaiFu.visible)
         {
            UIManager.actKaiFu.reset();
            UIManager.actKaiFu.autoChoose();
         }
         var infosDic:Dictionary = Data_lib.kfhd;
         for(key in infosDic)
         {
            if(key == "20" || key == "21" || key == "22")
            {
               info = infosDic[key];
               startDay = int(info[1]);
               endDay = int(info[4]);
               if(kfDay >= startDay && kfDay <= endDay || endDay == -1)
               {
                  KaiFuModuleMgr.instance.setState(int(key),1);
               }
            }
         }
      }
      
      public static function GC_NEWERAWARD(data:Array) : void
      {
         var ins:Model_actDaily = Model_actDaily.getInstance();
         ins.speBtnCn = data;
      }
      
      public static function GC_GETKFHDREWARD(result:int, taskID:int) : void
      {
         var ins:Model_actDaily = Model_actDaily.getInstance();
         var infos:Array = ins.kfhdFinishArr;
         if(result == 1)
         {
            infos[taskID - 1] = 2;
         }
         if(UIManager.actKaiFu.visible)
         {
            UIManager.actKaiFu.reset();
            UIManager.actKaiFu.updateCur();
         }
         UIManager.actKaiFu.updateBmBtn();
         UIManager.actKaiFu.showGetAni(taskID);
      }
      
      public static function GC_KFHDSPEC(r1:int, timeStr:String, c1:int, c2:int, c3:int) : void
      {
         if(r1 == 1)
         {
            if(c1 == 1 || c2 == 1 || c3 == 1)
            {
               UIManager.actKaiFu.setTip(true);
            }
            Model_actDaily.getInstance().specObj["13"] = [timeStr,c1,c2,c3];
         }
         else
         {
            delete Model_actDaily.getInstance().specObj["13"];
            UIManager.actKaiFu.updateBmBtn();
         }
      }
      
      public static function GC_GETKFHDREWARDSPEC(result:int, cID:int) : void
      {
         var tmp:Array = [35,36,37];
         Model_actDaily.getInstance().specObj["13"][cID] = 2;
         if(result == 1)
         {
            UIManager.actKaiFu.showGetAni(tmp[cID - 1]);
            UIManager.actKaiFu.updateCur(13);
         }
         UIManager.actKaiFu.updateBmBtn();
      }
      
      public static function GC_WASH_LEVEL(lv:int, result:String) : void
      {
         var vo:ActivityGuideVo = null;
         var str:String = "\n当前已消耗<font color=\'#04ff00\'>" + lv + "颗</font>";
         var arr:Array = result.split("_");
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.WASH_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionStatus = arr;
            vo.allConditionDes = [vo.conditionOneDes + str,vo.conditionTwoDes + str,vo.conditionThreeDes + str];
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_WASH_ACTIVITY(result:int) : void
      {
         Model_ActivityGuide.isWashActivity = result == 1 ? true : false;
      }
      
      public static function GC_ACTIVITY_BUY(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("购买成功");
               break;
            case 0:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("此活动已过期");
         }
      }
      
      public static function GC_REWARD_STATUS(type:int, result:String, combat:String) : void
      {
         var vo:ActivityGuideVo = null;
         var id:int = 0;
         var arr:Array = result.split("_");
         var str:String = "\n当前已消耗<font color=\'#04ff00\'>" + combat + "个</font>";
         if(type == Enum_ActivityGuide.WUXING_REWARD_STATUS)
         {
            id = Enum_ActivityGuide.WUXING_ID;
         }
         else
         {
            id = Enum_ActivityGuide.NEIDAN_ID;
         }
         var i:int = 0;
         while(i < Model_ActivityGuide.activityVoData.length)
         {
            vo = Model_ActivityGuide.activityVoData[i] as ActivityGuideVo;
            if(vo.id == id)
            {
               if(id == Enum_ActivityGuide.WUXING_ID)
               {
                  vo.allConditionDes = [vo.conditionOneDes + str,vo.conditionTwoDes + str,vo.conditionThreeDes + str];
               }
               vo.allConditionStatus = arr;
               View_ActivityGuidePanel.instance.updateData(vo);
               break;
            }
            i++;
         }
         i = 0;
         while(i < arr.length)
         {
            if(arr[i] == Enum_ActivityGuide.HIGHT_LIGHT)
            {
               View_ActivityGuidePanel.instance.setBtnEff(id,Enum_ActivityGuide.HIGHT_LIGHT);
               break;
            }
            View_ActivityGuidePanel.instance.setBtnEff(id,Enum_ActivityGuide.NOT_HIGHT_LIGHT);
            i++;
         }
      }
      
      public static function GC_GET_WUXING_REWARD(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("未达到对应条件");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("领取成功");
         }
      }
      
      public static function GC_GET_SHENDAN_REWARD(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("条件不符");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("领取成功");
         }
      }
      
      public static function GC_BTN_HIGHLIGHT(type:int, result:int) : void
      {
         switch(type)
         {
            case Enum_ActivityGuide.WUXING_REWARD_STATUS:
               View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.WUXING_ID,result);
               break;
            case Enum_ActivityGuide.NEIDAN_REWARD_STATUS:
               View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.NEIDAN_ID,result);
         }
      }
      
      public static function GC_ACTIVITY_CONREWARD(startTime:int, endTime:int, actTime1:int, actTime2:int, actTime3:int, count:int, next:int, curReward:int, nxtCost:int, reward:int) : void
      {
         View_ActivityGuidePanel.instance.consumeRwardItem.update(startTime,endTime,actTime1,actTime2,actTime3,count,next,curReward,nxtCost,reward);
      }
      
      public static function GC_HORSE_REWARD(result:String, count:int) : void
      {
         var vo:ActivityGuideVo = null;
         var arr:Array = result.split("_");
         var str:String = "\n当前高级锻造<font color=\'#04ff00\'>" + Math.floor(count / 10) + "次</font>";
         var i:int = 0;
         while(i < Model_ActivityGuide.activityVoData.length)
         {
            vo = Model_ActivityGuide.activityVoData[i] as ActivityGuideVo;
            if(vo.id == Enum_ActivityGuide.HORSE_ID)
            {
               vo.allConditionDes = [vo.conditionOneDes + str,vo.conditionTwoDes + str,vo.conditionThreeDes + str];
               vo.allConditionStatus = arr;
               View_ActivityGuidePanel.instance.updateData(vo);
               break;
            }
            i++;
         }
      }
      
      public static function GC_GET_HORSE_REWARD(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("条件不符");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("领取成功");
         }
      }
      
      public static function GC_PET_EQUIP_REWARD(count:int, one:int, two:int, three:int) : void
      {
         var vo:ActivityGuideVo = null;
         var arr:Array = [one,two,three];
         var str:String = "\n当前已消耗<font color=\'#04ff00\'>" + count + "个</font>";
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.PET_EQUIP_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionDes = [vo.conditionOneDes + str,vo.conditionTwoDes + str,vo.conditionThreeDes + str];
            vo.allConditionStatus = arr;
            Model_ActivityGuide.petEquipVo = vo;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
         var i:int = 0;
         while(i < arr.length)
         {
            if(arr[i] == Enum_ActivityGuide.HIGHT_LIGHT)
            {
               View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.PET_EQUIP_ID,Enum_ActivityGuide.HIGHT_LIGHT);
               break;
            }
            View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.PET_EQUIP_ID,Enum_ActivityGuide.NOT_HIGHT_LIGHT);
            i++;
         }
      }
      
      public static function GC_GET_PET_EQUIP_REWARD(type:int, result:int) : void
      {
         var vo:ActivityGuideVo = null;
         var i:int = 0;
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("条件不符");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("领取成功");
         }
         if(result == 4)
         {
            result = 2;
         }
         else if(result == 3)
         {
            result = 1;
         }
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.PET_EQUIP_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionStatus[type] = result;
            Model_ActivityGuide.petEquipVo = vo;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
         if(Boolean(vo))
         {
            i = 0;
            while(i < vo.allConditionStatus.length)
            {
               if(vo.allConditionStatus[i] == Enum_ActivityGuide.HIGHT_LIGHT)
               {
                  View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.PET_EQUIP_ID,Enum_ActivityGuide.HIGHT_LIGHT);
                  break;
               }
               View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.PET_EQUIP_ID,Enum_ActivityGuide.NOT_HIGHT_LIGHT);
               i++;
            }
         }
      }
      
      public static function GC_REFRESH_PET_EQUIP_COUNT(count:int) : void
      {
         var vo:ActivityGuideVo = null;
         var str:String = "\n当前已消耗<font color=\'#04ff00\'>" + count + "个</font>";
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.PET_EQUIP_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionDes = [vo.conditionOneDes + str,vo.conditionTwoDes + str,vo.conditionThreeDes + str];
            Model_ActivityGuide.petEquipVo = vo;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
         trace(vo.allConditionStatus,"vo.allConditionStatus");
      }
      
      public static function GC_ChongZhiFanLi_OPEN(current:int) : void
      {
         View_ActivityGuidePanel.instance.consumeRwardItem.Update_ChongZhiFanLi(current);
      }
      
      public static function MiJingCangZong_TIME(startTime:int, endTime:int) : void
      {
         View_MiJingCangZong_explain.instance.UpdateDate(startTime,endTime);
      }
      
      public static function MiJingCangZong_FRESH(freshTimes:int) : void
      {
         Global.delegate.dosomething(View_MiJingCangZong_explain.instance,function():void
         {
            View_MiJingCangZong_explain.instance.UpdateFresh(freshTimes);
         });
      }
      
      public static function MiJingCangZong_BUY(itemID:int, result:int) : void
      {
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("购买成功");
               View_MiJingCangZong_menu.instance.UpdateZongZiCount();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("粽子不足");
         }
      }
      
      public static function GC_MeiRiHuiKui_OPEN(chongzhi:int, xiaofei:int, arr:Array) : void
      {
         var vo:ActivityGuideVo = null;
         var strArray:Array = [];
         var i:int = 1;
         while(i < 4)
         {
            if(Data_lib.meirihuikui[i][0] == 1)
            {
               strArray[i - 1] = "\n已充值<font color=\'#04ff00\'>" + chongzhi + "元宝</font>";
            }
            else if(Data_lib.meirihuikui[i][0] == 2)
            {
               strArray[i - 1] = "\n已消费<font color=\'#04ff00\'>" + xiaofei + "元宝</font>";
            }
            i++;
         }
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.MeiRiHuiKui] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionDes = [vo.conditionOneDes + strArray[0],vo.conditionTwoDes + strArray[1],vo.conditionThreeDes + strArray[2]];
            vo.allConditionStatus = arr;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_MeiRiHuiKui_GET(btnID:int, flag:int) : void
      {
         var vo:ActivityGuideVo = null;
         if(flag == 2)
         {
            vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.MeiRiHuiKui] as ActivityGuideVo;
            if(Boolean(vo))
            {
               vo.allConditionStatus[btnID - 1] = 2;
               View_ActivityGuidePanel.instance.updateData(vo);
               View_ActivityGuidePanel.instance.flyIcon(btnID - 1);
            }
         }
         else if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("领取失败");
         }
      }
      
      public static function GC_STONE_REWARD(count:int, one:int, two:int, three:int) : void
      {
         var vo:ActivityGuideVo = null;
         var arr:Array = [one,two,three];
         var str:String = "\n当前已消耗<font color=\'#04ff00\'>" + count + "颗</font>";
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.STONE_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionDes = [vo.conditionOneDes + str,vo.conditionTwoDes + str,vo.conditionThreeDes + str];
            vo.allConditionStatus = arr;
            Model_ActivityGuide.stoneVo = vo;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_GET_STONE_REWARD(result:int, index:int, type:int) : void
      {
         var vo:ActivityGuideVo = null;
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("领取成功");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               return;
         }
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.STONE_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionStatus[index] = type;
            Model_ActivityGuide.stoneVo = vo;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_EQUIP_STRENTHEN_REWARD(one:int, two:int, oneCount:int, twoCount:int) : void
      {
         var vo:ActivityGuideVo = null;
         var arr:Array = [one,two,0];
         var str:String = "\n还可以领取<font color=\'#04ff00\'>" + oneCount + "次</font>";
         var str2:String = "\n还可以领取<font color=\'#04ff00\'>" + twoCount + "次</font>";
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.STRENGHTEN_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionDes = [vo.conditionOneDes + str,vo.conditionTwoDes + str2,vo.conditionThreeDes];
            vo.allConditionStatus = arr;
            Model_ActivityGuide.strengthenVo = vo;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_GET_EQUIP_STRENTHEN_REWARD(result:int, index:int, type:int, count:int) : void
      {
         var vo:ActivityGuideVo = null;
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("领取成功");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               return;
         }
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.STRENGHTEN_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            if(index == 0)
            {
               vo.allConditionDes = [vo.conditionOneDes + "\n还可以领取<font color=\'#04ff00\'>" + count + "次</font>",vo.allConditionDes[1],vo.conditionThreeDes];
            }
            else if(index == 1)
            {
               vo.allConditionDes = [vo.allConditionDes[0],vo.conditionTwoDes + "\n还可以领取<font color=\'#04ff00\'>" + count + "次</font>",vo.conditionThreeDes];
            }
            vo.allConditionStatus[index] = type;
            Model_ActivityGuide.strengthenVo = vo;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_GET_WASH_REWARD(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("条件不符");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("领取成功");
         }
      }
      
      public static function GC_CHENGZHUANG_WASH_REWARD_STATUS(result:String) : void
      {
         var vo:ActivityGuideVo = null;
         var arr:Array = result.split("_");
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.CHENGZHUANG_WASH_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionStatus = arr;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_CHENGZHUANG_GET_WASH_REWARD(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("条件不符");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("领取成功");
         }
      }
      
      public static function GC_PET_GROW_REWARD(count:int, one:int, two:int, three:int) : void
      {
         var vo:ActivityGuideVo = null;
         var arr:Array = [one,two,three];
         var str:String = "\n当前已提升<font color=\'#04ff00\'>" + count + "点</font>";
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.PET_GROW_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionDes = [vo.conditionOneDes + str,vo.conditionTwoDes + str,vo.conditionThreeDes + str];
            vo.allConditionStatus = arr;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_GET_PET_GROW_REWARD(result:int) : void
      {
         switch(result)
         {
            case -1:
               UIManager.centerBroadcast.addMsg("领取失败");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("领取成功");
         }
      }
      
      public static function GC_SHENBING_HIGHLIGHT(result:int) : void
      {
         View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.SHENBING_ID,result);
      }
      
      public static function GC_SHENBING_REWARD(str:String) : void
      {
         var vo:ActivityGuideVo = null;
         var strArr:Array = str.split("_");
         str = "\n当前已消耗<font color=\'#04ff00\'>" + strArr.pop() + "个</font>";
         var arr:Array = strArr;
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.SHENBING_ID] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionDes = [vo.conditionOneDes + str,vo.conditionTwoDes + str,vo.conditionThreeDes + str];
            vo.allConditionStatus = arr;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_GET_SHENBING_REWARD(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("数量没有达到对应值");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("领取成功");
         }
      }
      
      public static function GC_ChongWuNeiDan2_OPEN(str:String) : void
      {
         var vo:ActivityGuideVo = null;
         var strArr:Array = str.split("_");
         str = "\n当前已提升<font color=\'#04ff00\'>" + strArr.pop() + "点</font>";
         var arr:Array = strArr;
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.ChongWuNeiDan2] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionDes = [vo.conditionOneDes + str,vo.conditionTwoDes + str,vo.conditionThreeDes + str];
            vo.allConditionStatus = arr;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_GET_ChongWuNeiDan2_REWARD(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("数量没有达到对应值");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("领取成功");
         }
      }
      
      public static function GC_ChongWuNeiDan2_HIGHLIGHT(result:int) : void
      {
         View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.ChongWuNeiDan2,result);
      }
      
      public static function GC_ShenMaoTanBao_OPEN() : void
      {
         Global.delegate.dosomething(View_ShenMaoTanBao_menu.instance,function():void
         {
            Global.control.sendNotification(Enum_ShenMaoTanBao.INIT,null);
         });
      }
      
      public static function GC_ShenMaoTanBao_SEEK() : void
      {
         Global.control.sendNotification(Enum_ShenMaoTanBao.SEEK_RESULT,null);
      }
      
      public static function GC_ShenMaoTanBao_GET() : void
      {
         Global.control.sendNotification(Enum_ShenMaoTanBao.GET_RESULT,null);
      }
      
      public static function GC_ShenMaoTanBao_JUMP() : void
      {
         Global.control.sendNotification(Enum_ShenMaoTanBao.JUMP_RESULT,null);
      }
      
      public static function GC_ShenMaoTanBao_BEGINNING_JUMP(flag:int) : void
      {
         switch(flag)
         {
            case 1:
               Model_ShenMaoTanBao.potision = [Model_ShenMaoTanBao.potision[0] + 1,0];
               Global.control.sendNotification(Enum_ShenMaoTanBao.BEGINNING_JUMP,null);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("不能跳层");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      public static function GC_YueBingShangCheng_BUY(result:int) : void
      {
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("购买成功");
               View_YueBingShangCheng.instance.UpdateZongZiCount();
               Global.control.sendNotification(Enum_YueBingShangCheng.FLY_TO_BAG,null);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("月饼不足");
         }
      }
      
      public static function GC_CHIBANG_OPENWIN(arr:Array) : void
      {
         var vo:ActivityGuideVo = null;
         var len:int = int(arr.length);
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.CHIBANG_ZHUTI] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionStatus = arr;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_CHIBANG_GETGIFT(flag:int, JS:int) : void
      {
         var btnID:int = 0;
         var vo:ActivityGuideVo = null;
         if(flag == 1)
         {
            btnID = Model_ActivityGuide.chibangtiaojian.indexOf(JS);
            vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.CHIBANG_ZHUTI] as ActivityGuideVo;
            if(Boolean(vo))
            {
               vo.allConditionStatus[btnID] = 2;
               View_ActivityGuidePanel.instance.updateData(vo);
               View_ActivityGuidePanel.instance.flyIcon(btnID);
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("领取失败");
         }
      }
      
      public static function GC_XiaoFeiHuiKui_OPEN(arr:Array) : void
      {
         var vo:ActivityGuideVo = null;
         var temp:Array = null;
         var strArray:Array = [];
         var len:int = int(arr.length);
         var i:int = 0;
         while(i < len)
         {
            if(Data_lib.xiaofeihuikui[i + 1][0] == 2)
            {
               strArray[i] = "\n已充值<font color=\'#04ff00\'>" + arr[i][0] + "元宝</font>";
            }
            else if(Data_lib.xiaofeihuikui[i + 1][0] == 1)
            {
               strArray[i] = "\n已消费<font color=\'#04ff00\'>" + arr[i][0] + "元宝</font>";
            }
            i++;
         }
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.XIAOFEIHUIKUI] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionDes = [vo.conditionOneDes + strArray[0],vo.conditionTwoDes + strArray[1],vo.conditionThreeDes + strArray[2]];
            temp = [];
            i = 0;
            while(i < len)
            {
               temp.push([arr[i][1],arr[i][2]]);
               i++;
            }
            vo.allConditionStatus2 = temp;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_XiaoFeiHuiKui_GET(flag:int, btnIndex:int) : void
      {
         if(flag == 1)
         {
            View_ActivityGuidePanel.instance.flyIcon(btnIndex);
         }
         else if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("领取失败");
         }
      }
      
      public static function GC_DaoJuDuiHuan(arr:Array) : void
      {
         Child_ItemWard.instance.updateData(arr);
      }
      
      public static function GC_DaoJuDuiHuan_GET(flag:int, curTime:int) : void
      {
         if(flag == 1)
         {
            Child_ItemWard.instance.getAward(Child_ItemWard.CUR_INDEX,curTime);
         }
         else if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("兑换失败");
         }
         else if(flag == 2)
         {
            UIManager.centerBroadcast.addMsg("兑换次数达到上限 ");
         }
         else if(flag == 3)
         {
            UIManager.centerBroadcast.addMsg("兑换材料不足");
         }
         else if(flag == 4)
         {
            UIManager.centerBroadcast.addMsg("经验不足，无法兑换");
         }
         else if(flag == 5)
         {
            UIManager.centerBroadcast.addMsg("超值兑换exchangeDatas字符串长度超过1000");
         }
      }
      
      public static function GC_DengLuYouLi_OPEN(desArr:Array, statusArr:Array, type:int) : void
      {
         var vo:ActivityGuideVo = null;
         var key:String = null;
         var i:int = 0;
         var type2:int = 0;
         var type1:int = 0;
         var conditionDesArr:Array = [];
         var str:String = "";
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.DENGLUYOULI] as ActivityGuideVo;
         vo.allConditionReward = [];
         for(key in Data_lib.dengluyouli)
         {
            if(Data_lib.dengluyouli[key][4] == type)
            {
               type2 = int(Data_lib.dengluyouli[key][5]);
               break;
            }
         }
         i = 0;
         while(i < desArr.length)
         {
            if(i == 0)
            {
               str = "每日登陆可领取";
            }
            else
            {
               str = "累积登陆<font color=\'#00ff00\'>" + Data_lib.dengluyouli[i + 1][0] + "天</font>可领取\n您已累积登陆<font color=\'#00ff00\'>" + desArr[i] + "天</font>";
            }
            type1 = i + 1 + (type2 - 1) * 4;
            vo.getArr(Data_lib.dengluyouli[type1][1]);
            conditionDesArr.push(str);
            i++;
         }
         if(Boolean(vo))
         {
            vo.allConditionDes = conditionDesArr;
            vo.allConditionStatus = statusArr;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_DengluYouLi_GETAWARD(flag:int, JS:int) : void
      {
         var len:int = 0;
         var btnID:int = 0;
         var i:int = 0;
         var vo:ActivityGuideVo = null;
         if(flag == 1)
         {
            len = int(Data_lib.dengluyouli.getLength());
            i = 0;
            while(i < len)
            {
               if(Data_lib.dengluyouli[i + 1][0] == JS)
               {
                  btnID = i;
                  break;
               }
               i++;
            }
            vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.DENGLUYOULI] as ActivityGuideVo;
            if(Boolean(vo))
            {
               vo.allConditionStatus[btnID] = 2;
               View_ActivityGuidePanel.instance.updateData(vo);
               View_ActivityGuidePanel.instance.flyIcon(btnID);
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("领取失败");
         }
      }
      
      public static function GC_ZuoQiTuanGou_OPEN(desArr:Array, statusArr:Array) : void
      {
         var des:String = null;
         var dic:Array = null;
         var j:int = 0;
         var vo:AcitivityVo = new AcitivityVo(Enum_KF.ID_ZUOQITUANGOU);
         var descriArr:Array = [];
         var awardArr:Array = [];
         var arr2:Array = [2,3,4];
         var i:int = 0;
         while(i < desArr.length)
         {
            des = "<font color=\'#00ff00\' size=\'18\'>" + desArr[i] + "</font>";
            descriArr.push(des);
            awardArr[i] = [];
            j = 0;
            while(j < arr2[i])
            {
               if(i == 0)
               {
                  dic = Data_lib.zuoqituangou[i * arr2[i] + j + 1][2].split("_");
               }
               else if(i == 1)
               {
                  dic = Data_lib.zuoqituangou[i * arr2[i] + j][2].split("_");
               }
               else if(i == 2)
               {
                  dic = Data_lib.zuoqituangou[i * arr2[i] + j - 2][2].split("_");
               }
               awardArr[i].push(dic);
               j++;
            }
            i++;
         }
         vo.allConditionDes = descriArr;
         vo.allConditionStatus = statusArr;
         vo.allConditionReward = awardArr;
         Child_WuHunTuanGou.instance.updateItem(vo);
      }
      
      public static function GC_ZuoQiTuanGou_GETAWARD(flag:int) : void
      {
         if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功",1);
            Child_WuHunTuanGou.instance.flyIcon();
         }
         else if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("领取失败",1);
         }
      }
      
      public static function GC_ShouChongTuanGou_OPEN(desArr:Array, statusArr:Array) : void
      {
         var des1:String = null;
         var des:String = null;
         var arr:Array = null;
         var singleArr:Array = null;
         var j:int = 0;
         var vo:AcitivityVo = new AcitivityVo(Enum_KF.ID_SHOUCHONGTUANGOU);
         var descriArr:Array = [];
         var awardArr:Array = [];
         var descriArr1:Array = [];
         var i:int = 0;
         while(i < desArr.length)
         {
            des1 = "首冲<font color=\'#00ff00\'>" + Data_lib.shouchongtuangou[i + 1][0] + "</font>人\n达标人数：";
            descriArr1.push(des1);
            des = "<font color=\'#00ff00\' size=\'18\'>" + desArr[i] + "</font>";
            descriArr.push(des);
            arr = String(Data_lib.shouchongtuangou[i + 1][1]).split(",");
            singleArr = [];
            j = 0;
            while(j < arr.length)
            {
               singleArr.push(arr[j].split("_"));
               j++;
            }
            awardArr.push(singleArr);
            i++;
         }
         vo.allConditionDes = descriArr;
         vo.allConditionStatus = statusArr;
         vo.allConditionReward = awardArr;
         vo.allConditionDes1 = descriArr1;
         Child_ShouChongTuanGou.instance.updateItem(vo);
      }
      
      public static function GC_ShouChongTuanGou_GETAWARD(flag:int) : void
      {
         if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功",1);
            Child_ShouChongTuanGou.instance.flyIcon(AcitivityVo.awardIndex - 1);
         }
         else if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("领取失败",1);
         }
      }
      
      public static function GC_WuHunTuanGou_OPEN(desArr:Array, statusArr:Array) : void
      {
         var des:String = null;
         var j:int = 0;
         var dic:Array = null;
         var vo:AcitivityVo = new AcitivityVo(Enum_KF.ID_WUHUNTUANGOU);
         var descriArr:Array = [];
         var awardArr:Array = [];
         var i:int = 0;
         while(i < desArr.length)
         {
            des = "<font color=\'#00ff00\' size=\'18\'>" + desArr[i] + "</font>";
            descriArr.push(des);
            awardArr[i] = [];
            j = 0;
            while(j < 4)
            {
               dic = Data_lib.wuhuntuangou[i * 4 + j + 1][2].split("_");
               awardArr[i].push(dic);
               j++;
            }
            i++;
         }
         vo.allConditionDes = descriArr;
         vo.allConditionStatus = statusArr;
         vo.allConditionReward = awardArr;
         Child_WuHunTuanGou.instance.updateItem(vo);
      }
      
      public static function GC_WuHunTuanGou_GETAWARD(flag:int) : void
      {
         if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功",1);
            Child_WuHunTuanGou.instance.flyIcon();
         }
         else if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("领取失败",1);
         }
      }
      
      public static function GC_TuanGouHighLight(index:int, isHighLight:int) : void
      {
         if(isHighLight == 1)
         {
            if(index == 1)
            {
               KaiFuModuleMgr.instance.setBtnEffect(Enum_KF.ID_SHOUCHONGTUANGOU,1);
            }
            else if(index == 2)
            {
               KaiFuModuleMgr.instance.setBtnEffect(Enum_KF.ID_WUHUNTUANGOU,1);
            }
            else if(index == 3)
            {
               KaiFuModuleMgr.instance.setBtnEffect(Enum_KF.ID_ZUOQITUANGOU,1);
            }
         }
         else if(isHighLight == 0)
         {
            if(index == 1)
            {
               KaiFuModuleMgr.instance.setBtnEffect(Enum_KF.ID_SHOUCHONGTUANGOU,0);
            }
            else if(index == 2)
            {
               KaiFuModuleMgr.instance.setBtnEffect(Enum_KF.ID_WUHUNTUANGOU,0);
            }
            else if(index == 3)
            {
               KaiFuModuleMgr.instance.setBtnEffect(Enum_KF.ID_ZUOQITUANGOU,0);
            }
         }
      }
      
      public static function GC_HaiDiXunBao_OPEN(result:int, curCount:int = -1, curTimes:int = -1, curPosition:int = -1, gridItemArr:Array = null, gridLightArr:Array = null) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("活动已结束");
         }
         else if(result == 1)
         {
            Global.control.sendNotification(Enum_HaiDiXunBao.OPEN,[curCount,curTimes,curPosition,gridItemArr,gridLightArr]);
            View_HaiDiXunBao_panel.instance.visible = !View_HaiDiXunBao_panel.instance.visible;
         }
      }
      
      public static function GC_HaiDiXunBao_PRIZE_RECORD(arr:Array) : void
      {
         Global.control.sendNotification(Enum_HaiDiXunBao.SET_PRIZE_RECORD,arr);
      }
      
      public static function GC_HaiDiXunBao_GET(result:int, flag:int = -1, position:int = -1, position2:int = 0) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("活动已结束");
         }
         else if(result == 1)
         {
            if(flag == 0)
            {
               UIManager.centerBroadcast.addMsg("寻宝失败");
            }
            else if(flag == 1)
            {
               Global.control.sendNotification(Enum_HaiDiXunBao.PLAY_ANIMATION,[position,position2]);
            }
         }
      }
      
      public static function GC_JHS_HIGHLIGHT(type:int) : void
      {
         View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.JVHUASUAN,type);
      }
   }
}

