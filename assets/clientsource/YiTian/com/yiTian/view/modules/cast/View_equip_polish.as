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
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.comp.View_grid_extra;
   import com.yiTian.view.modules.activityGuide.Model_ActivityGuide;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class View_equip_polish extends View_cast_base
   {
      
      private static var _vec_tf:Vector.<int>;
      
      public static var is_selection:Boolean = false;
      
      private static var isShowQuick:Boolean = false;
      
      private static const _keyArr:Array = ["气血","内力","攻击","防御","命中","闪避","暴击","格档","攻速"];
      
      private var view_grid_equip_now:View_Grid;
      
      private var view_grid_item_now:View_Grid;
      
      private var view_grid_equip:View_Grid;
      
      private var view_grid_item:View_Grid;
      
      private var gridId_equip:int;
      
      private var btn_keep:Button;
      
      private var btn_replace:Button;
      
      private var tf_keep:MyTextField;
      
      private var tf_replace:MyTextField;
      
      private var xilian_btn:Button;
      
      private var Button_body:TabButton;
      
      private var Button_Bag:TabButton;
      
      private var FeiYong_text:MyTextField;
      
      private var ChengGongLv_text:MyTextField;
      
      private var lockArr:Array = [];
      
      private var now:TabButton;
      
      private var type:int;
      
      private var lock_Arr:Array = [];
      
      private var unlock_Arr:Array = [];
      
      private var isShowCheckBoxTips:Boolean = false;
      
      private var checkTips:String = "强化材料不足，是否花费60元宝快速购买高级强化石？";
      
      private var autoBuyTips:String;
      
      private var _askType:int;
      
      private var self_data:Vector.<Vo_valuable>;
      
      private var bag_data:Vector.<Vo_valuable>;
      
      private var temGridArr:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var trueN:int;
      
      private var checkItemPrice:int;
      
      private var checkColor:String;
      
      private var tf_help_changed:MyTextField;
      
      private var tf_title:MyTextField;
      
      private var isPolish:Boolean = false;
      
      private var quickDataArrVec:Vector.<Vo_item> = new Vector.<Vo_item>();
      
      private var idArr:Array = [46061,46062,46063];
      
      private var priceTypeArr:Array = [[4,6],[15,7],[50,8]];
      
      private var quickContainer:Sprite = new Sprite();
      
      public function View_equip_polish()
      {
         super();
      }
      
      override public function Init() : void
      {
         var lockAttrib:setLockAttrib = null;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":135,
            "y":46,
            "width":253,
            "height":240
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":135,
            "y":290,
            "width":253,
            "height":155
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":137,
            "y":49,
            "width":249,
            "height":234
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":392,
            "y":65,
            "width":287,
            "height":178
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":392,
            "y":266,
            "width":287,
            "height":179
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":212,
            "y":297,
            "width":74,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":212,
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
            "x":139,
            "y":147,
            "width":122,
            "height":100
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":262,
            "y":147,
            "width":122,
            "height":100
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60079",6),this,{
            "x":146,
            "y":296,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60080",6),this,{
            "x":146,
            "y":316,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60081",6),this,{
            "x":163,
            "y":125,
            "color":15318372,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60082",6),this,{
            "x":277,
            "y":125,
            "color":15318372,
            "size":12,
            "leading":0
         });
         var tf:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("60083",6),this,{
            "x":206,
            "y":51,
            "color":15318372,
            "size":12,
            "leading":0
         });
         this.Button_body = ComponentUtil.getTabButton(LangConfig.getWord("145",0),"TabButton_Four",this,{
            "x":395,
            "y":44,
            "textColor":327424,
            "chooseColor":16773818,
            "name":"self"
         },Global.Img_Cdm);
         this.Button_Bag = ComponentUtil.getTabButton(LangConfig.getWord("146",0),"TabButton_Four",this,{
            "x":470,
            "y":44,
            "textColor":327424,
            "chooseColor":16773818,
            "name":"bag"
         },Global.Img_Cdm);
         this.Button_body.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Bag.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.btn_keep = ComponentUtil.getButton(LangConfig.getWord("60084",6),"Button_Four",this,{
            "x":170,
            "y":250,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_replace = ComponentUtil.getButton(LangConfig.getWord("60085",6),"Button_Four",this,{
            "x":280,
            "y":250,
            "textColor":16184781
         },Global.Img_Cdm);
         this.setBtn(this.btn_replace,false);
         this.btn_keep.addEventListener(MouseEvent.CLICK,this.CLICK_KEEP);
         this.btn_replace.addEventListener(MouseEvent.CLICK,this.CLICK_REPLACE);
         this.tf_keep = ComponentUtil.getTextField("",this,{
            "x":161 - 19,
            "y":150,
            "color":15318372,
            "leading":5
         });
         this.tf_replace = ComponentUtil.getTextField("",this,{
            "x":272 - 8,
            "y":150,
            "color":15318372,
            "leading":5
         });
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
         this.xilian_btn = ComponentUtil.getButton(LangConfig.getWord("252",0),"Button_Orange",this,{
            "x":296,
            "y":303,
            "textColor":16184781
         },Global.Img_Cdm);
         this.xilian_btn.callBack = this.xilianHandle;
         this.view_grid_equip = new View_Grid();
         this.view_grid_equip.type = Enum_type_grid.CAST;
         this.view_grid_equip.set_bmp_bg();
         this.view_grid_equip.set_bmp_over();
         this.view_grid_equip.set_tf_info(HtmlUtil.font(LangConfig.getWord("162",0),"#33CCFF"));
         addChild(this.view_grid_equip);
         this.view_grid_equip.x = 196;
         this.view_grid_equip.y = 77;
         this.view_grid_equip.addEventListener(MouseEvent.CLICK,this.EQUIP_CANCEL);
         this.view_grid_item = new View_Grid();
         this.view_grid_item.type = Enum_type_grid.CAST;
         this.view_grid_item.set_bmp_bg();
         this.view_grid_item.set_bmp_over();
         this.view_grid_item.set_tf_info(HtmlUtil.font(LangConfig.getWord("253",0) + "\n" + LangConfig.getWord("164",0),"#33CCFF"));
         addChild(this.view_grid_item);
         this.view_grid_item.x = 305;
         this.view_grid_item.y = 77;
         this.view_grid_item.addEventListener(MouseEvent.CLICK,this.ITEM_CANCEL);
         this.gridId_equip = 0;
         i = 0;
         while(i < 10)
         {
            lockAttrib = new setLockAttrib();
            lockAttrib.x = 239 + int(i / 5) * 124;
            lockAttrib.y = 151 + 19 * int(i % 5);
            lockAttrib.lock = true;
            lockAttrib.visible = false;
            if(i >= 5)
            {
               lockAttrib.clickType = false;
            }
            this.lockArr.push(lockAttrib);
            addChild(lockAttrib);
            ++i;
         }
         this.getQuickData();
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
         this.return_data();
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
      
      private function xilianCheckCall(box:CheckBox) : void
      {
         this.isShowCheckBoxTips = box.selected;
      }
      
      private function xilianHandle(e:MouseEvent) : void
      {
         if(this.view_grid_equip.vo == null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("167",0));
            return;
         }
         if(this.view_grid_item.vo == null || this.trueN == 0)
         {
            if(!this.isShowCheckBoxTips)
            {
               View_Alert.checkStatus(this.isShowCheckBoxTips);
               View_Alert.show(this.checkTips,View_Alert.OK_CANCAL,function():void
               {
                  xilian(1);
               },null,null,null,310,"","",TextFormatAlign.LEFT,true);
               View_Alert.instance.showCheckBox = this.xilianCheckCall;
            }
            else
            {
               this.xilian(1);
            }
         }
         else
         {
            this.xilian(0);
         }
      }
      
      private function xilian(askType:int) : void
      {
         var temlck:setLockAttrib = null;
         this._askType = askType;
         if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < int(this.FeiYong_text.text))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("97",0));
            return;
         }
         this.lock_Arr = [];
         this.unlock_Arr = [];
         i = 0;
         while(i < this.lockArr.length / 2)
         {
            temlck = this.lockArr[i];
            if(temlck.visible)
            {
               if(temlck.lock)
               {
                  this.lock_Arr.push(i);
               }
               else
               {
                  this.unlock_Arr.push(i);
               }
            }
            ++i;
         }
         if(this.lock_Arr.length == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("254",0));
            return;
         }
         if(!this.lock_Arr.length || is_selection)
         {
            this.okHandle();
         }
         else
         {
            if(!UIManager.tishi_sms.visible)
            {
               UIManager.tishi_sms.visible = true;
            }
            if(Model_ActivityGuide.isWashActivity == true)
            {
               UIManager.tishi_sms.updata_txt_polish(LangConfig.getWord("176",0) + HtmlUtil.font(String(this.lock_Arr.length * 4),"#ff00ff") + LangConfig.getWord("255",0),this.lock_Arr.length * 4,this.okHandle);
            }
            else
            {
               UIManager.tishi_sms.updata_txt_polish(LangConfig.getWord("176",0) + HtmlUtil.font(String(this.lock_Arr.length * 5),"#ff00ff") + LangConfig.getWord("255",0),this.lock_Arr.length * 5,this.okHandle);
            }
         }
      }
      
      private function okHandle() : void
      {
         this.setBtn(this.btn_replace,false);
         if(!this.view_grid_equip.vo)
         {
            return;
         }
         CastCGMessage.CG_POLISH((this.view_grid_equip.vo as Vo_valuable).id_server,this.view_grid_item.vo.gridId,int((this.view_grid_item.vo as Vo_valuable).bBind),this.lock_Arr,this.unlock_Arr,this._askType);
      }
      
      private function get_self_data() : void
      {
         this.self_data = new Vector.<Vo_valuable>();
         this.temGridArr = UIManager.rolePanel.view_role_equip.get_equips_noFasion();
         var i:int = 0;
         while(i < this.temGridArr.length)
         {
            if((this.temGridArr[i].vo as Vo_equip).type != 10)
            {
               this.self_data.push(this.temGridArr[i].vo);
            }
            i++;
         }
         vec_Vo_valuable_cache = vec_Vo_valuable_show_up = this.self_data;
         this.show_up_data(this.self_data,this.temGridArr);
      }
      
      private function get_bag_data() : void
      {
         this.bag_data = new Vector.<Vo_valuable>();
         this.bag_data = CommandManager.get_bag_vec(Enum_filter.EQUIP_POLISH);
         vec_Vo_valuable_cache = vec_Vo_valuable_show_up = this.bag_data;
         this.show_up_data(this.bag_data);
      }
      
      private function show_up_data(arr:Vector.<Vo_valuable>, temGridArr:Vector.<View_Grid> = null) : void
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
            if(Boolean(temGridArr))
            {
               v.Show(arr[i],View_grid_extra.POLISH,temGridArr[i]);
            }
            else
            {
               v.Show(arr[i],View_grid_extra.POLISH);
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
         canvas_up.align();
      }
      
      public function setBtn(_btn:Button, value:Boolean) : void
      {
         if(Boolean(_btn))
         {
            _btn.buttonMode = value;
            _btn.useHandCursor = value;
            _btn.enabled = value;
            if(value)
            {
               _btn.addEventListener(MouseEvent.CLICK,this.CLICK_REPLACE);
            }
            else
            {
               _btn.removeEventListener(MouseEvent.CLICK,this.CLICK_REPLACE);
            }
         }
      }
      
      public function update_success_changed() : void
      {
         var temIdArr:Vector.<Vo_valuable> = null;
         CastEffect.getEffect("tihuan",this.view_grid_equip,this);
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         if(this.type == 1)
         {
            this.get_bag_data();
            if(Boolean(this.view_grid_equip.vo))
            {
               temIdArr = CommandManager.get_bag_vec(Enum_filter.GRID_ID,null,[this.view_grid_equip.vo.gridId]);
               this.view_grid_equip.vo = temIdArr[0];
            }
         }
         else
         {
            this.get_self_data();
            this.view_grid_equip.vo = UIManager.rolePanel.view_role_equip.get_item_index(this.view_grid_equip.index);
         }
         if(Boolean(this.view_grid_equip.vo))
         {
            this.set_txt_extra((this.view_grid_equip.vo as Vo_equip).vec_extend,this.tf_keep);
         }
         this.update_tf_cost();
         this.Show_down();
         this.auto_addTool();
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
         }
      }
      
      private function showBmp() : void
      {
         var bg3:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":165,
            "y":51,
            "width":213,
            "height":21
         },Global.Forging_Imgsdm);
         var bg1:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":160,
            "y":124,
            "width":110,
            "height":21
         },Global.Forging_Imgsdm);
         var bg2:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":271,
            "y":124,
            "width":110,
            "height":21
         },Global.Forging_Imgsdm);
         setChildIndex(bg1,2);
         setChildIndex(bg2,3);
         setChildIndex(bg3,4);
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
            this.checkTips = LangConfig.getWord("30129",3,String(this.checkItemPrice),HtmlUtil.fontNoSize(_vo.str_name,this.checkColor));
            this.autoBuyTips = LangConfig.getWord("30133",3,String(this.checkItemPrice),HtmlUtil.fontNoSize(_vo.str_name,this.checkColor));
            this.trueN = _num;
            colorS = _num == 0 ? "#fe0000" : "#f4cd31";
            _truNum = _num > 1 ? int(_num - 1) : _num;
            this.view_grid_item.set_tf_info(HtmlUtil.font("\n" + 1 + "/",colorS) + HtmlUtil.font(_truNum.toString(),colorS),this.view_grid_item.numChildren - 1);
         }
         else if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.set_tf_info(HtmlUtil.font(LangConfig.getWord("253",0) + "\n" + LangConfig.getWord("164",0),"#33CCFF"));
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         this.reset();
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
         this.gridId_equip = 0;
         this.view_grid_item_now = null;
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         vec_Vo_valuable_cache = null;
         if(Boolean(this.tf_keep))
         {
            this.tf_keep.text = "";
         }
         if(Boolean(this.tf_replace))
         {
            this.tf_replace.text = "";
         }
         if(Boolean(this.lockArr.length))
         {
            i = 0;
            while(i < 10)
            {
               this.lockArr[i].visible = false;
               ++i;
            }
         }
         this.setBtn(this.btn_replace,false);
      }
      
      override public function hide() : void
      {
      }
      
      override public function display() : void
      {
         tbtn_stuff.set_htmlText(LangConfig.getWord("256",0));
         tbbtn_bought.visible = true;
         tbtn_stuff.visible = true;
         tfMart.visible = true;
         tfMiJing.visible = true;
         if(!this.tf_help_changed)
         {
            this.tf_help_changed = ComponentUtil.getTextField("",this,{
               "x":158,
               "y":369 - 20,
               "leading":4,
               "color":14013822
            });
         }
         this.tf_help_changed.htmlText = "1. 洗练装备能够改变装备的附加属性\n2. 洗练装备后可选择" + HtmlUtil.font("维持原有属性","#ff7700") + "或" + HtmlUtil.font("\n   替换原有属性","#ff7700");
         canvas_txt.align();
         canvas_txt.visible = false;
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
         if(this.isShowCheckBoxTips && this._askType == 1)
         {
            UIManager.centerBroadcast.addMsg(this.autoBuyTips);
         }
         UIManager.castPanel.setTabEnable(false);
         CastEffect.getEffect("xilian",this.view_grid_equip,this);
         var eff4:Effect = EffectManager.addEffect("35064",this,500,this.view_grid_item.x + 15,this.view_grid_item.y + 16);
         var eff1:Effect = EffectManager.addEffect("35063",this,1000,this.view_grid_item.x + this.view_grid_item.width / 2,this.view_grid_item.y + this.view_grid_item.height / 2);
         Tween.to(eff1,1000,{
            "px":[this.view_grid_item.x + this.view_grid_item.width / 2,this.tf_replace.x + 50],
            "py":[this.view_grid_item.y + this.view_grid_item.height / 2,this.tf_replace.y + 40]
         },this.compleHandle);
         _vec_tf = vec;
      }
      
      private function compleHandle() : void
      {
         UIManager.castPanel.setTabEnable(true);
         var eff1:Effect = EffectManager.addEffect("35061",this,500,this.tf_replace.x + 50,this.tf_replace.y + 40);
         this.set_txt_extra(_vec_tf,this.tf_replace,true);
         this.update_upAndDown();
      }
      
      private function update_tf_cost() : void
      {
         var vo_equip:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         var str:String = Data_lib.cast_cost[Math.ceil(vo_equip.lv_use / 10)][Enum_lib_cast_cost.EQUIP_POLISH];
         var arr:Array = str.split("_");
         var color:int = vo_equip.color;
         if(color > 4)
         {
            color = 4;
         }
         this.FeiYong_text.text = arr[color - 1];
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
                  this.view_grid_equip.vo = vec_View_grid_extra_up[i].view_grid.vo;
                  this.set_txt_extra((this.view_grid_equip.vo as Vo_equip).vec_extend,this.tf_keep);
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
            this.view_grid_item_now = null;
            this.view_grid_item.vo = null;
            this.tf_keep.text = "";
            this.tf_replace.text = "";
            this.empty_vec_View_grid_cast_down();
         }
      }
      
      private function auto_addTool() : void
      {
         var _voI:Vo_item = null;
         this.view_grid_item_now = null;
         this.view_grid_item.vo = null;
         var _voValu:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[this.get_item_id()]);
         if(!_voValu || !_voValu.length)
         {
            _voI = new Vo_item();
            _voI.id = this.get_item_id();
            _voI.count = 0;
            _voI.Init_lib();
            this.view_grid_item.vo = _voI;
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
            v.Show(vec_Vo_valuable_show_up[i],View_grid_extra.POLISH);
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
            metiaContainer.addChild(v);
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
               v.y = INDENT + int(i / 2) * 43;
               metiaContainer.addChild(v);
               v.Show(vec_Vo_valuable_show_down[i],View_grid_extra.HOLE);
               v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_DOWN);
               vec_View_grid_extra_down.push(v);
               ++i;
            }
            canvas_down.addChild(metiaContainer);
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
            if(Boolean(vec_View_grid_extra_down[i]) && metiaContainer.contains(vec_View_grid_extra_down[i]))
            {
               metiaContainer.removeChild(vec_View_grid_extra_down[i]);
            }
            vec_View_grid_extra_down[i].view_grid.empty();
            pool.push(vec_View_grid_extra_down[i]);
            vec_View_grid_extra_down.pop();
            --i;
         }
         canvas_down.removeChild(metiaContainer);
      }
      
      private function getAttribute(id_attribute:int, value:int) : String
      {
         var _n:Number = NaN;
         var __vo:Vo_equip = null;
         var __color:int = 0;
         var Lvl:int = 0;
         var _key1:int = 0;
         var ss:String = null;
         var _keyIndex:int = 0;
         var _a:int = 0;
         var __n:int = 0;
         if(Boolean(this.view_grid_equip.vo))
         {
            __vo = this.view_grid_equip.vo as Vo_equip;
            __color = __vo.color;
            __color = __color <= 4 ? __color : 4;
            Lvl = __vo.lv_use;
            _key1 = Math.ceil(Lvl / 10);
            ss = Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME];
            _keyIndex = _keyArr.indexOf(ss);
            if(_keyIndex != -1)
            {
               _a = int(Data_lib.equipPolish[_key1][_keyIndex]);
            }
            __n = Math.pow(1 / (_a * Math.pow(__color,0.5) / value),1 / 0.7) * 10 % 10;
            if(__n >= 5)
            {
               _n = Math.ceil(Math.pow(1 / (_a * Math.pow(__color,0.5) / value),1 / 0.7));
            }
            else
            {
               _n = Math.floor(Math.pow(1 / (_a * Math.pow(__color,0.5) / value),1 / 0.7));
            }
         }
         var colorSS:String = _n == 10 ? ColorConstant.getColorStr(ColorConstant.ORANGE) : ColorConstant.getColorStr(ColorConstant.BLUE_LIGHT);
         var starSS:String = _n == 10 ? " (满星)" : " (" + _n + "星)";
         if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
         {
            return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + " +" + value + "" + HtmlUtil.font(starSS,colorSS,12);
         }
         return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + " +" + value + "%" + HtmlUtil.font(starSS,colorSS,12);
      }
      
      private function set_txt_extra(vec_extend:Vector.<int>, tf:MyTextField, isPolish:Boolean = false) : void
      {
         var temLockItem:setLockAttrib = null;
         var j:int = 0;
         var str:String = "";
         var temLen:int = vec_extend.length / 4;
         i = 5;
         while(i < 10)
         {
            temLockItem = this.lockArr[i];
            temLockItem.visible = false;
            ++i;
         }
         if(!isPolish)
         {
            j = 0;
            while(j < temLen)
            {
               temLockItem = this.lockArr[j];
               temLockItem.visible = true;
               temLockItem.lock = vec_extend[4 * j + 2] > 0;
               str += HtmlUtil.fontBr(this.getAttribute(vec_extend[4 * j],vec_extend[4 * j + 1]),ColorConstant.getColorStr(ColorConstant.BLUE));
               j++;
            }
         }
         else
         {
            i = 0;
            while(i < temLen)
            {
               temLockItem = this.lockArr[i + 5];
               temLockItem.visible = temLockItem.lock = vec_extend[4 * i + 2] > 0;
               str += HtmlUtil.fontBr(this.getAttribute(vec_extend[4 * i],vec_extend[4 * i + 1]),ColorConstant.getColorStr(ColorConstant.BLUE));
               ++i;
            }
         }
         tf.htmlText = str;
         if(this.tf_replace.htmlText != "")
         {
            this.setBtn(this.btn_replace,true);
         }
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
         if(this.view_grid_equip.vo == temp.vo)
         {
            return;
         }
         if(this.type == 2)
         {
            if(temp.index == 12)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("258",0));
               return;
            }
         }
         else if((temp.vo as Vo_equip).type == 10)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("258",0));
            return;
         }
         if(Boolean(this.view_grid_equip_now))
         {
            this.view_grid_equip_now.bSelect = false;
         }
         i = 0;
         while(i < 10)
         {
            this.lockArr[i].visible = false;
            ++i;
         }
         this.view_grid_equip_now = temp;
         this.view_grid_equip_now.bSelect = true;
         this.view_grid_equip.vo = temp.vo;
         this.view_grid_equip.index = temp.index;
         this.gridId_equip = this.view_grid_equip.vo.gridId;
         this.tf_replace.text = "";
         this.set_txt_extra((temp.vo as Vo_equip).vec_extend,this.tf_keep);
         this.update_tf_cost();
         var str:String = (temp.vo as Vo_equip).extral_of_equip_str;
         var temArr:Array = this.handleStr(str);
         if(Boolean(temArr))
         {
            this.set_txt_extra_copy(temArr,this.tf_replace);
         }
         this.Show_down();
         this.auto_addTool();
         this.checkItemPrice = Data_lib.autoBuyConst[this.view_grid_item.vo.id][Const_id.AUTO_PRICE];
         this.checkColor = Data_lib.autoBuyConst[this.view_grid_item.vo.id][Const_id.AUTO_COLOR];
      }
      
      private function CLICK_UP(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         this.getClickGrid(temp);
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
         if(this.type == 1)
         {
            if(Boolean(this.view_grid_equip.vo))
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
      }
      
      private function set_txt_extra_copy(vec_extend:Array, tf:MyTextField) : void
      {
         var str:String = "";
         i = 0;
         if(Boolean(vec_extend.length))
         {
            this.setBtn(this.btn_replace,true);
         }
         var j:int = 0;
         while(j < vec_extend.length)
         {
            this.lockArr[j + 5].visible = this.lockArr[j + 5].lock = vec_extend[j][2] > 0;
            str += HtmlUtil.fontBr(this.getAttribute(vec_extend[j][0],vec_extend[j][1]),ColorConstant.getColorStr(ColorConstant.BLUE));
            j++;
         }
         tf.htmlText = str;
      }
      
      private function handleStr(str:String) : Array
      {
         var temArr:Array = null;
         var i:int = 0;
         var tem_arr:Array = new Array();
         if(str == "" || str == "0")
         {
            return null;
         }
         temArr = str.split("-");
         i = 0;
         while(i < temArr.length)
         {
            tem_arr.push(temArr[i].split(":"));
            i++;
         }
         return tem_arr;
      }
      
      private function CLICK_REPLACE(e:MouseEvent) : void
      {
         if(this.tf_replace.text == "")
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("259",0));
            return;
         }
         i = 0;
         while(i < 10)
         {
            this.lockArr[i].visible = false;
            ++i;
         }
         CastCGMessage.CG_POLISH_OK((this.view_grid_equip.vo as Vo_valuable).id_server);
         if(this.tf_replace.text != "")
         {
            this.tf_replace.text = "";
            this.setBtn(this.btn_replace,false);
         }
      }
      
      private function CLICK_KEEP(e:MouseEvent) : void
      {
         i = 5;
         while(i < 10)
         {
            this.lockArr[i].visible = false;
            ++i;
         }
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
      
      private function ITEM_CANCEL(event:MouseEvent) : void
      {
         if(Boolean(this.view_grid_item.vo))
         {
            this.view_grid_item.vo = null;
            if(Boolean(this.view_grid_item_now))
            {
               ++this.view_grid_item_now.count;
               this.view_grid_item_now.bSelect = false;
               this.view_grid_item_now = null;
            }
         }
      }
      
      private function return_data() : void
      {
         i = 0;
         while(i < 10)
         {
            this.lockArr[i].visible = false;
            ++i;
         }
         if(Boolean(this.view_grid_equip))
         {
            this.view_grid_equip.vo = null;
         }
         this.gridId_equip = 0;
         this.view_grid_item_now = null;
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         if(Boolean(this.FeiYong_text))
         {
            this.FeiYong_text.text = "";
         }
         if(Boolean(this.tf_keep))
         {
            this.tf_keep.text = "";
         }
         if(Boolean(this.tf_replace))
         {
            this.tf_replace.text = "";
         }
         this.setBtn(this.btn_replace,false);
         this.empty_vec_View_grid_cast_down();
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

import com.yiTian.data.vo.Vo_valuable;
import com.yiTian.utils.Utils;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class setLockAttrib extends Sprite
{
   
   private var moveBar:Sprite = new Sprite();
   
   private var _lock:Boolean = false;
   
   private var bmp:Bitmap;
   
   public function setLockAttrib()
   {
      super();
      this.moveBar.graphics.beginFill(0,0);
      this.moveBar.graphics.drawRect(0,0,15,15);
      this.moveBar.addEventListener(MouseEvent.CLICK,this.clickHandle);
      addChild(this.moveBar);
      this.moveBar.buttonMode = true;
   }
   
   public function clickHandle(e:MouseEvent) : void
   {
      this.lock = !this.lock;
   }
   
   public function set lock(value:Boolean) : void
   {
      this._lock = value;
      if(Boolean(this.bmp))
      {
         this.bmp.bitmapData = null;
      }
      if(value)
      {
         this.bmp = Utils.getLoadBitmap("resource/image/cast_lock/Locked.png");
      }
      else
      {
         this.bmp = Utils.getLoadBitmap("resource/image/cast_lock/Open.png");
      }
      addChild(this.bmp);
   }
   
   public function set clickType(value:Boolean) : void
   {
      this.moveBar.mouseEnabled = value;
      this.moveBar.buttonMode = value;
      if(value)
      {
         this.moveBar.removeEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      else
      {
         this.moveBar.addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
   }
   
   public function get lock() : Boolean
   {
      return this._lock;
   }
   
   public function getClickVo(_vo:Vo_valuable) : void
   {
   }
}
