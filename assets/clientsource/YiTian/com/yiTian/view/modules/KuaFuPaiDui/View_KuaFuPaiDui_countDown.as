package com.yiTian.view.modules.KuaFuPaiDui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_KuaFuPaiDui;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.KuaFuPaiDuiCGMessage;
   import com.yiTian.view.Panel;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class View_KuaFuPaiDui_countDown extends Panel
   {
      
      private static var _instance:View_KuaFuPaiDui_countDown;
      
      public var findBtn:Button;
      
      public var relieveBtn:Button;
      
      private var time:MyTextField;
      
      private var arrowEff:Effect;
      
      private var arrow:Sprite;
      
      public function View_KuaFuPaiDui_countDown()
      {
         super();
         init();
      }
      
      public static function get instance() : View_KuaFuPaiDui_countDown
      {
         if(!_instance)
         {
            _instance = new View_KuaFuPaiDui_countDown();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         bAutoRemove = false;
         move = new Rectangle(0,0,280,55);
         ComponentUtil.getBitmap("Back_QLW",this,{
            "x":0,
            "y":0
         },Global.KFPDdm);
         ComponentUtil.getBitmap("Text_QLW",this,{
            "x":34,
            "y":20
         },Global.KFPDdm);
         this.time = ComponentUtil.getTextField("0",this,{
            "x":212,
            "y":16,
            "color":16729670,
            "size":16,
            "leading":0,
            "autoSize":"center"
         });
         this.findBtn = ComponentUtil.getButton("","Button_XZWB",this,{
            "x":98,
            "y":60,
            "textColor":16771436
         },Global.KFPDdm);
         this.findBtn.callBack = function():void
         {
            View_KuaFuPaiDui_partnerMenu.instance.visible = true;
         };
         this.relieveBtn = ComponentUtil.getButton("","Button_JCWB",this,{
            "x":98,
            "y":60,
            "textColor":16771436
         },Global.KFPDdm);
         this.relieveBtn.callBack = function():void
         {
            KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_BREAK_UP();
         };
         this.relieveBtn.visible = false;
         this.arrow = new Sprite();
         addChild(this.arrow);
         this.arrowEff = EffectManager.addEffect("35247",this.arrow,2000,58,75,true);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.INVITE_SUCCEED,this.inviteSucceed);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.BREAK_UP,this.breakUp);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.EXIT,this.exit);
      }
      
      private function inviteSucceed(e:*) : void
      {
         this.findBtn.visible = false;
         this.relieveBtn.visible = true;
         this.arrow.visible = false;
         if(Model_KuaFuPaiDui.isDanceing)
         {
            this.visible = false;
         }
      }
      
      private function breakUp(e:*) : void
      {
         this.findBtn.visible = true;
         this.relieveBtn.visible = false;
         this.arrow.visible = true;
         this.visible = true;
      }
      
      private function exit(e:*) : void
      {
         this.findBtn.visible = true;
         this.relieveBtn.visible = false;
         this.arrow.visible = true;
      }
      
      public function setTime(seconds:int) : void
      {
         this.time.text = seconds.toString();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = 100;
      }
   }
}

