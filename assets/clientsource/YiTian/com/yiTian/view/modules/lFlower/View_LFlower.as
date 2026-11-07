package com.yiTian.view.modules.lFlower
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_LFower;
   import com.yiTian.data.vo.Vo_DynamicTip;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.LFlowerCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class View_LFlower extends Panel123
   {
      
      private static var _instance:View_LFlower;
      
      private static const MAX:int = 251;
      
      private var cost:int;
      
      private var isShowAlert:Boolean;
      
      private var temp:int;
      
      private var timer:Timer;
      
      private var wy_btn:Button;
      
      private var cd_txt:MyTextField;
      
      private var bm:Bitmap;
      
      public function View_LFlower()
      {
         super();
         regResource("lang/ch/AQZH.swf","AQZHdm");
      }
      
      public static function get instance() : View_LFlower
      {
         if(!_instance)
         {
            _instance = new View_LFlower();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var str:String;
         var vo:Vo_DynamicTip;
         var spr:Sprite = new Sprite();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":512,
            "height":526
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":462,
            "height":476
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":477,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_AQZH",this,{
            "x":186,
            "y":5
         },Global.AQZHdm);
         ComponentUtil.getBitmap("Back_AQZH",spr,{
            "x":37,
            "y":52
         },Global.AQZHdm);
         this.addChild(spr);
         ComponentUtil.getBitmap("Flower",this,{
            "x":202,
            "y":92
         },Global.AQZHdm);
         ComponentUtil.getBitmap("Back_JDTD",this,{
            "x":117,
            "y":420
         },Global.AQZHdm);
         this.bm = ComponentUtil.getBitmap("Back_JDT",this,{
            "x":131,
            "y":434
         },Global.AQZHdm);
         this.wy_btn = ComponentUtil.getButton("","Button_ShuiDian",this,{
            "x":390,
            "y":419,
            "textColor":16771436,
            "callBack":this.onWeiyangHandler
         },Global.AQZHdm);
         this.cd_txt = ComponentUtil.getTextField("0/10",this,{
            "x":239,
            "y":427
         });
         str = "爱情之花成长为<font color=\'#04ff00\'>1</font>的时奖励：<font color=\'#de45c7\'>  情人节属性丹</font>*1\n";
         str += "爱情之花成长为<font color=\'#04ff00\'>5</font>的时奖励：<font color=\'#de45c7\'>  情人节属性丹</font>*2\n";
         str += "爱情之花成长为<font color=\'#04ff00\'>10</font>的时奖励：<font color=\'#de45c7\'>情人节属性丹</font>*2\n";
         str += "奖励以邮件的形式发送";
         vo = new Vo_DynamicTip();
         vo._w = 450;
         vo.info = str;
         TipManager.bind(spr,vo);
         TipManager.bind(this.wy_btn,"点击种植爱情之花");
         this.timer = new Timer(1000);
         this.timer.addEventListener(TimerEvent.TIMER,this.timerHandler);
         this.bm.width = 1;
         move = new Rectangle(0,0,477,36);
      }
      
      protected function timerHandler(event:TimerEvent) : void
      {
         var hour:int = 0;
         var min:int = 0;
         var s:int = 0;
         var ss:String = null;
         var money:int = 0;
         --Model_LFower.cdTime;
         var cd:String = "";
         if(Model_LFower.cdTime <= 0)
         {
            this.timer.reset();
            this.timer.stop();
            Model_LFower.cdTime = 0;
         }
         if(this.isShowAlert)
         {
            hour = int(Model_LFower.cdTime / 60 / 60);
            min = int((Model_LFower.cdTime - hour * 60 * 60) / 60);
            s = int(Model_LFower.cdTime - hour * 60 * 60 - min * 60);
            ss = s < 10 ? "0" + s : s + "";
            cd = hour + ":" + min + ":" + ss;
            money = Math.ceil(hour * 6 + min / 10);
            View_Alert.show("是否花费<font color=\'#f9ff00\'>" + money + "元宝</font>清除CD？\n<font color=\'#318669\'>    CD时间：" + cd + "</font>",View_Alert.OK_CANCAL,this.costOkFun,this.cancelFun);
         }
      }
      
      public function onOpenWin(evt:MouseEvent = null) : void
      {
         if(GameUnitManager.hero.marriageID == 0)
         {
            UIManager.centerBroadcast.addMsg("赶紧去结婚吧，才能种植爱情之花，可获得情人节属性丹哦",1);
            return;
         }
         if(Model_LFower.currentCZ >= Model_LFower.nextCZ)
         {
            UIManager.centerBroadcast.addMsg("爱情之花成长值已满，不能喂养",1);
         }
         else
         {
            LFlowerCGMessage.CG_IFLOWER_OPEN();
            this.visible = true;
         }
      }
      
      private function onWeiyangHandler(evt:MouseEvent) : void
      {
         View_Alert.show("是否向伴侣邀请一起种植爱情之花<br/><font color=\'#318669\'>(每两个小时可再次喂养爱情之花)</font>",View_Alert.OK_CANCAL,function():void
         {
            LFlowerCGMessage.CG_IFLOWER_WY();
         });
      }
      
      public function killCD() : void
      {
         var hour:int = 0;
         var min:int = 0;
         var s:int = 0;
         var ss:String = null;
         var cd:String = null;
         var money:int = 0;
         if(Model_LFower.cdTime >= 0)
         {
            this.isShowAlert = true;
            hour = int(Model_LFower.cdTime / 60 / 60);
            min = int((Model_LFower.cdTime - hour * 60 * 60) / 60);
            s = int(Model_LFower.cdTime - hour * 60 * 60 - min * 60);
            ss = s < 10 ? "0" + s : s + "";
            cd = hour + ":" + min + ":" + ss;
            money = Math.ceil(hour * 6 + min / 10);
            View_Alert.show("是否花费<font color=\'#f9ff00\'>" + money + "元宝</font>清除CD？\n<font color=\'#318669\'>    CD时间：" + cd + "</font>",View_Alert.OK_CANCAL,this.costOkFun,this.cancelFun);
         }
         else
         {
            this.okSend();
         }
      }
      
      private function costOkFun() : void
      {
         this.isShowAlert = false;
         if(GameUnitManager.hero.money >= this.cost)
         {
            this.okSend();
         }
         else
         {
            UIManager.centerBroadcast.addMsg("元宝不足，请及时充值！");
         }
      }
      
      private function okSend() : void
      {
         LFlowerCGMessage.CG_IFLOWER_KILLCD();
      }
      
      private function cancelFun() : void
      {
         this.isShowAlert = false;
      }
      
      public function stopTimer() : void
      {
         if(Boolean(this.timer))
         {
            this.timer.reset();
            this.timer.stop();
         }
         this.isShowAlert = false;
      }
      
      public function update() : void
      {
         if(Model_LFower.cdTime > 2)
         {
            this.timer.start();
         }
         this.cd_txt.htmlText = Model_LFower.currentCZ + "/" + Model_LFower.nextCZ;
         var num:int = Model_LFower.currentCZ / Model_LFower.nextCZ * MAX;
         Tween.to(this.bm,200,{"width":[this.bm.width,num]});
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
   }
}

