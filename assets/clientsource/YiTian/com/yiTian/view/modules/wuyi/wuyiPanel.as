package com.yiTian.view.modules.wuyi
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   import com.yiTian.net.message.cg.WuYiCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.treasureBowl.View_treasureBowl;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class wuyiPanel extends Panel123
   {
      
      private static var _instance:wuyiPanel;
      
      public static const BMX:int = 129;
      
      public static const BMY:int = 5;
      
      private var timetf:MyTextField;
      
      private var bitmapArr:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var bmArr:Vector.<Sprite> = new Vector.<Sprite>();
      
      private var TipsArr:Vector.<Sprite> = new Vector.<Sprite>();
      
      private var ClickArr:Vector.<Sprite> = new Vector.<Sprite>();
      
      private var tips:Array = ["活动期间，玩家只要在秘境购买道具，聚宝盆内绑银就会进行累积，每日活动结束后，消耗元宝最多的三位玩家按比例获得当日聚宝盆内的绑银。","活动期间，每天24:00结束后竞技场前1000名均可获得奖励。","活动期间，运镖时可额外获得20%的经验加成。"];
      
      private var back:Bitmap;
      
      private var bmxArr:Array = [325,308,288];
      
      private var bmyArr:Array = [167,264,361];
      
      public function wuyiPanel()
      {
         super();
         regResource("lang/ch/WuYi.swf","WuYidm");
      }
      
      public static function get instance() : wuyiPanel
      {
         if(!_instance)
         {
            _instance = new wuyiPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         this.back = ComponentUtil.getBitmap("Back_Imgs",this,{
            "x":0,
            "y":0
         },Global.WuYidm);
         ComponentUtil.getBitmap("List_01",this,{
            "x":325,
            "y":167
         },Global.WuYidm);
         ComponentUtil.getBitmap("List_02",this,{
            "x":308,
            "y":264
         },Global.WuYidm);
         ComponentUtil.getBitmap("List_03",this,{
            "x":288,
            "y":361
         },Global.WuYidm);
         this.timetf = ComponentUtil.getTextField("00月00日 00:00 - 00月00日 00:00",this,{
            "x":347,
            "y":123,
            "color":8453888,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,this.back.width,this.back.height);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":700,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.callBack = this.close;
         this.bmArr.length = 3;
         this.TipsArr.length = 3;
         this.ClickArr.length = 3;
         while(i < this.bmArr.length)
         {
            this.bitmapArr[i] = new Bitmap();
            this.bitmapArr[i] = Utils.getLoadBitmap("resource/image/wuyi/" + "wy" + i + ".png",this.bitmapArr[i]);
            this.bitmapArr[i].x = this.bmxArr[i] + BMX;
            this.bitmapArr[i].y = this.bmyArr[i] + BMY;
            addChild(this.bitmapArr[i]);
            this.TipsArr[i] = new Sprite();
            this.TipsArr[i].graphics.beginFill(16711680,0);
            this.TipsArr[i].graphics.drawRect(this.bmxArr[i],this.bmyArr[i],340,62);
            this.TipsArr[i].graphics.endFill();
            this.TipsArr[i].buttonMode = true;
            addChild(this.TipsArr[i]);
            this.bmArr[i] = new Sprite();
            this.bmArr[i].graphics.beginFill(16711680,0);
            this.bmArr[i].graphics.drawRect(this.bmxArr[i] + BMX,this.bmyArr[i] + BMY,50,50);
            this.bmArr[i].graphics.endFill();
            this.bmArr[i].buttonMode = true;
            addChild(this.bmArr[i]);
            this.bmArr[i].addEventListener(MouseEvent.CLICK,this.btnClick);
            this.bmArr[i].addEventListener(MouseEvent.MOUSE_OVER,this.over);
            this.bmArr[i].addEventListener(MouseEvent.MOUSE_OUT,this.out);
            this.ClickArr[i] = new Sprite();
            this.ClickArr[i].graphics.beginFill(16711680,0);
            this.ClickArr[i].graphics.drawRect(this.bmxArr[i] + BMX + 140,this.bmyArr[i] + BMY + 24,68,22);
            this.ClickArr[i].graphics.endFill();
            this.ClickArr[i].buttonMode = true;
            addChild(this.ClickArr[i]);
            this.ClickArr[i].addEventListener(MouseEvent.CLICK,this.btnClick);
            i++;
         }
         this.addtips();
      }
      
      private function addtips() : void
      {
         var i:int = 0;
         while(i < this.TipsArr.length)
         {
            if(this.TipsArr[i] != null)
            {
               TipManager.bind(this.TipsArr[i],this.tips[i]);
            }
            if(this.bmArr[i] != null)
            {
               TipManager.bind(this.bmArr[i],this.tips[i]);
            }
            if(this.ClickArr[i] != null)
            {
               TipManager.bind(this.ClickArr[i],this.tips[i]);
            }
            i++;
         }
      }
      
      private function over(e:MouseEvent) : void
      {
         switch(e.target)
         {
            case this.bmArr[0]:
               this.bitmapArr[0].transform.colorTransform = Util.colorGlow;
               break;
            case this.bmArr[1]:
               this.bitmapArr[1].transform.colorTransform = Util.colorGlow;
               break;
            case this.bmArr[2]:
               this.bitmapArr[2].transform.colorTransform = Util.colorGlow;
         }
      }
      
      private function out(e:MouseEvent) : void
      {
         switch(e.target)
         {
            case this.bmArr[0]:
               this.bitmapArr[0].transform.colorTransform = Util.colorNomal;
               break;
            case this.bmArr[1]:
               this.bitmapArr[1].transform.colorTransform = Util.colorNomal;
               break;
            case this.bmArr[2]:
               this.bitmapArr[2].transform.colorTransform = Util.colorNomal;
         }
      }
      
      private function close(e:MouseEvent) : void
      {
         visible = false;
      }
      
      private function btnClick(e:MouseEvent) : void
      {
         switch(e.target)
         {
            case this.bmArr[0]:
               if(!UIManager.treasureBowlPanel)
               {
                  UIManager.treasureBowlPanel = new View_treasureBowl();
                  UIManager.treasureBowlPanel.init();
               }
               UIManager.treasureBowlPanel.visible = true;
               break;
            case this.bmArr[1]:
               if(GameUnitManager.hero.level < 25)
               {
                  UIManager.centerBroadcast.addMsg("开启等级25级");
                  return;
               }
               JingJiChangCGMessage.CG_GET_PAIMING();
               JingJiChangCGMessage.CG_GET_WAR_INFO();
               UIManager.jjc_panel.visible = !UIManager.jjc_panel.visible;
               break;
            case this.bmArr[2]:
               UIManager.paoBiaoPanel.shenBiaoHandler();
               break;
            case this.ClickArr[0]:
               if(!UIManager.treasureBowlPanel)
               {
                  UIManager.treasureBowlPanel = new View_treasureBowl();
                  UIManager.treasureBowlPanel.init();
               }
               UIManager.treasureBowlPanel.visible = true;
               break;
            case this.ClickArr[1]:
               if(GameUnitManager.hero.level < 25)
               {
                  UIManager.centerBroadcast.addMsg("开启等级25级");
                  return;
               }
               JingJiChangCGMessage.CG_GET_PAIMING();
               JingJiChangCGMessage.CG_GET_WAR_INFO();
               UIManager.jjc_panel.visible = !UIManager.jjc_panel.visible;
               break;
            case this.ClickArr[2]:
               UIManager.paoBiaoPanel.shenBiaoHandler();
         }
      }
      
      public function open() : void
      {
         if(wuyiVO.endTime > 999)
         {
            this.timetf.text = wuyiVO.starTime.toString().slice(0,4) + "年" + wuyiVO.starTime.toString().slice(4,6) + "月" + wuyiVO.starTime.toString().slice(6,8) + "日00:00:00至" + wuyiVO.endTime.toString().slice(0,2) + "月" + wuyiVO.endTime.toString().slice(2,4) + "日23:59:59";
         }
         else
         {
            this.timetf.text = wuyiVO.starTime.toString().slice(0,4) + "年" + wuyiVO.starTime.toString().slice(4,6) + "月" + wuyiVO.starTime.toString().slice(6,8) + "日00:00:00至0" + wuyiVO.endTime.toString().slice(0,1) + "月" + wuyiVO.endTime.toString().slice(1,3) + "日23:59:59";
         }
      }
      
      public function show() : void
      {
         visible = !visible;
         if(visible)
         {
            WuYiCGMessage.CG_WUYI_TIME();
         }
      }
   }
}

