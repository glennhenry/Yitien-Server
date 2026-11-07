package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_WuLinMiXin;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.WuLinMiXinHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class WulinmixinGCMessage
   {
      
      public function WulinmixinGCMessage(_index:Array)
      {
         super();
         _index[MessageType.GC_Wulinmixin_UPDATE_ALL_STATUS] = this.UpdateAllStatus;
         _index[MessageType.GC_Wulinmixin_UPDATE_STATUS] = this.UpdateStatus;
         _index[MessageType.GC_Wulinmixin_UPDATE_PANEL] = this.UpdatePanel;
      }
      
      private function upgradeTo30() : void
      {
         var arr:Array = null;
         var i:int = 0;
         if(GameUnitManager.hero.level >= 30)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,this.upgradeTo30);
            arr = [];
            i = 0;
            while(i < 12)
            {
               arr.push(1);
               i++;
            }
            WuLinMiXinHandle.UpdateAllStatus(arr);
         }
      }
      
      public function UpdateAllStatus(_patch:IDataInput) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.upgradeTo30);
            return;
         }
         var arr:Array = [];
         var i:int = 0;
         while(i < 12)
         {
            arr.push(_patch.readByte());
            i++;
         }
         WuLinMiXinHandle.UpdateAllStatus(arr);
         WuLinMiXinHandle.SetMainButtonEffect(_patch.readByte());
         trace("****107000",arr);
      }
      
      public function UpdatePanel(_patch:IDataInput) : void
      {
         var name:String = null;
         var kind:int = 0;
         var prize:int = 0;
         var name1:String = null;
         var kind1:int = 0;
         var money1:int = 0;
         var k:int = 0;
         while(k < 12)
         {
            WuLinMiXinHandle.UpdateStatus(k);
            k++;
         }
         var freeTime:int = _patch.readByte();
         var openedTime:int = _patch.readByte();
         var bigPrizeOwner:String = _patch.readUTF();
         var bigPrize:int = _patch.readInt();
         trace("****107002 freeTime,openedTime,bigPrizeOwner,bigPrize",freeTime,openedTime,bigPrizeOwner,bigPrize);
         Model_WuLinMiXin.freeOpenTimes = freeTime;
         Model_WuLinMiXin.haveOpenTimes = openedTime;
         WuLinMiXinHandle.UpdatePrizeOwner(bigPrizeOwner,bigPrize);
         var nameArr:Array = [];
         var kindArr:Array = [];
         var itemArr:Array = [];
         var length:int = _patch.readByte();
         var i:int = 0;
         while(i < length)
         {
            name = _patch.readUTF();
            kind = _patch.readByte();
            prize = _patch.readInt();
            trace("****107002 name,kind,prize",name,kind,prize);
            nameArr.push(name);
            kindArr.push(kind);
            itemArr.push(prize);
            i++;
         }
         WuLinMiXinHandle.UpdateItemRecord(nameArr,kindArr,itemArr);
         length = _patch.readByte();
         nameArr = [];
         kindArr = [];
         itemArr = [];
         var j:int = 0;
         while(j < length)
         {
            name1 = _patch.readUTF();
            kind1 = _patch.readByte();
            money1 = _patch.readInt();
            trace("****107002 name1 kind1 money1",name1,kind1,money1);
            nameArr.push(name1);
            kindArr.push(kind1);
            itemArr.push(money1);
            j++;
         }
         WuLinMiXinHandle.UpdatePrizeRecord(nameArr,kindArr,itemArr);
         var pool:int = _patch.readInt();
         trace("****107002 pool",pool);
         WuLinMiXinHandle.UpdatePrizePool(pool);
         WuLinMiXinHandle.UpdateOpenTimes();
      }
      
      public function UpdateStatus(_patch:IDataInput) : void
      {
         var money:int = 0;
         var item:int = 0;
         var cardId:int = _patch.readByte();
         var kind:int = _patch.readByte();
         trace("****107004 cardId,kind",cardId,kind);
         if(kind == 1)
         {
            UIManager.centerBroadcast.addMsg("再来一箭吧");
            if(Model_WuLinMiXin.freeOpenTimes > 0)
            {
               WuLinMiXinHandle.AddPool(1000);
            }
            else
            {
               ++Model_WuLinMiXin.freeOpenTimes;
               ++Model_WuLinMiXin.haveOpenTimes;
               WuLinMiXinHandle.AddPool(Data_lib.wulinmixin_cost[Model_WuLinMiXin.haveOpenTimes][0] * 1000);
            }
         }
         else if(kind == 2)
         {
            money = _patch.readInt();
            trace("****107004-2",money);
            UIManager.centerBroadcast.addMsg("恭喜你获得" + money + "银子");
            if(Model_WuLinMiXin.freeOpenTimes > 0)
            {
               WuLinMiXinHandle.AddPool(1000);
               --Model_WuLinMiXin.freeOpenTimes;
            }
            else
            {
               ++Model_WuLinMiXin.haveOpenTimes;
               WuLinMiXinHandle.AddPool(Data_lib.wulinmixin_cost[Model_WuLinMiXin.haveOpenTimes][0] * 1000);
            }
            WuLinMiXinHandle.MoneyFlyToBag(cardId - 1);
         }
         else if(kind == 3)
         {
            item = _patch.readInt();
            trace("****107004-3",item);
            if(Model_WuLinMiXin.freeOpenTimes > 0)
            {
               --Model_WuLinMiXin.freeOpenTimes;
               WuLinMiXinHandle.AddPool(1000);
            }
            else
            {
               ++Model_WuLinMiXin.haveOpenTimes;
               WuLinMiXinHandle.AddPool(Data_lib.wulinmixin_cost[Model_WuLinMiXin.haveOpenTimes][0] * 1000);
            }
            WuLinMiXinHandle.ItemFlyToBag(cardId - 1,item);
         }
         else if(kind == 4)
         {
            money = _patch.readInt();
            trace("****107004-4",money);
            UIManager.centerBroadcast.addMsg("恭喜你获得" + money + "绑银");
            if(Model_WuLinMiXin.freeOpenTimes > 0)
            {
               --Model_WuLinMiXin.freeOpenTimes;
               WuLinMiXinHandle.AddPool(1000);
            }
            else
            {
               ++Model_WuLinMiXin.haveOpenTimes;
               WuLinMiXinHandle.AddPool(Data_lib.wulinmixin_cost[Model_WuLinMiXin.haveOpenTimes][0] * 1000);
            }
            WuLinMiXinHandle.MoneyFlyToBag(cardId - 1);
         }
         else if(kind == 5)
         {
            money = _patch.readInt();
            trace("****107004-5",money);
            UIManager.centerBroadcast.addMsg("恭喜你获得" + money + "元宝");
            if(Model_WuLinMiXin.freeOpenTimes > 0)
            {
               --Model_WuLinMiXin.freeOpenTimes;
               WuLinMiXinHandle.AddPool(1000);
            }
            else
            {
               ++Model_WuLinMiXin.haveOpenTimes;
               WuLinMiXinHandle.AddPool(Data_lib.wulinmixin_cost[Model_WuLinMiXin.haveOpenTimes][0] * 1000);
            }
            WuLinMiXinHandle.MoneyFlyToBag(cardId - 1);
         }
         else if(kind == 6)
         {
            UIManager.centerBroadcast.addMsg("元宝不足");
         }
         WuLinMiXinHandle.SetMainButtonEffect(Model_WuLinMiXin.freeOpenTimes);
         Model_WuLinMiXin.statusArray[cardId - 1] = 0;
         WuLinMiXinHandle.UpdateStatus(cardId - 1,true);
         WuLinMiXinHandle.UpdateOpenTimes();
      }
   }
}

