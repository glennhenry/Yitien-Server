package com.yiTian.net.message.cg
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.activity.kaifuItem.tuangou.AcitivityVo;
   import com.yiTian.view.modules.activityGuide.Model_ActivityGuide;
   
   public class DailyActCGMessage extends CGMessage
   {
      
      public function DailyActCGMessage()
      {
         super();
      }
      
      public static function CG_DAILYACT() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_DAILYACT,byteBuff);
      }
      
      public static function CG_KFHD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_KFHD,byteBuff);
      }
      
      public static function CG_GETKFHDREWARD(taskID:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(taskID);
         SocketManager.send(MessageType.CG_GETKFHDREWARD,byteBuff);
      }
      
      public static function CG_NEWER_CLICK(taskID:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(taskID);
         SocketManager.send(MessageType.CG_NEWER_CLICK,byteBuff);
      }
      
      public static function CG_DAILYSHARE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_DAILYSHARE,byteBuff);
      }
      
      public static function CG_GETKFHDREWARD2(taskID:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(taskID);
         SocketManager.send(MessageType.CG_GETKFHDREWARDSPEC,byteBuff);
      }
      
      public static function CG_WASH_LEVEL() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WASH_LEVEL,byteBuff);
      }
      
      public static function CG_ACTIVITY_BUY(id:int, num:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeByte(num);
         SocketManager.send(MessageType.CG_ACTIVITY_BUY,byteBuff);
      }
      
      public static function CG_REWARD_STATUS(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_REWARD_STATUS,byteBuff);
      }
      
      public static function CG_GET_WUXING_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_WUXING_REWARD,byteBuff);
      }
      
      public static function CG_GET_SHENDAN_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_SHENDAN_REWARD,byteBuff);
      }
      
      public static function CG_ACTIVITY_CONREWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ACTIVITY_CONREWARD,byteBuff);
      }
      
      public static function CG_ChongZhiFanLi() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ChongZhiFanLi_OPEN,byteBuff);
      }
      
      public static function CG_HORSE_REWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_HORSE_REWARD,byteBuff);
      }
      
      public static function CG_GET_HORSE_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_HORSE_REWARD,byteBuff);
      }
      
      public static function CG_MiJingCangZong_FRESH() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_MiJingCangZong_FRESH,byteBuff);
      }
      
      public static function CG_MiJingCangZong_BUY(id:int, count:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeInt(count);
         SocketManager.send(MessageType.CG_MiJingCangZong_BUY,byteBuff);
      }
      
      public static function CG_PET_EQUIP_REWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_PET_EQUIP_REWARD,byteBuff);
      }
      
      public static function CG_GET_PET_EQUIP_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_PET_EQUIP_REWARD,byteBuff);
      }
      
      public static function CG_MeiRiHuiKui_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_MeiRiHuiKui_OPEN,byteBuff);
      }
      
      public static function CG_MeiRiHuiKui_GET(btnID:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(btnID + 1);
         SocketManager.send(MessageType.CG_MeiRiHuiKui_GET,byteBuff);
      }
      
      public static function CG_GET_STONE_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_STONE_REWARD,byteBuff);
      }
      
      public static function CG_GET_EQUIP_STRENTHEN_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_EQUIP_STRENTHEN_REWARD,byteBuff);
      }
      
      public static function CG_GET_WASH_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_WASH_REWARD,byteBuff);
      }
      
      public static function CG_CHENGZHUANG_GET_WASH_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_CHENGZHUANG_GET_WASH_REWARD,byteBuff);
      }
      
      public static function CG_CHENGZHUANG_WASH_STATUS() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CHENGZHUANG_WASH_STATUS,byteBuff);
      }
      
      public static function CG_PET_GROW_REWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_PET_GROW_REWARD,byteBuff);
      }
      
      public static function CG_GET_PET_GROW_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_PET_GROW_REWARD,byteBuff);
      }
      
      public static function CG_SHENBING_REWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_SHENBING_REWARD,byteBuff);
      }
      
      public static function CG_GET_SHENBING_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_SHENBING_REWARD,byteBuff);
      }
      
      public static function CG_ChongWuNeiDan2_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ChongWuNeiDan2_OPEN,byteBuff);
      }
      
      public static function CG_GET_ChongWuNeiDan2_REWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_ChongWuNeiDan2_REWARD,byteBuff);
      }
      
      public static function CG_ShenMaoTanBao_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ShenMaoTanBao_OPEN,byteBuff);
      }
      
      public static function CG_ShenMaoTanBao_SEEK() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ShenMaoTanBao_SEEK,byteBuff);
      }
      
      public static function CG_ShenMaoTanBao_GET() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ShenMaoTanBao_GET,byteBuff);
      }
      
      public static function CG_ShenMaoTanBao_JUMP() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ShenMaoTanBao_JUMP,byteBuff);
      }
      
      public static function CG_ShenMaoTanBao_BEGINNING_JUMP() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ShenMaoTanBao_BEGINNING_JUMP,byteBuff);
      }
      
      public static function CG_YueBingShangCheng_BUY(id:int, count:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeInt(count);
         SocketManager.send(MessageType.CG_YueBingShangCheng_BUY,byteBuff);
      }
      
      public static function CG_CHIBANG_OPENWIN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CHIBANG_OPENWIN,byteBuff);
      }
      
      public static function CG_CHIBANG_GETGIFT(type:int) : void
      {
         byteBuff.length = 0;
         var btnID:int = int(Model_ActivityGuide.chibangtiaojian[type]);
         byteBuff.writeByte(btnID);
         SocketManager.send(MessageType.CG_CHIBANG_GETGIFT,byteBuff);
      }
      
      public static function CG_XIAOFEIHUIKUI() : void
      {
         var i:String = null;
         var j:String = null;
         byteBuff.length = 0;
         for(i in Data_lib.xiaofeihuikui)
         {
            byteBuff.writeByte(Data_lib.xiaofeihuikui[i][0]);
         }
         for(j in Data_lib.xiaofeihuikui)
         {
            byteBuff.writeInt(Data_lib.xiaofeihuikui[j][1]);
         }
         SocketManager.send(MessageType.CG_XiaoFeiHuiKui_OPEN,byteBuff);
      }
      
      public static function CG_XIAOFEIHUIKUI_GETAWARD(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_XiaoFeiHuiKui_GETWARD,byteBuff);
      }
      
      public static function CG_DAOJUDUIHUAN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_DaoJuDuiHuan_OPEN,byteBuff);
      }
      
      public static function CG_DAOJUDUIHUAN_GETAWARD(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(index);
         SocketManager.send(MessageType.CG_DaoJuDuiHuan_GETWARD,byteBuff);
      }
      
      public static function CG_KF_HORSE_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_KF_HORSE_OPEN,byteBuff);
      }
      
      public static function CG_HORSE_GETAWARD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_HORSE_GETAWARD,byteBuff);
      }
      
      public static function CG_KF_ZLSC_OPEN(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_KF_ZLSC_OPEN,byteBuff);
      }
      
      public static function CG_KF_ZLSC_GETAWARD(type:int, index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_KF_ZLSC_GETAWARD,byteBuff);
      }
      
      public static function CG_KFHD_OPEN(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_KFHD_OPEN,byteBuff);
      }
      
      public static function CG_KFHD_WL_GETAWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_KFHD_WL_GETAWARD,byteBuff);
      }
      
      public static function CG_KFHD_BP_GETAWARD(_id:int, rank:int, type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(_id);
         byteBuff.writeByte(rank);
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_KFHD_BP_GETAWARD,byteBuff);
      }
      
      public static function CG_KFHD_CJ_GETAWARD(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_KFHD_CJ_GETAWARD,byteBuff);
      }
      
      public static function CG_DengLuYouLi_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_DengLuYouLi_OPEN,byteBuff);
      }
      
      public static function CG_DengluYouLi_GETAWARD(index:int) : void
      {
         byteBuff.length = 0;
         var btnID:int = int(Data_lib.dengluyouli[index + 1][0]);
         byteBuff.writeByte(btnID);
         SocketManager.send(MessageType.CG_DengluYouLi_GETAWARD,byteBuff);
      }
      
      public static function CG_ShouCHongTuanGou_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ShouChongTuanGou_OPEN,byteBuff);
      }
      
      public static function CG_ShouCHongTuanGou_GETAWARD(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(index);
         SocketManager.send(MessageType.CG_ShouChongTuanGou_GETAWARD,byteBuff);
      }
      
      public static function CG_WuHunTuanGou_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WuHunTuanGou_OPEN,byteBuff);
      }
      
      public static function CG_WuHunTuanGou_GETAWARD(id:int) : void
      {
         byteBuff.length = 0;
         var btnID:int = AcitivityVo.awardIndex;
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_WuHunTuanGou_GETAWARD,byteBuff);
      }
      
      public static function CG_ZuoQiTuanGou_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ZuoQiTuanGou_OPEN,byteBuff);
      }
      
      public static function CG_ZuoQiTuanGou_GETAWARD(id:int) : void
      {
         byteBuff.length = 0;
         var btnID:int = AcitivityVo.awardIndex;
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_ZuoQiTuanGou_GETAWARD,byteBuff);
      }
      
      public static function CG_HaiDiXunBao_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_HaiDiXunBao_OPEN,byteBuff);
      }
      
      public static function CG_HaiDiXunBao_GET() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_HaiDiXunBao_GET,byteBuff);
      }
   }
}

