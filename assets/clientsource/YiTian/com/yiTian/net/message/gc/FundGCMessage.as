package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.actions.jiJin.FundBuy;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import com.yiTian.view.modules.actions.jiJin.FundOpen;
   import com.yiTian.view.modules.actions.jiJin.chongzhi.View_chongzhi;
   import com.yiTian.view.modules.actions.jiJin.fundShop.FundStore;
   import com.yiTian.view.modules.fund.FundConfig;
   import flash.utils.IDataInput;
   
   public class FundGCMessage
   {
      
      public function FundGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_FUND] = this.GC_FUND;
         index[MessageType.GC_FUND_COUNT] = this.GC_FUND_COUNT;
         index[MessageType.GC_FUND_RECHARGE] = this.GC_FUND_RECHARGE;
         index[MessageType.GC_GET_REWARD] = this.GC_GET_REWARD;
         index[MessageType.GC_FUND_PAY] = this.GC_FUND_PAY;
         index[MessageType.GC_FUND_EFFICON] = GC_FUND_EFFICON;
      }
      
      public static function GC_FUND_EFFICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            FundConfig.addEff();
         }
         else if(result == 2)
         {
            UIManager.heroHead.setChongZhiEff(true);
         }
      }
      
      public function GC_FUND(patch:IDataInput) : void
      {
         var type:int = 0;
         var lvl:int = 0;
         var days:int = 0;
         var dataArr:Array = null;
         var _pan2:FundOpen = null;
         var pan3:FundBuy = null;
         var _pan:FundBuy = null;
         var pan2:FundOpen = null;
         type = patch.readByte();
         lvl = patch.readByte();
         days = patch.readShort();
         var len:int = patch.readByte();
         dataArr = [];
         var i:int = 0;
         while(i < len)
         {
            dataArr.push(patch.readByte());
            i++;
         }
         FundMter.baiJinLvl = lvl;
         if(type == 0)
         {
            _pan2 = Singleton.getInstance(FundOpen) as FundOpen;
            if(_pan2.visible)
            {
               _pan2.visible = false;
            }
            pan3 = Singleton.getInstance(FundBuy) as FundBuy;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan3,function():void
            {
               pan3.visible = true;
            });
         }
         else
         {
            FundMter.dataArrSave = type;
            _pan = Singleton.getInstance(FundBuy) as FundBuy;
            if(_pan.visible)
            {
               _pan.visible = false;
            }
            pan2 = Singleton.getInstance(FundOpen) as FundOpen;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan2,function():void
            {
               pan2.update(type,lvl,days,dataArr);
            });
         }
      }
      
      public function GC_FUND_COUNT(patch:IDataInput) : void
      {
         var count:int = patch.readInt();
         FundMter.fundOwn = count;
         var pan:FundStore = Singleton.getInstance(FundStore) as FundStore;
         if(FundMter.isOpenFundStore)
         {
            if(!pan.visible)
            {
               pan.visible = true;
            }
            FundMter.isOpenFundStore = false;
         }
      }
      
      public function GC_FUND_PAY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         UIManager.centerBroadcast.addMsg("购买成功");
         Global.control.sendNotification(Enum_MsgType.BAIJIN_UPDATA,null);
      }
      
      public function GC_FUND_RECHARGE(patch:IDataInput) : void
      {
         var len:int;
         var i:int;
         var chongMo:int = 0;
         var lvl:int = 0;
         var statusArr:Array = null;
         var pan2:View_chongzhi = null;
         chongMo = patch.readInt();
         lvl = patch.readByte();
         FundMter.baiJinLvl = lvl;
         statusArr = [];
         len = patch.readByte();
         i = 0;
         while(i < len)
         {
            statusArr.push(patch.readByte());
            i++;
         }
         if(FundMter.isOpenChongZhi)
         {
            if(Boolean(FundMter.chongZhiPan))
            {
               FundMter.chongZhiPan.update(chongMo,lvl,statusArr);
            }
            else
            {
               pan2 = Singleton.getInstance(View_chongzhi) as View_chongzhi;
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan2,function():void
               {
                  FundMter.chongZhiPan = pan2;
                  FundMter.chongZhiPan.update(chongMo,lvl,statusArr);
               });
            }
         }
         else if(Boolean(FundMter.chongZhiPan))
         {
            FundMter.chongZhiPan.money = chongMo;
         }
      }
      
      public function GC_GET_REWARD(patch:IDataInput) : void
      {
         var pan2:FundOpen = null;
         var _pan2:FundOpen = null;
         var pan3:FundBuy = null;
         var type:int = patch.readByte();
         var result:int = patch.readByte();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            if(type == 1)
            {
               UIManager.centerBroadcast.addMsg("恭喜你获得了" + FundMter.getJiJing + "基金");
               pan2 = Singleton.getInstance(FundOpen) as FundOpen;
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan2,function():void
               {
                  pan2.getAward(FundMter._index);
               });
            }
            else if(type == 2)
            {
               FundMter.chongZhiPan.getAward(FundMter._chongZhiIndex);
            }
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("背包不够了");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("已经领取过了");
         }
         else if(result == 4)
         {
            FundMter.dataArrSave = 0;
            UIManager.centerBroadcast.addMsg("所有返利都已领取完，可以购买新的基金");
            FundConfig.removeEff();
            _pan2 = Singleton.getInstance(FundOpen) as FundOpen;
            if(_pan2.visible)
            {
               _pan2.visible = false;
            }
            pan3 = Singleton.getInstance(FundBuy) as FundBuy;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan3,function():void
            {
               if(!pan3.visible)
               {
                  pan3.visible = true;
               }
            });
         }
      }
   }
}

