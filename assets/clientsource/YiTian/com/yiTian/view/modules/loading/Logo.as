package com.yiTian.view.modules.loading
{
   import com.utils.ComponentUtil;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class Logo extends Sprite
   {
      
      private var bm:Bitmap;
      
      private var light:DisplayObject;
      
      private var lightMask:DisplayObject;
      
      public function Logo()
      {
         super();
      }
      
      public function play(info:Object) : void
      {
         this.bm = ComponentUtil.getBitmap("logo2",null,null,info.applicationDomain);
         this.light = ComponentUtil.getDisplayObject("back",null,null,info.applicationDomain);
         this.light.alpha = 0.4;
         this.light.blendMode = BlendMode.ADD;
         this.lightMask = ComponentUtil.getDisplayObject("logo",null,null,info.applicationDomain);
         addChild(this.bm);
         addChild(this.light);
         addChild(this.lightMask);
         this.light.mask = this.lightMask;
      }
      
      public function begin() : void
      {
         this.toRight();
      }
      
      private function toRight() : void
      {
         Tween.to(this.light,1200,{
            "x":[-250,142],
            "y":[-60,45]
         },this.toRight,null,Tween.BEE_LINE);
      }
      
      public function end() : void
      {
         Tween.stop(this.light);
      }
      
      public function dispose() : void
      {
         var child:DisplayObject = null;
         if(Boolean(this.light))
         {
            Tween.stop(this.light);
         }
         while(Boolean(numChildren))
         {
            child = getChildAt(0);
            removeChild(child);
         }
      }
   }
}

