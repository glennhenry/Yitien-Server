package com.yiTian.view.modules.boatChall.VTip
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.boatChall.V_helpPanel;
   
   public class V_helpTBtn extends V_TipBtn
   {
      
      public function V_helpTBtn()
      {
         super("resource/image/kuafubangzhan/help.png");
      }
      
      public static function get instance() : V_TipBtn
      {
         return Singleton.getInstance(V_helpTBtn);
      }
      
      override protected function clickEvent(e:* = null) : void
      {
         V_helpPanel.instance.show();
      }
      
      override public function show(_parent:* = null) : void
      {
         super.show(_parent);
         ComponentUtil.setPropertie(this,{
            "x":Global.stage.stageWidth - 360,
            "y":6
         });
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
      }
      
      override public function hide(_parent:* = null) : void
      {
         super.hide(_parent);
         Global.control.removeCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
      }
      
      private function resetPosition() : void
      {
         x = Global.stage.stageWidth - 360;
         y = 10;
      }
   }
}

