package com.yiTian.view.modules.guaji
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.IMainUiBtn;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class BitmapBtn extends IMainUiBtn
   {
      
      private var _bm_bg:Bitmap;
      
      private var _fun_click:Function;
      
      private var _extraObject:Object;
      
      private var iconHide:Boolean;
      
      public function BitmapBtn(iconHide:Boolean = false)
      {
         super();
         this.iconHide = iconHide;
      }
      
      public function init(_tx:Number = 4, _ty:Number = 4, _twidth:Number = 32, _theight:Number = 32) : void
      {
         graphics.beginFill(11206570,0);
         graphics.drawRect(_tx,_ty,_twidth,_theight);
         graphics.endFill();
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         if(this.iconHide)
         {
            Global.control.registerCallBack(Enum_mainUIBtn_hide.MOVE_TO_HIDE,this.onHide);
         }
      }
      
      private function onHide() : void
      {
         UIManager.mainUiBtnContainer.partPauseRemove(this,1);
      }
      
      public function set extraObject(value:Object) : void
      {
         this._extraObject = value;
      }
      
      public function get extraObject() : Object
      {
         return this._extraObject;
      }
      
      protected function clickHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         if(this._fun_click != null)
         {
            this._fun_click.call(null,evt);
         }
      }
      
      public function setBgDir(bmDir:String) : void
      {
         bmUrl = bmDir;
         if(!this._bm_bg)
         {
            this._bm_bg = new Bitmap();
            addChild(this._bm_bg);
         }
         this._bm_bg = Utils.getLoadBitmap(bmDir,this._bm_bg,{},function():void
         {
            graphics.clear();
         });
      }
      
      public function set clickCallBack(value:Function) : void
      {
         this._fun_click = value;
      }
      
      public function dispose() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         if(Boolean(this._bm_bg))
         {
            removeChild(this._bm_bg);
         }
         graphics.clear();
         removeEventListener(MouseEvent.CLICK,this.clickHandle);
         this._extraObject = null;
         this._fun_click = null;
         this._bm_bg.bitmapData = null;
         this._bm_bg = null;
      }
   }
}

