package com.yiTian.view.modules.farm
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_farmList;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.handler.FarmHandler;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_farmListItem extends Sprite
   {
      
      public static var selectedTarget:Child_farmListItem;
      
      private static const maskY:Number = 20;
      
      public static var pool:Array = [];
      
      private var maskX:Number = 142;
      
      private var bg:Shape;
      
      public var vo_info:Vo_farmList;
      
      private var bm_icon:Bitmap;
      
      private var tf_friendName:MyTextField;
      
      public var farmStatus:int;
      
      public var bit:Bitmap;
      
      private var sprite:Sprite;
      
      private var mouseArea:Sprite;
      
      private var isSelected:Boolean = false;
      
      public function Child_farmListItem(data:Vo_farmList)
      {
         super();
         this.bg = new Shape();
         addChild(this.bg);
         this.vo_info = data;
         this.bm_icon = new Bitmap();
         this.sprite = new Sprite();
         addChild(this.sprite);
         this.bit = new Bitmap();
         this.bit.x = 129;
         this.bit.y = 3;
         this.sprite.addChild(this.bit);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":25,
            "y":2,
            "width":16,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":129,
            "y":2,
            "width":16,
            "height":16
         },Global.Img_Cdm);
         this.tf_friendName = ComponentUtil.getTextField("玩家中文名字",this,{
            "x":45,
            "y":2,
            "color":12537400,
            "size":12,
            "leading":0
         });
         this.tf_friendName.selectable = false;
         addChild(this.tf_friendName);
         this.bm_icon.x = 25;
         addChild(this.bm_icon);
         this.mouseArea = new Sprite();
         this.mouseArea.graphics.beginFill(8947848,0);
         this.mouseArea.graphics.drawRect(15,0,this.maskX,maskY);
         this.mouseArea.graphics.endFill();
         addChild(this.mouseArea);
         this.update(this.vo_info);
         this.updateStatus(this.vo_info.status,this.vo_info.farmer);
         addEventListener(MouseEvent.MOUSE_MOVE,this.rollOverHandle);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandle);
         addEventListener(MouseEvent.CLICK,this.mouseClickHandle);
      }
      
      public static function doneSelectedTarget() : void
      {
         if(Boolean(selectedTarget))
         {
            selectedTarget.setMouseOutBg();
         }
      }
      
      public function getItem(data:Vo_farmList) : void
      {
         this.vo_info = data;
         this.vo_info.name = Model_heFu.repNameByHero(this.vo_info.name);
         this.update(this.vo_info);
         this.updateStatus(this.vo_info.status,this.vo_info.farmer);
      }
      
      public function updateStatus(index:int, farmer:uint = 0) : void
      {
         this.farmStatus = index;
         if(this.farmStatus == 2)
         {
            this.bit.bitmapData = ComponentUtil.getBitmapData("waterSmall",Global.ShanZhuang_Imgsdm);
            TipManager.bind(this.sprite,LangConfig.getWord("102",9));
         }
         else if(this.farmStatus == 1)
         {
            this.bit.bitmapData = ComponentUtil.getBitmapData("catchSmallIcon",Global.ShanZhuang_Imgsdm);
            TipManager.bind(this.sprite,LangConfig.getWord("103",9));
         }
         else if(this.farmStatus == 3)
         {
            this.bit.bitmapData = ComponentUtil.getBitmapData("matureSmall",Global.ShanZhuang_Imgsdm);
            TipManager.bind(this.sprite,LangConfig.getWord("104",9));
         }
         else
         {
            this.bit.bitmapData = null;
         }
         this.setChildIndex(this.sprite,this.numChildren - 1);
         if(farmer == 0)
         {
            this.tf_friendName.htmlText = HtmlUtil.font(this.vo_info.name,ColorConstant.getColorStr(ColorConstant.WHITE),12);
         }
         else if(farmer == 1)
         {
            this.tf_friendName.htmlText = HtmlUtil.font(this.vo_info.name,ColorConstant.getColorStr(ColorConstant.RED),12);
         }
      }
      
      public function update(data:Vo_farmList) : void
      {
         var icon_num:int = 23000 + Enum_job.getBaseJob(this.vo_info.job) * 100 + 30 + this.vo_info.sex;
         var str_icon:String = "resource/image/icon/" + icon_num.toString() + ".jpg";
         Utils.getLoadBitmap(str_icon,this.bm_icon);
         this.tf_friendName.htmlText = HtmlUtil.font(data.name,ColorConstant.getColorStr(ColorConstant.WHITE),12);
      }
      
      private function rollOverHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         if(!this.isSelected)
         {
            this.setMouseOverBg();
         }
      }
      
      private function rollOutHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         if(!this.isSelected)
         {
            this.setMouseOutBg();
         }
      }
      
      public function dispose() : void
      {
         this.vo_info = null;
         this.tf_friendName.text = "";
         this.bm_icon.bitmapData = null;
         this.bit.bitmapData = null;
         pool.push(this);
      }
      
      private function mouseClickHandle(evt:MouseEvent) : void
      {
         doneSelectedTarget();
         selectedTarget = this;
         this.setSelectedBg();
         FarmHandler.updateFarm(this.vo_info.id);
      }
      
      private function setMouseOverBg() : void
      {
         this.bg.graphics.beginFill(5609898,0.7);
         this.bg.graphics.drawRect(15,0,this.maskX,maskY);
         this.bg.graphics.endFill();
      }
      
      private function setMouseOutBg() : void
      {
         this.isSelected = false;
         this.bg.graphics.clear();
      }
      
      private function setSelectedBg() : void
      {
         this.isSelected = true;
         this.bg.graphics.beginFill(14135320,0.7);
         this.bg.graphics.drawRect(15,0,this.maskX,maskY);
         this.bg.graphics.endFill();
      }
   }
}

