package com.yiTian.view.modules.roleHead
{
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class BuffterView extends Sprite
   {
      
      public static const WIDTH:int = 16;
      
      public static const HEIGHT:int = 16;
      
      private var bm:Bitmap;
      
      private var back:Shape;
      
      private var isOn:Boolean;
      
      private var _vo:Vo_Buffer;
      
      private var lastTime:int;
      
      public function BuffterView()
      {
         super();
         this.bm = new Bitmap();
         addChild(this.bm);
         this.back = this.getShape();
         addChild(this.back);
      }
      
      private function getShape() : Shape
      {
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,WIDTH,HEIGHT);
         return shape;
      }
      
      public function get vo() : Vo_Buffer
      {
         return this._vo;
      }
      
      public function set vo(value:Vo_Buffer) : void
      {
         this._vo = value;
         if(!this.bm)
         {
            this.bm = new Bitmap();
            addChild(this.bm);
         }
         Utils.getLoadBitmap(Const_strImg.getBuffUrl(this._vo.icon.toString()),this.bm);
         if(!this.back)
         {
            this.back = this.getShape();
            addChild(this.back);
         }
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this.addEventListener(MouseEvent.MOUSE_MOVE,this.onMove);
      }
      
      protected function onOver(event:MouseEvent) : void
      {
         GameScene.instance.addFrameCallBack(this.countDown);
      }
      
      protected function onMove(event:MouseEvent) : void
      {
         this.bind();
      }
      
      protected function onOut(event:MouseEvent) : void
      {
         if(GameScene.instance.hasFrameCallBack(this.countDown))
         {
            GameScene.instance.removeFrameCallBack(this.countDown);
         }
         TipManager.hide();
      }
      
      private function bind() : void
      {
         var time:Number = NaN;
         var ms:int = 0;
         var ss:int = 0;
         var mm:int = 0;
         var hh:int = 0;
         var dd:int = 0;
         if(this._vo.last_time > 0)
         {
            time = this._vo.remainValue * 1000 - (getTimer() - this._vo.updateTime);
            time = time < 0 ? 0 : time;
            ms = int(time % 1000);
            time /= 1000;
            ss = int(time % 60);
            time /= 60;
            mm = int(time % 60);
            time /= 60;
            hh = int(time % 24);
            time /= 24;
            dd = time;
            TipManager.update(this._vo.name + LangConfig.getWord("10448",1) + (Boolean(dd) ? dd + LangConfig.getWord("10449",1) : "") + (Boolean(hh) ? hh + LangConfig.getWord("10450",1) : "") + (Boolean(mm) ? mm + LangConfig.getWord("10451",1) : "") + ss + LangConfig.getWord("10452",1) + this._vo.discript);
         }
         else if(this._vo.type == 4)
         {
            TipManager.update(this._vo.name + "<br>" + this._vo.discript);
         }
         else if(this._vo.type == 2)
         {
            TipManager.update(this._vo.name + "<br>" + (this._vo.categories == 2 ? LangConfig.getWord("10453",1) : LangConfig.getWord("10454",1)) + "：" + this._vo.remainValue + "<br>" + this._vo.discript);
         }
         else if(this._vo.type == 5)
         {
            TipManager.update(this._vo.name + "<br>" + LangConfig.getWord("10455",1) + this._vo.remainValue + "%");
         }
      }
      
      private function countDown(interval:int) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime >= 1000)
         {
            this.bind();
            this.lastTime = now;
         }
      }
      
      public function dispose() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMove);
         if(GameScene.instance.hasFrameCallBack(this.countDown))
         {
            GameScene.instance.removeFrameCallBack(this.countDown);
         }
         if(Boolean(this.bm))
         {
            removeChild(this.bm);
         }
         this.bm = null;
         if(Boolean(this.back))
         {
            removeChild(this.back);
         }
         this.back = null;
         this._vo = null;
      }
   }
}

