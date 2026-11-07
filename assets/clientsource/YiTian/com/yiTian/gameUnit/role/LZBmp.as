package com.yiTian.gameUnit.role
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.UIManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LZBmp extends Sprite
   {
      
      public static var isUsingSuperHuangZuan:Boolean = true;
      
      private var _bmp:Bitmap;
      
      public function LZBmp()
      {
         super();
         this.bmp = new Bitmap();
         addChild(this._bmp);
         useHandCursor = true;
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.cliHd);
         addEventListener(MouseEvent.MOUSE_DOWN,this.downHd);
      }
      
      public static function getLvlUrl(_index:int) : String
      {
         return "resource/image/Diamond/dia_" + _index + ".png";
      }
      
      public static function getYearUrl(_index:int) : String
      {
         return "resource/image/Diamond/year" + _index + ".png";
      }
      
      public static function getLvlUrl_h(_index:int) : String
      {
         return "resource/image/Diamond/Diamond000" + _index + ".png";
      }
      
      public static function getYearUrl_h(_index:int) : String
      {
         return "resource/image/Diamond/yearDiaLvl_" + _index + ".png";
      }
      
      public static function getLvlUrl_superH(_index:int) : String
      {
         return "resource/image/superHuangZuan/qz_vip_icon_fla_l_" + _index + ".png";
      }
      
      public static function getYearUrl_superH(_index:int) : String
      {
         return "resource/image/superHuangZuan/qz_vip_icon_fla_l_year_" + _index + ".png";
      }
      
      public static function getQQHuiYuan(_index:int) : String
      {
         return "resource/image/shouchong/HY0" + _index + ".png";
      }
      
      public static function getQQHuiYuanYear(_index:int) : String
      {
         return "resource/image/shouchong/HY_year0" + _index + ".png";
      }
      
      public static function getsuperLan(_index:int) : String
      {
         return "resource/image/Diamond/superLan_" + _index + ".png";
      }
      
      public static function getsuperLanYear(_index:int) : String
      {
         return "resource/image/Diamond/superLanYear_" + _index + ".png";
      }
      
      public static function getCamp(url:String) : String
      {
         return "resource/image/crossCampBattle/" + url + ".png";
      }
      
      private function downHd(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         if(Global.pf != Enum_SPStr.QQ3366)
         {
            UIManager.yellowDiamond.visible = !UIManager.yellowDiamond.visible;
         }
      }
      
      public function set bitmapData(bmd:BitmapData) : void
      {
         if(Boolean(this._bmp))
         {
            this._bmp.bitmapData = bmd;
         }
      }
      
      public function set bmp(b:Bitmap) : void
      {
         this._bmp = b;
      }
      
      public function get bmp() : Bitmap
      {
         return this._bmp;
      }
   }
}

