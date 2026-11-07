package com.yiTian.net.handler
{
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BufferCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.roleHead.BuffterVO;
   import flash.utils.getTimer;
   
   public class BufferHandler
   {
      
      private static var lastTime:int;
      
      public function BufferHandler()
      {
         super();
      }
      
      public static function GC_BUFFER(result:int, buffId:int, value:int) : void
      {
         var arr:Array = null;
         var buffVO:Vo_Buffer = new Vo_Buffer(buffId);
         var index:int = indexOf(buffId,BuffterVO.buffArr);
         if(index > -1)
         {
            BuffterVO.buffArr[index][1] = value;
            if(buffVO.type == 2 || buffVO.type == 4)
            {
               BuffterVO.roleBuffVOVec[indexOf(buffId,BuffterVO.roleBuffVOVec)].remainValue = value;
               BuffterVO.roleBuffVOVec[indexOf(buffId,BuffterVO.roleBuffVOVec)].updateTime = getTimer();
               resetRequest(BuffterVO.roleBuffVOVec);
               UIManager.heroHead.showBuffter();
            }
            else if(buffVO.type == 3)
            {
               BuffterVO.petBuffVOVec[indexOf(buffId,BuffterVO.petBuffVOVec)].remainValue = value;
               BuffterVO.petBuffVOVec[indexOf(buffId,BuffterVO.petBuffVOVec)].updateTime = getTimer();
               resetRequest(BuffterVO.petBuffVOVec);
               UIManager.petHeadPanel.showBuffter();
            }
            else if(buffVO.type == 5)
            {
               BuffterVO.wuLinBuffVOVec[indexOf(buffId,BuffterVO.wuLinBuffVOVec)].remainValue = value;
               BuffterVO.wuLinBuffVOVec[indexOf(buffId,BuffterVO.wuLinBuffVOVec)].updateTime = getTimer();
               resetRequest(BuffterVO.wuLinBuffVOVec);
               UIManager.wulin_record.showBuffter();
            }
         }
         else
         {
            arr = [];
            arr.push(buffId);
            arr.push(value);
            BuffterVO.buffArr.push(arr);
            buffVO.updateTime = getTimer();
            buffVO.remainValue = value;
            if(buffVO.type == 2 || buffVO.type == 4 || buffVO.type == 6)
            {
               BuffterVO.roleBuffVOVec.push(buffVO);
               resetRequest(BuffterVO.roleBuffVOVec);
               UIManager.heroHead.showBuffter();
            }
            else if(buffVO.type == 3)
            {
               BuffterVO.petBuffVOVec.push(buffVO);
               resetRequest(BuffterVO.petBuffVOVec);
               UIManager.petHeadPanel.showBuffter();
            }
            else if(buffVO.type == 5)
            {
               BuffterVO.wuLinBuffVOVec.push(buffVO);
               resetRequest(BuffterVO.wuLinBuffVOVec);
               UIManager.wulin_record.showBuffter();
            }
         }
         addFrame();
      }
      
      public static function GC_BUFFER_END(result:int, buffId:int, time:int) : void
      {
         var buffVO:Vo_Buffer = null;
         var index:int = 0;
         var i:int = 0;
         if(result == 1)
         {
            index = indexOf(buffId,BuffterVO.buffArr);
            if(index >= 0)
            {
               buffVO = new Vo_Buffer(buffId);
               BuffterVO.buffArr.splice(index,1);
               if(buffVO.type == 2 || buffVO.type == 4 || buffVO.type == 6)
               {
                  i = indexOf(buffId,BuffterVO.roleBuffVOVec);
                  if(i >= 0)
                  {
                     BuffterVO.roleBuffVOVec.splice(i,1);
                  }
                  UIManager.heroHead.showBuffter();
               }
               else if(buffVO.type == 3)
               {
                  i = indexOf(buffId,BuffterVO.petBuffVOVec);
                  if(i >= 0)
                  {
                     BuffterVO.petBuffVOVec.splice(i,1);
                  }
                  UIManager.petHeadPanel.showBuffter();
               }
               else if(buffVO.type == 5)
               {
                  i = indexOf(buffId,BuffterVO.wuLinBuffVOVec);
                  if(i >= 0)
                  {
                     BuffterVO.wuLinBuffVOVec.splice(i,1);
                  }
                  UIManager.wulin_record.showBuffter();
               }
               addFrame();
            }
         }
      }
      
      public static function GC_ADD_HP_MP(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10367",1) + "</font>");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10362",1) + "</font>");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10368",1) + "</font>");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10369",1) + "</font>");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10361",1) + "</font>");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10370",1) + "</font>");
         }
      }
      
      private static function addFrame() : void
      {
         if(GameScene.instance.hasFrameCallBack(countDown))
         {
            GameScene.instance.removeFrameCallBack(countDown);
         }
         if(BuffterVO.roleBuffVOVec.some(function(item:Vo_Buffer, ind:int, v:Vector.<Vo_Buffer>):Boolean
         {
            return item.last_time > 0;
         }) || BuffterVO.petBuffVOVec.some(function(item:Vo_Buffer, ind:int, v:Vector.<Vo_Buffer>):Boolean
         {
            return item.last_time > 0;
         }) || BuffterVO.wuLinBuffVOVec.some(function(item:Vo_Buffer, ind:int, v:Vector.<Vo_Buffer>):Boolean
         {
            return item.last_time > 0;
         }))
         {
            GameScene.instance.addFrameCallBack(countDown);
         }
      }
      
      private static function countDown(interval:int) : void
      {
         var now:int = getTimer();
         if(now - lastTime >= 1000)
         {
            check(BuffterVO.roleBuffVOVec);
            check(BuffterVO.petBuffVOVec);
            check(BuffterVO.wuLinBuffVOVec);
            lastTime = now;
         }
      }
      
      private static function check(buffVOVec:Vector.<Vo_Buffer>) : void
      {
         buffVOVec.forEach(function(item:Vo_Buffer, index:int, vec:Vector.<Vo_Buffer>):void
         {
            if(item.last_time > 0 && item.remainValue * 1000 - (getTimer() - item.updateTime) <= 0 && !item.Requested)
            {
               BufferCGMessage.CG_BUFFER_END(item.id);
               item.Requested = true;
               if(item.id == 39902)
               {
                  View_Alert.show(LangConfig.getWord("10645",1),View_Alert.OK);
               }
            }
         });
      }
      
      private static function indexOf(searchId:int, searchObject:*) : int
      {
         var arr:Array = null;
         var vec:Vector.<Vo_Buffer> = null;
         var index:int = -1;
         if(searchObject is Array)
         {
            arr = searchObject as Array;
            arr.some(function(element:Array, ind:int, arr:Array):Boolean
            {
               if(element[0] == searchId)
               {
                  index = ind;
                  return true;
               }
               return false;
            });
         }
         else if(searchObject is Vector.<Vo_Buffer>)
         {
            vec = searchObject as Vector.<Vo_Buffer>;
            vec.some(function(element:Vo_Buffer, ind:int, vec:Vector.<Vo_Buffer>):Boolean
            {
               if(element.id == searchId)
               {
                  index = ind;
                  return true;
               }
               return false;
            });
         }
         return index;
      }
      
      private static function resetRequest(vec:Vector.<Vo_Buffer>) : void
      {
         if(Boolean(vec))
         {
            vec.forEach(function(item:Vo_Buffer, index:int, v:Vector.<Vo_Buffer>):void
            {
               item.Requested = false;
            });
         }
      }
   }
}

