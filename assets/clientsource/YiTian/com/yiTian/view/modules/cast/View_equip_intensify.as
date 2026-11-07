package com.yiTian.view.modules.cast
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Const_id;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.config.valuable.Enum_lib_item;
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
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.comp.View_grid_extra;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class View_equip_intensify extends View_cast_base
   {
      
      private static var MenuVip_text:MyTextField;
      
      public static const MAX_LUCKY_SYMBOL:int = 3;
      
      public static var instensify_type:int = 2;
      
      private static var vipRights:Array = [LangConfig.getWord("234",0),LangConfig.getWord("235",0),LangConfig.getWord("236",0)];
      
      private static var IncreaseArr:Array = [LangConfig.getWord("237",0),LangConfig.getWord("238",0),LangConfig.getWord("239",0)];
      
      private static var colorArr:Array = ["#00AE4F","#01A6DC","#F000AA"];
      
      private static var isShowQui:Boolean = false;
      
      private var view_grid_equip_now:View_Grid;
      
      private var vec_View_Grid_sym_now:Vector.<View_Grid>;
      
      private var view_grid_equip:View_Grid;
      
      private var view_grid_item:View_Grid;
      
      private var view_grid_pro:View_Grid;
      
      private var vec_View_Grid_sym:Vector.<View_Grid>;
      
      private var vec_bmpLv:Vector.<Bitmap>;
      
      private var gridId_equip:int;
      
      private var i:int;
      
      public var view_grid_equip_arr:Array = [];
      
      private var tf_of_view_grid_equip:Array;
      
      private var Luckly_text:MyTextField;
      
      private var instansRate:MyTextField;
      
      private var Pecent_text:MyTextField;
      
      private var checkBox:CheckBox;
      
      private var Button_QiangHua:Button;
      
      private var FeiYong_text:MyTextField;
      
      private var ChengGongLv_text:MyTextField;
      
      private var Button_Chai:TabButton;
      
      private var Button_body:TabButton;
      
      private var Button_Bag:TabButton;
      
      private var now:TabButton;
      
      private var luckySignStr:String = "";
      
      private var isShowCheckBoxTips:Boolean = false;
      
      private var checkTips:String = "强化材料不足，是否花费60元宝快速购买高级强化石？";
      
      private var autoBuyTips:String;
      
      private var _askType:int;
      
      private var _num:int;
      
      private var _last:int;
      
      private var _now:int;
      
      private var self_data:Vector.<Vo_valuable>;
      
      private var bag_data:Vector.<Vo_valuable>;
      
      private var temGridArr:Vector.<View_Grid>;
      
      private var vec_now_data:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
      
      private var _truN:int;
      
      private var nEnoughMetirial:Boolean = false;
      
      private var checkItemPrice:int;
      
      private var checkColor:String;
      
      private var spr:Sprite;
      
      private var useValue:int;
      
      private var tfH:MyTextField;
      
      private var tfTitle:MyTextField;
      
      private var luckyValue:int = 0;
      
      private var success_rate:int;
      
      private var successRateVec:Vector.<int> = new <int>[100,80,70,60,50,40,30,20,10,5,0];
      
      private var view_grid_item_now:View_Grid;
      
      private var quickDataArrVec:Vector.<Vo_item> = new Vector.<Vo_item>();
      
      private var idArr:Array = [46011,46012,46013,44643];
      
      private var priceTypeArr:Array = [[5,3],[18,4],[60,5],[150,26]];
      
      private var quickContainer:Sprite = new Sprite();
      
      private var now_down_select_grid:View_Grid;
      
      public function View_equip_intensify()
      {
         super();
      }
      
      public static function updateText(vip_type:int) : void
      {
         MenuVip_text.htmlText = HtmlUtil.font(vipRights[vip_type - 1],colorArr[vip_type - 1]) + HtmlUtil.font(IncreaseArr[vip_type - 1],"#afb495");
      }
      
      private static function CLICKHandle(e:TextEvent) : void
      {
         if(!UIManager.openVipPanel.visible)
         {
            UIManager.openVipPanel.visible = true;
         }
      }
      
      override public function Init() : void
      {
         this.tf_of_view_grid_equip = [LangConfig.getWord("162",0),LangConfig.getWord("219",0) + "\n" + LangConfig.getWord("164",0)];
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
            "x":220,
            "y":297,
            "width":74,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":220,
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
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":146,
            "y":49,
            "width":233,
            "height":234
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60076",6),this,{
            "x":211,
            "y":52,
            "color":15318372,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("1126",0),this,{
            "x":203,
            "y":151,
            "color":15318372,
            "size":12,
            "leading":0
         });
         this.Button_QiangHua = ComponentUtil.getButton(LangConfig.getWord("220",0),"Button_Orange",this,{
            "x":305,
            "y":303,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_QiangHua.callBack = this.instensifyHandle;
         this.FeiYong_text = ComponentUtil.getTextField("0",this,{
            "x":225,
            "y":316,
            "color":15318372
         });
         this.ChengGongLv_text = ComponentUtil.getTextField("0%",this,{
            "x":225,
            "y":296,
            "color":15318372
         });
         this.FeiYong_text.textColor = 16711424;
         this.ChengGongLv_text.textColor = 16711424;
         this.Button_body = ComponentUtil.getTabButton(LangConfig.getWord("145",0),"TabButton_Four",this,{
            "x":395,
            "y":44,
            "name":"self",
            "textColor":16773818,
            "chooseColor":327424
         },Global.Img_Cdm);
         this.Button_Bag = ComponentUtil.getTabButton(LangConfig.getWord("146",0),"TabButton_Four",this,{
            "x":470,
            "y":44,
            "name":"bag",
            "textColor":16773818,
            "chooseColor":327424
         },Global.Img_Cdm);
         this.Button_body.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Bag.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.view_grid_equip = new View_Grid();
         this.view_grid_equip.type = Enum_type_grid.CAST;
         this.view_grid_equip.set_bmp_bg();
         this.view_grid_equip.set_bmp_over();
         this.view_grid_equip.set_tf_info(HtmlUtil.font(LangConfig.getWord("162",0),"#d5d57e"));
         addChild(this.view_grid_equip);
         this.view_grid_equip.x = 194;
         this.view_grid_equip.y = 104;
         this.view_grid_equip.addEventListener(MouseEvent.CLICK,this.EQUIP_CANCEL);
         this.view_grid_item = new View_Grid();
         this.view_grid_item.type = Enum_type_grid.CAST;
         this.view_grid_item.set_bmp_bg();
         this.view_grid_item.set_bmp_over();
         this.view_grid_item.set_tf_info(HtmlUtil.font(LangConfig.getWord("219",0) + "\n" + LangConfig.getWord("164",0),"#d5d57e"));
         addChild(this.view_grid_item);
         this.view_grid_item.x = 278;
         this.view_grid_item.y = 104;
         this.view_grid_item.addEventListener(MouseEvent.CLICK,this.STONE_CANCEL);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":213,
            "y":259,
            "width":23,
            "height":20
         },Global.Img_Cdm);
         MenuVip_text = ComponentUtil.getTextField(LangConfig.getWord("223",0),this,{
            "x":202,
            "y":218,
            "color":16777215
         });
         MenuVip_text.mouseEnabled = true;
         if(!GameUnitManager.hero.vip)
         {
            this.getHtmlText();
         }
         else
         {
            updateText(GameUnitManager.hero.vip);
         }
         this.Luckly_text = ComponentUtil.getTextField(LangConfig.getWord("224",0),this,{
            "x":166,
            "y":238,
            "color":16777215
         });
         this.instansRate = ComponentUtil.getTextField("",this,{
            "x":186,
            "y":259,
            "color":16777215
         });
         this.instansRate.htmlText = LangConfig.getWord("225",0) + HtmlUtil.font("0","#faff00") + LangConfig.getWord("226",0);
         this.Luckly_text.textColor = 11515029;
         this.instansRate.textColor = 11515029;
         this.Pecent_text = ComponentUtil.getTextField("0",this,{
            "x":216,
            "y":260,
            "color":16777215,
            "realWidth":20,
            "realHeight":18
         });
         this.Pecent_text.type = TextFieldType.INPUT;
         this.Pecent_text.restrict = ".0-9";
         this.Pecent_text.maxChars = 2;
         this.Pecent_text.align = TextFormatAlign.CENTER;
         this.Pecent_text.textColor = 16449280;
         ComponentUtil.getTextField(LangConfig.getWord("60078",6),this,{
            "x":160,
            "y":316,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60077",6),this,{
            "x":160,
            "y":296,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.Pecent_text.addEventListener(Event.CHANGE,this.changeHandle);
         this.checkBox = ComponentUtil.getCheckBox("","CheckBox01",this,{
            "x":166,
            "y":260
         },Global.Img_Cdm);
         this.checkBox.clickFun = this.cliCheHandle;
         this.vec_View_Grid_sym = new Vector.<View_Grid>(MAX_LUCKY_SYMBOL,true);
         this.vec_View_Grid_sym_now = new Vector.<View_Grid>(MAX_LUCKY_SYMBOL,true);
         this.i = 0;
         while(this.i < MAX_LUCKY_SYMBOL)
         {
            this.vec_View_Grid_sym[this.i] = new View_Grid();
            this.vec_View_Grid_sym[this.i].type = Enum_type_grid.CAST;
            this.vec_View_Grid_sym[this.i].set_bmp_bg();
            this.vec_View_Grid_sym[this.i].set_bmp_over();
            this.vec_View_Grid_sym[this.i].set_tf_info(HtmlUtil.font(LangConfig.getWord("227",0) + "\n" + LangConfig.getWord("228",0),"#d5d57e"));
            addChild(this.vec_View_Grid_sym[this.i]);
            this.vec_View_Grid_sym[this.i].x = 180 + this.i * 60;
            this.vec_View_Grid_sym[this.i].y = 177;
            this.vec_View_Grid_sym[this.i].addEventListener(MouseEvent.CLICK,this.LUCKY_CANCEL);
            ++this.i;
         }
         this.vec_bmpLv = new Vector.<Bitmap>(Vo_equip.MAX_LV_INTENSIFY,true);
         this.i = 0;
         while(this.i < Vo_equip.MAX_LV_INTENSIFY)
         {
            this.vec_bmpLv[this.i] = new Bitmap();
            addChild(this.vec_bmpLv[this.i]);
            this.vec_bmpLv[this.i].x = 160 + this.i * 21;
            this.vec_bmpLv[this.i].y = 80;
            ++this.i;
         }
         this.gridId_equip = 0;
         this.getQuickData();
      }
      
      private function cliCheHandle(e:CheckBox) : void
      {
         var rate:int = 0;
         if(!this.view_grid_equip.vo)
         {
            e.selected = false;
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("229",0));
            return;
         }
         if(this.luckyValue < 10)
         {
            e.selected = false;
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("230",0));
            return;
         }
         if(this.success_rate + GameUnitManager.hero.vip >= 100)
         {
            e.selected = false;
            UIManager.centerBroadcast.addMsg("成功率已到100%");
            return;
         }
         if(Boolean(this.view_grid_equip.vo))
         {
            if(this.checkBox.selected)
            {
               this.Pecent_text.filters = Util.disabled;
               this.Pecent_text.selectable = false;
               rate = this.success_rate + GameUnitManager.hero.vip + int(this.Pecent_text.text);
               if(rate >= 100)
               {
                  rate = 100;
               }
               this.ChengGongLv_text.text = rate + "%";
            }
            else
            {
               this.Pecent_text.filters = [];
               this.Pecent_text.selectable = true;
               this.ChengGongLv_text.text = String(this.success_rate + GameUnitManager.hero.vip) + "%";
            }
         }
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
            instensify_type = 2;
            this.get_self_data();
         }
         else
         {
            instensify_type = 1;
            this.get_bag_data();
         }
      }
      
      override public function setClickType(type_index:int) : void
      {
         if(type_index == 2)
         {
            this.Button_body.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else if(type_index == 1)
         {
            this.Button_Bag.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
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
      
      private function local_reset() : void
      {
         this.FeiYong_text.text = "0";
         this.ChengGongLv_text.text = "0%";
         this.Luckly_text.htmlText = LangConfig.getWord("231",0) + HtmlUtil.font("0","#9ada78");
         this.view_grid_equip.vo = null;
         this.view_grid_item.vo = null;
         this.empty_vec_View_grid_cast_down();
         if(Boolean(this.view_grid_equip.vo))
         {
            this.view_grid_equip.vo = null;
         }
         if(Boolean(this.view_grid_item.vo))
         {
            this.view_grid_item.vo = null;
         }
         this.show_lv_intensify(0);
         var i:int = 0;
         while(i < this.vec_View_Grid_sym.length)
         {
            this.vec_View_Grid_sym[i].vo = null;
            i++;
         }
      }
      
      override public function bagEmpthHandle(arr_gridId:Array) : void
      {
         var i:int = 0;
         var _temVec:Vector.<Vo_valuable> = null;
         if(instensify_type == 1)
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
                           return;
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
         if(instensify_type == 2)
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
         if(Boolean(this.view_grid_equip))
         {
            if(instensify_type == 1)
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
         if(instensify_type == 1)
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
      
      private function instensifyCheckCall(box:CheckBox) : void
      {
         this.isShowCheckBoxTips = box.selected;
      }
      
      private function instensifyHandle(e:MouseEvent) : void
      {
         if(!this.view_grid_equip.vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("232",0));
            return;
         }
         if((this.view_grid_equip.vo as Vo_equip).lv == 10 || (this.view_grid_equip.vo as Vo_equip).lv == 21)
         {
            if((this.view_grid_equip.vo as Vo_equip).lv == 10)
            {
               UIManager.centerBroadcast.addMsg("已经是最高级了,晋级后可再升");
            }
            else
            {
               UIManager.centerBroadcast.addMsg("已经是最高级了");
            }
            return;
         }
         if(!this.view_grid_item.vo || this._truN < 0)
         {
            if(!this.isShowCheckBoxTips)
            {
               View_Alert.checkStatus(this.isShowCheckBoxTips);
               View_Alert.show(this.checkTips,View_Alert.OK_CANCAL,function():void
               {
                  yesInstensify(1);
               },null,null,null,310,"","",TextFormatAlign.LEFT,true);
               View_Alert.instance.showCheckBox = this.instensifyCheckCall;
            }
            else
            {
               this.yesInstensify(1);
            }
         }
         else
         {
            this.yesInstensify(0);
         }
      }
      
      private function yesInstensify(askType:int) : void
      {
         var temStr:String = this.getLuckySignStr();
         this._askType = askType;
         if(!this.view_grid_item.vo)
         {
            UIManager.centerBroadcast.addMsg("请放入强化材料");
            return;
         }
         if(!this.checkBox.selected)
         {
            CastCGMessage.CG_INTENSIFY((this.view_grid_equip.vo as Vo_valuable).id_server,this.view_grid_item.vo.gridId,int((this.view_grid_item.vo as Vo_valuable).bBind),askType,0,temStr);
         }
         else
         {
            CastCGMessage.CG_INTENSIFY((this.view_grid_equip.vo as Vo_valuable).id_server,this.view_grid_item.vo.gridId,int((this.view_grid_item.vo as Vo_valuable).bBind),askType,int(this.Pecent_text.text) * 10,temStr);
         }
         this.setLabel(false);
         this._num = 2;
         this.Button_QiangHua.label = String(this._num);
         this._last = getTimer();
         addEventListener(Event.ENTER_FRAME,this.frameHandle);
      }
      
      private function frameHandle(e:Event) : void
      {
         this._now = getTimer();
         if(this._now - this._last >= 1000)
         {
            --this._num;
            this.Button_QiangHua.label = String(this._num);
            this._last = this._now;
         }
         if(this._num < 1)
         {
            removeEventListener(Event.ENTER_FRAME,this.frameHandle);
            this.setLabel(true);
         }
      }
      
      private function setLabel(value:Boolean) : void
      {
         this.Button_QiangHua.enabled = value;
         if(value)
         {
            this.Button_QiangHua.label = LangConfig.getWord("220",0);
         }
      }
      
      private function getLuckySignStr() : String
      {
         return this.handle_grid();
      }
      
      private function handle_grid() : String
      {
         var temStr:String = "";
         var i:int = 0;
         while(i < MAX_LUCKY_SYMBOL)
         {
            if(Boolean(this.vec_View_Grid_sym[i].vo))
            {
               if(temStr != "")
               {
                  temStr += "_";
               }
               temStr += String(this.vec_View_Grid_sym[i].vo.gridId + ":" + int((this.vec_View_Grid_sym[i].vo as Vo_valuable).bBind));
            }
            i++;
         }
         return temStr;
      }
      
      private function comparing(arr:Array, gridId:int) : int
      {
         var i:int = 0;
         while(i < arr.length)
         {
            if(arr[i][0] == gridId)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function get_self_data() : void
      {
         this.self_data = new Vector.<Vo_valuable>();
         this.temGridArr = new Vector.<View_Grid>();
         if(Boolean(UIManager.rolePanel.view_role_equip))
         {
            this.temGridArr = UIManager.rolePanel.view_role_equip.get_items_data();
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
         this.bag_data = CommandManager.get_bag_vec(Enum_filter.EQUIP_ALL_INTENS);
         this.vec_now_data = this.bag_data;
         this.show_up_data(this.bag_data);
      }
      
      private function showBmp() : void
      {
         if(!this.spr)
         {
            this.spr = new Sprite();
            addChild(this.spr);
            this.spr.x = 284;
            this.spr.y = 5;
         }
         this.spr.mouseChildren = false;
         this.spr.mouseEnabled = false;
         var bg2:Bitmap = ComponentUtil.getBitmap("Forging_Back1",this,{
            "x":160,
            "y":62
         },Global.Forging_Imgsdm);
         var bg1:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":155,
            "y":51,
            "width":213,
            "height":21
         },Global.Forging_Imgsdm);
         var bg3:ScaleBitmap = ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":155,
            "y":150,
            "width":213,
            "height":21
         },Global.Forging_Imgsdm);
         setChildIndex(bg2,2);
         setChildIndex(bg1,1);
         setChildIndex(bg3,3);
      }
      
      private function visiHd() : void
      {
         var _vo:Vo_item = null;
         var _id:int = 0;
         var _num:int = 0;
         var _count:int = 0;
         var colorS:String = null;
         var _truNum:int = 0;
         var _d:Dictionary = null;
         if(Boolean(this.view_grid_item) && Boolean(this.view_grid_item.vo))
         {
            _vo = this.view_grid_item.vo as Vo_item;
            _id = _vo.id;
            _num = CommandManager.get_bag_count(_id);
            this.checkTips = LangConfig.getWord("30127",3,String(this.checkItemPrice),HtmlUtil.fontNoSize(_vo.str_name,this.checkColor));
            this.autoBuyTips = LangConfig.getWord("30131",3,String(this.checkItemPrice),HtmlUtil.fontNoSize(_vo.str_name,this.checkColor));
            if(_id == 44643)
            {
               if((this.view_grid_equip.vo as Vo_equip).lv != 21 && (this.view_grid_equip.vo as Vo_equip).lv != 10)
               {
                  _d = Data_lib.jinJiMetial;
                  _count = int(Data_lib.jinJiMetial[(this.view_grid_equip.vo as Vo_equip).lv + 1][0]);
               }
            }
            else
            {
               _count = 1;
            }
            this._truN = _num - _count;
            colorS = _num - _count < 0 ? "#fe0000" : "#f4cd31";
            _truNum = _num;
            this.view_grid_item.set_tf_info(HtmlUtil.font("\n" + _count + "/",colorS) + HtmlUtil.font(_truNum.toString(),colorS),this.view_grid_item.numChildren - 1);
         }
         else if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.set_tf_info(HtmlUtil.font(LangConfig.getWord("219",0) + "\n" + LangConfig.getWord("164",0),"#d5d57e"));
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
            this.checkBox.enabled = true;
            this.now = this.Button_body;
            instensify_type = 2;
            this.show_lv_intensify(0);
            this.setLabel(true);
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
            this.get_self_data();
         }
         else
         {
            if(hasEventListener(Event.ENTER_FRAME))
            {
               removeEventListener(Event.ENTER_FRAME,this.frameHandle);
            }
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
      
      override public function update_upAndDown() : void
      {
         if(instensify_type == 1)
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
            this.update_tf_success();
         }
      }
      
      private function checkData(_grid:View_Grid, _type:int) : int
      {
         var i:int = 0;
         if(_type == 1)
         {
            if(Boolean(this.bag_data))
            {
               i = 0;
               while(i < this.bag_data.length)
               {
                  if((_grid.vo as Vo_valuable).gridId == this.bag_data[i].gridId)
                  {
                     return i;
                  }
                  i++;
               }
            }
         }
         else if(_type == 2)
         {
            if(Boolean(this.self_data))
            {
               i = 0;
               while(i < this.self_data.length)
               {
                  if(_grid.index == this.temGridArr[i].index)
                  {
                     return i;
                  }
                  i++;
               }
            }
         }
         return -1;
      }
      
      private function changeHandle(e:Event) : void
      {
         var temTotal:int = 0;
         var tf:MyTextField = e.target as MyTextField;
         var temNum:int = int(tf.text);
         if(temNum * 10 > this.luckyValue)
         {
            temNum = int(this.luckyValue / 10);
         }
         tf.text = String(temNum);
         this.instansRate.htmlText = LangConfig.getWord("225",0) + HtmlUtil.font(String(temNum * 10),"#faff00") + LangConfig.getWord("226",0);
         this.Luckly_text.htmlText = LangConfig.getWord("231",0) + HtmlUtil.font(String(this.luckyValue - temNum * 10),"#9ada78");
         if(this.checkBox.selected)
         {
            temTotal = this.success_rate + temNum + GameUnitManager.hero.vip;
            if(temTotal > 100)
            {
               temTotal = 100;
            }
            this.ChengGongLv_text.text = String(temTotal) + "%";
         }
      }
      
      private function getHtmlText() : void
      {
         var temStr:String = HtmlUtil.link("<u>" + "<font color=\'" + "#ff0000" + "\'>" + LangConfig.getWord("240",0),"ss") + "</font>" + "</u>" + HtmlUtil.font(LangConfig.getWord("241",0),"#99ff33");
         MenuVip_text.htmlText = temStr;
         MenuVip_text.addEventListener(TextEvent.LINK,CLICKHandle);
      }
      
      override public function reset() : void
      {
         this.empty_vec_View_grid_cast_up();
         this.empty_vec_View_grid_cast_down();
         if(Boolean(this.now_down_select_grid))
         {
            this.now_down_select_grid.bSelect = false;
         }
         this.now_down_select_grid = null;
         if(Boolean(this.ChengGongLv_text))
         {
            this.ChengGongLv_text.text = "0%";
         }
         if(Boolean(this.Pecent_text))
         {
            this.Pecent_text.text = "0";
            this.Pecent_text.selectable = true;
         }
         this.luckyValue = 0;
         if(Boolean(this.Luckly_text))
         {
            this.Luckly_text.htmlText = LangConfig.getWord("231",0) + HtmlUtil.font("0","#9ada78");
         }
         if(Boolean(this.FeiYong_text))
         {
            this.FeiYong_text.text = "0";
         }
         if(Boolean(this.checkBox))
         {
            this.checkBox.selected = false;
         }
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         if(Boolean(this.view_grid_equip_now))
         {
            this.view_grid_equip_now.bSelect = false;
            this.view_grid_equip_now = null;
         }
         if(Boolean(this.view_grid_equip))
         {
            this.view_grid_equip.vo = null;
         }
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         if(Boolean(this.vec_View_Grid_sym))
         {
            this.i = 0;
            while(this.i < MAX_LUCKY_SYMBOL)
            {
               this.vec_View_Grid_sym[this.i].vo = null;
               ++this.i;
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
         tbtn_stuff.set_htmlText(LangConfig.getWord("242",0));
         tbbtn_bought.visible = true;
         tbtn_stuff.visible = true;
         tfMart.visible = true;
         tfMiJing.visible = true;
         tf_help.textColor = 11904647;
         tf_help.y = 5;
         tf_help.multiline = true;
         tf_help.wordWrap = true;
         tf_help.visible = false;
         if(!this.tfH)
         {
            this.tfH = ComponentUtil.getTextField("",this,{
               "x":157,
               "y":362 - 20,
               "leading":4,
               "color":14013822
            });
         }
         this.tfH.mouseEnabled = true;
         this.tfH.addEventListener(TextEvent.LINK,function(e:TextEvent):void
         {
            if(GameUnitManager.hero.level < 30)
            {
               UIManager.centerBroadcast.addMsg("等级不够30级");
               return;
            }
            UIManager.sm_shop.visible = true;
         });
         this.tfH.htmlText = "1.强化" + HtmlUtil.font("+7","#ff7700") + "以上可增加新的强化属性\n2.使用" + HtmlUtil.font("幸运符","#ff7700") + "(" + HtmlUtil.font(HtmlUtil.link(HtmlUtil.underLine("秘境"),"ss"),"#04ff00") + "产出)可提高成功率；\n3.强化失败会增加" + HtmlUtil.font("幸运值","#ff7700") + "，幸运值可" + HtmlUtil.font("增\n   加","#ff7700") + "强化" + HtmlUtil.font("成功率","#ff7700");
         canvas_txt.align();
         canvas_txt.x = 160;
         canvas_txt.y = 340;
         canvas_txt.visible = false;
      }
      
      override public function update() : void
      {
         this.Luckly_text.htmlText = LangConfig.getWord("231",0) + HtmlUtil.font(String(this.luckyValue),"#9ada78");
         vec_Vo_valuable_cache = vec_Vo_valuable_show_up = CommandManager.get_bag_vec(Enum_filter.EQUIP_INTENSIFY);
         if(filter != Enum_filter.ALL)
         {
            vec_Vo_valuable_show_up = CommandManager.get_bag_vec(filter,vec_Vo_valuable_show_up);
         }
      }
      
      public function intensGetEffect(res:int) : void
      {
         var str3:String = null;
         var eff1:Effect = null;
         var eff6:Effect = null;
         var eff7:Effect = null;
         var eff8:Effect = null;
         if(this.isShowCheckBoxTips && this._askType == 1)
         {
            UIManager.centerBroadcast.addMsg(this.autoBuyTips);
         }
         if(res == 1)
         {
            str3 = "instens";
            UIManager.castPanel.setTabEnable(false);
            CastEffect.getEffect(str3,this.view_grid_equip,this);
            eff1 = EffectManager.addEffect("35063",this,600,this.view_grid_item.x + this.view_grid_item.width / 2,this.view_grid_item.y + this.view_grid_item.height / 2);
            Tween.to(eff1,600,{
               "px":[this.view_grid_item.x + this.view_grid_item.width / 2,this.view_grid_equip.x + this.view_grid_equip.width / 2],
               "py":[this.view_grid_item.y + this.view_grid_item.height / 2,this.view_grid_equip.y + this.view_grid_equip.height / 2]
            },this.compleHandle);
         }
         else if(res == 6)
         {
            CastEffect.getFailEffect("insten_fail",this.view_grid_equip,this);
            eff6 = EffectManager.addEffect("35065",this,500,this.view_grid_item.x + 15,this.view_grid_item.y + 16);
            eff7 = EffectManager.addEffect("35065",this,500,this.view_grid_equip.x + 15,this.view_grid_equip.y + 16,false,2,this.endHandle);
            eff8 = EffectManager.addEffect("35066",this,500,this.view_grid_equip.x + this.view_grid_equip.width / 2 + 50,this.view_grid_equip.y + this.view_grid_equip.height - 56);
         }
         this.update_success_copy();
      }
      
      private function endHandle() : void
      {
         CastEffect.endHanlde();
      }
      
      private function compleHandle() : void
      {
         UIManager.castPanel.setTabEnable(true);
         var eff1:Effect = EffectManager.addEffect("35062",this,600,this.view_grid_equip.x + 20,this.view_grid_equip.y + 20);
      }
      
      override public function update_success_copy() : void
      {
         var temIdArr:Vector.<Vo_valuable> = null;
         this.checkBox.selected = false;
         if(!this.checkBox.enabled)
         {
            this.checkBox.enabled = true;
         }
         this.instansRate.htmlText = LangConfig.getWord("225",0) + HtmlUtil.font("0","#faff00") + LangConfig.getWord("226",0);
         this.Pecent_text.text = "0";
         this.Pecent_text.selectable = true;
         if(Boolean(this.view_grid_item.vo))
         {
            this.view_grid_item.vo = null;
         }
         this.i = 0;
         while(this.i < MAX_LUCKY_SYMBOL)
         {
            if(Boolean(this.vec_View_Grid_sym[this.i].vo))
            {
               this.vec_View_Grid_sym[this.i].vo = null;
            }
            ++this.i;
         }
         if(!this.view_grid_equip.vo)
         {
            return;
         }
         if(instensify_type == 1)
         {
            this.get_bag_data();
            if(Boolean(this.view_grid_equip.vo))
            {
               temIdArr = CommandManager.get_bag_vec(Enum_filter.GRID_ID,null,[this.view_grid_equip.vo.gridId]);
               this.view_grid_equip.vo = temIdArr[0];
            }
         }
         else if(instensify_type == 2)
         {
            this.get_self_data();
            this.view_grid_equip.vo = UIManager.rolePanel.view_role_equip.get_item_index(this.view_grid_equip.index);
         }
         if(Boolean(this.view_grid_equip.vo))
         {
            this.show_lv_intensify((this.view_grid_equip.vo as Vo_equip).lv);
         }
         this.Show_down();
         this.auto_addTool();
         this.update_tf_cost();
         this.update_tf_success();
      }
      
      private function update_tf_cost() : void
      {
         var vo_equip:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         trace(Math.ceil(vo_equip.lv_use / 10));
         var temNum:int = Math.ceil(vo_equip.lv_use / 10);
         var _lv:int = vo_equip.lv;
         if(_lv < 11)
         {
            _lv = vo_equip.lv;
         }
         else if(_lv >= 11 && _lv < 22)
         {
            _lv = 18 + (vo_equip.lv - 11);
            if(_lv > 27)
            {
               _lv = 27;
            }
         }
         else
         {
            _lv = vo_equip.lv + 7;
         }
         var dic:Dictionary = Data_lib.cast_cost;
         var str:String = Data_lib.cast_cost[Math.ceil(vo_equip.lv_use / 10)][Enum_lib_cast_cost.EQUIP_INTENSIFY_0 + _lv];
         if(!str)
         {
            return;
         }
         var arr:Array = str.split("_");
         var color:int = vo_equip.color;
         if(color == 5 || color == 6)
         {
            color = 4;
         }
         if(_lv <= 16)
         {
            this.FeiYong_text.text = arr[color - 1];
         }
         else if(_lv > 16 && _lv < 22)
         {
            this.FeiYong_text.text = arr[0];
         }
         else
         {
            this.FeiYong_text.text = arr[0];
         }
         if((this.view_grid_equip.vo as Vo_equip).lv == 10)
         {
            this.FeiYong_text.text = "0";
         }
         this.luckyValue = vo_equip.fail_count;
         this.Luckly_text.htmlText = LangConfig.getWord("231",0) + HtmlUtil.font(String(this.luckyValue),"#9ada78");
         if(int(this.Luckly_text.htmlText) < 0)
         {
            this.Luckly_text.htmlText = "0";
         }
      }
      
      private function update_tf_success() : void
      {
         var id:int = 0;
         var _lv:int = 0;
         var vo_equip:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         if(vo_equip.lv < 11)
         {
            _lv = vo_equip.lv;
         }
         else if(vo_equip.lv >= 11 && vo_equip.lv < 22)
         {
            _lv = vo_equip.lv - 11;
         }
         else
         {
            _lv = vo_equip.lv - 22;
         }
         if(_lv <= 10)
         {
            this.success_rate = this.successRateVec[_lv];
            this.i = 0;
            while(this.i < MAX_LUCKY_SYMBOL)
            {
               if(Boolean(this.vec_View_Grid_sym[this.i].vo))
               {
                  id = (this.vec_View_Grid_sym[this.i].vo as Vo_item).id;
                  this.success_rate += Data_lib.item[id][Enum_lib_item.RESULT];
               }
               ++this.i;
            }
            if(this.success_rate > 100)
            {
               this.success_rate = 100;
            }
            this.ChengGongLv_text.text = this.success_rate + "%";
            if(GameUnitManager.hero.vip != 0)
            {
               if(this.success_rate < 100)
               {
                  this.ChengGongLv_text.text = (this.success_rate + GameUnitManager.hero.vip > 100 ? 100 : this.success_rate + GameUnitManager.hero.vip) + "%";
               }
               else
               {
                  this.ChengGongLv_text.text = this.success_rate + "%";
               }
            }
            return;
         }
         throw new Error();
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
      
      private function set_select(pos:int, bSelect:Boolean) : void
      {
         if(Boolean(this.vec_View_Grid_sym_now[pos]))
         {
            if(bSelect)
            {
               if(++this.vec_View_Grid_sym_now[pos].index == 1)
               {
                  this.vec_View_Grid_sym_now[pos].bSelect = true;
               }
               --this.vec_View_Grid_sym_now[pos].count;
            }
            else
            {
               if(--this.vec_View_Grid_sym_now[pos].index == 0)
               {
                  this.vec_View_Grid_sym_now[pos].bSelect = false;
               }
               ++this.vec_View_Grid_sym_now[pos].count;
            }
         }
      }
      
      private function auto_addEquip() : void
      {
         this.view_grid_equip.vo = null;
         this.show_lv_intensify(0);
         if(this.gridId_equip > 0)
         {
            this.i = 0;
            while(this.i < vec_View_grid_extra_up.length)
            {
               if(vec_View_grid_extra_up[this.i].view_grid.vo.gridId == this.gridId_equip)
               {
                  vec_View_grid_extra_up[this.i].view_grid.bSelect = true;
                  this.view_grid_equip_now = vec_View_grid_extra_up[this.i].view_grid;
                  this.view_grid_equip.vo = vec_View_grid_extra_up[this.i].view_grid.vo;
                  this.show_lv_intensify((this.view_grid_equip.vo as Vo_equip).lv);
                  break;
               }
               ++this.i;
            }
         }
         if(Boolean(this.view_grid_equip.vo))
         {
            this.update_tf_cost();
            this.update_tf_success();
            this.Show_down();
            this.auto_addTool();
         }
         else
         {
            this.i = 0;
            while(this.i < MAX_LUCKY_SYMBOL)
            {
               this.vec_View_Grid_sym[this.i].vo = null;
               ++this.i;
            }
            this.empty_vec_View_grid_cast_down();
         }
      }
      
      private function get_item_id() : int
      {
         var id:int = 0;
         if(!this.view_grid_equip)
         {
            return 46011;
         }
         if(!this.view_grid_equip.vo)
         {
            return 46011;
         }
         var lv:int = (this.view_grid_equip.vo as Vo_equip).lv;
         if(lv < 3)
         {
            id = Const_id.INTENSIFY_STONE1;
         }
         else if(lv < 6)
         {
            id = Const_id.INTENSIFY_STONE1 + 1;
         }
         else
         {
            id = Const_id.INTENSIFY_STONE1 + 2;
         }
         return id;
      }
      
      private function auto_addTool() : void
      {
         var __id:int = 0;
         this.i = 0;
         while(this.i < MAX_LUCKY_SYMBOL)
         {
            this.vec_View_Grid_sym[this.i].vo = null;
            ++this.i;
         }
         var _vo:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         if(Boolean(_vo) && _vo.lv < 11)
         {
            __id = this.get_item_id();
         }
         else
         {
            __id = 44643;
         }
         this.checkItemPrice = Data_lib.autoBuyConst[__id][Const_id.AUTO_PRICE];
         this.checkColor = Data_lib.autoBuyConst[__id][Const_id.AUTO_COLOR];
         if(vec_Vo_valuable_show_down.length > 0)
         {
            if(vec_Vo_valuable_show_down[0].count == 0)
            {
               this.view_grid_item.vo = vec_Vo_valuable_show_down[0];
               return;
            }
            this.i = 0;
            while(this.i < vec_Vo_valuable_show_down.length)
            {
               if(vec_Vo_valuable_show_down[this.i].bBind == false)
               {
                  if(vec_Vo_valuable_show_down[this.i].id == __id)
                  {
                     this.view_grid_item.vo = vec_Vo_valuable_show_down[this.i];
                     this.view_grid_item.index = vec_View_grid_extra_down[this.i].view_grid.index;
                     this.view_grid_item_now = vec_View_grid_extra_down[this.i].view_grid;
                     this.view_grid_item_now.bSelect = true;
                     return;
                  }
               }
               ++this.i;
            }
            if(vec_Vo_valuable_show_down[0].id == __id)
            {
               this.view_grid_item.vo = vec_Vo_valuable_show_down[0];
               this.view_grid_item.index = vec_View_grid_extra_down[0].view_grid.index;
               this.view_grid_item_now = vec_View_grid_extra_down[0].view_grid;
               this.view_grid_item_now.bSelect = true;
            }
         }
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
               v.Show(arr[this.i],View_grid_extra.INTENSIFY,arr2[this.i]);
            }
            else
            {
               v.Show(arr[this.i],View_grid_extra.INTENSIFY);
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
      
      private function Show_up() : void
      {
         var v:View_grid_extra = null;
         this.empty_vec_View_grid_cast_up();
         this.i = 0;
         while(this.i < vec_Vo_valuable_show_up.length)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_bmp_select();
            v.Show(vec_Vo_valuable_show_up[this.i],View_grid_extra.INTENSIFY);
            if(this.i % 2 == 0)
            {
               v.x = INDENT;
            }
            else
            {
               v.x = INDENT + GAP_WIDTH_GRID + WIDTH_GRID;
            }
            v.y = INDENT + int(this.i / 2) * (GAP_HEIGHT_GRID + HEIGHT_GRID);
            canvas_up.addChild(v);
            v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_UP);
            vec_View_grid_extra_up.push(v);
            ++this.i;
         }
         canvas_up.reset();
         canvas_up.align();
      }
      
      private function getQuickData() : void
      {
         var voI:Vo_item = null;
         this.i = 0;
         while(this.i < this.idArr.length)
         {
            voI = new Vo_item();
            voI.id = this.idArr[this.i];
            voI.Init_lib();
            this.quickDataArrVec[this.i] = voI;
            ++this.i;
         }
      }
      
      private function showQuick() : void
      {
         var v:View_grid_extra = null;
         isShowQui = true;
         this.i = 0;
         while(this.i < this.idArr.length)
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
            v.index = this.i;
            v.y = INDENT + int(this.i / 2) * 43;
            this.quickContainer.addChild(v);
            vec_View_grid_extra_down_quickData.push(v);
            v.setTypePri(this.priceTypeArr[this.i]);
            v.Show(this.quickDataArrVec[this.i],-2);
            ++this.i;
         }
         canvas_down_quickMetia.addChild(this.quickContainer);
         canvas_down_quickMetia.align();
      }
      
      private function Show_down() : void
      {
         var vec_Vo_valuable_temp:Vector.<Vo_valuable> = null;
         var temp:int = 0;
         var v:View_grid_extra = null;
         var vo:Vo_item = null;
         this.empty_vec_View_grid_cast_down();
         var bZero:Boolean = false;
         var _vo:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         if(Boolean(_vo) && _vo.lv < 11)
         {
            temp = this.get_item_id();
         }
         else
         {
            temp = 44643;
         }
         vec_Vo_valuable_show_down = CommandManager.get_bag_vec(Enum_filter.ID,null,[temp]);
         if(vec_Vo_valuable_show_down.length == 0)
         {
            bZero = true;
         }
         vec_Vo_valuable_temp = CommandManager.get_bag_vec(Enum_filter.ID,null,[Const_id.INTENSIFY_LUCKY1,Const_id.INTENSIFY_LUCKY1 + 1,Const_id.INTENSIFY_LUCKY1 + 2,44654,44655,44656,44657,44658,44659]);
         this.i = 0;
         while(this.i < vec_Vo_valuable_temp.length)
         {
            vec_Vo_valuable_show_down.push(vec_Vo_valuable_temp[this.i]);
            ++this.i;
         }
         if(bZero)
         {
            v = pool.pop() as View_grid_extra;
            v.view_grid.type = Enum_type_grid.CAST;
            v.view_grid.set_bmp_bg();
            v.view_grid.set_bmp_over();
            v.view_grid.set_tf_count(true,true,true);
            v.x = 7;
            v.y = INDENT;
            vo = new Vo_item();
            vo.id = temp;
            vo.Init_lib();
            vo.count = 0;
            metiaContainer.addChild(v);
            v.Show(vo,View_grid_extra.INTENSIFY);
            vec_View_grid_extra_down.push(v);
            vec_Vo_valuable_show_down.unshift(vo);
            this.i = 1;
         }
         else
         {
            this.i = 0;
         }
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
            v.index = this.i;
            v.y = INDENT + int(this.i / 2) * (GAP_HEIGHT_GRID + HEIGHT_GRID);
            metiaContainer.addChild(v);
            v.Show(vec_Vo_valuable_show_down[this.i],View_grid_extra.INTENSIFY);
            v.view_grid.addEventListener(MouseEvent.CLICK,this.CLICK_DOWN);
            vec_View_grid_extra_down.push(v);
            ++this.i;
         }
         canvas_down.addChild(metiaContainer);
         canvas_down.reset();
         canvas_down.align();
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
            if(Boolean(vec_View_grid_extra_down[this.i].parent))
            {
               vec_View_grid_extra_down[this.i].parent.removeChild(vec_View_grid_extra_down[this.i]);
            }
            vec_View_grid_extra_down[this.i].view_grid.empty();
            pool.push(vec_View_grid_extra_down[this.i]);
            vec_View_grid_extra_down.pop();
            --this.i;
         }
         canvas_down.removeChild(metiaContainer);
      }
      
      private function show_lv_intensify(lv:int) : void
      {
         var n:int = 0;
         var _n:int = 0;
         if(lv <= 11)
         {
            this.i = 0;
            while(this.i < Vo_equip.MAX_LV_INTENSIFY)
            {
               if(this.i < lv)
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY2,this.vec_bmpLv[this.i]);
               }
               else
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY1,this.vec_bmpLv[this.i]);
               }
               ++this.i;
            }
         }
         else if(lv > 11 && lv <= 21)
         {
            n = lv - 11;
            this.i = 0;
            while(this.i < Vo_equip.MAX_LV_INTENSIFY)
            {
               if(this.i < n)
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY4,this.vec_bmpLv[this.i]);
               }
               else
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY2,this.vec_bmpLv[this.i]);
               }
               ++this.i;
            }
         }
         else
         {
            _n = lv - 22;
            this.i = 0;
            while(this.i < Vo_equip.MAX_LV_INTENSIFY)
            {
               if(this.i < _n)
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY6,this.vec_bmpLv[this.i]);
               }
               else
               {
                  Utils.getLoadBitmap(Const_strImg.LV_INTENSIFY4,this.vec_bmpLv[this.i]);
               }
               ++this.i;
            }
         }
      }
      
      private function CLICK_BTN_OK(e:MouseEvent) : void
      {
         var vo_equip:Vo_equip = null;
         if(this.view_grid_equip.vo == null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("167",0));
            return;
         }
         vo_equip = this.view_grid_equip.vo as Vo_equip;
         if(vo_equip.lv == Vo_equip.MAX_LV_INTENSIFY)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("243",0));
            return;
         }
         if(vo_equip.bBind == false)
         {
            this.i = 0;
            while(this.i < MAX_LUCKY_SYMBOL)
            {
               if(Boolean(this.vec_View_Grid_sym[this.i].vo) && (this.vec_View_Grid_sym[this.i].vo as Vo_item).bBind)
               {
                  View_Alert.show(LangConfig.getWord("244",0) + HtmlUtil.font(LangConfig.getWord("172",0),ColorConstant.getColorStr(ColorConstant.RED)),View_Alert.OK_CANCAL,this.CLICK_OK);
                  return;
               }
               ++this.i;
            }
         }
         this.CLICK_OK();
      }
      
      private function CLICK_OK(e:MouseEvent = null) : void
      {
         var vec:Vector.<int> = new Vector.<int>();
         this.i = 0;
         while(this.i < MAX_LUCKY_SYMBOL)
         {
            if(Boolean(this.vec_View_Grid_sym[this.i].vo))
            {
               vec.push(this.vec_View_Grid_sym[this.i].vo.gridId);
            }
            ++this.i;
         }
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
         if((temp.vo as Vo_equip).lv == 10)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("245",0));
            return;
         }
         this.view_grid_equip.vo = temp.vo;
         this.view_grid_equip.index = temp.index;
         if(Boolean(this.view_grid_item.vo))
         {
            this.view_grid_item.vo = null;
         }
         this.checkBox.selected = false;
         if(!this.checkBox.enabled)
         {
            this.checkBox.enabled = true;
         }
         this.show_lv_intensify((this.view_grid_equip.vo as Vo_equip).lv);
         this.Pecent_text.text = "0";
         this.instansRate.htmlText = LangConfig.getWord("225",0) + HtmlUtil.font("0","#faff00") + LangConfig.getWord("226",0);
         this.Luckly_text.htmlText = LangConfig.getWord("231",0) + HtmlUtil.font(String((this.view_grid_equip.vo as Vo_equip).fail_count),"#9ada78");
         this.view_grid_equip_now = temp;
         this.view_grid_equip_now.bSelect = true;
         this.gridId_equip = this.view_grid_equip.vo.gridId;
         this.Pecent_text.selectable = true;
         this.i = 0;
         while(this.i < MAX_LUCKY_SYMBOL)
         {
            this.vec_View_Grid_sym[this.i].vo = null;
            ++this.i;
         }
         this.Show_down();
         this.auto_addTool();
         this.update_tf_cost();
         this.update_tf_success();
      }
      
      private function CLICK_UP(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         this.getClickGrid(temp);
      }
      
      private function getEmptyGrid() : int
      {
         var i:int = 0;
         while(i < this.vec_View_Grid_sym.length)
         {
            if(!this.vec_View_Grid_sym[i].vo)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function CLICK_DOWN(e:MouseEvent) : void
      {
         var __id:int = 0;
         var temNum:int = 0;
         var temp:View_Grid = e.target as View_Grid;
         var temV:View_grid_extra = e.target.parent as View_grid_extra;
         if(Boolean(this.now_down_select_grid))
         {
            this.now_down_select_grid.bSelect = false;
         }
         this.now_down_select_grid = temp;
         this.now_down_select_grid.bSelect = true;
         if(this.view_grid_item.vo == temp.vo)
         {
            return;
         }
         if(temp.vo.id != 46071 && temp.vo.id != 46072 && temp.vo.id != 46073)
         {
            this.view_grid_item.vo = temp.vo;
            this.view_grid_item.index = temV.index;
         }
         else
         {
            if(this.success_rate >= 100)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("247",0));
               return;
            }
            if(temp.count < 1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("248",0));
               return;
            }
            temNum = this.getEmptyGrid();
            if(temNum == -1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("249",0));
               return;
            }
            this.vec_View_Grid_sym[temNum].vo = temp.vo;
            this.vec_View_Grid_sym[temNum].index = temV.index;
         }
         var _vo:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         if(Boolean(_vo) && _vo.lv < 11)
         {
            __id = this.get_item_id();
         }
         else
         {
            __id = 44643;
         }
         if(temp.vo.id != __id)
         {
            if(temp.vo.id == Const_id.INTENSIFY_LUCKY1 || temp.vo.id == Const_id.INTENSIFY_LUCKY1 + 1 || temp.vo.id == Const_id.INTENSIFY_LUCKY1 + 2)
            {
               --temp.count;
               this.update_tf_success();
            }
            else if(temp.vo.id == 44654 || temp.vo.id == 44655 || temp.vo.id == 44656 || temp.vo.id == 44657 || temp.vo.id == 44658 || temp.vo.id == 44659)
            {
               trace("特殊强化石");
            }
            else
            {
               this.i = 0;
               while(this.i < MAX_LUCKY_SYMBOL)
               {
                  if(this.vec_View_Grid_sym[this.i].vo == null && temp.count > 0)
                  {
                     this.vec_View_Grid_sym[this.i].vo = temp.vo;
                     this.vec_View_Grid_sym_now[this.i] = temp;
                     this.update_tf_success();
                     return;
                  }
                  ++this.i;
               }
            }
         }
      }
      
      private function PRO_CANCEL(event:MouseEvent) : void
      {
         if(Boolean(this.view_grid_pro.vo))
         {
            this.view_grid_pro.vo = null;
         }
      }
      
      private function STONE_CANCEL(e:MouseEvent) : void
      {
         var temGrid:View_Grid = e.target as View_Grid;
         if(!temGrid.vo)
         {
            return;
         }
         var i:int = 0;
         while(i < vec_View_grid_extra_down.length)
         {
            if(vec_View_grid_extra_down[i].index == temGrid.index)
            {
            }
            i++;
         }
         temGrid.vo = null;
         if(Boolean(this.now_down_select_grid))
         {
            this.now_down_select_grid.bSelect = false;
         }
         this.now_down_select_grid = null;
      }
      
      private function update_down_stone(tem_grid:View_Grid) : void
      {
         var i:int = 0;
         while(i < vec_View_grid_extra_down.length)
         {
            if(vec_View_grid_extra_down[i].view_grid.vo.id == tem_grid.vo.id)
            {
               ++vec_View_grid_extra_down[i].view_grid.count;
            }
            i++;
         }
      }
      
      private function EQUIP_CANCEL(event:MouseEvent) : void
      {
         if(Boolean(this.view_grid_equip.vo))
         {
            this.return_data();
         }
      }
      
      private function return_data() : void
      {
         this.FeiYong_text.text = "0";
         this.ChengGongLv_text.text = "0%";
         this.Luckly_text.htmlText = LangConfig.getWord("231",0) + HtmlUtil.font("0","#9ada78");
         if(Boolean(this.now_down_select_grid))
         {
            this.now_down_select_grid.bSelect = false;
         }
         this.now_down_select_grid = null;
         this.checkBox.enabled = true;
         this.checkBox.selected = false;
         if(Boolean(this.view_grid_equip_now))
         {
            this.view_grid_equip_now.bSelect = false;
            this.view_grid_equip_now = null;
         }
         if(Boolean(this.view_grid_equip))
         {
            this.view_grid_equip.vo = null;
         }
         if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.vo = null;
         }
         this.i = 0;
         while(this.i < MAX_LUCKY_SYMBOL)
         {
            this.vec_View_Grid_sym[this.i].vo = null;
            ++this.i;
         }
         this.show_lv_intensify(0);
         this.empty_vec_View_grid_cast_down();
      }
      
      private function LUCKY_CANCEL(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         if(Boolean(temp.vo))
         {
            this.updata_down(temp);
            if(Boolean(this.now_down_select_grid))
            {
               this.now_down_select_grid.bSelect = false;
            }
            this.now_down_select_grid = null;
            temp.vo = null;
            this.update_tf_success();
         }
      }
      
      private function updata_down(temp_grid:View_Grid) : void
      {
         var i:int = 0;
         while(i < vec_View_grid_extra_down.length)
         {
            if(vec_View_grid_extra_down[i].index == temp_grid.index)
            {
               ++vec_View_grid_extra_down[i].view_grid.count;
            }
            i++;
         }
      }
   }
}

