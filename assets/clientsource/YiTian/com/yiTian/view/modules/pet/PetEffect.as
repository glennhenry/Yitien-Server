package com.yiTian.view.modules.pet
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class PetEffect
   {
      
      private static var _pe:PetEffect;
      
      public static var TSCG:String = "tscg";
      
      public static var XZCG:String = "xzcg";
      
      public static var DTJM:String = "dtjm";
      
      public static var LHCG:String = "lhcg";
      
      public static var JDCG:String = "jdcg";
      
      public static var JJCG:String = "jjcg";
      
      public static var XSCG:String = "Text_XSCG";
      
      public static var XSSB:String = "Text_XSSB";
      
      private var _url:String;
      
      private var _eff:Effect;
      
      private var _mask:DisplayObject;
      
      private var _back:DisplayObject;
      
      private var _bm:Bitmap = new Bitmap();
      
      private var _contain:Sprite = new Sprite();
      
      private var _c:Class;
      
      private var _light:DisplayObject;
      
      private var _info:Object;
      
      public var _type:int;
      
      public function PetEffect()
      {
         super();
      }
      
      public static function getInstance() : PetEffect
      {
         if(!_pe)
         {
            _pe = new PetEffect();
         }
         return _pe;
      }
      
      public function play(url:String, type:int = 0) : void
      {
         this._url = url;
         this._type = type;
         if(!this._info)
         {
            MassLoader.add("resource/image/pet/petEff.swf",this.onComplete);
         }
         else
         {
            this.onComplete(this._info);
         }
      }
      
      public function load() : void
      {
         if(!this._info)
         {
            MassLoader.add("resource/image/pet/petEff.swf",this.loaded);
         }
      }
      
      private function loaded(info:Object) : void
      {
         this._info = info;
      }
      
      private function onComplete(info:Object) : void
      {
         var __url:String;
         var nn:int = 0;
         this._info = info;
         __url = "35070";
         if(this._type == -1)
         {
            __url = "35066";
         }
         this._eff = EffectManager.addEffect(__url,this._contain,700,420,50,false,2,this.playEnd);
         this._c = info.applicationDomain.getDefinition(this._url + "_png") as Class;
         this._bm.bitmapData = new this._c();
         this._contain.addChild(this._bm);
         this._bm.x = 420 - 80;
         this._bm.y = 50 - 30;
         if(!UIManager.petPanel.contains(this._contain))
         {
            UIManager.petPanel.addChild(this._contain);
         }
         if(this._type == -1)
         {
            nn = int(setTimeout(function():void
            {
               clearTimeout(nn);
               playEnd();
            },700));
            return;
         }
         this._light = ComponentUtil.getDisplayObject("back",null,null,Global.effectWord);
         this._light.y = this._bm.y;
         this._light.blendMode = BlendMode.ADD;
         this._contain.addChild(this._light);
         this._c = info.applicationDomain.getDefinition(this._url + "_mask") as Class;
         this._mask = new this._c();
         this._mask.x = this._bm.x + 6.85;
         this._mask.y = this._bm.y + 6.85;
         this._light.mask = this._mask;
         this._contain.addChild(this._mask);
         Tween.to(this._light,700,{"x":[this._bm.x,this._bm.x + this._bm.width]},this.playEnd);
      }
      
      private function playEnd() : void
      {
         if(UIManager.petPanel.contains(this._contain))
         {
            UIManager.petPanel.removeChild(this._contain);
         }
         while(Boolean(this._contain.numChildren))
         {
            this._contain.removeChild(this._contain.getChildAt(this._contain.numChildren - 1));
         }
      }
   }
}

