package com.yiTian.view.modules.boatChall.VTip
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.net.message.cg.BoatCGMessage;
   import com.yiTian.utils.Singleton;
   
   public class QuitBtn extends V_TipBtn
   {
      
      public function QuitBtn()
      {
         super("resource/image/pata/Exit_Icon.png");
      }
      
      public static function get instance() : QuitBtn
      {
         return Singleton.getInstance(QuitBtn);
      }
      
      override protected function clickEvent(e:* = null) : void
      {
         BoatCGMessage.CG_QUIT_CHALL();
      }
      
      override public function show(_parent:* = null) : void
      {
         super.show(_parent);
         ComponentUtil.setPropertie(this,{
            "x":Global.stage.stageWidth - 296,
            "y":10
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
         x = Global.stage.stageWidth - 296;
         y = 10;
      }
   }
}

