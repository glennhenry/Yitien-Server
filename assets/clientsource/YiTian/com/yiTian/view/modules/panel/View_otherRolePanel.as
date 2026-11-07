package com.yiTian.view.modules.panel
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.vo.vo_otherRoleInfo;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   
   public class View_otherRolePanel extends Panel
   {
      
      public function View_otherRolePanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         Global.control.registerCallBack(Enum_MsgType.MSG_CHECKOTHERROLE,this.check);
      }
      
      private function check(id:Number) : void
      {
         var vo:vo_otherRoleInfo = null;
         if(UIManager.heroInfoPanel.id == id && UIManager.heroInfoPanel.visible)
         {
            UIManager.heroInfoPanel.visible = false;
            return;
         }
         RoleCGMessage.CG_CHECK_OTHERROLE(id);
      }
      
      protected function equipClickHandle(evt:MouseEvent = null) : void
      {
      }
      
      protected function meridianClickHandle(evt:MouseEvent = null) : void
      {
      }
      
      override public function resetPosition() : void
      {
         x = 100;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

