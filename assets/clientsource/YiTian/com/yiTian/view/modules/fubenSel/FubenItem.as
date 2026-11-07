package com.yiTian.view.modules.fubenSel
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.WorldConfig;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   
   public class FubenItem extends Sprite
   {
      
      private static var FIRST_TIME:ColorTransform = new ColorTransform(1,1,1,0.25,0,0,0,0);
      
      private static var HAS_FINISH:ColorTransform = new ColorTransform(1,1,1,0.35,-179,-65,-191,0);
      
      private static var DISABLED:ColorTransform = new ColorTransform(1,1,1,0.5,-255,-255,-255,0);
      
      private static var pool:Array = [];
      
      private var _fubenId:int;
      
      private var _condition:Array;
      
      private var back_bitmap:Bitmap = new Bitmap();
      
      private var lock_bitmap:Bitmap = new Bitmap();
      
      private var bitmap:Bitmap;
      
      private var saoDangBtn:Button;
      
      private var backBmp:Bitmap = new Bitmap();
      
      private var backB:Bitmap;
      
      private var _pointId:int;
      
      private var buttonOver:Boolean;
      
      private var monsterArr:Array;
      
      private var overBMP:Bitmap = new Bitmap();
      
      public function FubenItem()
      {
         super();
         this.bitmap = new Bitmap();
         addChild(this.bitmap);
         addEventListener(MouseEvent.CLICK,this.selFuben);
         this.saoDangBtn = ComponentUtil.getButton(LangConfig.getWord("10606",1),"Button_QJ",this,{
            "x":4,
            "y":84,
            "textColor":16184781
         },Global.New_Imgsdm);
         this.saoDangBtn.visible = false;
         this.saoDangBtn.addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
         this.saoDangBtn.addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
      }
      
      public static function getItem() : FubenItem
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new FubenItem();
      }
      
      public function set fubenId(id:int) : void
      {
         this._fubenId = id;
         MassLoader.add("resource/image/fuben/" + id + ".png",function(info:Object):void
         {
            info.obj.bitmapData = (info.content as Bitmap).bitmapData;
         },null,MassLoader.LEVEL1,this.bitmap);
         if(!Global.Map_Imgsdm)
         {
            SingleLoader.add("lang/ch/Map_Imgs.swf",function(info:Object):void
            {
               Global.Map_Imgsdm = info.applicationDomain;
               addBmp();
            });
         }
         else
         {
            this.addBmp();
         }
      }
      
      private function addBmp() : void
      {
         this.backB = ComponentUtil.getBitmap("Ring",this,{
            "x":0,
            "y":0
         },Global.Map_Imgsdm);
         setChildIndex(this.backB,0);
      }
      
      public function set pointId(_value:int) : void
      {
         this._pointId = _value;
      }
      
      public function get pointId() : int
      {
         return this._pointId;
      }
      
      public function get fubenId() : int
      {
         return this._fubenId;
      }
      
      private function getLock(value:Boolean) : void
      {
         this.bitmap.visible = value;
         if(!value)
         {
            MassLoader.add("resource/image/fuben/Locked.png",function(info:Object):void
            {
               info.obj.bitmapData = (info.content as Bitmap).bitmapData;
            },null,MassLoader.LEVEL1,this.lock_bitmap);
            addChild(this.lock_bitmap);
         }
         else if(Boolean(this.lock_bitmap))
         {
            this.lock_bitmap.bitmapData = null;
         }
      }
      
      public function set saoDangEnabled(value:Boolean) : void
      {
         var arr:Array = null;
         this.saoDangBtn.visible = value;
         arr = this.condition[0].split("_");
         if(this.saoDangBtn.hasEventListener(MouseEvent.CLICK))
         {
            this.saoDangBtn.removeEventListener(MouseEvent.CLICK,this.saoDangHandle);
         }
         if(this.saoDangBtn.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            this.saoDangBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.saoDangHandle);
         }
         if(value)
         {
            MassLoader.add("resource/image/fuben/Button_QJ_background.png",function(info:Object):void
            {
               info.obj.bitmapData = (info.content as Bitmap).bitmapData;
            },null,MassLoader.LEVEL1,this.backBmp);
            addChildAt(this.backBmp,1);
            this.backBmp.x = 22;
            this.backBmp.y = 102;
            this.saoDangBtn.addEventListener(MouseEvent.CLICK,this.saoDangHandle);
            if(int(arr[1]) < 30)
            {
               this.saoDangBtn.visible = false;
               this.backBmp.visible = false;
            }
         }
      }
      
      private function overHandle(e:MouseEvent) : void
      {
         this.buttonOver = true;
         this.overBMP.visible = false;
         e.stopPropagation();
      }
      
      private function outHandle(e:MouseEvent) : void
      {
         this.overBMP.visible = true;
         this.buttonOver = false;
      }
      
      private function saoDangHandle(e:MouseEvent) : void
      {
         UIManager.saoDangFuben.pointId = this._pointId;
         UIManager.saoDangFuben.fubenId = this.fubenId;
         var arr:Array = WorldConfig.getMapMonster(this._fubenId);
         UIManager.saoDangFuben.monsterArr = arr;
         UIManager.saoDangFuben.monsterLvlArr = this.condition;
         UIManager.saoDangFuben.visible = !UIManager.saoDangFuben.visible;
         e.stopPropagation();
      }
      
      public function set condition(value:Array) : void
      {
         var minusValue:int = 0;
         this.monsterArr = value;
         if(!MapManager.fubenInfo[Global.sceneID])
         {
            if(this._fubenId.toString().substr(3,2) == "02")
            {
               if(this.checkLevel(value))
               {
                  this.enabled = true;
                  this.saoDangEnabled = false;
               }
               else
               {
                  this.enabled = false;
                  this.saoDangEnabled = false;
               }
            }
            else
            {
               this.saoDangEnabled = false;
               this.enabled = false;
            }
         }
         else
         {
            minusValue = this._fubenId - MapManager.fubenInfo[Global.sceneID];
            if(minusValue > 1)
            {
               this.enabled = false;
               this.saoDangEnabled = false;
            }
            else if(minusValue == 1)
            {
               if(this.checkLevel(value))
               {
                  this.enabled = true;
                  this.saoDangEnabled = false;
               }
               else
               {
                  this.enabled = false;
                  this.saoDangEnabled = false;
               }
            }
            else
            {
               this.enabled = true;
               this.saoDangEnabled = true;
            }
         }
      }
      
      public function get condition() : Array
      {
         return this.monsterArr;
      }
      
      private function checkLevel(value:Array) : Boolean
      {
         var fubenData:Array = null;
         var len:int = int(value.length);
         var i:int = 0;
         while(i < len)
         {
            if(Boolean(value[i]))
            {
               fubenData = value[i].split("_");
               if(fubenData[0] == 1)
               {
                  if(GameUnitManager.hero.level >= fubenData[1])
                  {
                     return true;
                  }
                  return false;
               }
            }
            i++;
         }
         return true;
      }
      
      public function mouseOver(e:MouseEvent) : void
      {
         MassLoader.add("resource/image/fuben/Fuben_Select.png",function(info:Object):void
         {
            info.obj.bitmapData = (info.content as Bitmap).bitmapData;
         },null,MassLoader.LEVEL1,this.overBMP);
         addChild(this.overBMP);
         this.overBMP.x = -6;
         this.overBMP.y = 6;
      }
      
      public function mouseOut(e:MouseEvent) : void
      {
         if(Boolean(this.overBMP.bitmapData))
         {
            this.overBMP.bitmapData.dispose();
         }
      }
      
      public function set enabled(value:Boolean) : void
      {
         this.getLock(value);
         if(value)
         {
            if(!hasEventListener(MouseEvent.ROLL_OVER))
            {
               addEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
            }
            if(!hasEventListener(MouseEvent.ROLL_OUT))
            {
               addEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
            }
            buttonMode = true;
            mouseChildren = mouseEnabled = true;
         }
         else
         {
            buttonMode = false;
            if(hasEventListener(MouseEvent.ROLL_OVER))
            {
               removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
            }
            if(hasEventListener(MouseEvent.ROLL_OUT))
            {
               removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
            }
            mouseChildren = mouseEnabled = false;
         }
      }
      
      private function selFuben(e:MouseEvent) : void
      {
         if(!View_fuBenSaodanging.isQingJiao)
         {
            if(GameUnitManager.hero.captainId == 0 || GameUnitManager.hero.teamPosition == 0)
            {
               SceneCGMessage.CG_ENTER_FUBEN(this._fubenId);
               UIManager.fubenSelPanel.visible = false;
            }
         }
      }
      
      public function dispose() : void
      {
         if(Boolean(this.bitmap.bitmapData))
         {
            this.bitmap.bitmapData.dispose();
         }
         if(Boolean(this.backBmp.bitmapData))
         {
            this.backBmp.bitmapData.dispose();
         }
         if(Boolean(this.lock_bitmap.bitmapData))
         {
            this.lock_bitmap.bitmapData.dispose();
         }
         if(hasEventListener(MouseEvent.ROLL_OVER))
         {
            removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
         }
         if(hasEventListener(MouseEvent.ROLL_OUT))
         {
            removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
         }
         pool.push(this);
      }
   }
}

