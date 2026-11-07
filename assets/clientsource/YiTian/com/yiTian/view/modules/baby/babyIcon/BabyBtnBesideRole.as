package com.yiTian.view.modules.baby.babyIcon
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.baby.babyManager.Enum_baby;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import com.yiTian.view.modules.baby.babyPan.View_babyPan;
   import com.yiTian.view.modules.mainMenu.MicroButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BabyBtnBesideRole extends Sprite
   {
      
      public static const BABYPAN_MSG_BACK:String = "babyPan_msg_back";
      
      public function BabyBtnBesideRole()
      {
         super();
         buttonMode = true;
         addChild(Utils.getLoadBitmap("resource/image/baby/Icon_JSZN.png"));
         addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            Model_baby.show(View_babyPan.instance);
         });
         addEventListener(MouseEvent.ROLL_OVER,this.over);
         addEventListener(MouseEvent.ROLL_OUT,this.out);
      }
      
      private function over(e:MouseEvent) : void
      {
         filters = Util.glowFFFF00;
      }
      
      private function out(e:MouseEvent) : void
      {
         filters = [];
      }
      
      public function init() : void
      {
         Global.control.registerCallBack(Enum_baby.ENUM_ROLEBTN_MOVE,this.resize);
         this.setPosition();
      }
      
      private function resize(mBtn:MicroButton) : void
      {
         if(mBtn == UIManager.mainMenu.roleBtn)
         {
            this.setPosition();
         }
      }
      
      public function remove() : void
      {
         Global.control.removeCallBack(Enum_baby.ENUM_ROLEBTN_MOVE,this.resize);
      }
      
      public function setPosition() : void
      {
         x = UIManager.mainMenu.roleBtn.x + 25;
         y = UIManager.mainMenu.roleBtn.y - 5;
      }
   }
}

