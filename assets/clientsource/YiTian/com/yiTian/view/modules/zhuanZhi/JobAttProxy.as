package com.yiTian.view.modules.zhuanZhi
{
   import com.yiTian.data.config.Enum_OtherTip_Type;
   import com.yiTian.manager.TipManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class JobAttProxy extends EventDispatcher
   {
      
      private var _tipObj:Object = {
         "typeId":Enum_OtherTip_Type.ZHUANZHI,
         "job":0
      };
      
      private var _target:Sprite;
      
      private var _autoHide:Boolean;
      
      public function JobAttProxy(target:Sprite = null, autoHide:Boolean = true)
      {
         super();
         this._target = target || new Sprite();
         this._autoHide = autoHide;
      }
      
      public function setJob(jobIndex:int) : void
      {
         dispatchEvent(new Event("attribute_change"));
         this._tipObj.job = jobIndex;
         this._target.visible = this._autoHide && (jobIndex >= 6 && jobIndex <= 13);
      }
      
      public function getJob() : int
      {
         return this._tipObj.job;
      }
      
      public function addEvent() : void
      {
         this._target.addEventListener(MouseEvent.ROLL_OVER,this.rollOverHd);
         this._target.addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
      }
      
      public function removeEvent() : void
      {
         this._target.removeEventListener(MouseEvent.ROLL_OVER,this.rollOverHd);
         this._target.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
      }
      
      public function getTarget() : Sprite
      {
         return this._target;
      }
      
      private function rollOverHd(e:MouseEvent) : void
      {
         if(this._tipObj.job >= 6 && this._tipObj.job <= 13)
         {
            TipManager.update(this._tipObj);
         }
      }
      
      private function rollOutHd(e:MouseEvent) : void
      {
         TipManager.hide();
      }
   }
}

