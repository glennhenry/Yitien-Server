package com.yiTian.view.modules.wing
{
   import com.ui.controls.Button;
   import com.ui.controls.MaskProgressBar2;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_wing;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.WingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel123;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_wing_blessTipsMenu extends Panel123
   {
      
      private static var _instance:View_wing_blessTipsMenu;
      
      private var progress:MaskProgressBar2;
      
      private var blessTxt:MyTextField;
      
      private var leftTimeTxt:MyTextField;
      
      private var upLevelBtn:Button;
      
      private var holdOnBtn:Button;
      
      private var beginTime:int;
      
      private var pastTime:int;
      
      private var effSpr:Sprite;
      
      public function View_wing_blessTipsMenu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/ChiBang.swf","ChiBangdm");
      }
      
      public static function get instance() : View_wing_blessTipsMenu
      {
         if(!_instance)
         {
            _instance = new View_wing_blessTipsMenu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         move = new Rectangle(0,0,620,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":620,
            "height":383
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":570,
            "height":333
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":546,
            "height":268
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Back_JJTS",this,{
            "x":44,
            "y":61
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Dot_JJTS",this,{
            "x":93,
            "y":171
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Dot_JJTS",this,{
            "x":93,
            "y":248
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Title_JJTS",this,{
            "x":230,
            "y":6
         },Global.ChiBangdm);
         ComponentUtil.getTextField("什么是祝福值？",this,{
            "x":118,
            "y":165,
            "color":15660032,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField("是指翅膀进阶失败后为您增加下次进阶成功的机率，祝福值越高，成功率越高",this,{
            "x":118,
            "y":190,
            "color":16772287,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("什么是祝福值保存倒计时？",this,{
            "x":118,
            "y":242,
            "color":15660032,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField("祝福值在进阶成功后和倒计时结束清零，建议您一次性完成进阶，避免错过进\n" + "阶时间，造成损失",this,{
            "x":118,
            "y":267,
            "color":16772287,
            "size":12,
            "leading":3
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":585,
            "y":5,
            "textColor":16771436
         },Global.Img_Cdm);
         CloseButton.callBack = this.closeMenu;
         this.progress = new MaskProgressBar2(ComponentUtil.getBitmap("Line_JDT",null,{
            "x":82,
            "y":93
         },Global.ChiBangdm),ComponentUtil.getBitmap("Line_JDTD",null,{
            "x":44,
            "y":86
         },Global.ChiBangdm));
         addChild(this.progress);
         this.blessTxt = ComponentUtil.getTextField("0/0",this,{
            "x":310,
            "y":91,
            "color":16772287,
            "size":12,
            "leading":0
         },"center");
         this.effSpr = new Sprite();
         addChild(this.effSpr);
         this.effSpr.x = 309;
         this.effSpr.y = 102;
         this.effSpr.mouseEnabled = false;
         this.effSpr.mouseChildren = false;
         EffectManager.addEffect("35286",this.effSpr,1000,0,0,true);
         this.effSpr.visible = false;
         ComponentUtil.getTextField("祝福值清除倒计时：",this,{
            "x":233,
            "y":120,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.leftTimeTxt = ComponentUtil.getTextField("00:00:00",this,{
            "x":336,
            "y":119,
            "color":65280,
            "size":14,
            "leading":0
         });
         this.upLevelBtn = ComponentUtil.getButton("继续进阶","Button_JinJie",this,{
            "x":149,
            "y":327,
            "textColor":16771436
         },Global.ChiBangdm);
         this.upLevelBtn.callBack = function():void
         {
            visible = false;
            if(!View_wing_menu.instance.visible)
            {
               Global.delegate.dosomething(View_wing_menu.instance,function():void
               {
                  WingCGMessage.CG_WING_OPEN();
               });
            }
         };
         this.holdOnBtn = ComponentUtil.getButton("稍后再说","Button_JinJie",this,{
            "x":369,
            "y":327,
            "textColor":16771436
         },Global.ChiBangdm);
         this.holdOnBtn.callBack = this.closeMenu;
      }
      
      private function closeMenu(e:*) : void
      {
         this.visible = false;
      }
      
      public function update() : void
      {
         this.blessTxt.text = String(Model_wing.bless) + "/" + String(Data_lib.wing[Model_wing.wingId][5]);
         this.leftTimeTxt.text = DateUtil.getHMSBySecond2(Model_wing.blessTime);
         this.progress.persent = Model_wing.bless / Data_lib.wing[Model_wing.wingId][5];
         if(Model_wing.bless > 0)
         {
            this.effSpr.visible = true;
            this.beginTime = getTimer();
            GameScene.instance.addFrameCallBack(this.frameCallBack);
         }
         else
         {
            this.effSpr.visible = false;
            GameScene.instance.removeFrameCallBack(this.frameCallBack);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            WingCGMessage.CG_WING_BLESS_MENU();
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.frameCallBack);
         }
      }
      
      private function frameCallBack() : void
      {
         this.pastTime = getTimer() - this.beginTime;
         if(this.pastTime > 1000)
         {
            if(this.pastTime >= Model_wing.blessTime * 1000)
            {
               GameScene.instance.removeFrameCallBack(this.frameCallBack);
               Model_wing.bless = 0;
               Model_wing.blessTime = 0;
               this.effSpr.visible = false;
               this.blessTxt.text = String(Model_wing.bless) + "/" + String(Data_lib.wing[Model_wing.wingId][5]);
               this.progress.persent = Model_wing.bless / Data_lib.wing[Model_wing.wingId][5];
               this.leftTimeTxt.text = DateUtil.getHMSBySecond2(Model_wing.blessTime);
            }
            else
            {
               this.leftTimeTxt.text = DateUtil.getHMSBySecond2(Model_wing.blessTime - this.pastTime / 1000);
            }
         }
      }
   }
}

