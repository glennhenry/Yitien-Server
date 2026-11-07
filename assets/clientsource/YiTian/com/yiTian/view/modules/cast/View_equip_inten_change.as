package com.yiTian.view.modules.cast
{
   import com.event.Button_h;
   import com.event.TextField_h;
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_id;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.config.valuable.Enum_lib_attribute;
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
   
   public class View_equip_inten_change extends View_cast_base
   {
      
      private var view_grid_equip_now:View_Grid;
      
      private var view_grid_item_now:View_Grid;
      
      private var view_grid_equip:View_Grid;
      
      private var view_grid_item:View_Grid;
      
      private var gridId_equip:int;
      
      private var btn_keep:Button_h;
      
      private var btn_replace:Button_h;
      
      private var tf_keep:TextField_h;
      
      private var tf_replace:TextField_h;
      
      private var xilian_btn:Button;
      
      private var checkBox:CheckBox;
      
      private var ChengGongLV_text:MyTextField;
      
      private var QHShiBai_text:MyTextField;
      
      private var Cost1_text:MyTextField;
      
      private var Cost2_text:MyTextField;
      
      private var Button_ZhuanYi:Button;
      
      private var Button_body:TabButton;
      
      private var Button_Bag:TabButton;
      
      private var now:TabButton;
      
      private var type:int;
      
      private var self_data:Vector.<Vo_valuable>;
      
      private var bag_data:Vector.<Vo_valuable>;
      
      private var isFinishChanged:Boolean = false;
      
      private var tf_help_changed:MyTextField;
      
      private var can:Canvas;
      
      private var rateArr:Array = ["100","80","70","60","50","40","30","20","10","5","100","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5"];
      
      private var costArr:Array = [1000,2000,3000,4000,5000,10000,20000,30000,50000,100000,5000000,10000,20000,30000,40000,50000,100000,200000,300000,500000,1000000,5000000,10000,20000,30000,40000,50000,100000,200000,300000,500000,1000000];
      
      private var cost_Arr:Array = [0,1,10,20,30,50,70,100,200,300,500,1,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500];
      
      private var fail_down_Arr:Array = [0,0,0,1,2,3,4,4,5,6,7,11,11,11,12,13,14,15,15,16,17,18,21,21,21,22,23,24,25,25,26,28,28];
      
      private var success_rate:int;
      
      private var cost_sil:int;
      
      private var cost_yb:int;
      
      public function View_equip_inten_change()
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
         ComponentUtil.getTextField(LangConfig.getWord("60072",6),this,{
            "x":153,
            "y":252,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60073",6),this,{
            "x":153,
            "y":270,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60074",6),this,{
            "x":197,
            "y":52,
            "color":15318372,
            "size":12,
            "leading":0
         });
         this.view_grid_equip = new View_Grid();
         this.view_grid_equip.type = Enum_type_grid.CAST;
         this.view_grid_equip.set_bmp_bg();
         this.view_grid_equip.set_bmp_over();
         this.view_grid_equip.set_tf_info(LangConfig.getWord("204",0) + "\n" + LangConfig.getWord("205",0));
         addChild(this.view_grid_equip);
         this.view_grid_equip.x = 192;
         this.view_grid_equip.y = 123;
         this.view_grid_equip.addEventListener(MouseEvent.CLICK,this.EQUIP_CANCEL);
         this.view_grid_item = new View_Grid();
         this.view_grid_item.type = Enum_type_grid.CAST;
         this.view_grid_item.set_bmp_bg();
         this.view_grid_item.set_bmp_over();
         this.view_grid_item.set_tf_info(LangConfig.getWord("206",0) + "\n" + LangConfig.getWord("205",0));
         addChild(this.view_grid_item);
         this.view_grid_item.x = 296;
         this.view_grid_item.y = 123;
         this.view_grid_item.addEventListener(MouseEvent.CLICK,this.ITEM_CANCEL);
         this.Button_body = ComponentUtil.getTabButton(LangConfig.getWord("145",0),"TabButton_Four",this,{
            "x":395,
            "y":44,
            "textColor":16773818,
            "name":"self",
            "chooseColor":327424
         },Global.Img_Cdm);
         this.Button_Bag = ComponentUtil.getTabButton(LangConfig.getWord("146",0),"TabButton_Four",this,{
            "x":470,
            "y":44,
            "textColor":16773818,
            "name":"bag",
            "chooseColor":327424
         },Global.Img_Cdm);
         this.Button_body.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Bag.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.ChengGongLV_text = ComponentUtil.getTextField(LangConfig.getWord("207",0),this,{
            "x":186,
            "y":200,
            "color":15318372
         });
         this.QHShiBai_text = ComponentUtil.getTextField(LangConfig.getWord("208",0),this,{
            "x":199.05,
            "y":170
         });
         this.ChengGongLV_text.textColor = 11515029;
         this.QHShiBai_text.textColor = 16646144;
         this.QHShiBai_text.visible = false;
         this.checkBox = ComponentUtil.getCheckBox("","CheckBox01",this,{
            "x":170,
            "y":200
         },Global.Img_Cdm);
         this.checkBox.selected = true;
         this.checkBox.clickFun = this.selHandle;
         this.Cost1_text = ComponentUtil.getTextField("100%",this,{
            "x":216,
            "y":252,
            "color":15318372
         });
         this.Cost2_text = ComponentUtil.getTextField("0",this,{
            "x":216,
            "y":270,
            "color":15318372
         });
         this.Cost1_text.textColor = 16711424;
         this.Cost2_text.textColor = 16711424;
         this.Button_ZhuanYi = ComponentUtil.getButton(LangConfig.getWord("209",0),"Button_Orange",this,{
            "x":296,
            "y":258,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_ZhuanYi.callBack = this.operHandle;
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
         this.local_reset();
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
      
      private function get_self_data() : void
      {
         this.self_data = new Vector.<Vo_valuable>();
         var temGridArr:Vector.<View_Grid> = UIManager.rolePanel.view_role_equip.get_items_dataC();
         var i:int = 0;
         while(i < temGridArr.length)
         {
            this.self_data.push(temGridArr[i].vo);
            i++;
         }
         this.show_up_data(this.self_data,temGridArr);
      }
      
      private function get_bag_data() : void
      {
         this.bag_data = new Vector.<Vo_valuable>();
         this.bag_data = CommandManager.get_bag_vec(Enum_filter.EQUIP_ALL_INTENS_CHANGE);
         this.show_up_data(this.bag_data);
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
               v.Show(arr[i],View_grid_extra.INTENSIFY,arr2[i]);
            }
            else
            {
               v.Show(arr[i],View_grid_extra.INTENSIFY);
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
      
      private function local_reset() : void
      {
         if(Boolean(this.view_grid_equip))
         {
            this.view_grid_equip.vo = null;
         }
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         if(Boolean(this.Cost1_text))
         {
            this.Cost1_text.text = "0%";
         }
         if(Boolean(this.Cost2_text))
         {
            this.Cost2_text.text = "0";
         }
         if(Boolean(this.ChengGongLV_text))
         {
            this.ChengGongLV_text.text = LangConfig.getWord("207",0);
         }
         if(Boolean(this.QHShiBai_text))
         {
            this.QHShiBai_text.visible = false;
         }
         this.cost_sil = 0;
         this.cost_yb = 0;
         this.success_rate = 0;
      }
      
      private function selHandle(checkBox:CheckBox) : void
      {
         if(Boolean(this.view_grid_equip.vo))
         {
            if(checkBox.selected)
            {
               this.Cost1_text.text = "100%";
            }
            else
            {
               this.Cost1_text.text = this.success_rate + "%";
            }
         }
      }
      
      private function operHandle(e:MouseEvent) : void
      {
         if(!this.view_grid_equip.vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("210",0));
            return;
         }
         if(!this.view_grid_item || !this.view_grid_item.vo)
         {
            UIManager.centerBroadcast.addMsg("请放入要转移的装备");
            return;
         }
         if((this.view_grid_equip.vo as Vo_equip).color == 5)
         {
            if((this.view_grid_item.vo as Vo_equip).lv_use < 50 && (this.view_grid_item.vo as Vo_equip).color != 5)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("977",0));
               return;
            }
         }
         if(!this.view_grid_item.vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("210",0));
            return;
         }
         if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < this.cost_sil)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("8",0));
            return;
         }
         if(this.checkBox.selected)
         {
            if(GameUnitManager.hero.money < this.cost_yb)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
               return;
            }
         }
         if(Boolean(this.view_grid_equip && this.view_grid_item && this.view_grid_equip.vo && this.view_grid_item.vo) && Boolean((this.view_grid_equip.vo as Vo_equip).lv >= 11) && (this.view_grid_item.vo as Vo_equip).color < 4)
         {
            UIManager.centerBroadcast.addMsg("神级装备不能转移给紫装以下的装备");
            return;
         }
         if((this.view_grid_equip.vo as Vo_equip).lv > 11 && (this.view_grid_item.vo as Vo_equip).lv > 11)
         {
         }
         CastCGMessage.CG_INSTEN_CHANGED((this.view_grid_equip.vo as Vo_valuable).id_server,(this.view_grid_item.vo as Vo_valuable).id_server,int(this.checkBox.selected));
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
      }
      
      override public function bagEmpthHandle(arr_gridId:Array) : void
      {
         var i:int = 0;
         var _temVec:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
         if(this.type == 1)
         {
            if(Boolean(this.view_grid_equip))
            {
               if(Boolean(this.view_grid_equip.vo) || Boolean(this.view_grid_item.vo))
               {
                  i = 0;
                  while(i < arr_gridId.length)
                  {
                     if(Boolean(this.view_grid_equip.vo) && this.view_grid_equip.vo.gridId == arr_gridId[i])
                     {
                        _temVec = CommandManager.get_bag_vec(Enum_filter.SEVER_ID,null,[(this.view_grid_equip.vo as Vo_equip).id_server]);
                        if(!_temVec)
                        {
                           this.view_grid_equip.vo = null;
                           this.local_reset();
                        }
                     }
                     else if(Boolean(this.view_grid_item.vo) && this.view_grid_item.vo.gridId == arr_gridId[i])
                     {
                        _temVec = CommandManager.get_bag_vec(Enum_filter.SEVER_ID,null,[(this.view_grid_equip.vo as Vo_equip).id_server]);
                        if(!_temVec)
                        {
                           this.view_grid_item.vo = null;
                           this.Cost2_text.text = "0";
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
                     this.local_reset();
                  }
               }
            }
         }
      }
      
      override public function changeEquipBag(_equips:Array = null) : void
      {
         if(!_equips)
         {
            return;
         }
         if(this.type == 2)
         {
            if(Boolean(this.view_grid_equip.vo))
            {
               if((this.view_grid_equip.vo as Vo_equip).id_server == _equips[0][0])
               {
                  this.local_reset();
               }
            }
            if(Boolean(this.view_grid_item.vo))
            {
               if((this.view_grid_item.vo as Vo_equip).id_server == _equips[0][0])
               {
                  this.view_grid_item.vo = null;
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
         if(this.type == 1)
         {
            i = 0;
            while(i < _equips.length)
            {
               if(Boolean(this.view_grid_equip.vo))
               {
                  if((this.view_grid_equip.vo as Vo_equip).id_server == _equips[i][0])
                  {
                     this.local_reset();
                     return;
                  }
               }
               if(Boolean(this.view_grid_item.vo))
               {
                  if((this.view_grid_item.vo as Vo_equip).id_server == _equips[i][0])
                  {
                     this.view_grid_item.vo = null;
                     this.Cost2_text.text = "";
                     return;
                  }
               }
               i++;
            }
         }
      }
      
      public function update_success_insChanged() : void
      {
         this.isFinishChanged = true;
         CastEffect.getEffect("trans",this.view_grid_equip,this);
         var eff1:Effect = EffectManager.addEffect("35063",this,1000,this.view_grid_equip.x + this.view_grid_equip.width / 2,this.view_grid_equip.y + this.view_grid_equip.height / 2);
         UIManager.castPanel.setTabEnable(false);
         Tween.to(eff1,1000,{
            "px":[this.view_grid_equip.x + this.view_grid_equip.width / 2,this.view_grid_item.x + this.view_grid_item.width / 2],
            "py":[this.view_grid_equip.y + this.view_grid_equip.height / 2,this.view_grid_item.y + this.view_grid_item.height / 2]
         },this.compleHandle);
      }
      
      private function compleHandle(str:String = "") : void
      {
         var temIdArr:Vector.<Vo_valuable> = null;
         var i:int = 0;
         UIManager.castPanel.setTabEnable(true);
         var eff1:Effect = EffectManager.addEffect("35062",this,600,this.view_grid_item.x + this.view_grid_item.width / 2 - 3,this.view_grid_item.y + this.view_grid_item.height / 2);
         if(this.type == 1)
         {
            this.get_bag_data();
            if(Boolean(this.view_grid_equip.vo) && Boolean(this.view_grid_item.vo))
            {
               temIdArr = CommandManager.get_bag_vec(Enum_filter.GRID_ID,null,[this.view_grid_equip.vo.gridId,this.view_grid_item.vo.gridId]);
            }
            if(Boolean(temIdArr))
            {
               i = 0;
               while(i < temIdArr.length)
               {
                  if(temIdArr[i].gridId == this.view_grid_equip.vo.gridId)
                  {
                     this.view_grid_equip.vo = temIdArr[i];
                  }
                  else if(temIdArr[i].gridId == this.view_grid_item.vo.gridId)
                  {
                     this.view_grid_item.vo = temIdArr[i];
                  }
                  i++;
               }
            }
         }
         else
         {
            this.get_self_data();
            this.view_grid_equip.vo = UIManager.rolePanel.view_role_equip.get_item_index(this.view_grid_equip.index);
            this.view_grid_item.vo = UIManager.rolePanel.view_role_equip.get_item_index(this.view_grid_item.index);
         }
      }
      
      public function update_fail_insChanged() : void
      {
         this.isFinishChanged = true;
         var eff5:Effect = EffectManager.addEffect("35064",this,500,this.view_grid_equip.x + 15,this.view_grid_equip.y + 16);
         var eff7:Effect = EffectManager.addEffect("35065",this,500,this.view_grid_equip.x + 15,this.view_grid_equip.y + 16);
         this.compleHandle("fail");
         if(Boolean(this.view_grid_equip.vo))
         {
            this.QHShiBai_text.visible = true;
            this.QHShiBai_text.text = LangConfig.getWord("211",0) + String((this.view_grid_equip.vo as Vo_equip).lv);
         }
      }
      
      private function frameHandle(instanc:int) : void
      {
         if(Boolean(this.view_grid_equip.vo) && Boolean(!this.isFinishChanged) && !this.checkBox.selected)
         {
            this.QHShiBai_text.visible = true;
         }
         else
         {
            this.QHShiBai_text.visible = false;
         }
         if(Boolean(this.view_grid_equip.vo) && this.isFinishChanged)
         {
            this.checkBox.enabled = false;
         }
         else
         {
            this.checkBox.enabled = true;
         }
         if(!this.view_grid_equip.vo)
         {
            this.isFinishChanged = false;
         }
      }
      
      private function showBmp() : void
      {
         var bg1:Bitmap = ComponentUtil.getBitmap("Forging_Back1",this,{
            "x":160,
            "y":62
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
            this.Button_body.choose = true;
            this.now = this.Button_body;
            this.get_self_data();
            this.type = 2;
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
            GameScene.instance.addFrameCallBack(this.frameHandle);
         }
         else
         {
            this.reset();
            GameScene.instance.removeFrameCallBack(this.frameHandle);
         }
      }
      
      override public function reset() : void
      {
         this.empty_vec_View_grid_cast_up();
         if(Boolean(this.view_grid_equip))
         {
            this.view_grid_equip.vo = null;
         }
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         if(Boolean(this.Cost1_text))
         {
            this.Cost1_text.text = "0%";
         }
         if(Boolean(this.Cost2_text))
         {
            this.Cost2_text.text = "0";
         }
         if(Boolean(this.ChengGongLV_text))
         {
            this.ChengGongLV_text.text = LangConfig.getWord("207",0);
         }
         this.success_rate = 0;
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
      }
      
      override public function hide() : void
      {
      }
      
      override public function display() : void
      {
         canvas_txt.visible = false;
         tbtn_stuff.set_htmlText(LangConfig.getWord("271",0));
         tbbtn_bought.visible = false;
         if(!this.tf_help_changed)
         {
            this.tf_help_changed = ComponentUtil.getTextField("",this,{
               "x":154,
               "y":312 - 15,
               "leading":4,
               "color":14013822
            });
         }
         this.tf_help_changed.htmlText = "1.强化" + HtmlUtil.font("+1","#ff7700") + "以上的装备才可进行强化转移\n2.强化转移有一定几率降低强化等级\n3.旧装备强化等级必须大于新装备\n4.强化转移的装备等级差不能超过" + HtmlUtil.font("20级","#ff7700") + "\n5.橙装只能转移至" + HtmlUtil.font("50级以上","#ff7700") + "橙装或紫装\n6.装备转移" + HtmlUtil.font("保留强化等级","#ff7700") + "和" + HtmlUtil.font("橙装精炼等级","#ff7700") + "\n  ，橙装、暗金装转移后变为紫装";
      }
      
      override public function update() : void
      {
         vec_Vo_valuable_cache = vec_Vo_valuable_show_up = CommandManager.get_bag_vec(Enum_filter.EQUIP_POLISH);
         if(filter != Enum_filter.ALL)
         {
            vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_show_up);
         }
         this.auto_addEquip();
      }
      
      public function update_txt(vec:Vector.<int>) : void
      {
         this.set_txt_extra(vec,this.tf_replace);
      }
      
      private function update_tf_cost() : void
      {
         var vo_equip:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         if(vo_equip.lv < 1)
         {
            return;
         }
         this.cost_sil = this.costArr[vo_equip.lv - 1];
         var temNum:int = (this.view_grid_item.vo as Vo_equip).color;
         var temNum2:int = (this.view_grid_equip.vo as Vo_equip).color;
         temNum = temNum >= 5 ? 4 : temNum;
         temNum2 = temNum2 >= 5 ? 4 : temNum2;
         var _lv:int = vo_equip.lv;
         var align:int = _lv < 11 ? 0 : 1;
         this.Cost2_text.text = this.cost_sil.toString();
         this.QHShiBai_text.text = LangConfig.getWord("211",0) + (this.fail_down_Arr[_lv] - align);
      }
      
      private function update_tf_cost2() : void
      {
         var vo_equip:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         if(vo_equip.lv < 1)
         {
            return;
         }
         this.success_rate = int(this.rateArr[vo_equip.lv - 1]);
         var _lv:int = vo_equip.lv;
         var algin:int = _lv < 11 ? 0 : 1;
         this.cost_yb = this.cost_Arr[_lv];
         if(this.checkBox.selected)
         {
            this.Cost1_text.text = "100%";
         }
         else
         {
            this.Cost1_text.text = this.success_rate + "%";
         }
         this.ChengGongLV_text.htmlText = LangConfig.getWord("212",0) + HtmlUtil.font(String(this.cost_yb),"#faff00") + LangConfig.getWord("213",0) + HtmlUtil.font("100%","#faff00") + LangConfig.getWord("214",0);
         this.QHShiBai_text.text = LangConfig.getWord("211",0) + (this.fail_down_Arr[_lv] - algin);
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
      
      private function get_item_id() : int
      {
         var id:int = 0;
         var color:int = (this.view_grid_equip.vo as Vo_equip).color;
         if(color <= Enum_color.GREEN)
         {
            id = Const_id.POLISH_STONE1;
         }
         else if(color == Enum_color.BLUE)
         {
            id = Const_id.POLISH_STONE1 + 1;
         }
         else if(color == Enum_color.PURPLE)
         {
            id = Const_id.POLISH_STONE1 + 2;
         }
         else if(color == Enum_color.ORANGE)
         {
            id = Const_id.POLISH_STONE1 + 2;
         }
         else
         {
            if(color != Enum_color.ANJIN)
            {
               throw new Error();
            }
            id = Const_id.POLISH_STONE1 + 2;
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
            v.Show(vec_Vo_valuable_show_up[i],View_grid_extra.INTENSIFY);
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
            v.x = GAP_X;
            v.y = INDENT;
            vo = new Vo_item();
            vo.id = this.get_item_id();
            vo.Init_lib();
            vo.count = 0;
            canvas_down.addChild(v);
            v.Show(vo,View_grid_extra.HOLE);
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
               v.y = INDENT + int(i / 2) * (GAP_HEIGHT_GRID + HEIGHT_GRID);
               canvas_down.addChild(v);
               v.Show(vec_Vo_valuable_show_down[i],View_grid_extra.HOLE);
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
            canvas_down.removeChild(vec_View_grid_extra_down[i]);
            vec_View_grid_extra_down[i].view_grid.empty();
            pool.push(vec_View_grid_extra_down[i]);
            vec_View_grid_extra_down.pop();
            --i;
         }
      }
      
      private function getAttribute(id_attribute:int, value:int) : String
      {
         if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
         {
            return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + " +" + value + "";
         }
         return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + " +" + value + "%";
      }
      
      private function set_txt_extra(vec_extend:Vector.<int>, tf:TextField_h) : void
      {
      }
      
      private function CLICK_BTN_OK(e:MouseEvent) : void
      {
         if(this.view_grid_equip.vo == null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("167",0));
            return;
         }
         if(this.view_grid_item.vo == null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("215",0));
            return;
         }
      }
      
      override public function getClickGrid(temp:View_Grid) : void
      {
         var __voE:Vo_equip = null;
         var color:int = 0;
         if(this.view_grid_equip.vo == temp.vo)
         {
            return;
         }
         if(this.view_grid_equip.vo == null)
         {
            if((temp.vo as Vo_equip).lv < 1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("216",0));
               return;
            }
            if(Boolean(this.view_grid_equip_now))
            {
               this.view_grid_equip_now.bSelect = false;
            }
            temp.bSelect = true;
            this.view_grid_equip_now = temp;
            this.view_grid_equip.vo = temp.vo;
            if(this.type == 2)
            {
               this.view_grid_equip.index = temp.index;
            }
            this.gridId_equip = this.view_grid_equip.vo.gridId;
            this.update_tf_cost2();
         }
         else
         {
            __voE = temp.vo as Vo_equip;
            color = (this.view_grid_equip.vo as Vo_equip).color;
            if(color < 5)
            {
               if(Math.abs((temp.vo as Vo_equip).lv_use - (this.view_grid_equip.vo as Vo_equip).lv_use) > 20)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("217",0));
                  return;
               }
               if(color >= 5)
               {
                  if(Boolean(__voE) && __voE.color < 4)
                  {
                     UIManager.centerBroadcast.addMsg("要转移的装备必须紫装以上");
                     return;
                  }
                  if(color == 5)
                  {
                     UIManager.centerBroadcast.addMsg("该装备必须要50级以上");
                     return;
                  }
                  if(color == 6)
                  {
                     UIManager.centerBroadcast.addMsg("该装备必须要110级以上");
                     return;
                  }
               }
            }
            if((temp.vo as Vo_equip).lv > (this.view_grid_equip.vo as Vo_equip).lv)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("218",0));
               return;
            }
            this.view_grid_item.vo = temp.vo;
            if(this.type == 2)
            {
               this.view_grid_item.index = temp.index;
            }
            this.update_tf_cost();
         }
      }
      
      private function CLICK_UP(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         this.getClickGrid(temp);
      }
      
      private function CLICK_REPLACE(e:MouseEvent) : void
      {
         if(this.tf_replace.text != "")
         {
            this.tf_replace.text = "";
         }
      }
      
      private function CLICK_KEEP(e:MouseEvent) : void
      {
         this.tf_replace.text = "";
      }
      
      private function CLICK_DOWN(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         if(this.view_grid_item.vo == temp.vo)
         {
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
      }
      
      private function ITEM_CANCEL(e:MouseEvent) : void
      {
         var temGrid:View_Grid = e.target as View_Grid;
         if(Boolean(temGrid.vo))
         {
            temGrid.vo = null;
            this.Cost2_text.text = "0";
         }
      }
      
      private function EQUIP_CANCEL(e:MouseEvent) : void
      {
         var temGrid:View_Grid = e.target as View_Grid;
         if(Boolean(temGrid.vo))
         {
            this.local_reset();
         }
      }
   }
}

