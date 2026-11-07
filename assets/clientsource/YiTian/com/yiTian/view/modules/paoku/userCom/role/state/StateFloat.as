package com.yiTian.view.modules.paoku.userCom.role.state
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.entity.MoveData;
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   
   public class StateFloat implements IState
   {
      
      private var _target:KuPaoEntity;
      
      private var _keepEffect:Effect;
      
      private var _eatCoinRect:Rectangle = new Rectangle(0,0,600,600);
      
      private var _sinNum:Number = 0;
      
      private var _startMeter:int;
      
      private var _lastKeyCode:int;
      
      public function StateFloat()
      {
         super();
      }
      
      public function enter(param:*) : void
      {
         Model_KuPao.isFloating = true;
         this._target = param;
         this._target.addMsg(KuPaoEntityMsgConst.CHANGE_ACTIONVIEW,{
            "action":Action.RUN,
            "frameInterval":20000,
            "frameIndex":5
         });
         this._target.addMsg(KuPaoEntityMsgConst.ADD_EFFECT,{
            "id":"36130",
            "time":2000,
            "x":0,
            "y":0,
            "isLoop":true
         });
         this._target.unAcceptMsg(KuPaoEntityMsgConst.CHANGE_STATE);
         this._target.unAcceptMsg(KuPaoEntityMsgConst.HERO_HIT);
         this._startMeter = this._target.moveData.xPos;
         this._target.moveData.imbaTime = true;
         this._target.moveData.ySpeed = 0;
         this._target.moveData.xSpeed = 30;
         Global.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      public function exit(param:*) : void
      {
         var md:MoveData = null;
         Model_KuPao.isFloating = false;
         this._target.addMsg(KuPaoEntityMsgConst.REMOVE_EFFECT,"36130");
         this._target.acceptMsg(KuPaoEntityMsgConst.CHANGE_STATE);
         this._target.acceptMsg(KuPaoEntityMsgConst.HERO_HIT);
         this._target.moveData.canCrossWall = false;
         md = this._target.moveData;
         setTimeout(function():void
         {
            md.imbaTime = false;
         },1000);
         this._target = null;
         this._lastKeyCode = -1;
         Global.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      public function update(param:*) : void
      {
         var coin:KuPaoEntity = null;
         var now:int = this._target.moveData.xPos;
         if(now - this._startMeter > 50 * Model_KuPao.numPixelMeter)
         {
            this._target.acceptMsg(KuPaoEntityMsgConst.CHANGE_STATE);
            this._target.addMsg(KuPaoEntityMsgConst.CHANGE_STATE,{"state":KuPaoRoleStates.ST_JUMP});
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
         return true;
      }
      
      private function onKeyDown(e:KeyboardEvent) : void
      {
         this._lastKeyCode = e.keyCode;
      }
   }
}

