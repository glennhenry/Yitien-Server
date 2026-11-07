package com.yiTian.view.modules.panel
{
   public class Vo_Target
   {
      
      public var clipIndex:int;
      
      public var taskIDs:Array = [];
      
      public function Vo_Target()
      {
         super();
      }
      
      public function isAllTaskComplete() : Boolean
      {
         var taskId:int = 0;
         var dataMap:Object = Model_target.taskStateMap;
         for each(taskId in this.taskIDs)
         {
            if(dataMap[taskId] != -1)
            {
               return false;
            }
         }
         return true;
      }
   }
}

