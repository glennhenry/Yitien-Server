package com.yiTian.view.modules.joinfriends
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.roleHead.PlayerMenu;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class JoinFriendsItem extends Sprite
   {
      
      private const COLOR:Array = ["D75B43","5AA8BF","87BF38","BF65B4"];
      
      private var m:DisplayObject;
      
      private var t:MyTextField;
      
      private var s:Sprite;
      
      private var d:Array;
      
      private var b:Bitmap;
      
      public function JoinFriendsItem()
      {
         super();
         var b:Bitmap = new Bitmap();
         addChild(b);
         Utils.loadTitle("lang/ch/JoinFriends_Imgs.swf","Back_JoinFriends",b,null,null);
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":0,
            "y":94,
            "width":94,
            "height":26
         },Global.Img_Cdm);
         this.m = ComponentUtil.getDisplayObject("Player_Head_Mask",this);
         this.m.x = 15;
         this.m.y = 15;
         this.t = ComponentUtil.getTextField("",this);
         this.t.realWidth = 77;
         this.t.realHeight = 18;
         this.t.align = TextFormatAlign.CENTER;
         this.t.underline = true;
         this.t.x = 8;
         this.t.y = 98;
         this.s = new Sprite();
         var g:Graphics = this.s.graphics;
         g.beginFill(0,0);
         g.drawRect(0,0,77,19);
         g.endFill();
         addChild(this.s);
         this.s.x = this.t.x;
         this.s.y = this.t.y;
      }
      
      protected function spOnClick(e:MouseEvent) : void
      {
         e.stopPropagation();
         PlayerMenu.isSpecialCheck = false;
         PlayerMenu.getInstance().show([PlayerMenu.zdqq,PlayerMenu.ckzl,PlayerMenu.fqlt,PlayerMenu.fqjy,PlayerMenu.jwhy,PlayerMenu.fzmz],{
            "id":this.d[0],
            "name":this.d[3]
         });
      }
      
      public function updata(value:Array) : void
      {
         this.d = value;
         if(Boolean(this.d))
         {
            this.t.htmlText = "<font color=\'#" + this.COLOR[this.d[1] - 1] + "\'>" + this.d[3] + "</font>";
            if(Boolean(this.b))
            {
               removeChild(this.b);
            }
            this.b = new Bitmap();
            addChild(this.b);
            this.b.x = this.m.x;
            this.b.y = this.m.y;
            Utils.getLoadBitmap(Const_strImg.getPlayerHead(this.d[1],this.d[2]),this.b);
            this.b.mask = this.m;
            this.m.visible = true;
            this.s.addEventListener(MouseEvent.CLICK,this.spOnClick);
            this.s.buttonMode = true;
         }
         else
         {
            this.t.htmlText = "";
            this.m.visible = false;
            this.s.removeEventListener(MouseEvent.CLICK,this.spOnClick);
            this.s.buttonMode = false;
         }
      }
   }
}

