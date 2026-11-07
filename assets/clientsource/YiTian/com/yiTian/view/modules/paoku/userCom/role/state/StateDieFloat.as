package com.yiTian.view.modules.paoku.userCom.role.state
{
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.input.KuPaoInput;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.geom.Rectangle;
   
   public class StateDieFloat implements IState
   {
      
      private var _startMeter:int;
      
      private var _target:KuPaoEntity;
      
      private var _sinNum:Number = 0;
      
      private var _eatCoinRect:Rectangle = new Rectangle(0,0,600,600);
      
      public function StateDieFloat()
      {
         super();
      }
      
      public function enter(param:*) : void
      {
         this._target = param;
         this._target.moveData.canCrossWall = true;
         this._target.moveData.xSpeed = 30;
         this._target.moveData.ySpeed = 0;
         this._startMeter = this._target.moveData.xPos;
         this._target.acceptMsg(KuPaoEntityMsgConst.CHANGE_STATE);
         this._target.addMsg(KuPaoEntityMsgConst.CHANGE_ACTIONVIEW,{
            "action":Child_tianTiUnit.JUMPUP,
            "frameInterval":40
         });
         this._target.addMsg(KuPaoEntityMsgConst.ADD_EFFECT,{
            "id":"36130",
            "time":2000,
            "x":0,
            "y":0,
            "isLoop":true
         });
         KuPaoInput.instance.pause();
      }
      
      public function exit(param:*) : void
      {
         this._target.addMsg(KuPaoEntityMsgConst.REMOVE_EFFECT,"36130");
         this._startMeter = 0;
         this._target.moveData.canCrossWall = false;
         this._target = null;
         KuPaoInput.instance.resume();
      }
      
      public function update(param:*) : void
      {
         var coin:KuPaoEntity = null;
         var now:int = this._target.moveData.xPos;
         if(now - this._startMeter > 45 * Model_KuPao.numPixelMeter)
         {
            this._target.acceptMsg(KuPaoEntityMsgConst.CHANGE_STATE);
            this._target.addMsg(KuPaoEntityMsgConst.CHANGE_STATE,{"state":KuPaoRoleStates.ST_DIE});
         }
         this._sinNum += 0.2;
         var distY:Number = Math.sin(this._sinNum) * 25 + 300;
         var length:Number = Math.abs(distY - this._target.moveData.yPos);
         var stepY:Number = Math.max(-10,Math.min(20,(distY - this._target.moveData.yPos) * 20));
         if(Math.abs(stepY) > length)
         {
            stepY = stepY > 0 ? length : -length;
         }
         this._target.moveData.ySpeed = stepY;
         this._eatCoinRect.x = this._target.moveData.xPos;
         this._eatCoinRect.y = this._target.moveData.yPos - 300;
         var coins:Array = KPMap.instance.getHitItems(this._eatCoinRect);
         for each(coin in coins)
         {
            coin.addMsg(KuPaoEntityMsgConst.AUTO_TOHERO,this._target);
         }
      }
      
      public function askExit(nextState:int) : Boolean
      {
         if(nextState == KuPaoRoleStates.ST_DIE)
         {
            return true;
         }
         return false;
      }
   }
}

