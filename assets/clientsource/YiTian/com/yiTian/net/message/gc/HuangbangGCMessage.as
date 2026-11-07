package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.HuangbangHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.huangbang.Enum_Huangbang;
   import com.yiTian.view.modules.huangbang.LoopPoint;
   import com.yiTian.view.modules.huangbang.Model_Huangbang;
   import com.yiTian.view.modules.huangbang.View_HuangbangInfoPanel;
   import com.yiTian.view.modules.huangbang.View_HuangbangPanel;
   import flash.utils.IDataInput;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class HuangbangGCMessage
   {
      
      private var needTipCountArr:Array = [25,50,75];
      
      private var oldCurrentCount:int;
      
      public function HuangbangGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ENTER_HUANGBANG] = this.GC_ENTER_HUANGBANG;
         index[MessageType.GC_SHAKER] = this.GC_SHAKER;
         index[MessageType.GC_FAST_FINISH_HUANGBANG] = this.GC_FAST_FINISH_HUANGBANG;
         index[MessageType.GC_FAST_FINISH_HUANGBANG_TEN] = this.GC_FAST_FINISH_HUANGBANG_TEN;
         index[MessageType.GC_GIVE_UP_HUANGBANG] = this.GC_GIVE_UP_HUANGBANG;
         index[MessageType.GC_JUMP_HUANGBANG] = this.GC_JUMP_HUANGBANG;
         index[MessageType.GC_GET_LASTWEEK_QUEST] = this.GC_GET_LASTWEEK_QUEST;
         index[MessageType.GC_GET_LASTWEEK_QUEST_CONFIRM] = this.GC_GET_LASTWEEK_QUEST_CONFIRM;
         index[MessageType.GC_HUANGBANG_REWARD] = this.GC_HUANGBANG_REWARD;
         index[MessageType.GC_HUANGBANG_OTHER_REWARD] = this.GC_HUANGBANG_OTHER_REWARD;
         index[MessageType.GC_EIXT_HUANGBANG] = this.GC_EIXT_HUANGBANG;
         index[MessageType.GC_QUEST_HUANGBANG] = this.GC_QUEST_HUANGBANG;
         index[MessageType.GC_QUEST_HUANGBANG_COUNT] = this.GC_QUEST_HUANGBANG_COUNT;
         index[MessageType.GC_ADD_HUANGBANG_POINT] = this.GC_ADD_HUANGBANG_POINT;
         index[MessageType.GC_LOOK_BACK_QUEST] = this.GC_LOOK_BACK_QUEST;
         index[MessageType.GC_USE_TITEL_RESULT] = this.GC_USE_TITEL_RESULT;
      }
      
      public function GC_ENTER_HUANGBANG(patch:IDataInput) : void
      {
         var isFirst:int = patch.readByte();
         var currentCount:int = patch.readInt();
         var loop:int = patch.readInt();
         var whatWeek:int = patch.readByte();
         var Count:int = patch.readInt();
         var exp:Number = LongUtil.readLong(patch);
         if(isFirst == 2)
         {
            UIManager.centerBroadcast.addMsg("组队状态不能进入皇榜地图");
            return;
         }
         HuangbangHandler.GC_ENTER_HUANGBANG(isFirst,currentCount,loop,whatWeek,Count,exp);
      }
      
      public function GC_SHAKER(patch:IDataInput) : void
      {
         var shakerPoint:int = 0;
         var questId:int = 0;
         var isLink:int = 0;
         var XYStr:String = null;
         var route:String = null;
         var result:int = patch.readByte();
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("投骰成功");
               View_HuangbangPanel.instance.shaizi.hideGuideByClick();
               Model_Huangbang.canClickShake = false;
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("有未完成的任务，请先完成或放弃");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("本周周任务已完成");
               View_HuangbangPanel.instance.shaizi.hideGuideByClick();
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("银两不足");
               break;
            case 4:
               Global.control.registerCallBack(Enum_Huangbang.GOBACK_START,this.goBackTip);
         }
         if(result == 0 || result == 4)
         {
            shakerPoint = patch.readInt();
            questId = patch.readInt();
            isLink = patch.readByte();
            XYStr = patch.readUTF();
            route = patch.readUTF();
            HuangbangHandler.GC_SHAKER(shakerPoint,questId,isLink,XYStr,route);
         }
      }
      
      private function goBackTip() : void
      {
         UIManager.centerBroadcast.addMsg("回到起点，请重新投骰");
         Global.control.removeCallBack(Enum_Huangbang.GOBACK_START,this.goBackTip);
      }
      
      public function GC_FAST_FINISH_HUANGBANG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         HuangbangHandler.GC_FAST_FINISH_HUANGBANG(result);
      }
      
      public function GC_FAST_FINISH_HUANGBANG_TEN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         HuangbangHandler.GC_FAST_FINISH_HUANGBANG_TEN(result);
      }
      
      public function GC_GIVE_UP_HUANGBANG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var currentCount:int = patch.readInt();
         HuangbangHandler.GC_GIVE_UP_HUANGBANG(result,currentCount);
      }
      
      public function GC_JUMP_HUANGBANG(patch:IDataInput) : void
      {
         var x:int = 0;
         var y:int = 0;
         if(SceneConfig.getSceneType() != SceneConfig.HUANGBANG)
         {
            return;
         }
         var result:int = patch.readByte();
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("跳圈成功");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("无道具或元宝不足");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("有未完成的任务，请先完成或放弃");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("本周周任务已完成");
         }
         if(result == 0)
         {
            x = patch.readInt();
            y = patch.readInt();
            HuangbangHandler.GC_JUMP_HUANGBANG(x,y);
         }
      }
      
      public function GC_GET_LASTWEEK_QUEST(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var count:int = patch.readInt();
         HuangbangHandler.GC_GET_LASTWEEK_QUEST(result,count);
      }
      
      public function GC_GET_LASTWEEK_QUEST_CONFIRM(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         HuangbangHandler.GC_GET_LASTWEEK_QUEST_CONFIRM(result);
      }
      
      public function GC_HUANGBANG_REWARD(patch:IDataInput) : void
      {
         var exp:Number = LongUtil.readLong(patch);
         HuangbangHandler.GC_HUANGBANG_REWARD(exp);
      }
      
      public function GC_HUANGBANG_OTHER_REWARD(patch:IDataInput) : void
      {
         var itemStr:String = patch.readUTF();
         HuangbangHandler.GC_HUANGBANG_OTHER_REWARD(itemStr);
      }
      
      public function GC_EIXT_HUANGBANG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 0)
         {
         }
      }
      
      public function GC_QUEST_HUANGBANG(patch:IDataInput) : void
      {
         var questId:int = 0;
         var result:int = 0;
         var currentCount:int = 0;
         questId = patch.readInt();
         result = patch.readByte();
         Global.delegate.dosomething(View_HuangbangInfoPanel.instance,function():void
         {
            View_HuangbangInfoPanel.instance.updateQuestStatus(questId,result);
         });
         if(result == 1)
         {
            currentCount = Model_Huangbang.currentCount + 1;
            if(this.needTipCountArr.indexOf(currentCount) != -1 && this.oldCurrentCount != currentCount)
            {
               UIManager.centerBroadcast.addMsg("第" + currentCount + "轮周任务，获得周任务礼包");
               this.oldCurrentCount = currentCount;
            }
         }
      }
      
      public function GC_QUEST_HUANGBANG_COUNT(patch:IDataInput) : void
      {
         var questId:int = patch.readInt();
         var count:int = patch.readInt();
         Model_Huangbang.currentCount = count;
      }
      
      public function GC_ADD_HUANGBANG_POINT(patch:IDataInput) : void
      {
         var pos:int = 0;
         var arr:Array = null;
         var pointArr:Array = null;
         var point:LoopPoint = null;
         var showAllPoint:Function = null;
         var currentLoop:int = patch.readByte();
         pos = patch.readInt();
         var pointStr:String = patch.readUTF();
         arr = pointStr.split(",");
         pointArr = [];
         if(SceneConfig.getSceneType() == SceneConfig.HUANGBANG)
         {
            showAllPoint = function():void
            {
               var i:int = 0;
               var loopPoint:LoopPoint = null;
               var timeOut:int = 0;
               Model_Huangbang.heroStandPoint = null;
               i = 0;
               while(i < arr.length)
               {
                  pointArr.push(arr[i].toString().split("_"));
                  i++;
               }
               for each(loopPoint in LoopPoint.list)
               {
                  GameUnitManager.removeUnit(loopPoint);
               }
               timeOut = int(setTimeout(function():void
               {
                  i = 0;
                  while(i < pointArr.length)
                  {
                     point = GameUnitManager.getUnit(UnitType.HUANGBANG_POINT) as LoopPoint;
                     point.init(Enum_Huangbang.HUANGBANG_NUM + int(pointArr[i][0]),pointArr[i][1],pointArr[i][2],pointArr[i][3]);
                     GameUnitManager.addUnit(point);
                     ++i;
                  }
                  if(pos > 0)
                  {
                     Model_Huangbang.heroStandPoint = GameUnitManager.findUnit(Enum_Huangbang.HUANGBANG_NUM + pos,UnitType.HUANGBANG_POINT) as LoopPoint;
                     if(Boolean(Model_Huangbang.heroStandPoint))
                     {
                        GameUnitManager.removeUnit(Model_Huangbang.heroStandPoint);
                     }
                  }
                  clearTimeout(timeOut);
               },1000));
               Global.control.removeCallBack(Enum_Huangbang.SHOW_ALLPOINT,showAllPoint);
            };
            if(Model_Huangbang.isLink == true)
            {
               Global.control.registerCallBack(Enum_Huangbang.SHOW_ALLPOINT,showAllPoint);
            }
            else
            {
               showAllPoint();
            }
         }
      }
      
      public function GC_LOOK_BACK_QUEST(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         Model_Huangbang.canLookBack = result == 1 ? true : false;
      }
      
      public function GC_USE_TITEL_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("使用失败，已拥有该称号");
         }
      }
   }
}

