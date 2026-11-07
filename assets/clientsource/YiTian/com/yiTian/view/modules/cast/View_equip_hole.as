package com.yiTian.view.modules.cast
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_id;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_equip_type;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CastCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.comp.View_grid_extra;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class View_equip_hole extends View_cast_base
   {
      
      private static var _tabIndex:int;
      
      private static var isShowQuick:Boolean = false;
      
      private var view_grid_equip_now:View_Grid;
      
      private var view_grid_item_now:View_Grid;
      
      private var view_grid_equip:View_Grid;
      
      private var view_grid_item:View_Grid;
      
      private var gridId_equip:int;
      
      private var vec_View_Grid:Vector.<View_Grid>;
      
      private var FeiYong_text:MyTextField;
      
      private var ChengGongLv_text:MyTextField;
      
      private var Button_body:TabButton;
      
      private var Button_Bag:TabButton;
      
      private var btn_arr:Vector.<Button> = new Vector.<Button>();
      
      private var now:TabButton;
      
      private var type:int = 2;
      
      private var self_data:Vector.<Vo_valuable>;
      
      private var bag_data:Vector.<Vo_valuable>;
      
      private var temGridArr:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var _trueN:int;
      
      private var checkItemPrice:int;
      
      private var checkColor:String;
      
      private var tf_help_changed:MyTextField;
      
      private var stonesIdArr:Array = [];
      
      private var _kaiKongShiId:int;
      
      private var quickDataArrVec:Vector.<Vo_item> = new Vector.<Vo_item>();
      
      private var idArr:Array = [46051,46052,46053];
      
      private var priceTypeArr:Array = [[5,9],[20,10],[80,11]];
      
      private var quickContainer:Sprite = new Sprite();
      
      private var rateVec:Vector.<int> = new <int>[100,75,50,25];
      
      private var inLay_index:int;
      
      private var unload_index:int;
      
      private var isShowCheckBoxTips:Boolean = false;
      
      private var checkTips:String = "开孔材料不足，是否花费60元宝快速购买高级开孔石？";
      
      private var autoBuyTips:String;
      
      private var _askType:int;
      
      public function View_equip_hole()
      {
         super();
      }
      
      override public function Init() : void
      {
         var temBtn:Button = null;
         var i:int = 0;
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
            "x":220,
            "y":254,
            "width":74,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":220,
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
         ComponentUtil.getTextField(LangConfig.getWord("1127",0),this,{
            "x":212,
            "y":52,
            "color":15318372,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60065",6),this,{
            "x":153,
            "y":270,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60064",6),this,{
            "x":153,
            "y":252,
            "color":11904647,
            "size":12,
            "leading":0
         });
         var tfDsp:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("60067",6),this,{
            "x":218,
            "y":132,
            "color":15318372,
            "size":12,
            "leading":0
         });
         setChildIndex(tfDsp,numChildren - 1);
         this.Button_body = ComponentUtil.getTabButton(LangConfig.getWord("145",0),"TabButton_Four",this,{
            "x":395,
            "y":44,
            "textColor":16773818,
            "chooseColor":327424,
            "name":"self"
         },Global.Img_Cdm);
         this.Button_Bag = ComponentUtil.getTabButton(LangConfig.getWord("146",0),"TabButton_Four",this,{
            "x":470,
            "y":44,
            "textColor":16773818,
            "chooseColor":327424,
            "name":"bag"
         },Global.Img_Cdm);
         this.Button_body.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Bag.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.FeiYong_text = ComponentUtil.getTextField("0",this,{
            "x":225,
            "y":270,
            "color":15318372
         });
         this.ChengGongLv_text = ComponentUtil.getTextField("0%",this,{
            "x":225,
            "y":252,
            "color":15318372
         });
         i = 0;
         while(i < 4)
         {
            temBtn = ComponentUtil.getButton(LangConfig.getWord("161",0),"Button_Two",this,{
               "x":155 + 54.1 * i,
               "y":205
            },Global.Img_Cdm);
            temBtn.visible = false;
            temBtn.tabIndex = i;
            temBtn.addEventListener(MouseEvent.CLICK,this.OperationHandle);
            this.btn_arr.push(temBtn);
            i++;
         }
         this.view_grid_equip = new View_Grid();
         this.view_grid_equip.type = Enum_type_grid.CAST;
         this.view_grid_equip.set_bmp_bg();
         this.view_grid_equip.set_bmp_over();
         this.view_grid_equip.set_tf_info(LangConfig.getWord("162",0));
         addChild(this.view_grid_equip);
         this.view_grid_equip.x = 206;
         this.view_grid_equip.y = 81;
         this.view_grid_equip.addEventListener(MouseEvent.CLICK,this.EQUIP_CANCEL);
         this.view_grid_item = new View_Grid();
         this.view_grid_item.type = Enum_type_grid.CAST;
         this.view_grid_item.set_bmp_bg();
         this.view_grid_item.set_bmp_over();
         this.view_grid_item.set_tf_info(LangConfig.getWord("163",0) + "\n" + LangConfig.getWord("164",0));
         addChild(this.view_grid_item);
         this.view_grid_item.x = 283;
         this.view_grid_item.y = 81;
         this.view_grid_item.addEventListener(MouseEvent.CLICK,this.ITEM_CANCEL);
         this.vec_View_Grid = new Vector.<View_Grid>(Vo_equip.MAX_HOLE,true);
         i = 0;
         while(i < Vo_equip.MAX_HOLE)
         {
            this.vec_View_Grid[i] = new View_Grid();
            this.vec_View_Grid[i].type = Enum_type_grid.CAST;
            this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_LOCK);
            addChild(this.vec_View_Grid[i]);
            this.vec_View_Grid[i].x = 164.3 + i * 54;
            this.vec_View_Grid[i].y = 159;
            this.vec_View_Grid[i].tabIndex = i;
            i++;
         }
         this.gridId_equip = 0;
         this.getQuickData();
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         var btn:TabButton = e.currentTarget as TabButton;
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
         this.view_grid_item.vo = null;
         this.setEquipVo(null);
         this.empty_vec_View_grid_cast_down();
         if(this.now.name == "self")
         {
            this.type = 2;
            this.get_self_data();
         }
         else
         {
            this.type = 1;
            this.get_bag_data();
         }
      }
      
      private function setEquipVo(_vo:Vo_grid) : void
      {
         this.view_grid_equip.vo = _vo;
         this.handle_of_data(this.view_grid_equip.vo);
      }
      
      private function handle_of_data(equip_vo:Vo_grid) : void
      {
         var i:int = 0;
         if(!equip_vo)
         {
            i = 0;
            while(i < 4)
            {
               this.btn_arr[i].visible = false;
               if(Boolean(this.vec_View_Grid[i].vo))
               {
                  this.vec_View_Grid[i].vo = null;
               }
               this.vec_View_Grid[i].type = Enum_type_grid.CAST;
               this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_LOCK);
               this.vec_View_Grid[i].set_tf_info("");
               i++;
            }
            this.FeiYong_text.text = "0";
            this.ChengGongLv_text.text = "0%";
            this.empty_vec_View_grid_cast_down();
         }
         else
         {
            this.showBtn((this.view_grid_equip.vo as Vo_equip).cur_hole,(this.view_grid_equip.vo as Vo_equip).vec_gemId);
            this.show_gem();
            this.update_tf_cost();
            this.Show_down();
            this.auto_addTool();
         }
      }
      
      private function get_self_data() : void
      {
         this.self_data = new Vector.<Vo_valuable>();
         if(Boolean(UIManager.rolePanel.view_role_equip))
         {
            this.temGridArr = UIManager.rolePanel.view_role_equip.get_equips_noFasion();
         }
         var i:int = 0;
         while(i < this.temGridArr.length)
         {
            if((this.temGridArr[i].vo as Vo_equip).type != 10)
            {
               this.self_data.push(this.temGridArr[i].vo);
            }
            i++;
         }
         this.show_up_data(this.self_data,this.temGridArr);
      }
      
      private function show_up_data(arr:Vector.<Vo_valuable>, arr2:Vector.<View_Grid> = null) : void
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
            if(Boolean(arr2))
            {
               v.Show(arr[i],View_grid_extra.HOLE,arr2[i]);
            }
            else
            {
               v.Show(arr[i],View_grid_extra.HOLE);
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
      
      override public function changeEquipBag(_equips:Array = null) : void
      {
         if(!_equips)
         {
            return;
         }
         if(!_equips.length)
         {
            return;
         }
         if(this.type == 2)
         {
            if(Boolean(this.view_grid_equip.vo))
            {
               if((this.view_grid_equip.vo as Vo_equip).id_server == _equips[0][0])
               {
                  this.return_data();
                  return;
               }
            }
         }
      }
      
      override public function changeEquipSelf(_equips:Array = null) : void
      {
         var i:int = 0;
         if(!_equips)
         {
            return;
         }
         if(!_equips.length)
         {
            return;
         }
         if(this.view_grid_equip.vo == null)
         {
            return;
         }
         if(this.type == 1)
         {
            i = 0;
            while(i < _equips.length)
            {
               if((this.view_grid_equip.vo as Vo_equip).id_server == _equips[i][0])
               {
                  this.return_data();
                  return;
               }
               i++;
            }
         }
      }
      
      private function get_bag_data() : void
      {
         this.bag_data = new Vector.<Vo_valuable>();
         this.bag_data = CommandManager.get_bag_vec(Enum_filter.EQUIP_HOLE);
         this.show_up_data(this.bag_data);
      }
      
      private function showBmp() : void
      {
         var bg1:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":155,
            "y":51,
            "width":213,
            "height":21
         },Global.Forging_Imgsdm);
         var bgCo:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":175,
            "y":131,
            "width":173,
            "height":21
         },Global.Forging_Imgsdm);
         var bg:Bitmap = ComponentUtil.getBitmap("Forging_Back1",this,{
            "x":155,
            "y":49
         },Global.Forging_Imgsdm);
         setChildIndex(bg1,1);
         setChildIndex(bg,2);
         setChildIndex(bgCo,3);
      }
      
      private function visiHd() : void
      {
         var _vo:Vo_item = null;
         var _id:int = 0;
         var _num:int = 0;
         var colorS:String = null;
         var _truNum:int = 0;
         if(Boolean(this.view_grid_item) && Boolean(this.view_grid_item.vo))
         {
            _vo = this.view_grid_item.vo as Vo_item;
            _id = _vo.id;
            _num = CommandManager.get_bag_count(_id);
            this.checkTips = LangConfig.getWord("30128",3,String(this.checkItemPrice),HtmlUtil.fontNoSize(_vo.str_name,this.checkColor));
            this.autoBuyTips = LangConfig.getWord("30132",3,String(this.checkItemPrice),HtmlUtil.fontNoSize(_vo.str_name,this.checkColor));
            this._trueN = _num;
            colorS = _num == 0 ? "#fe0000" : "#f4cd31";
            _truNum = _num > 1 ? int(_num - 1) : _num;
            this.view_grid_item.set_tf_info(HtmlUtil.font("\n" + 1 + "/",colorS) + HtmlUtil.font(_truNum.toString(),colorS),this.view_grid_item.numChildren - 1);
         }
         else if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.set_tf_info(LangConfig.getWord("163",0) + "\n" + LangConfig.getWord("164",0));
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(Boolean(tbtn_stuff))
            {
               tbtn_stuff.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            if(Boolean(this.now))
            {
               this.now.choose = false;
            }
            this.Button_body.choose = true;
            this.now = this.Button_body;
            this.type = 2;
            this.get_self_data();
            this.getItemsId();
            GameScene.instance.addFrameCallBack(this.visiHd);
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
            this.showQuick();
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.visiHd);
            this.reset();
            while(Boolean(this.quickContainer) && Boolean(this.quickContainer.numChildren))
            {
               this.quickContainer.removeChildAt(0);
            }
            while(Boolean(canvas_down_quickMetia) && Boolean(canvas_down_quickMetia.numChildren))
            {
               canvas_down_quickMetia.removeChildAt(0);
            }
         }
      }
      
      override public function reset() : void
      {
         var i:int = 0;
         var temGrid:View_Grid = null;
         this.empty_vec_View_grid_cast_up();
         this.empty_vec_View_grid_cast_down();
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         if(Boolean(this.view_grid_equip))
         {
            this.view_grid_equip.vo = null;
         }
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         if(Boolean(this.vec_View_Grid))
         {
            i = 0;
            while(i < Vo_equip.MAX_HOLE)
            {
               this.btn_arr[i].visible = false;
               temGrid = this.vec_View_Grid[i];
               temGrid.set_bmp_bg(View_Grid.GRID_LOCK);
               temGrid.set_tf_info("");
               if(Boolean(temGrid.vo))
               {
                  temGrid.vo = null;
               }
               i++;
            }
         }
         if(Boolean(canvas_down_quickMetia))
         {
            canvas_down_quickMetia.visible = false;
         }
      }
      
      override public function hide() : void
      {
      }
      
      override public function display() : void
      {
         tbtn_stuff.set_htmlText(LangConfig.getWord("166",0));
         tbbtn_bought.visible = true;
         tbtn_stuff.visible = true;
         tfMart.visible = true;
         tfMiJing.visible = true;
         if(!this.tf_help_changed)
         {
            this.tf_help_changed = ComponentUtil.getTextField("",this,{
               "x":157,
               "y":316 - 20,
               "leading":4,
               "color":14013822
            });
         }
         this.tf_help_changed.mouseEnabled = true;
         this.tf_help_changed.addEventListener(TextEvent.LINK,function(e:TextEvent):void
         {
            var pan:ShoppingMallPan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
            pan.visible = true;
         });
         this.tf_help_changed.htmlText = "1、只有" + HtmlUtil.font("开孔","#ff7700") + "后的装备才可镶嵌宝石\n2、每一件装备上镶嵌的宝石属性种\n     类不能重复\n3、开孔石可通过副本获得或者通过\n     " + HtmlUtil.font(HtmlUtil.link(HtmlUtil.underLine("商城"),"ss"),"#04ff00") + "获得";
         canvas_txt.visible = false;
         canvas_txt.align();
      }
      
      override public function update() : void
      {
         vec_Vo_valuable_cache = vec_Vo_valuable_show_up = CommandManager.get_bag_vec(Enum_filter.EQUIP_HOLE);
         if(filter != Enum_filter.ALL)
         {
            vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_show_up);
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
         this.auto_addEquip();
      }
      
      private function auto_addEquip() : void
      {
         this.view_grid_equip.vo = null;
         if(this.gridId_equip > 0)
         {
            i = 0;
            while(i < vec_View_grid_extra_up.length)
            {
               if(vec_View_grid_extra_up[i].view_grid.vo.gridId == this.gridId_equip)
               {
                  vec_View_grid_extra_up[i].view_grid.bSelect = true;
                  this.view_grid_equip_now = vec_View_grid_extra_up[i].view_grid;
                  this.view_grid_equip.vo = this.view_grid_equip_now.vo;
                  this.show_gem();
                  break;
               }
               ++i;
            }
         }
         if(Boolean(this.view_grid_equip.vo))
         {
            this.update_tf_cost();
            this.Show_down();
            this.auto_addTool();
         }
         else
         {
            i = 0;
            while(i < Vo_equip.MAX_HOLE)
            {
               this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_LOCK);
               this.vec_View_Grid[i].vo = null;
               ++i;
            }
            this.view_grid_item_now = null;
            this.view_grid_item.vo = null;
            this.empty_vec_View_grid_cast_down();
         }
      }
      
      private function auto_addTool() : void
      {
         var _vo:Vo_item = null;
         this.view_grid_item_now = null;
         this.view_grid_item.vo = null;
         if(Boolean(this.view_grid_equip.vo))
         {
            if((this.view_grid_equip.vo as Vo_equip).cur_hole == 4)
            {
               return;
            }
         }
         var _countVo:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[this.get_item_id()]);
         if(!_countVo || !_countVo.length)
         {
            _vo = new Vo_item();
            _vo.id = this.get_item_id();
            _vo.count = 0;
            _vo.Init_lib();
            this.view_grid_item.vo = _vo;
         }
         if(vec_Vo_valuable_show_down.length > 0)
         {
            if(vec_Vo_valuable_show_down[0].count == 0)
            {
               this.view_grid_item.vo = vec_Vo_valuable_show_down[0];
               return;
            }
            i = 0;
            while(i < vec_Vo_valuable_show_down.length)
            {
               if(vec_Vo_valuable_show_down[i].id == 46051 || vec_Vo_valuable_show_down[i].id == 46052 || vec_Vo_valuable_show_down[i].id == 46053)
               {
                  if(vec_Vo_valuable_show_down[i].bBind == false)
                  {
                     this.view_grid_item_now = vec_View_grid_extra_down[i].view_grid;
                     this.view_grid_item.vo = this.view_grid_item_now.vo;
                     this.view_grid_item.index = this.view_grid_item_now.index;
                     this.view_grid_item_now.bSelect = true;
                     --this.view_grid_item_now.count;
                     return;
                  }
               }
               ++i;
            }
            if(vec_View_grid_extra_down[0].view_grid.vo.id == 46051 || vec_View_grid_extra_down[0].view_grid.vo.id == 46052 || vec_View_grid_extra_down[0].view_grid.vo.id == 46053)
            {
               this.view_grid_item_now = vec_View_grid_extra_down[0].view_grid;
               this.view_grid_item.vo = this.view_grid_item_now.vo;
               this.view_grid_item.index = this.view_grid_item_now.index;
               this.view_grid_item_now.bSelect = true;
               --this.view_grid_item_now.count;
            }
         }
      }
      
      private function show_gem() : void
      {
      }
      
      private function getItemsId() : void
      {
         var equip_stone_arr:Array = null;
         var equip_stoneId:String = null;
         var equip_stoneDic:Dictionary = Data_lib.equipStone;
         this.stonesIdArr = [];
         for(equip_stoneId in equip_stoneDic)
         {
            equip_stone_arr = equip_stoneDic[equip_stoneId];
            this.stonesIdArr.push(equip_stone_arr);
         }
         trace("id数据：",this.stonesIdArr,this.stonesIdArr.length);
      }
      
      private function get_item_id() : int
      {
         var id:int = 0;
         var color:int = (this.view_grid_equip.vo as Vo_equip).color;
         if(color <= Enum_color.GREEN)
         {
            id = Const_id.HOLE_STONE1;
         }
         else if(color == Enum_color.BLUE)
         {
            id = Const_id.HOLE_STONE1 + 1;
         }
         else if(color == Enum_color.PURPLE)
         {
            id = Const_id.HOLE_STONE1 + 2;
         }
         else if(color == Enum_color.ORANGE)
         {
            id = Const_id.HOLE_STONE1 + 2;
         }
         else
         {
            if(color != Enum_color.ANJIN)
            {
               throw new Error();
            }
            id = Const_id.HOLE_STONE1 + 2;
         }
         return id;
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
            v.Show(vec_Vo_valuable_show_up[i],View_grid_extra.HOLE);
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
         canvas_up.reset();
         canvas_up.align();
      }
      
      private function getQuickData() : void
      {
         var voI:Vo_item = null;
         i = 0;
         while(i < this.idArr.length)
         {
            voI = new Vo_item();
            voI.id = this.idArr[i];
            voI.Init_lib();
            this.quickDataArrVec.push(voI);
            ++i;
         }
      }
      
      private function showQuick() : void
      {
         var v:View_grid_extra = null;
         isShowQuick = true;
         i = 0;
         while(i < 3)
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
            v.index = i;
            v.y = INDENT + int(i / 2) * 43;
            this.quickContainer.addChild(v);
            v.setTypePri(this.priceTypeArr[i]);
            v.Show(this.quickDataArrVec[i],-2);
            vec_View_grid_extra_down_quickData.push(v);
            ++i;
         }
         canvas_down_quickMetia.addChild(this.quickContainer);
         canvas_down_quickMetia.align();
      }
      
      private function Show_down() : void
      {
         var vec_Vo_valuable_temp:Vector.<Vo_valuable> = null;
         var v:View_grid_extra = null;
         var vo:Vo_item = null;
         this.empty_vec_View_grid_cast_down();
         vec_Vo_valuable_show_down = CommandManager.get_bag_vec(Enum_filter.ID,null,[this.get_item_id()]);
         vec_Vo_valuable_temp = CommandManager.get_bag_vec(Enum_filter.ID,null,this.stonesIdArr);
         var i:int = 0;
         while(i < vec_Vo_valuable_temp.length)
         {
            vec_Vo_valuable_show_down.push(vec_Vo_valuable_temp[i]);
            i++;
         }
         if(vec_Vo_valuable_show_down.length == 0)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_tf_count(true,true,true);
            v.x = GAP_X;
            v.y = INDENT;
            vo = new Vo_item();
            vo.id = this.get_item_id();
            vo.Init_lib();
            vo.count = 0;
            metiaContainer.addChild(v);
            v.Show(vo);
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
               if(i % 2 == 0)
               {
                  v.x = GAP_X;
               }
               else
               {
                  v.x = GAP_XL;
               }
               v.index = i;
               v.y = INDENT + int(i / 2) * 43;
               metiaContainer.addChild(v);
               v.Show(vec_Vo_valuable_show_down[i]);
               v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_DOWN);
               vec_View_grid_extra_down.push(v);
               i++;
            }
            canvas_down.addChild(metiaContainer);
            canvas_down.reset();
            canvas_down.align();
         }
      }
      
      private function showStoneData() : void
      {
         var v:View_grid_extra = null;
         var vo:Vo_item = null;
         this.empty_vec_View_grid_cast_down();
         vec_Vo_valuable_show_down = CommandManager.get_bag_vec(Enum_filter.ID,null,this.stonesIdArr);
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
            v.Show(vo);
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
               if(i % 2 == 0)
               {
                  v.x = INDENT;
               }
               else
               {
                  v.x = INDENT + GAP_WIDTH_GRID + WIDTH_GRID;
               }
               v.y = INDENT + int(i / 2) * (GAP_HEIGHT_GRID + HEIGHT_GRID);
               canvas_down.addChild(v);
               v.Show(vec_Vo_valuable_show_down[i]);
               v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_DOWN);
               vec_View_grid_extra_down.push(v);
               ++i;
            }
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
            metiaContainer.removeChild(vec_View_grid_extra_down[i]);
            vec_View_grid_extra_down[i].view_grid.empty();
            pool.push(vec_View_grid_extra_down[i]);
            vec_View_grid_extra_down.pop();
            --i;
         }
         canvas_down.removeChild(metiaContainer);
      }
      
      private function update_tf_cost() : void
      {
         var rate:int = 0;
         var vo_equip:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         var str:String = Data_lib.cast_cost[Math.ceil(vo_equip.lv_use / 10)][Enum_lib_cast_cost.EQUIP_HOLE_0 + vo_equip.cur_hole];
         var arr:Array = str.split("_");
         if(vo_equip.color >= 1 && vo_equip.color <= 3)
         {
            this.FeiYong_text.text = arr[int(vo_equip.color - 1)];
         }
         else if(vo_equip.color == 4 || vo_equip.color == 5 || vo_equip.color == 6)
         {
            this.FeiYong_text.text = arr[3];
         }
         else
         {
            this.FeiYong_text.text = "0";
         }
         if(vo_equip.cur_hole >= 0 && vo_equip.cur_hole <= 3)
         {
            rate = this.rateVec[vo_equip.cur_hole];
         }
         else
         {
            this.FeiYong_text.text = "0";
            rate = 0;
         }
         this.ChengGongLv_text.text = rate + "%";
      }
      
      private function CLICK_BTN_OK(e:MouseEvent) : void
      {
         if(this.view_grid_equip.vo == null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("167",0));
            return;
         }
         var vo_equip:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         if(vo_equip.cur_hole == Vo_equip.MAX_HOLE)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("168",0));
            return;
         }
         if(vo_equip.type == Enum_equip_type.NECKLACE || vo_equip.type == Enum_equip_type.RING)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("169",0));
            return;
         }
         if(this.view_grid_item.vo == null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("170",0));
            return;
         }
         if(vo_equip.bBind == false && (this.view_grid_item.vo as Vo_item).bBind)
         {
            View_Alert.show(LangConfig.getWord("171",0) + HtmlUtil.font(LangConfig.getWord("172",0),ColorConstant.getColorStr(ColorConstant.RED)),View_Alert.OK_CANCAL,this.CLICK_OK);
         }
         else
         {
            this.CLICK_OK();
         }
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
         if(this.type == 2)
         {
            if(temp.index == 12)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("173",0));
               return;
            }
         }
         else if((temp.vo as Vo_equip).type == 10)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("173",0));
            return;
         }
         var i:int = 0;
         while(i < 4)
         {
            this.btn_arr[i].visible = false;
            if(Boolean(this.vec_View_Grid[i].vo))
            {
               this.vec_View_Grid[i].vo = null;
            }
            this.vec_View_Grid[i].type = Enum_type_grid.CAST;
            this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_LOCK);
            this.vec_View_Grid[i].set_tf_info("");
            i++;
         }
         if(Boolean(this.view_grid_equip_now))
         {
            this.view_grid_equip_now.bSelect = false;
         }
         temp.bSelect = true;
         this.view_grid_equip_now = temp;
         this.view_grid_equip.vo = temp.vo;
         this.view_grid_equip.index = temp.index;
         this.gridId_equip = temp.vo.gridId;
         this.showBtn((this.view_grid_equip.vo as Vo_equip).cur_hole,(this.view_grid_equip.vo as Vo_equip).vec_gemId);
         this.show_gem();
         this.update_tf_cost();
         this.Show_down();
         this.auto_addTool();
         if(this.view_grid_item.vo == null)
         {
            return;
         }
         this.checkItemPrice = Data_lib.autoBuyConst[this.view_grid_item.vo.id][Const_id.AUTO_PRICE];
         this.checkColor = Data_lib.autoBuyConst[this.view_grid_item.vo.id][Const_id.AUTO_COLOR];
      }
      
      private function CLICK_UP(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         this.getClickGrid(temp);
      }
      
      override public function update_upAndDown() : void
      {
         if(this.type == 1)
         {
            this.get_bag_data();
         }
         else
         {
            this.get_self_data();
         }
         if(Boolean(this.view_grid_equip.vo))
         {
            this.Show_down();
            this.auto_addTool();
            this.update_tf_cost();
         }
      }
      
      private function operationCheckCall(box:CheckBox) : void
      {
         this.isShowCheckBoxTips = box.selected;
      }
      
      private function Tapping(btn:Button) : void
      {
         if(!this.view_grid_item.vo || this._trueN == 0)
         {
            if(!this.isShowCheckBoxTips)
            {
               View_Alert.checkStatus(this.isShowCheckBoxTips);
               View_Alert.show(this.checkTips,View_Alert.OK_CANCAL,function():void
               {
                  _tabIndex = btn.tabIndex;
                  CastCGMessage.CG_ADD_HOLE((view_grid_equip.vo as Vo_valuable).id_server,view_grid_item.vo.gridId,int((view_grid_item.vo as Vo_valuable).bBind),1);
               },null,null,null,310,"","",TextFormatAlign.LEFT,true);
               View_Alert.instance.showCheckBox = this.operationCheckCall;
            }
            else
            {
               _tabIndex = btn.tabIndex;
               CastCGMessage.CG_ADD_HOLE((this.view_grid_equip.vo as Vo_valuable).id_server,this.view_grid_item.vo.gridId,int((this.view_grid_item.vo as Vo_valuable).bBind),1);
            }
            this._askType = 1;
         }
         else
         {
            _tabIndex = btn.tabIndex;
            CastCGMessage.CG_ADD_HOLE((this.view_grid_equip.vo as Vo_valuable).id_server,this.view_grid_item.vo.gridId,int((this.view_grid_item.vo as Vo_valuable).bBind),0);
            this._askType = 0;
         }
      }
      
      private function OperationHandle(e:MouseEvent) : void
      {
         var btn:Button = null;
         var str:String = null;
         var arr:Array = null;
         var temColor:int = 0;
         btn = e.target as Button;
         if(btn.label == LangConfig.getWord("165",0))
         {
            this.Tapping(btn);
         }
         else if(btn.label == LangConfig.getWord("174",0))
         {
            if(!this.vec_View_Grid[btn.tabIndex].vo)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("175",0));
               return;
            }
            str = Data_lib.cast_cost[Math.ceil((this.vec_View_Grid[btn.tabIndex].vo as Vo_item).lv)][Enum_lib_cast_cost.EQUIP_INLAY];
            arr = str.split("_");
            temColor = (this.view_grid_equip.vo as Vo_equip).color;
            if(temColor >= 5)
            {
               temColor = 4;
            }
            View_Alert.show(LangConfig.getWord("176",0) + String(arr[temColor - 1]) + LangConfig.getWord("177",0),View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
            {
               if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < arr[(view_grid_equip.vo as Vo_equip).color - 1])
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("178",0));
                  return;
               }
               inLay_index = btn.tabIndex;
               CastCGMessage.CG_INLAY((view_grid_equip.vo as Vo_valuable).id_server,btn.tabIndex + 1,vec_View_Grid[btn.tabIndex].vo.gridId,int((vec_View_Grid[btn.tabIndex].vo as Vo_valuable).bBind));
            },null,null,null,310,LangConfig.getWord("6",0),LangConfig.getWord("5",0),TextFormatAlign.LEFT);
         }
         else
         {
            str = Data_lib.cast_cost[Math.ceil((this.vec_View_Grid[btn.tabIndex].vo as Vo_item).lv)][Enum_lib_cast_cost.EQUIP_UNLOAD];
            arr = str.split("_");
            temColor = (this.view_grid_equip.vo as Vo_equip).color;
            if(temColor >= 5)
            {
               temColor = 4;
            }
            View_Alert.show(LangConfig.getWord("176",0) + String(arr[temColor - 1]) + LangConfig.getWord("179",0),View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
            {
               if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < arr[(view_grid_equip.vo as Vo_equip).color - 1])
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("180",0));
                  return;
               }
               unload_index = btn.tabIndex;
               CastCGMessage.CG_UNLOAD((view_grid_equip.vo as Vo_valuable).id_server,btn.tabIndex + 1);
            },null,null,null,310,LangConfig.getWord("6",0),LangConfig.getWord("5",0),TextFormatAlign.LEFT);
         }
      }
      
      override public function bagEmpthHandle(arr_gridId:Array) : void
      {
         var i:int = 0;
         var _temVec:Vector.<Vo_valuable> = null;
         if(this.type == 1)
         {
            if(Boolean(this.view_grid_equip))
            {
               if(Boolean(this.view_grid_equip.vo))
               {
                  i = 0;
                  while(i < arr_gridId.length)
                  {
                     if(this.view_grid_equip.vo.gridId == arr_gridId[i])
                     {
                        _temVec = CommandManager.get_bag_vec(Enum_filter.SEVER_ID,null,[(this.view_grid_equip.vo as Vo_equip).id_server]);
                        if(!_temVec)
                        {
                           this.view_grid_equip.vo = null;
                           this.return_data();
                        }
                     }
                     i++;
                  }
               }
            }
         }
      }
      
      override public function roleEmptyHandle(_gridId:int) : void
      {
         if(this.type == 2)
         {
            if(Boolean(this.view_grid_equip))
            {
               if(Boolean(this.view_grid_equip.vo))
               {
                  if(this.view_grid_equip.index == _gridId)
                  {
                     this.view_grid_equip.vo = null;
                     this.return_data();
                  }
               }
            }
         }
      }
      
      private function showBtn(hold_num:int, vec_stoneId:Vector.<int>) : void
      {
         this.handle_of(vec_stoneId,hold_num);
         this.addEventHandle();
      }
      
      private function handle_of(vec_stoneId:Vector.<int>, _num2:int) : void
      {
         var _num1:int = 0;
         var temId:int = 0;
         var temVo_item:Vo_item = null;
         if(!vec_stoneId)
         {
            _num1 = 0;
         }
         _num1 = int(vec_stoneId.length);
         if(_num1 > 0)
         {
            i = 0;
            while(i < _num1)
            {
               if(vec_stoneId[i] != 0)
               {
                  this.btn_arr[i].visible = true;
                  this.btn_arr[i].label = LangConfig.getWord("161",0);
                  temId = vec_stoneId[i];
                  temVo_item = new Vo_item();
                  temVo_item.id = temId;
                  temVo_item.Init_lib();
                  this.vec_View_Grid[i].type = Enum_type_grid.CAST_DISABLED;
                  this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_OPEN);
                  this.vec_View_Grid[i].set_bmp_over();
                  this.vec_View_Grid[i].vo = temVo_item;
                  if(this.vec_View_Grid[i].hasEventListener(MouseEvent.CLICK))
                  {
                     this.vec_View_Grid[i].removeEventListener(MouseEvent.CLICK,this.backItemHandle);
                  }
               }
               else
               {
                  this.btn_arr[i].visible = true;
                  this.btn_arr[i].label = LangConfig.getWord("174",0);
                  this.vec_View_Grid[i].type = Enum_type_grid.CAST;
                  this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_OPEN);
                  this.vec_View_Grid[i].set_tf_info(LangConfig.getWord("181",0));
                  this.vec_View_Grid[i].set_bmp_over();
               }
               ++i;
            }
         }
         if(_num2 >= 4)
         {
            return;
         }
         this.vec_View_Grid[_num2].set_bmp_bg(View_Grid.GRID_LOCK);
         this.vec_View_Grid[_num2].set_tf_info("");
         this.btn_arr[_num2].visible = true;
         this.btn_arr[_num2].label = LangConfig.getWord("165",0);
      }
      
      private function addEventHandle() : void
      {
         var temGrid:View_Grid = null;
         var i:int = 0;
         while(i < 4)
         {
            temGrid = this.vec_View_Grid[i];
            if(!temGrid.lock)
            {
               if(temGrid.type == Enum_type_grid.CAST)
               {
                  temGrid.addEventListener(MouseEvent.CLICK,this.backItemHandle);
               }
            }
            i++;
         }
      }
      
      private function backItemHandle(e:MouseEvent) : void
      {
         var temV:View_grid_extra = null;
         var i:int = 0;
         var temGrid:View_Grid = e.target as View_Grid;
         if(Boolean(temGrid.vo))
         {
            i = 0;
            while(i < vec_Vo_valuable_show_down.length)
            {
               temV = vec_View_grid_extra_down[i];
               if(temGrid.index == temV.index)
               {
                  temV.view_grid.vo = temGrid.vo;
                  temGrid.vo = null;
                  break;
               }
               i++;
            }
         }
      }
      
      private function CLICK_DOWN(e:MouseEvent) : void
      {
         var temLockNum:int = 0;
         var temIsSameTypeVo:Boolean = false;
         var temVoBool:Boolean = false;
         var temNumBool:Boolean = false;
         var temp:View_Grid = e.target as View_Grid;
         var temV:View_grid_extra = e.target.parent as View_grid_extra;
         if(this.view_grid_item.vo == temp.vo)
         {
            return;
         }
         if(temp.count == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("182",0));
            return;
         }
         if(temp.vo.id == 46051 || temp.vo.id == 46052 || temp.vo.id == 46053)
         {
            if(Boolean(this.view_grid_equip.vo))
            {
               if((this.view_grid_equip.vo as Vo_equip).cur_hole == 4)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("183",0));
                  return;
               }
            }
         }
         if(temp.vo.id == 46051 || temp.vo.id == 46052 || temp.vo.id == 46053)
         {
            if(Boolean(this.view_grid_item.vo))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("184",0));
               return;
            }
            this.view_grid_item.vo = temp.vo;
            this.view_grid_item.index = temV.index;
            if(Boolean(this.view_grid_item_now))
            {
               this.view_grid_item_now.bSelect = false;
            }
            this.view_grid_item_now = temp;
            this.view_grid_item_now.bSelect = true;
            --temp.count;
         }
         else
         {
            temLockNum = this.getLockGrid();
            if(temLockNum == -1)
            {
               temNumBool = this.handleOfEquipVo();
               if(temNumBool)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("186",0));
                  return;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("187",0));
               return;
            }
            temIsSameTypeVo = this.isSameTypeVo(temp.vo as Vo_item);
            if(temIsSameTypeVo)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("185",0));
               return;
            }
            temVoBool = this.getIsVo(temLockNum);
            if(temVoBool)
            {
               this.vec_View_Grid[temLockNum].vo = temp.vo;
               this.vec_View_Grid[temLockNum].index = temV.index;
               --temp.count;
            }
         }
      }
      
      private function isSameTypeVo(_vo:Vo_item) : Boolean
      {
         var i:int = 0;
         while(i < Vo_equip.MAX_HOLE)
         {
            if(Boolean(this.vec_View_Grid[i].vo))
            {
               if((this.vec_View_Grid[i].vo as Vo_item).type_result == _vo.type_result)
               {
                  return true;
               }
            }
            i++;
         }
         return false;
      }
      
      private function handleOfEquipVo() : Boolean
      {
         if(Boolean(this.view_grid_equip.vo))
         {
            if((this.view_grid_equip.vo as Vo_equip).cur_hole == 4)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getIsVo(_num:int) : Boolean
      {
         if(Boolean(this.vec_View_Grid[_num].vo))
         {
            return false;
         }
         return true;
      }
      
      private function getLockGrid() : int
      {
         var i:int = 0;
         while(i < Vo_equip.MAX_HOLE)
         {
            if(!this.vec_View_Grid[i].lock)
            {
               if(!this.vec_View_Grid[i].vo)
               {
                  return i;
               }
            }
            i++;
         }
         return -1;
      }
      
      private function ITEM_CANCEL(e:MouseEvent) : void
      {
         var i:int = 0;
         var temGrid:View_Grid = e.target as View_Grid;
         if(Boolean(this.view_grid_item.vo))
         {
            i = 0;
            while(i < vec_View_grid_extra_down.length)
            {
               if(temGrid.index == vec_View_grid_extra_down[i].index)
               {
                  ++vec_View_grid_extra_down[i].view_grid.count;
               }
               i++;
            }
            this.view_grid_item.vo = null;
            if(Boolean(this.view_grid_item_now))
            {
               this.view_grid_item_now.bSelect = false;
            }
            this.view_grid_item_now = null;
         }
      }
      
      public function return_data() : void
      {
         var i:int = 0;
         i = 0;
         while(i < this.vec_View_Grid.length)
         {
            this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_LOCK);
            this.vec_View_Grid[i].set_tf_info("");
            if(Boolean(this.vec_View_Grid[i].vo))
            {
               this.vec_View_Grid[i].vo = null;
            }
            i++;
         }
         i = 0;
         while(i < this.btn_arr.length)
         {
            this.btn_arr[i].visible = false;
            i++;
         }
         this.FeiYong_text.text = "0";
         this.ChengGongLv_text.text = "0%";
         if(Boolean(this.view_grid_equip))
         {
            this.view_grid_equip.vo = null;
         }
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         this.empty_vec_View_grid_cast_down();
      }
      
      public function successHold(result:int) : void
      {
         var str3:String = null;
         var eff1:Effect = null;
         var eff6:Effect = null;
         var eff8:Effect = null;
         if(this.isShowCheckBoxTips && this._askType == 1)
         {
            UIManager.centerBroadcast.addMsg(this.autoBuyTips);
         }
         if(result == 1)
         {
            str3 = "hold";
            UIManager.castPanel.setTabEnable(false);
            CastEffect.getEffect(str3,this.view_grid_equip,this);
            eff1 = EffectManager.addEffect("35063",this,1000,this.view_grid_item.x + this.view_grid_item.width / 2,this.view_grid_item.y + this.view_grid_item.height / 2);
            Tween.to(eff1,1000,{
               "px":[this.view_grid_item.x + this.view_grid_item.width / 2,this.vec_View_Grid[_tabIndex].x + this.vec_View_Grid[_tabIndex].width / 2],
               "py":[this.view_grid_item.y + this.view_grid_item.height / 2,this.vec_View_Grid[_tabIndex].y + this.vec_View_Grid[_tabIndex].height / 2]
            },this.compleHandle);
         }
         else if(result == 2)
         {
            CastEffect.getFailEffect("hold_fail",this.view_grid_equip,this);
            eff6 = EffectManager.addEffect("35065",this,500,this.view_grid_item.x + 15,this.view_grid_item.y + 16,false,2,this.endHandle);
            eff8 = EffectManager.addEffect("35066",this,500,this.view_grid_equip.x + this.view_grid_equip.width / 2 + 50,this.view_grid_equip.y + this.view_grid_equip.height - 56);
            this.update_success_copy();
         }
      }
      
      private function endHandle() : void
      {
         CastEffect.endHanlde();
      }
      
      private function compleHandle() : void
      {
         UIManager.castPanel.setTabEnable(true);
         var eff1:Effect = EffectManager.addEffect("35062",this,1200,this.vec_View_Grid[_tabIndex].x + this.vec_View_Grid[_tabIndex].width / 2 - 3,this.vec_View_Grid[_tabIndex].y + this.vec_View_Grid[_tabIndex].height / 2);
         this.update_success_copy();
         _tabIndex = 0;
      }
      
      override public function update_success_copy() : void
      {
         var temIdArr:Vector.<Vo_valuable> = null;
         if(Boolean(this.view_grid_item.vo))
         {
            this.view_grid_item.vo = null;
         }
         if(this.type == 1)
         {
            this.get_bag_data();
            temIdArr = CommandManager.get_bag_vec(Enum_filter.GRID_ID,null,[this.view_grid_equip.vo.gridId]);
            this.view_grid_equip.vo = temIdArr[0];
         }
         else
         {
            this.get_self_data();
            this.view_grid_equip.vo = UIManager.rolePanel.view_role_equip.get_item_index(this.view_grid_equip.index);
         }
         this.showBtn((this.view_grid_equip.vo as Vo_equip).cur_hole,(this.view_grid_equip.vo as Vo_equip).vec_gemId);
         this.show_gem();
         this.update_tf_cost();
         this.Show_down();
         this.auto_addTool();
      }
      
      public function updata_unLoad() : void
      {
         var i:int = 0;
         while(i < 4)
         {
            if(Boolean(this.vec_View_Grid[i].vo))
            {
               if(this.btn_arr[i].label != LangConfig.getWord("174",0))
               {
                  this.vec_View_Grid[i].vo = null;
               }
            }
            i++;
         }
         CastEffect.getEffect("unload",this.view_grid_equip,this);
         var temGrid:View_Grid = this.vec_View_Grid[this.unload_index];
         var eff6:Effect = EffectManager.addEffect("35065",this,500,temGrid.x + 15,temGrid.y + 16);
         this.operation_result();
      }
      
      public function update_inlay() : void
      {
         var temGrid:View_Grid = this.vec_View_Grid[this.inLay_index];
         CastEffect.getEffect("inlay",this.view_grid_equip,this);
         var eff1:Effect = EffectManager.addEffect("35062",this,1200,temGrid.x + temGrid.width / 2 - 3,temGrid.y + temGrid.height / 2);
         this.operation_result();
      }
      
      private function operation_result() : void
      {
         var temIdArr:Vector.<Vo_valuable> = null;
         var i:int = 0;
         while(i < 4)
         {
            this.btn_arr[i].visible = false;
            this.vec_View_Grid[i].type = Enum_type_grid.CAST;
            this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_LOCK);
            this.vec_View_Grid[i].set_tf_info("");
            i++;
         }
         if(this.type == 1)
         {
            this.get_bag_data();
            temIdArr = CommandManager.get_bag_vec(Enum_filter.GRID_ID,null,[this.view_grid_equip.vo.gridId]);
            this.view_grid_equip.vo = temIdArr[0];
         }
         else
         {
            this.get_self_data();
            this.view_grid_equip.vo = UIManager.rolePanel.view_role_equip.get_item_index(this.view_grid_equip.index);
         }
         this.showBtn((this.view_grid_equip.vo as Vo_equip).cur_hole,(this.view_grid_equip.vo as Vo_equip).vec_gemId);
         this.show_gem();
         this.update_tf_cost();
         this.Show_down();
         this.auto_addTool();
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

