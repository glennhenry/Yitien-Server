package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class buildingsItem extends Sprite
   {
      
      private var _btmBuildings:Bitmap;
      
      private var _colorBit:Bitmap;
      
      private var _lockBtm:Bitmap;
      
      private var _tips:String;
      
      public var _canUseNum:int;
      
      public var _sysLevel:int;
      
      private var _canUseNumTxt:MyTextField;
      
      private var _nameTxt:MyTextField;
      
      private var numBit:Bitmap;
      
      public var _bId:int;
      
      private var _thisBuildsInfo:InfoItemBuildings;
      
      private var maskShape:Shape;
      
      private var color:int;
      
      private var colorVec:Vector.<String> = new <String>["#000000","#ffffff","#04ff00","#33CCFF","#de45c7","#ff7700"];
      
      public function buildingsItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var back:Bitmap = ComponentUtil.getBitmap("Back_JZWP",this,{
            "x":0,
            "y":0
         },Global.KFJYdm);
         this.numBit = ComponentUtil.getBitmap("Back_WPSZ",this,{
            "x":87,
            "y":145
         },Global.KFJYdm);
         this._canUseNumTxt = ComponentUtil.getTextField("999",this,{
            "x":85 + this.numBit.width / 2,
            "y":144,
            "color":16772287,
            "size":12,
            "leading":0
         },"center");
         this._nameTxt = ComponentUtil.getTextField("一级建筑",this,{
            "x":back.width / 2,
            "y":124,
            "color":16755712,
            "size":12,
            "leading":0
         },"center");
         this._colorBit = new Bitmap();
         addChild(this._colorBit);
         this._btmBuildings = new Bitmap();
         addChild(this._btmBuildings);
         this._lockBtm = ComponentUtil.getBitmap("Lock",this,{
            "x":49,
            "y":58
         },Global.KFJYdm);
         this.buttonMode = true;
      }
      
      public function update(infObj:InfoItemBuildings) : void
      {
         if(!infObj)
         {
            this.visible = false;
            return;
         }
         if(Boolean(this._colorBit))
         {
            this._colorBit.bitmapData = null;
         }
         if(Boolean(this._btmBuildings))
         {
            this._btmBuildings.bitmapData = null;
         }
         this._btmBuildings.visible = false;
         this.visible = true;
         this._thisBuildsInfo = infObj;
         this._bId = infObj.id;
         this.setStatus(infObj.num);
         this._tips = infObj.localDataArr[Enum_SortBuildins.DESC_ATT];
         TipManager.bind(this,this._tips);
         this._nameTxt.htmlText = HtmlUtil.fontNoSize("" + infObj.localDataArr[Enum_SortBuildins.NAME_ATT],this.colorVec[this.color]);
         this.color = infObj.localDataArr[Enum_SortBuildins.COLOR_ATT];
         Utils.getLoadBitmap("resource/image/kuafuHome/color/color" + this.color + ".png",this._colorBit,{
            "x":4,
            "y":19
         },this.refresh);
         Utils.getLoadBitmap("resource/image/kuafuHome/sortBuild/" + this._bId + ".png",this._btmBuildings,{
            "x":2,
            "y":18
         },this.refresh);
      }
      
      private function refresh() : void
      {
         Utils.getLoadBitmap("resource/image/kuafuHome/color/color" + this.color + ".png",this._colorBit,{
            "x":4,
            "y":19
         });
         Utils.getLoadBitmap("resource/image/kuafuHome/sortBuild/" + this._bId + ".png",this._btmBuildings,{
            "x":2,
            "y":18,
            "visible":true
         });
      }
      
      public function setStatus(num:int) : void
      {
         this._canUseNum = num;
         if(this._canUseNum > 0)
         {
            this._canUseNumTxt.visible = true;
            this.numBit.visible = true;
            this._canUseNumTxt.text = String(this._canUseNum);
         }
         else
         {
            this.numBit.visible = false;
            this._canUseNumTxt.visible = false;
         }
         if(num <= 0)
         {
            this._lockBtm.visible = true;
            if(!this.maskShape)
            {
               this.maskShape = new Shape();
               this.maskShape.graphics.beginFill(0,0.4);
               this.maskShape.graphics.drawRect(0,0,this.width,this.height);
               this.maskShape.graphics.endFill();
            }
            this.maskShape.visible = true;
            if(!this.contains(this.maskShape))
            {
               this.addChild(this.maskShape);
            }
         }
         else
         {
            this._lockBtm.visible = false;
            if(Boolean(this.maskShape))
            {
               this.maskShape.visible = false;
               if(this.contains(this.maskShape))
               {
                  this.removeChild(this.maskShape);
               }
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            if(Boolean(this._colorBit))
            {
               this._colorBit.bitmapData = null;
            }
            if(Boolean(this._btmBuildings))
            {
               this._btmBuildings.bitmapData = null;
            }
         }
      }
   }
}

