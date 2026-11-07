package com.yiTian.view.modules.keJu
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_KeJu;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.shake.EffectShake;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_Poems extends Sprite
   {
      
      private static var _instance:View_Poems;
      
      private var startTime:Number;
      
      private var moveArr:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var mcArr:Vector.<Array> = new Vector.<Array>();
      
      private var bitmapArr:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var spriteArr:Vector.<Sprite> = new Vector.<Sprite>();
      
      private var isFirst:Boolean = true;
      
      public function View_Poems()
      {
         super();
      }
      
      public static function get instance() : View_Poems
      {
         if(!_instance)
         {
            _instance = new View_Poems();
         }
         return _instance;
      }
      
      public function init(id:int) : void
      {
         this.visible = true;
         if(!this.isFirst)
         {
            this.drawColor();
            return;
         }
         Model_KeJu.poemsID = id;
         if(!Global.KeJu_Imgsdm)
         {
            this.load();
         }
         else
         {
            this.sourceComplete();
         }
      }
      
      public function dispose() : void
      {
         var bmd:BitmapData = null;
         var bm1:Bitmap = null;
         var sprite:Sprite = null;
         var bm:Bitmap = null;
         if(Model_KeJu.poemsBMD.length == 0)
         {
            return;
         }
         for each(bmd in Model_KeJu.poemsBMD)
         {
            bmd.dispose();
            bmd = null;
         }
         Model_KeJu.poemsBMD.length = 0;
         this.mcArr.length = 0;
         for each(bm1 in this.moveArr)
         {
            bm1 = null;
         }
         this.moveArr.length = 0;
         Model_KeJu.poemsIndexArr.length = 0;
         if(this.bitmapArr.length == 0)
         {
            return;
         }
         for each(bm in this.bitmapArr)
         {
            sprite = bm.parent as Sprite;
            if(Boolean(bm) && Boolean(bm.parent))
            {
               sprite.removeChild(bm);
            }
            bm.bitmapData.dispose();
            bm = null;
            if(Boolean(sprite) && Boolean(sprite.parent))
            {
               this.removeChild(sprite);
            }
            sprite = null;
         }
         this.bitmapArr.length = 0;
         this.isFirst = true;
      }
      
      public function go(num:int, startPoint:Point) : void
      {
         var point:Point = null;
         var nowBitmap:Bitmap = null;
         if(num > Model_KeJu.poemsBMD.length)
         {
            return;
         }
         Model_KeJu.poemsIndexArr.push(num);
         point = GameScene.mainLayer.localToGlobal(startPoint);
         if(this.moveArr.length > 0)
         {
            nowBitmap = this.moveArr.pop();
         }
         else
         {
            nowBitmap = new Bitmap();
         }
         nowBitmap.bitmapData = Model_KeJu.poemsBMD[num - 1];
         var targetBitmap:Bitmap = this.bitmapArr[num - 1];
         this.mcArr.push([nowBitmap,targetBitmap]);
         addChild(nowBitmap);
         nowBitmap.transform.colorTransform = Enum_KeJu.COLOR_RED;
         nowBitmap.x = point.x - 20;
         nowBitmap.y = point.y - 20;
         this.startTime = getTimer();
         this.run();
      }
      
      private function run() : void
      {
         var arr:Array = this.mcArr[this.mcArr.length - 1];
         var nowBitmap:Bitmap = arr[0];
         var targetBitmap:Bitmap = arr[1];
         var sprite:Sprite = targetBitmap.parent as Sprite;
         Tween.to(nowBitmap,2000,{
            "x":[nowBitmap.x,sprite.x],
            "y":[nowBitmap.y,sprite.y]
         },this.runComFun,null,Tween.EASYINOUT);
      }
      
      private function runComFun() : void
      {
         var nowBitmap:Bitmap = null;
         var targetBitmap:Bitmap = null;
         if(this.mcArr.length == 0)
         {
            return;
         }
         var arr:Array = this.mcArr[0];
         nowBitmap = arr[0];
         targetBitmap = arr[1];
         var sprite:Sprite = targetBitmap.parent as Sprite;
         this.mcArr.shift();
         if(Boolean(nowBitmap.parent))
         {
            this.removeChild(nowBitmap);
         }
         nowBitmap.bitmapData = null;
         this.moveArr.push(nowBitmap);
         targetBitmap.transform.colorTransform = Enum_KeJu.COLOR_RED;
         sprite.filters = Util.glowBig000000;
         if(Model_KeJu.poemsIndexArr.length >= 20)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80033",8));
         }
         EffectShake.addShake(sprite,3,3,4,4);
      }
      
      private function show() : void
      {
         var offsetY:Number = NaN;
         var posY:Number = NaN;
         var bitmap:Bitmap = null;
         var rangX:int = 0;
         var rangY:int = 0;
         var oY:int = 0;
         var sprite:Sprite = null;
         var i:int = 0;
         offsetY = 200;
         posY = 24;
         i = 0;
         while(i < 20)
         {
            rangX = i / 10;
            rangY = i % 10;
            if(i >= 10)
            {
               oY = 50;
            }
            else
            {
               oY = 0;
            }
            if(rangY >= 5)
            {
               offsetY = 230;
            }
            else
            {
               offsetY = 200;
            }
            sprite = new Sprite();
            sprite.x = rangX * 24 + 280;
            sprite.y = rangY * posY + offsetY + oY;
            addChildAt(sprite,0);
            this.spriteArr.push(sprite);
            bitmap = new Bitmap();
            bitmap.bitmapData = Model_KeJu.poemsBMD[i];
            bitmap.transform.colorTransform = Enum_KeJu.COLORBLACK;
            sprite.addChild(bitmap);
            this.bitmapArr.push(bitmap);
            i++;
         }
         if(Model_KeJu.poemsIndexArr.length == 0)
         {
            return;
         }
         this.drawColor();
      }
      
      private function drawColor() : void
      {
         var bitmap:Bitmap = null;
         var sprite:Sprite = null;
         var i:int = 0;
         for each(i in Model_KeJu.poemsIndexArr)
         {
            bitmap = this.bitmapArr[i - 1];
            bitmap.transform.colorTransform = Enum_KeJu.COLOR_RED;
            sprite = bitmap.parent as Sprite;
            sprite.filters = Util.glowBig000000;
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_KeJu.KEJUSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         var bitmapData:BitmapData = null;
         var rangX:int = 0;
         var rangY:int = 0;
         if(Boolean(info))
         {
            Global.KeJu_Imgsdm = info.applicationDomain;
         }
         var bitmap:Bitmap = ComponentUtil.getBitmap("Poems_" + Model_KeJu.poemsID,null,null,Global.KeJu_Imgsdm);
         var i:int = 19;
         while(i >= 0)
         {
            rangX = i % 10;
            rangY = i / 10;
            bitmapData = new BitmapData(24,24);
            bitmapData.copyPixels(bitmap.bitmapData,new Rectangle(24 * rangX,24 * rangY,24,24),new Point(0,0));
            Model_KeJu.poemsBMD.unshift(bitmapData);
            i--;
         }
         var vec1:Vector.<BitmapData> = Model_KeJu.poemsBMD.slice(0,10);
         var vec2:Vector.<BitmapData> = Model_KeJu.poemsBMD.slice(10);
         Model_KeJu.poemsBMD = vec2.concat(vec1);
         this.isFirst = false;
         this.showBox();
         this.show();
      }
      
      public function showBox() : void
      {
         var num:int = 0;
         var npc:Npc = null;
         var i:int = 0;
         if(this.isFirst)
         {
            return;
         }
         i = i;
         while(i < 20)
         {
            num = 56957 + i;
            npc = Npc.getNpcBySysid(num);
            if(npc)
            {
               npc.setTitle(Model_KeJu.poemsBMD[i]);
            }
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.isFirst)
            {
               this.showBox();
            }
            GameScene.uiLayer.addChild(this);
         }
         else if(Boolean(this.parent))
         {
            GameScene.uiLayer.removeChild(this);
         }
      }
   }
}

