package com.yiTian.view.modules.tianmingjj
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_TianmingJJ;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TianmingJJCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class Child_TMSZContiner extends Sprite
   {
      
      private static const MAX:int = 6;
      
      public static const PLAY_END:String = "playend";
      
      public static const PLAY_START:String = "playstart";
      
      private static const MAXW:int = 420;
      
      private static const MAXH:int = 265;
      
      public var side_diceVec:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      private var front_diceVec:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      private var shaiziVec:Vector.<NSprite> = new Vector.<NSprite>();
      
      private var timeFlag:int;
      
      private var runTime:int;
      
      private var MAXSPEED:Number = 4;
      
      private var __xFlag:int = 1;
      
      private var __yFlag:int = 1;
      
      private var changeTime:int;
      
      private var _add:int = 1;
      
      public function Child_TMSZContiner()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         var b:NSprite = null;
         var k:int = 0;
         var s:Shape = new Shape();
         s.graphics.beginFill(16711680,0);
         s.graphics.drawRect(40,50,MAXW,MAXH);
         s.graphics.endFill();
         this.addChild(s);
         var i:int = 0;
         while(i < MAX)
         {
            this.side_diceVec.push(ComponentUtil.getBitmapData("X" + (i + 1),Global.TianMingdm));
            this.front_diceVec.push(ComponentUtil.getBitmapData("S0" + (i + 1),Global.TianMingdm));
            i++;
         }
         k = 0;
         while(k < MAX)
         {
            b = new NSprite();
            b.bitmapData = this.front_diceVec[5];
            b.x = k % 3 * 70 + 100 + int(k / 3) * 80;
            b.y = int(k / 3) * 50 + 160;
            this.addChild(b);
            this.shaiziVec.push(b);
            k++;
         }
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onRoll);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onUp);
      }
      
      public function resetPos() : void
      {
         this.MAXSPEED = 4;
      }
      
      public function play() : void
      {
         var i:int;
         var b:NSprite = null;
         var resultPos:Array = null;
         var onDo:Function = function(i:int):void
         {
            var p:Point = null;
            var flag:int = 0;
            b = shaiziVec[i];
            p = resultPos[i];
            Tween.to(b,1100,{
               "x":[b.x,p.x - Math.random() * 30 * (Math.random() * 2 - 1 > 0 ? 1 : -1)],
               "y":[b.y,p.y - Math.random() * 90 * (Math.random() * 2 - 1 > 0 ? 1 : -1)]
            },function(b:NSprite):void
            {
               Tween.to(b,900,{
                  "x":[b.x,p.x],
                  "y":[b.y,p.y]
               });
            });
         };
         this.timeFlag = getTimer();
         this.changeTime = getTimer();
         if(!GameScene.instance.hasFrameCallBack(this.execute))
         {
            GameScene.instance.addFrameCallBack(this.execute);
         }
         resultPos = this.getEndPosList();
         i = 0;
         while(i < MAX)
         {
            onDo(i);
            i++;
         }
      }
      
      private function getEndPosList() : Array
      {
         var len:int = 0;
         var p1:Point = null;
         var p:Point = null;
         var arr:Array = [];
         arr.push(new Point(90 + Math.random() * 44,190 + Math.random() * 66));
         var index:Array = [0,0,1,1,3];
         while(arr.length < 6)
         {
            len = int(arr.length);
            p = arr[index[arr.length - 1]];
            p1 = new Point();
            p1.x = p.x + 60 + Math.random() * 4;
            p1.y = arr[0].y + 70 * (0 - len % 2) + Math.random() * 15;
            arr.push(p1);
         }
         arr[0].y -= 50;
         arr[5].y += 50;
         return arr;
      }
      
      private function execute() : void
      {
         var remd:int = 0;
         var b:NSprite = null;
         var isChange:Boolean = false;
         this.runTime = getTimer();
         if(this.runTime - this.timeFlag > 2000 && this.timeFlag != 0)
         {
            this.end();
            return;
         }
         if(int(this.runTime - this.timeFlag) >= this._add * 200)
         {
            this.MAXSPEED -= 0.5;
            if(this.MAXSPEED <= 0)
            {
               this.MAXSPEED == 0.2;
            }
            ++this._add;
         }
         if(getTimer() - this.changeTime > this.runTime / this.timeFlag * 30)
         {
            this.changeTime = getTimer();
            isChange = true;
         }
         var i:int = 0;
         while(i < MAX)
         {
            remd = Math.random() * MAX;
            b = this.shaiziVec[i];
            if(isChange)
            {
               b.bitmapData = this.side_diceVec[remd];
            }
            i++;
         }
      }
      
      private function end() : void
      {
         var b:NSprite = null;
         GameScene.instance.removeFrameCallBack(this.execute);
         this.timeFlag = 0;
         this.changeTime = 0;
         this.runTime = 0;
         var i:int = 0;
         while(i < MAX)
         {
            b = this.shaiziVec[i];
            b.bitmapData = this.front_diceVec[Model_TianmingJJ.vec[i].value - 1];
            i++;
         }
         setTimeout(Global.control.sendNotification,800,PLAY_END,null);
      }
      
      private function onRoll(evt:MouseEvent) : void
      {
         TianMingJJCursorManager.show("Icon_ZhuaShou",Global.TianMingdm);
      }
      
      private function onUp(evt:MouseEvent) : void
      {
         evt.stopImmediatePropagation();
         TianMingJJCursorManager.show("Icon_ZhuaShou",Global.TianMingdm);
         var counts:int = CommandManager.get_bag_count(Model_TianmingJJ.TOOLID);
         if(counts <= 0)
         {
            UIManager.centerBroadcast.addMsg("天命石不足！");
            return;
         }
         if(Model_TianmingJJ.isEffect)
         {
            return;
         }
         if(Model_TianmingJJ.startPlay)
         {
            return;
         }
         Model_TianmingJJ.startPlay = true;
         var gid:int = CommandManager.getGridIdById(Model_TianmingJJ.TOOLID);
         TianmingJJCGMessage.CG_TMJJ_TZ(gid);
      }
      
      private function onDown(evt:MouseEvent) : void
      {
         TianMingJJCursorManager.show("Icon_QuanTou",Global.TianMingdm);
      }
      
      private function onOut(evt:MouseEvent) : void
      {
         TianMingJJCursorManager.hide();
      }
      
      public function effect() : void
      {
         var eff:Effect = null;
         var p:Point = null;
         var p1:Point = View_TianmingJJ.instance.localToGlobal(new Point(View_TianmingJJ.instance.tmd.x,View_TianmingJJ.instance.tmd.y));
         var i:int = 0;
         while(i < 6)
         {
            eff = EffectManager.addEffect("35040",GameScene.upUILayer,1500,11,11);
            p = this.localToGlobal(new Point(this.shaiziVec[i].x,this.shaiziVec[i].y - 15));
            Tween.to(eff,1500,{
               "y":[p.y,p1.y],
               "x":[p.x,p1.x]
            },function(eff:Effect):void
            {
               if(Boolean(eff))
               {
                  EffectManager.removeEffect(eff);
               }
            });
            i++;
         }
      }
   }
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class NSprite extends Sprite
{
   
   private var b:Bitmap;
   
   public function NSprite()
   {
      super();
      this.b = new Bitmap();
      this.addChild(this.b);
   }
   
   public function set bitmapData(bmd:BitmapData) : void
   {
      this.b.bitmapData = bmd;
   }
}
