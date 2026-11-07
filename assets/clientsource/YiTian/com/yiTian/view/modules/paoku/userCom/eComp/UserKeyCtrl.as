package com.yiTian.view.modules.paoku.userCom.eComp
{
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.core.entity.eComponent.IEntityCtrl;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.input.KuPaoInput;
   import com.yiTian.view.modules.paoku.userCom.role.state.KuPaoRoleStates;
   
   public class UserKeyCtrl implements IEntityCtrl
   {
      
      private var _target:KuPaoEntity;
      
      private var _input:KuPaoInput;
      
      public function UserKeyCtrl()
      {
         super();
      }
      
      public function setName(v:String) : void
      {
      }
      
      public function getName() : String
      {
         return null;
      }
      
      public function setSortIndex(v:int) : void
      {
      }
      
      public function getSortIndex() : int
      {
         return 0;
      }
      
      public function enter(entity:Entity) : void
      {
         this._target = entity as KuPaoEntity;
      }
      
      public function exit(entity:Entity) : void
      {
      }
      
      public function update(entity:Entity) : void
      {
         if(KuPaoInput.instance.isPressJump())
         {
            KuPaoInput.instance.clearKeys();
            entity.addMsg(KuPaoEntityMsgConst.CHANGE_STATE,{
               "state":KuPaoRoleStates.ST_JUMP,
               "ySpeed":22
            });
         }
         if(KuPaoInput.instance.isPressFloat())
         {
            KuPaoInput.instance.clearKeys();
            entity.addMsg(KuPaoEntityMsgConst.CHANGE_STATE,{
               "state":KuPaoRoleStates.ST_FLOAT,
               "xSpeed":30
            });
         }
      }
      
      public function unActive(entity:Entity) : void
      {
      }
      
      public function active(entity:Entity) : void
      {
      }
   }
}

