package com.yiTian.view.modules.Card
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_card_small extends Sprite
   {
      
      private var _vo:Vo_card = new Vo_card();
      
      private var backSpr:Sprite;
      
      private var bigBorderBm:Bitmap;
      
      private var borderBm:Bitmap;
      
      private var roleBm:Bitmap;
      
      private var starBmArr:Array = [];
      
      private var pointBm:Bitmap;
      
      private var levelTxt:MyTextField;
      
      private var needLockBm:Boolean;
      
      private var _lockSpr:Sprite;
      
      private var lockBm:Bitmap;
      
      public function View_card_small(needLockBm:Boolean = false)
      {
         super();
         this.needLockBm = needLockBm;
         this.backSpr = new Sprite();
         addChild(this.backSpr);
         this.bigBorderBm = ComponentUtil.getBitmap("",this.backSpr);
         this.roleBm = ComponentUtil.getBitmap("",this.backSpr,{
            "x":8,
            "y":8
         });
         this.borderBm = ComponentUtil.getBitmap("",this.backSpr,{
            "x":8,
            "y":8
         });
         ComponentUtil.getBitmap("Back_KPXX",this.backSpr,{
            "x":7,
            "y":102
         },Global.KaPaidm);
         var starId:int = 0;
         while(starId < 5)
         {
            this.starBmArr.push(ComponentUtil.getBitmap("",this.backSpr,{
               "x":9 + starId * 16,
               "y":103
            }));
            starId++;
         }
         this.pointBm = ComponentUtil.getBitmap("",this.backSpr,{
            "x":90,
            "y":93
         });
         this.levelTxt = ComponentUtil.getTextField("LV.5",this.backSpr,{
            "x":120,
            "y":99,
            "color":16772287,
            "size":12,
            "leading":0
         },"right");
         this._lockSpr = new Sprite();
         this.backSpr.addChild(this.lockSpr);
         this.lockSpr.buttonMode = true;
         this.lockBm = ComponentUtil.getBitmap("",this.lockSpr,{
            "x":93,
            "y":6
         },Global.KaPaidm);
         this.lockSpr.addEventListener(MouseEvent.CLICK,this.onClickLock);
         this.lockSpr.visible = needLockBm;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverCard);
         addEventListener(MouseEvent.MOUSE_MOVE,this.onRollOverCard);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutCard);
         addEventListener(MouseEvent.CLICK,this.onClickCard);
      }
      
      public function set vo(value:Vo_card) : void
      {
         if(Boolean(value))
         {
            this._vo = value;
            this.id = value.id;
            this.star = value.star;
            this.level = value.level;
            this.exp = value.exp;
            this.lock = value.lock;
            this.backSpr.visible = true;
         }
         else
         {
            this._vo = new Vo_card();
            this.id = 0;
            this.star = 0;
            this.level = 0;
            this.exp = 0;
            this.lock = 0;
            this.backSpr.visible = false;
         }
      }
      
      public function get id() : int
      {
         return this.vo.id;
      }
      
      public function set id(value:int) : void
      {
         if(value > 0)
         {
            Utils.getLoadBitmap("resource/image/card/card_small/" + Data_lib.card[value][1] + ".png",this.roleBm);
            this.bigBorderBm.bitmapData = ComponentUtil.getBitmapData("Back_Xiao" + this.color,Global.KaPaidm);
            this.borderBm.bitmapData = ComponentUtil.getBitmapData("Light_Xiao" + this.color,Global.KaPaidm);
            this.pointBm.bitmapData = ComponentUtil.getBitmapData("Back_KP" + this.color,Global.KaPaidm);
         }
         else
         {
            this.roleBm.bitmapData = null;
            this.borderBm.bitmapData = null;
            this.bigBorderBm.bitmapData = null;
            this.pointBm.bitmapData = null;
         }
      }
      
      public function get star() : int
      {
         return this.vo.star;
      }
      
      public function set star(value:int) : void
      {
         var starNum:* = undefined;
         var i:* = undefined;
         if(value >= 0)
         {
            for(starNum in this.starBmArr)
            {
               if(starNum < this.star)
               {
                  this.starBmArr[starNum].bitmapData = ComponentUtil.getBitmapData("Icon_LXX",Global.KaPaidm);
               }
               else
               {
                  this.starBmArr[starNum].bitmapData = ComponentUtil.getBitmapData("Icon_AXX",Global.KaPaidm);
               }
            }
         }
         else
         {
            for(i in this.starBmArr)
            {
               this.starBmArr[i].bitmapData = null;
            }
         }
      }
      
      public function get level() : int
      {
         return this.vo.level;
      }
      
      public function set level(value:int) : void
      {
         if(value > 0)
         {
            this.levelTxt.text = "LV." + this.level;
         }
         else
         {
            this.levelTxt.text = "";
         }
      }
      
      public function get color() : int
      {
         return this.vo.color;
      }
      
      public function get vo() : Vo_card
      {
         return this._vo;
      }
      
      public function get type() : int
      {
         return this.vo.type;
      }
      
      public function get exp() : int
      {
         return this.vo.exp;
      }
      
      public function set exp(value:int) : void
      {
      }
      
      private function onRollOverCard(e:MouseEvent) : void
      {
         TipManager.update(this.vo);
         filters = View_card.boderArray[this.vo.color - 1];
      }
      
      private function onRollOutCard(e:MouseEvent) : void
      {
         TipManager.hide();
         filters = null;
      }
      
      public function get lock() : int
      {
         return this.vo.lock;
      }
      
      public function set lock(value:int) : void
      {
         if(value == -1)
         {
            this.lockBm.bitmapData = null;
         }
         else if(value == 1)
         {
            this.lockBm.bitmapData = ComponentUtil.getBitmapData("Lock",Global.KaPaidm);
         }
         else if(value == 0)
         {
            this.lockBm.bitmapData = ComponentUtil.getBitmapData("UnLock",Global.KaPaidm);
         }
      }
      
      public function get lockSpr() : Sprite
      {
         return this._lockSpr;
      }
      
      private function onClickLock(e:MouseEvent) : void
      {
         e.stopPropagation();
         this.dispatchEvent(new CardEvent(CardEvent.LOCK,this));
      }
      
      private function onClickCard(e:MouseEvent) : void
      {
         this.dispatchEvent(new CardEvent(CardEvent.CLICK,this));
      }
      
      public function set dark(value:Boolean) : void
      {
         if(value)
         {
            this.backSpr.filters = Util.dark;
         }
         else
         {
            this.backSpr.filters = null;
         }
      }
   }
}

