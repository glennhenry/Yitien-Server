package com.yiTian.view.modules.weilie
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_WeiLie;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class Child_Shoter extends Sprite
   {
      
      public var action1:Array = ["_11","_22","_33"];
      
      public var action2:Array = ["_1","_2","_3","_4","_5"];
      
      private var currentFrame:int;
      
      private var frameRate:int;
      
      private var now:int;
      
      private var lastTime:int;
      
      private var _way:int;
      
      private var lastWay:int;
      
      public var startPos:Point;
      
      public var endPos:Point;
      
      public var callBack:Function;
      
      private var eff:Effect;
      
      private var bm:Bitmap;
      
      private var _title:String;
      
      public function Child_Shoter()
      {
         super();
         this.bm = new Bitmap();
         this.addChild(this.bm);
      }
      
      public function set way(value:int) : void
      {
         this._way = value;
         switch(this._way)
         {
            case View_WeiLie.STAND:
               this.frameRate = 500;
               break;
            case View_WeiLie.SHOT:
               this.frameRate = 100;
         }
         this.makelove();
      }
      
      private function makelove() : void
      {
         var temp:Array = null;
         var t1:int = 0;
         var t2:int = 0;
         var t3:int = 0;
         var t4:int = 0;
         var t5:int = 0;
         var rate:Number = NaN;
         if(this.lastWay != this._way || this.currentFrame >= this["action" + this._way].length)
         {
            this.currentFrame = 0;
         }
         this.now = getTimer();
         if(this.currentFrame != 0 && this.now - this.lastTime < this.frameRate)
         {
            return;
         }
         this.lastTime = getTimer();
         this.lastWay = this._way;
         this.bm.bitmapData = null;
         this.bm.bitmapData = ComponentUtil.getBitmapData(this["action" + this._way][this.currentFrame],Global.QXWLdm);
         ++this.currentFrame;
         if(this._way == View_WeiLie.SHOT && this.currentFrame >= this["action" + this._way].length)
         {
            this.way = View_WeiLie.STAND;
            temp = Model_WeiLie.anglePos[Model_WeiLie.ins(this._title).index];
            t1 = this.startPos.x + temp[1];
            t2 = this.endPos.x + temp[3];
            t3 = this.startPos.y + temp[2];
            t4 = this.endPos.y + temp[4];
            t5 = int(temp[5]);
            Model_WeiLie.ins(this._title).view.jiantou.rotation = temp[0];
            Model_WeiLie.ins(this._title).view.jiantou.times = t5;
            Model_WeiLie.ins(this._title).view.jiantou.visible = true;
            Tween.to(Model_WeiLie.ins(this._title).view.jiantou,t5,{
               "x":[t1,t2],
               "y":[t3,t4]
            },this.callBack);
         }
      }
      
      public function show() : void
      {
         this.way = View_WeiLie.STAND;
         GameScene.instance.addFrameCallBack(this.makelove);
      }
      
      public function dispose() : void
      {
         GameScene.instance.removeFrameCallBack(this.makelove);
      }
      
      public function set title(value:String) : void
      {
         this._title = value;
      }
   }
}

