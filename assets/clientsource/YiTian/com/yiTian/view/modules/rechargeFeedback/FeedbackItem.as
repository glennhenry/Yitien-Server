package com.yiTian.view.modules.rechargeFeedback
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.RechargeFeedbackCGMessage;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class FeedbackItem extends Sprite
   {
      
      private static var preItem:FeedbackItem;
      
      private static var selectFilter:Array = [new GlowFilter(16776960,1,8,8,2,1)];
      
      public static const RECEIVE:int = 1;
      
      public static const HAS_RECEIVED:int = 2;
      
      public static const NOT_ELIGIBLE:int = 0;
      
      private static const BTN_LABEL:Vector.<String> = new <String>[LangConfig.getWord("80224",8),LangConfig.getWord("80225",8),LangConfig.getWord("80226",8)];
      
      private var selectBmd:Bitmap;
      
      private var title:MyTextField;
      
      private var btn:Button;
      
      private var type:int;
      
      private var itemArr:Array;
      
      private var bmd:Bitmap;
      
      public function FeedbackItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         ComponentUtil.getBitmap("Back_CardOpend",this,{
            "x":0,
            "y":0
         },Global.HuiKui_Imgsdm);
         this.addEventListener(MouseEvent.CLICK,this.onClick);
         this.title = ComponentUtil.getTextField("",this,{
            "x":width / 2,
            "y":6,
            "color":14277081
         },"center");
         this.btn = ComponentUtil.getButton("","Button_LingQu",this,{
            "x":4,
            "y":103,
            "textColor":16184781
         },Global.HuiKui_Imgsdm);
         this.btn.callBack = this.clickFun;
      }
      
      public function select() : void
      {
         this.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function onClick(event:MouseEvent) : void
      {
         if(preItem == this)
         {
            return;
         }
         if(Boolean(preItem))
         {
            preItem.filters = [];
         }
         this.filters = selectFilter;
         View_RechargeFeedback.instance.itemList.upData(this.type,this.getItemList());
         preItem = this;
      }
      
      public function show(type:int) : void
      {
         if(Boolean(this.bmd))
         {
            return;
         }
         this.title.text = LangConfig.getWord("80228",8,Data_lib.czfk[type][0]);
         this.bmd = new Bitmap();
         addChild(this.bmd);
         ComponentUtil.setPropertie(this.bmd,{
            "x":26,
            "y":33
         });
         Utils.getLoadBitmap("resource/image/rechargeFeedback/" + type + ".png",this.bmd);
         this.type = type;
      }
      
      public function getItemList() : Array
      {
         var len:int = 0;
         var i:int = 0;
         if(!this.itemArr)
         {
            this.itemArr = Data_lib.czfk[this.type][1].toString().split(",");
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
         this.select();
         RechargeFeedbackCGMessage.CG_GET_FEEDBACK(this.type);
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
