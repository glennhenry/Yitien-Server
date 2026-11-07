package com.yiTian.view.comp
{
   import com.event.TextField_h;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.text.TextFieldType;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_grid_extra extends Sprite
   {
      
      public static const DECOMPOSE:int = 0;
      
      public static const INTENSIFY:int = 1;
      
      public static const HOLE:int = 2;
      
      public static const GEM_COMPOSE:int = 3;
      
      public static const INLAY:int = 4;
      
      public static const UNLOAD:int = 5;
      
      public static const POLISH:int = 6;
      
      public static const INTEN_CHANGE:int = 7;
      
      public static const CZ_JINGLIAN:int = 8;
      
      public static const CZ_DIANHUA:int = 9;
      
      public var view_grid:View_Grid;
      
      private var dis_bg:ScaleBitmap;
      
      private var tf_name:TextField_h;
      
      private var tf_info:TextField_h;
      
      public var index:int;
      
      private var numBg:ScaleBitmap;
      
      private var Xtf:MyTextField;
      
      private var tfBought:MyTextField;
      
      private var numTF:MyTextField;
      
      private var _sellPrice:int;
      
      private var _type:int;
      
      public function View_grid_extra()
      {
         super();
         this.dis_bg = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":0,
            "y":0,
            "width":121,
            "height":42
         },Global.Img_Cdm);
         this.numBg = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":58,
            "y":16,
            "width":30,
            "height":20
         },Global.Img_Cdm);
         this.numTF = ComponentUtil.getTextField("1",this,{
            "x":59,
            "y":17,
            "realWidth":29,
            "realHeight":19,
            "align":TextAlign.CENTER,
            "maxChars":2
         });
         this.numTF.type = TextFieldType.INPUT;
         this.numTF.restrict = ".0-9";
         this.Xtf = ComponentUtil.getTextField("X",this,{
            "x":44,
            "y":17
         });
         this.tfBought = ComponentUtil.getTextField("",this,{
            "x":89,
            "y":17
         });
         this.tfBought.htmlText = HtmlUtil.link(HtmlUtil.underLine(HtmlUtil.font("购买","#ff7700")),"ss");
         this.tfBought.mouseEnabled = true;
         this.tfBought.addEventListener(TextEvent.LINK,this.link);
         this.tfBought.visible = false;
         this.numBg.visible = false;
         this.Xtf.visible = false;
         this.numTF.visible = false;
         this.tf_name = new TextField_h();
         addChild(this.tf_name);
         this.tf_info = new TextField_h();
         addChild(this.tf_info);
         this.view_grid = new View_Grid();
         this.view_grid.type = Enum_type_grid.CAST;
         this.view_grid.set_bmp_bg();
         this.view_grid.set_bmp_over();
         this.view_grid.set_bmp_select();
         this.view_grid.x = 2;
         addChild(this.view_grid);
      }
      
      public function setTypePri(arr:Array) : void
      {
         this._sellPrice = arr[0];
         this._type = arr[1];
      }
      
      private function link(e:TextEvent) : void
      {
         if(!UIManager.storeTip.visible)
         {
            UIManager.storeTip.visible = true;
         }
         UIManager.storeTip.update(this.view_grid.vo.id,int(this.numTF.text),3,16000,this._sellPrice,9999,this._type,this.view_grid.vo.str_name);
      }
      
      public function Show(vo:Vo_valuable, type:int = -1, tem_grid:View_Grid = null) : void
      {
         var str:String = null;
         var n:int = 0;
         var s:String = null;
         var data:Vo_equip = null;
         var temArr:Array = null;
         var i:int = 0;
         var _lv:int = 0;
         if(vo is Vo_item)
         {
            this.view_grid.set_tf_count(true,true,true);
         }
         else if(vo is Vo_equip)
         {
            this.view_grid.set_tf_count(true,false,false);
         }
         this.view_grid.set_bmp_select();
         this.view_grid.vo = vo;
         if(Boolean(tem_grid))
         {
            this.view_grid.index = tem_grid.index;
         }
         this.view_grid.set_tf_count();
         if(vo.color == Enum_color.WHITE)
         {
            str = ColorConstant.getColorStr(ColorConstant.WHITE);
         }
         else if(vo.color == Enum_color.GREEN)
         {
            str = ColorConstant.getColorStr(ColorConstant.GREEN);
         }
         else if(vo.color == Enum_color.BLUE)
         {
            str = ColorConstant.getColorStr(ColorConstant.BLUE);
         }
         else if(vo.color == Enum_color.PURPLE)
         {
            str = ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         else if(vo.color == Enum_color.ORANGE)
         {
            str = ColorConstant.getColorStr(ColorConstant.ORANGE);
         }
         else if(vo.color == Enum_color.ANJIN)
         {
            str = ColorConstant.getColorStr(ColorConstant.ANJIN);
         }
         var stName:String = vo.str_name;
         if(stName.length >= 7)
         {
            n = stName.length - 5;
            s = stName.slice(stName.length - n,stName.length);
            stName = stName.replace(s,"...");
         }
         str = HtmlUtil.font(stName,str);
         this.tf_name.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.WHITE));
         this.tf_info.visible = true;
         if(vo is Vo_equip)
         {
            data = vo as Vo_equip;
            temArr = [];
            if(Boolean(data.vec_gemId.length))
            {
               i = 0;
               while(i < data.vec_gemId.length)
               {
                  if(data.vec_gemId[i] != 0)
                  {
                     temArr.push(data.vec_gemId[i]);
                  }
                  i++;
               }
            }
            if(type == HOLE)
            {
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("727",0) + temArr.length + "/" + data.cur_hole,ColorConstant.getColorStr(ColorConstant.WHITE));
            }
            else if(type == INTENSIFY)
            {
               _lv = data.lv;
               if(_lv >= 11 && _lv < 22)
               {
                  _lv = data.lv - 1;
               }
               else if(_lv >= 22)
               {
                  _lv = data.lv - 2;
               }
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("728",0) + _lv,ColorConstant.getColorStr(ColorConstant.WHITE));
            }
            else if(type == INLAY)
            {
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("729",0) + (data.cur_hole - data.vec_gemId.length),ColorConstant.getColorStr(ColorConstant.WHITE));
            }
            else if(type == UNLOAD)
            {
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("730",0) + data.vec_gemId.length,ColorConstant.getColorStr(ColorConstant.WHITE));
            }
            else if(type == POLISH)
            {
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("731",0) + data.vec_extend.length / 4,ColorConstant.getColorStr(ColorConstant.WHITE));
            }
            else if(type == CZ_DIANHUA)
            {
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("731",0) + data.vec_extend.length / 4,ColorConstant.getColorStr(ColorConstant.WHITE));
            }
            else if(type == DECOMPOSE)
            {
               if(temArr.length > 0)
               {
                  this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("732",0),ColorConstant.getColorStr(ColorConstant.WHITE));
               }
               else
               {
                  this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("733",0),ColorConstant.getColorStr(ColorConstant.WHITE));
               }
            }
            else if(type == CZ_JINGLIAN)
            {
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("950",0) + "+" + data.jingLianCount,ColorConstant.getColorStr(ColorConstant.WHITE));
            }
         }
         else if(vo is Vo_item)
         {
            if(type == GEM_COMPOSE)
            {
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("734",0) + (vo as Vo_item).count,ColorConstant.getColorStr(ColorConstant.WHITE));
            }
            else if(type == DECOMPOSE)
            {
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("735",0),ColorConstant.getColorStr(ColorConstant.WHITE));
            }
            else if(type == -2)
            {
               this.tf_info.visible = false;
               this.tfBought.visible = true;
               this.numBg.visible = true;
               this.Xtf.visible = true;
               this.numTF.visible = true;
               this.view_grid.set_tf_count(false,false,false);
            }
            else
            {
               this.tf_info.htmlText = "";
            }
         }
         this.tf_info.x = this.tf_name.x = this.view_grid.x + Const_png.SIZE_GRID;
         this.tf_name.y = -2;
         this.dis_bg.x = -2;
         this.dis_bg.y = -4;
         this.tf_info.y = this.tf_name.y + this.tf_name.height;
      }
      
      protected function LINK(event:TextEvent) : void
      {
         trace("购买");
      }
   }
}

