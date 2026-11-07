package com.yiTian.view.modules.npcDialog
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WordItem extends Sprite
   {
      
      private static var hightlight:BitmapData;
      
      private static var dialogBmd:BitmapData;
      
      protected var word:MyTextField;
      
      protected var tiao:Bitmap = new Bitmap();
      
      protected var _icon:Bitmap = new Bitmap();
      
      public function WordItem()
      {
         super();
         buttonMode = true;
         var shape:Shape = new Shape();
         shape.graphics.beginFill(0,0);
         shape.graphics.drawRect(0,0,500,18);
         shape.graphics.endFill();
         addChild(shape);
         if(!dialogBmd)
         {
            dialogBmd = ComponentUtil.getBitmapData("NPC_Talk",Global.npcTalk);
         }
         this._icon.x = 15;
         this._icon.y = 1;
         addChild(this._icon);
         this._icon.bitmapData = dialogBmd;
         this.word = ComponentUtil.getTextField("",this,{
            "x":35,
            "y":0,
            "realWidth":475,
            "color":1472370
         });
         addChild(this.word);
         if(!hightlight)
         {
            hightlight = ComponentUtil.getBitmapData("NPC_List",Global.npcTalk);
         }
         this.tiao.bitmapData = hightlight;
         this.tiao.visible = false;
         addChild(this.tiao);
         addEventListener(MouseEvent.ROLL_OVER,this.onRoleOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function onRoleOver(e:MouseEvent) : void
      {
         this.tiao.visible = true;
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         this.tiao.visible = false;
      }
      
      public function set htmlText(value:String) : void
      {
         this.word.htmlText = value;
      }
      
      override public function get width() : Number
      {
         return this.word.textWidth + this.word.x + 20;
      }
   }
}

