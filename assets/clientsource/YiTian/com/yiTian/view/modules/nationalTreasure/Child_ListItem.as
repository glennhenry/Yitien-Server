package com.yiTian.view.modules.nationalTreasure
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_lib_equip;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   
   public class Child_ListItem extends Sprite
   {
      
      private var text:MyTextField;
      
      public function Child_ListItem()
      {
         super();
         this.text = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":5,
            "realWidth":200
         });
         this.text.wordWrap = true;
         addChild(this.text);
      }
      
      public function update(str:String) : void
      {
         if(!str)
         {
            return;
         }
         var data:Array = str.split("_");
         var _type:int = int(data[2]);
         var _id:int = int(data[3]);
         if(_type == Enum_NationalTreasure.ITEM)
         {
            this.text.htmlText = "<font color = \'#f9ff00\'>" + data[0] + "</font>" + "寻得" + this.getColorStr(Data_lib.item[_id][Enum_lib_item.STR_NAME],Data_lib.item[_id][Enum_lib_item.COLOR]) + "*" + data[4];
         }
         else if(_type == Enum_NationalTreasure.EQUIP)
         {
            this.text.htmlText = "<font color = \'#f9ff00\'>" + data[0] + "</font>" + "寻得" + this.getColorStr(Data_lib.equip[_id][Enum_lib_equip.STR_NAME],Data_lib.equip[_id][Enum_lib_equip.COLOR]) + "*" + data[4];
         }
      }
      
      public function getColorStr(str:String, level:int = 1) : String
      {
         if(level == Enum_color.WHITE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.WHITE));
         }
         else if(level == Enum_color.GREEN)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.GREEN));
         }
         else if(level == Enum_color.BLUE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.BLUE));
         }
         else if(level == Enum_color.PURPLE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.PURPLE));
         }
         else if(level == Enum_color.ORANGE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.ORANGE));
         }
         else if(level == Enum_color.ANJIN)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.ANJIN));
         }
         return str;
      }
      
      override public function get height() : Number
      {
         if(!this.text)
         {
            return super.height;
         }
         return this.text.textHeight + 4;
      }
   }
}

