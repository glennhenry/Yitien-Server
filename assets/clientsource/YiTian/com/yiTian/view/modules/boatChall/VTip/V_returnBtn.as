package com.yiTian.view.modules.boatChall.VTip
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.boatChall.BoatGrids;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.boatChall.Child_DaoJiShi;
   import com.yiTian.view.modules.boatChall.EndTipPan;
   
   public class V_returnBtn extends V_TipBtn
   {
      
      public function V_returnBtn()
      {
         super("resource/image/AiDeBaoBao/return.png");
      }
      
      public static function get instance() : V_returnBtn
      {
         return Singleton.getInstance(V_returnBtn);
      }
      
      override protected function clickEvent(e:* = null) : void
      {
         CameraManager.cameraFromTo(BoatManager.END_X,BoatManager.END_Y,BoatManager.WATCH_X,BoatManager.WATCH_Y,500,function():void
         {
            var _temp_1:* = BoatManager;
            BoatManager.END_Y = 0;
            _temp_1.END_X = 0;
            Global.isPlayingMarriageEffect = false;
            Child_DaoJiShi.instance.visible = true;
            BoatManager.isMyShipEnding = false;
            EndTipPan.instance.hide();
            hide(Global.stage);
            BoatGrids.instance.hide();
         });
      }
      
      override public function show(_parent:* = null) : void
      {
         super.show(_parent);
         ComponentUtil.setPropertie(this,{
            "x":Global.stage.stageWidth - 424,
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
         x = Global.stage.stageWidth - 424;
         y = 10;
      }
   }
}

