package com.yiTian.view.modules.team
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class TeamSign extends Sprite
   {
      
      private const WIDTH:int = 120;
      
      private const HEIGHT:int = 10;
      
      private var back:DisplayObject;
      
      private var hpBM:Bitmap;
      
      private var hpMask:Shape;
      
      private var mpBM:Bitmap;
      
      private var mpMask:Shape;
      
      private var PlayerHead:Bitmap;
      
      private var PlayerLeaderHead:Bitmap;
      
      private var PlayerLeaveHead:Bitmap;
      
      private var petHeadBack:Bitmap;
      
      private var PetHead:Bitmap;
      
      private var petMask:DisplayObject;
      
      private var Lever_text:MyTextField;
      
      private var PlayerName_text:MyTextField;
      
      private var bm:Bitmap;
      
      private var _position:int = 50;
      
      public var menuButton:SimpleButton;
      
      public var index:int;
      
      public var dataArr:Array;
      
      private var petBtn:DisplayObject;
      
      public function TeamSign()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         this.back = ComponentUtil.getBitmap("Back_TeamHead",this,{
            "x":0,
            "y":0
         },Global.Scenedm);
         this.hpBM = ComponentUtil.getBitmap("Player_Head_HP",this,{
            "x":67,
            "y":32
         },Global.Scenedm);
         this.hpMask = new Shape();
         this.draw(this.hpMask,this.WIDTH);
         addChild(this.hpMask);
         this.hpMask.x = this.hpBM.x;
         this.hpMask.y = this.hpBM.y;
         this.hpBM.mask = this.hpMask;
         this.mpBM = ComponentUtil.getBitmap("Player_Head_MP",this,{
            "x":66,
            "y":45
         },Global.Scenedm);
         this.mpMask = new Shape();
         this.draw(this.mpMask,this.WIDTH);
         addChild(this.mpMask);
         this.mpMask.x = this.mpBM.x;
         this.mpMask.y = this.mpBM.y;
         this.mpBM.mask = this.mpMask;
         this.petHeadBack = ComponentUtil.getBitmap("Back_TeamPet",this,{
            "x":195,
            "y":5
         },Global.Scenedm);
         this.PetHead = new Bitmap();
         this.PetHead.cacheAsBitmap = true;
         addChild(this.PetHead);
         this.PetHead.x = this.petHeadBack.x + 7;
         this.PetHead.y = this.petHeadBack.y + 7;
         this.petMask = ComponentUtil.getDisplayObject("Pet_Head_Mask",this,{
            "x":this.PetHead.x + 2,
            "y":this.PetHead.y + 2
         },ComponentUtil.domain);
         this.petMask.cacheAsBitmap = true;
         this.PetHead.mask = this.petMask;
         this.petBtn = ComponentUtil.getDisplayObject("Pet_Head_Mask",this,{
            "x":this.PetHead.x,
            "y":this.PetHead.y
         },ComponentUtil.domain);
         this.petBtn.alpha = 0;
         this.petBtn.addEventListener(MouseEvent.CLICK,this.petBtnHandler);
         (this.petBtn as Sprite).buttonMode = true;
         this.PlayerHead = new Bitmap();
         addChild(this.PlayerHead);
         this.PlayerHead.x = 5;
         this.PlayerHead.y = -5;
         this.PlayerLeaderHead = new Bitmap();
         addChild(this.PlayerLeaderHead);
         this.PlayerLeaderHead.visible = false;
         this.PlayerLeaveHead = new Bitmap();
         addChild(this.PlayerLeaveHead);
         this.PlayerLeaveHead.x = 35;
         this.PlayerLeaveHead.y = 50;
         this.PlayerLeaveHead.visible = false;
         this.Lever_text = ComponentUtil.getTextField("106",this,{
            "x":56,
            "y":7,
            "color":16777215,
            "size":11,
            "leading":0
         });
         this.Lever_text.realWidth = 20;
         this.Lever_text.align = TextFormatAlign.CENTER;
         this.PlayerName_text = ComponentUtil.getTextField("",this,{
            "x":90,
            "y":11,
            "color":16777215
         });
         this.bm = new Bitmap();
         addChild(this.bm);
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawCircle(0,0,25);
         shape.graphics.endFill();
         this.menuButton = new SimpleButton();
         this.menuButton.upState = this.menuButton.overState = this.menuButton.downState = shape;
         this.menuButton.hitTestState = this.menuButton.upState;
         addChild(this.menuButton);
         this.menuButton.x = 10 + 25;
         this.menuButton.y = 15 + 25;
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      private function petBtnHandler(e:MouseEvent) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            return;
         }
         if(Global.isInHome)
         {
            return;
         }
         (this.parent as TeamSignTogether).requestPetInfo(this);
         (this.parent as TeamSignTogether).petInfoVisible(true,this);
      }
      
      public function set showPetHead(value:Boolean) : void
      {
         this.petHeadBack.visible = value;
         this.PetHead.visible = value;
         this.petBtn.visible = value;
         this.petMask.visible = value;
      }
      
      public function set petHead(value:String) : void
      {
         Utils.getLoadBitmap(value,this.PetHead);
      }
      
      public function set showLeaveHead(value:Boolean) : void
      {
         this.PlayerLeaveHead.visible = value;
      }
      
      public function set showLeaderHead(value:Boolean) : void
      {
         this.PlayerLeaderHead.visible = value;
      }
      
      public function set myName(value:String) : void
      {
         value = Model_heFu.repNameByHero(value);
         this.PlayerName_text.text = value;
      }
      
      public function set playerHead(value:String) : void
      {
         Utils.getLoadBitmap(value,this.PlayerHead);
      }
      
      public function set greyLeaderHead(value:Boolean) : void
      {
         if(value)
         {
            (this.PlayerLeaderHead as DisplayObject).filters = Util.disabled;
         }
         else
         {
            (this.PlayerLeaderHead as DisplayObject).filters = [];
         }
      }
      
      public function set greyPlayerHead(value:Boolean) : void
      {
         if(value)
         {
            (this.PlayerHead as DisplayObject).filters = Util.disabled;
         }
         else
         {
            (this.PlayerHead as DisplayObject).filters = [];
         }
      }
      
      public function set levelTxt(value:String) : void
      {
         this.Lever_text.text = value;
      }
      
      public function updateHM(arr:Array) : void
      {
         var w:int = 0;
         w = arr[1] > arr[2] ? this.WIDTH : int(arr[1] / arr[2] * this.WIDTH);
         this.hpMask.width = w;
         w = arr[3] > arr[4] ? this.WIDTH : int(arr[3] / arr[4] * this.WIDTH);
         this.mpMask.width = w;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.PlayerLeaderHead.bitmapData)
            {
               Utils.getLoadBitmap("resource/image/team/dz.png",this.PlayerLeaderHead);
            }
            if(!this.PlayerLeaveHead.bitmapData)
            {
               Utils.getLoadBitmap("resource/image/team/zl.png",this.PlayerLeaveHead);
            }
         }
      }
   }
}

