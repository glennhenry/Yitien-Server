package com.yiTian.view.modules.tip.tips
{
   import com.event.TextField_h;
   import com.utils.ColorConstant;
   import com.utils.DateUtil;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.config.valuable.Enum_item_type;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.handler.FruitShopHandler;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.role.Enum_lib_compose;
   import flash.display.Bitmap;
   import flash.utils.getTimer;
   
   public class View_Item extends View_tip
   {
      
      private static const GAP_HEIGHT:int = 0;
      
      private static const SIZE_TF_NAME:int = 14;
      
      private static const GAP_BMP:int = 2;
      
      private static const INDENT:int = 10;
      
      private var tf_name:TextField_h;
      
      private var tf_type:TextField_h;
      
      private var tf_bind:TextField_h;
      
      private var tf_describe:TextField_h;
      
      private var tf_stuff_label:TextField_h;
      
      private var tf_stuff1:TextField_h;
      
      private var tf_stuff2:TextField_h;
      
      private var tf_time:TextField_h;
      
      private var tf_source:TextField_h;
      
      private var tf_price:TextField_h;
      
      private var bmp_iconFrame:Bitmap;
      
      private var bmp_iconBg:Bitmap;
      
      private var bmp_icon:Bitmap;
      
      private var vo:Vo_item;
      
      private var vec_dis_x:Vector.<TextField_h>;
      
      private var vec_dis_y:Vector.<TextField_h>;
      
      private var str:String;
      
      private var lastId:int;
      
      public function View_Item()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.tf_name = new TextField_h();
         addChild(this.tf_name);
         this.tf_type = new TextField_h();
         addChild(this.tf_type);
         this.bmp_iconFrame = Utils.getLoadBitmap(View_Grid.GRID_OPEN);
         addChild(this.bmp_iconFrame);
         this.bmp_iconBg = new Bitmap();
         addChild(this.bmp_iconBg);
         this.bmp_icon = new Bitmap();
         addChild(this.bmp_icon);
         this.tf_bind = new TextField_h();
         addChild(this.tf_bind);
         this.tf_describe = new TextField_h();
         addChild(this.tf_describe);
         this.tf_stuff_label = new TextField_h();
         addChild(this.tf_stuff_label);
         this.tf_stuff1 = new TextField_h();
         addChild(this.tf_stuff1);
         this.tf_stuff2 = new TextField_h();
         addChild(this.tf_stuff2);
         this.tf_time = new TextField_h();
         addChild(this.tf_time);
         this.tf_source = new TextField_h();
         addChild(this.tf_source);
         this.tf_price = new TextField_h();
         addChild(this.tf_price);
         this.tf_name.x = INDENT;
         this.tf_name.y = 5;
         this.tf_name.htmlText = HtmlUtil.font("0",ColorConstant.getColorStr(ColorConstant.WHITE),SIZE_TF_NAME);
         this.bmp_iconBg.x = this.bmp_icon.x = INDENT + GAP_BMP + 3;
         this.bmp_iconBg.y = this.bmp_icon.y = this.tf_name.y + this.tf_name.height + GAP_BMP + 3;
         this.bmp_iconFrame.x = this.bmp_iconBg.x - 3;
         this.bmp_iconFrame.y = this.bmp_iconBg.y - 3;
         this.tf_type.x = this.bmp_icon.x + 49;
         this.tf_type.y = this.bmp_icon.y;
         this.tf_bind.x = INDENT;
         this.tf_describe.x = INDENT;
         this.tf_describe.wordWrap = true;
         this.tf_describe.multiline = true;
         this.tf_stuff_label.x = INDENT;
         this.tf_stuff_label.htmlText = HtmlUtil.font(LangConfig.getWord("192",0),ColorConstant.getColorStr(ColorConstant.YELLOW));
         this.tf_stuff1.x = INDENT;
         this.tf_stuff1.set_TextFormat_leading();
         this.tf_stuff2.set_TextFormat_leading();
         this.tf_time.x = INDENT;
         this.tf_source.x = INDENT;
         this.tf_price.x = INDENT;
         this.vec_dis_x = new Vector.<TextField_h>();
         this.vec_dis_x.push(this.tf_name,this.tf_type,this.tf_describe,this.tf_stuff2,this.tf_time,this.tf_source,this.tf_price);
         this.vec_dis_y = new Vector.<TextField_h>();
         this.vec_dis_y.push(this.tf_bind,this.tf_describe,this.tf_stuff_label,this.tf_stuff1,this.tf_time,this.tf_source,this.tf_price);
      }
      
      override public function Show($vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         visible = true;
         if(this.vo === $vo && this.lastId == $vo.id && this.vo.id != 45341)
         {
            return;
         }
         this.lastId = $vo.id;
         this.bmp_icon.bitmapData = null;
         this.bmp_iconBg.bitmapData = null;
         this.vo = $vo as Vo_item;
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
         Utils.getLoadBitmap("resource/image/icon/" + this.vo.str_icon + ".png",this.bmp_icon);
         Utils.getLoadBitmap("resource/image/iconBg/" + this.vo.bgIndex + ".png",this.bmp_iconBg);
         this.str = HtmlUtil.font(LangConfig.getWord("754",0),ColorConstant.getColorStr(ColorConstant.BLUE_LIGHT));
         if(this.vo.lv_use > GameUnitManager.hero.level)
         {
            this.str += HtmlUtil.font(this.vo.lv_use.toString(),ColorConstant.getColorStr(ColorConstant.RED));
         }
         else
         {
            this.str += HtmlUtil.font(this.vo.lv_use.toString(),ColorConstant.getColorStr(ColorConstant.WHITE));
         }
         this.tf_type.htmlText = this.str;
         if(this.vo.bBind)
         {
            this.tf_bind.htmlText = HtmlUtil.fontBr(LangConfig.getWord("755",0),ColorConstant.getColorStr(ColorConstant.RED));
            this.tf_bind.visible = true;
         }
         else
         {
            this.tf_bind.visible = false;
         }
         if(this.vo.str_describe != "0")
         {
            this.tf_describe.width = 210;
            this.str = HtmlUtil.font(this.vo.str_describe,ColorConstant.getColorStr(ColorConstant.YELLOW_SAND));
            this.tf_describe.htmlText = this.str;
            this.tf_describe.visible = true;
         }
         else
         {
            this.tf_describe.visible = false;
         }
         this.show_stuff();
         this.show_time();
         this.show_kfTime();
         if(this.vo.price == 0)
         {
            this.str = HtmlUtil.fontBr(LangConfig.getWord("756",0),ColorConstant.getColorStr(ColorConstant.RED));
         }
         else
         {
            this.str = LangConfig.getWord("757",0) + this.vo.price + "\n";
         }
         if(this.vo.source == "0")
         {
            this.tf_source.visible = false;
         }
         else
         {
            this.tf_source.htmlText = HtmlUtil.font(this.vo.source,"#33CCFF");
            this.tf_source.visible = true;
         }
         if(this.vo.str_help != "0")
         {
            this.str += HtmlUtil.font(this.vo.str_help,ColorConstant.getColorStr(ColorConstant.BLUE_LIGHT));
         }
         this.tf_price.set_TextFormat_leading();
         this.tf_price.htmlText = this.str;
         this.setPos();
      }
      
      private function show_stuff() : void
      {
         if(Data_lib.item[this.vo.id][Enum_lib_item.TYPE] == Enum_item_type.MERIDIAN_COMPOSE)
         {
            this.get_tf_stuff();
            this.tf_stuff_label.visible = true;
            this.tf_stuff1.visible = true;
            this.tf_stuff2.visible = true;
         }
         else
         {
            this.tf_stuff_label.visible = false;
            this.tf_stuff1.visible = false;
            this.tf_stuff2.visible = false;
         }
      }
      
      private function show_time() : void
      {
         var dateStr:String = null;
         var yStr:int = 0;
         var mStr:int = 0;
         var dStr:int = 0;
         var temH:int = 0;
         var temMi:int = 0;
         var temS:int = 0;
         var temDate:Date = null;
         var a:uint = 0;
         var dateNum:int = 0;
         var isVal:String = null;
         var isValiH:String = null;
         var mintStr:String = null;
         var sgin:String = Data_lib.item[this.vo.id][Enum_lib_item.USEABLE_DATE];
         if(Boolean(sgin) && Boolean(sgin.length > 3) && sgin.indexOf("_") != -1)
         {
            dateStr = Data_lib.item[this.vo.id][Enum_lib_item.USEABLE_DATE].split("_")[0];
            yStr = int(dateStr.split("-")[0]);
            mStr = int(dateStr.split("-")[1]);
            dStr = int(dateStr.split("-")[2]);
            temH = int(Data_lib.item[this.vo.id][Enum_lib_item.USEABLE_DATE].split("_")[1].split(":")[0]);
            temMi = int(Data_lib.item[this.vo.id][Enum_lib_item.USEABLE_DATE].split("_")[1].split(":")[1]);
            temS = int(Data_lib.item[this.vo.id][Enum_lib_item.USEABLE_DATE].split("_")[1].split(":")[2]);
            temDate = new Date(yStr,mStr - 1,dStr,temH,temMi,temS);
            a = FruitShopHandler.dateNum;
            dateNum = uint(temDate.time / 1000) - a;
            isVal = dateNum <= 0 ? "(已失效)" : "";
            isValiH = HtmlUtil.font(isVal,ColorConstant.getColorStr(ColorConstant.RED));
            mintStr = Data_lib.item[this.vo.id][Enum_lib_item.USEABLE_DATE].split("_")[1].substr(0,5);
            this.tf_time.htmlText = HtmlUtil.font(LangConfig.getWord("20055",11,yStr,mStr,dStr) + mintStr + isValiH,ColorConstant.getColorStr(ColorConstant.GREEN));
         }
         else
         {
            this.tf_time.htmlText = "";
         }
      }
      
      private function show_kfTime() : void
      {
         var now:int = 0;
         var remain:int = 0;
         var dateStr:String = null;
         var rep:String = null;
         var sgin:int = int(Data_lib.item[this.vo.id][Enum_lib_item.KF_TIME_LIMIT]);
         var kfTimeSec:int = Model_actDaily.getInstance().kfTime;
         var nowDateSec:int = int(FruitShopHandler.dateNum);
         if(sgin != 0 && kfTimeSec != 0 && nowDateSec != 0)
         {
            now = getTimer();
            remain = kfTimeSec + sgin - (nowDateSec + (now - FruitShopHandler.lastDateUpdateTime) / 1000);
            dateStr = DateUtil.getMSBySecond4(remain);
            rep = remain <= 0 ? "<font color=\'#ff3333\'>(已失效)</font>" : "<font color=\'#ff7700\'>物品剩余时间：</font><font color=\'#66ff33\'>{0}</font>";
            this.tf_time.htmlText = LangConfig.reTxt(rep,dateStr);
         }
      }
      
      private function get_tf_stuff() : void
      {
         var arr:Array = null;
         var str1:String = "";
         var str2:String = "";
         arr = (Data_lib.compose[this.vo.id][Enum_lib_compose.STR_STUFF] as String).split(",");
         var i:int = 0;
         while(i < arr.length)
         {
            arr[i] = (arr[i] as String).split("_");
            if(i % 2 == 0)
            {
               if(i != 0)
               {
                  str1 += "\n";
               }
               str1 += this.get_str_stuff(arr[i][0],arr[i][1]);
            }
            else
            {
               if(i != 1)
               {
                  str2 += "\n";
               }
               str2 += this.get_str_stuff(arr[i][0],arr[i][1]);
            }
            i++;
         }
         this.tf_stuff1.htmlText = str1;
         this.tf_stuff2.htmlText = str2;
         this.tf_stuff2.x = this.tf_stuff1.x + this.tf_stuff1.width + 3;
      }
      
      private function get_str_stuff(id:int, max_count:int) : String
      {
         this.str = Data_lib.item[id][Enum_lib_item.STR_NAME] + " ";
         var vec:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[id]);
         var count:int = 0;
         var i:int = 0;
         while(i < vec.length)
         {
            count += vec[i].count;
            i++;
         }
         if(count < max_count)
         {
            this.str = HtmlUtil.font(this.str + count + "/" + max_count,ColorConstant.getColorStr(ColorConstant.WHITE));
         }
         else
         {
            count = max_count;
            this.str = HtmlUtil.font(this.str + count + "/" + max_count,ColorConstant.getColorStr(ColorConstant.YELLOW));
         }
         return this.str;
      }
      
      private function setPos() : void
      {
         var i:int = 0;
         var max_x:int = 0;
         var max_y:int = this.bmp_iconFrame.y + Const_png.SIZE_GRID + GAP_BMP + GAP_HEIGHT;
         i = 0;
         while(i < this.vec_dis_x.length)
         {
            if(this.vec_dis_x[i].visible)
            {
               if(this.vec_dis_x[i] == this.tf_describe)
               {
                  if(max_x < this.vec_dis_x[i].x + this.vec_dis_x[i].textWidth + GAP_BMP)
                  {
                     max_x = this.vec_dis_x[i].x + this.vec_dis_x[i].textWidth + GAP_BMP;
                  }
               }
               else if(max_x < this.vec_dis_x[i].x + this.vec_dis_x[i].width)
               {
                  max_x = this.vec_dis_x[i].x + this.vec_dis_x[i].width;
               }
            }
            i++;
         }
         i = 0;
         while(i < this.vec_dis_y.length)
         {
            if(this.vec_dis_y[i].visible)
            {
               this.vec_dis_y[i].y = max_y;
               max_y += this.vec_dis_y[i].height + GAP_HEIGHT;
            }
            i++;
         }
         this.tf_stuff2.y = this.tf_stuff1.y;
         border.width = max_x + INDENT;
         border.height = max_y + 5;
      }
   }
}

