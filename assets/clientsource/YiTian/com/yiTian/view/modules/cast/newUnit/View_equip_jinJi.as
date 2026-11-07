package com.yiTian.view.modules.cast.newUnit
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
   import com.yiTian.view.modules.cast.Enum_lib_cast_cost;
   import com.yiTian.view.modules.cast.View_cast_base;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class View_equip_jinJi extends View_cast_base
   {
      
      private static var MenuVip_text:MyTextField;
      
      public static var nowChooseUpLvl:int;
      
      public static const MAX_LUCKY_SYMBOL:int = 3;
      
      public static var instensify_type:int = 2;
      
      private static var poolTxt:Array = [];
      
      private static var listTxt1:Array = [];
      
      private static var listTxt2:Array = [];
      
      private static var BBPool:Array = [];
      
      private static var BBList:Array = [];
      
      private static var ratArr:Array = ["10","15","20","30","40","50","60","70","80","90","100"];
      
      private static var isFirst:Boolean = true;
      
      private static var vipRights:Array = [LangConfig.getWord("234",0),LangConfig.getWord("235",0),LangConfig.getWord("236",0)];
      
      private static var IncreaseArr:Array = [LangConfig.getWord("237",0),LangConfig.getWord("238",0),LangConfig.getWord("239",0)];
      
      private static var isShowQui:Boolean = false;
      
      private var view_grid_equip_now:View_Grid;
      
      private var view_grid_equip:View_Grid;
      
      private var view_grid_item:View_Grid;
      
      private var view_grid_pro:View_Grid;
      
      private var vec_View_Grid_sym:Vector.<View_Grid>;
      
      private var vec_bmpLv:Vector.<Bitmap>;
      
      private var gridId_equip:int;
      
      private var i:int;
      
      public var view_grid_equip_arr:Array = [];
      
      private var tf_of_view_grid_equip:Array = [LangConfig.getWord("162",0),LangConfig.getWord("219",0) + "\n" + LangConfig.getWord("164",0)];
      
      private var Luckly_text:MyTextField;
      
      private var instansRate:MyTextField;
      
      private var Button_QiangHua:Button;
      
      private var Button_Chai:TabButton;
      
      private var Button_body:TabButton;
      
      private var Button_Bag:TabButton;
      
      private var tfCost:MyTextField;
      
      private var backNum1:ScaleBitmap;
      
      private var backNum2:ScaleBitmap;
      
      private var view_grid_equip_new:View_Grid;
      
      private var now:TabButton;
      
      private var luckySignStr:String = "";
      
      private var self_data:Vector.<Vo_valuable>;
      
      private var bag_data:Vector.<Vo_valuable>;
      
      private var temGridArr:Vector.<View_Grid>;
      
      private var vec_now_data:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
      
      private var tfExtral:MyTextField;
      
      private var change_to_equip:Vo_equip;
      
      private var container1:Sprite;
      
      private var _truN:int;
      
      private var tfAddVec1:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var tfAddVec2:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var lvUpBmVec:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var spr:Sprite;
      
      private var useValue:int;
      
      private var tfTDes:MyTextField;
      
      private var tfH:MyTextField;
      
      private var luckyValue:int = 0;
      
      private var view_grid_item_now:View_Grid;
      
      private var quickDataArrVec:Vector.<Vo_item> = new Vector.<Vo_item>();
      
      private var idArr:Array = [46011,46012,46013];
      
      private var priceTypeArr:Array = [[5,3],[18,4],[60,5]];
      
      private var quickContainer:Sprite = new Sprite();
      
      private var now_down_select_grid:View_Grid;
      
      public function View_equip_jinJi()
      {
         super();
      }
      
      private static function getTxt() : MyTextField
      {
         return poolTxt.pop() || ComponentUtil.getTextField("");
      }
      
      private static function getB() : Bitmap
      {
         return BBPool.pop() || ComponentUtil.getBitmap("LvUp_Img",null,null,Global.Forging_Imgsdm);
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
         this.gridId_equip = 0;
         this.init();
      }
      
      private function init() : void
      {
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
            "x":220 - 10,
            "y":297,
            "width":74,
            "height":20
         },Global.Img_Cdm);
         this.backNum1 = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":161 - 10,
            "y":201,
            "width":97,
            "height":69
         },Global.Img_Cdm);
         this.backNum2 = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":285 - 10,
            "y":201,
            "width":97,
            "height":69
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":157 - 10,
            "y":324,
            "width":229,
            "height":115
         },Global.Img_Cdm);
         this.Button_body = ComponentUtil.getTabButton("身上装备","TabButton_Four",this,{
            "x":395,
            "y":44,
            "textColor":16773818,
            "name":"self",
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_Bag = ComponentUtil.getTabButton("背包装备","TabButton_Four",this,{
            "x":470,
            "y":44,
            "textColor":16773818,
            "name":"bag",
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_body.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Bag.addEventListener(MouseEvent.CLICK,this.cliHandle);
         ComponentUtil.getTextField("晋级费用",this,{
            "x":160 - 10,
            "y":298,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.tfCost = ComponentUtil.getTextField("0",this,{
            "x":225 - 10,
            "y":298,
            "color":15318372,
            "size":12,
            "leading":0
         });
         this.Button_QiangHua = ComponentUtil.getButton("装备晋级","Button_Orange",this,{
            "x":305 - 10,
            "y":297,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_QiangHua.callBack = this.instensifyHandle;
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":155 - 10,
            "y":49,
            "width":233,
            "height":234
         },Global.Img_Cdm);
      }
      
      private function cliCheHandle(e:CheckBox) : void
      {
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
      
      private function instensifyHandle(e:MouseEvent) : void
      {
         var temStr:String = this.getLuckySignStr();
         if(!this.view_grid_equip.vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("232",0));
            return;
         }
         if(!this.view_grid_item.vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("233",0));
            return;
         }
         if(Boolean(this.view_grid_item.vo) && this._truN < 0)
         {
            UIManager.centerBroadcast.addMsg("材料不足");
            return;
         }
         nowChooseUpLvl = (this.view_grid_equip.vo as Vo_equip).lv;
         CastCGMessage.CG_CLICK_UP_LEVEL((this.view_grid_equip.vo as Vo_equip).id_server);
      }
      
      private function getLuckySignStr() : String
      {
         return this.handle_grid();
      }
      
      private function handle_grid() : String
      {
         return "";
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
            this.temGridArr = UIManager.rolePanel.view_role_equip.get_can_jinji_equip();
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
         this.bag_data = CommandManager.get_bag_vec(Enum_filter.EQUIP_CAN_JINJI);
         this.vec_now_data = this.bag_data;
         this.show_up_data(this.bag_data);
      }
      
      private function rePos() : void
      {
         var itemB:Bitmap = null;
         var tfI1:MyTextField = null;
         var tfI2:MyTextField = null;
         if(Boolean(this.view_grid_equip.vo) && (this.view_grid_equip.vo as Vo_equip).lv == 21)
         {
            this.container1.visible = false;
            this.backNum1.height = 85;
            this.backNum2.height = 85;
            this.backNum1.y = this.backNum2.y = 197;
            if(!this.tfExtral)
            {
               this.tfExtral = ComponentUtil.getTextField("",this,{
                  "x":220,
                  "y":177
               });
               this.tfExtral.htmlText = "附加属性" + HtmlUtil.font("+35%","#04ff00");
            }
            this.tfExtral.visible = true;
            this.showNextAtt();
            for each(itemB in this.lvUpBmVec)
            {
               itemB.visible = false;
            }
            for each(tfI1 in this.tfAddVec1)
            {
               tfI1.visible = false;
            }
            for each(tfI2 in this.tfAddVec2)
            {
               tfI2.visible = false;
            }
         }
         else
         {
            this.container1.visible = this.container1.visible || true;
            if(Boolean(this.tfExtral))
            {
               this.tfExtral.visible = false;
            }
            this.backNum1.height = 69;
            this.backNum2.height = 69;
            this.backNum1.y = this.backNum2.y = 201;
            if(Boolean(this.view_grid_equip.vo))
            {
               this.showTfAtt();
            }
            this.disP();
         }
      }
      
      private function disP() : void
      {
         var t:MyTextField = null;
         var tt:MyTextField = null;
         var b:Bitmap = null;
         while(Boolean(listTxt1.length))
         {
            t = listTxt1.pop();
            if(Boolean(t.parent))
            {
               t.parent.removeChild(t);
            }
            poolTxt.push(t);
         }
         while(Boolean(listTxt2.length))
         {
            tt = listTxt2.pop();
            if(Boolean(tt.parent))
            {
               tt.parent.removeChild(tt);
            }
            poolTxt.push(tt);
         }
         while(Boolean(BBList.length))
         {
            b = BBList.pop();
            if(Boolean(b.parent))
            {
               b.parent.removeChild(b);
            }
            BBPool.push(b);
         }
         listTxt2.splice(0);
         listTxt1.splice(0);
         BBList.splice(0);
      }
      
      private function showNextAtt() : void
      {
         var t1:MyTextField = null;
         var t2:MyTextField = null;
         var b:Bitmap = null;
         var id_att:int = 0;
         var addAtt:int = 0;
         var extralAtt:int = 0;
         var str1:String = null;
         var str2:String = null;
         if(!this.view_grid_equip.vo)
         {
            return;
         }
         var voEq:Vo_equip = this.view_grid_equip_new.vo as Vo_equip;
         var len:int = voEq.vec_extend.length / 4;
         if(!this.change_to_equip)
         {
            this.change_to_equip = new Vo_equip();
         }
         this.change_to_equip = voEq;
         this.change_to_equip.vec_basic = (this.view_grid_equip.vo as Vo_equip).vec_basic;
         this.change_to_equip.lv = 22;
         var temExtend:Vector.<int> = new Vector.<int>();
         var i:int = 0;
         while(i < len)
         {
            t1 = getTxt();
            t2 = getTxt();
            ComponentUtil.setPropertie(t1,{
               "x":168 - 10,
               "y":197 + 16 * i
            });
            ComponentUtil.setPropertie(t2,{
               "x":289 - 10,
               "y":197 + 16 * i
            });
            b = getB();
            ComponentUtil.setPropertie(b,{
               "x":370 - 14,
               "y":200 + i * 16
            });
            BBList.push(b);
            addChild(b);
            addChild(t1);
            addChild(t2);
            listTxt1.push(t1);
            listTxt2.push(t2);
            id_att = voEq.vec_extend[4 * i];
            addAtt = voEq.vec_extend[4 * i + 1];
            extralAtt = addAtt * (1 + 0.35);
            str1 = this.getAttribute1(id_att,addAtt,voEq,0);
            str2 = this.getAttribute1(id_att,extralAtt,voEq,0);
            temExtend.push(voEq.vec_extend[4 * i],voEq.vec_extend[4 * i + 1],voEq.vec_extend[4 * i + 2],int(addAtt * 0.35));
            t1.htmlText = str1;
            t2.htmlText = str2;
            i++;
         }
         this.change_to_equip.vec_extend = temExtend;
         this.view_grid_equip_new.vo = this.change_to_equip;
         this.tfCost.htmlText = "5000000";
      }
      
      private function showBmp() : void
      {
         var i:int = 0;
         var tf1:MyTextField = null;
         var tf2:MyTextField = null;
         if(!this.spr)
         {
            this.spr = new Sprite();
            addChild(this.spr);
            this.spr.x = 284;
            this.spr.y = 5;
         }
         this.spr.mouseChildren = false;
         this.spr.mouseEnabled = false;
         ComponentUtil.getBitmap("Forging_Back1",this,{
            "x":160 - 10,
            "y":62
         },Global.Forging_Imgsdm);
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this,{
            "x":165 - 10,
            "y":51,
            "width":213,
            "height":21
         },Global.Forging_Imgsdm);
         ComponentUtil.getBitmap("IconBack",this,{
            "x":182 - 10,
            "y":122
         },Global.Forging_Imgsdm);
         ComponentUtil.getBitmap("IconBack",this,{
            "x":312 - 10,
            "y":122
         },Global.Forging_Imgsdm);
         i = 0;
         while(i < 3)
         {
            this.lvUpBmVec.push(ComponentUtil.getBitmap("LvUp_Img",this,{
               "x":370 - 10,
               "y":209 + i * 20
            },Global.Forging_Imgsdm));
            i++;
         }
         ComponentUtil.getBitmap("Turn_Img",this,{
            "x":231 - 10,
            "y":122
         },Global.Forging_Imgsdm);
         ComponentUtil.getTextField("点击对应装备进行晋级",this,{
            "x":206 - 10,
            "y":52,
            "color":15318372,
            "size":12,
            "leading":0
         });
         if(!this.container1)
         {
            this.container1 = new Sprite();
            addChild(this.container1);
            ComponentUtil.setPropertie(this.container1,{
               "x":150,
               "y":177
            });
         }
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this.container1,{
            "x":0,
            "y":0,
            "width":100,
            "height":21
         },Global.Forging_Imgsdm);
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,17],this.container1,{
            "x":123,
            "y":0,
            "width":100,
            "height":21
         },Global.Forging_Imgsdm);
         ComponentUtil.getTextField("当前基本属性",this.container1,{
            "x":12,
            "y":1,
            "color":15318372,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("晋级基本属性",this.container1,{
            "x":135,
            "y":1,
            "color":15318372,
            "size":12,
            "leading":0
         });
         this.view_grid_equip = new View_Grid();
         this.view_grid_equip.type = Enum_type_grid.CAST;
         this.view_grid_equip.set_bmp_bg();
         this.view_grid_equip.set_bmp_over();
         this.view_grid_equip.set_tf_info(HtmlUtil.font(LangConfig.getWord("162",0),"#d5d57e"));
         addChild(this.view_grid_equip);
         this.view_grid_equip.x = 187 + 3 - 10;
         this.view_grid_equip.y = 127 + 3;
         this.view_grid_equip.addEventListener(MouseEvent.CLICK,this.EQUIP_CANCEL);
         this.view_grid_equip_new = new View_Grid();
         this.view_grid_equip_new.type = Enum_type_grid.CAST;
         this.view_grid_equip_new.set_bmp_bg();
         this.view_grid_equip_new.set_bmp_over(true,null);
         this.view_grid_equip_new.set_tf_info(HtmlUtil.font(LangConfig.getWord("162",0),"#d5d57e"));
         addChild(this.view_grid_equip_new);
         this.view_grid_equip_new.x = 317 + 3 - 10;
         this.view_grid_equip_new.y = 127 + 3;
         this.view_grid_item = new View_Grid();
         this.view_grid_item.type = Enum_type_grid.CAST;
         this.view_grid_item.set_bmp_bg();
         this.view_grid_item.set_bmp_over(true,null);
         this.view_grid_item.set_tf_info(HtmlUtil.font("神石","#d5d57e"));
         addChild(this.view_grid_item);
         this.view_grid_item.x = 252 - 10;
         this.view_grid_item.y = 75;
         i = 0;
         while(i < 3)
         {
            tf1 = ComponentUtil.getTextField("",this,{
               "x":166 - 10,
               "y":206 + 20 * i
            });
            tf2 = ComponentUtil.getTextField("",this,{
               "x":288 - 10,
               "y":206 + 20 * i
            });
            this.tfAddVec1.push(tf1);
            this.tfAddVec2.push(tf2);
            i++;
         }
         isFirst = false;
      }
      
      private function visiHd() : void
      {
         var _vo:Vo_item = null;
         var _id:int = 0;
         var _num:int = 0;
         var _truNum:int = 0;
         var needCount:int = 0;
         var colorS:String = null;
         var tfI1:MyTextField = null;
         var tfI2:MyTextField = null;
         var itemB:Bitmap = null;
         if(Boolean(this.view_grid_item) && Boolean(this.view_grid_item.vo))
         {
            _vo = this.view_grid_item.vo as Vo_item;
            _id = _vo.id;
            _num = CommandManager.get_bag_count(_id);
            _truNum = _num;
            needCount = 10;
            if(Boolean(this.view_grid_equip.vo) && (this.view_grid_equip.vo as Vo_equip).lv == 21)
            {
               needCount = 15;
            }
            colorS = needCount > _num ? "#fe0000" : "#f4cd31";
            this._truN = _num - needCount;
            this.view_grid_item.set_tf_info(HtmlUtil.font("\n" + needCount + "/",colorS) + HtmlUtil.font(_truNum.toString(),colorS),this.view_grid_item.numChildren - 1);
         }
         else if(Boolean(this.view_grid_item))
         {
            this.view_grid_item.set_tf_info(HtmlUtil.font("神石","#d5d57e"));
         }
         if(Boolean(this.view_grid_equip) && this.view_grid_equip.vo == null)
         {
            this.view_grid_equip_new.vo = null;
            for each(tfI1 in this.tfAddVec1)
            {
               tfI1.visible = false;
            }
            for each(tfI2 in this.tfAddVec2)
            {
               tfI2.visible = false;
            }
            for each(itemB in this.lvUpBmVec)
            {
               itemB.visible = false;
            }
            this.tfCost.text = "0";
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
            instensify_type = 2;
            this.show_lv_intensify(0);
            GameScene.instance.addFrameCallBack(this.visiHd);
            if(!Global.Forging_Imgsdm)
            {
               SingleLoader.add("lang/ch/Forging_Imgs.swf",function(info:Object):void
               {
                  Global.Forging_Imgsdm = info.applicationDomain;
                  showBmp();
               });
            }
            else if(isFirst)
            {
               this.showBmp();
            }
            this.get_self_data();
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.visiHd);
            this.reset();
            this.disP();
            if(Boolean(this.container1))
            {
               this.container1.visible = true;
            }
            if(Boolean(this.tfExtral))
            {
               this.tfExtral.visible = false;
            }
         }
      }
      
      private function getAttribute1(id_attribute:int, value:int, vo_equip:Vo_equip, extralAtt:int) : String
      {
         if(vo_equip.type != 11)
         {
            if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
            {
               return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + HtmlUtil.font(" +" + (value + extralAtt) + "","#f9ff00");
            }
            if(id_attribute == 10)
            {
               return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + HtmlUtil.font(" +" + (value + extralAtt) + "","#f9ff00");
            }
            return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + HtmlUtil.font(" +" + (value + extralAtt) + "%","#f9ff00");
         }
         if(vo_equip.daoTime != -2)
         {
            if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
            {
               return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font(" +" + (value + extralAtt) + "","#f9ff00");
            }
            if(id_attribute == 10)
            {
               return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font(" +" + (value + extralAtt) + "","#f9ff00");
            }
            return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font(" +" + (value + extralAtt) + "%","#f9ff00");
         }
         if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
         {
            return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font(" +" + (value + extralAtt).toString(),ColorConstant.getColorStr(ColorConstant.GREY)) + "";
         }
         if(id_attribute == 10)
         {
            return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font(" +" + (value + extralAtt).toString(),ColorConstant.getColorStr(ColorConstant.GREY)) + "";
         }
         return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font(" +" + (value + extralAtt).toString(),ColorConstant.getColorStr(ColorConstant.GREY)) + "%";
      }
      
      private function getAttribute2(id_attribute:int, value:int, vo_equip:Vo_equip, extralAtt:int) : String
      {
         var _addn:int = 0;
         var n:int = (value + extralAtt) * 1.1 * 10;
         if(int(n % 10) < 5)
         {
            _addn = int((value + extralAtt) * 1.1);
         }
         else
         {
            _addn = int((value + extralAtt) * 1.1) + 1;
         }
         if(vo_equip.type != 11)
         {
            if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
            {
               return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + HtmlUtil.font(" +" + _addn + "","#f9ff00");
            }
            if(id_attribute == 10)
            {
               return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + HtmlUtil.font(" +" + _addn + "","#f9ff00");
            }
            return Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME] + HtmlUtil.font(" +" + _addn + "%","#f9ff00");
         }
         if(vo_equip.daoTime != -2)
         {
            if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
            {
               return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font(" +" + _addn + "","#f9ff00");
            }
            if(id_attribute == 10)
            {
               return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font(" +" + _addn + "","#f9ff00");
            }
            return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font(" +" + _addn + "%","#f9ff00");
         }
         if(Data_lib.attribute[id_attribute][Enum_lib_attribute.TYPE] == 1)
         {
            return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font(" +" + _addn.toString(),ColorConstant.getColorStr(ColorConstant.GREY)) + "";
         }
         if(id_attribute == 10)
         {
            return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font(" +" + _addn.toString(),ColorConstant.getColorStr(ColorConstant.GREY)) + "";
         }
         return HtmlUtil.font(Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME],ColorConstant.getColorStr(ColorConstant.GREY)) + HtmlUtil.font(" +" + _addn.toString(),ColorConstant.getColorStr(ColorConstant.GREY)) + "%";
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
         var tf:MyTextField = e.target as MyTextField;
         var temNum:int = int(tf.text);
         if(temNum * 10 > this.luckyValue)
         {
            temNum = int(this.luckyValue / 10);
         }
         tf.text = String(temNum);
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
         this.luckyValue = 0;
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
         tbtn_stuff.set_htmlText("晋级材料");
         tbtn_stuff.visible = true;
         tbbtn_bought.visible = false;
         tfMart.visible = true;
         tfMiJing.visible = true;
         tf_help.visible = false;
         if(this.tfTDes)
         {
         }
         if(!this.tfH)
         {
            this.tfH = ComponentUtil.getTextField("",this,{
               "x":164 - 10,
               "y":347 - 17,
               "leading":4,
               "color":14013822
            });
         }
         this.tfH.mouseEnabled = true;
         this.tfH.addEventListener(TextEvent.LINK,function():void
         {
            UIManager.castPanel.openView(0);
         });
         this.tfH.htmlText = "1.只有" + HtmlUtil.font("强化 +10或+20","#ff7700") + "的品质为" + HtmlUtil.font("紫色","#ff7700") + "、" + HtmlUtil.font("橙\n   色或暗金色","#ff7700") + "的装备才可以晋级\n2.装备晋级后基本属性或附加属性得到提\n   升\n3.晋级后增加对应装备" + HtmlUtil.font("名称前缀","#ff7700") + "\n4.晋级后的装备" + HtmlUtil.font("可继续进行","#ff7700") + HtmlUtil.font(HtmlUtil.link(HtmlUtil.underLine("装备强化"),"ss"),"#04ff00");
         canvas_txt.align();
         canvas_txt.x = 160;
         canvas_txt.y = 340;
         canvas_txt.visible = false;
      }
      
      override public function update() : void
      {
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
         if(res == 1)
         {
            str3 = "instens";
            UIManager.castPanel.setTabEnable(false);
            CastEffect.getEffect(str3,this.view_grid_equip,this);
            eff1 = EffectManager.addEffect("35063",this,600,this.view_grid_equip.x + this.view_grid_equip.width / 2,this.view_grid_equip.y + this.view_grid_equip.height / 2);
            Tween.to(eff1,600,{
               "px":[this.view_grid_equip.x + this.view_grid_equip.width / 2,this.view_grid_equip_new.x + this.view_grid_equip_new.width / 2],
               "py":[this.view_grid_equip.y + this.view_grid_equip.height / 2,this.view_grid_equip_new.y + this.view_grid_equip_new.height / 2]
            },this.compleHandle);
         }
         else if(res == 6)
         {
            CastEffect.getFailEffect("insten_fail",this.view_grid_equip,this);
            eff6 = EffectManager.addEffect("35065",this,500,this.view_grid_equip.x + 15,this.view_grid_equip.y + 16);
            eff7 = EffectManager.addEffect("35065",this,500,this.view_grid_equip_new.x + 15,this.view_grid_equip_new.y + 16,false,2,this.endHandle);
            eff8 = EffectManager.addEffect("35066",this,500,this.view_grid_equip_new.x + this.view_grid_equip_new.width / 2 + 50,this.view_grid_equip_new.y + this.view_grid_equip_new.height - 56);
         }
         this.update_success_copy();
      }
      
      private function endHandle() : void
      {
         CastEffect.endHanlde();
      }
      
      private function compleHandle() : void
      {
         var tfI2:MyTextField = null;
         var itemB:Bitmap = null;
         UIManager.castPanel.setTabEnable(true);
         var eff1:Effect = EffectManager.addEffect("35062",this,600,this.view_grid_equip_new.x + this.view_grid_equip_new.width / 2 - 3,this.view_grid_equip_new.y + this.view_grid_equip_new.height / 2);
         var __voE:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         if(Boolean(__voE))
         {
            this.view_grid_equip_new.vo = null;
            this.view_grid_item.vo = null;
            for each(tfI2 in this.tfAddVec2)
            {
               tfI2.visible = false;
            }
            for each(itemB in this.lvUpBmVec)
            {
               itemB.visible = false;
            }
         }
      }
      
      override public function update_success_copy() : void
      {
         var temIdArr:Vector.<Vo_valuable> = null;
         if(Boolean(this.view_grid_item.vo))
         {
            this.view_grid_item.vo = null;
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
         if(Boolean(this.view_grid_equip.vo) && (this.view_grid_equip.vo as Vo_equip).lv < 21)
         {
            this.showTfAtt();
         }
      }
      
      private function update_tf_cost() : void
      {
         var vo_equip:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         trace(Math.ceil(vo_equip.lv_use / 10));
         var temNum:int = Math.ceil(vo_equip.lv_use / 10);
         var str:String = Data_lib.cast_cost[Math.ceil(vo_equip.lv_use / 10)][Enum_lib_cast_cost.EQUIP_INTENSIFY_0 + vo_equip.lv];
         var arr:Array = str.split("_");
         var color:int = vo_equip.color;
         if(color == 5 || color == 6)
         {
            color = 4;
         }
         this.luckyValue = vo_equip.fail_count;
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
            this.Show_down();
            this.auto_addTool();
         }
         else
         {
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
                  if(vec_Vo_valuable_show_down[this.i].id == 44641)
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
            if(vec_Vo_valuable_show_down[0].id == 44641)
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
         if(isShowQui)
         {
            if(canvas_down_quickMetia.contains(this.quickContainer))
            {
               canvas_down_quickMetia.removeChild(this.quickContainer);
            }
            canvas_down_quickMetia.addChild(this.quickContainer);
            canvas_down_quickMetia.align();
            return;
         }
         isShowQui = true;
         this.i = 0;
         while(this.i < 3)
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
         var v:View_grid_extra = null;
         var vo:Vo_item = null;
         this.empty_vec_View_grid_cast_down();
         var bZero:Boolean = false;
         vec_Vo_valuable_show_down = CommandManager.get_bag_vec(Enum_filter.ID,null,[44641]);
         if(vec_Vo_valuable_show_down.length == 0)
         {
            bZero = true;
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
            vo.id = 44641;
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
            metiaContainer.removeChild(vec_View_grid_extra_down[this.i]);
            vec_View_grid_extra_down[this.i].view_grid.empty();
            pool.push(vec_View_grid_extra_down[this.i]);
            vec_View_grid_extra_down.pop();
            --this.i;
         }
         canvas_down.removeChild(metiaContainer);
      }
      
      private function show_lv_intensify(lv:int) : void
      {
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
         }
         this.CLICK_OK();
      }
      
      private function CLICK_OK(e:MouseEvent = null) : void
      {
         var vec:Vector.<int> = new Vector.<int>();
      }
      
      private function getNewEquipVo() : void
      {
         var _id:int = 0;
         var vecbasic:Vector.<int> = null;
         var vecB:Vector.<int> = null;
         var i:int = 0;
         var _eq:Vo_equip = null;
         var __v:Vo_equip = null;
         var key:int = 0;
         var value1:int = 0;
         var value2:int = 0;
         if(Boolean(this.view_grid_equip) && Boolean(this.view_grid_equip.vo))
         {
            _id = this.view_grid_equip.vo.id;
            vecbasic = (this.view_grid_equip.vo as Vo_equip).vec_basic;
            vecB = new Vector.<int>();
            i = 0;
            while(i < vecbasic.length)
            {
               key = vecbasic[i];
               value1 = vecbasic[i + 1];
               value2 = value1 * 1.5;
               vecB.push(key,value1,value2);
               i += 3;
            }
            _eq = new Vo_equip();
            __v = this.view_grid_equip.vo as Vo_equip;
            _eq.totalData = __v.totalData;
            _eq.Init_sever_bag(_eq.totalData);
            _eq.vec_basic = vecB;
            this.view_grid_equip_new.vo = _eq;
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
         this.view_grid_equip.vo = temp.vo;
         this.getNewEquipVo();
         this.view_grid_equip.index = temp.index;
         if(Boolean(this.view_grid_item.vo))
         {
            this.view_grid_item.vo = null;
         }
         this.view_grid_equip_now = temp;
         this.view_grid_equip_now.bSelect = true;
         this.gridId_equip = this.view_grid_equip.vo.gridId;
         this.Show_down();
         this.auto_addTool();
         this.update_tf_cost();
         this.disP();
         this.rePos();
      }
      
      private function resetH() : void
      {
         var tf1:MyTextField = null;
         var tf2:MyTextField = null;
         var b:Bitmap = null;
         for each(tf1 in this.tfAddVec1)
         {
            tf1.visible = false;
         }
         for each(tf2 in this.tfAddVec2)
         {
            tf2.visible = false;
         }
         for each(b in this.lvUpBmVec)
         {
            b.visible = false;
         }
      }
      
      private function showTfAtt() : void
      {
         var _voEN:Vo_equip = null;
         var _voE:Vo_equip = null;
         var i:int = 0;
         var str1:String = null;
         var str2:String = null;
         var id_att:int = 0;
         var addAtt:int = 0;
         var extralAtt:int = 0;
         var tf1:MyTextField = null;
         var id_attn:int = 0;
         var addAttn:int = 0;
         var extralAttn:int = 0;
         var tf2:MyTextField = null;
         var b:Bitmap = null;
         this.resetH();
         if(Boolean(this.view_grid_equip_new.vo))
         {
            _voEN = this.view_grid_equip_new.vo as Vo_equip;
            _voEN.lv = 11;
            _voE = this.view_grid_equip.vo as Vo_equip;
            if(Boolean(_voE.vec_basic.length))
            {
               i = 0;
               while(i < _voE.vec_basic.length)
               {
                  str1 = "";
                  str2 = "";
                  id_att = _voE.vec_basic[i];
                  addAtt = _voE.vec_basic[i + 1];
                  extralAtt = _voE.vec_basic[i + 2];
                  tf1 = this.tfAddVec1[i / 3];
                  id_attn = _voEN.vec_basic[i];
                  addAttn = _voEN.vec_basic[i + 1];
                  extralAttn = _voEN.vec_basic[i + 2];
                  tf2 = this.tfAddVec2[i / 3];
                  tf1.visible = true;
                  tf2.visible = true;
                  b = this.lvUpBmVec[i / 3];
                  b.visible = true;
                  str1 = this.getAttribute1(id_att,addAtt,_voE,extralAtt);
                  str2 = this.getAttribute1(id_attn,addAttn,_voEN,extralAttn);
                  tf1.htmlText = str1;
                  tf2.htmlText = str2;
                  i += 3;
               }
            }
         }
         var vo_equip:Vo_equip = this.view_grid_equip.vo as Vo_equip;
         var num:int = Math.ceil(vo_equip.lv_use / 10);
         var arr:Array = Data_lib.cast_cost[num];
         var str:String = Data_lib.cast_cost[num][17];
         this.tfCost.htmlText = "500000";
      }
      
      private function CLICK_UP(e:MouseEvent) : void
      {
         var temp:View_Grid = e.target as View_Grid;
         this.getClickGrid(temp);
      }
      
      private function getEmptyGrid() : int
      {
         return -1;
      }
      
      private function CLICK_DOWN(e:MouseEvent) : void
      {
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
         }
         if(temp.vo.id != 44643)
         {
            if(temp.vo.id == Const_id.INTENSIFY_LUCKY1 || temp.vo.id == Const_id.INTENSIFY_LUCKY1 + 1 || temp.vo.id == Const_id.INTENSIFY_LUCKY1 + 2)
            {
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
               ++vec_View_grid_extra_down[i].view_grid.count;
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
            this.rePos();
         }
      }
      
      private function return_data() : void
      {
         if(Boolean(this.now_down_select_grid))
         {
            this.now_down_select_grid.bSelect = false;
         }
         this.now_down_select_grid = null;
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

