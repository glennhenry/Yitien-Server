package com.yiTian.view.modules.cast
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.config.valuable.Enum_lib_attribute;
   import com.yiTian.data.model.Model_store;
   import com.yiTian.data.vo.Vo_equip;
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
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.comp.View_grid_extra;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   
   public class View_equip_ChengZhuang_jingLian extends View_cast_base
   {
      
      private static var defaultStrLvl:String;
      
      private static var defaultStrAtt:String;
      
      private static var modelGridId:int;
      
      private static var gridIdx:int;
      
      public static var needCount:int;
      
      private static const Refine_tf_obj:Object = {
         "x":192,
         "y":71,
         "color":16383744
      };
      
      private static const Refine_Attribute_tf_obj:Object = {
         "x":192,
         "y":92,
         "color":16043313
      };
      
      private static const madeBtn_pos:Object = {
         "x":248,
         "y":278,
         "textColor":16383744
      };
      
      private static const REFINE_EQUIP:int = 0;
      
      private static const REFINE_METIRIAL:int = 1;
      
      public static var changeType:int = 1;
      
      private static const SELF:int = 0;
      
      private static const BAG:int = 1;
      
      public static var instensify_type:int = 2;
      
      private static var isFirstOpen:Boolean = true;
      
      public static var isShowAnjingTips:Boolean = false;
      
      private static var equip_data_vec:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
      
      private var Refine_tf:MyTextField;
      
      private var Refine_Attribute_tf:MyTextField;
      
      private var grid_vec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var i:int;
      
      private var madeBtn:Button;
      
      private var tab_vec:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var langCon_tab:Array = new Array();
      
      private var langCon_grid:Array = new Array();
      
      private var cost_tf:MyTextField;
      
      private var rat_tf:MyTextField;
      
      private var now:TabButton;
      
      private var tfHelp_attri_obj:Object = {
         "x":108.15,
         "y":333.6,
         "color":14013822,
         "realWidth":191,
         "realHeight":140,
         "multiline":true,
         "wordWrap":true
      };
      
      private var self_data:Vector.<Vo_valuable>;
      
      private var bag_data:Vector.<Vo_valuable>;
      
      private var temGridArr:Vector.<View_Grid>;
      
      private var vec_now_data:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
      
      private var _clicliType:int = 1;
      
      private var gridId:Array = [[46412],[46413],[45217,46413]];
      
      private var view_grid_equip_now:View_Grid;
      
      private var view_grid_item_now:View_Grid;
      
      private var tf_help_descrip:MyTextField;
      
      public function View_equip_ChengZhuang_jingLian()
      {
         super();
      }
      
      override public function Init() : void
      {
         var tab:TabButton = null;
         var grid:View_Grid = null;
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
         ComponentUtil.getTextField(LangConfig.getWord("60053",6),this,{
            "x":153,
            "y":252,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60054",6),this,{
            "x":153,
            "y":270,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60056",6),this,{
            "x":211,
            "y":52,
            "color":15318372,
            "size":12,
            "leading":0
         });
         this.langCon_tab = [LangConfig.getWord("145",0),LangConfig.getWord("146",0)];
         this.langCon_grid = [LangConfig.getWord("944",0),LangConfig.getWord("945",0)];
         defaultStrLvl = HtmlUtil.font("0/0","#999999");
         defaultStrAtt = HtmlUtil.font(LangConfig.getWord("951",0) + " + 0","#999999");
         this.i = 0;
         while(this.i < 2)
         {
            tab = ComponentUtil.getTabButton(this.langCon_tab[this.i],"TabButton_Four",this,{
               "x":395 + 75 * this.i,
               "y":44,
               "textColor":16773818,
               "chooseColor":16773818
            },Global.Img_Cdm);
            tab.addEventListener(MouseEvent.CLICK,this.Switching);
            tab.index = this.i;
            this.tab_vec.push(tab);
            ++this.i;
         }
         this.tab_vec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         this.cost_tf = ComponentUtil.getTextField("10000",this,{
            "x":216,
            "y":270,
            "color":15318372
         });
         this.rat_tf = ComponentUtil.getTextField("100%",this,{
            "x":216,
            "y":252,
            "color":15318372
         });
         this.Refine_tf = ComponentUtil.getTextField("",this,Refine_tf_obj);
         this.Refine_Attribute_tf = ComponentUtil.getTextField("",this,Refine_Attribute_tf_obj);
         this.Refine_tf.htmlText = LangConfig.getWord("940",0) + defaultStrLvl;
         this.Refine_Attribute_tf.htmlText = LangConfig.getWord("941",0) + "：" + defaultStrAtt;
         this.i = 0;
         while(this.i < 2)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.CAST;
            grid.tabIndex = this.i;
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_info(HtmlUtil.font(LangConfig.getWord("943",0) + "\n" + this.langCon_grid[this.i],"#d5d57e"),grid.numChildren - 1);
            grid.set_bmp_select(null);
            addChild(grid);
            grid.x = 251;
            grid.y = 120 + this.i * 56;
            this.grid_vec.push(grid);
            grid.addEventListener(MouseEvent.CLICK,this.backHandle);
            ++this.i;
         }
         this.madeBtn = ComponentUtil.getButton("装备精练","Button_Orange",this,{
            "x":305,
            "y":258,
            "textColor":16184781
         },Global.Img_Cdm);
         this.madeBtn.callBack = this.czJingLian;
      }
      
      private function Switching(e:MouseEvent) : void
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
         if(Boolean(this.grid_vec.length))
         {
            this.grid_vec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         if(this.now.index == 0)
         {
            instensify_type = 2;
            this.get_self_data();
         }
         else
         {
            instensify_type = 1;
            this.get_bag_data();
         }
      }
      
      private function get_self_data() : void
      {
         this.self_data = new Vector.<Vo_valuable>();
         this.temGridArr = new Vector.<View_Grid>();
         if(Boolean(UIManager.rolePanel.view_role_equip))
         {
            this.temGridArr = UIManager.rolePanel.view_role_equip.getCZ_data();
         }
         var i:int = 0;
         while(i < this.temGridArr.length)
         {
            this.self_data.push(this.temGridArr[i].vo);
            i++;
         }
         this.vec_now_data = this.self_data;
         this.show_up_data(this.self_data,this.temGridArr);
      }
      
      private function czJingLian(e:MouseEvent) : void
      {
         if(!this.grid_vec[REFINE_EQUIP].vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("969",0));
            return;
         }
         if(!this.grid_vec[REFINE_METIRIAL].vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("970",0));
            return;
         }
         modelGridId = this.grid_vec[REFINE_EQUIP].vo.gridId;
         gridIdx = this.grid_vec[REFINE_EQUIP].index;
         this._clicliType = instensify_type;
         CastCGMessage.CG_CZ_REFINE((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).id_server,this.grid_vec[REFINE_METIRIAL].vo.id);
      }
      
      public function updata_refine() : void
      {
         UIManager.castPanel.setTabEnable(false);
         var eff1:Effect = EffectManager.addEffect("35063",this,600,this.grid_vec[REFINE_METIRIAL].x + this.grid_vec[REFINE_METIRIAL].width / 2,this.grid_vec[REFINE_METIRIAL].y + this.grid_vec[REFINE_METIRIAL].height / 2);
         Tween.to(eff1,600,{
            "px":[this.grid_vec[REFINE_METIRIAL].x + this.grid_vec[REFINE_METIRIAL].width / 2,this.grid_vec[REFINE_EQUIP].x + this.grid_vec[REFINE_EQUIP].width / 2],
            "py":[this.grid_vec[REFINE_METIRIAL].y + this.grid_vec[REFINE_METIRIAL].height / 2,this.grid_vec[REFINE_EQUIP].y + this.grid_vec[REFINE_EQUIP].height / 2]
         },this.compleHandle);
      }
      
      private function compleHandle() : void
      {
         var temNum:int = 0;
         var gridIdVec:Vector.<Vo_valuable> = null;
         UIManager.castPanel.setTabEnable(true);
         var eff1:Effect = EffectManager.addEffect("35062",this,600,this.grid_vec[REFINE_EQUIP].x + this.grid_vec[REFINE_EQUIP].width / 2 - 3,this.grid_vec[REFINE_EQUIP].y + this.grid_vec[REFINE_EQUIP].height / 2);
         if(this._clicliType != instensify_type)
         {
            this.grid_vec[0].vo = null;
            this.grid_vec[1].vo = null;
            return;
         }
         if(Boolean(modelGridId))
         {
            if(instensify_type == 1)
            {
               gridIdVec = CommandManager.get_bag_vec(Enum_filter.GRID_ID,null,[modelGridId]);
               this.grid_vec[REFINE_EQUIP].vo = gridIdVec[0];
            }
            else if(instensify_type == 2)
            {
               this.get_self_data();
               this.grid_vec[0].vo = UIManager.rolePanel.view_role_equip.get_item_index(gridIdx);
            }
         }
         if(Boolean(this.grid_vec[REFINE_EQUIP].vo as Vo_valuable))
         {
            if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color >= 5)
            {
               if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).lv_use < 110 || (this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color == 6)
               {
                  temNum = 1;
               }
               else
               {
                  temNum = 2;
               }
            }
            else
            {
               temNum = 0;
            }
         }
         this.Show_down(temNum);
         this.addTF();
         if(Boolean(this.grid_vec[REFINE_EQUIP].vo) && Boolean((this.grid_vec[REFINE_EQUIP].vo as Vo_equip).color >= 5) && (this.grid_vec[REFINE_EQUIP].vo as Vo_equip).lv_use >= 110)
         {
            this.grid_vec[REFINE_METIRIAL].vo = null;
            return;
         }
         this.addCount();
         this.autoAddTool();
      }
      
      private function backHandle(e:MouseEvent) : void
      {
         var grid:View_Grid = e.target as View_Grid;
         if(!grid.vo)
         {
            return;
         }
         switch(grid.tabIndex)
         {
            case 0:
               grid.vo = null;
               this.empty_vec_View_grid_cast_down();
               break;
            case 1:
               this.itemCancel();
         }
      }
      
      private function get_bag_data() : void
      {
         this.bag_data = new Vector.<Vo_valuable>();
         this.bag_data = CommandManager.get_bag_vec(Enum_filter.CZ_EQUIP);
         this.vec_now_data = this.bag_data;
         this.show_up_data(this.bag_data);
      }
      
      private function showBmp() : void
      {
         var bg1:Bitmap = ComponentUtil.getBitmap("Forging_Back2",this,{
            "x":155,
            "y":49
         },Global.Forging_Imgsdm);
         var bg2:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":165,
            "y":51,
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
            this.tab_vec[0].choose = true;
            this.now = this.tab_vec[0];
            instensify_type = 2;
            this.get_self_data();
            if(isFirstOpen)
            {
               isFirstOpen = false;
               isShowAnjingTips = true;
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
            GameScene.instance.addFrameCallBack(this.frameCallHandle);
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.frameCallHandle);
            this.reset();
            if(isShowAnjingTips)
            {
               AnjinITemUseTips.removeTip();
            }
         }
      }
      
      private function frameCallHandle(interenal:int) : void
      {
         var temNum:int = 0;
         var colorStr:String = null;
         var max:int = 0;
         var vo_item:Vo_item = null;
         if(this.grid_vec[REFINE_EQUIP].vo == null)
         {
            this.grid_vec[REFINE_METIRIAL].vo = null;
            if(Boolean(this.grid_vec[REFINE_METIRIAL].vo))
            {
               this.itemCancel();
            }
            this.cost_tf.text = "0";
            this.rat_tf.text = "0%";
            this.Refine_tf.htmlText = LangConfig.getWord("940",0) + defaultStrLvl;
            this.Refine_Attribute_tf.htmlText = LangConfig.getWord("941",0) + "：" + defaultStrAtt;
            this.Refine_tf.visible = false;
            this.Refine_Attribute_tf.visible = false;
            this.grid_vec[REFINE_EQUIP].set_tf_info(HtmlUtil.font(LangConfig.getWord("943",0) + "\n" + this.langCon_grid[0],"#d5d57e"),this.grid_vec[REFINE_EQUIP].numChildren - 1);
         }
         if(Boolean(this.grid_vec[REFINE_EQUIP].vo))
         {
            if((this.grid_vec[REFINE_EQUIP].vo as Vo_equip).color >= 5 && (Boolean(this.grid_vec[REFINE_METIRIAL].vo) && Boolean(this.grid_vec[REFINE_METIRIAL].vo.id != 45217)))
            {
               this.Refine_tf.visible = true;
               this.Refine_Attribute_tf.visible = true;
            }
            else
            {
               this.Refine_tf.visible = false;
               this.Refine_Attribute_tf.visible = false;
            }
            if(this.grid_vec[REFINE_METIRIAL].vo == null)
            {
               vo_item = new Vo_item();
               if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color >= 5)
               {
                  if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).lv_use >= 110 && (this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color == 5)
                  {
                     vo_item = null;
                  }
                  else
                  {
                     max = int(Data_lib.cz_refine[(this.grid_vec[REFINE_EQUIP].vo as Vo_equip).jingLianCount][0]);
                     temNum = Model_store.getCount(46413);
                     vo_item.id = 46413;
                     vo_item.Init_lib();
                  }
               }
               else
               {
                  max = 10;
                  temNum = Model_store.getCount(46412);
                  vo_item.id = 46412;
                  vo_item.Init_lib();
               }
               if(temNum < max)
               {
                  colorStr = "#ff0000";
               }
               else
               {
                  temNum = max;
                  colorStr = "#f4cd31";
               }
               needCount = temNum;
               this.grid_vec[REFINE_METIRIAL].vo = vo_item;
               this.grid_vec[REFINE_METIRIAL].set_tf_info(HtmlUtil.font("\n" + String(temNum) + "/" + max,colorStr),this.grid_vec[REFINE_METIRIAL].numChildren - 1);
            }
         }
         var __vo:Vo_item = this.grid_vec[REFINE_METIRIAL].vo as Vo_item;
         var __voE:Vo_equip = this.grid_vec[REFINE_EQUIP].vo as Vo_equip;
         if(__vo == null)
         {
            this.grid_vec[REFINE_METIRIAL].set_tf_info(HtmlUtil.font(LangConfig.getWord("943",0) + "\n" + this.langCon_grid[1],"#d5d57e"));
            this.cost_tf.text = "0";
            this.rat_tf.text = "0%";
         }
      }
      
      private function empty_vec_View_grid_cast_up() : void
      {
         if(!DATA_LENG)
         {
            return;
         }
         this.i = DATA_LENG - 1;
         while(this.i > -1)
         {
            vec_View_grid_extra_up[this.i].view_grid.removeEventListener(MouseEvent.CLICK,this.CLICK_UP);
            canvas_up.removeChild(vec_View_grid_extra_up[this.i]);
            vec_View_grid_extra_up[this.i].view_grid.empty();
            pool.push(vec_View_grid_extra_up[this.i]);
            vec_View_grid_extra_up.pop();
            --this.i;
         }
         DATA_LENG = 0;
      }
      
      private function show_up_data(arr:Vector.<Vo_valuable>, arr2:Vector.<View_Grid> = null) : void
      {
         var v:View_grid_extra = null;
         this.empty_vec_View_grid_cast_up();
         if(!arr)
         {
            return;
         }
         DATA_LENG = arr.length;
         this.i = 0;
         while(this.i < arr.length)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_tf_count();
            if(Boolean(arr2))
            {
               v.Show(arr[this.i],View_grid_extra.CZ_JINGLIAN,arr2[this.i]);
            }
            else
            {
               v.Show(arr[this.i],View_grid_extra.CZ_JINGLIAN);
            }
            if(this.i % 2 == 0)
            {
               v.x = GAP_X;
            }
            else
            {
               v.x = GAP_XL;
            }
            v.y = INDENT + int(this.i / 2) * 43;
            canvas_up.addChild(v);
            v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_UP);
            vec_View_grid_extra_up.push(v);
            ++this.i;
         }
         canvas_up.reset();
         canvas_up.align();
      }
      
      private function CLICK_UP(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         this.getClickGrid(temp);
      }
      
      override public function getClickGrid(temp:View_Grid) : void
      {
         var temNum:int = 0;
         if(!temp)
         {
            return;
         }
         if(this.grid_vec[REFINE_EQUIP].vo == temp.vo)
         {
            return;
         }
         if(Boolean(this.grid_vec[REFINE_METIRIAL].vo))
         {
            this.grid_vec[REFINE_METIRIAL].vo = null;
         }
         if((temp.vo as Vo_equip).maxRefine == (temp.vo as Vo_equip).jingLianCount && (temp.vo as Vo_equip).color == 5 && (temp.vo as Vo_equip).maxRefine != 0 && (temp.vo as Vo_equip).lv_use < 110)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("971",0));
            return;
         }
         if(Boolean(this.view_grid_equip_now))
         {
            this.view_grid_equip_now.bSelect = false;
         }
         this.grid_vec[REFINE_EQUIP].vo = temp.vo;
         this.grid_vec[REFINE_EQUIP].index = temp.index;
         this.view_grid_equip_now = temp;
         this.view_grid_equip_now.bSelect = true;
         if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color >= 5)
         {
            if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).lv_use < 110 || (this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color == 6)
            {
               temNum = 1;
            }
            else
            {
               temNum = 2;
            }
         }
         else
         {
            temNum = 0;
         }
         this.addCount();
         this.Show_down(temNum);
         if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color == 5 && (this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).lv_use >= 110)
         {
            return;
         }
         this.autoAddTool();
         this.addTF();
      }
      
      private function addCount() : void
      {
         var temNum:int = 0;
         var colorStr:String = null;
         var max:int = 0;
         if(Boolean(this.grid_vec[REFINE_EQUIP].vo as Vo_valuable))
         {
            if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color >= 5)
            {
               if(!(this.grid_vec[REFINE_EQUIP].vo as Vo_equip))
               {
                  return;
               }
               if(Boolean(this.grid_vec[REFINE_METIRIAL].vo) && this.grid_vec[REFINE_METIRIAL].vo.id == 45217)
               {
                  max = int(Data_lib.EquipBlackGlod[(this.grid_vec[REFINE_EQUIP].vo as Vo_equip).type][1]);
                  temNum = Model_store.getCount(45217);
               }
               else
               {
                  max = int(Data_lib.cz_refine[(this.grid_vec[REFINE_EQUIP].vo as Vo_equip).jingLianCount][0]);
                  temNum = Model_store.getCount(46413);
               }
            }
            else
            {
               max = 10;
               temNum = Model_store.getCount(46412);
            }
         }
         if(temNum < max)
         {
            colorStr = "#ff0000";
         }
         else
         {
            temNum = max;
            colorStr = "#f4cd31";
         }
         needCount = temNum;
         this.grid_vec[REFINE_METIRIAL].set_tf_info(HtmlUtil.font("\n" + String(temNum) + "/" + max,colorStr),this.grid_vec[REFINE_METIRIAL].numChildren - 1);
         this.addTF();
      }
      
      private function addTF() : void
      {
         var value:int = 0;
         var __vo:Vo_item = null;
         var vv:int = 0;
         var vo:Vo_equip = this.grid_vec[0].vo as Vo_equip;
         if(!vo)
         {
            return;
         }
         if(vo.color == 4)
         {
            this.cost_tf.text = "100000";
         }
         else if(vo.color >= 5)
         {
            __vo = this.grid_vec[REFINE_METIRIAL].vo as Vo_item;
            if(Boolean(__vo) && __vo.id == 45217)
            {
               this.cost_tf.text = Data_lib.EquipBlackGlod[vo.type][0];
            }
            else
            {
               this.cost_tf.text = Data_lib.cz_refine[vo.jingLianCount][1];
            }
         }
         this.rat_tf.text = "100%";
         this.Refine_tf.htmlText = LangConfig.getWord("940",0) + HtmlUtil.font(vo.jingLianCount + "/" + vo.maxRefine,ColorConstant.getColorStr(ColorConstant.ORANGE));
         var i:int = 0;
         var str:String = "";
         var per:Number = 0;
         if(vo.color == 6)
         {
            per = Number(Data_lib.EquipBlackGlod[vo.type][2]);
         }
         while(i < vo.cz_insten_vec.length)
         {
            vv = vo.cz_insten_vec[i + 1] * 1 / (1 + per);
            str += HtmlUtil.font(this.getAttribute(vo.cz_insten_vec[i],vv),ColorConstant.getColorStr(ColorConstant.ORANGE));
            value = vo.cz_insten_vec[i + 1] - vv;
            if(value > vv)
            {
               value = vv;
            }
            i += 2;
         }
         if(str == "")
         {
            str = LangConfig.getWord("60057",6);
         }
         if(vo.color == 6)
         {
            this.Refine_Attribute_tf.htmlText = LangConfig.getWord("941",0) + "：" + str + "  +" + value;
         }
         else
         {
            this.Refine_Attribute_tf.htmlText = LangConfig.getWord("941",0) + "：" + str;
         }
      }
      
      private function getAttribute(id_attribute:int, value:int) : String
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
      
      private function autoAddTool() : void
      {
         this.view_grid_item_now = null;
         this.grid_vec[REFINE_METIRIAL].vo = null;
         if(vec_Vo_valuable_show_down.length > 0)
         {
            if(vec_Vo_valuable_show_down[0].count == 0)
            {
               return;
            }
            this.i = 0;
            while(this.i < vec_Vo_valuable_show_down.length)
            {
               if(vec_Vo_valuable_show_down[this.i].bBind == false)
               {
                  this.view_grid_item_now = vec_View_grid_extra_down[this.i].view_grid;
                  this.grid_vec[REFINE_METIRIAL].vo = this.view_grid_item_now.vo;
                  return;
               }
               ++this.i;
            }
            this.view_grid_item_now = vec_View_grid_extra_down[0].view_grid;
            this.grid_vec[REFINE_METIRIAL].vo = this.view_grid_item_now.vo;
         }
      }
      
      private function Show_down(_num:int) : void
      {
         var v:View_grid_extra = null;
         var _point:Point = null;
         var i:int = 0;
         this.empty_vec_View_grid_cast_down();
         vec_Vo_valuable_show_down = CommandManager.get_bag_vec(Enum_filter.ID,null,this.gridId[_num]);
         if(vec_Vo_valuable_show_down.length == 0)
         {
            return;
         }
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
            v.y = INDENT + int(i / 2) * 43;
            canvas_down.addChild(v);
            v.Show(vec_Vo_valuable_show_down[i],View_grid_extra.HOLE);
            v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_DOWN);
            vec_View_grid_extra_down.push(v);
            i++;
         }
         canvas_down.reset();
         canvas_down.align();
         i = 0;
         while(i < vec_View_grid_extra_down.length)
         {
            if(((vec_View_grid_extra_down[i] as View_grid_extra).view_grid.vo as Vo_valuable).id == 45217)
            {
               _point = new Point(vec_View_grid_extra_down[i].x + 20 + canvas_down.x,vec_View_grid_extra_down[i].y + 40 + canvas_down.y);
               break;
            }
            i++;
         }
         if(Boolean(_point) && isShowAnjingTips)
         {
            AnjinITemUseTips.addTip(_point,parent);
         }
      }
      
      private function empty_vec_View_grid_cast_down() : void
      {
         if(!vec_View_grid_extra_down)
         {
            return;
         }
         this.i = vec_View_grid_extra_down.length - 1;
         while(this.i > -1)
         {
            vec_View_grid_extra_down[this.i].view_grid.removeEventListener(MouseEvent.CLICK,this.CLICK_DOWN);
            canvas_down.removeChild(vec_View_grid_extra_down[this.i]);
            vec_View_grid_extra_down[this.i].view_grid.empty();
            pool.push(vec_View_grid_extra_down[this.i]);
            vec_View_grid_extra_down.pop();
            --this.i;
         }
      }
      
      private function CLICK_DOWN(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         this.grid_vec[REFINE_METIRIAL].vo = temp.vo;
         this.addCount();
         if(isShowAnjingTips)
         {
            AnjinITemUseTips.removeTip();
         }
      }
      
      private function itemCancel() : void
      {
      }
      
      override public function display() : void
      {
         tbbtn_bought.visible = false;
         canvas_txt.visible = false;
         if(!this.tf_help_descrip)
         {
            this.tf_help_descrip = ComponentUtil.getTextField("",this,{
               "x":157,
               "y":312 - 18,
               "leading":4,
               "color":14013822
            });
         }
         this.tf_help_descrip.mouseEnabled = true;
         this.tf_help_descrip.addEventListener(TextEvent.LINK,function():void
         {
            if(GameUnitManager.hero.level < 30)
            {
               UIManager.centerBroadcast.addMsg("等级不够30级");
               return;
            }
            UIManager.sm_shop.visible = true;
         });
         this.tf_help_descrip.htmlText = "1." + HtmlUtil.font("50级以上","#ff7700") + "的紫装通过橙装精炼会变成\n   " + HtmlUtil.font("橙色品质","#ff7700") + "，属性大幅提升\n2.精炼等级越高，属性提升越多\n3." + HtmlUtil.font("110级以上","#ff7700") + "橙装用" + HtmlUtil.font("暗金石","#ff7700") + "精炼为暗金装\n   备，增加橙装强化百分比\n4." + HtmlUtil.font("天橙石","#ff7700") + "通过万安寺和通天峰产出；" + HtmlUtil.font("附橙\n   石","#ff7700") + "可通过秘境刷出；" + HtmlUtil.font("暗金石","#ff7700") + "在地狱万安\n   寺产出。";
      }
      
      public function getGridPos() : Point
      {
         return localToGlobal(new Point(this.grid_vec[REFINE_METIRIAL].x,this.grid_vec[REFINE_METIRIAL].y));
      }
      
      override public function update() : void
      {
      }
      
      override public function update_success_copy() : void
      {
      }
      
      override public function update_upAndDown() : void
      {
         var temNum:int = 0;
         if(instensify_type == 1)
         {
            this.get_bag_data();
         }
         else
         {
            this.get_self_data();
         }
         if(Boolean(this.grid_vec[REFINE_EQUIP].vo))
         {
            if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color >= 5)
            {
               if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).lv_use < 110 || (this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color == 6)
               {
                  temNum = 1;
               }
               else
               {
                  temNum = 2;
               }
            }
            else
            {
               temNum = 0;
            }
            this.Show_down(temNum);
            this.addCount();
         }
      }
      
      override public function changeEquipSelf(_equips:Array = null) : void
      {
      }
      
      override public function changeEquipBag(_equips:Array = null) : void
      {
      }
      
      override public function bagEmpthHandle(arr_gridId:Array) : void
      {
      }
      
      override public function roleEmptyHandle(gridId:int) : void
      {
      }
      
      override public function hide() : void
      {
      }
      
      override public function re_set() : void
      {
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
      
      override public function setClickType(type_index:int) : void
      {
         if(type_index == 2)
         {
            this.tab_vec[SELF].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else if(type_index == 1)
         {
            this.tab_vec[BAG].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      override public function reset() : void
      {
         this.empty_vec_View_grid_cast_up();
         this.empty_vec_View_grid_cast_down();
         if(Boolean(this.grid_vec.length))
         {
            this.grid_vec[REFINE_EQUIP].vo = null;
            this.grid_vec[REFINE_METIRIAL].vo = null;
         }
      }
   }
}

