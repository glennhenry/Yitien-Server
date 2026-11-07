package com.yiTian.view.modules.xiaoxiaole
{
   import com.yiTian.data.model.Model_xiaoxiaole;
   import com.yiTian.manager.UIManager;
   import flash.events.MouseEvent;
   
   public class XXLMouseHandler
   {
      
      private static var instance:XXLMouseHandler;
      
      private var model:Model_xiaoxiaole = Model_xiaoxiaole.getInstance();
      
      private var gezi:GeZi;
      
      public function XXLMouseHandler()
      {
         super();
      }
      
      public static function getInstance() : XXLMouseHandler
      {
         if(!instance)
         {
            instance = new XXLMouseHandler();
         }
         return instance;
      }
      
      public function Click(evt:MouseEvent) : void
      {
         if(evt.target is GeZi)
         {
            if(this.model.isEffect)
            {
               return;
            }
            if(Model_xiaoxiaole.isSelected)
            {
               UIManager.centerBroadcast.addMsg("请耐心等待上一轮数据返回!");
               return;
            }
            this.model.addNode((evt.target as GeZi).node);
         }
      }
      
      public function onDown(evt:MouseEvent) : void
      {
         if(this.model.isEffect)
         {
            return;
         }
         if(Model_xiaoxiaole.isSelected)
         {
            UIManager.centerBroadcast.addMsg("请耐心等待上一轮数据返回!");
            return;
         }
         if(evt.target is GeZi)
         {
            this.gezi = evt.target as GeZi;
            this.model.addNode(this.gezi.node);
            this.gezi.parent.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         }
      }
      
      protected function onOver(event:MouseEvent) : void
      {
         var gezi1:GeZi = null;
         var colGap:Boolean = false;
         var rowGap:Boolean = false;
         if(this.model.isEffect)
         {
            return;
         }
         if(Model_xiaoxiaole.isSelected)
         {
            UIManager.centerBroadcast.addMsg("请耐心等待上一轮数据返回!");
            return;
         }
         if(event.target is GeZi && Boolean(this.gezi))
         {
            gezi1 = event.target as GeZi;
            colGap = Math.abs(gezi1.node.col - this.gezi.node.col) == 1;
            rowGap = Math.abs(gezi1.node.row - this.gezi.node.row) == 1;
            if(colGap || !rowGap || (!colGap || rowGap))
            {
               this.model.addNode(gezi1.node);
               this.gezi.parent.removeEventListener(MouseEvent.MOUSE_OVER,this.onOver);
               this.gezi = null;
            }
         }
      }
      
      public function onUp(evt:MouseEvent) : void
      {
         if(Boolean(this.gezi) && Boolean(this.gezi.parent))
         {
            if(this.gezi.parent.hasEventListener(MouseEvent.MOUSE_OVER))
            {
               this.gezi.parent.removeEventListener(MouseEvent.MOUSE_OVER,this.onOver);
            }
         }
      }
   }
}

