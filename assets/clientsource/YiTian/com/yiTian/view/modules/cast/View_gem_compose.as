package com.yiTian.view.modules.cast
{
   import com.event.TextField_h;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_id;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CastCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.comp.View_grid_extra;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class View_gem_compose extends View_cast_base
   {
      
      public static var vec_View_Grid_gem:Vector.<View_Grid>;
      
      private static const MAX_GEM:int = 4;
      
      private static var isFirstOpen:Boolean = true;
      
      private var view_grid_item_now:View_Grid;
      
      private var vec_View_Grid_gem_now:Vector.<View_Grid>;
      
      private var view_grid_item:View_Grid;
      
      private var view_grid_item_m:View_Grid;
      
      private var tf_success_rate:TextField_h;
      
      private var FeiYong_text:MyTextField;
      
      private var ChengGongLv_text:MyTextField;
      
      private var HeChengJiShu_text:MyTextField;
      
      private var downBtn:Button;
      
      private var upBtn:Button;
      
      private var Number_text:MyTextField;
      
      private var Button_Bag:TabButton;
      
      private var Button_HeCheng:Button;
      
      private var bag_data_Equip:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
      
      private var bag_data_Item:Vector.<Vo_valuable>;
      
      private var changNum:int = 1;
      
      private var tf_help_changed:MyTextField;
      
      private var now_grid_item:View_Grid;
      
      private var maxNum:int;
      
      public function View_gem_compose()
      {
         super();
      }
      
      override public function Init() : void
      {
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":143,
            "y":46,
            "width":239,
            "height":197
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":392,
            "y":65,
            "width":287,
            "height":178
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":143,
            "y":247,
            "width":239,
            "height":198
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":392,
            "y":266,
            "width":287,
            "height":179
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":211,
            "y":254,
            "width":74,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":211,
            "y":272,
            "width":74,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":148,
            "y":290,
            "width":229,
            "height":149
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":146,
            "y":49,
            "width":233,
            "height":191
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":266,
            "y":195,
            "width":50,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60089",6),this,{
            "x":153,
            "y":252,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60090",6),this,{
            "x":153,
            "y":270,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60091",6),this,{
            "x":239,
            "y":151,
            "color":15318372,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60092",6),this,{
            "x":213,
            "y":52,
            "color":15318372,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("X",this,{
            "x":253,
            "y":195,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.FeiYong_text = ComponentUtil.getTextField("1500",this,{
            "x":216,
            "y":270,
            "color":15318372
         });
         this.ChengGongLv_text = ComponentUtil.getTextField("100%",this,{
            "x":216,
            "y":252,
            "color":15318372
         });
         this.FeiYong_text.textColor = 16711424;
         this.ChengGongLv_text.textColor = 16711424;
         this.Button_Bag = ComponentUtil.getTabButton(LangConfig.getWord("149",0),"TabButton_Four",this,{
            "x":395,
            "y":44,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_Bag.choose = true;
         this.Button_Bag.buttonMode = false;
         this.Button_Bag.mouseEnabled = false;
         this.downBtn = ComponentUtil.getButton("","Button_NumDown",this,{
            "x":252.95 + 44,
            "y":218 - 14,
            "name":"down"
         },Global.Img_Cdm);
         this.upBtn = ComponentUtil.getButton("","Button_NumUp",this,{
            "x":252.95 + 44,
            "y":206 - 11,
            "name":"up"
         },Global.Img_Cdm);
         this.downBtn.callBack = this.changeNumHandle;
         this.upBtn.callBack = this.changeNumHandle;
         this.Number_text = ComponentUtil.getTextField("0",this,{
            "x":272,
            "y":196,
            "color":16777215,
            "realWidth":22,
            "realHeight":16
         });
         this.Number_text.align = TextFormatAlign.CENTER;
         this.Number_text.type = TextFieldType.DYNAMIC;
         this.Number_text.restrict = ".0-9";
         this.Number_text.maxChars = 3;
         this.Number_text.addEventListener(Event.CHANGE,this.numChangeHandle);
         this.HeChengJiShu_text = ComponentUtil.getTextField(LangConfig.getWord("267",0) + "\nx0",this,{
            "x":253,
            "y":90,
            "color":16777215
         });
         this.HeChengJiShu_text.leading = 4;
         this.HeChengJiShu_text.align = TextFormatAlign.CENTER;
         this.Button_HeCheng = ComponentUtil.getButton(LangConfig.getWord("268",0),"Button_Orange",this,{
            "x":296,
            "y":258,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_HeCheng.callBack = this.heChengHandle;
         this.view_grid_item = new View_Grid();
         this.view_grid_item.type = Enum_type_grid.CAST;
         this.view_grid_item.set_bmp_bg();
         this.view_grid_item.set_bmp_over();
         this.view_grid_item.set_tf_count();
         addChild(this.view_grid_item);
         this.view_grid_item.x = 188;
         this.view_grid_item.y = 85;
         this.view_grid_item.addEventListener(MouseEvent.CLICK,this.ITEM_CANCEL);
         this.view_grid_item_m = new View_Grid();
         this.view_grid_item_m.type = Enum_type_grid.CAST;
         this.view_grid_item_m.set_bmp_bg();
         this.view_grid_item_m.set_bmp_over();
         addChild(this.view_grid_item_m);
         this.view_grid_item_m.x = 188;
         this.view_grid_item_m.y = 185;
      }
      
      override public function bagEmpthHandle(grid_id:Array) : void
      {
      }
      
      override public function roleEmptyHandle(gridId:int) : void
      {
      }
      
      override public function reset() : void
      {
         canvas_up.reset();
         this.empty_vec_View_grid_cast_up();
         this.changNum = 1;
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         if(Boolean(this.view_grid_item_m))
         {
            this.view_grid_item_m.vo = null;
         }
         if(Boolean(this.Number_text))
         {
            this.Number_text.text = "0";
         }
         if(Boolean(this.FeiYong_text))
         {
            this.FeiYong_text.text = "0";
         }
         if(Boolean(this.HeChengJiShu_text))
         {
            this.HeChengJiShu_text.text = LangConfig.getWord("267",0) + "\nx0";
         }
      }
      
      private function get_bag_data() : void
      {
         this.bag_data_Item = new Vector.<Vo_valuable>();
         this.bag_data_Item = CommandManager.get_bag_vec(Enum_filter.COMPOSED_WP);
         this.show_up_data(this.bag_data_Item);
      }
      
      private function showBmp() : void
      {
         var bg1:Bitmap = ComponentUtil.getBitmap("Forging_Back1",this,{
            "x":155,
            "y":49
         },Global.Forging_Imgsdm);
         var bg2:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":165,
            "y":51,
            "width":213,
            "height":21
         },Global.Forging_Imgsdm);
         var bg3:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":185,
            "y":150,
            "width":173,
            "height":21
         },Global.Forging_Imgsdm);
         setChildIndex(bg1,2);
         setChildIndex(bg2,3);
         setChildIndex(bg3,4);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.get_bag_data();
            if(isFirstOpen)
            {
               isFirstOpen = false;
               if(!Global.Forging_Imgsdm)
               {
                  SingleLoader.add("lang/ch/Forging_Imgs.swf",function(info:Object):void
                  {
                     Global.Forging_Imgsdm = info.applicationDomain;
                     showBmp();
                  });
               }
               else
               {
                  this.showBmp();
               }
            }
         }
         else
         {
            this.reset();
         }
      }
      
      private function changeNumHandle(e:MouseEvent) : void
      {
         var btn:Button = e.target as Button;
         if(!this.view_grid_item.vo || !this.view_grid_item_m.vo)
         {
            return;
         }
         if(btn.name == "up")
         {
            if(this.changNum == this.maxNum)
            {
               return;
            }
            ++this.changNum;
         }
         else
         {
            if(this.changNum < 1)
            {
               return;
            }
            --this.changNum;
         }
         this.Number_text.text = String(this.changNum);
         this.FeiYong_text.text = String((this.view_grid_item.vo as Vo_item).combin_cost * this.changNum);
      }
      
      private function numChangeHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(int(tf.text) < 1)
         {
            tf.text = "1";
         }
         else if(int(tf.text) > this.maxNum)
         {
            tf.text = String(this.maxNum);
         }
         this.changNum = int(tf.text);
         this.FeiYong_text.text = String((this.view_grid_item.vo as Vo_item).combin_cost * this.changNum);
      }
      
      private function show_up_data(arr:Vector.<Vo_valuable>) : void
      {
         var v:View_grid_extra = null;
         this.empty_vec_View_grid_cast_up();
         if(!arr)
         {
            return;
         }
         if(!arr.length)
         {
            return;
         }
         var I_I:int = 0;
         i = 0;
         while(i < arr.length)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_tf_count();
            if(arr[i].count >= (arr[i] as Vo_item).num_combining)
            {
               v.Show(arr[i],View_grid_extra.GEM_COMPOSE);
               if(I_I % 2 == 0)
               {
                  v.x = GAP_X;
               }
               else
               {
                  v.x = GAP_XL;
               }
               v.y = INDENT + int(I_I / 2) * 43;
               canvas_up.addChild(v);
               v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_UP);
               vec_View_grid_extra_up.push(v);
               I_I++;
            }
            ++i;
         }
         DATA_LENG = vec_View_grid_extra_up.length;
         canvas_up.reset();
         canvas_up.align();
      }
      
      override public function hide() : void
      {
      }
      
      override public function display() : void
      {
         tbtn_stuff.set_htmlText(LangConfig.getWord("271",0));
         tbbtn_bought.visible = false;
         if(!this.tf_help_changed)
         {
            this.tf_help_changed = ComponentUtil.getTextField("",this,{
               "x":157,
               "y":316 - 20,
               "leading":4,
               "color":14013822
            });
         }
         this.tf_help_changed.htmlText = "1.物品通过合成能够合成更高级的物品\n2.合成需要消耗一定银两";
         canvas_txt.align();
         canvas_txt.visible = false;
      }
      
      override public function update() : void
      {
         vec_Vo_valuable_cache = vec_Vo_valuable_show_up = CommandManager.get_bag_vec(Enum_filter.GEM_COMPOSE);
         if(filter != Enum_filter.ALL)
         {
            vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_show_up);
         }
      }
      
      private function update_tf_cost() : void
      {
         var lv:int = 0;
         var count:int = 0;
         i = 0;
         while(i < MAX_GEM)
         {
            if(Boolean(vec_View_Grid_gem[i].vo))
            {
               count++;
               lv = (vec_View_Grid_gem[i].vo as Vo_item).lv;
            }
            ++i;
         }
      }
      
      private function heChengHandle(e:MouseEvent) : void
      {
         if(!this.view_grid_item.vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("272",0));
            return;
         }
         if(this.Number_text.text == "0")
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("273",0));
            return;
         }
         CastCGMessage.CG_GEM_COMPOSE(this.view_grid_item.vo.gridId,int(this.Number_text.text),int((this.view_grid_item.vo as Vo_item).bBind));
      }
      
      private function update_success() : void
      {
         var count:int = 0;
         i = 0;
         while(i < MAX_GEM)
         {
            if(Boolean(vec_View_Grid_gem[i].vo))
            {
               count++;
            }
            ++i;
         }
         if(Boolean(this.view_grid_item.vo))
         {
            count++;
         }
         if(count == 0)
         {
            this.tf_success_rate.text = "0%";
         }
         else
         {
            this.tf_success_rate.text = (count - 1) * 25 + "%";
         }
      }
      
      private function changeFilter() : void
      {
         this.reset();
         if(filter != Enum_filter.ALL)
         {
            vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_cache);
         }
         else
         {
            vec_Vo_valuable_show_up = vec_Vo_valuable_cache;
         }
         this.Show_up();
      }
      
      private function set_select(pos:int, bSelect:Boolean) : void
      {
         if(bSelect)
         {
            if(++this.vec_View_Grid_gem_now[pos].index == 1)
            {
               this.vec_View_Grid_gem_now[pos].bSelect = true;
            }
            --this.vec_View_Grid_gem_now[pos].count;
         }
         else
         {
            if(--this.vec_View_Grid_gem_now[pos].index == 0)
            {
               this.vec_View_Grid_gem_now[pos].bSelect = false;
            }
            ++this.vec_View_Grid_gem_now[pos].count;
         }
      }
      
      private function get_item_id() : int
      {
         var id:int = 0;
         var lv:int = (vec_View_Grid_gem[0].vo as Vo_valuable).lv;
         if(lv < 4)
         {
            id = Const_id.COMPOSE_STONE1;
         }
         else if(lv < 7)
         {
            id = Const_id.COMPOSE_STONE1 + 1;
         }
         else
         {
            id = Const_id.COMPOSE_STONE1 + 2;
         }
         return id;
      }
      
      private function auto_addTool() : void
      {
         if(this.view_grid_item_now == null)
         {
            if(vec_Vo_valuable_show_down.length > 0)
            {
               if(vec_Vo_valuable_show_down[0].count == 0)
               {
                  return;
               }
               i = 0;
               while(i < vec_Vo_valuable_show_down.length)
               {
                  if(vec_Vo_valuable_show_down[i].bBind == false)
                  {
                     this.view_grid_item_now = vec_View_grid_extra_down[i].view_grid;
                     this.view_grid_item.vo = this.view_grid_item_now.vo;
                     this.view_grid_item_now.bSelect = true;
                     --this.view_grid_item_now.count;
                     return;
                  }
                  ++i;
               }
               this.view_grid_item_now = vec_View_grid_extra_down[0].view_grid;
               this.view_grid_item.vo = this.view_grid_item_now.vo;
               this.view_grid_item_now.bSelect = true;
               --this.view_grid_item_now.count;
            }
         }
      }
      
      private function Show_up() : void
      {
         var v:View_grid_extra = null;
         this.empty_vec_View_grid_cast_up();
         i = 0;
         while(i < vec_Vo_valuable_show_up.length)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_bmp_select();
            v.view_grid.set_tf_count(true,true,true);
            canvas_up.addChild(v);
            if(i % 2 == 0)
            {
               v.x = INDENT;
            }
            else
            {
               v.x = INDENT + GAP_WIDTH_GRID + WIDTH_GRID;
            }
            v.y = INDENT + int(i / 2) * (GAP_HEIGHT_GRID + HEIGHT_GRID);
            v.Show(vec_Vo_valuable_show_up[i],View_grid_extra.GEM_COMPOSE);
            v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_UP);
            vec_View_grid_extra_up.push(v);
            ++i;
         }
         canvas_up.reset();
         canvas_up.align();
      }
      
      private function Show_down() : void
      {
         var v:View_grid_extra = null;
         var vo:Vo_item = null;
         this.empty_vec_View_grid_cast_down();
         vec_Vo_valuable_show_down = CommandManager.get_bag_vec(Enum_filter.ID,null,[this.get_item_id()]);
         if(vec_Vo_valuable_show_down.length == 0)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_tf_count(true,true,true);
            v.x = INDENT;
            v.y = INDENT;
            vo = new Vo_item();
            vo.id = this.get_item_id();
            vo.Init_lib();
            vo.count = 0;
            canvas_down.addChild(v);
            v.Show(vo,0);
            vec_View_grid_extra_down.push(v);
         }
         else
         {
            i = 0;
            while(i < vec_Vo_valuable_show_down.length)
            {
               v = pool.pop() as View_grid_extra;
               v.view_grid.type = Enum_type_grid.CAST;
               v.view_grid.set_bmp_bg();
               v.view_grid.set_bmp_over();
               v.view_grid.set_bmp_select();
               v.view_grid.set_tf_count(true,true,true);
               canvas_down.addChild(v);
               if(i % 2 == 0)
               {
                  v.x = GAP_X;
               }
               else
               {
                  v.x = GAP_XL;
               }
               v.y = INDENT + int(i / 2) * 43;
               v.Show(vec_Vo_valuable_show_down[i],0);
               v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_DOWN);
               vec_View_grid_extra_down.push(v);
               ++i;
            }
            canvas_down.reset();
            canvas_down.align();
         }
      }
      
      private function empty_vec_View_grid_cast_up() : void
      {
         if(!DATA_LENG)
         {
            return;
         }
         i = DATA_LENG - 1;
         while(i > -1)
         {
            vec_View_grid_extra_up[i].view_grid.removeEventListener(MouseEvent.CLICK,this.CLICK_UP);
            canvas_up.removeChild(vec_View_grid_extra_up[i]);
            vec_View_grid_extra_up[i].view_grid.empty();
            pool.push(vec_View_grid_extra_up[i]);
            vec_View_grid_extra_up.pop();
            --i;
         }
         DATA_LENG = 0;
      }
      
      private function empty_vec_View_grid_cast_down() : void
      {
         i = vec_View_grid_extra_down.length - 1;
         while(i > -1)
         {
            vec_View_grid_extra_down[i].view_grid.removeEventListener(MouseEvent.CLICK,this.CLICK_DOWN);
            canvas_down.removeChild(vec_View_grid_extra_down[i]);
            vec_View_grid_extra_down[i].view_grid.empty();
            pool.push(vec_View_grid_extra_down[i]);
            vec_View_grid_extra_down.pop();
            --i;
         }
      }
      
      private function get_gemNum() : int
      {
         var num:int = 0;
         i = 0;
         while(i < MAX_GEM)
         {
            if(vec_View_Grid_gem[i].vo != null)
            {
               num++;
            }
            ++i;
         }
         return num;
      }
      
      private function CLICK_BTN_OK(e:MouseEvent) : void
      {
         if(this.get_gemNum() == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("274",0));
            return;
         }
         i = 0;
         while(i < MAX_GEM)
         {
            if(Boolean(vec_View_Grid_gem[i].vo))
            {
               if((vec_View_Grid_gem[i].vo as Vo_item).lv == Vo_item.MAX_LV_GEM)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("275",0));
                  return;
               }
               break;
            }
            ++i;
         }
         if(Boolean(this.view_grid_item.vo))
         {
            if((this.view_grid_item.vo as Vo_valuable).bBind)
            {
               View_Alert.show(LangConfig.getWord("276",0) + HtmlUtil.font(LangConfig.getWord("172",0),ColorConstant.getColorStr(ColorConstant.RED)),View_Alert.OK_CANCAL,this.CLICK_OK);
               return;
            }
         }
         else if(this.get_gemNum() == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("277",0));
            return;
         }
         i = 0;
         while(i < MAX_GEM)
         {
            if(Boolean(vec_View_Grid_gem[i].vo) && (vec_View_Grid_gem[i].vo as Vo_item).bBind)
            {
               View_Alert.show(LangConfig.getWord("278",0) + HtmlUtil.font(LangConfig.getWord("172",0),ColorConstant.getColorStr(ColorConstant.RED)),View_Alert.OK_CANCAL,this.CLICK_OK);
               return;
            }
            ++i;
         }
         this.CLICK_OK();
      }
      
      private function CLICK_OK(e:MouseEvent = null) : void
      {
         var vec:Vector.<int> = new Vector.<int>();
         i = 0;
         while(i < MAX_GEM)
         {
            if(Boolean(vec_View_Grid_gem[i].vo))
            {
               vec.push(vec_View_Grid_gem[i].vo.gridId);
            }
            ++i;
         }
      }
      
      override public function getClickGrid(temp:View_Grid) : void
      {
         var temVO_item:Vo_item = null;
         var temVo_equip:Vo_equip = null;
         if(this.now_grid_item == temp)
         {
            return;
         }
         if(Boolean(this.view_grid_item_now))
         {
            this.view_grid_item_now.bSelect = false;
         }
         this.view_grid_item.vo = temp.vo;
         var temId:int = (temp.vo as Vo_item).id_combining;
         if(temId < 50000)
         {
            temVO_item = new Vo_item();
            temVO_item.id = temId;
            temVO_item.Init_lib();
            this.view_grid_item_m.vo = temVO_item;
         }
         else if(temId >= 50000)
         {
            temVo_equip = new Vo_equip();
            temVo_equip.id = temId;
            temVo_equip.Init_lib();
            this.view_grid_item_m.vo = temVo_equip;
         }
         this.view_grid_item_now = temp;
         this.view_grid_item_now.bSelect = true;
         this.Number_text.type = TextFieldType.INPUT;
         this.HeChengJiShu_text.text = LangConfig.getWord("267",0) + "\nx" + (temp.vo as Vo_item).num_combining;
         this.maxNum = int(temp.vo.count / (temp.vo as Vo_item).num_combining);
         this.changNum = this.maxNum;
         this.Number_text.text = String(this.maxNum);
         this.FeiYong_text.text = String((temp.vo as Vo_item).combin_cost * this.changNum);
      }
      
      private function CLICK_UP(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         this.getClickGrid(temp);
      }
      
      public function intensGemComp() : void
      {
         CastEffect.getEffect("gemCompose",this.view_grid_item,this);
         var eff1:Effect = EffectManager.addEffect("35063",this,1000,this.view_grid_item.x + this.view_grid_item.width / 2,this.view_grid_item.y + this.view_grid_item.height / 2);
         UIManager.castPanel.setTabEnable(false);
         Tween.to(eff1,1000,{
            "px":[this.view_grid_item.x + this.view_grid_item.width / 2,this.view_grid_item_m.x + this.view_grid_item_m.width / 2],
            "py":[this.view_grid_item.y + this.view_grid_item.height / 2,this.view_grid_item_m.y + this.view_grid_item_m.height / 2]
         },this.compleHandle);
      }
      
      private function compleHandle() : void
      {
         UIManager.castPanel.setTabEnable(true);
         var eff1:Effect = EffectManager.addEffect("35062",this,600,this.view_grid_item_m.x + this.view_grid_item_m.width / 2 - 3,this.view_grid_item_m.y + this.view_grid_item_m.height / 2);
      }
      
      override public function update_upAndDown() : void
      {
         var temIdArr:Vector.<Vo_valuable> = null;
         var temId:int = 0;
         var temVO_item:Vo_item = null;
         var temVo_equip:Vo_equip = null;
         this.get_bag_data();
         if(Boolean(this.view_grid_item.vo))
         {
            temIdArr = CommandManager.get_bag_vec(Enum_filter.GRID_ID,null,[this.view_grid_item.vo.gridId]);
            this.view_grid_item.vo = null;
            if(Boolean(temIdArr.length))
            {
               this.view_grid_item.vo = temIdArr[0];
               temId = (this.view_grid_item.vo as Vo_item).id_combining;
               if(temId < 50000)
               {
                  temVO_item = new Vo_item();
                  temVO_item.id = temId;
                  temVO_item.Init_lib();
                  this.view_grid_item_m.vo = temVO_item;
               }
               else if(temId >= 50000)
               {
                  temVo_equip = new Vo_equip();
                  temVo_equip.id = temId;
                  temVo_equip.Init_lib();
                  this.view_grid_item_m.vo = temVo_equip;
               }
               this.HeChengJiShu_text.text = LangConfig.getWord("267",0) + "\nx" + (this.view_grid_item.vo as Vo_item).num_combining;
               this.maxNum = int(this.view_grid_item.vo.count / (this.view_grid_item.vo as Vo_item).num_combining);
               this.changNum = this.maxNum;
               this.Number_text.text = String(this.maxNum);
               this.FeiYong_text.text = String((this.view_grid_item.vo as Vo_item).combin_cost * this.changNum);
            }
         }
      }
      
      private function CLICK_DOWN(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         if(this.view_grid_item_now == temp)
         {
            return;
         }
         if(this.get_gemNum() == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("274",0));
            return;
         }
         if(Boolean(this.view_grid_item_now))
         {
            ++this.view_grid_item_now.count;
            this.view_grid_item_now.bSelect = false;
         }
         this.view_grid_item.vo = temp.vo;
         temp.bSelect = true;
         --temp.count;
         this.view_grid_item_now = temp;
         this.update_success();
      }
      
      override public function changeEquipSelf(_equips:Array = null) : void
      {
         trace("空函数");
      }
      
      override public function changeEquipBag(_equips:Array = null) : void
      {
         trace("空函数");
      }
      
      private function data_reset() : void
      {
         this.FeiYong_text.text = "0";
         this.Number_text.text = "0";
         this.changNum = 0;
         this.HeChengJiShu_text.text = LangConfig.getWord("267",0) + "\nx0";
         if(Boolean(this.view_grid_item_m.vo))
         {
            this.view_grid_item_m.vo = null;
         }
      }
      
      private function ITEM_CANCEL(e:MouseEvent) : void
      {
         var temGrid:View_Grid = e.target as View_Grid;
         if(Boolean(temGrid.vo))
         {
            temGrid.vo = null;
            this.data_reset();
         }
      }
      
      private function GEM_CANCEL(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         if(Boolean(temp.vo))
         {
            temp.vo = null;
            this.set_select(temp.index,false);
            if(this.get_gemNum() == 0)
            {
               this.ITEM_CANCEL(null);
            }
         }
         this.update_success();
      }
   }
}

