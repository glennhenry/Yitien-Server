package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.effects.CoolDown;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class Child_ClanBattleBuffItem extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var titleBm:Bitmap;
      
      private var bm:Bitmap;
      
      public var vo:Vo_Buffer;
      
      private var lastTime:int;
      
      private var time:Number;
      
      private var isOver:Boolean;
      
      private var curCDSp:CoolDown;
      
      private var txtTime:MyTextField;
      
      public function Child_ClanBattleBuffItem()
      {
         super();
         this.bm = new Bitmap();
         addChild(this.bm);
         this.curCDSp = new CoolDown(50);
         this.curCDSp.color = 10066329;
         this.curCDSp.x = this.bm.x - 1;
         this.curCDSp.y = this.bm.y - 1;
         var _temp_1:* = this.curCDSp;
         this.curCDSp.mouseChildren = false;
         _temp_1.mouseEnabled = false;
         addChild(this.curCDSp);
         this.curCDSp.alpha = 0.3;
         this.curCDSp.percent = 1;
         this.txtTime = ComponentUtil.getTextField("",this,{
            "x":8,
            "y":16,
            "color":13827072,
            "size":18,
            "leading":0
         });
         this.txtTime.mouseEnabled = true;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
      }
      
      public static function getItem() : Child_ClanBattleBuffItem
      {
         return Boolean(pool.length) ? pool.pop() : new Child_ClanBattleBuffItem();
      }
      
      public function set data(value:Vo_Buffer) : void
      {
         this.vo = value;
         this.time = this.vo.remainValue * 1000;
         Utils.getLoadBitmap(Const_strImg.getBuffUrl(value.icon.toString()),this.bm);
      }
      
      public function start() : void
      {
         if(!GameScene.instance.hasFrameCallBack(this.countDown))
         {
            GameScene.instance.addFrameCallBack(this.countDown);
         }
      }
      
      protected function onOver(event:MouseEvent) : void
      {
         this.start();
         this.isOver = true;
      }
      
      protected function onOut(event:MouseEvent) : void
      {
         TipManager.hide();
         this.isOver = false;
      }
      
      private function bind() : void
      {
         this.time = this.time < 0 ? 0 : this.time;
         var ms:int = int(this.time % 1000);
         this.time /= 1000;
         var ss:int = int(this.time % 60);
         this.time /= 60;
         var mm:int = int(this.time % 60);
         this.time /= 60;
         var hh:int = int(this.time % 24);
         this.time /= 24;
         var dd:int = this.time;
         TipManager.update(this.vo.name + LangConfig.getWord("10448",1) + (Boolean(dd) ? dd + LangConfig.getWord("10449",1) : "") + (Boolean(hh) ? hh + LangConfig.getWord("10450",1) : "") + (Boolean(mm) ? mm + LangConfig.getWord("10451",1) : "") + ss + LangConfig.getWord("10452",1) + this.vo.discript);
      }
      
      private function countDown(interval:int) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime >= 1000)
         {
            if(this.vo.last_time > 0)
            {
               this.time = this.vo.remainValue * 1000;
               if(this.isOver == true)
               {
                  this.bind();
               }
            }
            if(this.time > 0)
            {
               this.curCDSp.percent = 1 - this.vo.remainValue / this.vo.last_time;
               this.enable = false;
               this.txtTime.text = this.vo.remainValue + "";
               this.txtTime.x = 24 - this.txtTime.textWidth / 2;
            }
            else
            {
               if(GameScene.instance.hasFrameCallBack(this.countDown))
               {
                  GameScene.instance.removeFrameCallBack(this.countDown);
               }
               this.enable = true;
               this.curCDSp.percent = 1;
               this.txtTime.text = "";
            }
            --this.vo.remainValue;
            this.lastTime = now;
         }
      }
      
      public function set enable(value:Boolean) : void
      {
         if(value)
         {
            if(!this.hasEventListener(MouseEvent.CLICK))
            {
               this.addEventListener(MouseEvent.CLICK,this.onBuy);
            }
            this.buttonMode = true;
         }
         else
         {
            if(this.hasEventListener(MouseEvent.CLICK))
            {
               this.removeEventListener(MouseEvent.CLICK,this.onBuy);
            }
            this.buttonMode = false;
         }
      }
      
      private function onBuy(e:MouseEvent) : void
      {
         CrossClanBattleCGMessage.CG_BUY_BUFF(this.vo.id);
      }
      
      public function dispose() : void
      {
         pool.push(this);
      }
   }
}

