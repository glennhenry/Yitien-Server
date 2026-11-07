package com.yiTian.view.modules.pet
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.MassLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class PanelModel extends Sprite
   {
      
      private const INTERVAL_FRAM:int = 5;
      
      private const DIRECTION:int = 4;
      
      private var imgBM:Bitmap;
      
      private var totalFram:int;
      
      private var imgList:Vector.<BitmapData>;
      
      private var playIndex:int = 0;
      
      private var _info:Object;
      
      private var qiXueBG:Bitmap;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _modelID:int;
      
      public function PanelModel(__x:Number = 0, __y:Number = 0)
      {
         super();
         this._x = __x;
         this._y = __y;
      }
      
      private function onComplete(info:Object) : void
      {
         var c:Class = null;
         var d:BitmapData = null;
         if(!this.imgBM)
         {
            this.imgBM = new Bitmap();
            addChild(this.imgBM);
         }
         this._info = info;
         this._info.content.init();
         this.imgList = new Vector.<BitmapData>(this.INTERVAL_FRAM * this._info.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         while(i < this.INTERVAL_FRAM * this._info.content.actionFrame)
         {
            if(i % this.INTERVAL_FRAM == 0)
            {
               c = info.applicationDomain.getDefinition("_" + (this.DIRECTION * this._info.content.actionFrame + j++)) as Class;
               d = new c();
               this.imgList[i] = d;
            }
            i++;
         }
         GameScene.instance.addFrameCallBack(this.go);
      }
      
      public function stop() : void
      {
         GameScene.instance.removeFrameCallBack(this.go);
      }
      
      public function play(modelID:int) : void
      {
         if(Global.pf == Enum_SPStr.CHITU && modelID == 20907)
         {
            modelID = 20901;
         }
         else if((Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366) && modelID == 20901)
         {
            modelID = 20907;
         }
         this._modelID = modelID;
         this.playImg();
      }
      
      private function go(interval:int) : void
      {
         if(this.playIndex < this.imgList.length)
         {
            if(this.imgList[this.playIndex] != null)
            {
               this.imgBM.x = this._x + this._info.content.rect[this._info.content.actionFrame * this.DIRECTION + this.playIndex / this.INTERVAL_FRAM][0];
               this.imgBM.y = this._y + this._info.content.rect[this._info.content.actionFrame * this.DIRECTION + this.playIndex / this.INTERVAL_FRAM][1];
               this.imgBM.bitmapData = this.imgList[this.playIndex];
            }
            ++this.playIndex;
         }
         else
         {
            this.playIndex = 0;
         }
      }
      
      private function playImg() : void
      {
         MassLoader.add("modelRes/role/body/run/" + this._modelID + ".swf",this.onComplete,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
   }
}

