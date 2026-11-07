package com.yiTian.view.modules.tip.tips
{
   import com.event.TextField_h;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_lib_attribute;
   import com.yiTian.data.config.valuable.Enum_lib_equip;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.config.valuable.Enum_lib_tz;
   import com.yiTian.data.model.Model_equipTips;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.newRolePan.ComparePan;
   import com.yiTian.view.modules.role.Enum_role_equip;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class View_Equip extends View_tip
   {
      
      private static var indent_value:int;
      
      private static var sz_value:int;
      
      private static var NONLEARN:String;
      
      private static var NONJOP:String;
      
      private static const GAP_WIDTH:int = 3;
      
      private static const GAP_HEIGHT:int = 0;
      
      private static const SIZE_TF_NAME:int = 14;
      
      private static const GAP_BMP:int = 2;
      
      private static const INDENT:int = 10;
      
      private static const COLOR:String = "#999999";
      
      private var tf_name:TextField_h;
      
      private var tf_type:TextField_h;
      
      private var tf_typeC:TextField_h;
      
      private var tf_bind:TextField_h;
      
      private var tf_basic_label:TextField_h;
      
      private var tf_basic1:TextField_h;
      
      private var tf_basic2:TextField_h;
      
      private var tf_intensify_label:TextField_h;
      
      private var tf_intensify1:TextField_h;
      
      private var tf_intensify2:TextField_h;
      
      private var tf_cz_insten_label:TextField_h;
      
      private var tf_cz_insten:TextField_h;
      
      private var tf_extend_skill_label:TextField_h;
      
      private var tf_extend_skill:TextField_h;
      
      private var tf_extend_label:TextField_h;
      
      private var tf_extend1:TextField_h;
      
      private var tf_extend2:TextField_h;
      
      private var tf_extend3:TextField_h;
      
      private var tf_hole_label:TextField_h;
      
      private var tf_gem_label:TextField_h;
      
      private var tf_gem1:MyTextField;
      
      private var tf_gem2:TextField_h;
      
      private var tf_bszy_label:TextField_h;
      
      private var tf_bszy:TextField_h;
      
      private var tf_tz:TextField_h;
      
      private var tf_describe:TextField_h;
      
      private var szTimeTf:TextField_h;
      
      private var szTimelabel:TextField_h;
      
      private var tf_price:TextField_h;
      
      private var bmp_iconFrame:Bitmap;
      
      private var bmp_iconBg:Bitmap;
      
      private var bmp_icon:Bitmap;
      
      private var vec_bmpLv:Vector.<Bitmap>;
      
      private var vec_bmpGem:Vector.<Bitmap>;
      
      private var vec_new_bmpGem:Vector.<Bitmap>;
      
      private var vec_stone_bmpGem:Vector.<Bitmap>;
      
      private var vec_gem_nameTxt:Vector.<MyTextField>;
      
      private var vec_gem_valueTxt:Vector.<TextField_h>;
      
      private var vec_gem_value2Txt:Vector.<TextField_h>;
      
      private var vec_idTz:Vector.<int>;
      
      private var vo:Vo_equip;
      
      private var vec_dis_x:Vector.<DisplayObject>;
      
      private var vec_dis_y:Vector.<DisplayObject>;
      
      private var i:int;
      
      private var str:String;
      
      private var str2:String;
      
      private var str3:String;
      
      private var imgCon:Sprite;
      
      private var tf_basic_colone:TextField_h;
      
      private var __PosY:int;
      
      private var tipType:int;
      
      private var stoneLevel:int = 0;
      
      private var skillName:String;
      
      private var newGemShowNum:int = 0;
      
      private var gemAdjustIdex:int = 0;
      
      private var isfirstGem:Boolean = false;
      
      private var vec_id_tz:Vector.<int>;
      
      private var _matchStr:Array = ["头","服","腰","子","护"];
      
      public function View_Equip()
      {
         super();
      }
      
      override public function Init() : void
      {
         var _posY:int = 0;
         var indent_value_copy:int = 0;
         addBorder();
         this.tf_name = new TextField_h();
         addChild(this.tf_name);
         this.tf_type = new TextField_h();
         addChild(this.tf_type);
         this.tf_typeC = new TextField_h();
         addChild(this.tf_typeC);
         this.tf_type.set_TextFormat_leading();
         this.tf_bind = new TextField_h();
         addChild(this.tf_bind);
         this.tf_bind.set_TextFormat_leading();
         this.tf_basic_label = new TextField_h();
         addChild(this.tf_basic_label);
         this.tf_basic1 = new TextField_h();
         addChild(this.tf_basic1);
         this.tf_basic1.set_TextFormat_leading();
         this.tf_basic2 = new TextField_h();
         addChild(this.tf_basic2);
         this.tf_basic2.set_TextFormat_leading();
         this.tf_intensify_label = new TextField_h();
         addChild(this.tf_intensify_label);
         this.tf_intensify1 = new TextField_h();
         addChild(this.tf_intensify1);
         this.tf_intensify1.set_TextFormat_leading();
         this.tf_intensify2 = new TextField_h();
         addChild(this.tf_intensify2);
         this.tf_intensify2.set_TextFormat_leading();
         this.tf_extend_label = new TextField_h();
         addChild(this.tf_extend_label);
         this.tf_extend1 = new TextField_h();
         addChild(this.tf_extend1);
         this.tf_extend1.set_TextFormat_leading();
         this.tf_extend2 = new TextField_h();
         addChild(this.tf_extend2);
         this.tf_extend2.set_TextFormat_leading();
         this.tf_extend3 = new TextField_h();
         addChild(this.tf_extend3);
         this.tf_extend3.set_TextFormat_leading();
         this.tf_hole_label = new TextField_h();
         addChild(this.tf_hole_label);
         this.tf_bszy_label = new TextField_h();
         addChild(this.tf_bszy_label);
         this.tf_gem_label = new TextField_h();
         addChild(this.tf_gem_label);
         this.tf_gem1 = ComponentUtil.getTextField("",this,{
            "width":129,
            "realWidth":128,
            "leading":4,
            "multiline":true,
            "wordWrap":true
         });
         this.tf_gem2 = new TextField_h();
         addChild(this.tf_gem2);
         this.tf_gem2.set_TextFormat_leading();
         this.tf_bszy = new TextField_h();
         addChild(this.tf_bszy);
         this.tf_bszy.set_TextFormat_leading();
         this.tf_tz = new TextField_h();
         addChild(this.tf_tz);
         this.tf_tz.set_TextFormat_leading();
         this.szTimelabel = new TextField_h();
         addChild(this.szTimelabel);
         this.szTimeTf = new TextField_h();
         addChild(this.szTimeTf);
         this.szTimeTf.set_TextFormat_leading();
         this.tf_describe = new TextField_h();
         addChild(this.tf_describe);
         this.tf_price = new TextField_h();
         addChild(this.tf_price);
         this.tf_price.set_TextFormat_leading();
         this.tf_price.multiline = true;
         this.tf_price.wordWrap = true;
         this.tf_price.width = 170;
         this.tf_cz_insten_label = new TextField_h();
         addChild(this.tf_cz_insten_label);
         this.tf_cz_insten = new TextField_h();
         addChild(this.tf_cz_insten);
         this.tf_cz_insten.set_TextFormat_leading();
         this.tf_extend_skill_label = new TextField_h();
         addChild(this.tf_extend_skill_label);
         this.tf_extend_skill = new TextField_h();
         addChild(this.tf_extend_skill);
         this.tf_extend_skill.set_TextFormat_leading();
         this.bmp_iconFrame = Utils.getLoadBitmap(View_Grid.GRID_OPEN);
         addChild(this.bmp_iconFrame);
         this.bmp_iconBg = new Bitmap();
         addChild(this.bmp_iconBg);
         this.bmp_icon = new Bitmap();
         addChild(this.bmp_icon);
         this.vec_idTz = new Vector.<int>();
         this.vec_id_tz = new Vector.<int>();
         this.tf_basic_label.htmlText = HtmlUtil.font(LangConfig.getWord("758",0),ColorConstant.getColorStr(ColorConstant.WHITE));
         this.tf_intensify_label.htmlText = HtmlUtil.font(LangConfig.getWord("759",0),ColorConstant.getColorStr(ColorConstant.YELLOW));
         this.tf_cz_insten_label.htmlText = HtmlUtil.font(LangConfig.getWord("948",0),ColorConstant.getColorStr(ColorConstant.YELLOW));
         this.tf_extend_skill_label.htmlText = HtmlUtil.font(LangConfig.getWord("949",0),ColorConstant.getColorStr(ColorConstant.YELLOW));
         this.tf_extend_label.htmlText = HtmlUtil.font(LangConfig.getWord("731",0),ColorConstant.getColorStr(ColorConstant.ORANGE));
         this.tf_hole_label.htmlText = HtmlUtil.font(LangConfig.getWord("760",0),ColorConstant.getColorStr(ColorConstant.ORANGE));
         this.tf_bszy_label.htmlText = HtmlUtil.font(LangConfig.getWord("1143",0),ColorConstant.getColorStr(ColorConstant.ORANGE));
         this.tf_gem_label.htmlText = HtmlUtil.font(LangConfig.getWord("761",0),ColorConstant.getColorStr(ColorConstant.ORANGE));
         this.szTimelabel.htmlText = HtmlUtil.font(LangConfig.getWord("60310",6),ColorConstant.getColorStr(ColorConstant.ORANGE));
         sz_value = INDENT + this.szTimelabel.width;
         indent_value = INDENT + this.tf_basic_label.width;
         this.tf_name.x = INDENT;
         this.tf_name.y = 5;
         this.tf_name.htmlText = HtmlUtil.font("0",ColorConstant.getColorStr(ColorConstant.WHITE),SIZE_TF_NAME);
         this.vec_bmpLv = new Vector.<Bitmap>(Vo_equip.MAX_LV_INTENSIFY,true);
         this.i = 0;
         while(this.i < Vo_equip.MAX_LV_INTENSIFY)
         {
            this.vec_bmpLv[this.i] = new Bitmap();
            addChild(this.vec_bmpLv[this.i]);
            this.vec_bmpLv[this.i].x = INDENT + this.i * (Const_png.SIZE_STAR + 2);
            this.vec_bmpLv[this.i].y = this.tf_name.y + this.tf_name.height + GAP_BMP;
            ++this.i;
         }
         this.bmp_iconBg.x = this.bmp_icon.x = INDENT + GAP_BMP + 7.6;
         this.__PosY = this.vec_bmpLv[0].y + Const_png.SIZE_STAR + 2 * GAP_BMP + 1;
         this.bmp_icon.y = this.vec_bmpLv[0].y + Const_png.SIZE_STAR + 2 * GAP_BMP + 3 + 13;
         this.bmp_icon.y = this.bmp_iconBg.y = this.__PosY + 31;
         this.bmp_iconFrame.y = this.__PosY - 3 + 31;
         this.bmp_iconFrame.x = this.bmp_iconBg.x - 3;
         _posY = this.__PosY - 3;
         this.tf_type.x = this.bmp_iconFrame.x + 46;
         this.tf_type.y = _posY;
         this.tf_bind.x = INDENT;
         this.tf_bind.y = _posY + Const_png.SIZE_GRID + GAP_BMP + GAP_HEIGHT;
         this.tf_basic_label.x = INDENT;
         this.tf_basic1.x = indent_value;
         this.tf_intensify_label.x = INDENT;
         this.tf_intensify1.x = indent_value;
         this.tf_cz_insten_label.x = INDENT;
         this.tf_cz_insten.x = indent_value;
         this.tf_extend_skill_label.x = INDENT;
         this.tf_extend_skill.x = indent_value;
         this.tf_extend_label.x = INDENT;
         this.tf_extend1.x = indent_value;
         indent_value_copy = INDENT + this.tf_bszy_label.width;
         this.tf_hole_label.x = INDENT;
         this.tf_bszy_label.x = INDENT;
         this.tf_bszy.x = indent_value_copy;
         this.vec_bmpGem = new Vector.<Bitmap>(Vo_equip.MAX_HOLE,true);
         this.vec_new_bmpGem = new Vector.<Bitmap>(Vo_equip.MAX_HOLE,true);
         this.vec_stone_bmpGem = new Vector.<Bitmap>(Vo_equip.MAX_HOLE,true);
         this.vec_gem_nameTxt = new Vector.<MyTextField>(Vo_equip.MAX_HOLE,true);
         this.vec_gem_valueTxt = new Vector.<TextField_h>(Vo_equip.MAX_HOLE,true);
         this.vec_gem_value2Txt = new Vector.<TextField_h>(Vo_equip.MAX_HOLE,true);
         this.i = 0;
         while(this.i < Vo_equip.MAX_HOLE)
         {
            this.vec_bmpGem[this.i] = new Bitmap();
            addChild(this.vec_bmpGem[this.i]);
            this.vec_bmpGem[this.i].x = indent_value + this.i * (Const_png.SIZE_GEM + GAP_WIDTH);
            this.vec_new_bmpGem[this.i] = new Bitmap();
            addChild(this.vec_new_bmpGem[this.i]);
            this.vec_new_bmpGem[this.i].x = indent_value;
            this.vec_stone_bmpGem[this.i] = new Bitmap();
            addChild(this.vec_stone_bmpGem[this.i]);
            this.vec_stone_bmpGem[this.i].x = this.vec_new_bmpGem[this.i].x + 2;
            this.vec_gem_nameTxt[this.i] = ComponentUtil.getTextField("",this,{
               "width":129,
               "realWidth":128,
               "leading":4,
               "multiline":true,
               "wordWrap":true
            });
            this.vec_gem_nameTxt[this.i].x = indent_value + 30;
            this.vec_gem_valueTxt[this.i] = new TextField_h();
            this.vec_gem_valueTxt[this.i].x = indent_value;
            this.vec_gem_valueTxt[this.i].width = 84;
            addChild(this.vec_gem_valueTxt[this.i]);
            this.vec_gem_valueTxt[this.i].set_TextFormat_leading();
            this.vec_gem_value2Txt[this.i] = new TextField_h();
            this.vec_gem_value2Txt[this.i].x = indent_value + 84;
            addChild(this.vec_gem_value2Txt[this.i]);
            this.vec_gem_value2Txt[this.i].set_TextFormat_leading();
            ++this.i;
         }
         this.tf_gem_label.x = INDENT;
         this.tf_gem1.x = indent_value;
         this.tf_describe.x = INDENT;
         this.tf_describe.wordWrap = true;
         this.tf_describe.multiline = true;
         this.tf_price.x = INDENT;
         this.szTimelabel.x = INDENT;
         this.szTimeTf.x = sz_value;
         this.tf_tz.x = INDENT;
         this.vec_dis_x = new Vector.<DisplayObject>();
         this.vec_dis_x.push(this.tf_name,this.vec_bmpLv[Vo_equip.MAX_LV_INTENSIFY - 1],this.tf_basic2,this.tf_intensify2,this.tf_cz_insten,this.tf_extend_skill,this.tf_extend2,this.tf_extend3,this.tf_gem2,this.tf_gem_label,this.tf_tz);
         this.vec_dis_y = new Vector.<DisplayObject>();
         this.vec_dis_y.push(Boolean(this.tf_basic_colone) ? this.tf_basic_colone : this.tf_basic1,this.tf_intensify1,this.tf_cz_insten,this.tf_extend_skill,this.tf_extend1,this.vec_bmpGem[Vo_equip.MAX_HOLE - 1],this.tf_gem_label,this.tf_bszy,this.tf_tz,this.tf_describe,this.szTimeTf,this.tf_price);
         this.imgCon = new Sprite();
         addChild(this.imgCon);
      }
      
      override public function Show($vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var __weiTiaoN:int = 0;
         while(Boolean(this.imgCon.numChildren))
         {
            this.imgCon.removeChildAt(0);
         }
         visible = true;
         this.bmp_icon.bitmapData = null;
         this.bmp_iconBg.bitmapData = null;
         this.vo = $vo as Vo_equip;
         this.tipType = type;
         this.stoneLevel = stoneLvl;
         if(this.vo.color == Enum_color.WHITE)
         {
            this.str = ColorConstant.getColorStr(ColorConstant.WHITE);
         }
         else if(this.vo.color == Enum_color.GREEN)
         {
            this.str = ColorConstant.getColorStr(ColorConstant.GREEN);
         }
         else if(this.vo.color == Enum_color.BLUE)
         {
            this.str = ColorConstant.getColorStr(ColorConstant.BLUE);
         }
         else if(this.vo.color == Enum_color.PURPLE)
         {
            this.str = ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         else if(this.vo.color == Enum_color.ORANGE)
         {
            this.str = ColorConstant.getColorStr(ColorConstant.ORANGE);
         }
         else if(this.vo.color == Enum_color.ANJIN)
         {
            this.str = ColorConstant.getColorStr(ColorConstant.ANJIN);
         }
         this.str = HtmlUtil.font(this.vo.str_name,this.str,SIZE_TF_NAME);
         this.tf_name.htmlText = this.str;
         this.show_lv_intensify(this.vo.lv,this.str);
         Utils.getLoadBitmap("resource/image/icon/" + this.vo.str_icon + ".png",this.bmp_icon);
         Utils.getLoadBitmap("resource/image/iconBg/" + this.vo.bgIndex + ".png",this.bmp_iconBg);
         if(this.vo.bBind)
         {
            this.str = " " + HtmlUtil.fontBr(LangConfig.getWord("755",0),ColorConstant.getColorStr(ColorConstant.RED));
            __weiTiaoN = 0;
         }
         else
         {
            this.str = " " + HtmlUtil.fontBr("未绑定",ColorConstant.getColorStr(ColorConstant.GREEN));
            __weiTiaoN = 0;
         }
         this.tf_typeC.htmlText = this.str;
         this.str = "";
         if(this.vo.job <= 0)
         {
            this.str += "\n";
         }
         else
         {
            this.str += HtmlUtil.font(LangConfig.getWord("764",0),ColorConstant.getColorStr(ColorConstant.WHITE));
            if(this.vo.job != 5 && Enum_job.getBaseJob(GameUnitManager.hero.job) != this.vo.job)
            {
               this.str += HtmlUtil.fontBr(Enum_job.TXT[this.vo.job - 1],ColorConstant.getColorStr(ColorConstant.RED));
            }
            else
            {
               this.str += HtmlUtil.fontBr(Enum_job.TXT[this.vo.job - 1],ColorConstant.getColorStr(ColorConstant.WHITE));
            }
         }
         if(this.vo.lv_use <= 0)
         {
            this.str += "\n";
         }
         else
         {
            this.str += HtmlUtil.font("等级：",ColorConstant.getColorStr(ColorConstant.WHITE));
            if(this.vo.lv_use > GameUnitManager.hero.level)
            {
               this.str += HtmlUtil.font(this.vo.lv_use.toString(),ColorConstant.getColorStr(ColorConstant.RED)) + "\n";
            }
            else
            {
               this.str += HtmlUtil.font(this.vo.lv_use.toString(),ColorConstant.getColorStr(ColorConstant.WHITE)) + "\n";
            }
         }
         if(this.vo.max_nj >= 0)
         {
            this.str += HtmlUtil.font(LangConfig.getWord("765",0),ColorConstant.getColorStr(ColorConstant.WHITE));
            if(this.vo.type == 11)
            {
               this.str += "无限制";
            }
            else if(this.vo.cur_nj < Vo_equip.WARNING_NJ)
            {
               this.str += HtmlUtil.fontBr(this.vo.cur_nj + "/" + this.vo.max_nj,ColorConstant.getColorStr(ColorConstant.RED));
            }
            else
            {
               this.str += HtmlUtil.fontBr(this.vo.cur_nj + "/" + this.vo.max_nj,ColorConstant.getColorStr(ColorConstant.WHITE));
            }
         }
         this.tf_bind.htmlText = this.str;
         this.tf_bind.x = this.tf_type.x + 13;
         this.tf_bind.y = this.tf_type.y + 15 - __weiTiaoN - 12;
         Model_equipTips.getModel(int(this.vo.bDress)).showBdress(this.vo.bDress,new Point(this.tf_bind.x + 83,this.tf_bind.y),this.imgCon);
         this.bmp_icon.y = this.bmp_iconBg.y = this.tf_bind.y + 8;
         this.bmp_iconFrame.y = this.bmp_icon.y - 3;
         this.tf_typeC.x = this.tf_bind.x + 85;
         this.tf_typeC.y = this.tf_bind.y + 35;
         this.getBasic();
         this.getIntensify();
         this.getCZ();
         this.getExtend();
         this.show_gem();
         this.getNewGem();
         this.getStoneZY();
         this.getTz(type);
         if(this.vo.str_describe != "0")
         {
            this.tf_describe.htmlText = HtmlUtil.font(this.vo.str_describe,ColorConstant.getColorStr(ColorConstant.YELLOW_SAND));
            this.tf_describe.visible = true;
         }
         else
         {
            this.tf_describe.visible = false;
         }
         this.getSzT();
         this.getPrice();
         this.setPos();
      }
      
      private function setPos() : void
      {
         var m:int = 0;
         var max_x:int = 0;
         var temp_x:int = 0;
         var max_y:int = this.tf_bind.y + this.tf_bind.height + GAP_HEIGHT;
         this.i = 0;
         while(this.i < this.vec_dis_x.length)
         {
            if(this.vec_dis_x[this.i].visible)
            {
               if(max_x < this.vec_dis_x[this.i].x + this.vec_dis_x[this.i].width)
               {
                  if(this.vec_dis_x[this.i] == this.vec_bmpLv[Vo_equip.MAX_LV_INTENSIFY - 1])
                  {
                     max_x = this.vec_dis_x[this.i].x + Const_png.SIZE_STAR;
                  }
                  else
                  {
                     max_x = this.vec_dis_x[this.i].x + this.vec_dis_x[this.i].width;
                  }
               }
               if(this.vec_dis_x[this.i] == this.tf_gem_label)
               {
                  m = 0;
                  while(m < Vo_equip.MAX_HOLE)
                  {
                     if(this.vec_gem_value2Txt[m].visible)
                     {
                        temp_x = this.vec_gem_value2Txt[m].x + this.vec_gem_value2Txt[m].width + GAP_BMP;
                        if(temp_x > max_x)
                        {
                           max_x = temp_x;
                        }
                     }
                     else if(this.vec_gem_valueTxt[m].visible)
                     {
                        temp_x = this.vec_gem_valueTxt[m].x + this.vec_gem_valueTxt[m].width + 2 * GAP_BMP;
                        if(temp_x > max_x)
                        {
                           max_x = temp_x;
                        }
                     }
                     m++;
                  }
               }
            }
            ++this.i;
         }
         this.tf_describe.width = max_x - this.tf_describe.x;
         this.i = 0;
         while(this.i < this.vec_dis_y.length)
         {
            if(this.vec_dis_y[this.i].visible)
            {
               if(this.vec_dis_y[this.i] == this.vec_bmpGem[Vo_equip.MAX_HOLE - 1])
               {
                  this.vec_dis_y[this.i].y = max_y + GAP_BMP;
                  max_y += Const_png.SIZE_GEM + 2 * GAP_BMP + GAP_HEIGHT;
               }
               else if(this.vec_dis_y[this.i] == this.tf_gem_label)
               {
                  max_y += 41 * this.newGemShowNum + 2;
               }
               else
               {
                  this.vec_dis_y[this.i].y = max_y;
                  if(this.vec_dis_y[this.i] == this.tf_extend1 && !this.tf_extend_skill_label.visible)
                  {
                     this.tf_extend1.y -= 10;
                     max_y -= 10;
                  }
                  max_y += this.vec_dis_y[this.i].height + GAP_HEIGHT;
               }
            }
            ++this.i;
         }
         this.tf_basic_label.y = this.tf_basic2.y = this.tf_basic1.y;
         this.tf_intensify2.y = this.tf_intensify_label.y = this.tf_intensify1.y;
         this.tf_cz_insten_label.y = this.tf_cz_insten.y;
         this.tf_extend_skill_label.y = this.tf_extend_skill.y;
         this.tf_extend2.y = this.tf_extend_label.y = this.tf_extend1.y;
         this.tf_extend3.y = this.tf_extend_label.y = this.tf_extend1.y;
         this.szTimelabel.y = this.szTimeTf.y;
         this.tf_bszy_label.y = this.tf_bszy.y;
         var adjust:int = 0;
         this.i = 0;
         while(this.i < Vo_equip.MAX_HOLE)
         {
            if(this.i < Vo_equip.MAX_HOLE - 1)
            {
               this.vec_bmpGem[this.i].y = this.vec_bmpGem[Vo_equip.MAX_HOLE - 1].y;
            }
            if(this.vec_new_bmpGem[this.i].visible)
            {
               this.vec_new_bmpGem[this.i].y = this.vec_bmpGem[this.i].y + 20 + 41 * adjust;
               adjust++;
            }
            this.vec_stone_bmpGem[this.i].y = this.vec_new_bmpGem[this.i].y + 2;
            this.vec_gem_nameTxt[this.i].y = this.vec_new_bmpGem[this.i].y;
            this.vec_gem_valueTxt[this.i].y = this.vec_new_bmpGem[this.i].y + 20;
            this.vec_gem_value2Txt[this.i].y = this.vec_gem_valueTxt[this.i].y;
            ++this.i;
         }
         this.tf_hole_label.y = this.vec_bmpGem[Vo_equip.MAX_HOLE - 1].y - 3;
         this.tf_gem2.y = this.tf_gem_label.y = this.tf_gem1.y;
         this.tf_gem_label.y = this.vec_new_bmpGem[this.gemAdjustIdex].y;
         border.width = max_x + INDENT;
         border.width = Math.max(border.width,this.tf_typeC.x + this.tf_typeC.width + 3);
         Model_equipTips.getModel(int(this.vo.bDress)).resizeAlign(border.width);
         border.height = max_y + 5;
      }
      
      private function getAttribute(id_attribute:int, value:int, valueExtral:int = 0) : String
      {
         if(this.vo.type != 11)
         {
            if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
            {
               return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + " +" + value + "";
            }
            if(id_attribute == 10)
            {
               return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + " +" + value + "";
            }
            return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + " +" + value + "%";
         }
         if(this.vo.daoTime != -2)
         {
            if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
            {
               return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREEN)) + " +" + value + "";
            }
            if(id_attribute == 10)
            {
               return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREEN)) + " +" + value + "";
            }
            return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREEN)) + " +" + value + "%";
         }
         if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
         {
            return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font(" +" + value.toString(),ColorConstant.getColorStr(ColorConstant.GREY)) + "";
         }
         if(id_attribute == 10)
         {
            return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font(" +" + value.toString(),ColorConstant.getColorStr(ColorConstant.GREY)) + "";
         }
         return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font(" +" + value.toString(),ColorConstant.getColorStr(ColorConstant.GREY)) + "%";
      }
      
      private function getBasic() : void
      {
         if(this.vo.vec_basic.length == 0)
         {
            this.tf_basic_label.visible = false;
            this.tf_basic1.visible = false;
            this.tf_basic2.visible = false;
            return;
         }
         this.tf_basic_label.visible = true;
         this.tf_basic1.visible = true;
         this.tf_basic1.visible = true;
         this.str = "";
         this.str2 = "";
         this.i = 0;
         if(this.vo.type != 11)
         {
            while(this.i < this.vo.vec_basic.length)
            {
               if(this.i != 0)
               {
                  this.str += "\n";
                  this.str2 += "\n";
               }
               this.str += HtmlUtil.font(this.getAttribute(this.vo.vec_basic[this.i],this.vo.vec_basic[this.i + 1]),ColorConstant.getColorStr(ColorConstant.WHITE));
               if(this.vo.vec_basic[this.i + 2] > 0)
               {
                  if(Data_lib.attribute[this.vo.vec_basic[this.i]][Enum_lib_attribute.TYPE] == 2)
                  {
                     this.str2 += HtmlUtil.font("+" + this.vo.vec_basic[this.i + 2] + "%",ColorConstant.getColorStr(ColorConstant.YELLOW));
                  }
                  else
                  {
                     this.str2 += HtmlUtil.font("+" + this.vo.vec_basic[this.i + 2],ColorConstant.getColorStr(ColorConstant.YELLOW));
                  }
               }
               this.i += 3;
            }
         }
         else if(this.vo.daoTime != -2)
         {
            while(this.i < this.vo.vec_basic.length)
            {
               if(this.i != 0)
               {
                  this.str += "\n";
                  this.str2 += "\n";
               }
               this.str += HtmlUtil.font(LangConfig.getWord("60311",6),ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font(this.getAttribute(this.vo.vec_basic[this.i],this.vo.vec_basic[this.i + 1]),ColorConstant.getColorStr(ColorConstant.YELLOW));
               if(this.vo.vec_basic[this.i + 2] > 0)
               {
                  if(Data_lib.attribute[this.vo.vec_basic[this.i]][Enum_lib_attribute.TYPE] == 2)
                  {
                     this.str2 += HtmlUtil.font(LangConfig.getWord("60311",6),ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font("+" + this.vo.vec_basic[this.i + 2] + "%",ColorConstant.getColorStr(ColorConstant.YELLOW));
                  }
                  else
                  {
                     this.str2 += HtmlUtil.font(LangConfig.getWord("60311",6),ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font("+" + this.vo.vec_basic[this.i + 2],ColorConstant.getColorStr(ColorConstant.YELLOW));
                  }
               }
               this.i += 3;
            }
         }
         else
         {
            while(this.i < this.vo.vec_basic.length)
            {
               if(this.i != 0)
               {
                  this.str += "\n";
                  this.str2 += "\n";
               }
               this.str += HtmlUtil.font(LangConfig.getWord("60311",6),ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font(this.getAttribute(this.vo.vec_basic[this.i],this.vo.vec_basic[this.i + 1]),ColorConstant.getColorStr(ColorConstant.GREY));
               if(this.vo.vec_basic[this.i + 2] > 0)
               {
                  if(Data_lib.attribute[this.vo.vec_basic[this.i]][Enum_lib_attribute.TYPE] == 2)
                  {
                     this.str2 += HtmlUtil.font(LangConfig.getWord("60311",6),ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font("+" + this.vo.vec_basic[this.i + 2] + "%",ColorConstant.getColorStr(ColorConstant.GREY));
                  }
                  else
                  {
                     this.str2 += HtmlUtil.font(LangConfig.getWord("60311",6),ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font("+" + this.vo.vec_basic[this.i + 2],ColorConstant.getColorStr(ColorConstant.GREY));
                  }
               }
               this.i += 3;
            }
         }
         this.tf_basic1.htmlText = this.str;
         this.tf_basic2.x = this.tf_basic1.x + this.tf_basic1.width + GAP_WIDTH;
         this.tf_basic2.htmlText = this.str2;
         if(this.tf_basic1.height > this.tf_basic2.height)
         {
            this.tf_basic_colone = this.tf_basic1;
         }
         else
         {
            this.tf_basic_colone = this.tf_basic2;
         }
      }
      
      private function getCZ() : void
      {
         var value:int = 0;
         var per:Number = NaN;
         var vv:int = 0;
         NONLEARN = LangConfig.getWord("60312",6);
         NONJOP = LangConfig.getWord("60313",6);
         if(this.vo.color < 5)
         {
            this.tf_cz_insten_label.visible = false;
            this.tf_extend_skill_label.visible = false;
            this.tf_cz_insten.htmlText = "";
            this.tf_extend_skill.htmlText = "";
         }
         else
         {
            this.skillName = this.vo.skillId == 0 ? "" : Data_lib.skill[this.vo.skillId][1];
            this.tf_cz_insten_label.visible = true;
            this.tf_extend_skill_label.visible = true;
            this.tf_cz_insten.visible = true;
            this.tf_extend_skill.visible = true;
            if(this.vo.isColor != 1)
            {
               if(this.vo.isColor == 0)
               {
                  this.tf_extend_skill.htmlText = HtmlUtil.font(this.skillName + "+" + this.vo.skillLvl,ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.font(NONLEARN,COLOR);
               }
               else if(this.vo.isColor == 2)
               {
                  this.tf_extend_skill.htmlText = HtmlUtil.font(this.skillName + "+" + this.vo.skillLvl,ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.font(NONJOP,COLOR);
               }
               else if(Boolean(this.vo.skillId))
               {
                  if(this.vo.isColor == 0)
                  {
                     this.tf_extend_skill.htmlText = HtmlUtil.font(this.skillName + "+" + this.vo.skillLvl,ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.font(NONLEARN,COLOR);
                  }
                  else if(this.vo.isColor == 2)
                  {
                     this.tf_extend_skill.htmlText = HtmlUtil.font(this.skillName + "+" + this.vo.skillLvl,ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.font(NONJOP,COLOR);
                  }
               }
               else
               {
                  this.tf_extend_skill.htmlText = HtmlUtil.font(LangConfig.getWord("60314",6),ColorConstant.getColorStr(ColorConstant.YELLOW));
               }
            }
            else
            {
               this.tf_cz_insten.filters = [];
               this.tf_extend_skill.filters = [];
               this.tf_extend_skill.htmlText = HtmlUtil.font(this.skillName + "+" + this.vo.skillLvl,ColorConstant.getColorStr(ColorConstant.YELLOW));
            }
            this.str = "";
            this.tf_cz_insten.filters = [];
            this.i = 0;
            per = 0;
            if(this.vo.color == 6)
            {
               per = Number(Data_lib.EquipBlackGlod[this.vo.type][2]);
            }
            while(this.i < this.vo.cz_insten_vec.length)
            {
               vv = this.vo.cz_insten_vec[this.i + 1] * 1 / (1 + per);
               this.str += HtmlUtil.font(this.getAttribute(this.vo.cz_insten_vec[this.i],vv),ColorConstant.getColorStr(ColorConstant.YELLOW));
               value = this.vo.cz_insten_vec[this.i + 1] - vv;
               if(value > vv)
               {
                  value = vv;
               }
               this.i += 2;
            }
            if(!this.vo.cz_insten_vec.length)
            {
               this.str = "无";
            }
            if(this.vo.color == 6)
            {
               this.tf_cz_insten.htmlText = HtmlUtil.font(this.str + "   +" + value,ColorConstant.getColorStr(ColorConstant.YELLOW));
            }
            else
            {
               this.tf_cz_insten.htmlText = HtmlUtil.font(this.str,ColorConstant.getColorStr(ColorConstant.YELLOW));
            }
         }
         if(this.vo.id == 99509)
         {
            this.tf_cz_insten_label.visible = false;
            this.tf_extend_skill_label.visible = false;
            this.tf_cz_insten.visible = false;
            this.tf_extend_skill.visible = false;
         }
      }
      
      private function getIntensify() : void
      {
         if(this.vo.vec_intensify.length == 0)
         {
            this.tf_intensify_label.visible = false;
            this.tf_intensify1.visible = false;
            this.tf_intensify2.visible = false;
            return;
         }
         this.tf_intensify_label.visible = true;
         this.tf_intensify1.visible = true;
         this.tf_intensify2.visible = true;
         this.str = "";
         this.str2 = "";
         this.i = 0;
         while(this.i < this.vo.vec_intensify.length)
         {
            if(this.i % 4 == 0)
            {
               if(this.i != 0)
               {
                  this.str += "\n";
               }
               this.str += HtmlUtil.font(this.getAttribute(this.vo.vec_intensify[this.i],this.vo.vec_intensify[this.i + 1]),ColorConstant.getColorStr(ColorConstant.YELLOW));
            }
            else
            {
               if(this.i != 2)
               {
                  this.str2 += "\n";
               }
               this.str2 += HtmlUtil.font(this.getAttribute(this.vo.vec_intensify[this.i],this.vo.vec_intensify[this.i + 1]),ColorConstant.getColorStr(ColorConstant.YELLOW));
            }
            this.i += 2;
         }
         this.tf_intensify1.htmlText = this.str;
         this.tf_intensify2.x = this.tf_intensify1.x + this.tf_intensify1.width + GAP_WIDTH;
         this.tf_intensify2.htmlText = this.str2;
      }
      
      private function getExtend() : void
      {
         var _n:int = 0;
         var colorSS:String = null;
         var starSS:String = null;
         var extralVal:int = 0;
         var strEVal:String = null;
         if(this.vo.vec_extend.length == 0)
         {
            this.tf_extend_label.visible = false;
            this.tf_extend1.visible = false;
            this.tf_extend2.visible = false;
            this.tf_extend3.visible = false;
            return;
         }
         this.tf_extend_label.visible = true;
         this.tf_extend1.visible = true;
         this.tf_extend2.visible = true;
         this.tf_extend3.visible = true;
         this.str = "";
         this.str2 = "";
         this.str3 = "";
         this.i = 0;
         trace(this.vo.poshStarVec);
         while(this.i < this.vo.vec_extend.length)
         {
            if(this.i == 12)
            {
               this.str += "   ";
            }
            if(this.i == 4 || this.i == 8 || this.i == 12 || this.i == 16)
            {
               this.str += "\n";
               this.str2 += "\n";
               this.str3 += "\n";
            }
            _n = this.vo.poshStarVec[int(this.i / 4)];
            this.str += HtmlUtil.font(this.getAttribute(this.vo.vec_extend[this.i],this.vo.vec_extend[this.i + 1]),ColorConstant.getColorStr(ColorConstant.GREEN));
            colorSS = _n == 10 ? ColorConstant.getColorStr(ColorConstant.ORANGE) : ColorConstant.getColorStr(ColorConstant.GREEN);
            starSS = _n == 10 ? " (满星)" : " (" + _n + "星)";
            extralVal = this.vo.vec_extend[this.i + 3];
            strEVal = extralVal == 0 ? "" : "+" + extralVal.toString();
            this.str2 += HtmlUtil.font(starSS,colorSS);
            this.str3 += HtmlUtil.font(strEVal,"#f9ff00");
            if(this.i == 0)
            {
               this.str += "   ";
            }
            this.i += 4;
         }
         this.tf_extend1.htmlText = this.str;
         this.tf_extend3.htmlText = this.str3;
         this.tf_extend2.htmlText = this.str2;
         this.tf_extend3.x = this.tf_extend1.x + this.tf_extend1.width + 6;
         this.tf_extend2.x = this.tf_extend3.x + this.tf_extend3.width + 4;
      }
      
      private function setGemVisible(t:int, boo:Boolean) : void
      {
         this.vec_new_bmpGem[t].visible = boo;
         this.vec_stone_bmpGem[t].visible = boo;
         this.vec_gem_nameTxt[t].visible = boo;
         this.vec_gem_valueTxt[t].visible = boo;
         this.vec_gem_value2Txt[t].visible = boo;
      }
      
      private function getNewGem() : void
      {
         var id:int = 0;
         var att:int = 0;
         var secAtt:int = 0;
         var arr:Array = null;
         this.isfirstGem = false;
         var tem_num:int = this.getExtralVec();
         this.newGemShowNum = 0;
         this.i = 0;
         while(this.i < Vo_equip.MAX_HOLE)
         {
            this.vec_new_bmpGem[this.i].bitmapData = null;
            this.vec_stone_bmpGem[this.i].bitmapData = null;
            this.vec_gem_nameTxt[this.i].htmlText = "";
            this.vec_gem_valueTxt[this.i].htmlText = "";
            this.setGemVisible(this.i,false);
            ++this.i;
         }
         if(tem_num == -1)
         {
            this.tf_gem_label.visible = false;
            return;
         }
         this.tf_gem_label.visible = true;
         this.i = 0;
         while(this.i < this.vo.vec_gemId.length)
         {
            if(this.vo.vec_gemId[this.i] != 0)
            {
               if(!this.isfirstGem)
               {
                  this.isfirstGem = true;
                  this.gemAdjustIdex = this.i;
               }
               this.setGemVisible(this.i,true);
               id = this.vo.vec_gemId[this.i];
               arr = Data_lib.item[id] as Array;
               att = int(arr[Enum_lib_item.TYPE_RESULT]);
               secAtt = int(arr[Enum_lib_item.SED_TYPE_RESULT]);
               Utils.getLoadBitmap(Const_strImg.NEW_GEM_1,this.vec_new_bmpGem[this.i]);
               Utils.getLoadBitmap(Const_strImg.inlayStone(id),this.vec_stone_bmpGem[this.i]);
               this.vec_gem_nameTxt[this.i].htmlText = HtmlUtil.fontNoSize(arr[Enum_lib_item.STR_NAME].toString(),"#ff7700");
               if(att != 0)
               {
                  this.vec_gem_valueTxt[this.i].htmlText = HtmlUtil.fontNoSize(Data_lib.attribute[att][Enum_lib_attribute.STR_NAME].toString() + " +" + arr[Enum_lib_item.RESULT].toString(),"#04ff00");
               }
               if(secAtt != 0)
               {
                  this.vec_gem_value2Txt[this.i].htmlText = HtmlUtil.fontNoSize(Data_lib.attribute[secAtt][Enum_lib_attribute.STR_NAME].toString() + " +" + arr[Enum_lib_item.SED_RESULT].toString(),"#04ff00");
               }
               else
               {
                  this.vec_gem_value2Txt[this.i].visible = false;
               }
               ++this.newGemShowNum;
            }
            ++this.i;
         }
      }
      
      private function getGem() : void
      {
         var id:int = 0;
         var temStr:String = null;
         this.tf_gem1.htmlText = "";
         this.tf_gem2.htmlText = "";
         var tem_num:int = this.getExtralVec();
         if(tem_num == -1)
         {
            this.tf_gem_label.visible = false;
            this.tf_gem1.visible = false;
            this.tf_gem2.visible = false;
            return;
         }
         this.tf_gem_label.visible = true;
         this.tf_gem1.visible = true;
         this.tf_gem2.visible = true;
         this.str = "";
         this.str2 = "";
         this.i = 0;
         var temArr:Array = [];
         while(this.i < this.vo.vec_gemId.length)
         {
            if(this.vo.vec_gemId[this.i] != 0)
            {
               temStr = Data_lib.item[this.vo.vec_gemId[this.i]][Enum_lib_item.STR_NAME].toString().replace(LangConfig.getWord("164",0),"");
               id = int(Data_lib.item[this.vo.vec_gemId[this.i]][Enum_lib_item.TYPE_RESULT]);
               this.str += temStr + " +" + Data_lib.item[this.vo.vec_gemId[this.i]][Enum_lib_item.RESULT];
               if(Data_lib.attribute[id][Enum_lib_attribute.TYPE] == 2)
               {
                  this.str += "";
               }
               this.str += "\n";
               temArr.push(this.str);
               ++this.i;
            }
            else
            {
               ++this.i;
            }
         }
         this.tf_gem1.htmlText = HtmlUtil.font(this.str,ColorConstant.getColorStr(ColorConstant.ORANGE));
      }
      
      private function getExtralVec() : int
      {
         var i:int = 0;
         while(i < this.vo.vec_gemId.length)
         {
            if(this.vo.vec_gemId[i] != 0)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function get_tz_vec(type:int = 1) : void
      {
         var vec_equip:Vector.<Vo_equip> = null;
         if(type == Enum_type_grid.ROLE_EQUIP_OTHER)
         {
            vec_equip = CommandManager.get_otherRole_vec_equip();
         }
         else if(type == Enum_type_grid.ROLE_PAIHANG)
         {
            vec_equip = CommandManager.get_paiHang_vec_equip();
         }
         else
         {
            vec_equip = CommandManager.get_role_vec_equip();
         }
         this.vec_idTz = new Vector.<int>();
         this.i = 0;
         while(this.i < vec_equip.length)
         {
            if(Boolean(vec_equip[this.i]) && Boolean(vec_equip[this.i].id_tz == this.vo.id_tz) && vec_equip[this.i].newTaoZhuangId == this.vo.newTaoZhuangId)
            {
               this.vec_idTz.push(vec_equip[this.i].id);
               this.vec_id_tz.push(vec_equip[this.i].id_tz);
            }
            ++this.i;
         }
      }
      
      private function bActivation(id:int) : Boolean
      {
         var j:int = 0;
         j = 0;
         while(j < this.vec_idTz.length)
         {
            if(this.vec_idTz[j] == id)
            {
               return true;
            }
            j++;
         }
         return false;
      }
      
      public function getVo(idType:int, type:int) : Vo_equip
      {
         var voE:Vo_equip = null;
         if(type == Enum_type_grid.ROLE_EQUIP_OTHER)
         {
            WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
            {
               voE = pan.getEuqipSingle(idType);
            });
            return voE;
         }
         if(type == Enum_type_grid.ROLE_PAIHANG)
         {
            return UIManager.paiHangPanel.getEuqipSingle(idType);
         }
         return UIManager.rolePanel.view_role_equip.getEuqipSingle(idType);
      }
      
      private function Matching(idType:int, type:int) : Boolean
      {
         var temVo:Vo_equip = null;
         switch(idType)
         {
            case 0:
               temVo = this.getVo(Enum_role_equip.CLOTH,type);
               if(Boolean(temVo))
               {
                  if(temVo.id_tz == this.vo.id_tz && temVo.newTaoZhuangId == this.vo.newTaoZhuangId)
                  {
                     return true;
                  }
               }
               break;
            case 1:
               temVo = this.getVo(Enum_role_equip.PANT,type);
               if(Boolean(temVo))
               {
                  if(temVo.id_tz == this.vo.id_tz && temVo.newTaoZhuangId == this.vo.newTaoZhuangId)
                  {
                     return true;
                  }
               }
               break;
            case 2:
               temVo = this.getVo(Enum_role_equip.SHOE,type);
               if(Boolean(temVo))
               {
                  if(temVo.id_tz == this.vo.id_tz && temVo.newTaoZhuangId == this.vo.newTaoZhuangId)
                  {
                     return true;
                  }
               }
               break;
            case 3:
               temVo = this.getVo(Enum_role_equip.HAT,type);
               if(Boolean(temVo))
               {
                  if(temVo.id_tz == this.vo.id_tz && temVo.newTaoZhuangId == this.vo.newTaoZhuangId)
                  {
                     return true;
                  }
               }
               break;
            case 4:
               temVo = this.getVo(Enum_role_equip.SASH,type);
               if(Boolean(temVo))
               {
                  if(temVo.id_tz == this.vo.id_tz && temVo.newTaoZhuangId == this.vo.newTaoZhuangId)
                  {
                     return true;
                  }
               }
               break;
            case 5:
               temVo = this.getVo(Enum_role_equip.WRISTLET,type);
               if(Boolean(temVo))
               {
                  if(temVo.id_tz == this.vo.id_tz && temVo.newTaoZhuangId == this.vo.newTaoZhuangId)
                  {
                     return true;
                  }
               }
         }
         return false;
      }
      
      private function hander(vec:Vector.<View_Grid>) : Boolean
      {
         var _vo:Vo_equip = null;
         var bool:Boolean = false;
         if(!vec || !vec.length)
         {
            return false;
         }
         var _i:int = 0;
         while(_i < vec.length)
         {
            if(Boolean(vec[_i]))
            {
               _vo = vec[_i].vo as Vo_equip;
               if(_vo)
               {
                  bool = this.hand(_vo.vec_gemId);
                  if(bool)
                  {
                     return true;
                  }
               }
            }
            _i++;
         }
         return false;
      }
      
      private function hand(vec:Vector.<int>) : Boolean
      {
         if(!vec || !vec.length)
         {
            return false;
         }
         var _i:int = 0;
         while(_i < vec.length)
         {
            if(vec[_i] != 0)
            {
               return true;
            }
            _i++;
         }
         return false;
      }
      
      private function getStoneZY() : void
      {
         var lvl:int = 0;
         var isGetStone:Boolean = false;
         var _isGetStone:Boolean = false;
         var __vecG:Vector.<View_Grid> = null;
         var __isGetStone:Boolean = false;
         this.tf_bszy_label.visible = false;
         this.tf_bszy.visible = false;
      }
      
      private function getTz(type:int = 1) : void
      {
         var id:int = 0;
         var num:int = 0;
         var arr:Array = null;
         var i:int = 0;
         var _dic:Dictionary = null;
         var key:String = null;
         var _arr:Array = null;
         var sN:String = null;
         var ii:int = 0;
         var sl:String = null;
         var __dic:Dictionary = null;
         var _key:String = null;
         var s:String = null;
         if(this.vo.id_tz == 0)
         {
            this.tf_tz.visible = false;
            return;
         }
         this.tf_tz.visible = true;
         this.get_tz_vec(type);
         var taoAttStr:String = "";
         var addAttStr:String = "";
         if(this.vo.newTaoZhuangId != 0)
         {
            _dic = Data_lib.newTZ;
            for(key in _dic)
            {
               _arr = _dic[key];
               if(_dic[key][0] == this.vo.id_tz && _dic[key][10] == this.vo.newTaoZhuangId)
               {
                  taoAttStr = _dic[key][9] as String;
                  addAttStr = taoAttStr.slice(0,2);
                  taoAttStr = HtmlUtil.font(taoAttStr.slice(0,2),"#ffffff") + taoAttStr.slice(2,taoAttStr.length);
               }
            }
         }
         else
         {
            taoAttStr = (Data_lib.tz[this.vo.id_tz][8] as String).replace("装","");
            addAttStr = "";
         }
         this.str = HtmlUtil.font(LangConfig.getWord("767",0),ColorConstant.getColorStr(ColorConstant.ORANGE));
         i = 0;
         while(i < Enum_lib_tz.PART_NUM)
         {
            id = int(Data_lib.tz[this.vo.id_tz][Enum_lib_tz.CLOTH + i]);
            if(id != 0)
            {
               if(i == 0 || i % 2 == 0)
               {
                  if(i == 0)
                  {
                     this.str += " ";
                  }
                  if(i % 2 == 0 && i != 0)
                  {
                     this.str += "\n                ";
                  }
               }
               else
               {
                  this.str += "   ";
               }
               sN = Data_lib.equip[id][Enum_lib_equip.STR_NAME];
               if(this.vo.newTaoZhuangId != 0)
               {
                  ii = 0;
                  while(ii < this._matchStr.length)
                  {
                     sl = this._matchStr[ii];
                     if(sN.indexOf(sl) != -1)
                     {
                        sN = sN.replace(sl,"");
                     }
                     ii++;
                  }
               }
               if(this.Matching(i,type))
               {
                  this.str += addAttStr + HtmlUtil.font(sN,ColorConstant.getColorStr(ColorConstant.ORANGE));
               }
               else
               {
                  this.str += HtmlUtil.font(addAttStr + sN,ColorConstant.getColorStr(ColorConstant.GREY));
               }
            }
            i++;
         }
         this.str += "\n  ";
         var repeat:int = 0;
         if(this.vo.newTaoZhuangId == 0)
         {
            arr = (Data_lib.tz[this.vo.id_tz][Enum_lib_tz.STR_ATTRIBUTE] as String).split(",");
         }
         else
         {
            __dic = Data_lib.newTZ;
            for(_key in _dic)
            {
               if(__dic[_key][10] == this.vo.newTaoZhuangId && __dic[_key][0] == this.vo.id_tz)
               {
                  s = __dic[_key][2];
                  arr = s.split(",");
               }
            }
         }
         i = 0;
         while(i < arr.length)
         {
            if(i != 0)
            {
               this.str += "\n  ";
            }
            arr[i] = (arr[i] as String).split("_");
            num = int(arr[i][0]);
            if(num > this.vec_idTz.length)
            {
               if(repeat != num)
               {
                  repeat = num;
                  this.str += HtmlUtil.font(arr[i][0] + LangConfig.getWord("768",0) + "：" + this.getAttribute(int(arr[i][1]),int(arr[i][2])),ColorConstant.getColorStr(ColorConstant.GREY));
               }
               else
               {
                  this.str += HtmlUtil.font(arr[i][0] + LangConfig.getWord("768",0) + "：" + this.getAttribute(int(arr[i][1]),int(arr[i][2])),ColorConstant.getColorStr(ColorConstant.GREY));
               }
            }
            else if(repeat != num)
            {
               repeat = num;
               this.str += HtmlUtil.font(arr[i][0] + LangConfig.getWord("768",0) + "：",ColorConstant.getColorStr(ColorConstant.ORANGE)) + HtmlUtil.font(this.getAttribute(int(arr[i][1]),int(arr[i][2])),"#ffffff");
            }
            else
            {
               this.str += HtmlUtil.font(arr[i][0] + LangConfig.getWord("768",0) + "：",ColorConstant.getColorStr(ColorConstant.ORANGE)) + HtmlUtil.font(this.getAttribute(int(arr[i][1]),int(arr[i][2])),"#ffffff");
            }
            i++;
         }
         this.tf_tz.htmlText = this.str;
      }
      
      public function getSzT(value:Boolean = false) : void
      {
         this.str = "";
         if(!(this.vo is Vo_equip))
         {
            return;
         }
         this.szTimeTf.filters = [];
         this.szTimelabel.visible = true;
         this.szTimeTf.visible = true;
         if((this.vo as Vo_equip).daoTime == -1)
         {
            if((this.vo as Vo_equip).type != 11)
            {
               this.szTimeTf.text = "";
               this.szTimelabel.visible = false;
               this.szTimeTf.visible = false;
            }
            else
            {
               this.str = (this.vo as Vo_equip).time_limit.toString();
               this.szTimelabel.visible = true;
               this.szTimeTf.visible = true;
               this.szTimeTf.htmlText = HtmlUtil.font(String(DateUtil.getMSBySecond4((this.vo as Vo_equip).time_limit)),"#04ff00");
            }
         }
         else if((this.vo as Vo_equip).daoTime == 0 && (this.vo as Vo_equip).time_limit != 0)
         {
            if(!value)
            {
               this.str = (this.vo as Vo_equip).time_limit.toString();
               this.szTimelabel.visible = true;
               this.szTimeTf.visible = true;
               this.szTimeTf.htmlText = HtmlUtil.font(String(DateUtil.getMSBySecond4((this.vo as Vo_equip).time_limit)),"#04ff00");
            }
         }
         else if((this.vo as Vo_equip).daoTime > 0)
         {
            this.str = (this.vo as Vo_equip).daoTime.toString();
            this.szTimelabel.visible = true;
            this.szTimeTf.visible = true;
            this.szTimeTf.htmlText = HtmlUtil.font(String(DateUtil.getMSBySecond4((this.vo as Vo_equip).daoTime)),"#04ff00");
         }
         else if((this.vo as Vo_equip).daoTime == -2)
         {
            this.szTimeTf.htmlText = HtmlUtil.font(LangConfig.getWord("60316",6),"#fe0000");
         }
         else
         {
            this.szTimeTf.text = "";
            this.szTimelabel.visible = false;
            this.szTimeTf.visible = false;
         }
         this.setPos();
      }
      
      private function getPrice() : void
      {
         if(this.vo.price == -1 || this.vo.price == 1)
         {
            this.str = "";
         }
         else if(this.vo.price == 0)
         {
            this.str = HtmlUtil.fontBr(LangConfig.getWord("756",0),ColorConstant.getColorStr(ColorConstant.RED));
         }
         else
         {
            this.str = LangConfig.getWord("757",0) + this.vo.price + "\n";
         }
         if(this.vo.str_help != "0")
         {
            this.str += HtmlUtil.font(this.vo.str_help,ColorConstant.getColorStr(ColorConstant.BLUE_LIGHT));
         }
         this.tf_price.htmlText = this.str;
      }
      
      private function show_lv_intensify(lv:int, str:String) : void
      {
         var _dic:Dictionary = null;
         var key:String = null;
         var _arr:Array = null;
         var n:int = 0;
         var nn:int = 0;
         var taoAttStr:String = "";
         if(this.vo.newTaoZhuangId != 0)
         {
            _dic = Data_lib.newTZ;
            for(key in _dic)
            {
               _arr = _dic[key];
               if(_dic[key][0] == this.vo.id_tz && _dic[key][10] == this.vo.newTaoZhuangId)
               {
                  taoAttStr = (_dic[key][9] as String).slice(0,2);
               }
            }
         }
         var color:String = "";
         if(lv < 11)
         {
            this.i = 0;
            while(this.i < Vo_equip.MAX_LV_INTENSIFY)
            {
               if(this.i < lv)
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY2,this.vec_bmpLv[this.i]);
               }
               else
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY1,this.vec_bmpLv[this.i]);
               }
               ++this.i;
            }
            this.tf_name.htmlText = HtmlUtil.font(taoAttStr,"#ffffff",16) + str;
         }
         else if(lv >= 11 && lv <= 21)
         {
            n = lv - 11;
            this.i = 0;
            while(this.i < Vo_equip.MAX_LV_INTENSIFY)
            {
               if(this.i < n)
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY4,this.vec_bmpLv[this.i]);
               }
               else
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY2,this.vec_bmpLv[this.i]);
               }
               ++this.i;
            }
            if(this.vo.color == 4)
            {
               color = "#33CCFF";
            }
            else if(this.vo.color >= 5)
            {
               color = "#de45c7";
            }
            this.tf_name.htmlText = HtmlUtil.font(HtmlUtil.bold("[神]"),color,16) + HtmlUtil.font(taoAttStr,"#ffffff",16) + str;
         }
         else
         {
            nn = lv - 22;
            this.i = 0;
            while(this.i < Vo_equip.MAX_LV_INTENSIFY)
            {
               if(this.i < nn)
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY6,this.vec_bmpLv[this.i]);
               }
               else
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY4,this.vec_bmpLv[this.i]);
               }
               ++this.i;
            }
            if(this.vo.color == 4)
            {
               color = "#FAFAD2";
            }
            else if(this.vo.color >= 5)
            {
               color = "#B8860B";
            }
            this.tf_name.htmlText = HtmlUtil.font(HtmlUtil.bold("[帝]"),color,16) + HtmlUtil.font(taoAttStr,"#ffffff",16) + str;
         }
         Model_equipTips.getModel(int(this.vo.bDress)).show(this.vo.strength,this.imgCon,new Point(this.tf_name.x + this.tf_name.width + 10,this.tf_name.y - 3),true);
      }
      
      private function show_New_Gem() : void
      {
         var temLength:int = 0;
         var id:int = 0;
         if(this.vo.cur_hole > 0)
         {
            temLength = this.vo.vec_gemId.length - this.getEmptyHold();
            this.i = 0;
            while(this.i < Vo_equip.MAX_HOLE)
            {
               if(this.i < temLength)
               {
                  Utils.getLoadBitmap(Const_strImg.NEW_GEM_1,this.vec_bmpGem[this.i]);
                  id = this.vo.vec_gemId[this.i];
                  id = 41001 + this.i * 3;
                  Utils.getLoadBitmap(Const_strImg.inlayStone(id),this.vec_stone_bmpGem[this.i]);
               }
               else if(this.i < this.vo.cur_hole)
               {
                  this.vec_stone_bmpGem[this.i].bitmapData = null;
                  Utils.getLoadBitmap(Const_strImg.NEW_GEM_1,this.vec_bmpGem[this.i]);
               }
               else
               {
                  this.vec_stone_bmpGem[this.i].bitmapData = null;
                  Utils.getLoadBitmap(Const_strImg.NEW_GEM_0,this.vec_bmpGem[this.i]);
               }
               this.vec_bmpGem[this.i].visible = true;
               this.vec_stone_bmpGem[this.i].visible = true;
               ++this.i;
            }
            this.tf_hole_label.visible = true;
         }
         else
         {
            this.i = 0;
            while(this.i < Vo_equip.MAX_HOLE)
            {
               Utils.getLoadBitmap(Const_strImg.NEW_GEM_0,this.vec_bmpGem[this.i]);
               this.vec_bmpGem[this.i].visible = true;
               this.vec_stone_bmpGem[this.i].visible = false;
               ++this.i;
            }
            this.tf_hole_label.visible = true;
         }
      }
      
      private function show_gem() : void
      {
         var temLength:int = 0;
         if(this.vo.cur_hole > 0)
         {
            temLength = this.vo.vec_gemId.length - this.getEmptyHold();
            this.i = 0;
            while(this.i < Vo_equip.MAX_HOLE)
            {
               if(this.i < temLength)
               {
                  Utils.getLoadBitmap(Const_strImg.GEM_1,this.vec_bmpGem[this.i]);
               }
               else if(this.i < this.vo.cur_hole)
               {
                  Utils.getLoadBitmap(Const_strImg.GEM_0,this.vec_bmpGem[this.i]);
               }
               else
               {
                  this.vec_bmpGem[this.i].bitmapData = null;
               }
               this.vec_bmpGem[this.i].visible = true;
               ++this.i;
            }
            this.tf_hole_label.visible = true;
         }
         else
         {
            this.i = 0;
            while(this.i < Vo_equip.MAX_HOLE)
            {
               this.vec_bmpGem[this.i].visible = false;
               ++this.i;
            }
            this.tf_hole_label.visible = false;
         }
      }
      
      private function getEmptyHold() : int
      {
         var temNum:int = 0;
         var i:int = 0;
         while(i < this.vo.vec_gemId.length)
         {
            if(this.vo.vec_gemId[i] == 0)
            {
               temNum++;
            }
            i++;
         }
         return temNum;
      }
   }
}

