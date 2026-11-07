package com.yiTian.view.modules.guide
{
   import com.ui.controls.ScaleBitmap;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import flash.display.Sprite;
   
   public class View_questGuiKuang extends Sprite
   {
      
      private static var _instance:View_questGuiKuang;
      
      private var back:ScaleBitmap;
      
      private var _wid:int;
      
      private var _hei:int;
      
      public function View_questGuiKuang()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public static function get instance() : View_questGuiKuang
      {
         if(!_instance)
         {
            _instance = new View_questGuiKuang();
         }
         return _instance;
      }
      
      public function setSize(wid:int, hei:int) : void
      {
         if(!this.back)
         {
            this._wid = wid;
            this._hei = hei;
            this.back = Utils.getScaleBitmap("resource/image/guide/kuang.png",null,[10,8,50,12],null,this.loadCom,MassLoader.LEVEL0);
            addChild(this.back);
            return;
         }
         this.back.width = wid;
         this.back.height = hei;
         this.toDodge();
      }
      
      private function loadCom() : void
      {
         this.back.width = this._wid;
         this.back.height = this._hei;
         this.toDodge();
      }
      
      private function toDodge() : void
      {
         Tween.to(this,300,{"alpha":[1,0.5]},this.toClear);
      }
      
      private function toClear() : void
      {
         Tween.to(this,300,{"alpha":[0.5,1]},this.toDodge);
      }
   }
}

