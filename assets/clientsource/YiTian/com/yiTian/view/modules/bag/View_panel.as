package com.yiTian.view.modules.bag
{
   import com.ui.controls.Button;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.DrawObj;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.modules.mainMenu.MicroButton;
   import com.yiTian.view.modules.mainMenu.View_MainMenu;
   import com.yiTian.view.modules.map.SmallMap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class View_panel extends MainUIBase
   {
      
      protected var dis_bg:DisplayObject;
      
      protected var btn_close:Button;
      
      protected var bAutoRemove:Boolean;
      
      private var sp_moveBar:Sprite;
      
      protected var isTween:Boolean;
      
      private var isTweenRunning:Boolean;
      
      public var vsb:Boolean;
      
      protected var isRuning:Boolean = false;
      
      protected var bind_point:Point;
      
      public function View_panel()
      {
         super();
         super.visible = false;
         this.sp_moveBar = new Sprite();
         this.bAutoRemove = true;
         addEventListener(MouseEvent.MOUSE_DOWN,this.MOUSE_DOWN);
      }
      
      public function smMpHandle(value:Boolean) : void
      {
         var temp:Boolean = false;
         var p1:Point = null;
         var p2:Point = null;
         if(bind_target.parent is View_MainMenu)
         {
            this.bind_point = UIManager.mainMenu.getBtnPoint(bind_target);
         }
         else if(bind_target.parent is SmallMap)
         {
            this.bind_point = UIManager.smallMap.getBtnPoint(bind_target);
         }
         temp = visible == value;
         if(value)
         {
            scaleX = 1;
            scaleY = 1;
            super.visible = true;
            this.popup();
            resetPosition();
            if(this.isTween && !this.isTweenRunning && !temp)
            {
               p1 = new Point(this.x,this.y);
               p2 = UIManager.mainMenu.getXY(this);
               Tween.to(this,100,{
                  "alpha":[0,1],
                  "scaleX":[0.1,1],
                  "scaleY":[0.1,1],
                  "x":[p2.x,p1.x],
                  "y":[p2.y,p1.y]
               },this.stopHanlder);
               this.isTweenRunning = true;
            }
            else
            {
               this.alpha = 1;
            }
         }
         else
         {
            if(this.isRuning)
            {
               return;
            }
            this.isRuning = true;
            if(!this.isTweenRunning && !temp)
            {
               Tween.to(this,300,{
                  "scaleX":[1,0],
                  "scaleY":[1,0],
                  "x":[this.x,this.bind_point.x],
                  "y":[this.y,this.bind_point.y]
               },this.comp);
            }
            else
            {
               this.comp();
            }
         }
      }
      
      private function comp() : void
      {
         super.visible = false;
         if(this.bAutoRemove)
         {
            UIManager.removeVisibleView(this,0);
         }
         this.isRuning = false;
         if(bind_target is Button)
         {
            DrawObj.drawObj(bind_target,this.bind_point,(bind_target as Button).sourStype);
         }
         else if(bind_target is MicroButton)
         {
            DrawObj.drawObj(bind_target,this.bind_point,(bind_target as MicroButton).sourStype);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var p1:Point = null;
         var p2:Point = null;
         var temp:Boolean = false;
         this.vsb = value;
         if(Boolean(bind_target))
         {
            this.smMpHandle(value);
            return;
         }
         temp = visible == value;
         if(value)
         {
            super.visible = true;
            this.popup();
            resetPosition();
            if(this.isTween && !this.isTweenRunning && !temp)
            {
               p1 = new Point(this.x,this.y);
               p2 = UIManager.mainMenu.getXY(this);
               Tween.to(this,100,{
                  "alpha":[0,1],
                  "scaleX":[0.1,1],
                  "scaleY":[0.1,1],
                  "x":[p2.x,p1.x],
                  "y":[p2.y,p1.y]
               },this.stopHanlder);
               this.isTweenRunning = true;
            }
            else
            {
               this.alpha = 1;
            }
         }
         else
         {
            if(UIManager.isDragPanel && UIManager.curDragPanel == this)
            {
               this.upEvent(null);
            }
            if(this.isTween && !this.isTweenRunning && !temp)
            {
               p1 = new Point(this.x,this.y);
               p2 = UIManager.mainMenu.getXY(this);
               Tween.to(this,150,{
                  "alpha":[1,0],
                  "scaleX":[1,0.1],
                  "scaleY":[1,0.1],
                  "x":[p1.x,p2.x],
                  "y":[p1.y,p2.y]
               },this.onComplete);
               this.isTweenRunning = true;
            }
            else
            {
               super.visible = false;
               if(this.bAutoRemove)
               {
                  UIManager.removeVisibleView(this,0);
               }
            }
         }
      }
      
      private function stopHanlder() : void
      {
         this.isTweenRunning = false;
      }
      
      private function onComplete() : void
      {
         super.visible = false;
         if(this.bAutoRemove)
         {
            UIManager.removeVisibleView(this,0);
         }
         this.scaleX = 1;
         this.scaleY = 1;
         this.stopHanlder();
      }
      
      final public function set move(rect:Rectangle) : void
      {
         this.sp_moveBar.graphics.clear();
         this.sp_moveBar.graphics.beginFill(0,0);
         this.sp_moveBar.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
         this.sp_moveBar.graphics.endFill();
         this.sp_moveBar.x = rect.x;
         this.sp_moveBar.y = rect.y;
         this.sp_moveBar.addEventListener(MouseEvent.MOUSE_DOWN,this.DOWN_SP);
         this.sp_moveBar.addEventListener(MouseEvent.MOUSE_UP,this.upEvent);
         addChild(this.sp_moveBar);
      }
      
      protected function addEventListener_close() : void
      {
         this.btn_close.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_CLOSE);
      }
      
      private function popup() : void
      {
         if(GameScene.uiLayer.contains(this))
         {
            GameScene.uiLayer.setChildIndex(this,GameScene.uiLayer.numChildren - 1);
            if(this.bAutoRemove)
            {
               UIManager.addVisibleView(this,0);
            }
         }
      }
      
      private function CLICK_BTN_CLOSE(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function upEvent(e:MouseEvent) : void
      {
         stopDrag();
         UIManager.curDragPanel = null;
         UIManager.isDragPanel = false;
      }
      
      private function DOWN_SP(e:MouseEvent) : void
      {
         UIManager.isDragPanel = true;
         UIManager.curDragPanel = this;
         startDrag();
      }
      
      private function MOUSE_DOWN(e:MouseEvent) : void
      {
         this.popup();
      }
   }
}

