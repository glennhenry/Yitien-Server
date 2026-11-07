package com.yiTian.view.modules.skill.masterSk
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.call.DelegateEvent;
   import com.yiTian.utils.call.IDelegate123Obj;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Sprite;
   
   public class ChildSprite extends Sprite implements IDelegate123Obj
   {
      
      private var regArr:Array;
      
      private var _isReady:Boolean = false;
      
      public function ChildSprite()
      {
         super();
      }
      
      protected function regResource(url:String, img:String) : void
      {
         if(!this.regArr)
         {
            this.regArr = [];
         }
         this.regArr.push([url,img]);
      }
      
      public function preFun() : void
      {
         var urlName:String = null;
         var globalName:String = null;
         var len:int = int(this.regArr.length);
         if(!len)
         {
            return;
         }
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            urlName = this.regArr[i][0];
            globalName = this.regArr[i][1];
            if(!Global[globalName])
            {
               arr.push([urlName,this.singleLoadComp,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL,globalName]);
            }
            i++;
         }
         View_loading.instance.load(arr,this.allComp);
         View_loading.instance.visible = false;
      }
      
      protected function initSource() : void
      {
      }
      
      private function singleLoadComp(info:Object) : void
      {
         var gName:String = info.obj[5];
         Global[gName] = info.applicationDomain;
      }
      
      private function allComp() : void
      {
         this._isReady = true;
         this.initSource();
         dispatchEvent(new DelegateEvent(DelegateEvent.T_T_COMPLETE));
         this.regArr.splice(0);
      }
      
      public function get isReady() : Boolean
      {
         return this._isReady;
      }
   }
}

