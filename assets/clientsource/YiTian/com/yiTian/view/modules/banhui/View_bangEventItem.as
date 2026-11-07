package com.yiTian.view.modules.banhui
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_bangEventItem extends Sprite
   {
      
      private var Informat_text:MyTextField;
      
      private var Time_text:MyTextField;
      
      private var _str_over_bmp:DisplayObject;
      
      private var _choose:Boolean = false;
      
      public function View_bangEventItem()
      {
         super();
         this.init();
         addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
         addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
      }
      
      public function init() : void
      {
         var spr:Sprite = null;
         spr = new Sprite();
         spr.graphics.beginFill(0,0);
         spr.graphics.drawRect(0,0,460,25);
         spr.graphics.endFill();
         spr.mouseEnabled = false;
         addChild(spr);
         var back1:ScaleBitmap = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":30,
            "width":460,
            "height":2
         },Global.Img_Cdm);
         this._str_over_bmp = ComponentUtil.getDisplayObject("Item_Select",this,{
            "width":460,
            "y":3
         });
         (this._str_over_bmp as Sprite).mouseEnabled = false;
         (this._str_over_bmp as Sprite).mouseChildren = false;
         this._str_over_bmp.visible = false;
         this.Informat_text = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":9,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.Time_text = ComponentUtil.getTextField("0000-00-00-00:00",this,{
            "x":350,
            "y":9,
            "color":11904647,
            "size":12,
            "realWidth":112,
            "leading":0
         });
         this.Time_text.autoSize = TextFieldAutoSize.CENTER;
      }
      
      private function overHandle(e:MouseEvent) : void
      {
         this._str_over_bmp.visible = true;
      }
      
      public function update(_data:Array) : void
      {
         this.Informat_text.text = _data[0];
         this.Time_text.text = DateUtil.getYMDHM(_data[1]);
      }
      
      private function outHandle(e:MouseEvent) : void
      {
         if(!this._choose)
         {
            this._str_over_bmp.visible = false;
         }
      }
      
      public function set choose(value:Boolean) : void
      {
         this._choose = value;
         this._str_over_bmp.visible = value;
      }
   }
}

