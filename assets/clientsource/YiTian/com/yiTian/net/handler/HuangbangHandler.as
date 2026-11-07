package com.yiTian.net.handler
{
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HuangbangCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.huangbang.Enum_Huangbang;
   import com.yiTian.view.modules.huangbang.LoopPoint;
   import com.yiTian.view.modules.huangbang.Model_Huangbang;
   import com.yiTian.view.modules.huangbang.View_HuangbangHelpPanel;
   import com.yiTian.view.modules.huangbang.View_HuangbangInfoPanel;
   import com.yiTian.view.modules.huangbang.View_HuangbangPanel;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class HuangbangHandler
   {
      
      public function HuangbangHandler()
      {
         super();
      }
      
      public static function GC_ENTER_HUANGBANG(isFirst:int, currentCount:int, loop:int, whatWeek:int, Count:int, exp:Number) : void
      {
         var jumpLastPoint:Function = null;
         Model_Huangbang.isFirstEnter = isFirst == 0 ? true : false;
         Model_Huangbang.remainCount = Count - currentCount;
         Model_Huangbang.currentCount = currentCount;
         Model_Huangbang.currentLoop = loop;
         if(whatWeek == 0)
         {
            Model_Huangbang.totalCount = Count;
         }
         else
         {
            Model_Huangbang.totalCount = Count;
         }
         if(SceneConfig.getSceneType() == SceneConfig.HUANGBANG)
         {
            if(Model_Huangbang.currentLoop == Enum_Huangbang.MAX_QUALITY)
            {
               jumpLastPoint = function():void
               {
                  Global.delegate.dosomething(View_HuangbangInfoPanel.instance,View_HuangbangInfoPanel.instance.show);
                  HuangbangCGMessage.CG_JUMP_LAST_POINT();
                  Global.control.removeCallBack(Enum_Huangbang.JUMP_LAST_POINT,jumpLastPoint);
               };
               Global.control.registerCallBack(Enum_Huangbang.JUMP_LAST_POINT,jumpLastPoint);
            }
            else
            {
               Global.delegate.dosomething(View_HuangbangInfoPanel.instance,View_HuangbangInfoPanel.instance.show);
            }
            View_HuangbangInfoPanel.instance.setReward("<font color =\'#04ff00\'>经验：" + exp + "</font>");
            UIManager.questTraceView.update();
            UIManager.questPanel.update();
         }
         if(Model_Huangbang.isFirstEnter == true)
         {
            View_HuangbangHelpPanel.instance.visible = true;
         }
      }
      
      public static function GC_SHAKER(shakerPoint:int, questId:int, isLink:int, XYStr:String, route:String) : void
      {
         var XYArr:Array;
         var shakerFinish:Function = null;
         shakerFinish = function():void
         {
            var i:int;
            var pos:int;
            var loopPoint:LoopPoint;
            var timeOut:int = 0;
            timeOut = int(setTimeout(function():void
            {
               View_HuangbangPanel.instance.tou.visible = false;
               clearTimeout(timeOut);
            },2000));
            var arr:Array = route.split(",");
            Model_Huangbang.routeArr = [];
            i = 0;
            while(i < arr.length)
            {
               Model_Huangbang.routeArr.push(arr[i].toString().split("_"));
               i++;
            }
            if(!Model_Huangbang.routeArr || !Model_Huangbang.routeArr.length)
            {
               return;
            }
            pos = Model_Huangbang.routeArr.shift();
            loopPoint = GameUnitManager.findUnit(Enum_Huangbang.HUANGBANG_NUM + pos,UnitType.HUANGBANG_POINT) as LoopPoint;
            if(!loopPoint)
            {
               return;
            }
            View_HuangbangInfoPanel.instance.goPoint(loopPoint);
            Global.control.removeCallBack(Enum_Huangbang.SHAKER,shakerFinish);
            if(Boolean(Model_Huangbang.heroStandPoint))
            {
               Model_Huangbang.heroStandPoint.addEff();
               GameUnitManager.addUnit(Model_Huangbang.heroStandPoint);
            }
         };
         if(route == null || route == "")
         {
            return;
         }
         View_HuangbangPanel.instance.tou.visible = true;
         View_HuangbangPanel.instance.tou.roll(shakerPoint);
         XYArr = XYStr.split("_");
         Model_Huangbang.isLink = isLink == 1 ? true : false;
         if(Model_Huangbang.isLink == true)
         {
            Model_Huangbang.linkPoint = new Point(XYArr[0],XYArr[1]);
         }
         Model_Huangbang.currentQuestId = questId;
         Global.control.registerCallBack(Enum_Huangbang.SHAKER,shakerFinish);
      }
      
      public static function GC_FAST_FINISH_HUANGBANG(result:int) : void
      {
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("任务快速完成成功");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      public static function GC_FAST_FINISH_HUANGBANG_TEN(result:int) : void
      {
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("成功完成任务");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      public static function GC_GIVE_UP_HUANGBANG(result:int, currentCount:int) : void
      {
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("放弃任务成功");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("失败");
         }
         Model_Huangbang.remainCount = 100 - currentCount;
      }
      
      public static function GC_JUMP_HUANGBANG(x:int, y:int) : void
      {
         View_HuangbangInfoPanel.instance.jumpPoint(x,y);
      }
      
      public static function GC_GET_LASTWEEK_QUEST(result:int, count:int) : void
      {
         switch(result)
         {
            case 0:
               Model_Huangbang.lastWeekRemainCount = count;
               View_Alert.show("上周周任务剩余次数<font color=\'" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\'>" + Model_Huangbang.lastWeekRemainCount + "次，</font>是否花费<font color=\'" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\'>" + Model_Huangbang.lastWeekRemainCount + "元宝</font>找回",View_Alert.OK_CANCAL,function():void
               {
                  HuangbangCGMessage.CG_GET_LASTWEEK_QUEST_CONFIRM();
               });
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("本周任务没有完成不能找回上周任务");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已没有可找回的上周任务");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("上周没有剩余任务");
         }
      }
      
      public static function GC_GET_LASTWEEK_QUEST_CONFIRM(result:int) : void
      {
         switch(result)
         {
            case 0:
               View_HuangbangPanel.instance.showShake();
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      public static function GC_HUANGBANG_REWARD(exp:Number) : void
      {
         View_Alert.show("恭喜你揭开周任务的龙盘大奖，获得\n           <font color=\'" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\'>经验：" + exp + "*" + Model_Huangbang.remainCount + "\n           龙盘大礼*1</font>",View_Alert.OK,function():void
         {
         });
      }
      
      public static function GC_HUANGBANG_OTHER_REWARD(itemStr:String) : void
      {
         var itemArr:Array = itemStr.split(",");
         var arr:Array = [];
         var str:String = "本周100次任务完成，获得";
         var i:int = 0;
         while(i < itemArr.length)
         {
            arr = itemArr[i].toString().split("_");
            str += HtmlUtil.fontNoSize(Data_lib.item[arr[0]][Enum_lib_item.STR_NAME] + "*" + arr[1],ColorConstant.getColorStr(ColorConstant.GREEN));
            if(i < itemArr.length - 1)
            {
               str += ",";
            }
            i++;
         }
         UIManager.centerBroadcast.addMsg(str);
      }
   }
}

