package com.yiTian.view.modules.huangbang
{
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.message.cg.HuangbangCGMessage;
   import com.yiTian.view.modules.chat.ChatTip;
   import flash.geom.Point;
   
   public class Model_Huangbang
   {
      
      public static var currentLoop:int;
      
      public static var currentCount:int;
      
      public static var remainCount:int;
      
      public static var lastWeekRemainCount:int;
      
      public static var canAutoMove:Boolean;
      
      public static var isFirstEnter:Boolean;
      
      public static var isClickQuest:Boolean;
      
      public static var currentQuestId:int;
      
      public static var isLink:Boolean;
      
      public static var heroStandPoint:LoopPoint;
      
      public static var allSilverArr:Array = [];
      
      public static var silverArr:Array = [];
      
      public static var goldArr:Array = [];
      
      public static var loopArr:Array = ["白色","绿色","蓝色","紫色","橙色宝箱"];
      
      public static var questQualityArr:Array = ["白","绿","蓝","紫","橙"];
      
      public static var Shaker:Boolean = false;
      
      public static var routeArr:Array = [];
      
      public static var canAccept:Boolean = false;
      
      public static var totalCount:int = 100;
      
      public static var jumpIdArr:Array = [44772,44773,44774,44775];
      
      public static var canClickShake:Boolean = true;
      
      public static var linkPoint:Point = new Point();
      
      public static var canLookBack:Boolean = false;
      
      public function Model_Huangbang()
      {
         super();
      }
      
      public static function setSilverAndGoldData() : void
      {
         var i:String = null;
         var type:int = 0;
         var arr:Array = null;
         var minLv:int = 0;
         var maxLv:int = 0;
         for(i in Data_lib.huangbangFee)
         {
            type = int(Data_lib.huangbangFee[i][0]);
            if(type == Enum_Huangbang.SILVER)
            {
               arr = [];
               minLv = int(Data_lib.huangbangFee[i][6]);
               maxLv = int(Data_lib.huangbangFee[i][7]);
               arr.push(Data_lib.huangbangFee[i][1]);
               arr.push(Data_lib.huangbangFee[i][2]);
               arr.push(Data_lib.huangbangFee[i][3]);
               arr.push(Data_lib.huangbangFee[i][4]);
               arr.push(Data_lib.huangbangFee[i][5]);
               arr.push(minLv);
               arr.push(maxLv);
               if(GameUnitManager.hero.level >= minLv && GameUnitManager.hero.level <= maxLv)
               {
                  silverArr = arr;
               }
               allSilverArr.push(arr);
            }
            else if(type == Enum_Huangbang.GOLD)
            {
               goldArr.push(Data_lib.huangbangFee[i][1]);
               goldArr.push(Data_lib.huangbangFee[i][2]);
               goldArr.push(Data_lib.huangbangFee[i][3]);
               goldArr.push(Data_lib.huangbangFee[i][4]);
               goldArr.push(Data_lib.huangbangFee[i][5]);
            }
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,setSilver);
      }
      
      private static function setSilver() : void
      {
         var minLv:int = 0;
         var maxLv:int = 0;
         var i:int = 0;
         while(i < allSilverArr.length)
         {
            minLv = int(allSilverArr[i][5]);
            maxLv = int(allSilverArr[i][6]);
            if(GameUnitManager.hero.level >= minLv && GameUnitManager.hero.level <= maxLv)
            {
               silverArr = allSilverArr[i];
               break;
            }
            i++;
         }
      }
      
      public static function lookBackHuangBangQuest() : void
      {
         HuangbangCGMessage.CG_GET_LASTWEEK_QUEST();
      }
      
      public static function getRewardStr() : String
      {
         if(currentCount <= 25)
         {
            return "第25轮可获得<font color=\'" + ColorConstant.getColorStr(ColorConstant.PURPLE) + "\'><a href=\'event:showHuangbangGift\'>【周任务礼包】</a></font>";
         }
         if(currentCount <= 50)
         {
            return "第50轮可获得<font color=\'" + ColorConstant.getColorStr(ColorConstant.PURPLE) + "\'><a href=\'event:showHuangbangGift\'>【周任务礼包】</a></font>";
         }
         if(currentCount <= 75)
         {
            return "第75轮可获得<font color=\'" + ColorConstant.getColorStr(ColorConstant.PURPLE) + "\'><a href=\'event:showHuangbangGift\'>【周任务礼包】</a></font>";
         }
         if(currentCount <= 100)
         {
            return "第100轮可获得<font color=\'" + ColorConstant.getColorStr(ColorConstant.PURPLE) + "\'><a href=\'event:showHuangbangGift\'>【周任务大礼包】</a></font>";
         }
         return "";
      }
      
      public static function showItemTip() : void
      {
         var temVoItem:Vo_item = new Vo_item();
         if(currentCount > 75 && currentCount <= 100)
         {
            temVoItem.id = 45242;
         }
         else
         {
            temVoItem.id = 45241;
         }
         temVoItem.Init_lib();
         var temChatTip:ChatTip = ChatTip.getInstance();
         temChatTip.show(temVoItem);
      }
      
      public static function getLookBackStr() : String
      {
         return "<font color=\'" + ColorConstant.getColorStr(ColorConstant.YELLOW) + "\'><u><a href=\'event:open" + Enum_quest_step_type.LOOK_BACK_HUANGBANG_QUEST + "\'>找回上周次数</a></u></font>";
      }
   }
}

