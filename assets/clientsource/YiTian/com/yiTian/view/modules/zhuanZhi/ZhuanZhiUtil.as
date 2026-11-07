package com.yiTian.view.modules.zhuanZhi
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ZhuanZhiCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class ZhuanZhiUtil
   {
      
      public static var zhuanZhiTipBtn:BitmapBtn;
      
      private static var lastClickTime:int;
      
      private static var _scaleSp:Sprite;
      
      private static var _targetY:Number = -25;
      
      public function ZhuanZhiUtil()
      {
         super();
      }
      
      public static function getCanSumitTaskIndex(infos:Array) : int
      {
         var r:int = -1;
         var i:int = 0;
         while(i < infos.length)
         {
            if(infos[i][1] == 2)
            {
               r = i;
               break;
            }
            i += 1;
         }
         return r;
      }
      
      public static function getBestChooseIndex(infos:Array) : int
      {
         var r:int = 2;
         var i:int = 0;
         while(i < infos.length)
         {
            if(infos[i][1] >= 1 && infos[i][1] <= 2)
            {
               r = i;
               break;
            }
            i += 1;
         }
         return r;
      }
      
      public static function updateTipBtn(b:Boolean) : void
      {
         if(!zhuanZhiTipBtn)
         {
            return;
         }
         if(b && !zhuanZhiTipBtn.extraObject)
         {
            if(!_scaleSp)
            {
               _scaleSp = new Sprite();
               var _temp_2:* = _scaleSp;
               _scaleSp.scaleY = 0.7;
               _temp_2.scaleX = 0.7;
            }
            zhuanZhiTipBtn.addChild(_scaleSp);
            zhuanZhiTipBtn.extraObject = EffectManager.addEffect("35343",_scaleSp,1000,32,29,true);
         }
         else if(!b && Boolean(zhuanZhiTipBtn.extraObject))
         {
            EffectManager.removeEffect(zhuanZhiTipBtn.extraObject as Effect);
            zhuanZhiTipBtn.removeChild(_scaleSp);
            zhuanZhiTipBtn.extraObject = null;
         }
      }
      
      public static function getJobGridVos() : Array
      {
         var baseJob:int = int(Enum_job.getBaseJob(GameUnitManager.hero.job));
         var zIndex:int = int(Enum_job.getChildJobZ(baseJob));
         var xIndex:int = int(Enum_job.getChildJobX(baseJob));
         var dic:Dictionary = Data_lib.zhuanzhiAtt;
         var tmpz:Array = Util.splicObj(Data_lib.zhuanzhiAtt[zIndex][0],"_") as Array;
         var tmpx:Array = Util.splicObj(Data_lib.zhuanzhiAtt[xIndex][0],"_") as Array;
         return [toVos(tmpz),toVos(tmpx)];
      }
      
      public static function toVos(arr:Array) : Array
      {
         var vo_s:Vo_Skill = null;
         var r:Array = [];
         var i:int = 0;
         while(i < arr.length)
         {
            vo_s = new Vo_Skill(int(arr[i]));
            r.push(vo_s);
            i += 1;
         }
         return r;
      }
      
      private static function tweenBtn() : void
      {
         _targetY = _targetY == -25 ? -18 : -25;
         Tween.curTo(zhuanZhiTipBtn,800,{"y":_targetY},tweenBtn);
      }
      
      public static function checkAddBtn(lv:int) : Boolean
      {
         if(lv >= 90)
         {
            zhuanZhiTipBtn = new BitmapBtn();
            zhuanZhiTipBtn.init();
            zhuanZhiTipBtn.buttonMode = true;
            zhuanZhiTipBtn.setBgDir("resource/image/zhuanZhi/mainIconMini.png");
            zhuanZhiTipBtn.clickCallBack = clickHd;
            zhuanZhiTipBtn.y = -20;
            zhuanZhiTipBtn.addEventListener(MouseEvent.ROLL_OVER,onTipOver);
            zhuanZhiTipBtn.addEventListener(MouseEvent.ROLL_OUT,onTipOut);
            UIManager.special_btn.appendItem(zhuanZhiTipBtn);
            if(Enum_job.getChildWay(GameUnitManager.hero.job) == 0)
            {
               tweenBtn();
            }
            return true;
         }
         return false;
      }
      
      private static function onTipOver(e:MouseEvent) : void
      {
         zhuanZhiTipBtn.filters = Util.glowFFFF00;
         zhuanZhiTipBtn.y = -25;
      }
      
      private static function onTipOut(e:MouseEvent) : void
      {
         zhuanZhiTipBtn.filters = null;
         zhuanZhiTipBtn.y = -20;
      }
      
      public static function init() : void
      {
         Model_zhuanZhi.myState = 1;
         if(!checkAddBtn(GameUnitManager.hero.level))
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,onLvUp);
         }
      }
      
      private static function onLvUp(lv:int) : void
      {
         if(checkAddBtn(lv))
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,onLvUp);
         }
      }
      
      private static function clickHd(e:MouseEvent) : void
      {
         var now:int;
         var zhuanZhiPnl:View_zhuanZhiPanel = null;
         var zhuanZhiTaskPnl:View_zhuanZhiTask = null;
         var zhuanZhiWayPnl:View_zhuanZhiFangXiang = null;
         Tween.stop(zhuanZhiTipBtn);
         now = getTimer();
         if(now - lastClickTime <= 500)
         {
            return;
         }
         lastClickTime = now;
         if(Model_zhuanZhi.myState == -1)
         {
            return;
         }
         switch(Model_zhuanZhi.myState)
         {
            case 1:
               zhuanZhiPnl = Singleton.getInstance(View_zhuanZhiPanel);
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(zhuanZhiPnl,function():void
               {
                  zhuanZhiPnl.visible = !zhuanZhiPnl.visible;
               });
               break;
            case 2:
               zhuanZhiTaskPnl = Singleton.getInstance(View_zhuanZhiTask);
               if(zhuanZhiTaskPnl.visible)
               {
                  zhuanZhiTaskPnl.visible = false;
               }
               else
               {
                  ZhuanZhiCGMessage.CG_ZZ_ZHUANZHIINFO();
                  (Singleton.getInstance(Delegate123) as Delegate123).dosomething(zhuanZhiTaskPnl,function():void
                  {
                     zhuanZhiTaskPnl.visible = true;
                  });
               }
               break;
            case 3:
               zhuanZhiWayPnl = Singleton.getInstance(View_zhuanZhiFangXiang);
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(zhuanZhiWayPnl,function():void
               {
                  zhuanZhiWayPnl.visible = !zhuanZhiWayPnl.visible;
               });
         }
      }
      
      public static function getJobTipText(jobIndex:int) : String
      {
         var baseJob:int = int(Enum_job.getBaseJob(jobIndex));
         var arr:Array = Enum_job.TXT;
         var name:String = Enum_job.getJobColorStr(Enum_job.TXT[baseJob - 1],baseJob) + Enum_job.getJobWayLabel(jobIndex,true);
         return name + "\n" + getAttAdd(jobIndex);
      }
      
      public static function getAttAdd(jobIndex:int) : String
      {
         var arr:Array = null;
         var name:String = null;
         var r:String = null;
         var src:String = Data_lib.zhuanzhiAtt[jobIndex][1];
         var infos:Array = Util.splicObj(src,",_") as Array;
         var rr:Array = [];
         for each(arr in infos)
         {
            name = Data_lib.attribute[arr[0]][0];
            if(Data_lib.attribute[arr[0]][1] == 1)
            {
               r = Util.rep(LangConfig.getWord("1081",0),name,arr[1]);
            }
            else
            {
               r = Util.rep(LangConfig.getWord("1081",0),name,arr[1] + "%");
            }
            rr.push(r);
         }
         return rr.join("");
      }
      
      public static function getMeriAdd(jobIndex:int) : String
      {
         return Data_lib.zhuanzhiAtt[jobIndex][2];
      }
      
      public static function getDescript(id:int) : String
      {
         return Data_lib.zhuanzhiTask[id][0];
      }
      
      public static function getRewardStr(id:int) : String
      {
         return Data_lib.zhuanzhiTask[id][3];
      }
      
      public static function getCondDescript(id:int) : String
      {
         var arr:Array = null;
         var itemItemID:int = 0;
         var needNum:int = 0;
         var hasNum:int = 0;
         var itemName:String = null;
         var c:String = null;
         var src:String = Data_lib.zhuanzhiTask[id][1];
         var cond:String = Data_lib.zhuanzhiTask[id][2];
         if(cond == "0")
         {
            return src;
         }
         var needItemInfo:Array = Util.splicObj(cond,",_") as Array;
         var itemInfoArr:Array = [];
         for each(arr in needItemInfo)
         {
            itemItemID = int(arr[0]);
            needNum = int(arr[1]);
            hasNum = CommandManager.get_bag_count(itemItemID);
            if(hasNum > needNum)
            {
               hasNum = needNum;
            }
            itemName = Data_lib.item[itemItemID][Enum_lib_item.STR_NAME];
            c = hasNum >= needNum ? "#33ff33" : "#ff3333";
            itemInfoArr.push(itemName + HtmlUtil.fontNoSize(hasNum + "/" + needNum,c));
         }
         return Util.rep(src,itemInfoArr.join(" "));
      }
      
      public static function getNextSkillID(skillID:int, jobWay:int) : int
      {
         var r:int = 0;
         switch(jobWay)
         {
            case 1:
               r = skillID + 10;
               break;
            case 2:
               r = skillID + 20;
               break;
            default:
               r = skillID;
         }
         return r;
      }
   }
}

