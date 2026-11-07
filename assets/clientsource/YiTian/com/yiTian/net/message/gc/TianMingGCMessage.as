package com.yiTian.net.message.gc
{
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.data.model.Model_Tianming;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.TianMingHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.tianMing.TianMing_Container;
   import com.yiTian.view.modules.tianMing.View_MyTianMing;
   import com.yiTian.view.modules.tianMing.View_TianFu;
   import com.yiTian.view.modules.tianMing.View_TianMing;
   import flash.utils.IDataInput;
   import flash.utils.setTimeout;
   
   public class TianMingGCMessage
   {
      
      public function TianMingGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_TIANMING_LIST] = GC_TIANMING_LIST;
         index[MessageType.GC_MY_TIANMING_LIST] = GC_MY_TIANMING_LIST;
         index[MessageType.GC_TIANFU] = GC_TIANFU;
         index[MessageType.GC_ZHUFU] = GC_ZHUFU;
         index[MessageType.GC_COMP_BAG_TIANMING] = GC_COMP_BAG_TIANMING;
         index[MessageType.GC_UP_TIANFU] = GC_UP_TIANFU;
         index[MessageType.GC_UP_ZHUFU] = GC_UP_ZHUFU;
         index[MessageType.GC_USE_TIANMING] = GC_USE_TIANMING;
         index[MessageType.GC_TIANMING_CHEST_USE] = GC_TIANMING_CHEST_USE;
         index[MessageType.GC_USE_BLESSINGFRUIT] = GC_USE_BLESSINGFRUIT;
         index[MessageType.GC_TIANMING_LOCK] = GC_TIANMING_LOCK;
      }
      
      public static function GC_USE_BLESSINGFRUIT(patch:IDataInput) : void
      {
         var value:int = 0;
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               TianMingHandler.useFruitEff();
               value = patch.readInt();
               setTimeout(function():void
               {
                  View_TianFu.instance.tianFu_bar.valueEff(value);
               },850);
               break;
            case 2:
               View_Alert.show(LangConfig.getWord("80216",8),View_Alert.OK_CANCAL,function():void
               {
                  UIManager.sm_shop.visible = true;
               });
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80217",8));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80219",8));
         }
      }
      
      public static function GC_TIANMING_CHEST_USE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80215",8));
         }
      }
      
      public static function GC_USE_TIANMING(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80096",8));
         }
      }
      
      public static function GC_UP_ZHUFU(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80097",8));
               View_TianFu.instance.addFly(2);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80080",8));
         }
      }
      
      public static function GC_UP_TIANFU(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 0:
            case 1:
               View_TianMing.instance.addEff(result);
               View_TianFu.instance.addFly(1);
               setTimeout(function():void
               {
                  View_TianFu.instance.tianFu_bar.valueEff(Enum_TianMing.TIANFUDAN_EXP);
               },850);
               break;
            case 2:
               TianMingHandler.goToShop();
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80082",8));
         }
      }
      
      public static function GC_COMP_BAG_TIANMING(patch:IDataInput) : void
      {
         var id:int = 0;
         var exp:int = 0;
         var otherId:int = 0;
         var type:int = 0;
         var result:int = patch.readByte();
         if(result == 1)
         {
            id = patch.readInt();
            exp = patch.readInt();
            otherId = patch.readInt();
            type = patch.readByte();
            TianMingHandler.gc_comp_bag_tianming(id,exp,otherId,type);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80100",8));
         }
      }
      
      public static function GC_ZHUFU(patch:IDataInput) : void
      {
         var level:int = patch.readInt();
         var exp:int = patch.readInt();
         View_TianFu.instance.upZhuFuInfo(level,exp);
      }
      
      public static function GC_TIANFU(patch:IDataInput) : void
      {
         var level:int = patch.readInt();
         Model_Tianming.tianFuLevel = level;
         View_TianFu.instance.upTianFuInfo();
      }
      
      public static function GC_MY_TIANMING_LIST(patch:IDataInput) : void
      {
         var voVec:Vector.<Array> = TianMingHandler.makeVoArray(patch);
         TianMingHandler.upDataMyTianMing(voVec,Model_Tianming.myTianMing);
         View_MyTianMing.instance.show();
      }
      
      public static function GC_TIANMING_LIST(patch:IDataInput) : void
      {
         var voVec:Vector.<Array> = TianMingHandler.makeVoArray(patch);
         TianMingHandler.upDataTianMing(voVec,Model_Tianming.tianMingVo);
         TianMing_Container.instance.show();
      }
      
      public static function GC_TIANMING_LOCK(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("锁定天命");
         }
         else
         {
            UIManager.centerBroadcast.addMsg("解锁天命");
         }
      }
   }
}

