package com.yiTian.view
{
   import com.ui.controls.Button;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.crossCampBattle.View_CrossCampBattleInfoPanel;
   import com.yiTian.view.modules.crossClanBattle.View_ClanBattleInfo;
   import com.yiTian.view.modules.huangbang.View_HuangbangInfoPanel;
   import com.yiTian.view.modules.mainMenu.MicroButton;
   import com.yiTian.view.modules.mainMenu.View_MainMenu;
   import com.yiTian.view.modules.map.SmallMap;
   import com.yiTian.view.modules.roleHead.VIP_item;
   import com.yiTian.view.modules.roleHead.View_HeroHead;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.PerspectiveProjection;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import flash.utils.Timer;
   
   public class Panel extends MainUIBase
   {
      
      protected var CloseButton:Button;
      
      protected var moveBar:Sprite;
      
      protected var bAutoRemove:Boolean;
      
      private var _isTween:Boolean;
      
      private var isTweenRunning:Boolean;
      
      private var primaryMatrix:Matrix;
      
      private var primaryMatrix3D:Matrix3D;
      
      private var _useRotation3D:Boolean;
      
      private var is3DTweenRunning:Boolean;
      
      private var perspectiveProjection:PerspectiveProjection;
      
      private var showTimer3D:Timer;
      
      private var hideTimer3D:Timer;
      
      private var curZ:int;
      
      protected var isRuning:Boolean = false;
      
      protected var bind_point:Point;
      
      protected var isShoppingMall:Boolean = false;
      
      public function Panel()
      {
         super();
         super.visible = false;
         this.moveBar = new Sprite();
         this.bAutoRemove = true;
         addEventListener(MouseEvent.MOUSE_DOWN,this.down);
      }
      
      protected function get useRotation3D() : Boolean
      {
         return this._useRotation3D;
      }
      
      protected function set useRotation3D(value:Boolean) : void
      {
         this._useRotation3D = value;
         if(value)
         {
            this.isTween = false;
            if(!this.perspectiveProjection)
            {
               this.perspectiveProjection = new PerspectiveProjection();
               this.perspectiveProjection.projectionCenter = new Point(Global.stage.stageWidth / 2,Global.stage.stageHeight / 2);
               this.transform.perspectiveProjection = this.perspectiveProjection;
               this.showTimer3D = new Timer(Enum_panel.timerInterval,Enum_panel.costTimes);
               this.showTimer3D.addEventListener(TimerEvent.TIMER,this.on3DShowTimer);
               this.showTimer3D.addEventListener(TimerEvent.TIMER_COMPLETE,this.onRotation3DShowComplete);
               this.hideTimer3D = new Timer(Enum_panel.timerInterval,Enum_panel.costTimes);
               this.hideTimer3D.addEventListener(TimerEvent.TIMER,this.on3DHideTimer);
               this.hideTimer3D.addEventListener(TimerEvent.TIMER_COMPLETE,this.onRotation3DHideComplete);
            }
         }
      }
      
      protected function get isTween() : Boolean
      {
         return this._isTween;
      }
      
      protected function set isTween(value:Boolean) : void
      {
         this._isTween = value;
         if(value)
         {
            this.useRotation3D = false;
         }
      }
      
      override protected function initDynamicView() : void
      {
         if(Boolean(this.CloseButton))
         {
            this.CloseButton.callBack = this.onClose;
         }
      }
      
      private function setVisibleByRotation3D(value:Boolean) : void
      {
         if(this.is3DTweenRunning || this.isTweenRunning)
         {
            return;
         }
         this.is3DTweenRunning = true;
         this.primaryMatrix = Boolean(this.transform.matrix) ? this.transform.matrix.clone() : null;
         this.primaryMatrix3D = Boolean(this.transform.matrix3D) ? this.transform.matrix3D.clone() : null;
         if(value)
         {
            this.z = Enum_panel.zDistance;
            this.curZ = Enum_panel.zDistance;
            this.alpha = 0;
            resetPosition();
            super.visible = value;
            this.showTimer3D.reset();
            this.showTimer3D.start();
         }
         else
         {
            if(UIManager.isDragPanel && UIManager.curDragPanel == this)
            {
               this.upEvent(null);
            }
            if(this.bAutoRemove)
            {
               UIManager.removeVisibleView(this,0);
            }
            this.z = 0;
            this.curZ = 0;
            this.alpha = 1;
            this.hideTimer3D.reset();
            this.hideTimer3D.start();
         }
      }
      
      private function on3DShowTimer(e:TimerEvent) : void
      {
         this.z -= Enum_panel.zInterval;
         this.curZ -= Enum_panel.zInterval;
         this.alpha += 1 / Enum_panel.costTimes;
         this.transform.matrix3D.appendRotation(720 / Enum_panel.costTimes,Vector3D.X_AXIS,new Vector3D(Global.stage.stageWidth / 2,Global.stage.stageHeight / 2,this.curZ));
      }
      
      private function on3DHideTimer(e:TimerEvent) : void
      {
         this.z += Enum_panel.zInterval;
         this.curZ += Enum_panel.zInterval;
         this.alpha -= 1 / Enum_panel.costTimes;
         this.transform.matrix3D.appendRotation(-720 / Enum_panel.costTimes,Vector3D.X_AXIS,new Vector3D(Global.stage.stageWidth / 2,Global.stage.stageHeight / 2,this.curZ));
      }
      
      private function onRotation3DShowComplete(e:TimerEvent) : void
      {
         this.is3DTweenRunning = false;
         this.alpha = 1;
         this.transform.matrix = Boolean(this.primaryMatrix) ? this.primaryMatrix.clone() : null;
         this.transform.matrix3D = Boolean(this.primaryMatrix3D) ? this.primaryMatrix3D.clone() : null;
         this.popup();
         resetPosition();
      }
      
      private function onRotation3DHideComplete(e:TimerEvent) : void
      {
         this.is3DTweenRunning = false;
         this.alpha = 1;
         this.transform.matrix = Boolean(this.primaryMatrix) ? this.primaryMatrix.clone() : null;
         this.transform.matrix3D = Boolean(this.primaryMatrix3D) ? this.primaryMatrix3D.clone() : null;
         super.visible = false;
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
         else if(bind_target.parent is View_HeroHead)
         {
            this.bind_point = UIManager.heroHead.getBtnPoint(bind_target);
         }
         else if(bind_target.parent is View_ClanBattleInfo)
         {
            this.bind_point = View_ClanBattleInfo.instance.getBtnPoint(bind_target);
         }
         else if(bind_target.parent is View_HuangbangInfoPanel)
         {
            this.bind_point = View_HuangbangInfoPanel.instance.getBtnPoint(bind_target);
         }
         else if(bind_target.parent is View_CrossCampBattleInfoPanel)
         {
            this.bind_point = View_CrossCampBattleInfoPanel.instance.getBtnPoint(bind_target);
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
               this.isTweenRunning = true;
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
         stopDrag();
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
         else if(bind_target is VIP_item)
         {
            DrawObj.drawObj(bind_target,this.bind_point,(bind_target as VIP_item).sourStype);
         }
         this.stopHanlder();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var p1:Point = null;
         var p2:Point = null;
         var temp:Boolean = false;
         if(this.useRotation3D)
         {
            this.setVisibleByRotation3D(value);
         }
         else if(Boolean(bind_target))
         {
            this.smMpHandle(value);
         }
         else
         {
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
      
      private function popup() : void
      {
         if(this.parent == GameScene.uiLayer)
         {
            GameScene.uiLayer.setChildIndex(this,GameScene.uiLayer.numChildren - 1);
            if(this.bAutoRemove)
            {
               UIManager.addVisibleView(this,0);
            }
         }
      }
      
      final public function set move(rect:Rectangle) : void
      {
         this.moveBar.graphics.beginFill(0,0);
         this.moveBar.graphics.drawRect(0,0,rect.width,rect.height);
         this.moveBar.x = rect.x;
         this.moveBar.y = rect.y;
         this.moveBar.addEventListener(MouseEvent.MOUSE_DOWN,this.downEvent);
         this.moveBar.addEventListener(MouseEvent.MOUSE_UP,this.upEvent);
         addChild(this.moveBar);
      }
      
      private function onClose(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      public function upEvent(e:MouseEvent) : void
      {
         stopDrag();
         UIManager.curDragPanel = null;
         UIManager.isDragPanel = false;
      }
      
      private function downEvent(e:MouseEvent) : void
      {
         UIManager.isDragPanel = true;
         UIManager.curDragPanel = this;
         startDrag();
      }
      
      private function down(e:MouseEvent) : void
      {
         this.popup();
      }
   }
}

