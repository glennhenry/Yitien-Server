package com.yiTian.view.modules.cast
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_id;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.model.Model_store;
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
   import com.yiTian.view.modules.role.Enum_lib_compose;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class View_equip_inlay extends View_cast_base
   {
      
      private static const MAXMETER:int = 5;
      
      private static var isFirstOpen:Boolean = true;
      
      private var view_grid_equip_now:View_Grid;
      
      private var view_grid_item_now:View_Grid;
      
      private var view_grid_gem_now:View_Grid;
      
      private var view_grid_equip:View_Grid;
      
      private var view_grid_item:View_Grid;
      
      private var view_grid_gem:View_Grid;
      
      private var gridId_equip:int;
      
      private var vec_View_Grid:Vector.<View_Grid>;
      
      private var Button_YBZhiZuo:Button;
      
      private var Button_ZhiZhuo:Button;
      
      private var FeiYong_text:MyTextField;
      
      private var ChengGongLv_text:MyTextField;
      
      private var Button_Bag:TabButton;
      
      private var bag_data_Equip:Vector.<Vo_valuable>;
      
      private var bag_data_Item:Vector.<Vo_valuable>;
      
      private var tf_help_changed:MyTextField;
      
      private var id_arr:Array;
      
      private var is_enough_material:Boolean = true;
      
      public function View_equip_inlay()
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
         ComponentUtil.getTextField(LangConfig.getWord("60068",6),this,{
            "x":153,
            "y":252,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60069",6),this,{
            "x":153,
            "y":270,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60071",6),this,{
            "x":239,
            "y":151,
            "color":15318372,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60063",6),this,{
            "x":222,
            "y":52,
            "color":15318372,
            "size":12,
            "leading":0
         });
         this.Button_Bag = ComponentUtil.getTabButton(LangConfig.getWord("149",0),"TabButton_Four",this,{
            "x":395,
            "y":44,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_Bag.choose = true;
         this.Button_Bag.buttonMode = false;
         this.Button_Bag.mouseEnabled = false;
         this.Button_YBZhiZuo = ComponentUtil.getButton(LangConfig.getWord("188",0),"Button_Orange",this,{
            "x":293,
            "y":95,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_YBZhiZuo.visible = false;
         this.Button_YBZhiZuo.addEventListener(MouseEvent.CLICK,this.moneyHandle);
         this.Button_ZhiZhuo = ComponentUtil.getButton(LangConfig.getWord("189",0),"Button_Four",this,{
            "x":305,
            "y":258
         },Global.Img_Cdm);
         this.FeiYong_text = ComponentUtil.getTextField("0",this,{
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
         this.Button_ZhiZhuo.callBack = this.wpCreateHandle;
         this.view_grid_equip = new View_Grid();
         this.view_grid_equip.type = Enum_type_grid.CAST;
         this.view_grid_equip.set_bmp_bg();
         this.view_grid_equip.set_bmp_over();
         this.view_grid_equip.set_tf_count();
         this.view_grid_equip.set_tf_info(LangConfig.getWord("190",0) + "\n" + LangConfig.getWord("191",0));
         addChild(this.view_grid_equip);
         this.view_grid_equip.x = 248;
         this.view_grid_equip.y = 88;
         this.view_grid_equip.addEventListener(MouseEvent.CLICK,this.EQUIP_CANCEL);
         this.vec_View_Grid = new Vector.<View_Grid>(MAXMETER,true);
         i = 0;
         while(i < MAXMETER)
         {
            this.vec_View_Grid[i] = new View_Grid();
            this.vec_View_Grid[i].type = Enum_type_grid.CAST;
            this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_LOCK);
            this.vec_View_Grid[i].set_bmp_over();
            addChild(this.vec_View_Grid[i]);
            this.vec_View_Grid[i].x = 156 + i * 44;
            this.vec_View_Grid[i].y = 180;
            ++i;
         }
      }
      
      override public function reset() : void
      {
         canvas_up.reset();
         this.empty_vec_View_grid_cast_up();
         this.empty_vec_View_grid_cast_down();
         this.return_data();
      }
      
      private function get_bag_data() : void
      {
         this.bag_data_Item = new Vector.<Vo_valuable>();
         this.bag_data_Item = CommandManager.get_bag_vec(Enum_filter.TYPE_CREATE,null,[180]);
         this.show_up_data(this.bag_data_Item);
      }
      
      override public function bagEmpthHandle(grid_id:Array) : void
      {
      }
      
      override public function roleEmptyHandle(gridId:int) : void
      {
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
         DATA_LENG = arr.length;
         i = 0;
         while(i < arr.length)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_tf_count();
            v.Show(arr[i],View_grid_extra.GEM_COMPOSE);
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
      
      override public function update_upAndDown() : void
      {
         var arr:Array = null;
         this.get_bag_data();
         if(Boolean(this.view_grid_equip.vo))
         {
            arr = [];
            arr = (Data_lib.compose[this.view_grid_equip.vo.id][Enum_lib_compose.STR_STUFF] as String).split(",");
            this.hangle_length(arr);
            this.Show_down();
         }
      }
      
      override public function hide() : void
      {
      }
      
      override public function display() : void
      {
         tbtn_stuff.set_htmlText(LangConfig.getWord("192",0));
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
         this.tf_help_changed.htmlText = "1.物品制作需要消耗" + HtmlUtil.font("制作卷","#ff7700") + "和相应的" + HtmlUtil.font("制\n   作材料","#ff7700") + "\n2.也可用制作卷和" + HtmlUtil.font("元宝","#ff7700") + "进行制作";
         canvas_txt.align();
         canvas_txt.visible = false;
      }
      
      override public function update() : void
      {
         vec_Vo_valuable_cache = vec_Vo_valuable_show_up = CommandManager.get_bag_vec(Enum_filter.EQUIP_INLAY);
         if(filter != Enum_filter.ALL)
         {
            vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_show_up);
         }
         this.auto_addEquip();
      }
      
      private function update_tf_cost() : void
      {
         var vo_equip:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         var str:String = Data_lib.cast_cost[int(vo_equip.lv_use / 10) + 1][Enum_lib_cast_cost.EQUIP_INLAY];
         var arr:Array = str.split("_");
      }
      
      public function updata_create() : void
      {
         var temGrid:View_Grid = null;
         var eff1:Effect = null;
         CastEffect.getEffect("made",this.view_grid_equip,this);
         i = 0;
         while(i < this.vec_View_Grid.length)
         {
            temGrid = this.vec_View_Grid[i];
            if(Boolean(this.vec_View_Grid[i].vo))
            {
               eff1 = EffectManager.addEffect("35063",this,1000,temGrid.x + temGrid.width / 2,temGrid.y + temGrid.height / 2);
               UIManager.castPanel.setTabEnable(false);
               Tween.to(eff1,1000,{
                  "px":[temGrid.x + temGrid.width / 2,this.view_grid_equip.x + this.view_grid_equip.width / 2],
                  "py":[temGrid.y + temGrid.height / 2,this.view_grid_equip.y + this.view_grid_equip.height / 2]
               },this.completeHandle);
            }
            ++i;
         }
      }
      
      private function completeHandle() : void
      {
         var temIdArr:Vector.<Vo_valuable> = null;
         UIManager.castPanel.setTabEnable(true);
         var eff1:Effect = EffectManager.addEffect("35062",this,600,this.view_grid_equip.x + this.view_grid_equip.width / 2 - 3,this.view_grid_equip.y + this.view_grid_equip.height / 2);
         this.get_bag_data();
         if(Boolean(this.view_grid_equip.vo))
         {
            temIdArr = CommandManager.get_bag_vec(Enum_filter.GRID_ID,null,[this.view_grid_equip.vo.gridId]);
         }
         this.view_grid_equip.vo = null;
         if(Boolean(temIdArr))
         {
            if(Boolean(temIdArr.length))
            {
               this.view_grid_equip.vo = temIdArr[0];
            }
         }
      }
      
      override public function changeEquipBag(_equips:Array = null) : void
      {
         trace("空函数");
      }
      
      override public function changeEquipSelf(_equips:Array = null) : void
      {
         trace("空函数");
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
         this.auto_addEquip();
      }
      
      private function auto_addEquip() : void
      {
      }
      
      private function auto_addTool() : void
      {
         this.view_grid_item_now = null;
         this.view_grid_item.vo = null;
         this.view_grid_gem_now = null;
         this.view_grid_gem.vo = null;
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
                  if(vec_Vo_valuable_show_down[i].id == Const_id.INLAY_SYMBOL)
                  {
                     this.view_grid_item.vo = vec_Vo_valuable_show_down[i];
                     this.view_grid_item_now = vec_View_grid_extra_down[i].view_grid;
                     this.view_grid_item_now.bSelect = true;
                     --this.view_grid_item_now.count;
                     return;
                  }
               }
               ++i;
            }
            if(vec_Vo_valuable_show_down[0].id == Const_id.INLAY_SYMBOL)
            {
               this.view_grid_item.vo = vec_Vo_valuable_show_down[0];
               this.view_grid_item_now = vec_View_grid_extra_down[0].view_grid;
               this.view_grid_item_now.bSelect = true;
               --this.view_grid_item_now.count;
            }
         }
      }
      
      private function show_gem() : void
      {
         var vo_gem:Vo_item = null;
         var data:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         i = 0;
         while(i < Vo_equip.MAX_HOLE)
         {
            if(i < data.vec_gemId.length)
            {
               this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_OPEN);
               vo_gem = new Vo_item();
               vo_gem.id = data.vec_gemId[i];
               vo_gem.Init_lib();
               this.vec_View_Grid[i].vo = vo_gem;
            }
            else if(i < data.cur_hole)
            {
               this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_OPEN);
               this.vec_View_Grid[i].vo = null;
            }
            else
            {
               this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_LOCK);
               this.vec_View_Grid[i].vo = null;
            }
            ++i;
         }
      }
      
      private function Show_down() : void
      {
         var vec_Vo_valuable_temp:Vector.<Vo_valuable> = null;
         var v:View_grid_extra = null;
         var vo:Vo_item = null;
         this.empty_vec_View_grid_cast_down();
         vec_Vo_valuable_temp = CommandManager.get_bag_vec(Enum_filter.ID,null,this.id_arr);
         vec_Vo_valuable_show_down = vec_Vo_valuable_temp;
         if(vec_Vo_valuable_temp.length == 0 && !vec_Vo_valuable_temp)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_tf_count(true,true,true);
            v.x = GAP_X;
            v.y = INDENT;
            vo = new Vo_item();
            vo.id = Const_id.INLAY_SYMBOL;
            vo.Init_lib();
            vo.count = 0;
            canvas_down.addChild(v);
            v.Show(vo,View_grid_extra.INLAY);
            vec_View_grid_extra_down.push(v);
            vec_Vo_valuable_show_down.unshift(vo);
            i = 1;
         }
         else
         {
            i = 0;
         }
         while(i < vec_Vo_valuable_show_down.length)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_bmp_select();
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
            v.Show(vec_Vo_valuable_show_down[i],View_grid_extra.INLAY);
            v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_DOWN);
            vec_View_grid_extra_down.push(v);
            ++i;
         }
         canvas_down.reset();
         canvas_down.align();
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
            v.Show(vec_Vo_valuable_show_up[i],View_grid_extra.INLAY);
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
      
      private function CLICK_BTN_OK(e:MouseEvent) : void
      {
         if(this.view_grid_equip.vo == null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("167",0));
            return;
         }
         if((this.view_grid_equip.vo as Vo_equip).cur_hole == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("194",0));
            return;
         }
         if(this.view_grid_item.vo == null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("195",0));
            return;
         }
         if(this.view_grid_gem.vo == null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("196",0));
            return;
         }
         if((this.view_grid_equip.vo as Vo_equip).bBind == false)
         {
            if((this.view_grid_item.vo as Vo_item).bBind)
            {
               View_Alert.show(LangConfig.getWord("197",0) + HtmlUtil.font(LangConfig.getWord("172",0),ColorConstant.getColorStr(ColorConstant.RED)),View_Alert.OK_CANCAL,this.CLICK_OK);
               return;
            }
            if((this.view_grid_gem.vo as Vo_item).bBind)
            {
               View_Alert.show(LangConfig.getWord("198",0) + HtmlUtil.font(LangConfig.getWord("172",0),ColorConstant.getColorStr(ColorConstant.RED)),View_Alert.OK_CANCAL,this.CLICK_OK);
               return;
            }
         }
         this.CLICK_OK();
      }
      
      private function CLICK_OK(e:MouseEvent = null) : void
      {
      }
      
      override public function getClickGrid(temp:View_Grid) : void
      {
         if(!temp)
         {
            return;
         }
         if(this.view_grid_equip.vo == temp.vo)
         {
            return;
         }
         if(Boolean(this.view_grid_equip_now))
         {
            this.view_grid_equip_now.bSelect = false;
         }
         temp.bSelect = true;
         this.view_grid_equip_now = temp;
         this.view_grid_equip.vo = temp.vo;
         this.Button_YBZhiZuo.visible = true;
         this.FeiYong_text.text = Data_lib.compose[this.view_grid_equip.vo.id][Enum_lib_compose.YL_NEED];
         var arr:Array = [];
         arr = (Data_lib.compose[this.view_grid_equip.vo.id][Enum_lib_compose.STR_STUFF] as String).split(",");
         this.hangle_length(arr);
         this.Show_down();
      }
      
      private function CLICK_UP(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         this.getClickGrid(temp);
      }
      
      private function hangle_length(_arr:Array) : void
      {
         var temVO:Vo_item = null;
         var temNum:int = 0;
         if(!_arr)
         {
            return;
         }
         var temArr:Array = [];
         var tem_arr:Array = [];
         this.id_arr = [];
         var i:int = 0;
         while(i < _arr.length)
         {
            temArr.push([_arr[i].toString().split("_")]);
            tem_arr.push(_arr[i].toString().split("_"));
            this.vec_View_Grid[i].type = Enum_type_grid.CAST;
            this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_OPEN);
            this.vec_View_Grid[i].set_tf_count(true);
            this.vec_View_Grid[i].set_bmp_over();
            temVO = new Vo_item();
            temVO.id = int(tem_arr[i][0]);
            temVO.Init_lib();
            this.vec_View_Grid[i].vo = temVO;
            this.id_arr.push(temVO.id);
            temNum = Model_store.getCount(temVO.id);
            if(temNum > tem_arr[i][1])
            {
               temNum = int(tem_arr[i][1]);
            }
            else if(temNum < tem_arr[i][1])
            {
               this.is_enough_material = false;
            }
            this.vec_View_Grid[i].set_tf_info(HtmlUtil.font("\n" + String(temNum) + "/" + tem_arr[i][1],"#f4cd31"),this.vec_View_Grid[i].numChildren - 1);
            i++;
         }
         var j:int = i;
         while(j < this.vec_View_Grid.length)
         {
            this.vec_View_Grid[j].vo = null;
            this.vec_View_Grid[j].set_bmp_bg(View_Grid.GRID_LOCK);
            this.vec_View_Grid[j].set_tf_info(null);
            j += 1;
         }
      }
      
      private function CLICK_DOWN(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
      }
      
      private function ITEM_CANCEL(event:MouseEvent) : void
      {
         if(Boolean(this.view_grid_item.vo))
         {
            this.view_grid_item.vo = null;
            ++this.view_grid_item_now.count;
            this.view_grid_item_now.bSelect = false;
            this.view_grid_item_now = null;
         }
      }
      
      private function GEM_CANCEL(event:MouseEvent) : void
      {
         if(Boolean(this.view_grid_gem.vo))
         {
            this.view_grid_gem.vo = null;
            ++this.view_grid_gem_now.count;
            this.view_grid_gem_now.bSelect = false;
            this.view_grid_gem_now = null;
         }
      }
      
      private function moneyHandle(e:MouseEvent) : void
      {
         var temVo:Vo_valuable = null;
         if(!this.view_grid_equip.vo)
         {
            return;
         }
         temVo = this.view_grid_equip.vo as Vo_valuable;
         View_Alert.show(LangConfig.getWord("201",0) + String(Data_lib.compose[temVo.id][Enum_lib_compose.YB_NEED]) + LangConfig.getWord("202",0),View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
         {
            CastCGMessage.CG_RIDE_COMPOSE(temVo.id,int(temVo.bBind),1);
         },null,null,null,310,LangConfig.getWord("6",0),LangConfig.getWord("5",0),TextFormatAlign.LEFT);
      }
      
      private function wpCreateHandle(e:MouseEvent) : void
      {
         if(!this.view_grid_equip.vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("203",0));
            return;
         }
         var temVo:Vo_valuable = this.view_grid_equip.vo as Vo_valuable;
         CastCGMessage.CG_RIDE_COMPOSE(temVo.id,int(temVo.bBind),2);
      }
      
      private function return_data() : void
      {
         var i:int = 0;
         this.empty_vec_View_grid_cast_down();
         if(Boolean(this.view_grid_equip))
         {
            this.view_grid_equip.set_tf_info(LangConfig.getWord("190",0) + "\n" + LangConfig.getWord("191",0));
         }
         if(Boolean(this.view_grid_equip))
         {
            if(Boolean(this.view_grid_equip.vo))
            {
               this.view_grid_equip.vo = null;
            }
         }
         if(Boolean(this.vec_View_Grid))
         {
            i = 0;
            while(i < 5)
            {
               this.vec_View_Grid[i].type = Enum_type_grid.CAST;
               this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_LOCK);
               this.vec_View_Grid[i].set_bmp_over();
               this.vec_View_Grid[i].set_tf_info("");
               this.vec_View_Grid[i].vo = null;
               i++;
            }
         }
         if(Boolean(this.FeiYong_text))
         {
            this.FeiYong_text.text = "0";
         }
         if(Boolean(this.Button_YBZhiZuo))
         {
            this.Button_YBZhiZuo.visible = false;
         }
      }
      
      private function EQUIP_CANCEL(event:MouseEvent) : void
      {
         if(Boolean(this.view_grid_equip.vo))
         {
            this.return_data();
         }
      }
   }
}

