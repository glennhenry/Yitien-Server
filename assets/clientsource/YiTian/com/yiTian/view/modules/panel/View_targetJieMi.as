package com.yiTian.view.modules.panel
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.Little_system_CGMessage;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.view.UIBase123;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_targetJieMi extends UIBase123
   {
      
      private var _bmTxt:Bitmap2;
      
      private var _bmWeapon:Bitmap2;
      
      private var _shape:Shape;
      
      public function View_targetJieMi()
      {
         super();
         regResource("lang/ch/TargetPrompt.swf","TargetPromptdm");
      }
      
      public function setbBindTarget(target:Sprite) : void
      {
         bindParent = target;
         if(visible)
         {
            bindParent.addChild(this);
            resetPosition();
         }
      }
      
      override protected function initUI2() : void
      {
         this._shape = ComponentUtil.getShape(558,340,0,0.3);
         this._shape.x = 14;
         this._shape.y = 32;
         addChild(this._shape);
         ComponentUtil.getBitmap("Back01",this,{
            "x":0,
            "y":85
         },Global.TargetPromptdm);
         this._bmWeapon = new Bitmap2();
         this._bmWeapon.x = 24;
         this._bmWeapon.y = 107;
         addChild(this._bmWeapon);
         this._bmTxt = new Bitmap2();
         this._bmTxt.x = 273;
         this._bmTxt.y = 83;
         addChild(this._bmTxt);
         ComponentUtil.getButton("","Button_JieMi",this,{
            "x":251,
            "y":220,
            "textColor":16184781,
            "callBack":this.jieMiClickHd
         },Global.TargetPromptdm);
      }
      
      private function jieMiClickHd(e:MouseEvent) : void
      {
         visible = false;
         Model_target.type = 2;
         Model_target.jieMiFlag = 0;
         Global.control.sendNotification(Model_target.TARGET_TYPE_CHANGE,null);
         Little_system_CGMessage.CG_CHIP_TASK_JIEMI();
      }
      
      public function show(opt:* = null) : void
      {
         visible = true;
         this._bmWeapon.load(Model_target.getWeaponUrl(2));
         this._bmTxt.load(Model_target.getTitleUrl(2));
      }
      
      public function hide(opt:* = null) : void
      {
         visible = false;
      }
   }
}

