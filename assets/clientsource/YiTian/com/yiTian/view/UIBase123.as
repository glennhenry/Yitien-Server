package com.yiTian.view
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.call.DelegateEvent;
   import com.yiTian.utils.call.IDelegate123Obj;
   import com.yiTian.view.modules.loading.View_loading;
   
   public class UIBase123 extends UIBase implements IDelegate123Obj
   {
      
      public static const SWF:int = 1;
      
      public static const BYTE:int = 2;
      
      private var uiCfgs:Array = [];
      
      private var _srcArr:Array;
      
      private var _isRead:Boolean = false;
      
      public function UIBase123()
      {
         super();
      }
      
      public function preFun() : void
      {
         this.loadSrc();
      }
      
      protected function initUI2() : void
      {
         throw new Error("must be override");
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
         while(i + 2 < len)
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
         else
         {
            this.uiCfgs.push(info.data);
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
         this._srcArr.splice(0);
         return true;
      }
   }
}

