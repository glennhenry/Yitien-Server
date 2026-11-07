package com.yiTian.view.modules.shenBing
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_lib_attribute;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ShenBingCGMessage;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class ShenBingUtil
   {
      
      public static var _tipBtn:BitmapBtn;
      
      public static var filterss:Array = [null,[new GlowFilter(16777215,1,16,16)],[new GlowFilter(3407667,1,16,16)],[new GlowFilter(3355647,1,16,16)],[new GlowFilter(16724991,1,16,16)],[new GlowFilter(16750899,1,16,16)]];
      
      public static const SB_INTRODUCE:String = "<font color=\'#ffff00\' size=\'14\'>神兵玩法介绍</font><br>" + "<font color=\'#dddd33\'>神兵淬炼</font><br>等级到达<font color=\'#ffff33\'>70级</font>的玩家都可拥有自己的神兵，玩家可通过<font color=\'#ffff33\'>神兵淬炼</font>功能提升神兵等级，淬炼可获得<font color=\'#ffff33\'>角色属性加成</font>；淬炼需要<font color=\'#ffff33\'>玉牌</font>；<br>" + "<font color=\'#dddd33\'>神兵技能</font><br>淬炼达到一定等级时，可激活对应神兵卡槽，卡槽可用来<font color=\'#ffff33\'>刻印</font>神兵技能；玩家可通过<font color=\'#ffff33\'>技能兑换</font>功能兑换<font color=\'#ffff33\'>神兵技能</font>；只有刻印后的神兵技能方可发挥威力；神兵技能概率触发，刻印的技能数量越多，技能触发的几率越大；神兵技能也可进行<font color=\'#ffff33\'>升级</font>，升级后的技能效果将大幅提升；兑换和升级神兵技能需消耗<font color=\'#ffff33\'>神兵技能碎片</font><br>" + "<font color=\'#ff3333\'>注：神兵技能只在PVP战斗中生效！</font>";
      
      public static const ATB_ICON:String = "resource/image/shenBing/atbIcon.png";
      
      public static const colorLabel:Array = [null,"白","绿","蓝","紫","橙"];
      
      public static var OPEN_CONDITION:Array = [75,5,80,10,85,20,90,30,95,45,100,60];
      
      public static const OPEN_CNDITION_REP:String = "角色等级达到 <font color=\'{0}\'>{1}</font> 级\n               淬炼等级达到 <font color=\'{2}\'>{3}</font> 级";
      
      public static const YUPAI_ID:int = 44749;
      
      public static const SHENBING_CHIP_ID:int = 44746;
      
      public static const PERCOST:int = 10;
      
      public function ShenBingUtil()
      {
         super();
      }
      
      public static function getConditionString(gridIndex:int) : String
      {
         var needRoleLv:int = int(OPEN_CONDITION[gridIndex * 2]);
         var needCuiLianLv:int = int(OPEN_CONDITION[gridIndex * 2 + 1]);
         var c1:String = GameUnitManager.hero.level >= needRoleLv ? "#33ff33" : "#ff3333";
         var c2:String = Model_ShenBing._curLevel >= needCuiLianLv ? "#33ff33" : "#ff3333";
         return LangConfig.reTxt(OPEN_CNDITION_REP,c1,needRoleLv,c2,needCuiLianLv);
      }
      
      public static function getIconUrl(id:int) : String
      {
         return "resource/image/icon/" + Data_lib.sbSkill[id][Enum_ShenBing.SKILL_ICON] + ".png";
      }
      
      public static function askOpenShenBingPanel(prm:* = null) : void
      {
         var pnl:View_ShenBingPanel = null;
         if(GameUnitManager.hero.level < 70)
         {
            UIManager.centerBroadcast.addMsg("神兵将在角色等级达到70级以后开放");
            return;
         }
         pnl = UIManager.shenBingPanel;
         Global.delegate.dosomething(pnl,pnl.visible ? function():void
         {
            pnl.hide(prm);
         } : function():void
         {
            pnl.show(prm);
         });
      }
      
      public static function askOpenSkillStore(prm:* = null) : void
      {
         var storePnl:View_ShenBingSkillStore = null;
         storePnl = UIManager.shenbingSkillStore;
         Global.delegate.dosomething(storePnl,storePnl.visible ? function():void
         {
            storePnl.hide(prm);
         } : function():void
         {
            storePnl.show(prm);
         });
      }
      
      public static function askOpenUpdateView(prm:* = null) : void
      {
         var updatePnl:View_ShenBingSkillUpdate = null;
         updatePnl = UIManager.shenBingSkillUpdate;
         Global.delegate.dosomething(updatePnl,updatePnl.visible ? function():void
         {
            updatePnl.hide(prm);
         } : function():void
         {
            updatePnl.show(prm);
         });
      }
      
      public static function askCuiLian(times:int) : void
      {
         if(!ShenBingUtil.askSendCuiLian(1,times))
         {
            View_CuiLianPrompt.instance.show(times);
         }
      }
      
      public static function askSendCuiLian(costType:int, times:int) : Boolean
      {
         if(costType == 1)
         {
            if(CommandManager.get_bag_count(SHENBING_CHIP_ID) >= times)
            {
               ShenBingCGMessage.CG_CUILIAN(1,times == 5 ? 2 : 1);
               return true;
            }
            UIManager.centerBroadcast.addMsg("您的玉牌不足");
         }
         else if(costType == 2)
         {
            if(GameUnitManager.hero.money >= times * PERCOST)
            {
               ShenBingCGMessage.CG_CUILIAN(2,times == 5 ? 2 : 1);
               return true;
            }
            UIManager.centerBroadcast.addMsg("元宝不足，请及时充值");
         }
         return false;
      }
      
      public static function explainAtbStr(v:String, rep:String = "<font color=\'#ffff33\'>{0}</font><font color=\'#33ff33\'>+{1}</font>") : Array
      {
         var isDef:Boolean = false;
         var a:Array = null;
         var temp:Array = null;
         var tempRate:Number = NaN;
         var atbName:String = null;
         var atbValue:String = null;
         var arr:Array = Util.splicObj(v,",_") as Array;
         var result:Array = [];
         if(Boolean(Model_ShenBing.heroShenBingVO) && Boolean(Model_ShenBing.heroShenBingVO.atbs) && Boolean(Model_ShenBing.heroShenBingVO.atbs.length))
         {
            temp = Model_ShenBing.heroShenBingVO.atbs.concat();
            tempRate = temp[2] / temp[1];
         }
         var flag:int = 0;
         var tempArr:Array = [];
         for each(a in arr)
         {
            atbName = Data_lib.attribute[a[0]][Enum_lib_attribute.STR_NAME] + " ";
            atbValue = a[1];
            flag++;
            if(Boolean(temp) && Boolean(temp.length))
            {
               isDef = true;
               tempArr.push("<font color=\'#f9ff00\'>（+" + temp[flag * 3 - 1] + "）</font>");
            }
            result.push(Util.rep(rep,atbName,atbValue));
         }
         if(isDef)
         {
            result.push(tempArr);
         }
         return result;
      }
      
      public static function explainAtbStrNxt(v:String, rep:String = "<font color=\'#ffff33\'>{0}</font><font color=\'#33ff33\'>+{1}</font>") : Array
      {
         var a:Array = null;
         var temp:Array = null;
         var tempRate:Number = NaN;
         var atbName:String = null;
         var atbValue:String = null;
         var arr:Array = Util.splicObj(v,",_") as Array;
         var result:Array = [];
         if(Boolean(Model_ShenBing.heroShenBingVO) && Boolean(Model_ShenBing.heroShenBingVO.atbs) && Boolean(Model_ShenBing.heroShenBingVO.atbs.length))
         {
            temp = Model_ShenBing.heroShenBingVO.atbs.concat();
            tempRate = temp[2] / temp[1];
         }
         var flag:int = 0;
         for each(a in arr)
         {
            atbName = Data_lib.attribute[a[0]][Enum_lib_attribute.STR_NAME] + " ";
            atbValue = a[1];
            flag++;
            if(Boolean(temp) && Boolean(temp.length))
            {
               if(flag == 0)
               {
                  atbValue += "<font color=\'#f9ff00\'>（+" + temp[2] + "）</font>";
               }
               else
               {
                  atbValue += "<font color=\'#f9ff00\'>（+" + Math.ceil(int(atbValue) * temp[2] / temp[1]) + "）</font>";
               }
            }
            result.push(Util.rep(rep,atbName,atbValue));
         }
         return result;
      }
      
      public static function getWeaponURl() : String
      {
         var token:String = null;
         var jobIndex:int = int(Enum_job.getBaseJob(GameUnitManager.hero.job));
         if(jobIndex == 1)
         {
            token = "D";
         }
         else if(jobIndex == 2)
         {
            token = "J";
         }
         else if(jobIndex == 3)
         {
            token = "S";
         }
         else if(jobIndex == 4)
         {
            token = "H";
         }
         return "resource/image/shenBingWeapon/" + token + Model_ShenBing.shenBingLv + ".png";
      }
      
      public static function init() : void
      {
         if(GameUnitManager.hero.level >= 70)
         {
            isShowBtn(true);
         }
         else
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,lvUpHandler);
         }
      }
      
      private static function lvUpHandler(lv:int) : void
      {
         if(lv >= 70)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,lvUpHandler);
            isShowBtn(true);
         }
      }
      
      private static function isShowBtn(v:Boolean) : void
      {
         if(v)
         {
            if(!_tipBtn)
            {
               _tipBtn = new BitmapBtn();
               _tipBtn.init();
               _tipBtn.buttonMode = true;
               _tipBtn.setBgDir("resource/image/shenBing/mainBtn.png");
               _tipBtn.y = -20;
               _tipBtn.clickCallBack = clickHd;
               _tipBtn.addEventListener(MouseEvent.ROLL_OUT,rollOutHd);
               _tipBtn.addEventListener(MouseEvent.ROLL_OVER,rollOverHd);
            }
            UIManager.special_btn.appendItem(_tipBtn);
         }
      }
      
      protected static function rollOverHd(event:MouseEvent) : void
      {
         _tipBtn.filters = Util.glowBigFFff00;
      }
      
      protected static function rollOutHd(event:MouseEvent) : void
      {
         _tipBtn.filters = null;
      }
      
      private static function clickHd(e:MouseEvent) : void
      {
         askOpenShenBingPanel();
      }
   }
}

