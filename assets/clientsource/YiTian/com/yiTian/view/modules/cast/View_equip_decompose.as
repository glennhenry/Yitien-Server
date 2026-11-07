package com.yiTian.view.modules.cast
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.model.Model_bag;
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
   import com.yiTian.view.modules.bag.ComboBox_h;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class View_equip_decompose extends View_cast_base
   {
      
      private static var COLOR_TYPE:int;
      
      private static const arr_id:Array = [46251,46252,46253,46254,46255];
      
      private static const COUNT_PAGE_EQUIP:int = 10;
      
      private static const COUNT_PAGE_ITEM:int = 5;
      
      public static var isClickSame:Boolean = false;
      
      private var comboBox:ComboBox_h;
      
      private var btn_pageLeft:Button;
      
      private var btn_pageRight:Button;
      
      private var tf_page:MyTextField;
      
      private var vec_View_equip:Vector.<View_Grid>;
      
      private var vec_View_item:Vector.<View_Grid>;
      
      private var vec_Vo_equip:Vector.<Vo_valuable>;
      
      private var page_cur:int;
      
      private var page_max:int;
      
      private var Button_FengJie:Button;
      
      private var FeiYong_text:MyTextField;
      
      private var ChengGongLv_text:MyTextField;
      
      private var Button_body:TabButton;
      
      private var Button_Bag:TabButton;
      
      private var now:TabButton;
      
      private var type:int;
      
      private var bag_data:Vector.<Vo_valuable>;
      
      private var isFirstOpen:Boolean = true;
      
      private var tf_help_copy:MyTextField;
      
      private var tf_title_copy:MyTextField;
      
      public function View_equip_decompose()
      {
         super();
      }
      
      override public function Init() : void
      {
         var grid:View_Grid = null;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":143,
            "y":46,
            "width":239,
            "height":240
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":392,
            "y":65,
            "width":287,
            "height":178
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":143,
            "y":290,
            "width":239,
            "height":155
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":392,
            "y":266,
            "width":287,
            "height":179
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":211,
            "y":297,
            "width":74,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":211,
            "y":317,
            "width":74,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":148,
            "y":339,
            "width":229,
            "height":100
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":294,
            "y":166,
            "width":50,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60060",6),this,{
            "x":153,
            "y":296,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60061",6),this,{
            "x":153,
            "y":316,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60062",6),this,{
            "x":208,
            "y":196,
            "color":15318372,
            "size":12,
            "leading":0
         });
         var vec_txt:Vector.<String> = new Vector.<String>();
         vec_txt.push([LangConfig.getWord("150",0)],["<font color=\'#04ff00\'>" + LangConfig.getWord("151",0) + "</font>"],["<font color=\'#33CCFF\'>" + LangConfig.getWord("152",0) + "</font>"],["<font color=\'#de45c7\'>" + LangConfig.getWord("153",0) + "</font>"]);
         this.comboBox = new ComboBox_h();
         this.comboBox.Init(vec_txt,165,LangConfig.getWord("154",0));
         this.comboBox.callBack = this.CLICK_COMBOBOX;
         this.comboBox.x = 174;
         this.comboBox.y = 50;
         this.Button_body = ComponentUtil.getTabButton(LangConfig.getWord("145",0),"TabButton_Four",this,{
            "x":395,
            "y":44,
            "textColor":16773818,
            "chooseColor":327424
         },Global.Img_Cdm);
         this.Button_Bag = ComponentUtil.getTabButton(LangConfig.getWord("146",0),"TabButton_Four",this,{
            "x":395,
            "y":44,
            "textColor":16773818,
            "chooseColor":327424
         },Global.Img_Cdm);
         this.Button_body.visible = false;
         this.Button_Bag.choose = true;
         this.Button_Bag.buttonMode = false;
         this.Button_Bag.mouseEnabled = false;
         this.Button_body.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Bag.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.btn_pageLeft = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":274,
            "y":166,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_pageRight = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":344,
            "y":166,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_page = ComponentUtil.getTextField("",this,{
            "x":310,
            "y":166,
            "color":15318372
         });
         this.Button_FengJie = ComponentUtil.getButton(LangConfig.getWord("155",0),"Button_Orange",this,{
            "x":296,
            "y":303,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_FengJie.callBack = this.CLICK_BTN_OK;
         this.FeiYong_text = ComponentUtil.getTextField("0",this,{
            "x":216,
            "y":316,
            "color":15318372
         });
         this.ChengGongLv_text = ComponentUtil.getTextField("100%",this,{
            "x":216,
            "y":296,
            "color":15318372
         });
         this.FeiYong_text.textColor = 16711424;
         this.ChengGongLv_text.textColor = 16711424;
         this.btn_pageLeft.addEventListener(MouseEvent.CLICK,this.BTN_LEFT_CLICK);
         this.btn_pageRight.addEventListener(MouseEvent.CLICK,this.BTN_RIGHT_CLICK);
         this.vec_View_equip = new Vector.<View_Grid>(COUNT_PAGE_EQUIP,true);
         i = 0;
         while(i < COUNT_PAGE_EQUIP)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.CAST;
            grid.set_bmp_bg();
            grid.set_bmp_over();
            addChild(grid);
            grid.addEventListener(MouseEvent.CLICK,this.EQUIP_CANCEL);
            this.vec_View_equip[i] = grid;
            this.vec_View_equip[i].x = 153.5 + 46 * (i % 5);
            this.vec_View_equip[i].y = 77 + 43 * int(i / 5);
            ++i;
         }
         this.vec_View_item = new Vector.<View_Grid>(COUNT_PAGE_ITEM,true);
         i = 0;
         while(i < COUNT_PAGE_ITEM)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.CAST;
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_tf_count(true,true,true);
            grid.isAutoLoad = false;
            addChild(grid);
            this.vec_View_item[i] = grid;
            this.vec_View_item[i].x = 153.5 + 46 * i;
            this.vec_View_item[i].y = 226;
            ++i;
         }
         this.vec_Vo_equip = new Vector.<Vo_valuable>();
         this.page_cur = 1;
         this.page_max = 1;
         this.tf_page.text = this.page_cur + "/" + this.page_max;
         addChild(this.comboBox);
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         var btn:TabButton = e.target as TabButton;
         if(btn == this.now)
         {
            return;
         }
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         btn.choose = true;
         this.now = btn;
         canvas_up.reset();
         if(btn.name != "self")
         {
            this.type = 1;
            this.get_bag_data();
         }
      }
      
      private function get_bag_data() : void
      {
         this.bag_data = new Vector.<Vo_valuable>();
         this.bag_data = CommandManager.get_bag_vec(Enum_filter.EQUIP_DECOMPOSE);
         vec_Vo_valuable_cache = this.bag_data;
         this.show_up_data(this.bag_data);
      }
      
      private function showBmp() : void
      {
         var bg1:Bitmap = ComponentUtil.getBitmap("Forging_Back1",this,{
            "x":155,
            "y":49
         },Global.Forging_Imgsdm);
         var bg2:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":164,
            "y":196,
            "width":213,
            "height":21
         },Global.Forging_Imgsdm);
         setChildIndex(bg1,2);
         setChildIndex(bg2,3);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(Boolean(this.now))
            {
               this.now.choose = false;
            }
            this.Button_body.choose = true;
            this.now = this.Button_body;
            this.get_bag_data();
            if(this.isFirstOpen)
            {
               this.setGridLoad();
               this.isFirstOpen = false;
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
            this.comboBox.setDefault(1);
         }
         else
         {
            this.reset();
         }
      }
      
      public function setGridLoad() : void
      {
         var vo:Vo_item = null;
         var grid:View_Grid = null;
         var i:int = 0;
         while(i < this.vec_View_item.length)
         {
            grid = this.vec_View_item[i];
            grid.isAutoLoad = true;
            grid.beginLoad();
            if(i < arr_id.length)
            {
               vo = new Vo_item();
               vo.id = arr_id[i];
               vo.Init_lib();
               grid.vo = vo;
            }
            grid.set_grey(true);
            i++;
         }
      }
      
      override public function reset() : void
      {
         this.empty_vec_View_grid_cast_up();
         this.empty_vec_View_grid_cast_down();
         if(Boolean(this.vec_View_equip))
         {
            i = 0;
            while(i < COUNT_PAGE_EQUIP)
            {
               this.vec_View_equip[i].vo = null;
               ++i;
            }
         }
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         if(Boolean(this.comboBox))
         {
            this.comboBox.setDefault(-1);
         }
         this.empty_vec_View_item();
         this.cancel_vec_Vo_equip();
         this.page_cur = 1;
         this.page_max = 1;
         if(Boolean(this.tf_page))
         {
            this.tf_page.text = this.page_cur + "/" + this.page_max;
         }
         COLOR_TYPE = 0;
      }
      
      override public function hide() : void
      {
      }
      
      override public function display() : void
      {
         tbtn_stuff.set_htmlText(LangConfig.getWord("157",0));
         tbtn_stuff.visible = true;
         tbbtn_bought.visible = false;
         if(!this.tf_help_copy)
         {
            this.tf_help_copy = ComponentUtil.getTextField("",this,{
               "x":157,
               "y":366 - 20,
               "leading":4,
               "color":14013822
            });
         }
         this.tf_help_copy.htmlText = "1.分解装备可获得" + HtmlUtil.font("银两","#ff7700") + "和" + HtmlUtil.font("英雄令牌","#ff7700") + "\n2.镶嵌有宝石的装备不能进行分解\n3." + HtmlUtil.font("橙装","#ff7700") + "不能分解";
         canvas_txt.visible = false;
         canvas_txt.align();
         callBack_btn_ok = this.CLICK_BTN_OK;
         callBack_changeFilter = this.changeFilter;
      }
      
      override public function update() : void
      {
         vec_Vo_valuable_cache = vec_Vo_valuable_show_up = CommandManager.get_bag_vec(Enum_filter.EQUIP_DECOMPOSE,vec_Vo_valuable_cache);
         if(filter != Enum_filter.ALL)
         {
            vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_show_up);
         }
         this.Show_down();
      }
      
      public function update_count(vec:Vector.<int>) : void
      {
         var temGrid:View_Grid = null;
         var eff4:Effect = null;
         var eff1:Effect = null;
         var teGrid:View_Grid = null;
         CastEffect.getEffect("compose",this.vec_View_equip[6],this);
         i = 0;
         while(i < this.vec_View_equip.length)
         {
            temGrid = this.vec_View_equip[i];
            if(Boolean(temGrid.vo))
            {
               eff4 = EffectManager.addEffect("35064",this,500,temGrid.x + 15,temGrid.y + 16);
               eff1 = EffectManager.addEffect("35063",this,1000,temGrid.x + temGrid.width / 2,temGrid.y + temGrid.height / 2);
               Tween.to(eff1,1000,{
                  "px":[temGrid.x + temGrid.width / 2,temGrid.x + temGrid.width / 2],
                  "py":[temGrid.y + temGrid.height / 2,this.vec_View_item[0].y]
               });
            }
            ++i;
         }
         i = 0;
         while(i < COUNT_PAGE_ITEM)
         {
            teGrid = this.vec_View_item[i];
            if(vec[i] > 0)
            {
               teGrid.set_grey(false);
            }
            else
            {
               teGrid.set_grey(true);
            }
            this.vec_View_item[i].count = vec[i];
            ++i;
         }
         this.empty_vec_View_equip();
      }
      
      private function funcHandle(vecArr:Vector.<int>) : int
      {
         var i:int = 0;
         while(i < vecArr.length)
         {
            if(vecArr[i] != 0)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function auto_addEquip(color:int) : void
      {
         COLOR_TYPE = color;
         i = 0;
         while(i < vec_Vo_valuable_cache.length)
         {
            if(vec_Vo_valuable_cache[i].color == color)
            {
               this.vec_Vo_equip.push(vec_Vo_valuable_cache[i]);
               vec_Vo_valuable_cache.splice(i,1);
               i = -1;
            }
            ++i;
         }
         vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_cache);
         this.show_up_data(vec_Vo_valuable_show_up);
         this.show_equip();
      }
      
      private function empty_vec_View_item() : void
      {
         if(Boolean(this.vec_View_item))
         {
            i = 0;
            while(i < COUNT_PAGE_ITEM)
            {
               this.vec_View_item[i].count = 0;
               this.vec_View_item[i].set_grey(true);
               ++i;
            }
         }
      }
      
      private function changeFilter() : void
      {
         if(filter != Enum_filter.ALL)
         {
            vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_cache);
         }
         else
         {
            vec_Vo_valuable_show_up = vec_Vo_valuable_cache;
         }
         this.Show_up();
         this.Show_down();
      }
      
      private function handleArr(_arr:Vector.<Vo_valuable>) : Vector.<Vo_valuable>
      {
         if(!_arr)
         {
            return null;
         }
         if(!_arr.length)
         {
            return new Vector.<Vo_valuable>();
         }
         var i:int = 0;
         while(i < _arr.length)
         {
            if(Boolean(vec_Vo_valuable_cache.length))
            {
               if(vec_Vo_valuable_cache[i].id_server == _arr[i].id_server)
               {
                  _arr.splice(i,1);
               }
            }
            i++;
         }
         return _arr;
      }
      
      private function show_up_data(arr:Vector.<Vo_valuable>, arr2:Vector.<View_Grid> = null) : void
      {
         var v:View_grid_extra = null;
         this.empty_vec_View_grid_cast_up();
         if(!arr.length)
         {
            return;
         }
         DATA_LENG = arr.length;
         i = 0;
         while(i < arr.length)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_tf_count();
            if(Boolean(arr2))
            {
               v.Show(arr[i],View_grid_extra.DECOMPOSE,arr2[i]);
            }
            else
            {
               v.Show(arr[i],View_grid_extra.DECOMPOSE);
            }
            if(i % 2 == 0)
            {
               v.x = GAP_X;
            }
            else
            {
               v.x = GAP_XL;
            }
            v.y = INDENT + int(i / 2) * 43;
            canvas_up.addChild(v);
            v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_UP);
            vec_View_grid_extra_up.push(v);
            ++i;
         }
         canvas_up.reset();
         canvas_up.align();
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
            v.view_grid.set_tf_count();
            v.Show(vec_Vo_valuable_show_up[i],View_grid_extra.DECOMPOSE);
            if(i % 2 == 0)
            {
               v.x = INDENT;
            }
            else
            {
               v.x = INDENT + GAP_WIDTH_GRID + WIDTH_GRID;
            }
            v.y = INDENT + int(i / 2) * (GAP_HEIGHT_GRID + HEIGHT_GRID);
            canvas_up.addChild(v);
            v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_UP);
            vec_View_grid_extra_up.push(v);
            ++i;
         }
         canvas_up.align();
      }
      
      private function Show_down() : void
      {
         var v:View_grid_extra = null;
         this.empty_vec_View_grid_cast_down();
         vec_Vo_valuable_show_down = CommandManager.get_bag_vec(Enum_filter.ID,null,arr_id);
         i = 0;
         while(i < vec_Vo_valuable_show_down.length)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_tf_count(true,true,true);
            if(i % 2 == 0)
            {
               v.x = GAP_X;
            }
            else
            {
               v.x = GAP_XL;
            }
            v.y = INDENT + int(i / 2) * 43;
            canvas_down.addChild(v);
            v.Show(vec_Vo_valuable_show_down[i],View_grid_extra.DECOMPOSE);
            vec_View_grid_extra_down.push(v);
            ++i;
         }
         canvas_down.reset();
         canvas_down.align();
      }
      
      private function empty_vec_View_grid_cast_up() : void
      {
         if(!DATA_LENG)
         {
            return;
         }
         if(DATA_LENG > vec_View_grid_extra_up.length)
         {
            DATA_LENG = vec_View_grid_extra_up.length;
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
            canvas_down.removeChild(vec_View_grid_extra_down[i]);
            vec_View_grid_extra_down[i].view_grid.empty();
            pool.push(vec_View_grid_extra_down[i]);
            vec_View_grid_extra_down.pop();
            --i;
         }
      }
      
      private function empty_vec_View_equip() : void
      {
         i = 0;
         while(i < this.vec_View_equip.length)
         {
            this.vec_View_equip[i].vo = null;
            ++i;
         }
         this.vec_Vo_equip = new Vector.<Vo_valuable>();
      }
      
      private function cancel_vec_Vo_equip() : void
      {
         if(Boolean(vec_Vo_valuable_cache))
         {
            i = this.vec_Vo_equip.length - 1;
            while(i > -1)
            {
               vec_Vo_valuable_cache.push(this.vec_Vo_equip[i]);
               this.vec_Vo_equip.pop();
               --i;
            }
         }
      }
      
      private function show_equip() : void
      {
         var len:int = int(this.vec_Vo_equip.length);
         var j:int = 0;
         while(j < COUNT_PAGE_EQUIP)
         {
            if(j + (this.page_cur - 1) * COUNT_PAGE_EQUIP < len)
            {
               this.vec_View_equip[j].vo = this.vec_Vo_equip[j + (this.page_cur - 1) * COUNT_PAGE_EQUIP];
            }
            else
            {
               this.vec_View_equip[j].vo = null;
            }
            j++;
         }
         this.page_max = this.vec_Vo_equip.length / COUNT_PAGE_EQUIP + 1;
         this.tf_page.text = this.page_cur + "/" + this.page_max;
      }
      
      private function CLICK_BTN_OK(e:MouseEvent) : void
      {
         if(this.vec_Vo_equip.length == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("158",0));
            return;
         }
         var vec:Vector.<Number> = new Vector.<Number>();
         i = 0;
         while(i < this.vec_Vo_equip.length)
         {
            if(this.vec_Vo_equip[i].color >= Model_bag.colorArr[3] && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
            {
               UIManager.bagPwdPutIn.visible = true;
               return;
            }
            vec.push(this.vec_Vo_equip[i].id_server);
            ++i;
         }
         i = 0;
         while(i < this.vec_Vo_equip.length)
         {
            if(this.vec_Vo_equip[i].color == 4)
            {
               View_Alert.show(LangConfig.getWord("988",0),View_Alert.OK_CANCAL,this.okHandle);
               return;
            }
            ++i;
         }
         CastCGMessage.CG_DECOMPOSE(vec);
      }
      
      private function okHandle() : void
      {
         var vec:Vector.<Number> = new Vector.<Number>();
         i = 0;
         while(i < this.vec_Vo_equip.length)
         {
            vec.push(this.vec_Vo_equip[i].id_server);
            ++i;
         }
         CastCGMessage.CG_DECOMPOSE(vec);
      }
      
      override public function update_upAndDown() : void
      {
         this.get_bag_data();
         if(Boolean(this.vec_Vo_equip.length))
         {
            i = this.vec_Vo_equip.length - 1;
            while(i >= 0)
            {
               this.vec_Vo_equip.splice(i,1);
               --i;
            }
         }
         i = 0;
         while(i < this.vec_View_equip.length)
         {
            if(Boolean(this.vec_View_equip[i].vo))
            {
               this.vec_View_equip[i].vo = null;
            }
            ++i;
         }
         if(COLOR_TYPE != 0)
         {
            this.auto_addEquip(COLOR_TYPE);
         }
      }
      
      override public function bagEmpthHandle(arr_gridId:Array) : void
      {
         var i:int = 0;
         var _temVec:Vector.<Vo_valuable> = null;
         if(Boolean(this.vec_Vo_equip))
         {
            if(Boolean(this.vec_Vo_equip.length))
            {
               i = 0;
               while(i < this.vec_Vo_equip.length)
               {
                  if(this.vec_Vo_equip[i].gridId == arr_gridId[0])
                  {
                     _temVec = CommandManager.get_bag_vec(Enum_filter.SEVER_ID,null,[(this.vec_Vo_equip[i] as Vo_equip).id_server]);
                     if(!_temVec)
                     {
                        this.vec_Vo_equip.splice(i,1);
                     }
                  }
                  i++;
               }
            }
         }
         this.get_bag_data();
         this.show_equip();
      }
      
      override public function changeEquipBag(_equips:Array = null) : void
      {
      }
      
      override public function changeEquipSelf(_equips:Array = null) : void
      {
         var i:int = 0;
         var j:int = 0;
         if(!_equips)
         {
            return;
         }
         if(!_equips.length)
         {
            return;
         }
         if(Boolean(this.vec_Vo_equip))
         {
            i = 0;
            loop0:
            while(i < this.vec_Vo_equip.length)
            {
               j = 0;
               while(true)
               {
                  if(j >= _equips.length)
                  {
                     i++;
                     continue loop0;
                  }
                  if(this.vec_Vo_equip[i].id_server == _equips[j][0])
                  {
                     break;
                  }
                  j++;
               }
               this.vec_Vo_equip.splice(i,1);
               this.show_equip();
               return;
            }
         }
         if(Boolean(vec_Vo_valuable_cache))
         {
            i = 0;
            while(i < vec_Vo_valuable_cache.length)
            {
               j = 0;
               while(j < _equips.length)
               {
                  j++;
               }
               i++;
            }
         }
      }
      
      override public function roleEmptyHandle(gridId:int) : void
      {
         trace("继承");
      }
      
      override public function getClickVo(_vo:Vo_valuable) : void
      {
         var i:int = 0;
         while(i < vec_View_grid_extra_up.length)
         {
            if(_vo == vec_View_grid_extra_up[i].view_grid.vo)
            {
               vec_View_grid_extra_up[i].view_grid.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               return;
            }
            i++;
         }
      }
      
      override public function setClickType(_type:int) : void
      {
         this.get_bag_data();
      }
      
      override public function getClickGrid(temp:View_Grid) : void
      {
         if((temp.vo as Vo_equip).vec_gemId.length > 0)
         {
            i = 0;
            while(i < (temp.vo as Vo_equip).vec_gemId.length)
            {
               if((temp.vo as Vo_equip).vec_gemId[i] > 0)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("159",0));
                  return;
               }
               ++i;
            }
         }
         if(this.type == 2)
         {
            if(temp.index == 12)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("160",0));
               return;
            }
         }
         else if((temp.vo as Vo_equip).type == 10)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("160",0));
            return;
         }
         i = 0;
         while(i < vec_Vo_valuable_cache.length)
         {
            if(temp.vo == vec_Vo_valuable_cache[i])
            {
               this.vec_Vo_equip.push(temp.vo);
               vec_Vo_valuable_cache.splice(i,1);
               break;
            }
            ++i;
         }
         this.show_equip();
         vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_cache);
         this.show_up_data(vec_Vo_valuable_show_up);
         canvas_up.reset();
         canvas_up.align();
         this.page_max = this.vec_Vo_equip.length / COUNT_PAGE_EQUIP + 1;
         this.tf_page.text = this.page_cur + "/" + this.page_max;
      }
      
      private function CLICK_UP(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         this.getClickGrid(temp);
      }
      
      private function EQUIP_CANCEL(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         if(Boolean(temp.vo))
         {
            vec_Vo_valuable_cache.push(temp.vo);
            vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_cache);
            this.show_up_data(vec_Vo_valuable_show_up);
            i = 0;
            while(i < this.vec_Vo_equip.length)
            {
               if(temp.vo == this.vec_Vo_equip[i])
               {
                  this.vec_Vo_equip.splice(i,1);
                  temp.vo = null;
                  break;
               }
               ++i;
            }
         }
      }
      
      private function BTN_RIGHT_CLICK(e:MouseEvent) : void
      {
         if(this.page_cur < this.page_max)
         {
            ++this.page_cur;
            this.tf_page.text = this.page_cur + "/" + this.page_max;
            this.show_equip();
         }
      }
      
      private function BTN_LEFT_CLICK(e:MouseEvent) : void
      {
         if(this.page_cur > 1)
         {
            --this.page_cur;
            this.tf_page.text = this.page_cur + "/" + this.page_max;
            this.show_equip();
         }
      }
      
      private function CLICK_COMBOBOX(id:int) : void
      {
         this.cancel_vec_Vo_equip();
         this.page_cur = 1;
         this.auto_addEquip(id + Enum_color.WHITE);
      }
   }
}

