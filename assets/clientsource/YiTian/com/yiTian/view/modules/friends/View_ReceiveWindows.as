package com.yiTian.view.modules.friends
{
   import com.event.TextField_h;
   import com.ui.controls.*;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Pool;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class View_ReceiveWindows extends Panel
   {
      
      private var bg_back:DisplayObjectContainer;
      
      public var data:Object = null;
      
      public var sender:TextField_h;
      
      private var timer:Timer = new Timer(10000,1);
      
      private const WIDTH:int = 605;
      
      private const HEIGHT:int = 468;
      
      private var message:String;
      
      private var isUIComplete:Boolean = false;
      
      public function View_ReceiveWindows()
      {
         super();
         this.bg_back = new Sprite();
         this.bg_back.mouseEnabled = false;
         addChild(this.bg_back);
         move = new Rectangle(0,0,this.WIDTH,this.HEIGHT);
         CloseButton = ComponentUtil.getButton("","NPC_Close",this,{
            "x":494,
            "y":64
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.onClose);
         this.sender = ComponentUtil.getTextField_h("",this);
         this.sender.x = this.WIDTH / 2 - this.sender.width / 2;
         this.sender.y = 170;
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this.addEventListener(MouseEvent.CLICK,this.swapHandler);
         bindParent = GameScene.uiLayer;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.Marry_Imgsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/Marry_Imgs.swf",function(info:Object):void
                  {
                     Global.Marry_Imgsdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     View_loading.instance.visible = false;
                     visible = timer.running;
                  });
                  return;
               }
               this.initT();
            }
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         this.isUIComplete = true;
         var bm:Bitmap = new Bitmap();
         bm.bitmapData = ComponentUtil.getBitmapData("Back_Marry",Global.Marry_Imgsdm);
         this.bg_back.addChild(bm);
         var btn_get:Button = ComponentUtil.getButton(LangConfig.getWord("29260",2),"Button_Marry",this,{
            "x":257,
            "y":280
         },Global.Marry_Imgsdm);
         btn_get.callBack = this.onClick;
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         if(Boolean(this.data))
         {
            UIManager.bestowFlower.show(this.data.id);
            UIManager.bestowFlower.visible = true;
            this.onTimerComplete(new TimerEvent("none"));
         }
      }
      
      private function swapHandler(evt:MouseEvent) : void
      {
         this.parent.setChildIndex(this,this.parent.numChildren - 1);
      }
      
      private function onClose(evt:MouseEvent) : void
      {
         if(Boolean(this.parent) && this.visible)
         {
            this.parent.removeChild(this);
            this.dispose();
         }
         else if(Boolean(this.parent))
         {
            this.dispose();
         }
      }
      
      private function onTimerComplete(evt:TimerEvent) : void
      {
         var p:Object = parent;
         var uiLayer:Sprite = GameScene.uiLayer;
         var b:Boolean = p == uiLayer;
         this.visible = false;
         this.dispose();
      }
      
      override public function resetPosition() : void
      {
         this.x = Global.stage.stageWidth / 2 - this.WIDTH / 2;
         this.y = Global.stage.stageHeight / 2 - this.HEIGHT / 2;
      }
      
      public function restart(_data:Object) : void
      {
         this.data = _data;
         var nameReplace:String = HtmlUtil.font(this.data.name,"#F4CD31");
         var numReplace:String = HtmlUtil.font(this.data.flowerNum,"#F4CD31");
         this.message = LangConfig.getWord("29261",2).replace("%name",nameReplace).replace("%num",numReplace);
         this.sender.htmlText = this.message;
         this.sender.x = this.WIDTH / 2 - this.sender.width / 2;
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this.timer.reset();
         this.timer.start();
         this.addEventListener(MouseEvent.CLICK,this.swapHandler);
      }
      
      public function dispose() : void
      {
         this.timer.stop();
         this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this.sender.text = "";
         this.data = null;
         Pool.saveObject(this);
         removeEventListener(MouseEvent.CLICK,this.swapHandler);
      }
   }
}

