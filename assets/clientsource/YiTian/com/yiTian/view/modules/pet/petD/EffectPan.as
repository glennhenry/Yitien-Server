package com.yiTian.view.modules.pet.petD
{
   import com.utils.ComponentUtil;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.PerspectiveProjection;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class EffectPan extends Sprite
   {
      
      protected var container:Sprite;
      
      private var bb:Bitmap;
      
      private var conBB:Sprite;
      
      private var _w:int = 243;
      
      private var _h:int = 282;
      
      public function EffectPan()
      {
         super();
         this.container = new Sprite();
         super.addChild(this.container);
      }
      
      public function get t_h() : int
      {
         return this._h;
      }
      
      public function set t_h(value:int) : void
      {
         this._h = value;
      }
      
      public function get t_w() : int
      {
         return this._w;
      }
      
      public function set t_w(value:int) : void
      {
         this._w = value;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var nn:int = 0;
         var p:PerspectiveProjection = null;
         var mm:int = 0;
         var bmd:BitmapData = new BitmapData(this.t_w,this.t_h,true,0);
         bmd.draw(this.container);
         if(!this.bb)
         {
            this.bb = new Bitmap();
            this.conBB = new Sprite();
            super.addChild(this.conBB);
            this.conBB.addChild(this.bb);
            ComponentUtil.setPropertie(this.bb,{"x":0 - this.t_w / 2});
            ComponentUtil.setPropertie(this.conBB,{"x":this.t_w / 2});
         }
         if(Boolean(this.conBB.parent.stage))
         {
            p = new PerspectiveProjection();
            p.projectionCenter = new Point(this.conBB.x,this.conBB.y);
            p.fieldOfView = 45;
            this.conBB.transform.perspectiveProjection = p;
            this.conBB.transform.perspectiveProjection = p;
         }
         this.bb.bitmapData = bmd;
         nn = int(setTimeout(function():void
         {
            clearTimeout(nn);
            container.visible = false;
         },50));
         this.conBB.visible = true;
         if(value)
         {
            mm = int(setTimeout(function():void
            {
               clearTimeout(mm);
               bbShow();
            },100));
         }
         else
         {
            Tween.to(this.conBB,100,{"rotationY":[0,90]},this.superHide);
         }
      }
      
      private function bbShow() : void
      {
         super.visible = true;
         this.conBB.rotationY = -90;
         Tween.to(this.conBB,200,{"rotationY":[this.conBB.rotationY,0]},this.superShow);
      }
      
      override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         this.container.addChildAt(child,index);
         return child;
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         this.container.addChild(child);
         return child;
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         this.container.removeChild(child);
         return child;
      }
      
      override public function set x(value:Number) : void
      {
         super.x = value;
      }
      
      override public function setChildIndex(child:DisplayObject, index:int) : void
      {
         this.container.setChildIndex(child,index);
      }
      
      override public function getChildAt(index:int) : DisplayObject
      {
         return this.container.getChildAt(index);
      }
      
      private function superHide() : void
      {
         this.container.visible = false;
         super.visible = false;
      }
      
      private function superShow() : void
      {
         this.container.visible = true;
         this.conBB.visible = false;
      }
   }
}

