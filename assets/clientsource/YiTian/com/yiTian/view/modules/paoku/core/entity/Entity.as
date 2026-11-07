package com.yiTian.view.modules.paoku.core.entity
{
   import com.yiTian.view.modules.paoku.core.entity.eComponent.IEntityCtrl;
   
   public class Entity
   {
      
      public var userDataMap:Object = {};
      
      public var _ctrls:Array = [];
      
      public var msgBoard:Object = {};
      
      public var acceptMsgMap:Object = {};
      
      private var _sortInvalidate:Boolean = false;
      
      private var _bActive:Boolean = false;
      
      public function Entity()
      {
         super();
      }
      
      public function addCtrl(ctrl:IEntityCtrl) : void
      {
         this._sortInvalidate = true;
         this._ctrls.push(ctrl);
         ctrl.enter(this);
      }
      
      public function removeCtrl(ctrl:IEntityCtrl) : void
      {
         var index:int = this._ctrls.indexOf(ctrl);
         if(index != -1)
         {
            this._ctrls.splice(index,1);
            ctrl.exit(this);
         }
      }
      
      public function update() : void
      {
         var ctrl:IEntityCtrl = null;
         if(this._sortInvalidate)
         {
            this._ctrls.sort(this.ctrlCompareFunc);
            this._sortInvalidate = false;
         }
         var len:int = int(this._ctrls.length);
         var i:int = 0;
         while(i < this._ctrls.length)
         {
            ctrl = this._ctrls[i];
            ctrl.update(this);
            i += 1;
         }
      }
      
      public function addMsg(msg:String, body:* = null) : void
      {
         if(this.acceptMsgMap[msg] == null)
         {
            return;
         }
         var arr:Array = this.msgBoard[msg];
         if(arr == null)
         {
            this.msgBoard[msg] = arr = [];
         }
         arr.push(body);
      }
      
      public function deleteMsg(msg:String) : void
      {
         delete this.msgBoard[msg];
      }
      
      public function getMsg(msg:String) : *
      {
         return this.msgBoard[msg];
      }
      
      private function ctrlCompareFunc(a:IEntityCtrl, b:IEntityCtrl) : Number
      {
         return a.getSortIndex() - b.getSortIndex();
      }
      
      public function active() : void
      {
         var ctrl:IEntityCtrl = null;
         for each(ctrl in this._ctrls)
         {
            ctrl.active(this);
         }
      }
      
      public function unActive() : void
      {
         var ctrl:IEntityCtrl = null;
         for each(ctrl in this._ctrls)
         {
            ctrl.unActive(this);
         }
      }
      
      public function clearMsgs() : void
      {
         var k:String = null;
         for(k in this.msgBoard)
         {
            delete this.msgBoard[k];
         }
      }
      
      public function acceptMsg(type:String) : void
      {
         this.acceptMsgMap[type] = true;
      }
      
      public function unAcceptMsg(type:String) : void
      {
         delete this.acceptMsgMap[type];
      }
      
      public function clearAccpetMsg() : void
      {
         var k:String = null;
         for(k in this.acceptMsgMap)
         {
            delete this.acceptMsgMap[k];
         }
      }
      
      public function cleanUp() : void
      {
         var ctrl:IEntityCtrl = null;
         this.clearMsgs();
         this.clearAccpetMsg();
         for each(ctrl in this._ctrls)
         {
            ctrl.exit(this);
         }
         this._ctrls.length = 0;
      }
      
      public function getCtrl(name:String) : IEntityCtrl
      {
         var ctrl:IEntityCtrl = null;
         for each(ctrl in this._ctrls)
         {
            if(ctrl.getName() == name)
            {
               return ctrl;
            }
         }
         return null;
      }
   }
}

