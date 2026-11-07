package com.yiTian.view.modules.cast.newUnit
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.config.valuable.Enum_lib_attribute;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CastCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.comp.View_grid_extra;
   import com.yiTian.view.modules.cast.CastEffect;
   import com.yiTian.view.modules.cast.View_cast_base;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_equip_DianHua extends View_cast_base
   {
      
      private static var _vec_tf:Vector.<int>;
      
      public static var is_selection:Boolean = false;
      
      private static var isLoad:Boolean = false;
      
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
      
      private var weiTiaoD:int = 13;
      
      private var now:TabButton;
      
      private var type:int;
      
      private var lock_Arr:Array = [];
      
      private var unlock_Arr:Array = [];
      
      private var tm:int;
      
      private var self_data:Vector.<Vo_valuable>;
      
      private var bag_data:Vector.<Vo_valuable>;
      
      private var temGridArr:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var tfDianHuaEd:MyTextField;
      
      private var tfDianHuaPre:MyTextField;
      
      private var trueN:int;
      
      private var tf_help_changed:MyTextField;
      
      private var tf_title:MyTextField;
      
      private var isPolish:Boolean = false;
      
      private var quickDataArrVec:Vector.<Vo_item> = new Vector.<Vo_item>();
      
      private var idArr:Array = [44648];
      
      private var priceTypeArr:Array = [[4,6],[15,7],[50,8]];
      
      private var quickContainer:Sprite = new Sprite();
      
      public function View_equip_DianHua()
      {
         super();
      }
      
      override public function Init() : void
      {
         this.initD();
         this.getQuickData();
      }
      
      private function initD() : void
      {
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":152 - this.weiTiaoD,
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
            "x":152 - this.weiTiaoD,
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
         ComponentUtil.getTextField("点化费用",this,{
            "x":160 - this.weiTiaoD,
            "y":305 - 5,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":220 - this.weiTiaoD,
            "y":302 - 5,
            "width":74,
            "height":24
         },Global.Img_Cdm);
         this.FeiYong_text = ComponentUtil.getTextField("000",this,{
            "x":225 - this.weiTiaoD,
            "y":305 - 5,
            "color":15318372,
            "size":12,
            "leading":0
         });
         this.xilian_btn = ComponentUtil.getButton("点化","Button_Orange",this,{
            "x":305 - this.weiTiaoD,
            "y":303 - 5,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":157 - this.weiTiaoD,
            "y":335 - 7,
            "width":229,
            "height":113
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":155 - this.weiTiaoD,
            "y":49,
            "width":233,
            "height":234
         },Global.Img_Cdm);
         this.view_grid_equip = new View_Grid();
         this.view_grid_equip.type = Enum_type_grid.CAST;
         this.view_grid_equip.set_bmp_bg();
         this.view_grid_equip.set_bmp_over();
         this.view_grid_equip.set_tf_info(HtmlUtil.font(LangConfig.getWord("162",0),"#33CCFF"));
         addChild(this.view_grid_equip);
         this.view_grid_equip.x = 196 - this.weiTiaoD;
         this.view_grid_equip.y = 84;
         this.view_grid_equip.addEventListener(MouseEvent.CLICK,this.EQUIP_CANCEL);
         this.view_grid_item = new View_Grid();
         this.view_grid_item.type = Enum_type_grid.CAST;
         this.view_grid_item.set_bmp_bg();
         this.view_grid_item.set_bmp_over();
         this.view_grid_item.set_tf_info(HtmlUtil.font("点化\n石","#33ccff"));
         addChild(this.view_grid_item);
         this.view_grid_item.x = 305 - this.weiTiaoD;
         this.view_grid_item.y = 84;
         this.view_grid_item.addEventListener(MouseEvent.CLICK,this.ITEM_CANCEL);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":158 - this.weiTiaoD,
            "y":185,
            "width":113,
            "height":80
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":272 - this.weiTiaoD,
            "y":185,
            "width":113,
            "height":80
         },Global.Img_Cdm);
         this.tf_keep = ComponentUtil.getTextField("2件：攻击+000000\n4件：攻击+000000\n6件：攻击+000000",this,{
            "x":162 - this.weiTiaoD,
            "y":193,
            "color":15318372,
            "size":12,
            "leading":6
         });
         this.tf_replace = ComponentUtil.getTextField("2件：攻击+000000\n4件：攻击+000000\n6件：攻击+000000",this,{
            "x":276 - this.weiTiaoD,
            "y":193,
            "color":15318372,
            "size":12,
            "leading":6
         });
         this.xilian_btn.callBack = this.xilianHandle;
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
         canvas_down.reset();
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
      
      private function xilianHandle(e:MouseEvent) : void
      {
         if(!this.view_grid_item.vo)
         {
            UIManager.centerBroadcast.addMsg("请放入点化材料");
            return;
         }
         if(Boolean(this.view_grid_equip.vo))
         {
            this.xilian_btn.enabled = false;
            this.tm = getTimer();
            CastCGMessage.CG_CLICK_UP_LEVEL_DIANHUA((this.view_grid_equip.vo as Vo_equip).id_server);
         }
      }
      
      private function okHandle() : void
      {
         this.setBtn(this.btn_replace,false);
         CastCGMessage.CG_POLISH((this.view_grid_equip.vo as Vo_valuable).id_server,this.view_grid_item.vo.gridId,int((this.view_grid_item.vo as Vo_valuable).bBind),this.lock_Arr,this.unlock_Arr,1);
      }
      
      private function get_self_data() : void
      {
         this.self_data = new Vector.<Vo_valuable>();
         this.temGridArr = UIManager.rolePanel.view_role_equip.get_can_dianHua();
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
         this.bag_data = CommandManager.get_bag_vec(Enum_filter.EQUIP_CAN_DIANHUA);
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
               v.Show(arr[i],View_grid_extra.CZ_DIANHUA,temGridArr[i]);
            }
            else
            {
               v.Show(arr[i],View_grid_extra.CZ_DIANHUA);
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
      
      public function update_success_changed(result:int = 0) : void
      {
         var eff1:Effect = null;
         var eff2:Effect = null;
         if(result == 1)
         {
            eff1 = EffectManager.addEffect("35063",this,1000,this.view_grid_equip.x + this.view_grid_equip.width / 2,this.view_grid_equip.y + this.view_grid_equip.height / 2);
            eff2 = EffectManager.addEffect("35063",this,1000,this.view_grid_item.x + this.view_grid_item.width / 2,this.view_grid_item.y + this.view_grid_item.height / 2);
            Tween.to(eff1,800,{
               "px":[eff1.px,this.view_grid_equip.x + 75],
               "py":[eff1.py,eff1.py]
            });
            Tween.to(eff2,800,{
               "px":[eff2.px,this.view_grid_equip.x + 75],
               "py":[eff2.py,eff2.py]
            },this.com1);
         }
      }
      
      private function com1() : void
      {
         var eff3:Effect = EffectManager.addEffect("35062",this,400,this.view_grid_equip.x + 75,this.view_grid_equip.y);
         Tween.to(eff3,400,{
            "px":[eff3.px,this.tf_replace.x + 25],
            "py":[eff3.py,this.tf_replace.y + 30]
         },this.compleHd);
      }
      
      private function compleHd() : void
      {
         var temIdArr:Vector.<Vo_valuable> = null;
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         var eff1:Effect = EffectManager.addEffect("35061",this,500,this.tf_replace.x + 50,this.tf_replace.y + 40);
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
         this.update_tf();
         this.update_tf_cost();
         this.Show_down();
         this.auto_addTool();
      }
      
      private function update_tf() : void
      {
         var voE:Vo_equip = null;
         var _dic:Dictionary = null;
         var key:String = null;
         var _arr:Array = null;
         var ss:String = null;
         if(Boolean(this.view_grid_equip.vo))
         {
            voE = this.view_grid_equip.vo as Vo_equip;
            if(voE.newTaoZhuangId != 0)
            {
               _dic = Data_lib.newTZ;
               for(key in _dic)
               {
                  _arr = _dic[key];
                  if(_dic[key][0] == voE.id_tz && _dic[key][10] == voE.newTaoZhuangId)
                  {
                     ss = _dic[key][9];
                     ss = HtmlUtil.font(ss.slice(0,2),"#ffffff") + HtmlUtil.font(ss.slice(2,ss.length),"#ff7700");
                     this.tfDianHuaEd.htmlText = ss;
                  }
               }
            }
         }
         if(Boolean(this.view_grid_equip.vo))
         {
            this.set_txt_extra((this.view_grid_equip.vo as Vo_equip).id_tz,this.tf_replace,true);
         }
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
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":160 - this.weiTiaoD,
            "y":130,
            "width":110,
            "height":50
         },Global.Forging_Imgsdm);
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":271 - this.weiTiaoD,
            "y":130,
            "width":110,
            "height":50
         },Global.Forging_Imgsdm);
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":165 - this.weiTiaoD,
            "y":51,
            "width":213,
            "height":21
         },Global.Forging_Imgsdm);
         ComponentUtil.getTextField("初始化套装属性",this,{
            "x":170 - this.weiTiaoD,
            "y":137,
            "color":15318372,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField("点化后套装属性",this,{
            "x":283 - this.weiTiaoD,
            "y":137,
            "color":15318372,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField("请选择需要点化的装备",this,{
            "x":206 - this.weiTiaoD,
            "y":53,
            "color":15318372,
            "size":12,
            "leading":0
         });
         this.tfDianHuaPre = ComponentUtil.getTextField(" ",this,{
            "x":170 - this.weiTiaoD,
            "y":137 + 20,
            "color":15318372,
            "size":12,
            "leading":3,
            "realWidth":83,
            "align":TextAlign.CENTER
         });
         this.tfDianHuaEd = ComponentUtil.getTextField(" ",this,{
            "x":283 - this.weiTiaoD,
            "y":137 + 20,
            "color":15318372,
            "size":12,
            "leading":3,
            "realWidth":83,
            "align":TextAlign.CENTER
         });
         isLoad = true;
      }
      
      private function visiHd() : void
      {
         var _vo:Vo_item = null;
         var _id:int = 0;
         var _num:int = 0;
         var colorS:String = null;
         var _truNum:int = 0;
         var tm2:int = 0;
         if(Boolean(this.view_grid_item) && Boolean(this.view_grid_item.vo))
         {
            _vo = this.view_grid_item.vo as Vo_item;
            _id = _vo.id;
            _num = CommandManager.get_bag_count(_id);
            this.trueN = _num;
            colorS = _num == 0 ? "#fe0000" : "#f4cd31";
            _truNum = _num > 1 ? int(_num - 1) : _num;
            this.view_grid_item.set_tf_info(HtmlUtil.font("\n" + 1 + "/",colorS) + HtmlUtil.font(_truNum.toString(),colorS),this.view_grid_item.numChildren - 1);
         }
         else if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.set_tf_info(HtmlUtil.font("点化\n石","#33ccff"));
         }
         if(!this.view_grid_equip.vo)
         {
            this.view_grid_item.vo = null;
            this.tfDianHuaPre.text = "";
            this.tfDianHuaEd.text = "";
         }
         if(!this.xilian_btn.enabled)
         {
            tm2 = getTimer();
            if(tm2 - this.tm >= 2000)
            {
               this.xilian_btn.enabled = true;
               this.tm = 0;
            }
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
            else if(!isLoad)
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
         tbtn_stuff.set_htmlText("点化材料");
         tbbtn_bought.visible = false;
         tbtn_stuff.visible = true;
         tfMart.visible = false;
         tfMiJing.visible = false;
         if(!this.tf_help_changed)
         {
            this.tf_help_changed = ComponentUtil.getTextField("",this,{
               "x":153,
               "y":369 - 40,
               "leading":4,
               "color":14013822
            });
         }
         this.tf_help_changed.htmlText = HtmlUtil.font("50级以上","#ff7700") + "紫色和橙色品质的套装都可进\n行点化，点化后的新" + HtmlUtil.font("套装","#ff7700") + "有以下属性：" + HtmlUtil.font("\n青龙","#ff7700") + "套装属性：攻击、命中、伤害加成" + HtmlUtil.font("\n白虎","#ff7700") + "套装属性：攻击、暴击、暴伤" + HtmlUtil.font("\n朱雀","#ff7700") + "套装属性：闪避、格挡、伤害减免" + HtmlUtil.font("\n玄武","#ff7700") + "套装属性：气血、防御、伤害减免";
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
         this.update_upAndDown();
      }
      
      private function update_tf_cost() : void
      {
         var _cost:int = 0;
         if(Boolean(this.view_grid_equip) && Boolean(this.view_grid_equip.vo))
         {
            _cost = int(Data_lib.TZCost[(this.view_grid_equip.vo as Vo_equip).id_tz]);
            this.FeiYong_text.text = _cost.toString();
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
                  this.view_grid_equip.vo = vec_View_grid_extra_up[i].view_grid.vo;
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
         return 44648;
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
         while(i < this.quickDataArrVec.length)
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
      
      private function set_txt_extra(tz_id:int, tf:MyTextField, isPolish:Boolean = false) : void
      {
         var _ve:Vo_equip = null;
         var __dic:Dictionary = null;
         var _key:String = null;
         var vE:Vo_equip = null;
         var _dic:Dictionary = null;
         var key:String = null;
         var _s:String = null;
         var _a:Array = null;
         var j:int = 0;
         var _ds:String = null;
         var _idx:int = 0;
         var _attid:int = 0;
         var att:int = 0;
         var s:String = "";
         if(!isPolish)
         {
            if(Boolean(this.view_grid_equip.vo))
            {
               _ve = this.view_grid_equip.vo as Vo_equip;
               if(Boolean(_ve.newTaoZhuangId))
               {
                  __dic = Data_lib.newTZ;
                  for(_key in __dic)
                  {
                     if(__dic[_key][10] == _ve.newTaoZhuangId && __dic[_key][0] == _ve.id_tz)
                     {
                        s = __dic[_key][2];
                     }
                  }
               }
               else
               {
                  s = Data_lib.tz[tz_id][1];
               }
            }
         }
         else if(Boolean(this.view_grid_equip.vo))
         {
            vE = this.view_grid_equip.vo as Vo_equip;
            if(Boolean(vE.newTaoZhuangId))
            {
               _dic = Data_lib.newTZ;
               for(key in _dic)
               {
                  if(_dic[key][10] == vE.newTaoZhuangId && _dic[key][0] == vE.id_tz)
                  {
                     s = _dic[key][2];
                  }
               }
            }
         }
         if(s == "")
         {
            return;
         }
         var _arr:Array = s.split(",");
         var dStr:String = "";
         var i:int = 0;
         while(i < _arr.length)
         {
            _s = _arr[i];
            _a = _s.split("_");
            j = 0;
            if(j < _a.length)
            {
               _ds = "";
               _idx = int(_a[0]);
               _attid = int(_a[1]);
               att = int(_a[2]);
               dStr += _idx + "件：" + this._getAttribute(_attid,att,this.view_grid_equip.vo as Vo_equip) + "\n";
            }
            i++;
         }
         tf.htmlText = dStr;
         if(this.tf_replace.htmlText != "")
         {
            this.setBtn(this.btn_replace,true);
         }
      }
      
      private function _getAttribute(id_attribute:int, value:int, vo:Vo_equip) : String
      {
         if(vo.type != 11)
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
         if(vo.daoTime != -2)
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
         var tId:int = 0;
         var _dic:Dictionary = null;
         var key:String = null;
         var _arr:Array = null;
         var ss:String = null;
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
         this.view_grid_equip_now = temp;
         this.view_grid_equip_now.bSelect = true;
         this.view_grid_equip.vo = temp.vo;
         this.view_grid_equip.index = temp.index;
         this.gridId_equip = this.view_grid_equip.vo.gridId;
         this.tf_replace.text = "";
         this.set_txt_extra((temp.vo as Vo_equip).id_tz,this.tf_keep);
         this.update_tf_cost();
         var str:String = (temp.vo as Vo_equip).extral_of_equip_str;
         if(Boolean(this.tfDianHuaEd))
         {
            this.tfDianHuaEd.text = " ";
         }
         if((this.view_grid_equip.vo as Vo_equip).newTaoZhuangId == 0)
         {
            tId = (this.view_grid_equip.vo as Vo_equip).id_tz;
            this.tfDianHuaPre.htmlText = Data_lib.tz[tId][8];
         }
         else
         {
            _dic = Data_lib.newTZ;
            for(key in _dic)
            {
               _arr = _dic[key];
               if(_dic[key][0] == (this.view_grid_equip.vo as Vo_equip).id_tz && _dic[key][10] == (this.view_grid_equip.vo as Vo_equip).newTaoZhuangId)
               {
                  ss = _dic[key][9];
                  ss = HtmlUtil.font(ss.slice(0,2),"#ffffff") + HtmlUtil.font(ss.slice(2,ss.length),"#ff7700");
                  this.tfDianHuaPre.htmlText = ss;
               }
            }
         }
         this.Show_down();
         this.auto_addTool();
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
         CastCGMessage.CG_POLISH_OK((this.view_grid_equip.vo as Vo_valuable).id_server);
         if(this.tf_replace.text != "")
         {
            this.tf_replace.text = "";
            this.setBtn(this.btn_replace,false);
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
            this.FeiYong_text.text = "0";
         }
         if(Boolean(this.tf_keep))
         {
            this.tf_keep.text = "";
         }
         if(Boolean(this.tf_replace))
         {
            this.tf_replace.text = "";
         }
         if(Boolean(this.tfDianHuaEd))
         {
            this.tfDianHuaEd.text = " ";
         }
         if(Boolean(this.tfDianHuaPre))
         {
            this.tfDianHuaPre.text = " ";
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
}
