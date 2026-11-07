package com.yiTian.view.modules.boatChall
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BoatCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class Child_DaoJiShi extends Panel123
   {
      
      private var tf:MyTextField;
      
      private var btn:Button;
      
      private var isRunning:Boolean = false;
      
      private var _leftTime:int;
      
      private var last:int;
      
      public function Child_DaoJiShi()
      {
         super();
         regResource("lang/ch/FWLZ.swf","FWLZdm");
      }
      
      public static function get instance() : Child_DaoJiShi
      {
         return Singleton.getInstance(Child_DaoJiShi);
      }
      
      override protected function initUI2() : void
      {
         this.btn = ComponentUtil.getButton("","Button_JCYB",this,{
            "x":344,
            "y":332,
            "textColor":16771436
         },Global.FWLZdm);
         ComponentUtil.getBitmap("Back_LZWZD",this,{
            "x":219,
            "y":387
         },Global.FWLZdm);
         ComponentUtil.getBitmap("Text_KSBS",this,{
            "x":370,
            "y":337
         },Global.FWLZdm);
         this.tf = ComponentUtil.getTextField("00:00:00",this,{
            "x":381,
            "y":358,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("注：龙舟最少坐6人之后才可以开始比赛",this,{
            "x":305,
            "y":390,
            "color":16711680,
            "size":12,
            "leading":0
         });
         this.btn.callBack = this.clickEvent;
      }
      
      private function clickEvent(e:MouseEvent) : void
      {
         if(this._leftTime > 0)
         {
            UIManager.centerBroadcast.addMsg("时间还没到哦",1);
            return;
         }
         if(GameUnitManager.hero.bindShip == null)
         {
            UIManager.centerBroadcast.addMsg("您还没有龙舟，赶紧去租一个吧",1);
            return;
         }
         BoatCGMessage.CG_STARTEDGAME();
      }
      
      public function set time(value:int) : void
      {
         this._leftTime = value;
         if(Boolean(this.tf))
         {
            this.tf.htmlText = DateUtil.getHMSBySecond2(value);
         }
         if(!this.isRunning)
         {
            this.last = getTimer();
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.run);
         }
      }
      
      private function run(intereval:int) : void
      {
         this.isRunning = true;
         var now:int = getTimer();
         if(now - this.last >= 1000)
         {
            --this._leftTime;
            if(this._leftTime < 0)
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.run);
               this.tf.htmlText = DateUtil.getHMSBySecond2(0);
               return;
            }
            this.tf.htmlText = DateUtil.getHMSBySecond2(this._leftTime);
            this.last = now;
         }
      }
      
      public function show() : void
      {
         this.visible = visible || true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.isRunning = false;
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.run);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 450) / 2 - 200;
         y = (Global.stage.stageHeight - height) / 2 - 100;
      }
   }
}

