package com.yiTian.view.modules.zhuanZhi
{
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.utils.Bitmap2;
   import flash.display.Sprite;
   
   public class View_ZhuanZhiAtbSp extends Sprite
   {
      
      private var _atbProxy:JobAttProxy;
      
      private var _face:Bitmap2;
      
      private var _loadEnabled:Boolean = false;
      
      private var _url:String;
      
      private var _size:uint = 0;
      
      public function View_ZhuanZhiAtbSp(bEvent:Boolean = true)
      {
         super();
         this._atbProxy = new JobAttProxy(this);
         this._face = new Bitmap2();
         addChild(this._face);
         if(bEvent)
         {
            this._atbProxy.addEvent();
         }
      }
      
      public function setSize(v:uint) : void
      {
         this._size = v;
      }
      
      public function setJob(v:uint) : void
      {
         this._atbProxy.setJob(v);
         var way:int = int(Enum_job.getChildWay(v));
         switch(way)
         {
            case 1:
               this._url = Boolean(this._size) ? "resource/image/zhuanZhi/1_" + this._size.toString() + ".png" : "resource/image/zhuanZhi/1.png";
               break;
            case 2:
               this._url = Boolean(this._size) ? "resource/image/zhuanZhi/2_" + this._size.toString() + ".png" : "resource/image/zhuanZhi/2.png";
         }
         this.load();
      }
      
      public function enableLoad() : void
      {
         if(!this._loadEnabled)
         {
            this._loadEnabled = true;
            this.load();
         }
      }
      
      private function load() : void
      {
         if(this._loadEnabled)
         {
            this._face.load(this._url);
            this._url = null;
         }
      }
   }
}

