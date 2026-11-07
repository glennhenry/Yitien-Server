package com.yiTian.view.modules.newRechargeFeedback
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.NewRechargeFeedbackCGMessage;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class NewFeedbackItem extends Sprite
   {
      
      private static var preItem:NewFeedbackItem;
      
      private static var selectFilter:Array = [new GlowFilter(16776960,1,8,8,2,1)];
      
      public static const RECEIVE:int = 1;
      
      public static const HAS_RECEIVED:int = 2;
      
      public static const NOT_ELIGIBLE:int = 0;
      
      private static const BTN_LABEL:Vector.<String> = new <String>[LangConfig.getWord("80224",8),LangConfig.getWord("80225",8),LangConfig.getWord("80226",8)];
      
      private var btn:Button;
      
      private var type:int;
      
      private var itemArr:Array;
      
      private var bmd:Bitmap;
      
      private var selectBmd:Bitmap;
      
      public function NewFeedbackItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
      }
      
      public function select(value:Boolean) : void
      {
         this.selectBmd.visible = value;
      }
      
      public function onClick(event:MouseEvent = null) : void
      {
         if(preItem == this)
         {
            return;
         }
         if(Boolean(preItem))
         {
            preItem.select(false);
         }
         this.select(true);
         View_NewRechargeFeedback.instance.itemList.upData(this.type,this.getItemList());
         preItem = this;
      }
      
      public function show(type:int) : void
      {
         ComponentUtil.getBitmap("Card_0" + type,this,null,Global.NewHuiKui_Imgsdm);
         this.selectBmd = ComponentUtil.getBitmap("Card_Select",this,{
            "x":-4,
            "y":-4,
            "visible":false
         },Global.NewHuiKui_Imgsdm);
         this.btn = ComponentUtil.getButton("","Button_LingQu",this,{
            "x":18,
            "y":128,
            "textColor":16184781
         },Global.NewHuiKui_Imgsdm);
         this.btn.enabled = false;
         this.btn.callBack = this.clickFun;
         this.addEventListener(MouseEvent.CLICK,this.onClick);
         this.type = type;
      }
      
      public function getItemList() : Array
      {
         var len:int = 0;
         var i:int = 0;
         if(!this.itemArr)
         {
            this.itemArr = Data_lib.gcfk[this.type][1].toString().split(",");
            len = int(this.itemArr.length);
            i = 0;
            while(i < len)
            {
               this.itemArr[i] = this.itemArr[i].split("_");
               i++;
            }
         }
         return this.itemArr;
      }
      
      private function clickFun(event:MouseEvent) : void
      {
         this.onClick();
         NewRechargeFeedbackCGMessage.CG_NEW_GET_FEEDBACK(this.type);
      }
      
      public function upBtn(status:int) : void
      {
         switch(status)
         {
            case RECEIVE:
               this.btn.enabled = true;
               break;
            case HAS_RECEIVED:
            case NOT_ELIGIBLE:
               this.btn.enabled = false;
         }
      }
   }
}

import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.utils.Utils;
import com.yiTian.view.comp.View_Grid;
import flash.display.Bitmap;
import flash.display.Sprite;

class GridView extends Sprite
{
   
   private var selectBmd:Bitmap;
   
   private var bmd:Bitmap;
   
   public function GridView()
   {
      super();
   }
   
   public function init(type:int) : void
   {
      ComponentUtil.getBitmap("Grid_Open",this,null,Global.Img_Cdm);
      this.selectBmd = new Bitmap();
      addChild(this.selectBmd);
      this.selectBmd.visible = false;
      Utils.getLoadBitmap(View_Grid.GRID_SELECT,this.selectBmd);
      ComponentUtil.setPropertie(this.selectBmd,{
         "x":0,
         "y":0
      });
      this.bmd = new Bitmap();
      addChild(this.bmd);
      ComponentUtil.setPropertie(this.bmd,{
         "x":3,
         "y":3
      });
      Utils.getLoadBitmap("resource/image/rechargeFeedback/" + type + ".png",this.bmd);
      buttonMode = true;
   }
   
   public function set disabled(value:Boolean) : void
   {
      this.bmd.filters = value ? Util.disabled : [];
   }
   
   public function set select(value:Boolean) : void
   {
      this.selectBmd.visible = value;
   }
}
