package com.yiTian.view
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.call.DelegateEvent;
   import com.yiTian.utils.call.IDelegate123Obj;
   import com.yiTian.view.modules.loading.View_loading;
   
   public class Panel123 extends Panel implements IDelegate123Obj
   {
      
      public static const SWF:int = 1;
      
      public static const BYTE:int = 2;
      
      public static const BYTE_DECODE:int = 3;
      
      protected var uiCfgs:Array;
      
      private var _srcArr:Array;
      
      private var _isRead:Boolean;
      
      public var ratio:int = 2;
      
      public var powerr:Number = 0.8;
      
      public function Panel123()
      {
         super();
      }
      
      public function preFun() : void
      {
         this.loadSrc();
      }
      
      protected function initUI2() : void
      {
         super.init();
      }
      
      private function loadSrc() : void
      {
         var srcName:String = null;
         var globolName:String = null;
         var type:int = 0;
         if(!this._srcArr)
         {
            return;
         }
         var len:int = int(this._srcArr.length);
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            srcName = this._srcArr[i];
            globolName = this._srcArr[i + 1];
            type = int(this._srcArr[i + 2]);
            if(globolName == "" || Global[globolName] == null)
            {
               arr.push([srcName,this.perComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL,globolName,type]);
            }
            i += 3;
         }
         View_loading.instance.load(arr,this.allComplete);
         View_loading.instance.visible = true;
      }
      
      private function perComplete(info:Object) : void
      {
         var gName:String = null;
         var type:int = int(info.obj[6]);
         if(type == 1)
         {
            gName = info.obj[5];
            Global[gName] = info.applicationDomain;
         }
         else if(type == 2)
         {
            this.uiCfgs = this.uiCfgs || [];
            this.uiCfgs.push(info.data);
         }
         else
         {
            Data_lib.init(info);
         }
      }
      
      private function allComplete(info:Object) : void
      {
         this._isRead = true;
         this.initUI2();
         dispatchEvent(new DelegateEvent(DelegateEvent.T_T_COMPLETE));
         this._srcArr.splice(0);
      }
      
      public function getCfg(cfgIndex:*) : *
      {
         return this.uiCfgs[cfgIndex];
      }
      
      protected function regResource(swfUrl:String, globalName:String, type:int = 1) : void
      {
         if(!this._srcArr)
         {
            this._srcArr = [];
         }
         this._srcArr.push(swfUrl,globalName,type);
      }
      
      public function get isReady() : Boolean
      {
         if(this._isRead == false)
         {
            this._isRead = this.checkSrcComplete();
         }
         return this._isRead;
      }
      
      private function checkSrcComplete() : Boolean
      {
         var swfUrl:String = null;
         var globalName:String = null;
         var type:int = 0;
         if(!this._srcArr)
         {
            return true;
         }
         var len:int = int(this._srcArr.length);
         var i:int = 0;
         while(i < len)
         {
            swfUrl = this._srcArr[i];
            globalName = this._srcArr[i + 1];
            type = int(this._srcArr[i + 2]);
            if(type != SWF || Global[globalName] == null)
            {
               return false;
            }
            i += 3;
         }
         this.initUI2();
         return true;
      }
      
      public function pop(sX:Number = 0.5, sY:Number = 0.5, pX:Number = 0.5, pY:Number = 0.5, starScale:Number = 0.3, endScale:Number = 1, duration:int = 400, endFun:Function = null) : void
      {
         var y1:Number = NaN;
         var x2:Number = NaN;
         var y2:Number = NaN;
         var x1:Number = (Global.stage.stageWidth - width * starScale) * sX;
         y1 = (Global.stage.stageHeight - height * starScale) * sY;
         x2 = (Global.stage.stageWidth - width * endScale) * pX;
         y2 = (Global.stage.stageHeight - height * endScale) * pY;
         scaleX = scaleY = starScale;
         x = x1;
         y = y1;
         Tween.curTo(this,duration,{
            "x":x2,
            "y":y2,
            "scaleX":endScale,
            "scaleY":endScale
         },null,endFun,this.tFun);
      }
      
      private function tFun(p:Number) : Number
      {
         var rate:Number = p * 3.1416 * this.ratio;
         return Math.pow(1 - Math.sin(rate) / rate,this.powerr);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

