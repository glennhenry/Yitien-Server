package com.yiTian.view.modules.tianTi
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Tween;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class Child_xinFaCJH extends Sprite
   {
      
      private static var counter:int;
      
      private static const OFFSET:Number = 50;
      
      private static const ITEMNUM:int = 2;
      
      public static var tt1:int = 0;
      
      private var vec:Vector.<Child_xinFaSB>;
      
      private var container:Sprite;
      
      private var _mask:Shape;
      
      public function Child_xinFaCJH()
      {
         super();
         this.container = new Sprite();
         addChild(this.container);
         this._mask = new Shape();
         this._mask.graphics.beginFill(255,0.3);
         this._mask.graphics.drawRect(0,0,40,40);
         this._mask.graphics.endFill();
         addChild(this._mask);
         this._mask.x = 5;
         this._mask.y = 4;
         mask = this._mask;
      }
      
      public function init() : void
      {
         var i:int = 0;
         var a:Child_xinFaSB = null;
         this.vec = new Vector.<Child_xinFaSB>();
         i = 0;
         while(i < ITEMNUM)
         {
            a = new Child_xinFaSB();
            a.type = 1 + int(Math.random() * 5);
            a.x = 3;
            this.vec.push(a);
            this.container.addChild(a);
            a.y = OFFSET * i + 3;
            i += 1;
         }
      }
      
      public function start(dis:uint, results:Array, nxtInfos:Array, base:int, acc:int) : void
      {
         var d:uint = 0;
         var index:int = 0;
         var total:Number = NaN;
         var startNum:Number = NaN;
         var temp:Number = NaN;
         var rnd:int = 0;
         counter = 0;
         rnd = base + tt1;
         tt1 += acc;
         d = dis;
         var offset:Number = rnd * 50;
         index = 1;
         total = 0;
         temp = startNum = this.container.y;
         var timeCost:int = rnd * 200;
         Tween.to(this.container,timeCost,{"y":[this.container.y,this.container.y - offset]},function onC():void
         {
            counter += 1;
            if(counter >= 5)
            {
               UIManager.xinFaPanel.cjEnd(results,nxtInfos);
               counter = 0;
            }
         },function():void
         {
            total = startNum - container.y;
            while(index <= total / 50)
            {
               index += 1;
               vec[0].y = vec[vec.length - 1].y + 50;
               vec.push(vec.shift());
               if(index == rnd)
               {
                  vec[1].type = d;
               }
               else
               {
                  vec[1].type = 1 + Math.random() * 5;
               }
            }
         },Tween.EASYINOUT);
      }
   }
}

