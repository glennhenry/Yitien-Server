package com.yiTian.view.modules.chat
{
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.TipManager;
   import com.yiTian.view.comp.View_Grid;
   import flash.events.MouseEvent;
   
   public class ChatTip extends View_Grid
   {
      
      public static var pool:Array = [];
      
      public function ChatTip()
      {
         super();
         Global.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
      }
      
      public static function getInstance() : ChatTip
      {
         var newInstance:ChatTip = null;
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         newInstance = new ChatTip();
         pool.push(newInstance);
         return newInstance;
      }
      
      private function mDownHandle(e:MouseEvent) : void
      {
         TipManager.hide();
         pool = [];
         Global.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
         visible = false;
         delete global[this];
      }
      
      public function show(_vo:Vo_grid) : void
      {
         vo = _vo;
         TipManager.update(vo);
         this.resetPos(vo);
      }
      
      private function resetPos(_vo:Vo_grid) : void
      {
         var temGap:int = 0;
         TipManager.view_tip.x = Global.stage.mouseX + 5;
         TipManager.view_tip.y = Global.stage.mouseY - TipManager.view_tip.height - 5;
         TipManager.view_equip.x = TipManager.view_tip.x + TipManager.view_tip.width;
         TipManager.view_equip.y = TipManager.view_tip.y;
         if(TipManager.view_tip.x + TipManager.view_tip.width > Global.stage.stageWidth)
         {
            TipManager.view_tip.x = Global.stage.mouseX - TipManager.view_tip.width - 5;
         }
         if(_vo is Vo_equip)
         {
            if(TipManager.view_equip.y + TipManager.view_equip.height > Global.stage.stageHeight)
            {
               temGap = TipManager.view_equip.y + TipManager.view_equip.height - Global.stage.stageHeight;
               TipManager.view_tip.y = TipManager.view_equip.y = Global.stage.mouseY - TipManager.view_tip.height - 5 - temGap - 5;
            }
         }
      }
   }
}

