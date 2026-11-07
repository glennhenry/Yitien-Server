package com.yiTian.view.modules.newRolePan
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_equip_type;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_role;
   import com.yiTian.data.model.Model_shuXingDan;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_shuXingDan;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.net.message.cg.TianMingCGMessage;
   import com.yiTian.net.message.cg.WuxingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.cast.baishiZengyi.TipMan;
   import com.yiTian.view.modules.cast.baishiZengyi.View_baoshiZY;
   import com.yiTian.view.modules.cast.baishiZengyi.Vo_baoshiZY;
   import com.yiTian.view.modules.chat.EffecObj;
   import com.yiTian.view.modules.chat.View_ChatPanel;
   import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
   import com.yiTian.view.modules.panel.Enum_panel_role;
   import com.yiTian.view.modules.role.Enum_role_equip;
   import com.yiTian.view.modules.role.View_role_fashionShow;
   import com.yiTian.view.modules.role.View_role_meridian;
   import com.yiTian.view.modules.shenBing.Model_ShenBing;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingAtb;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import com.yiTian.view.modules.tianMing.View_TianMing;
   import com.yiTian.view.modules.wuXing.Vo_wuXing;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import com.yiTian.view.modules.wuXing.WuxingIconTip;
   import com.yiTian.view.modules.xunZhang.XunZhang;
   import com.yiTian.view.modules.zhuanZhi.View_ZhuanZhiAtbSp;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_rolePan extends Panel123
   {
      
      public static var xunZhangGrid:View_Grid;
      
      private static var _stxY:int;
      
      private static var _stxYC:int;
      
      public static var _rightX:int = 360;
      
      private static var laKuan:int = 107;
      
      public static const vecColor:Vector.<int> = new <int>[1,5,7,8,3];
      
      public static const TITLE:int = 0;
      
      public static const COLOR:int = 1;
      
      public static const YELI:int = 2;
      
      public static const DATA:int = 3;
      
      public static var arrNextCH:Array = [];
      
      private static var proArr:Array = [{
         "x":288,
         "y":138
      },{
         "x":35,
         "y":138
      },{
         "x":35,
         "y":238
      },{
         "x":35,
         "y":288
      },{
         "x":35,
         "y":88
      },{
         "x":35,
         "y":188
      },{
         "x":288,
         "y":188
      },{
         "x":288,
         "y":88
      },{
         "x":288,
         "y":238
      },{
         "x":288,
         "y":288
      },{
         "x":35,
         "y":338
      },{
         "x":288,
         "y":338
      }];
      
      private var properTyArr:Array = [{
         "x":54,
         "y":400
      },{
         "x":126,
         "y":404
      },{
         "x":193,
         "y":405
      },{
         "x":259,
         "y":409
      }];
      
      private var urlArr:Array = ["BT_TianMing_up","BT_TaoZhuang_up","BT_WuXing_up","BT_BSZengYyi_up"];
      
      private var rItem:RightItem;
      
      private var tabVec:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var i:int;
      
      private var tabStrArr:Array = ["人物","经脉","时装秀"];
      
      private var totalSpri:Sprite;
      
      private var scaleB1:ScaleBitmap;
      
      private var scaleB2:ScaleBitmap;
      
      private var scaleBmp:ScaleBitmap;
      
      private var zhengXieCon:Sprite;
      
      private var zhengXieBm:Bitmap;
      
      private var QMDCon:Sprite;
      
      private var QMDBm:Bitmap;
      
      private var tfName:MyTextField;
      
      private var extralSpVec:Vector.<Sprite> = new Vector.<Sprite>();
      
      private var titleBm:Bitmap;
      
      private var upBmVec:Vector.<Button> = new Vector.<Button>();
      
      private var stoneLvl:int;
      
      private var hlSP:ringSP;
      
      private var jobExtraAtbSp:View_ZhuanZhiAtbSp;
      
      private var shenBingSp:ShenBingAtbIconSp;
      
      private var shuXingDanSp:ShuXingDanIcon;
      
      private var isOnTaoZhuangMove:Boolean = false;
      
      private var playUn:PlayUnit;
      
      private var now:TabButton;
      
      private var view_role_meridian:View_role_meridian;
      
      private var view_role_fashionShow:View_role_fashionShow;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var spriContainer:Sprite;
      
      private var sJianTou:Sprite;
      
      private var spVec:Vector.<Sprite> = new Vector.<Sprite>();
      
      private var playBody:int;
      
      private var playhorse:int;
      
      private var playWing:int;
      
      private var playWeapon:int;
      
      private var playSex:int;
      
      private var tipShow:TipMan;
      
      private var vec_Vo_equip_cache:Vector.<Vo_equip>;
      
      public function View_rolePan()
      {
         super();
         regResource("lang/ch/XJueSe.swf","XJueSedm");
      }
      
      override protected function initUI2() : void
      {
         var sp:Sprite = null;
         var p:Object = null;
         var url:String = null;
         var ss:String = null;
         var tab:TabButton = null;
         this.totalSpri = new Sprite();
         this.spriContainer = new Sprite();
         this.scaleB1 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":360,
            "height":480
         },Global.Img_Cdm);
         this.scaleB2 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":23,
            "y":41,
            "width":314,
            "height":430
         },Global.Img_Cdm);
         this.scaleBmp = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":26,
            "y":66,
            "width":308,
            "height":402
         },Global.Img_Cdm);
         addChild(this.totalSpri);
         this.totalSpri.addChild(this.spriContainer);
         move = new Rectangle(0,0,357,38);
         this.titleBm = ComponentUtil.getBitmap("Title_Role",this,{
            "x":100,
            "y":5
         },Global.XJueSedm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":323,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         initDynamicView();
         ComponentUtil.getBitmap("BG_XRWu",this.spriContainer,{
            "x":72,
            "y":87
         },Global.XJueSedm);
         ComponentUtil.getScaleBitmap("Back_JSID",[75,3,1,1],this.spriContainer,{
            "x":110,
            "y":94,
            "width":146,
            "height":22
         },Global.XJueSedm);
         this.tfName = ComponentUtil.getTextField("角色名字六个",this.spriContainer,{
            "x":120,
            "y":94,
            "color":15856113,
            "size":14,
            "leading":0,
            "realWidth":121,
            "align":TextAlign.CENTER
         });
         this.jobExtraAtbSp = new View_ZhuanZhiAtbSp();
         ComponentUtil.setPropertie(this.jobExtraAtbSp,{
            "x":96,
            "y":88
         });
         this.spriContainer.addChild(this.jobExtraAtbSp);
         this.shenBingSp = new ShenBingAtbIconSp();
         this.shenBingSp.x = 96;
         this.shenBingSp.y = 120;
         this.shenBingSp.vo = new Vo_ShenBingAtb();
         this.spriContainer.addChild(this.shenBingSp);
         this.shuXingDanSp = new ShuXingDanIcon();
         this.shuXingDanSp.x = 237;
         this.shuXingDanSp.y = 130;
         this.shuXingDanSp.vo = new Vo_shuXingDan();
         this.spriContainer.addChild(this.shuXingDanSp);
         this.hlSP = new ringSP();
         ComponentUtil.setPropertie(this.hlSP,{
            "x":237,
            "y":97
         });
         this.spriContainer.addChild(this.hlSP);
         ComponentUtil.getScaleBitmap("Back_RWGongNeng",[28,19,1,1],this.spriContainer,{
            "x":29,
            "y":385,
            "width":303,
            "height":82
         },Global.XJueSedm);
         ComponentUtil.getScaleBitmap("Back_WenLi",[14,14,1,1],this.spriContainer,{
            "x":361,
            "y":5,
            "width":169,
            "height":475
         },Global.XJueSedm);
         this.i = 0;
         while(this.i < 4)
         {
            sp = new Sprite();
            ComponentUtil.getBitmap("BG_QuanDa",this.spriContainer,{
               "x":53 + this.i * 67,
               "y":401
            },Global.XJueSedm);
            this.spriContainer.addChild(sp);
            p = this.properTyArr[this.i];
            ComponentUtil.setPropertie(sp,p);
            url = this.urlArr[this.i];
            if(this.i != 1)
            {
               sp.buttonMode = true;
               sp.tabIndex = 102 + this.i;
               sp.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
               {
                  e.target.filters = Util.glowFFff00;
               });
               sp.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
               {
                  e.target.filters = [];
               });
               sp.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
               {
                  var pan:View_baoshiZY = null;
                  switch(e.target.tabIndex)
                  {
                     case 102:
                        View_TianMing.instance.visible = true;
                        break;
                     case 104:
                        WuxingIconTip.cliHd();
                        break;
                     case 105:
                        if(GameUnitManager.hero.level < 40)
                        {
                           UIManager.centerBroadcast.addMsg("等级不够");
                           return;
                        }
                        pan = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
                        (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
                        {
                           pan.updata(Vo_baoshiZY.StoneLvl);
                        });
                  }
               });
               if(this.i == 3)
               {
                  sp.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void
                  {
                     var pan:View_baoshiZY = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
                     if(pan.visible)
                     {
                        pan.visible = false;
                     }
                  });
               }
            }
            else
            {
               sp.tabIndex = 101;
               sp.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
               {
                  isOnTaoZhuangMove = true;
                  GameScene.upUILayer.addChild(UIManager.rolePanel.tip);
                  dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
               });
               sp.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
               {
                  isOnTaoZhuangMove = false;
                  GameScene.upUILayer.removeChild(UIManager.rolePanel.tip);
               });
               sp.addEventListener(MouseEvent.MOUSE_MOVE,function(e:MouseEvent):void
               {
                  if(isOnTaoZhuangMove)
                  {
                     RoleMter.onMouseMove(e.target);
                  }
               });
            }
            this.extralSpVec.push(sp);
            ComponentUtil.getBitmap(url,sp,{
               "x":0,
               "y":0
            },Global.XJueSedm);
            ++this.i;
         }
         this.initGrid();
         this.playUn = new PlayUnit(this.spriContainer,191,298,"self");
         this.view_role_meridian = new View_role_meridian();
         this.view_role_fashionShow = new View_role_fashionShow();
         this.view_role_meridian.Init();
         this.view_role_fashionShow.Init();
         this.view_role_meridian.visible = false;
         this.view_role_fashionShow.visible = false;
         this.view_role_meridian.x = -3;
         this.view_role_fashionShow.x = -3;
         this.view_role_meridian.y = -1;
         this.view_role_fashionShow.y = -1;
         addChild(this.view_role_meridian);
         addChild(this.view_role_fashionShow);
         this.i = 0;
         while(this.i < 3)
         {
            ss = this.tabStrArr[this.i];
            tab = ComponentUtil.getTabButton(ss,"TabButton_Four",this,{
               "x":36 + 78 * this.i,
               "y":44,
               "textColor":16772813,
               "chooseColor":16771436
            },Global.Img_Cdm);
            tab.tabIndex = this.i;
            this.tabVec.push(tab);
            tab.addEventListener(MouseEvent.CLICK,this.tabChanged);
            ++this.i;
         }
         this.rItem = new RightItem();
         this.totalSpri.addChild(this.rItem);
         ComponentUtil.setPropertie(this.rItem,{"x":_rightX});
      }
      
      override public function get width() : Number
      {
         return 460;
      }
      
      public function updateFaShionShow(map:Object, atbs:Object) : void
      {
         this.view_role_fashionShow.updateLigth(map);
         this.view_role_fashionShow.updateAtb(atbs);
      }
      
      public function getFaShionLightMap() : Object
      {
         return this.view_role_fashionShow.lightMap;
      }
      
      public function updateLigth(map:Object) : void
      {
         this.view_role_fashionShow.updateLigth(map);
      }
      
      private function doubleClick(e:MouseEvent) : void
      {
         var upGrid:View_Grid = e.target as View_Grid;
         if(Boolean(upGrid.vo))
         {
            if(CommandManager.get_bag_canUse() - CommandManager.get_bag_used() == 0)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10018",1));
               return;
            }
            RoleCGMessage.CG_ROLE_SWAP(RoleCGMessage.ROLE_BAG,upGrid.vo.gridId);
         }
      }
      
      public function get_equips_noFasion() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            if(Boolean(this.gridVec[i].vo) && (this.gridVec[i].vo as Vo_equip).type != Enum_equip_type.FASHION)
            {
               temArr.push(this.gridVec[i]);
            }
            i++;
         }
         return temArr;
      }
      
      public function get_can_dianHuaEquip() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            if(Boolean(this.gridVec[i].vo && (this.gridVec[i].vo as Vo_equip).id_tz != 0 && (this.gridVec[i].vo as Vo_equip).color >= 4) && Boolean((this.gridVec[i].vo as Vo_equip).lv_use >= 50) && ((this.gridVec[i].vo as Vo_equip).id_tz == 4 || (this.gridVec[i].vo as Vo_equip).id_tz == 6 || (this.gridVec[i].vo as Vo_equip).id_tz == 8))
            {
               temArr.push(this.gridVec[i]);
            }
            i++;
         }
         return temArr;
      }
      
      public function getC_data() : Vector.<View_Grid>
      {
         var temVo:Vo_equip = null;
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            temVo = this.gridVec[i].vo as Vo_equip;
            if(temVo)
            {
               if(temVo.color >= 5 && temVo.id != 99509)
               {
                  temArr.push(this.gridVec[i]);
               }
            }
            i++;
         }
         return temArr;
      }
      
      public function getCZ_data() : Vector.<View_Grid>
      {
         var temVo:Vo_equip = null;
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            temVo = this.gridVec[i].vo as Vo_equip;
            if(temVo)
            {
               if(temVo.color >= 4 && temVo.lv_use >= 50 || temVo.color > 4 && temVo.jingLianCount != temVo.maxRefine)
               {
                  temArr.push(this.gridVec[i]);
               }
            }
            i++;
         }
         return temArr;
      }
      
      public function get_item_index(_index:int) : Vo_valuable
      {
         if(!_index)
         {
            return null;
         }
         if(Boolean(this.gridVec[_index - 1].vo))
         {
            return this.gridVec[_index - 1].vo as Vo_valuable;
         }
         return null;
      }
      
      public function get_items_data() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            if(Boolean(this.gridVec[i].vo && (this.gridVec[i].vo as Vo_equip).lv != 10 && (this.gridVec[i].vo as Vo_equip).lv != 21 && (this.gridVec[i].vo as Vo_equip).id != 99121) && Boolean((this.gridVec[i].vo as Vo_equip).id != 99122) && (this.gridVec[i].vo as Vo_equip).lv < 32)
            {
               temArr.push(this.gridVec[i]);
            }
            i++;
         }
         return temArr;
      }
      
      public function get_items_dataC() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            if(Boolean(this.gridVec[i].vo && this.gridVec[i].vo.id != 96679 && this.gridVec[i].vo.id != 96680 && this.gridVec[i].vo.id != 96681 && this.gridVec[i].vo.id != 96682 && this.gridVec[i].vo.id != 96683 && this.gridVec[i].vo.id != 96684) && Boolean(this.gridVec[i].vo.id != 96685) && this.gridVec[i].vo.id != 96686)
            {
               temArr.push(this.gridVec[i]);
            }
            i++;
         }
         return temArr;
      }
      
      public function get_can_jinji_equip() : Vector.<View_Grid>
      {
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            if(Boolean(this.gridVec[i].vo && ((this.gridVec[i].vo as Vo_equip).lv == 10 || (this.gridVec[i].vo as Vo_equip).lv == 21) && (this.gridVec[i].vo as Vo_equip).color >= 4 && (this.gridVec[i].vo as Vo_equip).type != 10) && Boolean((this.gridVec[i].vo as Vo_equip).type != 11) && (this.gridVec[i].vo as Vo_equip).type != 12)
            {
               temArr.push(this.gridVec[i]);
            }
            i++;
         }
         return temArr;
      }
      
      public function getCanJinJiData() : Vector.<View_Grid>
      {
         var _vo:Vo_equip = null;
         var temArr:Vector.<View_Grid> = new Vector.<View_Grid>();
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            _vo = this.gridVec[i].vo as Vo_equip;
            if(Boolean(_vo) && _vo.lv == 10)
            {
               temArr.push(this.gridVec[i]);
            }
            i++;
         }
         return temArr;
      }
      
      public function getZuoQi() : Vector.<Vo_valuable>
      {
         var temVec:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
         if(Boolean(this.gridVec[11].vo))
         {
            if(this.gridVec[11].vo.id != 99054)
            {
               temVec.push(this.gridVec[11].vo as Vo_valuable);
            }
         }
         return temVec;
      }
      
      public function getSmallestGrid() : View_Grid
      {
         var temNum:int = this.getVoIndex();
         if(temNum == 11)
         {
            return null;
         }
         var temMin:int = this.gridVec[temNum].vo.id;
         var temGrid:View_Grid = this.gridVec[this.getVoIndex()];
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            if(Boolean(this.gridVec[i].vo))
            {
               if(this.gridVec[i].vo.id < temMin)
               {
                  temMin = this.gridVec[i].vo.id;
                  temGrid = this.gridVec[i];
               }
            }
            i++;
         }
         return temGrid;
      }
      
      public function get equipV() : Vector.<View_Grid>
      {
         return this.gridVec;
      }
      
      public function getEuqipSingle(enum_pos:int) : Vo_equip
      {
         if(Boolean(this.gridVec[enum_pos].vo))
         {
            return this.gridVec[enum_pos].vo as Vo_equip;
         }
         return null;
      }
      
      public function getVoIndex() : int
      {
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            if(Boolean(this.gridVec[i].vo))
            {
               return i;
            }
            i++;
         }
         return this.gridVec.length - 1;
      }
      
      public function updateWuXingTip(__arr:Array) : void
      {
         var _totalLeiJiWorth:int = 0;
         var _vo:Vo_wuXing = null;
         var _sid:int = 0;
         var _leiJiWorth:int = 0;
         var _addTypeStr:String = null;
         var s:String = null;
         var ss:String = null;
         if(GameUnitManager.hero.level < 50)
         {
            TipManager.bind(this.extralSpVec[2],"50级开启");
            return;
         }
         var singAdd:String = "";
         var i:int = 0;
         while(i < __arr.length)
         {
            _vo = new Vo_wuXing();
            _sid = int(__arr[i][0]);
            _vo.initLib(_sid);
            _leiJiWorth = int(__arr[i][2]);
            _addTypeStr = _vo.addTypeStr;
            _totalLeiJiWorth += _leiJiWorth;
            s = RoleMter.dataStrArr[i];
            ss = HtmlUtil.font(s.replace("{0}",_vo.xiuXingWorthLv).replace("{1}",HtmlUtil.font(_addTypeStr,"#04ff00")) + "\n","#f9ff00");
            singAdd += ss;
            i++;
         }
         var layers:int = WuXingMter.getChongShuWorth(_totalLeiJiWorth);
         var _lv:int = int(Data_lib.Wuxing_s[layers][0]);
         var addS:String = Data_lib.Wuxing_s[layers][2];
         var chongStr:String = "当前五行修炼第" + _lv + "重\n";
         var extralStr:String = HtmlUtil.font("五行全属性额外增加：","#f9ff00") + HtmlUtil.font(addS,"#04ff00");
         TipManager.bind(this.extralSpVec[2],"五行属性：\n" + singAdd + chongStr + extralStr);
      }
      
      public function updateRing(ringID:int, qmd:int, name:String) : void
      {
         this.hlSP.visible = ringID > 0;
         if(ringID <= 0)
         {
            return;
         }
         var vo:VO_MarriageAttribute = new VO_MarriageAttribute();
         vo.ringId = ringID;
         vo.qmd = qmd;
         vo.sex = GameUnitManager.hero.sex;
         vo.coupleName = name;
         this.hlSP.setInfo(vo);
      }
      
      public function updateJobIdx(v:uint) : void
      {
         this.jobExtraAtbSp.setJob(v);
      }
      
      public function updateShenBing(v:Vo_ShenBingAtb) : void
      {
         this.shenBingSp.vo = v;
      }
      
      public function updateShuXingDan(v:Vo_shuXingDan) : void
      {
         this.shuXingDanSp.vo = v;
      }
      
      private function tabChanged(e:MouseEvent) : void
      {
         var tab:TabButton = e.target as TabButton;
         if(this.now == tab)
         {
            return;
         }
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         tab.choose = true;
         this.now = tab;
         this.showView(tab.tabIndex);
      }
      
      public function showView(_index:int) : void
      {
         if(!visible)
         {
            this.visible = true;
         }
         this.totalSpri.visible = false;
         this.view_role_meridian.visible = false;
         this.view_role_fashionShow.visible = false;
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         this.tabVec[_index].choose = true;
         this.now = this.tabVec[_index];
         switch(_index)
         {
            case Enum_panel_role.EQUIP:
               this.totalSpri.visible = true;
               this.scaleB1.width = 360;
               this.scaleB2.width = 314;
               this.scaleBmp.width = 308;
               CloseButton.x = 323;
               this.titleBm.x = 100;
               break;
            case Enum_panel_role.MERIDIAN:
               this.scaleB1.width = 360 + laKuan;
               this.scaleB2.width = 314 + laKuan;
               this.scaleBmp.width = 308 + laKuan;
               CloseButton.x = 323 + laKuan;
               this.view_role_meridian.visible = true;
               this.titleBm.x = 160;
               break;
            case Enum_panel_role.FASHIONSHOW:
               this.scaleB1.width = 360 + laKuan;
               this.scaleB2.width = 314 + laKuan;
               this.scaleBmp.width = 308 + laKuan;
               CloseButton.x = 323 + laKuan;
               this.view_role_fashionShow.visible = true;
               this.titleBm.x = 160;
         }
      }
      
      private function updateChengHaoTip() : void
      {
         var _obj:DisplayObject = null;
         var nextColor:String = null;
         var __obj:DisplayObject = null;
         var arrCurCH:Array = Data_lib.chengHao[GameUnitManager.hero.chengHao];
         var chengHao:int = GameUnitManager.hero.chengHao;
         if(chengHao == 0)
         {
            return;
         }
         var curColor:String = ColorConstant.getColorStr(vecColor[Data_lib.chengHao[GameUnitManager.hero.chengHao][COLOR] - 1]);
         arrNextCH = Data_lib.chengHao[GameUnitManager.hero.chengHao + 1];
         this.rItem.chengHaoHtmlText = LangConfig.getWord("10094",1) + "<font color=\'" + "0x11904647" + "\'>" + arrCurCH[TITLE] + "</font>";
         if(Boolean(arrNextCH))
         {
            this.rItem.ChengHaoEnable = GameUnitManager.hero.yeLi >= arrNextCH[YELI];
            this.rItem.hasEvent(this.rItem.ChengHaoEnable);
            if(this.rItem.ChengHaoEnable)
            {
               _obj = this.rItem.chengHaoBtn;
               this.rItem.chengHaoSp.visible = false;
            }
            else
            {
               this.rItem.chengHaoSp.visible = true;
               _obj = this.rItem.chengHaoSp;
            }
            nextColor = ColorConstant.getColorStr(vecColor[Data_lib.chengHao[GameUnitManager.hero.chengHao + 1][COLOR] - 1]);
            TipManager.bind(_obj,"<font color=\'#ffac00\'>" + LangConfig.getWord("10095",1) + "<font color=\'" + nextColor + "\'>" + arrNextCH[YELI] + LangConfig.getWord("10096",1) + "</font>" + LangConfig.getWord("10097",1) + "<font color=\'" + nextColor + "\'>" + arrNextCH[TITLE] + "</font><br>" + LangConfig.getWord("10098",1) + "<font color=\'" + curColor + "\'>" + LangConfig.getWord("10099",1) + arrCurCH[DATA].split("_")[1] + "</font><br>" + LangConfig.getWord("10100",1) + "<font color=\'" + nextColor + "\'>" + LangConfig.getWord("10099",1) + arrNextCH[DATA].split("_")[1] + "</font><br>" + "<font color=\'#049a47\'>" + LangConfig.getWord("10101",1) + GameUnitManager.hero.yeLi + "</font></font>" + LangConfig.getWord("10655",1));
         }
         else
         {
            if(Boolean(arrNextCH))
            {
               this.rItem.ChengHaoEnable = GameUnitManager.hero.yeLi >= arrNextCH[YELI];
            }
            this.rItem.hasEvent(this.rItem.ChengHaoEnable);
            if(this.rItem.ChengHaoEnable)
            {
               __obj = this.rItem.chengHaoBtn;
               this.rItem.chengHaoSp.visible = false;
            }
            else
            {
               this.rItem.chengHaoSp.visible = true;
               __obj = this.rItem.chengHaoSp;
            }
            TipManager.bind(__obj,"<font color=\'#ffac00\'>" + LangConfig.getWord("10593",1) + "<font color=\'" + curColor + "\'>" + arrCurCH[TITLE] + "</font><br>" + LangConfig.getWord("10098",1) + "<font color=\'" + curColor + "\'>" + LangConfig.getWord("10099",1) + arrCurCH[DATA].split("_")[1] + "</font><br>" + "<font color=\'#049a47\'>" + LangConfig.getWord("10101",1) + GameUnitManager.hero.yeLi + "</font></font>" + LangConfig.getWord("10655",1));
         }
      }
      
      private function mDownHandle(e:MouseEvent) : void
      {
         var temVo:Vo_valuable = e.target.vo as Vo_valuable;
         if(e.ctrlKey)
         {
            View_ChatPanel.show("【" + temVo.str_name + "】",temVo);
            return;
         }
         UIManager.startDrag(e);
      }
      
      public function updateBind() : void
      {
         var _voTM:Vo_TianMing = null;
         var strName:String = null;
         var level:int = 0;
         var typeRl:int = 0;
         var typeLeve:String = null;
         var strAdd:String = null;
         var matchStr:String = null;
         var startStr:String = "天命属性：\n";
         var i:int = 0;
         while(i < RoleMter.tianMingDataVec.length)
         {
            _voTM = RoleMter.tianMingDataVec[i];
            if(_voTM.value != 0)
            {
               strName = _voTM.str_name;
               level = _voTM.level;
               typeRl = _voTM.type_result;
               typeLeve = HtmlUtil.font(strName + "Lv." + level,"#f9ff00");
               strAdd = HtmlUtil.font(" 增加" + Data_lib.attribute[typeRl][0],"#f9ff00") + HtmlUtil.font("+" + _voTM.value,"#04ff00");
               matchStr = typeLeve + strAdd + "\n";
               startStr += matchStr;
            }
            i++;
         }
         if(startStr.length < 8)
         {
            startStr = "天命属性：无\n";
         }
         TipManager.bind(this.extralSpVec[0],startStr);
      }
      
      private function initGrid() : void
      {
         var _proper:Object;
         var bb:Bitmap = null;
         var g:View_Grid = null;
         var proper:Object = null;
         var btn:Button = null;
         this.i = 0;
         while(this.i < 12)
         {
            g = new View_Grid();
            g.set_bmp_bg();
            g.set_bmp_over();
            g.index = this.i + 1;
            g.doubleClickEnabled = true;
            g.set_tf_info(HtmlUtil.font(Enum_role_equip.TXT[this.i],"#d5d57e"));
            g.addEventListener(MouseEvent.MOUSE_UP,this.MOUSE_UP);
            g.addEventListener(MouseEvent.DOUBLE_CLICK,this.DOUBLE_CLICK);
            g.addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
            this.spriContainer.addChild(g);
            if(this.i == 11)
            {
               g.visible = false;
            }
            proper = proArr[this.i];
            btn = ComponentUtil.getButton("","Button_Lvup",this.spriContainer,{
               "x":proper.x + 18,
               "y":proper.y + 18
            },Global.Img_Cdm);
            btn.addEventListener(MouseEvent.CLICK,function():void
            {
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(10);
               }
               else
               {
                  UIManager.castPanel.openView(10);
               }
            });
            this.upBmVec.push(btn);
            btn.visible = false;
            ComponentUtil.setPropertie(g,proper);
            this.gridVec.push(g);
            ++this.i;
         }
         xunZhangGrid = new View_Grid();
         xunZhangGrid.set_bmp_bg();
         xunZhangGrid.set_bmp_over();
         xunZhangGrid.set_tf_info(HtmlUtil.font("勋章","#d5d57e"));
         xunZhangGrid.doubleClickEnabled = true;
         xunZhangGrid.addEventListener(MouseEvent.DOUBLE_CLICK,function():void
         {
            if(Boolean(xunZhangGrid.vo))
            {
               RoleCGMessage.CG_ROLE_SWAP(RoleCGMessage.ROLE_BAG,13);
            }
         });
         addChild(xunZhangGrid);
         this.sJianTou = new Sprite();
         addChild(this.sJianTou);
         this.sJianTou.buttonMode = true;
         _proper = proArr[11];
         ComponentUtil.setPropertie(xunZhangGrid,{
            "x":_proper.x,
            "y":_proper.y
         });
         ComponentUtil.setPropertie(this.sJianTou,{
            "x":xunZhangGrid.x - 4,
            "y":xunZhangGrid.y + 5
         });
         _stxY = this.sJianTou.y;
         bb = ComponentUtil.getBitmap("jianTou_01",this.sJianTou,null,Global.Img_Cdm);
         this.sJianTou.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            bb.bitmapData = ComponentUtil.getBitmapData("jianTou02",Global.Img_Cdm);
            Tween.stop(sJianTou);
         });
         this.sJianTou.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            bb.bitmapData = ComponentUtil.getBitmapData("jianTou_01",Global.Img_Cdm);
            moveHd(3);
         });
         this.sJianTou.addEventListener(MouseEvent.CLICK,function():void
         {
            WuXingMter.getPan(XunZhang,function(pan:XunZhang):void
            {
               pan.visible = true;
            });
         });
         TipManager.bind(this.sJianTou,HtmlUtil.font("勋章进阶和雕刻星石","#f4cd31"));
      }
      
      private function moveHd(_num:int) : void
      {
         var _gap:int = _stxY + _num;
         if(!visible)
         {
            this.sJianTou.y = _stxY;
            return;
         }
         Tween.to(this.sJianTou,500,{"y":[this.sJianTou.y,_gap]},function():void
         {
            moveHd(-_num);
         });
      }
      
      public function updateXunZhang() : void
      {
         if(xunZhangGrid.vo == null)
         {
            this.sJianTou.visible = false;
         }
         else
         {
            this.sJianTou.visible = true;
         }
         xunZhangGrid.vo = Model_role.xunZhangVo as Vo_equip;
      }
      
      private function moveJT(_num:int) : void
      {
         var _gap:int = _stxYC + _num;
         if(!visible)
         {
            this.sJianTou.y = _stxYC;
            return;
         }
         Tween.to(this.sJianTou,500,{"y":[this.sJianTou.y,_gap]},function():void
         {
            moveHd(-_num);
         });
      }
      
      private function MOUSE_UP(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var vo_equip:Vo_equip = null;
         var upGrid:View_Grid = e.target as View_Grid;
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            vo_equip = dragGrid.vo as Vo_equip;
            if(Boolean(vo_equip) && dragGrid.type == Enum_type_grid.BAG)
            {
               if(GameUnitManager.hero.level < vo_equip.lv_use)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("10016",1));
               }
               else if(Enum_job.getBaseJob(GameUnitManager.hero.job) != vo_equip.job && vo_equip.job != Enum_job.ALL)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("10017",1));
               }
               else
               {
                  RoleCGMessage.CG_ROLE_SWAP(RoleCGMessage.BAG_ROLE,dragGrid.vo.gridId,upGrid.index);
               }
            }
         }
      }
      
      private function DOUBLE_CLICK(e:MouseEvent) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         var upGrid:View_Grid = e.target as View_Grid;
         if(Boolean(upGrid.vo))
         {
            if(CommandManager.get_bag_canUse() - CommandManager.get_bag_used() == 0)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10018",1));
               return;
            }
            RoleCGMessage.CG_ROLE_SWAP(RoleCGMessage.ROLE_BAG,upGrid.vo.gridId);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = value;
            this.jobExtraAtbSp.enableLoad();
            this.hlSP.isAutoLoad = true;
            this.shenBingSp.init();
            TianMingCGMessage.CG_OPEN_TIANMING();
            WuxingCGMessage.CG_OPEN_WUXINGPAN();
            this.playBody = GameUnitManager.hero.body;
            this.playhorse = GameUnitManager.hero.horse;
            this.playWing = GameUnitManager.hero.wing;
            this.playWeapon = GameUnitManager.hero.weapon;
            this.playSex = GameUnitManager.hero.sex;
            this.playUn.playImg(this.playhorse,this.playWeapon,this.playSex,this.playBody,GameUnitManager.hero.job,this.playWing);
            this.rolePanUpdate();
            this.bagUd();
            if(GameUnitManager.hero.level < 33)
            {
               this.updateWuXingTip([]);
            }
            this.updateJobIdx(GameUnitManager.hero.job);
            this.updateXunZhang();
            Global.control.registerCallBack(Enum_MsgType.ROLE_PAN_UPDATE,this.rolePanUpdate);
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.bagUd);
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.lvlUp);
            this.moveHd(-3);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.ROLE_PAN_UPDATE,this.rolePanUpdate);
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.bagUd);
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.lvlUp);
            Model_specialD.visFalseComp(this,UIManager.mainMenu.roleBtn,this.hideSuper,1);
         }
      }
      
      private function hideSuper() : void
      {
         super.visible = false;
      }
      
      private function lvlUp() : void
      {
         if(!this.tipShow)
         {
            this.tipShow = new TipMan();
         }
         this.stoneLvl = Vo_baoshiZY.StoneLvl;
         if(GameUnitManager.hero.level < 40)
         {
            this.tipShow.bind(this.extralSpVec[3],"40级开启",false);
         }
         else
         {
            this.tipShow.bind(this.extralSpVec[3],Vo_baoshiZY.StoneLvl,true);
         }
      }
      
      public function updataStoneLvl(stoneLvl:int) : void
      {
         if(!this.tipShow)
         {
            this.tipShow = new TipMan();
         }
         stoneLvl = stoneLvl;
         if(GameUnitManager.hero.level < 40)
         {
            this.tipShow.bind(this.extralSpVec[3],"40级开启",false);
         }
         else
         {
            this.tipShow.bind(this.extralSpVec[3],stoneLvl,true);
         }
      }
      
      private function bagUd() : void
      {
         var n:int = CommandManager.get_bag_count(44477);
         if(n == 0)
         {
            EffecObj.removeEffect(this.extralSpVec[3]);
         }
         else
         {
            EffecObj.getEffec(this.extralSpVec[3]);
         }
         this.view_role_meridian.update_attribute();
      }
      
      private function rolePanUpdate() : void
      {
         this.updateChengHaoTip();
         this.rItem.updateAttribute();
         this.updateJobIdx(GameUnitManager.hero.job);
         this.update_equip();
         this.view_role_fashionShow.updateBody();
         this.updateXunZhang();
         this.updateShenBing(Model_ShenBing.heroShenBingVO);
         this.updateShuXingDan(Model_shuXingDan.heroShuXingDanVo);
         this.playUn.playImg(GameUnitManager.hero.horse,GameUnitManager.hero.weapon,GameUnitManager.hero.sex,GameUnitManager.hero.body,GameUnitManager.hero.job,GameUnitManager.hero.wing);
      }
      
      public function update_equip() : void
      {
         this.tfName.text = Model_heFu.repNameByHero(GameUnitManager.hero.name);
         this.vec_Vo_equip_cache = CommandManager.get_role_vec_equip();
         var i:int = 0;
         while(i < 12)
         {
            this.gridVec[i].vo = this.vec_Vo_equip_cache[i];
            if(GameUnitManager.hero.level >= 50)
            {
               if((Boolean(this.gridVec[i].vo && (this.gridVec[i].vo as Vo_equip).lv == 10 || this.gridVec[i].vo && (this.gridVec[i].vo as Vo_equip).lv == 21)) && Boolean((this.gridVec[i].vo as Vo_equip).color >= 4) && (this.gridVec[i].vo as Vo_equip).type != 11)
               {
                  this.upBmVec[i].visible = true;
               }
               else
               {
                  this.upBmVec[i].visible = false;
               }
            }
            i++;
         }
         xunZhangGrid.vo = Model_role.xunZhangVo;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.data.config.Enum_job;
import com.yiTian.data.config.valuable.Enum_lib_attribute;
import com.yiTian.data.model.Model_bang;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.TipManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.HumanCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.utils.Utils;
import com.yiTian.view.modules.marriage.MarriageGetWord;
import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
import com.yiTian.view.modules.newRolePan.RoleMter;
import com.yiTian.view.modules.newRolePan.View_WYBQ;
import com.yiTian.view.modules.newRolePan.View_rolePan;
import com.yiTian.view.modules.wuXing.WuXingMter;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;

class RightItem extends Sprite
{
   
   private var tfChengHao:MyTextField;
   
   public var chengHaoSp:Sprite;
   
   public var chengHaoBtn:Button;
   
   private var upTfVec:Vector.<MyTextField>;
   
   private var downTfVec:Vector.<MyTextField>;
   
   private var zhanLiTf:MyTextField;
   
   public function RightItem()
   {
      var i:int;
      var tf:MyTextField = null;
      var vecAtt:int = 0;
      var _tf:MyTextField = null;
      var _vecAtt:int = 0;
      this.upTfVec = new Vector.<MyTextField>();
      this.downTfVec = new Vector.<MyTextField>();
      super();
      this.tfChengHao = ComponentUtil.getTextField("江湖称号",this,{
         "x":388 - View_rolePan._rightX,
         "y":43,
         "color":11904647,
         "size":12,
         "leading":0
      });
      this.chengHaoSp = new Sprite();
      this.chengHaoSp.graphics.beginFill(0,0);
      this.chengHaoSp.graphics.drawRect(0,0,19,19);
      this.chengHaoSp.graphics.endFill();
      this.chengHaoSp.mouseEnabled = true;
      ComponentUtil.setPropertie(this.chengHaoSp,{
         "x":486 - View_rolePan._rightX,
         "y":43
      });
      this.chengHaoBtn = ComponentUtil.getButton("","Button_OrangeUp",this,{
         "x":486 - View_rolePan._rightX,
         "y":43,
         "textColor":16771436
      },Global.XJueSedm);
      addChild(this.chengHaoSp);
      i = 0;
      i = 0;
      while(i < 4)
      {
         tf = ComponentUtil.getTextField("",this,{
            "x":388 - View_rolePan._rightX,
            "y":77 + 20 * i,
            "color":11904647,
            "size":12,
            "leading":6
         });
         tf.mouseEnabled = true;
         this.upTfVec.push(tf);
         vecAtt = RoleMter.vec_attribute[i];
         TipManager.bind(tf,Data_lib.attribute[vecAtt][Enum_lib_attribute.STR_DESCRIBE]);
         i++;
      }
      i = 0;
      while(i < 10)
      {
         _tf = ComponentUtil.getTextField("",this,{
            "x":388 - View_rolePan._rightX,
            "y":176 + 20 * i,
            "color":11904647,
            "size":12,
            "leading":6
         });
         _tf.mouseEnabled = true;
         this.downTfVec.push(_tf);
         _vecAtt = RoleMter.vec_attribute[i + 4];
         TipManager.bind(_tf,Data_lib.attribute[_vecAtt][Enum_lib_attribute.STR_DESCRIBE]);
         i++;
      }
      ComponentUtil.getBitmap("Text_ShuXing",this,{
         "x":427 - View_rolePan._rightX,
         "y":15
      },Global.XJueSedm);
      ComponentUtil.getBitmap("Text_ZDLi",this,{
         "x":387 - View_rolePan._rightX,
         "y":406
      },Global.XJueSedm);
      this.zhanLiTf = ComponentUtil.getTextField("98765400",this,{
         "x":449 - View_rolePan._rightX,
         "y":404,
         "color":16776960,
         "size":16,
         "leading":0,
         "bold":true
      });
      ComponentUtil.getButton("我要变强","BT_WYBQ",this,{
         "x":395 - View_rolePan._rightX,
         "y":438,
         "textColor":16771436,
         "callBack":function():void
         {
            WuXingMter.getPan(View_WYBQ,function(pan:View_WYBQ):void
            {
               pan.visible = true;
            });
         }
      },Global.XJueSedm);
      ComponentUtil.getBitmap("BG_Light",this,{
         "x":368 - View_rolePan._rightX,
         "y":69
      },Global.XJueSedm);
      ComponentUtil.getBitmap("BG_Light",this,{
         "x":367 - View_rolePan._rightX,
         "y":166
      },Global.XJueSedm);
      ComponentUtil.getBitmap("BG_Light",this,{
         "x":367 - View_rolePan._rightX,
         "y":391
      },Global.XJueSedm);
   }
   
   public function set chengHaoHtmlText(str:String) : void
   {
      this.tfChengHao.htmlText = str;
   }
   
   public function set ChengHaoEnable(value:Boolean) : void
   {
      this.chengHaoBtn.enabled = value;
   }
   
   public function get ChengHaoEnable() : Boolean
   {
      return this.chengHaoBtn.enabled;
   }
   
   public function hasEvent(value:Boolean) : void
   {
      if(value)
      {
         this.chengHaoBtn.addEventListener(MouseEvent.CLICK,this.chengHaoHandler);
      }
      else
      {
         this.chengHaoBtn.removeEventListener(MouseEvent.CLICK,this.chengHaoHandler);
      }
   }
   
   private function chengHaoHandler(e:MouseEvent) : void
   {
      if(Boolean(View_rolePan.arrNextCH) && Boolean(View_rolePan.arrNextCH.length))
      {
         if(GameUnitManager.hero.yeLi >= View_rolePan.arrNextCH[View_rolePan.YELI])
         {
            HumanCGMessage.CG_CHENGHAO_UPGRADE();
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10102",1));
         }
      }
      else
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("10103",1));
      }
   }
   
   public function updateAttribute() : void
   {
      var i:int = 0;
      var temStr:String = null;
      i = 0;
      while(i < 4)
      {
         if(i == 2)
         {
            temStr = GameUnitManager.hero[RoleMter.vec_str_attribute[i]];
            if(temStr == "")
            {
               temStr = LangConfig.getWord("10015",1);
            }
            this.upTfVec[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(temStr,ColorConstant.ROLE_ATTR_COLOR);
         }
         else if(i == 1)
         {
            this.upTfVec[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(Model_bang.job_arr[Enum_job.getBaseJob(GameUnitManager.hero[RoleMter.vec_str_attribute[i]]) - 1],ColorConstant.ROLE_ATTR_COLOR);
         }
         else
         {
            this.upTfVec[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(GameUnitManager.hero[RoleMter.vec_str_attribute[i]],ColorConstant.ROLE_ATTR_COLOR);
         }
         i++;
      }
      i = 0;
      while(i < 10)
      {
         this.downTfVec[i].htmlText = Data_lib.attribute[RoleMter.vec_attribute[i + 4]][Enum_lib_attribute.STR_NAME] + "：  " + HtmlUtil.font(GameUnitManager.hero[RoleMter.vec_str_attribute[i + 4]],ColorConstant.ROLE_ATTR_COLOR);
         i++;
      }
      this.zhanLiTf.htmlText = GameUnitManager.hero.strength.toString();
   }
}

class ringSP extends Sprite
{
   
   private var bm_icon:Bitmap;
   
   private var qinmiLv:int;
   
   private var _vo:VO_MarriageAttribute;
   
   private var bm_url:String = "";
   
   private var _isAutoLoad:Boolean = false;
   
   public function ringSP()
   {
      super();
      this.bm_icon = new Bitmap();
      addChild(this.bm_icon);
   }
   
   public function setInfo(vo:VO_MarriageAttribute) : void
   {
      var rId:int = vo.ringId;
      var qmd:int = vo.qmd;
      this._vo = vo;
      var lv:int = rId - 46440;
      this.qinmiLv = MarriageGetWord.getQMDIndex(qmd);
      this._vo.qmdLv = this.qinmiLv;
      addEventListener(MouseEvent.ROLL_OVER,this.rollOverHd);
      addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
      var effLv:int = this.qinmiLv / 2;
      var effArr:Array = [16777215,65280,54783,16711935,16744192];
      if(effArr[effLv] > 0)
      {
         filters = [new GlowFilter(effArr[effLv],0.8,25,25,2,1)];
      }
      this.bm_url = "resource/image/ringBM/lv" + lv.toString() + ".png";
      if(this._isAutoLoad)
      {
         Utils.getLoadBitmap(this.bm_url,this.bm_icon);
         this.bm_url = "";
      }
   }
   
   private function rollOverHd(evt:MouseEvent) : void
   {
      TipManager.update(this._vo);
   }
   
   private function rollOutHd(evt:MouseEvent) : void
   {
      TipManager.hide();
   }
   
   public function set isAutoLoad(b:Boolean) : void
   {
      if(!this._isAutoLoad && b && this.bm_url != "")
      {
         Utils.getLoadBitmap(this.bm_url,this.bm_icon);
         this.bm_url = "";
      }
      this._isAutoLoad = b;
   }
}
