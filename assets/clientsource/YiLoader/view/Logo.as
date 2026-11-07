package view
{
   import com.utils.ComponentUtil;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.system.ApplicationDomain;
   import manager.Tween;
   
   public class Logo extends Sprite
   {
      
      private var bm:Bitmap;
      
      private var light:DisplayObject;
      
      private var lightMask:DisplayObject;
      
      public function Logo()
      {
         super();
      }
      
      public function getDisplayObject(url:String, parent:DisplayObjectContainer = null, property:Object = null, dm:ApplicationDomain = null) : DisplayObject
      {
         var cla:Class = dm.getDefinition(url) as Class;
         var disobj:DisplayObject = new cla();
         disobj.cacheAsBitmap = true;
         if(Boolean(parent))
         {
            parent.addChild(disobj);
         }
         return disobj;
      }
      
      public function play(info:Object) : void
      {
         this.bm = ComponentUtil.getBitmap("logo2",null,null,info.applicationDomain);
         this.light = this.getDisplayObject("back",null,null,info.applicationDomain);
         this.light.alpha = 0.4;
         this.light.blendMode = BlendMode.ADD;
         this.lightMask = this.getDisplayObject("logo",null,null,info.applicationDomain);
         addChild(this.bm);
         addChild(this.light);
         addChild(this.lightMask);
         this.light.mask = this.lightMask;
         this.toRight();
      }
      
      private function toLeft() : void
      {
         Tween.to(this.light,1500,{
            "x":[170,0],
            "y":[18,-17]
         },this.toRight,null,Tween.BEE_LINE);
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

