package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.vo.vo_otherRoleInfo;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class OtherRoleManager
   {
      
      public static const ins:OtherRoleManager = new OtherRoleManager();
      
      private var roleInfoDic:Dictionary;
      
      private const maxTime:int = 40000;
      
      private var timeCount:int = 0;
      
      private var isStart:Boolean;
      
      public function OtherRoleManager()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.roleInfoDic = new Dictionary();
      }
      
      private function frameHandle(interval:int) : void
      {
         var curTime:int = 0;
         var counter:int = 0;
         var item:dicItem = null;
         this.timeCount += interval;
         if(this.timeCount >= this.maxTime)
         {
            this.timeCount = 0;
            curTime = getTimer();
            counter = 0;
            for each(item in this.roleInfoDic)
            {
               counter += 1;
               if(curTime - item.time > this.maxTime)
               {
                  delete this.roleInfoDic[item.vo.roleId];
                  counter -= 1;
               }
            }
            if(counter == 0 && this.isStart)
            {
               this.isStart = false;
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameHandle);
            }
         }
      }
      
      public function getInfo(roleId:int) : vo_otherRoleInfo
      {
         var target:dicItem = this.roleInfoDic[roleId];
         if(Boolean(target))
         {
            return target.vo;
         }
         return null;
      }
      
      public function addInfo(vo:vo_otherRoleInfo) : void
      {
         var item:dicItem = new dicItem(getTimer(),vo);
         this.roleInfoDic[vo.roleId] = item;
         if(!this.isStart)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameHandle);
            this.isStart = true;
         }
      }
   }
}

import com.yiTian.data.vo.vo_otherRoleInfo;

class dicItem
{
   
   public var time:int;
   
   public var vo:vo_otherRoleInfo;
   
   public function dicItem(time:int, vo:vo_otherRoleInfo)
   {
      super();
      this.time = time;
      this.vo = vo;
   }
}
