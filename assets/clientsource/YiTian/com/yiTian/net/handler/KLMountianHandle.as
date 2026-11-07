package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_kunlun;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.Kunlun.Enum_kunLun;
   import com.yiTian.view.modules.Kunlun.View_RoomTipBtn;
   import com.yiTian.view.modules.Kunlun.View_klTipBtn;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.utils.IDataInput;
   
   public class KLMountianHandle
   {
      
      private static var flag:Boolean = false;
      
      public function KLMountianHandle()
      {
         super();
      }
      
      public static function GC_KL_EXTRA_RESULT(type:int, patch:IDataInput) : void
      {
         var str:String = null;
         var roomId:int = 0;
         var obj:Object = null;
         var remainTime:int = 0;
         var id:int = 22340 + type;
         switch(type)
         {
            case 7:
               roomId = patch.readByte();
               obj = Model_kunlun.klRoomInfo.getData();
               (obj.array as Array)[roomId] = Enum_kunLun.NUM_MAX_PLAYER;
               Model_kunlun.klRoomInfo.setData(obj);
               break;
            case 10:
               patch.readByte();
               remainTime = patch.readInt();
               str = LangConfig.getWord(id.toString(),2,remainTime);
               break;
            default:
               str = LangConfig.getWord(id.toString(),2);
         }
         if(Boolean(str))
         {
            UIManager.centerBroadcast.addMsg(str);
         }
      }
      
      public static function GC_KLSHAN_ONTIME() : void
      {
         Model_actDaily.getInstance().kunlun(true);
         if(GameUnitManager.hero.level >= 30)
         {
            UIManager.kunlun_prompt.visible = true;
         }
         UIManager.selfBroadcast.addMsg(LangConfig.getWord("22361",2));
         Model_actDaily.getInstance().updateAct(2,true);
         UIManager.smallMap.addTip(0);
      }
      
      public static function GC_ENTER_KL_MOUNTIAN(roomIndex:int, numKl1:int, numKl2:int, sbId:Number, sbName:String, actRemainTime:int, freRemainTime:int) : void
      {
         var obj:Object = {
            "myIndex":roomIndex,
            "kill1":numKl1,
            "kill2":numKl2,
            "sbId":sbId,
            "sbName":sbName
         };
         Model_kunlun.myKLInfo.setData(obj);
         UIManager.kunlun_inside.enterKL();
         UIManager.kunlun_inside.updateTime(actRemainTime,freRemainTime);
         var ins:View_RoomTipBtn = View_RoomTipBtn.getInstance();
         UIManager.mainUiBtnContainer.addBTN(ins);
         UIManager.questTraceView.visible = false;
         UIManager.kl_roomInfo.visible = false;
         UIManager.kunlun_prompt.visible = false;
         if(View_klTipBtn.isInstance())
         {
            UIManager.mainUiBtnContainer.removeBTN(View_klTipBtn.instance);
            View_klTipBtn.instance.dispose();
         }
         if(GameUnitManager.hero.status != Status.KUN_LUN)
         {
            GameUnitManager.hero.status = Status.KUN_LUN;
         }
         if(!flag)
         {
            UIManager.kunlun_jieShao.visible = true;
            flag = true;
         }
      }
      
      public static function GC_GET_KL_ROOM(arr:Array, myIndex:int) : void
      {
         var obj:Object = Boolean(Model_kunlun.klRoomInfo.getData()) ? Model_kunlun.klRoomInfo.getData() : new Object();
         obj.array = arr;
         obj.roomIndex = myIndex;
         Model_kunlun.klRoomInfo.setData(obj);
      }
      
      public static function GC_KILL_INFO(k1:int, k2:int) : void
      {
         var obj:Object = Model_kunlun.myKLInfo.getData();
         if(Boolean(obj))
         {
            obj.kill1 = k1;
            obj.kill2 = k2;
            Model_kunlun.myKLInfo.setData(obj);
         }
      }
      
      public static function GC_KL_RANK(type:int, myRank:int, dataCount:int, pageIndex:int, array:Array) : void
      {
         var aIndex:int = type - 1;
         Model_kunlun.voArr[aIndex][pageIndex] = array;
         Model_kunlun.voCountArr[aIndex] = dataCount;
         Model_kunlun.scoreArr[aIndex] = myRank;
      }
      
      public static function GC_KL_CHANGE_ROOM(newRoomId:int) : void
      {
      }
      
      public static function GC_KL_END(type:int) : void
      {
         var b:Boolean = View_klTipBtn.isInstance();
         switch(type)
         {
            case 1:
               UIManager.mainUiBtnContainer.addBTN(View_klTipBtn.instance);
               break;
            case 2:
               if(View_klTipBtn.isInstance())
               {
                  UIManager.mainUiBtnContainer.removeBTN(View_klTipBtn.instance);
               }
               Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.KunLunShan,2]);
         }
         UIManager.questTraceView.resetPosition();
         UIManager.questTraceView.visible = true;
         UIManager.kl_roomInfo.visible = false;
         UIManager.kunlun_inside.leaveKL();
         if(View_RoomTipBtn.isInstance())
         {
            UIManager.mainUiBtnContainer.removeBTN(View_RoomTipBtn.getInstance());
            View_RoomTipBtn.getInstance().dispose();
         }
         if(GameUnitManager.hero.status == Status.KUN_LUN)
         {
            GameUnitManager.hero.status = Status.NOMAL;
         }
      }
      
      public static function GC_KL_RANK1(arr:Array) : void
      {
         UIManager.kunlun_substantive.update(arr);
         var obj:Object = Model_kunlun.myKLInfo.getData();
         if(Boolean(obj) && Boolean(arr.length))
         {
            obj.sbId = arr[0][0];
            obj.sbName = arr[0][1];
            Model_kunlun.myKLInfo.setData(obj);
         }
      }
      
      public static function GC_INFO_REFRESH_FLAG(type:int) : void
      {
         Model_kunlun.initKLRanksData();
      }
      
      public static function GC_GET_KLEXP(result:int, exp:int) : void
      {
      }
      
      public static function GC_LIXIANDIAN_RESULT(type:int, lixiandian:int, total:int) : void
      {
         var str:String = null;
         var s:Function = null;
         if(type == 1)
         {
            str = "增加了" + lixiandian + "历险点";
         }
         else if(type == 2)
         {
            str = "减少了" + lixiandian + "历险点";
         }
         else if(type == 3)
         {
            UIManager.kunlun_inside.setMyLixiandian(total);
         }
         else if(type == 4)
         {
            UIManager.centerBroadcast.addMsg("您退出了昆仑山，减少了10历险点");
         }
         if(type == 1 || type == 2)
         {
            s = function():void
            {
               UIManager.centerBroadcast.addMsg(str);
               Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,s);
            };
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,s);
         }
         UIManager.kunlun_inside.setMyLixiandian(total);
      }
   }
}

