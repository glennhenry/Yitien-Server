package com.yiTian.view.modules.fishing
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class Child_fishMarkItem extends Sprite
   {
      
      private var bg:DisplayObject;
      
      private var bm_icon:Bitmap;
      
      private var grid:View_Grid;
      
      private var tf_name:MyTextField;
      
      private var _data:Object;
      
      private var grid_bm:Bitmap;
      
      public var itemIndex:int = 0;
      
      public function Child_fishMarkItem()
      {
         super();
         this.init();
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      private function init() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":0,
            "y":0,
            "width":250,
            "height":50
         },Global.Img_Cdm);
         this.grid_bm = ComponentUtil.getBitmap("Grid_Open",this,{
            "x":5,
            "y":5
         },Global.Img_Cdm);
         this.bm_icon = new Bitmap();
         this.bm_icon.x = 8;
         this.bm_icon.y = 8;
         addChild(this.bm_icon);
         this.tf_name = ComponentUtil.getTextField("",this,{
            "x":86,
            "y":16,
            "color":11904647,
            "size":12,
            "leading":0
         });
         buttonMode = true;
         mouseChildren = false;
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,250,50);
         graphics.endFill();
      }
      
      public function set data(value:Object) : void
      {
         var url:String = null;
         var name:String = null;
         var type:int = 0;
         var str1:String = null;
         if(Boolean(value))
         {
            this._data = value;
            url = "resource/image/icon/" + Data_lib.item[this._data][Enum_lib_item.STR_ICON] + ".png";
            this.bm_icon = Utils.getLoadBitmap(url,this.bm_icon);
            name = Data_lib.item[this._data][Enum_lib_item.STR_NAME] + LangConfig.getWord("23317",2);
            type = int(Data_lib.item[this._data][Enum_lib_item.COLOR]);
            if(type == Enum_color.WHITE)
            {
               str1 = HtmlUtil.font(name,ColorConstant.getColorStr(ColorConstant.WHITE),12);
            }
            else if(type == Enum_color.GREEN)
            {
               str1 = HtmlUtil.font(name,ColorConstant.getColorStr(ColorConstant.GREEN),12);
            }
            else if(type == Enum_color.BLUE)
            {
               str1 = HtmlUtil.font(name,ColorConstant.getColorStr(ColorConstant.BLUE),12);
            }
            else if(type == Enum_color.PURPLE)
            {
               str1 = HtmlUtil.font(name,ColorConstant.getColorStr(ColorConstant.PURPLE),12);
            }
            this.tf_name.htmlText = str1;
         }
         else
         {
            this.bm_icon.bitmapData = null;
            this._data = null;
            this.tf_name.text = LangConfig.getWord("23316",2);
         }
      }
      
      public function isEmpty() : Boolean
      {
         return this._data == null;
      }
   }
}

