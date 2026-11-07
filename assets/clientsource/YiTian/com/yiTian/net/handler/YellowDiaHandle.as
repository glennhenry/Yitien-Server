package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.yellowDiamond.tiXingXuFei.YellowDiaXFPan;
   
   public class YellowDiaHandle
   {
      
      public function YellowDiaHandle()
      {
         super();
      }
      
      public static function YelloDiaGCMessage(isDiaCustor:int, isYeaDiaCustor:int, DiaLevel:int, canLvlGoodsGet:int, canLvlGrowGoodsGet:int, yeaCostCanGet:int, yeaNewsCanGet:int, _level:int, isYellowPetCanGet:int, haohua:int) : void
      {
         UIManager.yellowDiamond.updata(isDiaCustor,isYeaDiaCustor,DiaLevel,canLvlGoodsGet,canLvlGrowGoodsGet,yeaCostCanGet,yeaNewsCanGet,_level,isYellowPetCanGet,haohua);
      }
      
      public static function GC_YELLOWDIAMOND_AWARD(type:int, _level:int, canGetAward:int) : void
      {
         UIManager.yellowDiamond.updataTypeGet(type,canGetAward,_level);
      }
      
      public static function GC_YELLOWDIAMOND_EFF() : void
      {
         UIManager.special_btn.showYD(true);
      }
      
      public static function GC_OPEN_QQGIFT(_days:int, _status:int) : void
      {
         UIManager.onlineAward.update(_days,_status,1);
      }
      
      public static function GC_GET_QQGIFT() : void
      {
         UIManager.onlineAward.getGoods();
      }
      
      public static function GC_GET_AIWAN_GIFT() : void
      {
         UIManager.onlineAward.getGoods();
      }
      
      public static function GC_GET_CHITU_GIFT() : void
      {
         UIManager.onlineAward.getGoods();
      }
      
      public static function GC_KUANGHUAN_GIFT() : void
      {
         UIManager.yellowDiamond.showQQgiftKH();
      }
      
      public static function GC_KUANGHUAN_GET_GIFT() : void
      {
         UIManager.yellowDiamond.removeQQgiftKH();
      }
      
      public static function GC_OLD_PLAYERS_RETURN() : void
      {
         UIManager.yellowDiamond.showIcon();
      }
      
      public static function GC_OLD_PLAYERS_RETURN_GETGOODS() : void
      {
         UIManager.yellowDiamond.getG();
      }
      
      public static function GC_XIANSHI_HUODONG(leastLvl:int, startTime:String, endTime:String, dataArr:Array) : void
      {
         UIManager.xshdPan.setData(leastLvl,startTime,endTime,dataArr);
      }
      
      public static function GC_XIANSHI_GET(result:int) : void
      {
         UIManager.centerBroadcast.addMsg("领取成功");
         UIManager.xshdPan.getData();
      }
      
      public static function GC_OPEN_AIWAN_GIFT(_days:int, _status:int) : void
      {
         UIManager.onlineAward.update(_days,_status,2);
      }
      
      public static function GC_OPEN_CHITU_GIFT(_days:int, _status:int) : void
      {
         UIManager.onlineAward.update(_days,_status,3);
      }
      
      public static function GC_HUANGZUAN_XF_SHOWPAN(result:int, roleName:String) : void
      {
         var _result:int = 0;
         var _roleName:String = null;
         _result = result;
         _roleName = roleName;
         if(_result == 0 || _result == 1)
         {
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(YellowDiaXFPan.instance,function():void
            {
               YellowDiaXFPan.instance.show(_result,_roleName);
            });
         }
      }
      
      public static function GC_HUANGZUAN_XF_ASK(isEnable:int) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(YellowDiaXFPan.instance,function():void
         {
            YellowDiaXFPan.instance.xuFei(isEnable);
         });
      }
   }
}

