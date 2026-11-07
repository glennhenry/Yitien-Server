package com.yiTian.view.modules.crossCampBattle
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.utils.getTimer;
   
   public class View_CampBattlePrePanel extends Panel123
   {
      
      private var txtPreTime:MyTextField;
      
      private var lastTime:uint;
      
      private var time:int;
      
      private var lastShowTime:uint;
      
      public function View_CampBattlePrePanel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_CampBattlePrePanel
      {
         return Singleton.getInstance(View_CampBattlePrePanel);
      }
      
      override protected function initStaticView() : void
      {
         this.txtPreTime = ComponentUtil.getTextField("帮会中文名称.S000",this,{
            "x":25,
            "y":0,
            "color":16043313,
            "size":24,
            "leading":0,
            "bold":true
         });
      }
      
      public function setPreTimeVisible(value:Boolean) : void
      {
         this.txtPreTime.visible = value;
      }
      
      private function frameStep() : void
      {
         var timeStr:String = null;
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 1000)
         {
            --Model_CrossCampBattle.preTime;
            timeStr = DateUtil.getMSBySecond2(Model_CrossCampBattle.preTime);
            this.txtPreTime.htmlText = "距离阵营开战时间还剩" + timeStr;
            this.lastTime = now;
            if(Model_CrossCampBattle.preTime <= 0)
            {
               this.hide();
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
         var timeStr:String = DateUtil.getMSBySecond2(Model_CrossCampBattle.preTime);
         this.txtPreTime.htmlText = "距离阵营开战时间还剩" + timeStr;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
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

