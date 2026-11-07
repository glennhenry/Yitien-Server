package com.yiTian.view.modules.paoku.core.state
{
   import flash.utils.Dictionary;
   
   public class StateMachie
   {
      
      public var _stateDict:Dictionary = new Dictionary();
      
      public var _currentState:IState;
      
      public var _currentStateName:String;
      
      public var enterLogFunc:Function;
      
      public var exitLogFunc:Function;
      
      public function StateMachie()
      {
         super();
      }
      
      public function changeState(stateName:*, param:* = null) : Boolean
      {
         if(this._currentState != null && !this._currentState.askExit(stateName))
         {
            return false;
         }
         if(this._currentState != null)
         {
            if(this.exitLogFunc != null)
            {
               this.exitLogFunc(this._currentStateName);
            }
            this._currentState.exit(param);
         }
         this._currentState = this._stateDict[stateName];
         if(this._currentState != null)
         {
            if(this.enterLogFunc != null)
            {
               this.enterLogFunc(stateName);
            }
            this._currentState.enter(param);
         }
         this._currentStateName = stateName;
         return true;
      }
      
      public function setState(stateName:*, stateImpl:IState) : void
      {
         this._stateDict[stateName] = stateImpl;
      }
      
      public function smUpdate(param:* = null) : void
      {
         if(this._currentState != null)
         {
            this._currentState.update(param);
         }
      }
   }
}

