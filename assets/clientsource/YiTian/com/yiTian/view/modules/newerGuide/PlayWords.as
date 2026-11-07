package com.yiTian.view.modules.newerGuide
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class PlayWords extends Sprite
   {
      
      private static var _instance:PlayWords;
      
      public static var bmpVec:Vector.<Bitmap> = new Vector.<Bitmap>(14);
      
      public static var isInit:Boolean = false;
      
      private static var count:int = 0;
      
      private static var isFinishAllSourceLoad:Boolean = false;
      
      public function PlayWords()
      {
         super();
         GameScene.upUILayer.addChild(this);
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resposition);
      }
      
      public static function get instance() : PlayWords
      {
         if(!_instance)
         {
            _instance = new PlayWords();
         }
         return _instance;
      }
      
      public function init() : void
      {
         var i:int = 0;
         var b:Bitmap = null;
         if(isInit)
         {
            return;
         }
         i = 0;
         while(i < bmpVec.length)
         {
            b = new Bitmap();
            b.visible = false;
            b = Utils.getLoadBitmap("resource/image/newerGuideWords/words_" + (i + 1) + ".png",b,{
               "x":60 - 60 * int(i / 7),
               "y":int(i / 7) * 40 + 58 * int(i % 7)
            },this.comp);
            addChild(b);
            bmpVec[i] = b;
            i++;
         }
      }
      
      private function comp() : void
      {
         ++count;
         if(count >= bmpVec.length)
         {
            isInit = true;
            count = 0;
            this.playEff(0);
         }
      }
      
      public function playEff(_index:int) : void
      {
         var b:Bitmap = null;
         var _temp:int = 0;
         var nn:int = 0;
         var n:int = 0;
         if(!isInit)
         {
            this.init();
            return;
         }
         if(_index >= bmpVec.length)
         {
            n = int(setTimeout(function():void
            {
               hide();
            },3200));
            return;
         }
         if(!visible)
         {
            visible = true;
         }
         b = bmpVec[_index];
         b.visible = true;
         Tween.to(b,500,{"alpha":[0.1,0.9]});
         _temp = _index + 1;
         nn = int(setTimeout(function():void
         {
            playEff(_temp);
            clearTimeout(nn);
         },300));
      }
      
      private function hide() : void
      {
         Tween.to(this,1200,{"alpha":[1,0]},function(ss:Sprite):void
         {
            ss.visible = false;
         });
      }
      
      public function resposition() : void
      {
         x = (Global.stage.stageWidth - 100) / 2 + 300;
         y = (Global.stage.stageHeight - 300) / 2 - 150;
      }
   }
}

