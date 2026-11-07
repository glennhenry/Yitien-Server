package com.yiTian.net.handler
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.horse.Model_horse;
   import com.yiTian.view.modules.horse.View_horseLibPanel;
   import com.yiTian.view.modules.horse.View_horsePanel;
   import com.yiTian.view.modules.horse.starSign.Model_XingZuo;
   import com.yiTian.view.modules.horse.starSign.View_XingZuoBreakTip;
   
   public class HorseHandler
   {
      
      public function HorseHandler()
      {
         super();
      }
      
      public static function GC_HORSE_PARTS_INFO(infos:Array, atbs:String, baseAtbs:String) : void
      {
         var a:Array = null;
         var baseInfos:Array = null;
         var aa:Array = null;
         var pnl:View_horsePanel = null;
         infos.splice(2,0,infos.pop());
         infos.splice(2,0,infos.pop());
         Model_horse.partInfos = infos;
         infos = Util.splicObj(atbs,",_") as Array;
         for each(a in infos)
         {
            if(a[0] == "92")
            {
               Model_horse.extraMoveSpeed = parseInt(a[1]);
               break;
            }
         }
         baseInfos = Util.splicObj(baseAtbs,",_") as Array;
         for each(aa in baseInfos)
         {
            if(aa[0] == "92")
            {
               Model_horse.baseMoveSpeed = parseInt(aa[1]);
               break;
            }
         }
         pnl = Singleton.getInstance(View_horsePanel);
         Global.delegate.dosomething(pnl,function():void
         {
            pnl.horsePart.updateParts();
            pnl.horsePart.updateSpeed();
         });
      }
      
      public static function GC_HORSE_QIANGHUA(result:int) : void
      {
         var pnl:View_horsePanel = null;
         switch(result)
         {
            case 1:
               pnl = Singleton.getInstance(View_horsePanel);
               Global.delegate.dosomething(pnl,function():void
               {
                  pnl.qiangHua._leftHorse.maimengDefault();
               });
               break;
            case 2:
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29487",2));
               break;
            default:
               UIManager.centerBroadcast.addMsg("error  msg:" + result);
         }
         pnl = Singleton.getInstance(View_horsePanel);
         Global.delegate.dosomething(pnl,function():void
         {
            pnl.qiangHua.showEff(result);
         });
      }
      
      public static function GC_HORSE_LIB(infos:Array, curRide:int) : void
      {
         var o:Object = {};
         var i:int = 0;
         while(i < infos.length)
         {
            o[infos[i]] = infos[i + 1];
            i += 2;
         }
         Model_horse.libInfos = o;
         Model_horse.myRidder = curRide;
         var pnl:View_horseLibPanel = Singleton.getInstance(View_horseLibPanel);
         Global.delegate.dosomething(pnl,pnl.libPan.updateInfos);
         Global.delegate.dosomething(pnl,pnl.cardPan.updateInfos);
         if(pnl.xingZuoPan != null)
         {
            Global.delegate.dosomething(pnl,pnl.xingZuoPan.updateInfos);
         }
      }
      
      public static function GC_HORSEDUANZAO(result:int) : void
      {
         var pnl:View_horsePanel = null;
         switch(result)
         {
            case 1:
               pnl = Singleton.getInstance(View_horsePanel);
               Global.delegate.dosomething(pnl,function():void
               {
                  pnl.horsePart.maimeng();
                  pnl.horsePart.showSuccess();
               });
               break;
            case 2:
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("20241",2));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29488",2));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29489",2));
               break;
            default:
               UIManager.centerBroadcast.addMsg("error  msg:" + result);
         }
      }
      
      public static function GC_HORSE_QIANGHUA_INFO(luck:int, horseStar:int, horseId:int) : void
      {
         var pnl:View_horsePanel = null;
         pnl = Singleton.getInstance(View_horsePanel);
         Model_horse.qiangHuaLucky = luck;
         Model_horse.qiangHuaStar = horseStar;
         Model_horse.qiangHuaHorseId = horseId;
         Global.delegate.dosomething(pnl,function():void
         {
            pnl.qiangHua.updateQiangHuaInfo();
            pnl.qiangHua.updateHorseLv();
         });
      }
      
      public static function GC_HORSE_JINJIE() : void
      {
         var pnl:View_horsePanel = null;
         pnl = Singleton.getInstance(View_horsePanel);
         Global.delegate.dosomething(pnl,function():void
         {
            pnl.horseJinJie.showUpdateAni();
            pnl.horseJinJie.showSuccess();
         });
         UIManager.centerBroadcast.addMsg("坐骑进阶成功");
      }
      
      public static function GC_HORSE_LIB_ENABLE(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29490",2));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29491",2));
         }
      }
      
      public static function GC_HORSE_JINJIE_INFO(id:int) : void
      {
         var pnl:View_horsePanel = null;
         pnl = Singleton.getInstance(View_horsePanel);
         Model_horse.curJinJieId = id;
         Global.delegate.dosomething(pnl,function():void
         {
            pnl.horseJinJie.updateInfos();
         });
      }
      
      public static function GC_HORSE_SHOW_AND_HIDE(result:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("跑镖途中不能下坐骑");
         }
         else if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("切换成功");
         }
      }
      
      public static function GC_STARSIGN(xingzuo:int, signID:int) : void
      {
         Model_XingZuo.setXingZuoLevel(xingzuo,signID);
      }
      
      public static function GC_ENABLE_STARSIGN(rest:int, preID:int, afterID:int) : void
      {
         var tip:String = null;
         if(rest == 1)
         {
            if(Model_XingZuo.signLevel != -1)
            {
               Model_XingZuo.setXingZuoLevel(Model_XingZuo.signLevel,afterID);
            }
            tip = "恭喜您激活成功";
         }
         else if(rest == 2)
         {
            tip = "您的银两不足";
         }
         else if(rest == 3)
         {
            tip = "您的星泪不足";
         }
         else if(rest == 4)
         {
            tip = "星泪之力聚集失败";
         }
         else if(rest == 5)
         {
            tip = "活动未开启";
         }
         else if(rest == 6)
         {
            tip = "已经是最高级";
         }
         else if(rest == 7)
         {
            tip = "锻造等级不足，未开启该星座功能";
         }
         if(tip != null)
         {
            UIManager.centerBroadcast.addMsg(tip,1);
         }
         Model_XingZuo.updateOpenStar(rest,preID,afterID);
      }
      
      public static function GC_XINGLEI_UPDATE(value:int) : void
      {
         Model_XingZuo.updateXingLei(value);
      }
      
      public static function GC_STARSIGN_BREAK_REST(rest:int) : void
      {
         var tip:String = null;
         if(rest == 1)
         {
            Model_XingZuo.isAfterTuPo = 1;
            tip = "突破成功";
         }
         else if(rest == 2)
         {
            tip = "元宝不足";
         }
         else if(rest == 3)
         {
            tip = "突破失败";
         }
         if(tip != null)
         {
            UIManager.centerBroadcast.addMsg(tip,1);
         }
      }
      
      public static function GC_STARSIGN_ATB(equipAtbs:Array) : void
      {
         Model_XingZuo.updateMyEquipAtbs(equipAtbs);
      }
      
      public static function GC_LUCK_BREAK_UPDATE(percent:int, remainTime:int) : void
      {
         var tip:BitmapBtn = null;
         if(percent > 0 && remainTime > 0 && Model_XingZuo.pnlShowTimes == 0)
         {
            tip = new BitmapBtn();
            tip.init();
            tip.setBgDir("resource/image/horse/tip.png");
            UIManager.tipBtnContainer.addItem(tip);
            tip.clickCallBack = function():void
            {
               UIManager.tipBtnContainer.removeItem(tip);
               Global.delegate.dosomething(View_XingZuoBreakTip.instance,function():void
               {
                  View_XingZuoBreakTip.instance.visible = true;
               });
            };
         }
         Model_XingZuo.updateLuckPercent(percent,remainTime);
      }
   }
}

