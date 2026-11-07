package com.yiTian.view.modules.paoku.userCom.input
{
   import com.yiTian.Global;
   import com.yiTian.data.config.KeyBoardConst;
   import com.yiTian.view.modules.paoku.view.View_kuPaoPnl;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class KuPaoInput1 extends KuPaoInput
   {
      
      private var _lastPressCode:int;
      
      public function KuPaoInput1()
      {
         super();
      }
      
      override public function resume() : void
      {
         Global.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         View_kuPaoPnl.instance.viewContainer.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      override public function pause() : void
      {
         Global.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         View_kuPaoPnl.instance.viewContainer.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      override public function isPressFloat() : Boolean
      {
         return false;
      }
      
      override public function isPressJump() : Boolean
      {
         return this._lastPressCode == KeyBoardConst.SPACE;
      }
      
      override public function isPressUp() : Boolean
      {
         return this._lastPressCode == KeyBoardConst.UP;
      }
      
      override public function isPressDown() : Boolean
      {
         return this._lastPressCode == KeyBoardConst.DOWN;
      }
      
      override public function clearKeys() : void
      {
         this._lastPressCode = 0;
      }
      
      protected function keyDownHandler(e:KeyboardEvent) : void
      {
         this._lastPressCode = e.keyCode;
      }
      
      protected function onMouseDown(e:MouseEvent) : void
      {
         this._lastPressCode = KeyBoardConst.SPACE;
      }
   }
}

