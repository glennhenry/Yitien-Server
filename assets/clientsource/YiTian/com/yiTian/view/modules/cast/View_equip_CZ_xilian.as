package com.yiTian.view.modules.cast
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.model.Model_store;
   import com.yiTian.data.vo.Vo_Skill;
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
   
   public class View_equip_CZ_xilian extends View_cast_base
   {
      
      public static var modelGridId:int;
      
      public static var gridIdx:int;
      
      private static var poX:int;
      
      private static var poY:int;
      
      private static const REFINE_EQUIP:int = 0;
      
      private static const REFINE_METIRIAL:int = 1;
      
      private static const madeBtn_pos:Object = {
         "x":248,
         "y":278,
         "textColor":16383744
      };
      
      public static var instensify_type:int = 2;
      
      public static var isCheck:Boolean = false;
      
      public static var isPosSKi:Boolean = false;
      
      private static var isFirstOpen:Boolean = true;
      
      private var grid_vec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var langCon_grid:Array = new Array();
      
      private var langCon_tab:Array = new Array();
      
      private var tab_vec:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var i:int;
      
      private var skillGrid:View_Grid;
      
      private var cost_tf:MyTextField;
      
      private var rat_tf:MyTextField;
      
      private var madeBtn:Button;
      
      private var now:TabButton;
      
      private var self_data:Vector.<Vo_valuable>;
      
      private var bag_data:Vector.<Vo_valuable>;
      
      private var temGridArr:Vector.<View_Grid>;
      
      private var vec_now_data:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
      
      private var view_grid_equip_now:View_Grid;
      
      private var view_grid_item_now:View_Grid;
      
      private var tf_help_descrip:MyTextField;
      
      private var tfHelp_attri_obj:Object = {
         "x":155,
         "y":315,
         "color":11904647,
         "realWidth":191,
         "realHeight":140,
         "multiline":true,
         "wordWrap":true
      };
      
      public function View_equip_CZ_xilian()
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
            "x":212,
            "y":52,
            "color":15318372,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60059",6),this,{
            "x":227,
            "y":156,
            "color":15318372,
            "size":12,
            "leading":0
         });
         this.langCon_grid = [LangConfig.getWord("944",0),LangConfig.getWord("945",0)];
         this.langCon_tab = [LangConfig.getWord("145",0),LangConfig.getWord("146",0)];
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
         this.madeBtn = ComponentUtil.getButton("装备精练","Button_Orange",this,{
            "x":298,
            "y":258,
            "textColor":16184781
         },Global.Img_Cdm);
         this.madeBtn.callBack = this.cz_xilianHandle;
         this.i = 0;
         while(this.i < 2)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_tf_info(HtmlUtil.font(LangConfig.getWord("943",0) + "\n" + this.langCon_grid[this.i],"#d5d57e"));
            addChild(grid);
            grid.x = 196 + this.i * 104;
            grid.y = 95;
            grid.tabIndex = this.i;
            this.grid_vec.push(grid);
            grid.addEventListener(MouseEvent.CLICK,this.cancalHandle);
            ++this.i;
         }
         this.skillGrid = new View_Grid();
         this.skillGrid.setTFstyle(false);
         this.skillGrid.set_bmp_bg();
         this.skillGrid.set_bmp_over(true,null);
         this.skillGrid.set_bmp_select();
         this.skillGrid.set_tf_count(true,false,true);
         this.skillGrid.set_tf_info(HtmlUtil.font(LangConfig.getWord("972",0),"#faff00") + "\n" + HtmlUtil.font(LangConfig.getWord("973",0),"#faff00"),3,false);
         this.skillGrid.x = 251;
         this.skillGrid.y = 192;
         addChild(this.skillGrid);
         poX = this.skillGrid.x + this.skillGrid.width / 2;
         poY = this.skillGrid.y + this.skillGrid.height / 2;
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
      
      private function cz_xilianHandle(e:MouseEvent) : void
      {
         if(!this.grid_vec[REFINE_EQUIP].vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("974",0));
            return;
         }
         if(!this.grid_vec[REFINE_METIRIAL].vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("975",0));
            return;
         }
         var vo:Vo_equip = this.grid_vec[REFINE_EQUIP].vo as Vo_equip;
         if(!isCheck)
         {
            UIManager.tishi_sms.updata_txt_skill(LangConfig.getWord("976",0),this.yesHandle);
         }
         else
         {
            this.yesHandle();
         }
      }
      
      private function yesHandle() : void
      {
         modelGridId = this.grid_vec[REFINE_EQUIP].vo.gridId;
         gridIdx = this.grid_vec[REFINE_EQUIP].index;
         isPosSKi = true;
         CastCGMessage.CG_CZ_XILIAN((this.grid_vec[REFINE_EQUIP].vo as Vo_equip).id_server,this.grid_vec[REFINE_METIRIAL].vo.gridId);
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
         var bg3:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":185,
            "y":155,
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
            GameScene.instance.addFrameCallBack(this.framHandle);
         }
         else
         {
            this.reset();
            GameScene.instance.removeFrameCallBack(this.framHandle);
         }
      }
      
      private function framHandle(interenal:int) : void
      {
         var vo_item:Vo_item = null;
         if(this.grid_vec[REFINE_EQUIP].vo == null)
         {
            this.grid_vec[REFINE_METIRIAL].vo = null;
            this.skillGrid.vo = null;
            this.cost_tf.text = "0";
            this.rat_tf.text = "0%";
            this.grid_vec[REFINE_METIRIAL].set_tf_info(HtmlUtil.font(LangConfig.getWord("943",0) + "\n" + this.langCon_grid[1],"#d5d57e"),this.grid_vec[REFINE_EQUIP].numChildren - 1);
         }
         if(this.grid_vec[REFINE_METIRIAL].vo == null)
         {
            this.view_grid_item_now = null;
         }
         var count:int = 1;
         if(Boolean(this.grid_vec[REFINE_EQUIP].vo))
         {
            if(this.grid_vec[REFINE_METIRIAL].vo == null)
            {
               vo_item = new Vo_item();
               if(this.grid_vec[REFINE_METIRIAL].vo == null)
               {
                  vo_item.id = 46413;
                  vo_item.Init_lib();
               }
               if((this.grid_vec[REFINE_EQUIP].vo as Vo_equip).color == 6)
               {
                  count = 2;
               }
               this.grid_vec[REFINE_METIRIAL].vo = vo_item;
               this.grid_vec[REFINE_METIRIAL].set_tf_info(HtmlUtil.font("\n" + String(0) + "/" + count,"#ff0000"),this.grid_vec[REFINE_METIRIAL].numChildren - 1);
            }
         }
         if(Boolean(this.skillGrid.vo))
         {
            this.skillGrid.count = (this.grid_vec[REFINE_EQUIP].vo as Vo_equip).skillLvl;
         }
         if(Boolean(this.view_grid_item_now))
         {
            if(this.view_grid_item_now.count < 0)
            {
               this.view_grid_item_now.count = 0;
            }
         }
      }
      
      public function cancalHandle(e:MouseEvent) : void
      {
         switch((e.target as View_Grid).tabIndex)
         {
            case 0:
               this.equipCancel();
               break;
            case 1:
               this.itemCancel();
         }
      }
      
      private function equipCancel() : void
      {
         this.grid_vec[REFINE_EQUIP].vo = null;
         this.empty_vec_View_grid_cast_down();
      }
      
      private function itemCancel() : void
      {
      }
      
      public function updata_cz_polish() : void
      {
         UIManager.castPanel.setTabEnable(false);
         var eff1:Effect = EffectManager.addEffect("35063",this,600,this.grid_vec[REFINE_METIRIAL].x + this.grid_vec[REFINE_METIRIAL].width / 2,this.grid_vec[REFINE_METIRIAL].y + this.grid_vec[REFINE_METIRIAL].height / 2);
         Tween.to(eff1,800,{
            "px":[this.grid_vec[REFINE_METIRIAL].x + this.grid_vec[REFINE_METIRIAL].width / 2,poX],
            "py":[this.grid_vec[REFINE_METIRIAL].y + this.grid_vec[REFINE_METIRIAL].height / 2,poY]
         },this.compleHandle);
      }
      
      private function compleHandle() : void
      {
         var temNum:int = 0;
         var gridIdVec:Vector.<Vo_valuable> = null;
         UIManager.castPanel.setTabEnable(true);
         var eff1:Effect = EffectManager.addEffect("35062",this,800,this.skillGrid.x + this.skillGrid.width / 2 - 3,this.skillGrid.y + this.skillGrid.height / 2);
         if(Boolean(modelGridId))
         {
            if(instensify_type == 1)
            {
               gridIdVec = CommandManager.get_bag_vec(Enum_filter.GRID_ID,null,[modelGridId]);
               if(!gridIdVec.length)
               {
                  return;
               }
               this.grid_vec[REFINE_EQUIP].vo = gridIdVec[0];
            }
            else if(instensify_type == 2)
            {
               this.get_self_data();
               this.grid_vec[REFINE_EQUIP].vo = UIManager.rolePanel.view_role_equip.get_item_index(gridIdx);
            }
         }
         if(Boolean(this.grid_vec[REFINE_EQUIP].vo) && (this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color == 5)
         {
            temNum = 1;
         }
         else
         {
            temNum = 0;
         }
         this.autoGetTool();
         this.autoAddSkill();
         isPosSKi = false;
      }
      
      private function get_self_data() : void
      {
         this.self_data = new Vector.<Vo_valuable>();
         this.temGridArr = new Vector.<View_Grid>();
         if(Boolean(UIManager.rolePanel.view_role_equip))
         {
            this.temGridArr = UIManager.rolePanel.view_role_equip.getC_data();
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
      
      private function get_bag_data() : void
      {
         this.bag_data = new Vector.<Vo_valuable>();
         this.bag_data = CommandManager.get_bag_vec(Enum_filter.CG_XILIAN_EQUIP);
         this.vec_now_data = this.bag_data;
         this.show_up_data(this.bag_data);
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
         if(!temp)
         {
            return;
         }
         if(this.grid_vec[REFINE_EQUIP].vo == temp.vo)
         {
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
         if(Boolean(this.grid_vec[REFINE_METIRIAL].vo))
         {
            this.grid_vec[REFINE_METIRIAL].vo = null;
         }
         this.Show_down();
         this.autoGetTool();
         this.autoAddSkill();
         this.addCost();
      }
      
      private function addCost() : void
      {
         if((this.grid_vec[REFINE_EQUIP].vo as Vo_equip).color == 6)
         {
            this.cost_tf.text = "300000";
         }
         else
         {
            this.cost_tf.text = "50000";
         }
         this.rat_tf.text = "100%";
      }
      
      private function autoAddSkill() : void
      {
         this.skillGrid.vo = null;
         var vo:Vo_equip = this.grid_vec[REFINE_EQUIP].vo as Vo_equip;
         if(!vo)
         {
            return;
         }
         if(!vo.skillId)
         {
            return;
         }
         var skill:Vo_Skill = new Vo_Skill(vo.skillId);
         skill.isSpecial = true;
         this.skillGrid.vo = skill;
         this.skillGrid.type = vo.skillLvl;
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
      
      private function autoGetTool() : void
      {
         var max:int = 0;
         var temNum:int = 0;
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
                  this.grid_vec[REFINE_METIRIAL].set_tf_info(HtmlUtil.font("\n" + String(1) + "/" + 1,"#f4cd31"),this.grid_vec[REFINE_METIRIAL].numChildren - 1);
                  this.view_grid_item_now.bSelect = true;
                  --this.view_grid_item_now.count;
                  break;
               }
               ++this.i;
            }
            this.view_grid_item_now = vec_View_grid_extra_down[0].view_grid;
            this.grid_vec[REFINE_METIRIAL].vo = this.view_grid_item_now.vo;
            max = 1;
            temNum = 1;
            if(Boolean(this.grid_vec[REFINE_EQUIP].vo) && (this.grid_vec[REFINE_EQUIP].vo as Vo_equip).color == 6)
            {
               temNum = Model_store.getCount(46413);
               max = 2;
            }
            this.grid_vec[REFINE_METIRIAL].set_tf_info(HtmlUtil.font("\n" + temNum + "/" + max,"#f4cd31"),this.grid_vec[REFINE_METIRIAL].numChildren - 1);
            this.view_grid_item_now.bSelect = true;
            --this.view_grid_item_now.count;
         }
      }
      
      private function CLICK_DOWN(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         if(this.grid_vec[REFINE_METIRIAL].vo == temp.vo)
         {
            return;
         }
         if(Boolean(this.view_grid_item_now))
         {
            ++this.view_grid_item_now.count;
            this.view_grid_item_now.bSelect = false;
         }
         this.grid_vec[REFINE_METIRIAL].vo = temp.vo;
         temp.bSelect = true;
         --temp.count;
         this.view_grid_item_now = temp;
      }
      
      private function Show_down() : void
      {
         var v:View_grid_extra = null;
         this.empty_vec_View_grid_cast_down();
         vec_Vo_valuable_show_down = CommandManager.get_bag_vec(Enum_filter.ID,null,[46413]);
         if(vec_Vo_valuable_show_down.length == 0)
         {
            return;
         }
         this.i = 0;
         while(this.i < vec_Vo_valuable_show_down.length)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_bmp_select();
            v.view_grid.set_tf_count(true,true,true);
            if(this.i % 2 == 0)
            {
               v.x = GAP_X;
            }
            else
            {
               v.x = GAP_XL;
            }
            v.y = INDENT + int(this.i / 2) * 43;
            canvas_down.addChild(v);
            v.Show(vec_Vo_valuable_show_down[this.i],View_grid_extra.HOLE);
            v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_DOWN);
            vec_View_grid_extra_down.push(v);
            ++this.i;
         }
         canvas_down.reset();
         canvas_down.align();
      }
      
      override public function display() : void
      {
         tbbtn_bought.visible = false;
         canvas_txt.visible = false;
         if(!this.tf_help_descrip)
         {
            this.tf_help_descrip = ComponentUtil.getTextField("",this,{
               "x":157,
               "y":312 - 15,
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
         this.tf_help_descrip.htmlText = "1.橙装洗练只可洗出各职业技能，只有\n   符合自身职业的技能才有效果\n2.当两件装备出现同一种技能时可相互\n   叠加\n3.橙装洗练的" + HtmlUtil.font("附橙石","#ff7700") + "可通过" + HtmlUtil.font(HtmlUtil.link(HtmlUtil.underLine("秘境"),"ss"),"#04ff00") + "刷出\n4.暗金装备有一定几率洗出2级、3\n   级技能。";
      }
      
      override public function update() : void
      {
      }
      
      override public function update_success_copy() : void
      {
      }
      
      override public function changeEquipSelf(_equips:Array = null) : void
      {
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
         if(Boolean(this.grid_vec[REFINE_EQUIP]))
         {
            if(instensify_type == 1)
            {
               if(Boolean(this.grid_vec[REFINE_EQUIP].vo))
               {
                  if((this.grid_vec[REFINE_EQUIP].vo as Vo_equip).id_server == _equips[0][0])
                  {
                     this.grid_vec[REFINE_EQUIP].vo = null;
                     return;
                  }
               }
            }
         }
      }
      
      override public function update_upAndDown() : void
      {
         var temNum:int = 0;
         var voVec:Vector.<Vo_valuable> = null;
         var vo:Vo_equip = null;
         if(instensify_type == 1)
         {
            this.get_bag_data();
            if(Boolean(this.grid_vec[REFINE_EQUIP].vo))
            {
               voVec = CommandManager.get_bag_vec(Enum_filter.GRID_ID,null,[this.grid_vec[REFINE_EQUIP].vo.gridId]);
               if(!voVec.length)
               {
                  return;
               }
               this.grid_vec[REFINE_EQUIP].vo = voVec[0];
               temNum = 0;
               if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color == 5)
               {
                  temNum = 1;
               }
               else
               {
                  temNum = 0;
               }
               this.Show_down();
               this.autoGetTool();
               if(!isPosSKi)
               {
                  this.autoAddSkill();
               }
            }
         }
         else
         {
            this.get_self_data();
            if(Boolean(this.grid_vec[REFINE_EQUIP].vo))
            {
               vo = UIManager.rolePanel.view_role_equip.get_item_index(this.grid_vec[REFINE_EQUIP].index) as Vo_equip;
               if(Boolean(vo))
               {
                  this.grid_vec[REFINE_EQUIP].vo = vo;
                  this.grid_vec[REFINE_EQUIP].index = this.grid_vec[REFINE_EQUIP].index;
               }
               temNum = 0;
               if((this.grid_vec[REFINE_EQUIP].vo as Vo_valuable).color == 5)
               {
                  temNum = 1;
               }
               else
               {
                  temNum = 0;
               }
               this.Show_down();
               this.autoGetTool();
               if(!isPosSKi)
               {
                  this.autoAddSkill();
               }
            }
         }
      }
      
      override public function hide() : void
      {
      }
      
      override public function re_set() : void
      {
      }
      
      override public function getClickVo(_vo:Vo_valuable) : void
      {
      }
      
      override public function roleEmptyHandle(gridId:int) : void
      {
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
         if(Boolean(this.skillGrid))
         {
            this.skillGrid.vo = null;
         }
      }
      
      override public function bagEmpthHandle(arr_gridId:Array) : void
      {
      }
   }
}

