package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.utils.getTimer;
   
   public class View_MsgPanel extends Panel123
   {
      
      private var preTimeIcon:Bitmap;
      
      private var tipIcon:Bitmap;
      
      private var txtPreTime:MyTextField;
      
      private var lastTime:uint;
      
      private var time:int;
      
      private var lastShowTime:uint;
      
      public function View_MsgPanel()
      {
         super();
         regResource("lang/ch/KFBang_CC.swf","KFBang_CCdm");
      }
      
      public static function get instance() : View_MsgPanel
      {
         return Singleton.getInstance(View_MsgPanel);
      }
      
      override protected function initUI2() : void
      {
         this.preTimeIcon = ComponentUtil.getBitmap("Text_DaoJi",this,{
            "x":20,
            "y":5
         },Global.KFBang_CCdm);
         this.tipIcon = ComponentUtil.getBitmap("Text_ShaoHou",this,{
            "x":20,
            "y":5
         },Global.KFBang_CCdm);
         this.txtPreTime = ComponentUtil.getTextField("帮会中文名称.S000",this,{
            "x":25 + this.preTimeIcon.width,
            "y":0,
            "color":16043313,
            "size":24,
            "leading":0,
            "bold":true
         });
      }
      
      public function setPreTimeVisible(value:Boolean) : void
      {
         this.preTimeIcon.visible = value;
         this.txtPreTime.visible = value;
         this.tipIcon.visible = !value;
      }
      
      private function frameStep() : void
      {
         var timeStr:String = null;
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 1000)
         {
            --Model_CrossClanBattle.preTime;
            timeStr = DateUtil.getMSBySecond2(Model_CrossClanBattle.preTime);
            this.txtPreTime.htmlText = timeStr;
            this.lastTime = now;
            if(Model_CrossClanBattle.preTime <= 0)
            {
               this.hide();
               View_ClanBattleInfo.instance.start();
            }
         }
      }
      
      public function showPreTime() : void
      {
         if(visible == true)
         {
            return;
         }
         visible = true;
         this.setPreTimeVisible(true);
         var timeStr:String = DateUtil.getMSBySecond2(Model_CrossClanBattle.preTime);
         this.txtPreTime.htmlText = timeStr;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
      }
      
      public function showTipIcon() : void
      {
         this.tipIcon.visible = true;
         this.tipIcon.alpha = 1;
         Tween.to(this.tipIcon,1000,{"y":[Global.stage.stageHeight - 200,-100]},this.stay,null,Tween.SIN);
      }
      
      private function stay() : void
      {
         Tween.to(this.tipIcon,1000,{"alpha":[1,1]},this.stayVisible,null,Tween.BEE_LINE);
      }
      
      private function stayVisible() : void
      {
         Tween.to(this.tipIcon,1000,{"alpha":[1,0]},this.hideTipIcon,null,Tween.BEE_LINE);
      }
      
      public function hideTipIcon() : void
      {
         this.tipIcon.visible = false;
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

