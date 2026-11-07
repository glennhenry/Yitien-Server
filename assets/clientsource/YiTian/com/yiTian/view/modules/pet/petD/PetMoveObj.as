package com.yiTian.view.modules.pet.petD
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.cast.View_equip_ChengZhuang_jingLian;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import flashx.textLayout.formats.TextAlign;
   
   public class PetMoveObj extends Sprite
   {
      
      private static var pool:Array = [];
      
      public static var list:Array = [];
      
      public static const MSG_PET_CHANGE:String = "msg_pet_change";
      
      private static var livet_ime:int = 5000;
      
      private var tf:MyTextField;
      
      public var b:Bitmap = new Bitmap();
      
      private var _sty:int;
      
      private var moveGap:int = 5;
      
      private var bindParent:DisplayObjectContainer;
      
      private var timeLastRecord:int;
      
      public function PetMoveObj()
      {
         super();
         addChild(this.b);
         this.b.bitmapData = ComponentUtil.getBitmapData("Back_KQTJ",Global.Pet_Imgsdm);
         list.push(this);
      }
      
      public static function get instance() : PetMoveObj
      {
         return Boolean(pool.length) ? pool.pop() : new PetMoveObj();
      }
      
      public function setTextDescrip(value:String, point:Point) : void
      {
         if(!this.tf)
         {
            this.tf = ComponentUtil.getTextField("",this,{
               "size":14,
               "x":point.x,
               "y":point.y,
               "realWidth":68,
               "align":TextAlign.CENTER,
               "color":3394815
            });
         }
         this.tf.htmlText = value;
      }
      
      public function move(stx:int, sty:int, _parent:DisplayObjectContainer) : void
      {
         this._sty = sty;
         this.bindParent = _parent;
         this.timeLastRecord = getTimer();
         if(!this.bindParent.contains(this))
         {
            this.bindParent.addChild(this);
            this.alpha = 0;
            ComponentUtil.setPropertie(this,{
               "x":stx,
               "y":sty - 20
            });
            Tween.to(this,180,{
               "y":[this.y,this.y + 20],
               "alpha":[0,1]
            },function():void
            {
               start(moveGap);
            });
         }
      }
      
      private function start(gap:int) : void
      {
         var now:int = getTimer();
         if(now - this.timeLastRecord >= livet_ime)
         {
            this.remove();
         }
         Tween.to(this,500,{"y":[this.y,this.y + gap]},function():void
         {
            start(-gap);
         },null,Tween.SIN06);
      }
      
      public function remove() : void
      {
         Tween.stop(this);
         this.bindParent = null;
         this.tf.text = "";
         this.timeLastRecord = 0;
         this.b.rotation = 0;
         this.b.x = 0;
         this.b.y = 0;
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         list.splice(list.indexOf(this),1);
         pool.push(this);
         if(View_equip_ChengZhuang_jingLian.isShowAnjingTips)
         {
            View_equip_ChengZhuang_jingLian.isShowAnjingTips = false;
         }
      }
   }
}

