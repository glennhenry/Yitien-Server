package com.yiTian.utils.auto
{
   import com.yiTian.Global;
   import com.yiTian.command.Control;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class HandupMgr
   {
      
      private static var _roleFun:Function;
      
      private static var _battlePlayFun:Function;
      
      private static var _condition:Function;
      
      private static var _fubenFinish:Function;
      
      private static var _onSceneOk:Function;
      
      private static var _onAddNpc:Function;
      
      private static var _ctrl:Control;
      
      public static const TURNON:String = "handup_trunon";
      
      public static const TURNOFF:String = "handup_turnoff";
      
      public static const SHOW:String = "handup_show";
      
      public static const HIDE:String = "handup_hide";
      
      private static var _timer:Timer = new Timer(_delay);
      
      private static var _isTurnOn:Boolean = false;
      
      private static var _delay:int = 5000;
      
      private static var _type:int = -1;
      
      private static var lastCheck:Number = -2000;
      
      public function HandupMgr()
      {
         super();
      }
      
      public static function setType(v:int) : void
      {
         _type = v;
      }
      
      public static function getType() : int
      {
         return _type;
      }
      
      public static function turnon() : void
      {
         _timer.delay = _delay;
         _timer.addEventListener(TimerEvent.TIMER,onTimer);
         _timer.start();
         Global.control.registerCallBack(Enum_MsgType.ADD_NPC_SCENE,onAddNpc);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,onBattleStart);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,onBattleEnd);
         Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,onSceneOk);
         Global.control.registerCallBack(Enum_MsgType.FUBEN_FINISH,onFuBenFinish);
         _isTurnOn = true;
         Global.control.sendNotification(TURNON,null);
      }
      
      public static function turnoff() : void
      {
         GameUnitManager.hero.lockTarget = null;
         Global.control.removeCallBack(Enum_MsgType.ADD_NPC_SCENE,onAddNpc);
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_START,onBattleStart);
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,onBattleEnd);
         Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,onSceneOk);
         Global.control.removeCallBack(Enum_MsgType.FUBEN_FINISH,onFuBenFinish);
         _timer.stop();
         _isTurnOn = false;
         Global.control.sendNotification(TURNOFF,null);
      }
      
      public static function isTurnOn() : Boolean
      {
         return _isTurnOn;
      }
      
      public static function show() : void
      {
         Global.control.sendNotification(SHOW,null);
      }
      
      public static function hide() : void
      {
         Global.control.sendNotification(HIDE,null);
      }
      
      public static function set roleFun(fun:Function) : void
      {
         _roleFun = fun;
      }
      
      public static function get roleFun() : Function
      {
         return _roleFun;
      }
      
      public static function set delay(v:int) : void
      {
         _delay = _timer.delay = v;
      }
      
      public static function get delay() : int
      {
         return _delay;
      }
      
      public static function set battlePlayFun(v:Function) : void
      {
         _battlePlayFun = v;
      }
      
      public static function get battlePlayFun() : Function
      {
         return _battlePlayFun;
      }
      
      public static function set addNpcFun(v:Function) : void
      {
         _onAddNpc = v;
      }
      
      public static function set conditionFun(v:Function) : void
      {
         _condition = v;
      }
      
      public static function get conditionFun() : Function
      {
         return _condition;
      }
      
      private static function onBattleStart(bID:int) : void
      {
         if(_battlePlayFun != null)
         {
            _battlePlayFun(bID);
         }
      }
      
      private static function onBattleEnd() : void
      {
         executeHandupFun();
      }
      
      private static function onSceneOk() : void
      {
         if(_onSceneOk != null)
         {
            _onSceneOk();
         }
      }
      
      private static function onAddNpc(npc:Npc) : void
      {
         if(_onAddNpc != null)
         {
            _onAddNpc(npc);
         }
      }
      
      private static function onFuBenFinish() : void
      {
         if(_fubenFinish != null)
         {
            _fubenFinish();
         }
      }
      
      private static function onTimer(e:TimerEvent) : void
      {
         executeHandupFun();
      }
      
      public static function execute() : void
      {
         executeHandupFun();
         _timer.reset();
         _timer.start();
      }
      
      private static function executeHandupFun() : void
      {
         var gameUnit:GameUnit = null;
         if(_condition != null && _condition() == false || _roleFun == null)
         {
            return;
         }
         for each(gameUnit in GameUnitManager.list)
         {
            if(Boolean(_roleFun(gameUnit)))
            {
               break;
            }
         }
      }
      
      public static function askMovePass() : Boolean
      {
         if(!_isTurnOn)
         {
            return true;
         }
         var now:int = getTimer();
         if(now - lastCheck > 1500)
         {
            lastCheck = now;
            UIManager.centerBroadcast.addMsg("再次点击地图取消挂机");
            _timer.reset();
            _timer.start();
            return false;
         }
         turnoff();
         return true;
      }
   }
}

