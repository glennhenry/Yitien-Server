package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_bangStoreItems extends Sprite
   {
      
      private var Button_Buy:Button;
      
      private var Price_text:MyTextField;
      
      private var Num_text:MyTextField;
      
      private var IconName_text:MyTextField;
      
      public var grid:View_Grid;
      
      private var _data:Object;
      
      public function View_bangStoreItems()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         var back1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":0,
            "y":0,
            "width":170,
            "height":74
         },Global.Img_Cdm);
         var back2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":90,
            "y":27,
            "width":48,
            "height":20
         },Global.Img_Cdm);
         var back3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":90,
            "y":49,
            "width":48,
            "height":20
         },Global.Img_Cdm);
         var tf1:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("60032",6),this,{
            "x":55,
            "y":27,
            "color":11904647,
            "size":12,
            "leading":0
         });
         var tf2:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("60033",6),this,{
            "x":55,
            "y":49,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.Button_Buy = ComponentUtil.getButton(LangConfig.getWord("29184",2),"Button_Two",this,{
            "x":5,
            "y":46,
            "textColor":16773818,
            "enabled":false
         },Global.Img_Cdm);
         this.Price_text = ComponentUtil.getTextField("0000",this,{
            "x":98,
            "y":27,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.Num_text = ComponentUtil.getTextField("0000",this,{
            "x":98,
            "y":49,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.IconName_text = ComponentUtil.getTextField("name",this,{
            "x":55,
            "y":5,
            "color":6666344,
            "size":12,
            "leading":0
         });
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.x = 10;
         this.grid.y = 6;
         this.grid.type = Enum_type_grid.NO_DRAG;
         addChild(this.grid);
         this.Button_Buy.callBack = this.buyClickHandle;
      }
      
      public function set vo(value:Object) : void
      {
         var str:String = null;
         var type:int = 0;
         var str1:String = null;
         var gridVO:Vo_item = null;
         if(Boolean(value))
         {
            if(value.itemSellCount > 0)
            {
               this.Button_Buy.enabled = true;
            }
            else
            {
               this.Button_Buy.enabled = false;
            }
            this.Price_text.text = value.itemPrice.toString();
            this.Num_text.text = value.itemSellCount.toString();
            this._data = value;
            str = Data_lib.item[this._data.itemId][Enum_lib_item.STR_NAME];
            type = int(Data_lib.item[this._data.itemId][Enum_lib_item.COLOR]);
            if(type == Enum_color.WHITE)
            {
               str1 = ColorConstant.getColorStr(ColorConstant.WHITE);
            }
            else if(type == Enum_color.GREEN)
            {
               str1 = ColorConstant.getColorStr(ColorConstant.GREEN);
            }
            else if(type == Enum_color.BLUE)
            {
               str1 = ColorConstant.getColorStr(ColorConstant.BLUE);
            }
            else if(type == Enum_color.PURPLE)
            {
               str1 = ColorConstant.getColorStr(ColorConstant.PURPLE);
            }
            this.IconName_text.htmlText = HtmlUtil.font(str,str1,12);
            gridVO = new Vo_item();
            gridVO.id = this._data.itemId;
            gridVO.Init_lib();
            this.grid.vo = gridVO;
         }
         else
         {
            this.Button_Buy.enabled = false;
            this.IconName_text.text = "";
            this.Price_text.text = "";
            this.Num_text.text = "";
            this.grid.vo = null;
            this._data = null;
         }
      }
      
      public function buyClickHandle(e:MouseEvent) : void
      {
         UIManager.bang_store_prompt.type = "banghui";
         if(!UIManager.bang_store_prompt.visible)
         {
            UIManager.bang_store_prompt.show(this._data);
         }
         UIManager.bang_store_prompt.parent.setChildIndex(UIManager.bang_store_prompt,UIManager.bang_store_prompt.parent.numChildren - 1);
      }
   }
}

