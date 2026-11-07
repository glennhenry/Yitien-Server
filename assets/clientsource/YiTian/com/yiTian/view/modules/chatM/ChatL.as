package com.yiTian.view.modules.chatM
{
   import com.utils.ComponentUtil;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ChatL extends Sprite
   {
      
      private var canvasM:TestScroll;
      
      private var posX:int;
      
      private var __width:int;
      
      private var dataList:Array = [];
      
      private var pool:Array = [];
      
      public var _lock:Boolean = false;
      
      private var _hei:Number;
      
      public function ChatL(_wid:int, hei:int, direc:String = "right", _parent:DisplayObjectContainer = null)
      {
         super();
         this.__width = _wid;
         this.canvasM = new TestScroll(_wid,hei,direc,_parent);
         this.canvasM.item = this;
         if(direc == TestScroll.LEFT)
         {
            x = 21;
         }
         else if(direc == TestScroll.RIGHT)
         {
            x = 0;
         }
         addEventListener(MouseEvent.CLICK,GameScene.instance.uiOnGo);
      }
      
      public function init(dataStr:String, dataLink:Object, callBack:Function) : void
      {
         if(dataStr == "")
         {
            return;
         }
         var tf:RitfM = RitfM.instance;
         tf.realWid = this.__width - 21;
         tf.init(dataStr,dataLink,callBack);
         addChild(tf);
         this.pool.push(tf);
         if(this.pool.length >= 80)
         {
            this.remove();
         }
         this.setPos();
      }
      
      public function getPos(proper:Object) : void
      {
         ComponentUtil.setPropertie(this.canvasM,proper);
      }
      
      private function remove() : void
      {
         this.pool[0].dispose();
         removeChild(this.pool[0]);
         this.pool.shift();
      }
      
      public function setPos() : void
      {
         var nowY:int = 0;
         var _tt:RitfM = null;
         nowY = 0;
         var i:int = 0;
         while(i < this.pool.length)
         {
            _tt = this.pool[i];
            _tt.y = nowY;
            nowY += _tt.height;
            i++;
         }
         this.getHei();
         this.canvasM.resize();
      }
      
      private function getHei() : void
      {
         var child:DisplayObject = null;
         var size:int = numChildren;
         this._hei = 0;
         var i:int = 0;
         while(i < size)
         {
            child = getChildAt(i);
            this._hei = Math.max(this._hei,child.y + child.height);
            i++;
         }
      }
      
      public function show() : void
      {
         this.canvasM.visible = true;
      }
      
      public function hide() : void
      {
         this.canvasM.visible = false;
      }
      
      public function set lock(value:Boolean) : void
      {
         this._lock = value;
         this.canvasM.lock = value;
      }
      
      override public function get height() : Number
      {
         return this._hei;
      }
      
      public function get lock() : Boolean
      {
         return this._lock;
      }
      
      public function resetPostion() : void
      {
         this.canvasM.x = 1;
         this.canvasM.y = UIManager.chatPanel.y;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         while(i < this.pool.length)
         {
            removeChild(this.pool[i]);
            i++;
         }
         this.pool = [];
      }
   }
}

