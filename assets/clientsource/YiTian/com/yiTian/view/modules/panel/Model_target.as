package com.yiTian.view.modules.panel
{
   import com.utils.Util;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.manager.GameUnitManager;
   
   public class Model_target
   {
      
      public static const TARGET_DATA_UPDATE:String = "target_clip_data_update";
      
      public static const TARGET_TYPE_CHANGE:String = "target_type_change";
      
      public static const TARGET_POPUP_JIEMI:String = "target_popup_jiemi";
      
      public static const TARGET_GET_CHIP_SUCCESS:String = "target_get_chip_success";
      
      public static var clipsVo1:Array = [];
      
      public static var clipsVo2:Array = [];
      
      public static var type:int = -1;
      
      public static var jieMiFlag:int = 0;
      
      public static var taskStateMap:DictionaryTabel = new DictionaryTabel();
      
      public static var taskCompleteMap:DictionaryTabel = new DictionaryTabel();
      
      public static var voRefMap:Object = {};
      
      private static var _isInit:Boolean = false;
      
      public function Model_target()
      {
         super();
      }
      
      public static function init() : void
      {
         var vo:Vo_Target = null;
         var info:Array = null;
         var a:Vo_Target = null;
         var b:Vo_Target = null;
         var id:int = 0;
         var index:int = 0;
         if(_isInit)
         {
            return;
         }
         _isInit = true;
         var infos:Array = Data_lib.chip_task.toArray();
         for each(info in infos)
         {
            id = int(info[0]);
            index = int(info[2]);
            if(!voRefMap[index])
            {
               vo = voRefMap[index] = new Vo_Target();
               if(index <= 7)
               {
                  clipsVo1.push(vo);
               }
               else if(index <= 14)
               {
                  clipsVo2.push(vo);
               }
               vo.clipIndex = index;
            }
            else
            {
               vo = voRefMap[index];
            }
            vo.taskIDs.push(id);
         }
         for each(a in clipsVo1)
         {
            a.taskIDs.sort(taskSort);
         }
         for each(b in clipsVo1)
         {
            b.taskIDs.sort(taskSort);
         }
         clipsVo1.sortOn("clipIndex",Array.NUMERIC);
         clipsVo2.sortOn("clipIndex",Array.NUMERIC);
      }
      
      private static function taskSort(a:int, b:int) : Number
      {
         return a - b;
      }
      
      public static function getChipCanGetting() : int
      {
         var vo:Vo_Target = null;
         init();
         var a:Array = type == 1 ? clipsVo1 : clipsVo2;
         var i:int = 0;
         while(i < a.length)
         {
            vo = a[i];
            if(vo.isAllTaskComplete() && taskCompleteMap[vo.clipIndex] == 0)
            {
               return i;
            }
            i += 1;
         }
         return -1;
      }
      
      public static function getWeaponUrl(prm:* = null) : String
      {
         var lv:int = Boolean(prm) ? int(prm) : type;
         return Util.rep("resource/image/target/weapon/{0}_{1}.png",lv,Enum_job.getBaseJob(GameUnitManager.hero.job));
      }
      
      public static function getTitleUrl(prm:* = null) : String
      {
         var lv:int = Boolean(prm) ? int(prm) : type;
         return Util.rep("resource/image/target/title/{0}_{1}.png",lv,Enum_job.getBaseJob(GameUnitManager.hero.job));
      }
   }
}

