package com.yiTian.view.modules.team
{
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.banhui.Vo_BangZF;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class View_ZFGrid extends Sprite
   {
      
      private var _gridBg:Bitmap;
      
      private var _bitmap:Bitmap;
      
      private var _userData:Object;
      
      private var _vo:Vo_BangZF;
      
      private var _selectedBM:Bitmap;
      
      public function View_ZFGrid()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._gridBg = new Bitmap();
         addChild(this._gridBg);
         Utils.getLoadBitmap("resource/image/iconBg/open.png",this._gridBg);
         this._bitmap = new Bitmap();
         this._bitmap.x = 3;
         this._bitmap.y = 3;
         addChild(this._bitmap);
         this._selectedBM = new Bitmap();
         Utils.getLoadBitmap("resource/image/iconBg/select.png",this._selectedBM);
         addChild(this._selectedBM);
         this.selected = false;
      }
      
      public function set vo(value:Vo_BangZF) : void
      {
         this._vo = value;
         if(value.isLoadImg)
         {
            this._bitmap = Utils.getLoadBitmap("resource/image/icon/" + value.img.toString() + ".png",this._bitmap);
         }
      }
      
      public function set selected(value:Boolean) : void
      {
         this._selectedBM.visible = value;
      }
      
      public function get vo() : Vo_BangZF
      {
         return this._vo;
      }
   }
}

