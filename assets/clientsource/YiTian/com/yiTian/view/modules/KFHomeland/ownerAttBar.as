package com.yiTian.view.modules.KFHomeland
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ownerAttBar extends Sprite
   {
      
      public static var _nameBarVec:Vector.<String> = new <String>["Text_FRD","Text_QJD","Text_JYB"];
      
      public static var _bitUrlVec:Vector.<String> = new <String>["Icon_FRD","Icon_ShaoBa","Icon_JYBT"];
      
      public var _barVec:Vector.<barItem>;
      
      private var _cleanContain:Sprite;
      
      private var _cleanBit:Bitmap;
      
      public function ownerAttBar()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var item:barItem = null;
         ComponentUtil.getBitmap("Back_FQJ",this,{
            "x":0,
            "y":0
         },Global.KFJYdm);
         this._barVec = new Vector.<barItem>(3,true);
         i = 0;
         while(i < 3)
         {
            item = new barItem(i);
            addChild(item);
            item.x = 0;
            item.y = 12 + i * 43;
            this._barVec[i] = item;
            i++;
         }
         this._cleanContain = new Sprite();
         addChild(this._cleanContain);
         this._cleanContain.x = 201;
         this._cleanContain.y = 65;
         this._cleanContain.buttonMode = true;
         this._cleanBit = ComponentUtil.getBitmap("Icon_LvQin",this._cleanContain,{
            "x":0,
            "y":0
         },Global.KFJYdm);
         this._cleanContain.addEventListener(MouseEvent.CLICK,this.cleanHandle);
      }
      
      private function cleanHandle(evt:MouseEvent) : void
      {
         if(VoHome.clean == 100)
         {
            UIManager.centerBroadcast.addMsg("清洁度100%，不需要清理");
            return;
         }
         HomeLandCGMessage.CG_CLEAN_HOMELAND(1);
      }
      
      private function cleanEff() : void
      {
      }
      
      public function update() : void
      {
         if(!this._barVec)
         {
            return;
         }
         var i:int = 0;
         while(i < 3)
         {
            this._barVec[i].update();
            i++;
         }
         this.updateCleanBtnStatus();
      }
      
      private function updateCleanBtnStatus() : void
      {
         if(VoHome.clean < 60)
         {
            this._cleanBit.bitmapData = ComponentUtil.getBitmapData("Icon_HongQin",Global.KFJYdm);
         }
         else
         {
            this._cleanBit.bitmapData = ComponentUtil.getBitmapData("Icon_LvQin",Global.KFJYdm);
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.TipManager;
import com.yiTian.view.modules.KFHomeland.VoHome;
import com.yiTian.view.modules.KFHomeland.ownerAttBar;
import flash.display.Bitmap;
import flash.display.Sprite;

class barItem extends Sprite
{
   
   private var _bit:Bitmap;
   
   private var _attTxt:MyTextField;
   
   private var _type:int;
   
   private var _att:String;
   
   private var _tips:String;
   
   public function barItem(type:int)
   {
      super();
      this._type = type;
      this.init();
   }
   
   private function init() : void
   {
      ComponentUtil.getBitmap("Back_FQJD",this,{
         "x":18,
         "y":0
      },Global.KFJYdm);
      ComponentUtil.getBitmap(ownerAttBar._nameBarVec[this._type],this,{
         "x":59,
         "y":11
      },Global.KFJYdm);
      this._attTxt = ComponentUtil.getTextField("1234567890",this,{
         "x":137,
         "y":8,
         "color":11523767,
         "size":12,
         "leading":0
      });
      this._bit = ComponentUtil.getBitmap(ownerAttBar._bitUrlVec[this._type],this,{
         "x":26,
         "y":5
      },Global.KFJYdm);
   }
   
   public function update() : void
   {
      if(!this._attTxt)
      {
         return;
      }
      switch(this._type)
      {
         case 0:
            this._att = String(VoHome.boom);
            this._tips = "繁荣度越高获得每天体力奖励越高";
            break;
         case 1:
            this._att = String(VoHome.clean) + "%";
            break;
         case 2:
            this._att = String(VoHome.homeMoney);
            this._tips = "在商铺中可以通过银子或者元宝购买获得";
      }
      this._attTxt.text = this._att;
      if(Boolean(this._tips) && this._tips != "")
      {
         TipManager.bind(this,this._tips);
      }
   }
}
