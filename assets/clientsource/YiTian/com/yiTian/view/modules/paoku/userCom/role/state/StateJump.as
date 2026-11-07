package com.yiTian.view.modules.paoku.userCom.role.state
{
   import com.yiTian.view.modules.paoku.core.entity.MoveData;
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.userCom.util.Config;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   
   public class StateJump implements IState
   {
      
      private var _entity:KuPaoEntity;
      
      private var _lastVertSpeed:int;
      
      private var _comboJumpTime:int;
      
      private var _avtObject:Object = {};
      
      public function StateJump()
      {
         super();
      }
      
      public function enter(param:*) : void
      {
         this._lastVertSpeed = 0;
         this._entity = param;
         ++this._comboJumpTime;
         trace(this._comboJumpTime);
      }
      
      public function exit(param:*) : void
      {
         this._entity = null;
      }
      
      public function update(param:*) : void
      {
         this.tryCorrectAction();
         var vy:Number = this._entity.moveData.ySpeed - Config.gavity;
         var md:MoveData = this._entity.moveData;
         vy = Math.max(-39,vy);
         md.ySpeed = vy;
         var nextVertType:int = KuPaoMgr.instance.getType(md.xPos,md.yPos + md.ySpeed);
         if(nextVertType == 1)
         {
            if(md.ySpeed < 0)
            {
               this._entity.addMsg(KuPaoEntityMsgConst.CHANGE_STATE,{"state":KuPaoRoleStates.ST_RUN});
            }
            else if(md.ySpeed > 0)
            {
            }
         }
      }
      
      public function tryCorrectAction() : void
      {
         if(this._lastVertSpeed == 0 || this._entity.moveData.ySpeed * this._lastVertSpeed < 0)
         {
            this._lastVertSpeed = this._entity.moveData.ySpeed;
            if(this._entity.moveData.ySpeed < 0)
            {
               this._avtObject.action = Child_tianTiUnit.JUMPDOWN;
               this._avtObject.frameInterval = 40;
               this._entity.addMsg(KuPaoEntityMsgConst.CHANGE_ACTIONVIEW,this._avtObject);
            }
            else
            {
               if(this._comboJumpTime <= 1)
               {
                  this._avtObject.action = Child_tianTiUnit.JUMPUP;
               }
               else
               {
                  this._avtObject.action = Child_tianTiUnit.ROTATE;
               }
               this._avtObject.frameInterval = 40;
               this._entity.addMsg(KuPaoEntityMsgConst.CHANGE_ACTIONVIEW,this._avtObject);
            }
         }
      }
      
      public function askExit(nextState:int) : Boolean
      {
         if(nextState == KuPaoRoleStates.ST_JUMP)
         {
            if(this._comboJumpTime < 2)
            {
               return true;
            }
            return false;
         }
         this._comboJumpTime = 0;
         return true;
      }
   }
}

