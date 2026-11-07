package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_ShenMaoTanBao;
   import com.yiTian.data.vo.Vo_KFBP;
   import com.yiTian.data.vo.Vo_KFWL;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.DailyActHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.activity.kaifuItem.tuangou.AcitivityVo;
   import com.yiTian.view.modules.yellowDiamond.HuiyuanGiftTip;
   import com.yiTian.view.modules.yellowDiamond.Model_txAction;
   import flash.utils.IDataInput;
   
   public class DailyActGCMessage
   {
      
      public function DailyActGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_DAILYACT] = this.GC_DAILYACT;
         index[MessageType.GC_DAILYACT_CHANGE] = this.GC_DAILYACT_CHANGE;
         index[MessageType.GC_KFHD] = this.GC_KFHD;
         index[MessageType.GC_GETKFHDREWARD] = this.GC_GETKFHDREWARD;
         index[MessageType.GC_NEWERAWARD] = this.GC_NEWERAWARD;
         index[MessageType.GC_KFHDSPEC] = this.GC_KFHDSPEC;
         index[MessageType.GC_GETKFHDREWARDSPEC] = this.GC_GETKFHDREWARDSPEC;
         index[MessageType.GC_WASH_LEVEL] = this.GC_WASH_LEVEL;
         index[MessageType.GC_WASH_ACTIVITY] = this.GC_WASH_ACTIVITY;
         index[MessageType.GC_ACTIVITY_BUY] = this.GC_ACTIVITY_BUY;
         index[MessageType.GC_REWARD_STATUS] = this.GC_REWARD_STATUS;
         index[MessageType.GC_GET_WUXING_REWARD] = this.GC_GET_WUXING_REWARD;
         index[MessageType.GC_GET_SHENDAN_REWARD] = this.GC_GET_SHENDAN_REWARD;
         index[MessageType.GC_BTN_HIGHLIGHT] = this.GC_BTN_HIGHLIGHT;
         index[MessageType.GC_ACTIVITY_CONREWARD] = this.GC_ACTIVITY_CONREWARD;
         index[MessageType.GC_HORSE_REWARD] = this.GC_HORSE_REWARD;
         index[MessageType.GC_GET_HORSE_REWARD] = this.GC_GET_HORSE_REWARD;
         index[MessageType.GC_PET_EQUIP_REWARD] = this.GC_PET_EQUIP_REWARD;
         index[MessageType.GC_GET_PET_EQUIP_REWARD] = this.GC_GET_PET_EQUIP_REWARD;
         index[MessageType.GC_REFRESH_PET_EQUIP_COUNT] = this.GC_REFRESH_PET_EQUIP_COUNT;
         index[MessageType.GC_ChongZhiFanLi_OPEN] = this.GC_ChongZhiFanLi_OPEN;
         index[MessageType.GC_MiJingCangZong_TIME] = this.GC_MiJingCangZong_TIME;
         index[MessageType.GC_MiJingCangZong_FRESH] = this.GC_MiJingCangZong_FRESH;
         index[MessageType.GC_MiJingCangZong_BUY] = this.GC_MiJingCangZong_BUY;
         index[MessageType.GC_MeiRiHuiKui_OPEN] = this.GC_MeiRiHuiKui_OPEN;
         index[MessageType.GC_MeiRiHuiKui_GET] = this.GC_MeiRiHuiKui_GET;
         index[MessageType.GC_STONE_REWARD] = this.GC_STONE_REWARD;
         index[MessageType.GC_GET_STONE_REWARD] = this.GC_GET_STONE_REWARD;
         index[MessageType.GC_EQUIP_STRENTHEN_REWARD] = this.GC_EQUIP_STRENTHEN_REWARD;
         index[MessageType.GC_GET_EQUIP_STRENTHEN_REWARD] = this.GC_GET_EQUIP_STRENTHEN_REWARD;
         index[MessageType.GC_GET_WASH_REWARD] = this.GC_GET_WASH_REWARD;
         index[MessageType.GC_CHENGZHUANG_WASH_REWARD_STATUS] = this.GC_CHENGZHUANG_WASH_REWARD_STATUS;
         index[MessageType.GC_CHENGZHUANG_GET_WASH_REWARD] = this.GC_CHENGZHUANG_GET_WASH_REWARD;
         index[MessageType.GC_PET_GROW_REWARD] = this.GC_PET_GROW_REWARD;
         index[MessageType.GC_GET_PET_GROW_REWARD] = this.GC_GET_PET_GROW_REWARD;
         index[MessageType.GC_SHENBING_HIGHLIGHT] = this.GC_SHENBING_HIGHLIGHT;
         index[MessageType.GC_SHENBING_REWARD] = this.GC_SHENBING_REWARD;
         index[MessageType.GC_GET_SHENBING_REWARD] = this.GC_GET_SHENBING_REWARD;
         index[MessageType.GC_ICON_SHOW_HIDE_CTRL] = this.GC_ICON_SHOW_HIDE_CTRL;
         index[MessageType.GC_ShenMaoTanBao_OPEN] = this.GC_ShenMaoTanBao_OPEN;
         index[MessageType.GC_ShenMaoTanBao_SEEK] = this.GC_ShenMaoTanBao_SEEK;
         index[MessageType.GC_ShenMaoTanBao_JUMP] = this.GC_ShenMaoTanBao_JUMP;
         index[MessageType.GC_ShenMaoTanBao_BEGINNING_JUMP] = this.GC_ShenMaoTanBao_BEGINNING_JUMP;
         index[MessageType.GC_ShenMaoTanBao_GET] = this.GC_ShenMaoTanBao_GET;
         index[MessageType.GC_YueBingShangCheng_BUY] = this.GC_YueBingShangCheng_BUY;
         index[MessageType.GC_ChongWuNeiDan2_OPEN] = this.GC_ChongWuNeiDan2_OPEN;
         index[MessageType.GC_GET_ChongWuNeiDan2_REWARD] = this.GC_GET_ChongWuNeiDan2_REWARD;
         index[MessageType.GC_ChongWuNeiDan2_HIGHLIGHT] = this.GC_ChongWuNeiDan2_HIGHLIGHT;
         index[MessageType.GC_CHIBANG_OPENWIN] = this.GC_CHIBANG_OPENWIN;
         index[MessageType.GC_CHIBANG_GETGIFT] = this.GC_CHIBANG_GETGIFT;
         index[MessageType.GC_XiaoFeiHuiKui_OPEN] = this.GC_XiaoFeiHuiKui_OPEN;
         index[MessageType.GC_XiaoFeiHuiKui_GETWARD] = this.GC_XiaoFeiHuiKui_GETWARD;
         index[MessageType.GC_DaoJuDuiHuan_OPEN] = this.GC_DaoJuDuiHuan_OPEN;
         index[MessageType.GC_DaoJuDuiHuan_GETWARD] = this.GC_DaoJuDuiHuan_GETWARD;
         index[MessageType.GC_DengLuYouLi_OPEN] = this.GC_DengLuYouLi_OPEN;
         index[MessageType.GC_DengluYouLi_GETAWARD] = this.GC_DengluYouLi_GETAWARD;
         index[MessageType.GC_ShouChongTuanGou_OPEN] = this.GC_ShouChongTuanGou_OPEN;
         index[MessageType.GC_ShouChongTuanGou_GETAWARD] = this.GC_ShouChongTuanGou_GETAWARD;
         index[MessageType.GC_WuHunTuanGou_OPEN] = this.GC_WuHunTuanGou_OPEN;
         index[MessageType.GC_WuHunTuanGou_GETAWARD] = this.GC_WuHunTuanGou_GETAWARD;
         index[MessageType.GC_ZuoQiTuanGou_OPEN] = this.GC_ZuoQiTuanGou_OPEN;
         index[MessageType.GC_ZuoQiTuanGou_GETAWARD] = this.GC_ZuoQiTuanGou_GETAWARD;
         index[MessageType.GC_TUANGOU_HIGHLIGHT] = this.GC_TUANGOU_HIGHLIGHT;
         index[MessageType.GC_KF_HORSE_OPEN] = this.GC_KF_HORSE_OPEN;
         index[MessageType.GC_HORSE_GETAWARD] = this.GC_HORSE_GETAWARD;
         index[MessageType.GC_KF_ZLSC_OPEN] = this.GC_KF_ZLSC_OPEN;
         index[MessageType.GC_KF_ZLSC_GETAWARD] = this.GC_KF_ZLSC_GETAWARD;
         index[MessageType.GC_KF_TIPS_HORSE] = this.GC_KF_TIPS_HORSE;
         index[MessageType.GC_KF_TIPS_ZL] = this.GC_KF_TIPS_ZL;
         index[MessageType.GC_KF_TIPS_BB] = this.GC_KF_TIPS_BB;
         index[MessageType.GC_KFHD_WL_OPEN] = this.GC_KFHD_WL_OPEN;
         index[MessageType.GC_KFHD_WL_GETAWARD] = this.GC_KFHD_WL_GETAWARD;
         index[MessageType.GC_KFHD_BP_OPEN] = this.GC_KFHD_BP_OPEN;
         index[MessageType.GC_KFHD_BP_GETAWARD] = this.GC_KFHD_BP_GETAWARD;
         index[MessageType.GC_KFHD_CJ_OPEN] = this.GC_KFHD_CJ_OPEN;
         index[MessageType.GC_KFHD_CJ_GETAWARD] = this.GC_KFHD_CJ_GETAWARD;
         index[MessageType.GC_KFHD_HIGHTLINE] = this.GC_KFHD_HIGHTLINE;
         index[MessageType.GC_HaiDiXunBao_OPEN] = this.GC_HaiDiXunBao_OPEN;
         index[MessageType.GC_HaiDiXunBao_PRIZE_RECORD] = this.GC_HaiDiXunBao_PRIZE_RECORD;
         index[MessageType.GC_HaiDiXunBao_GET] = this.GC_HaiDiXunBao_GET;
      }
      
      private function GC_KFHD_CJ_OPEN(patch:IDataInput) : void
      {
         var status:String = patch.readUTF();
         var counts:String = patch.readUTF();
         DailyActHandle.GC_KFHD_CJ_OPEN(status,counts);
      }
      
      private function GC_KFHD_HIGHTLINE(patch:IDataInput) : void
      {
         var id:int = patch.readByte();
         var status:int = patch.readByte();
         DailyActHandle.GC_KFHD_HIGHTLINE(id,status);
      }
      
      private function GC_KFHD_CJ_GETAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_KFHD_CJ_GETAWARD(result);
      }
      
      private function GC_KFHD_BP_OPEN(patch:IDataInput) : void
      {
         var vo:Vo_KFBP = null;
         var showPage:int = patch.readByte();
         var showTime:String = patch.readUTF();
         var len:int = patch.readByte();
         var vec:Vector.<Vo_KFBP> = new Vector.<Vo_KFBP>();
         var i:int = 0;
         while(i < len)
         {
            vo = new Vo_KFBP();
            vo.index = patch.readByte();
            vo.time = patch.readUTF();
            vo.hasData = patch.readByte() == 1;
            if(!vo.hasData)
            {
               vec.push(vo);
            }
            else
            {
               vo.rank = patch.readByte();
               vo.familyName = patch.readUTF();
               vo.roleID = LongUtil.readLong(patch);
               vo.roleName = patch.readUTF();
               vo.sex = patch.readByte();
               vo.job = patch.readByte();
               vo.weapon = patch.readInt();
               vo.wing = patch.readInt();
               vo.fishion = patch.readInt();
               vo.GGStatus = patch.readByte();
               vo.DDStatus = patch.readByte();
               vec.push(vo);
            }
            i++;
         }
         DailyActHandle.GC_KFHD_BP_OPEN(vec,showPage,showTime);
      }
      
      private function GC_KFHD_BP_GETAWARD(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         DailyActHandle.GC_KFHD_BP_GETAWARD(reslut);
      }
      
      private function GC_KFHD_WL_OPEN(patch:IDataInput) : void
      {
         var vo:Vo_KFWL = null;
         var status:int = patch.readByte();
         var len:int = patch.readByte();
         var vec:Vector.<Vo_KFWL> = new Vector.<Vo_KFWL>();
         var i:int = 0;
         while(i < len)
         {
            vo = new Vo_KFWL();
            vo.time = patch.readUTF();
            vo.hasData = patch.readByte() == 1;
            vo.index = i + 1;
            if(!vo.hasData)
            {
               vec.push(vo);
            }
            else
            {
               vo.roleID = LongUtil.readLong(patch);
               vo.roleName = patch.readUTF();
               vo.sex = patch.readByte();
               vo.job = patch.readByte();
               vo.weapon = patch.readInt();
               vo.wing = patch.readInt();
               vo.fishion = patch.readInt();
               vec.push(vo);
            }
            i++;
         }
         DailyActHandle.GC_KFHD_WL_OPEN(vec,status);
      }
      
      private function GC_KFHD_WL_GETAWARD(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         DailyActHandle.GC_KFHD_WL_GETAWARD(reslut);
      }
      
      private function GC_KF_ZLSC_GETAWARD(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var index:int = patch.readByte();
         var reslut:int = patch.readByte();
         DailyActHandle.GC_KF_ZLSC_GETAWARD(type,index,reslut);
      }
      
      private function GC_HORSE_GETAWARD(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var index:int = patch.readByte();
         var reslut:int = patch.readByte();
         DailyActHandle.GC_HORSE_GETAWARD(type,index,reslut);
      }
      
      private function GC_KF_ZLSC_OPEN(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var status:String = patch.readUTF();
         var count:String = patch.readUTF();
         DailyActHandle.GC_KF_ZLSC_OPEN(type,status,count);
      }
      
      private function GC_KF_TIPS_HORSE(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         DailyActHandle.GC_KF_TIPS_HORSE(reslut);
      }
      
      private function GC_KF_TIPS_ZL(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         DailyActHandle.GC_KF_TIPS_ZL(reslut);
      }
      
      private function GC_KF_TIPS_BB(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         DailyActHandle.GC_KF_TIPS_BB(reslut);
      }
      
      private function GC_KF_HORSE_OPEN(patch:IDataInput) : void
      {
         var obj:Object = null;
         var arr:Array = [];
         obj = new Object();
         obj.name = patch.readUTF();
         obj.status = patch.readByte();
         obj.reamain = -1;
         arr.push(obj);
         obj = new Object();
         obj.name = patch.readUTF();
         obj.status = patch.readByte();
         obj.reamain = -1;
         arr.push(obj);
         obj = new Object();
         obj.name = patch.readUTF();
         obj.status = patch.readByte();
         obj.reamain = -1;
         arr.push(obj);
         obj = new Object();
         obj.name = patch.readUTF();
         obj.status = patch.readByte();
         obj.reamain = -1;
         arr.push(obj);
         obj = new Object();
         obj.rank = 5;
         obj.name = "";
         obj.status = patch.readByte();
         obj.reamain = patch.readInt();
         arr.push(obj);
         DailyActHandle.GC_KF_HORSE_OPEN(arr);
      }
      
      public function GC_DAILYACT(patch:IDataInput) : void
      {
         var length:int = patch.readByte();
         var array:Array = [];
         var i:int = 0;
         while(i < length)
         {
            array.push(patch.readByte());
            i += 1;
         }
         var zmrTimes:int = patch.readByte();
         DailyActHandle.GC_DAILYACT(array,zmrTimes);
      }
      
      public function GC_DAILYACT_CHANGE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_DAILYACT_CHANGE();
      }
      
      public function GC_KFHD(patch:IDataInput) : void
      {
         var taskID:int = 0;
         var state:int = 0;
         var len:int = patch.readShort();
         var kfTime:int = patch.readInt();
         var curTime:int = patch.readInt();
         var kfDay:int = patch.readInt();
         var infos:Array = [];
         var i:int = 0;
         while(i < len)
         {
            taskID = patch.readByte();
            state = patch.readByte();
            if([32,33,34].indexOf(taskID) != -1 && kfDay > 20)
            {
               state = 0;
            }
            infos.push(taskID,state);
            i += 1;
         }
         DailyActHandle.GC_KFHD(kfTime,curTime,kfDay,infos);
      }
      
      public function GC_NEWERAWARD(patch:IDataInput) : void
      {
         var speBtnCon:int = 0;
         var type:int = 0;
         var len:int = patch.readByte();
         var temArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            speBtnCon = patch.readByte();
            type = patch.readByte();
            temArr.push([speBtnCon,type]);
            i++;
         }
         DailyActHandle.GC_NEWERAWARD(temArr);
      }
      
      public function GC_GETKFHDREWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var taskID:int = patch.readByte();
         DailyActHandle.GC_GETKFHDREWARD(result,taskID);
      }
      
      public function GC_KFHDSPEC(patch:IDataInput) : void
      {
         var isShow:int = patch.readByte();
         var timeStr:String = patch.readUTF();
         var c1:int = patch.readByte();
         var c2:int = patch.readByte();
         var c3:int = patch.readByte();
         DailyActHandle.GC_KFHDSPEC(isShow,timeStr,c1,c2,c3);
      }
      
      public function GC_GETKFHDREWARDSPEC(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var cID:int = patch.readByte();
         DailyActHandle.GC_GETKFHDREWARDSPEC(result,cID);
      }
      
      public function GC_WASH_LEVEL(patch:IDataInput) : void
      {
         var lv:int = patch.readInt();
         var status:String = patch.readUTF();
         DailyActHandle.GC_WASH_LEVEL(lv,status);
      }
      
      public function GC_WASH_ACTIVITY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_WASH_ACTIVITY(result);
      }
      
      public function GC_ACTIVITY_BUY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_ACTIVITY_BUY(result);
      }
      
      public function GC_REWARD_STATUS(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var result:String = patch.readUTF();
         var combat:String = patch.readUTF();
         DailyActHandle.GC_REWARD_STATUS(type,result,combat);
      }
      
      public function GC_GET_WUXING_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_GET_WUXING_REWARD(result);
      }
      
      public function GC_GET_SHENDAN_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_GET_SHENDAN_REWARD(result);
      }
      
      public function GC_BTN_HIGHLIGHT(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var result:int = patch.readByte();
         DailyActHandle.GC_BTN_HIGHLIGHT(type,result);
      }
      
      public function GC_ACTIVITY_CONREWARD(patch:IDataInput) : void
      {
         var startTime:int = patch.readInt();
         var endTime:int = patch.readInt();
         var actTime1:int = patch.readInt();
         var actTime2:int = patch.readInt();
         var actTime3:int = patch.readInt();
         var count:int = patch.readInt();
         if(count >= 200000)
         {
            count = 200000;
         }
         var next:int = patch.readInt();
         var curReward:int = patch.readInt();
         var nxtCost:int = patch.readInt();
         var reward:int = patch.readInt();
         DailyActHandle.GC_ACTIVITY_CONREWARD(startTime,endTime,actTime1,actTime2,actTime3,count,next,curReward,nxtCost,reward);
      }
      
      public function GC_HORSE_REWARD(patch:IDataInput) : void
      {
         var result:String = patch.readUTF();
         var count:int = patch.readInt();
         DailyActHandle.GC_HORSE_REWARD(result,count);
      }
      
      public function GC_GET_HORSE_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_GET_HORSE_REWARD(result);
      }
      
      public function GC_PET_EQUIP_REWARD(patch:IDataInput) : void
      {
         var count:int = patch.readInt();
         var one:int = patch.readByte();
         var two:int = patch.readByte();
         var three:int = patch.readByte();
         DailyActHandle.GC_PET_EQUIP_REWARD(count,one,two,three);
      }
      
      public function GC_GET_PET_EQUIP_REWARD(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var result:int = patch.readByte();
         DailyActHandle.GC_GET_PET_EQUIP_REWARD(type,result);
      }
      
      public function GC_REFRESH_PET_EQUIP_COUNT(patch:IDataInput) : void
      {
         var count:int = patch.readInt();
         DailyActHandle.GC_REFRESH_PET_EQUIP_COUNT(count);
      }
      
      public function GC_ChongZhiFanLi_OPEN(patch:IDataInput) : void
      {
         var current:int = patch.readInt();
         DailyActHandle.GC_ChongZhiFanLi_OPEN(current);
      }
      
      public function GC_MiJingCangZong_TIME(patch:IDataInput) : void
      {
         var startTime:int = patch.readInt();
         var endTime:int = patch.readInt();
         DailyActHandle.MiJingCangZong_TIME(startTime,endTime);
      }
      
      public function GC_MiJingCangZong_FRESH(patch:IDataInput) : void
      {
         var freshTimes:int = patch.readInt();
         DailyActHandle.MiJingCangZong_FRESH(freshTimes);
      }
      
      public function GC_MiJingCangZong_BUY(patch:IDataInput) : void
      {
         var itemID:int = patch.readInt();
         var result:int = patch.readByte();
         DailyActHandle.MiJingCangZong_BUY(itemID,result);
      }
      
      public function GC_MeiRiHuiKui_OPEN(patch:IDataInput) : void
      {
         var chongzhi:int = patch.readInt();
         var xiaofei:int = patch.readInt();
         var arr:Array = [];
         arr.push(patch.readByte());
         arr.push(patch.readByte());
         arr.push(patch.readByte());
         trace("每日充值OPEN>>",chongzhi,xiaofei,arr);
         DailyActHandle.GC_MeiRiHuiKui_OPEN(chongzhi,xiaofei,arr);
      }
      
      public function GC_MeiRiHuiKui_GET(patch:IDataInput) : void
      {
         var btnID:int = patch.readByte();
         var flag:int = patch.readByte();
         trace("每日充值GET>>",btnID,flag);
         DailyActHandle.GC_MeiRiHuiKui_GET(btnID,flag);
      }
      
      public function GC_STONE_REWARD(patch:IDataInput) : void
      {
         var count:int = patch.readInt();
         var oneStatus:int = patch.readByte();
         var twoStatus:int = patch.readByte();
         var threeStatus:int = patch.readByte();
         DailyActHandle.GC_STONE_REWARD(count,oneStatus,twoStatus,threeStatus);
      }
      
      public function GC_GET_STONE_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var index:int = patch.readByte();
         var type:int = patch.readByte();
         DailyActHandle.GC_GET_STONE_REWARD(result,index,type);
      }
      
      public function GC_EQUIP_STRENTHEN_REWARD(patch:IDataInput) : void
      {
         var oneStatus:int = patch.readByte();
         var oneCount:int = patch.readByte();
         var twoStatus:int = patch.readByte();
         var twoCount:int = patch.readByte();
         DailyActHandle.GC_EQUIP_STRENTHEN_REWARD(oneStatus,twoStatus,oneCount,twoCount);
      }
      
      public function GC_GET_EQUIP_STRENTHEN_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var index:int = patch.readByte();
         var type:int = patch.readByte();
         var count:int = patch.readByte();
         DailyActHandle.GC_GET_EQUIP_STRENTHEN_REWARD(result,index,type,count);
      }
      
      public function GC_GET_WASH_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_GET_WASH_REWARD(result);
      }
      
      public function GC_CHENGZHUANG_WASH_REWARD_STATUS(patch:IDataInput) : void
      {
         var result:String = patch.readUTF();
         DailyActHandle.GC_CHENGZHUANG_WASH_REWARD_STATUS(result);
      }
      
      public function GC_CHENGZHUANG_GET_WASH_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_CHENGZHUANG_GET_WASH_REWARD(result);
      }
      
      public function GC_PET_GROW_REWARD(patch:IDataInput) : void
      {
         var time:String = patch.readUTF();
         var count:int = patch.readInt();
         var one:int = patch.readByte();
         var two:int = patch.readByte();
         var three:int = patch.readByte();
         DailyActHandle.GC_PET_GROW_REWARD(count,one,two,three);
      }
      
      public function GC_GET_PET_GROW_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_GET_PET_GROW_REWARD(result);
      }
      
      public function GC_SHENBING_HIGHLIGHT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_SHENBING_HIGHLIGHT(result);
      }
      
      public function GC_SHENBING_REWARD(patch:IDataInput) : void
      {
         var str:String = patch.readUTF();
         DailyActHandle.GC_SHENBING_REWARD(str);
      }
      
      public function GC_GET_SHENBING_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_GET_SHENBING_REWARD(result);
      }
      
      public function GC_ChongWuNeiDan2_OPEN(patch:IDataInput) : void
      {
         var str:String = patch.readUTF();
         DailyActHandle.GC_ChongWuNeiDan2_OPEN(str);
      }
      
      public function GC_GET_ChongWuNeiDan2_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_GET_ChongWuNeiDan2_REWARD(result);
      }
      
      public function GC_ChongWuNeiDan2_HIGHLIGHT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_ChongWuNeiDan2_HIGHLIGHT(result);
      }
      
      public function GC_ICON_SHOW_HIDE_CTRL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.mainUiBtnContainer.removeTTFBtn();
               break;
            case 2:
               UIManager.mainUiBtnContainer.showTTFBtn();
               break;
            case 3:
               UIManager.lingQiWuHunPanel.hideLingBtn();
               break;
            case 4:
               UIManager.lingQiWuHunPanel.showLingBtn();
               break;
            case 5:
               HuiyuanGiftTip.instance.remove();
               HuiyuanGiftTip.huiYuanSign = false;
               break;
            case 6:
               HuiyuanGiftTip.instance.show();
               break;
            case 7:
               Model_txAction.wordsShow(false);
               break;
            case 8:
               Model_txAction.wordsShow(true);
               break;
            case 9:
               Model_txAction.iconCtrl(false);
               break;
            case 11:
               Model_txAction.wordsCtrl(false);
               break;
            case 12:
               Model_txAction.wordsCtrl(true);
         }
      }
      
      public function GC_ShenMaoTanBao_OPEN(patch:IDataInput) : void
      {
         var floor:int = 0;
         var position:int = 0;
         var getBtn:int = 0;
         var jumpBtn:int = 0;
         var flag:int = patch.readByte();
         if(flag == 1)
         {
            floor = patch.readByte();
            position = patch.readByte();
            getBtn = patch.readByte();
            jumpBtn = patch.readByte();
            Model_ShenMaoTanBao.potision = [floor,position];
            Model_ShenMaoTanBao.btnStatus = [getBtn,jumpBtn];
            DailyActHandle.GC_ShenMaoTanBao_OPEN();
            trace("初始化",floor,position);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("活动已结束");
         }
      }
      
      public function GC_ShenMaoTanBao_SEEK(patch:IDataInput) : void
      {
         var position:int = 0;
         var jumpBtn:int = 0;
         var flag:int = patch.readByte();
         if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("活动已结束");
         }
         else if(flag == 1)
         {
            position = patch.readByte();
            jumpBtn = patch.readByte();
            Model_ShenMaoTanBao.potision[1] = position;
            Model_ShenMaoTanBao.btnStatus = [1,jumpBtn];
            DailyActHandle.GC_ShenMaoTanBao_SEEK();
            trace("搜寻",position);
         }
         else if(flag == 2)
         {
            UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      public function GC_ShenMaoTanBao_GET(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("活动已结束");
         }
         else if(flag == 1)
         {
            Model_ShenMaoTanBao.potision = [1,0];
            Model_ShenMaoTanBao.btnStatus = [0,0,1];
            DailyActHandle.GC_ShenMaoTanBao_GET();
            trace("领取完归位");
         }
      }
      
      public function GC_ShenMaoTanBao_JUMP(patch:IDataInput) : void
      {
         var nextPos:int = 0;
         var jumpBtn:int = 0;
         var curFloor:int = 0;
         var flag:int = patch.readByte();
         if(flag == 2)
         {
            UIManager.centerBroadcast.addMsg("活动已结束");
         }
         else if(flag == 1)
         {
            nextPos = patch.readByte();
            jumpBtn = patch.readByte();
            curFloor = int(Model_ShenMaoTanBao.potision[0]);
            Model_ShenMaoTanBao.potision = [curFloor + 1,nextPos];
            Model_ShenMaoTanBao.btnStatus = [1,jumpBtn];
            DailyActHandle.GC_ShenMaoTanBao_JUMP();
            trace("跳楼",curFloor + 1,nextPos);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("跳入下一层失败");
         }
      }
      
      public function GC_ShenMaoTanBao_BEGINNING_JUMP(patch:IDataInput) : void
      {
         DailyActHandle.GC_ShenMaoTanBao_BEGINNING_JUMP(patch.readByte());
      }
      
      public function GC_YueBingShangCheng_BUY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_YueBingShangCheng_BUY(result);
      }
      
      private function GC_CHIBANG_OPENWIN(patch:IDataInput) : void
      {
         var js:int = 0;
         var status:int = 0;
         var count:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < count)
         {
            js = patch.readByte();
            status = patch.readByte();
            arr.push(status);
            i++;
         }
         DailyActHandle.GC_CHIBANG_OPENWIN(arr);
      }
      
      private function GC_CHIBANG_GETGIFT(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         var JS:int = patch.readByte();
         DailyActHandle.GC_CHIBANG_GETGIFT(flag,JS);
      }
      
      public function GC_XiaoFeiHuiKui_OPEN(patch:IDataInput) : void
      {
         var singleArr:Array = null;
         var arr:Array = [];
         var i:int = 0;
         while(i < 3)
         {
            singleArr = [];
            singleArr.push(patch.readInt());
            singleArr.push(patch.readByte());
            singleArr.push(patch.readByte());
            arr.push(singleArr);
            i++;
         }
         DailyActHandle.GC_XiaoFeiHuiKui_OPEN(arr);
      }
      
      public function GC_XiaoFeiHuiKui_GETWARD(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         var btnID:int = patch.readByte();
         DailyActHandle.GC_XiaoFeiHuiKui_GET(flag,btnID);
      }
      
      public function GC_DaoJuDuiHuan_OPEN(patch:IDataInput) : void
      {
         var id:int = 0;
         var len:int = patch.readInt();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            id = patch.readInt();
            arr.push(patch.readInt());
            i++;
         }
         DailyActHandle.GC_DaoJuDuiHuan(arr);
      }
      
      public function GC_DaoJuDuiHuan_GETWARD(patch:IDataInput) : void
      {
         var flag:int = patch.readInt();
         var curTimes:int = patch.readInt();
         DailyActHandle.GC_DaoJuDuiHuan_GET(flag,curTimes);
      }
      
      private function GC_DengLuYouLi_OPEN(patch:IDataInput) : void
      {
         var str:String = patch.readUTF();
         var type:int = patch.readByte();
         var dataArr:Array = str.split(",");
         var desArr:Array = [];
         var statusArr:Array = [];
         var i:int = 1;
         while(i < dataArr.length - 1)
         {
            desArr.push(dataArr[0]);
            statusArr.push(dataArr[i]);
            i++;
         }
         DailyActHandle.GC_DengLuYouLi_OPEN(desArr,statusArr,type);
      }
      
      private function GC_DengluYouLi_GETAWARD(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         var JS:int = patch.readByte();
         DailyActHandle.GC_DengluYouLi_GETAWARD(flag,JS);
      }
      
      private function GC_ShouChongTuanGou_OPEN(patch:IDataInput) : void
      {
         var des:int = patch.readInt();
         var count:int = patch.readByte();
         var desArr:Array = [];
         var statusArr:Array = [];
         var i:int = 0;
         while(i < count)
         {
            desArr.push(des);
            statusArr.push(patch.readByte());
            i++;
         }
         DailyActHandle.GC_ShouChongTuanGou_OPEN(desArr,statusArr);
      }
      
      private function GC_ShouChongTuanGou_GETAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_ShouChongTuanGou_GETAWARD(result);
      }
      
      private function GC_WuHunTuanGou_OPEN(patch:IDataInput) : void
      {
         var count:int = patch.readByte();
         var desArr:Array = [];
         var statusArr:Array = [];
         var i:int = 0;
         while(i < count)
         {
            desArr.push(patch.readInt());
            statusArr.push([patch.readByte(),patch.readByte(),patch.readByte(),patch.readByte()]);
            i++;
         }
         DailyActHandle.GC_WuHunTuanGou_OPEN(desArr,statusArr);
      }
      
      private function GC_WuHunTuanGou_GETAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_WuHunTuanGou_GETAWARD(result);
      }
      
      private function GC_ZuoQiTuanGou_OPEN(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("您还没有坐骑，13级获得坐骑后可以参与活动",1);
            AcitivityVo.HAS_HORSE = false;
            return;
         }
         AcitivityVo.HAS_HORSE = true;
         var count:int = patch.readByte();
         var desArr:Array = [];
         var statusArr:Array = [];
         var i:int = 0;
         while(i < count)
         {
            desArr.push(patch.readInt());
            if(i == 0)
            {
               statusArr.push([patch.readByte(),patch.readByte()]);
            }
            else if(i == 1)
            {
               statusArr.push([patch.readByte(),patch.readByte(),patch.readByte()]);
            }
            else if(i == 2)
            {
               statusArr.push([patch.readByte(),patch.readByte(),patch.readByte(),patch.readByte()]);
            }
            i++;
         }
         DailyActHandle.GC_ZuoQiTuanGou_OPEN(desArr,statusArr);
      }
      
      private function GC_ZuoQiTuanGou_GETAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DailyActHandle.GC_ZuoQiTuanGou_GETAWARD(result);
      }
      
      private function GC_TUANGOU_HIGHLIGHT(patch:IDataInput) : void
      {
         var index:int = patch.readByte();
         var isHighLight:int = patch.readByte();
         DailyActHandle.GC_TuanGouHighLight(index,isHighLight);
      }
      
      private function GC_HaiDiXunBao_OPEN(patch:IDataInput) : void
      {
         var curCount:int = 0;
         var curTimes:int = 0;
         var curPosition:int = 0;
         var str1:String = null;
         var str2:String = null;
         var gridItemArr:Array = null;
         var gridLightArr:Array = null;
         var result:int = patch.readByte();
         if(result == 0)
         {
            DailyActHandle.GC_HaiDiXunBao_OPEN(result);
         }
         else if(result == 1)
         {
            curCount = patch.readInt();
            curTimes = patch.readInt();
            curPosition = patch.readInt();
            str1 = patch.readUTF();
            str2 = patch.readUTF();
            gridItemArr = str1.split("_");
            gridLightArr = str2.split("");
            trace("OPEN",curCount,curTimes,curPosition,str1,str2);
            DailyActHandle.GC_HaiDiXunBao_OPEN(result,curCount,curTimes,curPosition,gridItemArr,gridLightArr);
         }
      }
      
      private function GC_HaiDiXunBao_PRIZE_RECORD(patch:IDataInput) : void
      {
         var name:String = null;
         var job:int = 0;
         var itemStr:String = null;
         var arr:Array = [];
         while(Boolean(patch.bytesAvailable))
         {
            name = patch.readUTF();
            job = int(patch.readUTF());
            itemStr = patch.readUTF();
            arr.push(name);
            arr.push(itemStr);
            arr.push(job);
         }
         DailyActHandle.GC_HaiDiXunBao_PRIZE_RECORD(arr);
      }
      
      private function GC_HaiDiXunBao_GET(patch:IDataInput) : void
      {
         var flag:int = 0;
         var position:int = 0;
         var position2:int = 0;
         var result:int = patch.readByte();
         if(result == 0)
         {
            DailyActHandle.GC_HaiDiXunBao_GET(result);
         }
         else if(result == 1)
         {
            flag = patch.readByte();
            position = patch.readInt();
            position2 = patch.readInt();
            DailyActHandle.GC_HaiDiXunBao_GET(result,flag,position,position2);
         }
      }
   }
}

