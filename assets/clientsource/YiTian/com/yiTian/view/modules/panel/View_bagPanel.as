package com.yiTian.view.modules.panel
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Const_strUI;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_UpdateTime;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_XianGou;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.config.valuable.Enum_item_type;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_TianmingJJ;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.model.Model_mart;
   import com.yiTian.data.model.Model_wing;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.effects.CoolDown;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FruitShopHandler;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.net.message.cg.ChunJieNianGaoCGMessage;
   import com.yiTian.net.message.cg.DepotCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.net.message.cg.TianmingJJCGMessage;
   import com.yiTian.net.message.cg.XianGouCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.ControlPan;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.comp.View_Menu_mini;
   import com.yiTian.view.modules.XianGou.View_XianGou_menu2;
   import com.yiTian.view.modules.activity.kaifuItem.Model_KaiFuGem;
   import com.yiTian.view.modules.bag.View_panel;
   import com.yiTian.view.modules.bianxinggaiming.View_BangHuiGaiMingPanel;
   import com.yiTian.view.modules.cast.baishiZengyi.View_baoshiZY;
   import com.yiTian.view.modules.cast.baishiZengyi.Vo_baoshiZY;
   import com.yiTian.view.modules.chat.View_ChatPanel;
   import com.yiTian.view.modules.guaji.Model_guajiInfo;
   import com.yiTian.view.modules.horse.HorseConfig;
   import com.yiTian.view.modules.horse.HorseUtil;
   import com.yiTian.view.modules.horse.View_horsePanel;
   import com.yiTian.view.modules.huangbang.Model_Huangbang;
   import com.yiTian.view.modules.huangbang.View_HuangbangPanel;
   import com.yiTian.view.modules.newYear.Config_NewYear;
   import com.yiTian.view.modules.newYear.View_nianGaoSMailPnl;
   import com.yiTian.view.modules.shenBing.ShenBingUtil;
   import com.yiTian.view.modules.tianMing.View_BlessingFruit;
   import com.yiTian.view.modules.tianMing.View_TianMing;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class View_bagPanel extends View_panel
   {
      
      private static var MC_FRM_MAX_NUM:int = 25;
      
      private static var NUM_BAG_GRID_ONE_PAGE:int = 30;
      
      private static const Y_TabButton:int = 50;
      
      private static const COUNT_TBTN:int = 5;
      
      private static const COUNT_PAGE:int = 30;
      
      private static const suiyin:int = 46250;
      
      private static const yinding:int = 46251;
      
      private var curCDSp:CoolDown;
      
      public var dataTime:int;
      
      private var closeGridArr:Array = new Array();
      
      public var curGrid:View_Grid;
      
      private var overGrid:View_Grid;
      
      public var curCDGridPage:int;
      
      public var lastGrid:View_Grid;
      
      private var ARR_STR:Array = new Array();
      
      public var page_cur:int;
      
      private var page_max:int;
      
      private var view_menu_mini:View_Menu_mini;
      
      public var vec_View_Grid:Vector.<View_Grid>;
      
      private var filter:int;
      
      private var view_grid_now:View_Grid;
      
      private var dic_mask:Dictionary;
      
      private var vec_Vo_valuable_cache:Vector.<Vo_valuable>;
      
      private var tbtn_now:TabButton;
      
      private var vec_tbtn:Vector.<TabButton>;
      
      private var btn_page_right:Button;
      
      private var btn_page_left:Button;
      
      private var btn_tidy:Button;
      
      private var btn_fix:Button;
      
      private var btn_consignment:Button;
      
      private var btn_vip:Button;
      
      private var bm_wenzi:Bitmap;
      
      private var tf_capacity:MyTextField;
      
      private var tf_page:MyTextField;
      
      private var tf_YB:MyTextField;
      
      private var tf_coupon:MyTextField;
      
      private var tf_silver:MyTextField;
      
      private var band_tf_silver:MyTextField;
      
      private var hiden_btn:HideBtn;
      
      private var btnClose:Button;
      
      private var backGround1:ScaleBitmap;
      
      private var backGround2:ScaleBitmap;
      
      private var popBtnOpen:Button;
      
      private var popBtnClose:Button;
      
      private var titleBitmap:Bitmap;
      
      private var _titleStatus:int;
      
      private var lockBtn:Button;
      
      private var unlockBtn:Button;
      
      private var temLayer:Sprite;
      
      private var isFirstOpen:Boolean = true;
      
      private var tem_vo:Vo_item;
      
      private var id_arr:Array = [46340,46341,46342];
      
      private var _now:int;
      
      private var _last:int;
      
      public function View_bagPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var b1:ScaleBitmap;
         var b2:ScaleBitmap;
         var b3:ScaleBitmap;
         var b4:ScaleBitmap;
         var i:int;
         var j:int;
         var tbtn:TabButton = null;
         var s:Sprite = null;
         this.ARR_STR = [LangConfig.getWord("353",0),LangConfig.getWord("162",0),LangConfig.getWord("181",0),LangConfig.getWord("863",0),LangConfig.getWord("357",0)];
         this.backGround1 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":315,
            "height":433
         },Global.Img_Cdm);
         this.backGround2 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":599,
            "height":433
         },Global.Img_Cdm);
         this.backGround2.visible = false;
         this.popBtnOpen = ComponentUtil.getButton("","Button_ZoonOpen",this,{
            "x":290,
            "y":180,
            "textColor":16184781
         },Global.Img_Cdm);
         this.popBtnOpen.callBack = this.popXianGouMenu;
         this.popBtnOpen.visible = false;
         this.popBtnClose = ComponentUtil.getButton("","Button_ZoonClose",this,{
            "x":290,
            "y":180,
            "textColor":16184781
         },Global.Img_Cdm);
         this.popBtnClose.callBack = this.popXianGouMenu;
         this.popBtnClose.visible = false;
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":27,
            "y":70,
            "width":263,
            "height":310
         },Global.Img_Cdm);
         b1 = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":66,
            "y":325,
            "width":85,
            "height":18
         },Global.Img_Cdm);
         b2 = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":66,
            "y":350,
            "width":85,
            "height":18
         },Global.Img_Cdm);
         b3 = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":195,
            "y":325,
            "width":85,
            "height":18
         },Global.Img_Cdm);
         b4 = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":195,
            "y":350,
            "width":85,
            "height":18
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":235,
            "y":298,
            "width":28,
            "height":18
         },Global.Img_Cdm);
         move = new Rectangle(0,0,300,36);
         this.btnClose = ComponentUtil.getButton("","Button_Close",this,{
            "x":281,
            "y":7,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnClose.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
         addEventListener(MouseEvent.MOUSE_DOWN,this.MOUSE_DOWN);
         this.vec_tbtn = new Vector.<TabButton>(COUNT_TBTN,true);
         i = 0;
         while(i < COUNT_TBTN)
         {
            tbtn = ComponentUtil.getTabButton(this.ARR_STR[i],Const_strUI.TBTN_TWO,this,{
               "x":32 + i * 51,
               "y":Y_TabButton,
               "textColor":12232795,
               "chooseColor":16773818
            },Global.Img_Cdm);
            tbtn.addEventListener(MouseEvent.CLICK,this.CLICK_TBTN);
            tbtn.tabIndex = i;
            this.vec_tbtn[i] = tbtn;
            i++;
         }
         ComponentUtil.getTextField(LangConfig.getWord("60234",6),this,{
            "x":36,
            "y":298,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60235",6),this,{
            "x":36,
            "y":325,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60236",6),this,{
            "x":36,
            "y":350,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60237",6),this,{
            "x":164,
            "y":325,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60238",6),this,{
            "x":164,
            "y":350,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.btn_page_right = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":263,
            "y":297,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_page_left = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":215,
            "y":297,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_tidy = ComponentUtil.getButton(LangConfig.getWord("864",0),"Button_Two64",this,{
            "x":25,
            "y":392,
            "textColor":16773818
         },Global.Img_Cdm);
         this.btn_fix = ComponentUtil.getButton(LangConfig.getWord("865",0),"Button_Two64",this,{
            "x":92,
            "y":392,
            "textColor":16773818
         },Global.Img_Cdm);
         this.btn_vip = ComponentUtil.getButton(LangConfig.getWord("30145",3),"Button_Two64",this,{
            "x":226,
            "y":392,
            "textColor":16773818
         },Global.Img_Cdm);
         this.btn_consignment = ComponentUtil.getButton(LangConfig.getWord("866",0),"Button_Two64",this,{
            "x":159,
            "y":392,
            "textColor":16773818
         },Global.Img_Cdm);
         this.btn_page_left.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_LEFT);
         this.btn_page_right.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_RIGHT);
         this.btn_tidy.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_TIDY);
         this.btn_fix.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_FIX);
         this.btn_consignment.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_CONSIGNMENT);
         this.btn_consignment.addEventListener(MouseEvent.MOUSE_DOWN,this.mHandle);
         this.btn_vip.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_VIP);
         this.btn_vip.addEventListener(MouseEvent.MOUSE_DOWN,this.mHandle);
         this.tf_capacity = ComponentUtil.getTextField("000/00",this,{
            "x":92,
            "y":298,
            "color":12877056,
            "size":12,
            "leading":0
         });
         this.tf_page = ComponentUtil.getTextField("0/0",this,{
            "x":238,
            "y":298,
            "color":12877056,
            "size":12,
            "leading":0
         });
         this.tf_capacity.align = TextFormatAlign.CENTER;
         this.tf_page.align = TextFormatAlign.CENTER;
         this.tf_YB = ComponentUtil.getTextField("000000000",this,{
            "x":73,
            "y":325,
            "color":12877056,
            "size":12,
            "leading":0
         });
         this.tf_coupon = ComponentUtil.getTextField("000000000",this,{
            "x":202,
            "y":325,
            "color":12877056,
            "size":12,
            "leading":0
         });
         this.tf_silver = ComponentUtil.getTextField("000000000",this,{
            "x":73,
            "y":350,
            "color":12877056,
            "size":12,
            "leading":0
         });
         this.band_tf_silver = ComponentUtil.getTextField("000000000",this,{
            "x":202,
            "y":350,
            "color":12877056,
            "size":12,
            "leading":0
         });
         this.tf_capacity.textColor = 14013822;
         this.tf_page.textColor = 14013822;
         this.tf_YB.textColor = 14013822;
         this.tf_coupon.textColor = 14013822;
         this.tf_silver.textColor = 14013822;
         this.band_tf_silver.textColor = 14013822;
         j = 0;
         while(j < 4)
         {
            s = new Sprite();
            s.graphics.beginFill(16711424,0);
            s.graphics.drawRect(36 + int(j % 2) * 128,325 + 25 * int(j / 2),115,18);
            s.graphics.endFill();
            addChild(s);
            TipManager.bind(s,LangConfig.getWord("112" + (j + 2),0));
            j++;
         }
         Global.control.registerCallBack(Enum_XianGou.TURN_ON,this.turnOnXianGou);
         addChild(View_XianGou_menu2.instance);
         View_XianGou_menu2.instance.visible = false;
      }
      
      override protected function initDynamicView() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         this.vec_View_Grid = new Vector.<View_Grid>(COUNT_PAGE,true);
         i = 0;
         while(i < this.vec_View_Grid.length)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.BAG;
            grid.set_bmp_over();
            grid.set_tf_count();
            grid.isAutoLoad = false;
            grid.set_bmp_select();
            grid.set_bmp_mask();
            addChild(grid);
            grid.addEventListener(MouseEvent.MOUSE_UP,this.MOUSE_UP_GRID);
            grid.addEventListener(MouseEvent.DOUBLE_CLICK,this.DOUBLE_CLICK_GRID);
            grid.doubleClickEnabled = true;
            grid.addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
            this.vec_View_Grid[i] = grid;
            this.vec_View_Grid[i].x = 36 + 42 * int(i % 6);
            this.vec_View_Grid[i].y = 80 + 42 * int(i / 6);
            i++;
         }
         this.view_menu_mini = new View_Menu_mini();
         this.view_menu_mini.visible = false;
         this.dic_mask = new Dictionary();
         this.tbtn_now = this.vec_tbtn[0];
         this.tbtn_now.choose = true;
         this.filter = Enum_filter.ALL;
         this.page_cur = 1;
         this.tf_page.text = this.page_cur + "/" + this.page_max;
         this.temLayer = new Sprite();
         addChild(this.temLayer);
      }
      
      private function turnOnXianGou(e:int) : void
      {
         if(!Global.Bag_Imgsdm)
         {
            SingleLoader.add("lang/ch/Bag_Imgs.swf",function(info:Object):void
            {
               Global.Bag_Imgsdm = info.applicationDomain;
               getTitle();
            });
         }
         if(e == 1)
         {
            this.titleStatus = 1;
         }
         else if(e == 0)
         {
            this.titleStatus = 2;
         }
      }
      
      private function popXianGouMenu(e:MouseEvent) : void
      {
         if(e.currentTarget == this.popBtnOpen)
         {
            this.titleStatus = 1;
         }
         else if(e.currentTarget == this.popBtnClose)
         {
            this.titleStatus = 0;
         }
      }
      
      private function set titleStatus(value:int) : void
      {
         this._titleStatus = value;
         if(value == 1)
         {
            this.popBtnOpen.visible = false;
            this.popBtnClose.visible = true;
            this.backGround1.visible = false;
            this.backGround2.visible = true;
            this.btnClose.x = 565;
            if(Boolean(this.titleBitmap))
            {
               this.titleBitmap.x = 219;
            }
            move = new Rectangle(0,0,565,36);
            View_XianGou_menu2.instance.visible = true;
            View_XianGou_menu2.instance.x = 303;
            View_XianGou_menu2.instance.y = 39;
            XianGouCGMessage.CG_OPEN_MENU();
         }
         else if(value == 0)
         {
            this.popBtnOpen.visible = true;
            this.popBtnClose.visible = false;
            this.backGround1.visible = true;
            this.backGround2.visible = false;
            this.btnClose.x = 281;
            if(Boolean(this.titleBitmap))
            {
               this.titleBitmap.x = 82;
            }
            move = new Rectangle(0,0,283,36);
            View_XianGou_menu2.instance.visible = false;
         }
         else if(value == 2)
         {
            this.popBtnOpen.visible = false;
            this.popBtnClose.visible = false;
            this.backGround1.visible = true;
            this.backGround2.visible = false;
            this.btnClose.x = 281;
            if(Boolean(this.titleBitmap))
            {
               this.titleBitmap.x = 82;
            }
            move = new Rectangle(0,0,283,36);
            View_XianGou_menu2.instance.visible = false;
         }
      }
      
      private function mHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function mDownHandle(e:MouseEvent) : void
      {
         var temVo:Vo_valuable = e.target.vo as Vo_valuable;
         if(e.ctrlKey)
         {
            if(temVo.str_name == null)
            {
               return;
            }
            View_ChatPanel.show("【" + temVo.str_name + "】",temVo);
            return;
         }
         UIManager.startDrag(e);
      }
      
      override public function resetPosition() : void
      {
         var xp:Number = NaN;
         var yp:Number = NaN;
         if(UIManager.rolePanel.vsb)
         {
            xp = (Global.stage.stageWidth - (UIManager.rolePanel.width + 10 + this.width)) / 2;
            yp = (Global.stage.stageHeight - UIManager.rolePanel.height) / 2;
            Tween.to(UIManager.rolePanel,100,{
               "x":[UIManager.rolePanel.x,xp],
               "y":[UIManager.rolePanel.y,yp]
            });
            x = xp + UIManager.rolePanel.width + 10;
            y = yp;
         }
         else if(UIManager.trans_send_panel.visible)
         {
            xp = (Global.stage.stageWidth - (UIManager.trans_send_panel.width + 10 + this.width)) / 2;
            yp = (Global.stage.stageHeight - UIManager.trans_send_panel.height) / 2;
            Tween.to(UIManager.trans_send_panel,100,{
               "x":[UIManager.trans_send_panel.x,xp],
               "y":[UIManager.trans_send_panel.y,yp]
            });
            x = xp + UIManager.trans_send_panel.width + 10;
            y = yp;
         }
         else if(UIManager.sold_set.visible)
         {
            xp = (Global.stage.stageWidth - (UIManager.sold_set.width + 10 + this.width)) / 2;
            yp = (Global.stage.stageHeight - UIManager.sold_set.height) / 2;
            Tween.to(UIManager.sold_set,100,{
               "x":[UIManager.sold_set.x,xp],
               "y":[UIManager.sold_set.y,yp]
            });
            x = xp + UIManager.sold_set.width + 10;
            y = yp;
         }
         else if(UIManager.depotPanel.visible)
         {
            xp = (Global.stage.stageWidth - (UIManager.depotPanel.width + 10 + this.width)) / 2;
            yp = (Global.stage.stageHeight - UIManager.depotPanel.height) / 2;
            Tween.to(UIManager.depotPanel,100,{
               "x":[UIManager.depotPanel.x,xp],
               "y":[UIManager.depotPanel.y,yp]
            });
            x = xp + UIManager.depotPanel.width + 10;
            y = yp;
         }
         else if(UIManager.selectNum.visible)
         {
            x = (Global.stage.stageWidth - this.width) / 2 + 150;
            y = (Global.stage.stageHeight - this.height) / 2;
         }
         else if(UIManager.long_way_shop.visible)
         {
            xp = (Global.stage.stageWidth - (UIManager.long_way_shop.width + 10 + this.width)) / 2;
            yp = (Global.stage.stageHeight - UIManager.long_way_shop.height) / 2;
            Tween.to(UIManager.long_way_shop,100,{
               "x":[UIManager.long_way_shop.x,xp],
               "y":[UIManager.long_way_shop.y,yp]
            });
            x = xp + UIManager.long_way_shop.width + 10;
            y = yp;
         }
         else if(UIManager.zaHuoDian.visible)
         {
            xp = (Global.stage.stageWidth - (UIManager.zaHuoDian.width + 10 + this.width)) / 2;
            yp = (Global.stage.stageHeight - UIManager.zaHuoDian.height) / 2;
            Tween.to(UIManager.zaHuoDian,100,{
               "x":[UIManager.zaHuoDian.x,xp],
               "y":[UIManager.zaHuoDian.y,yp]
            });
            x = xp + UIManager.zaHuoDian.width + 10;
            y = yp;
         }
         else if(UIManager.letterEditViewPanel.visible)
         {
            xp = (Global.stage.stageWidth - (UIManager.letterEditViewPanel.width + 10 + this.width)) / 2;
            yp = (Global.stage.stageHeight - UIManager.letterEditViewPanel.height) / 2;
            Tween.to(UIManager.letterEditViewPanel,100,{
               "x":[UIManager.letterEditViewPanel.x,xp],
               "y":[UIManager.letterEditViewPanel.y,yp]
            });
            x = xp + UIManager.letterEditViewPanel.width + 10;
            y = yp - 50;
         }
         else
         {
            x = (Global.stage.stageWidth - this.width) / 2;
            y = (Global.stage.stageHeight - this.height) / 2;
         }
      }
      
      override public function get width() : Number
      {
         return 315;
      }
      
      override public function get height() : Number
      {
         return 431;
      }
      
      private function getTitle() : void
      {
         if(!this.titleBitmap)
         {
            if(this._titleStatus == 1)
            {
               this.titleBitmap = ComponentUtil.getBitmap("Title_Bag",this,{
                  "x":219,
                  "y":4
               },Global.Bag_Imgsdm);
            }
            else
            {
               this.titleBitmap = ComponentUtil.getBitmap("Title_Bag",this,{
                  "x":82,
                  "y":4
               },Global.Bag_Imgsdm);
            }
         }
         SingleLoader.add(Model_bag.EJiMiMaSOURCE_URL,function(info:Object):void
         {
            if(Boolean(lockBtn))
            {
               return;
            }
            Global.EJiMiMa_Imgsdm = info.applicationDomain;
            unlockBtn = ComponentUtil.getButton("","Button_UnLock",temLayer,{
               "x":165,
               "y":292,
               "callBack":onDePwdHandler
            },Global.EJiMiMa_Imgsdm);
            lockBtn = ComponentUtil.getButton("","Button_Lock",temLayer,{
               "x":165,
               "y":292,
               "callBack":onDePwdHandler
            },Global.EJiMiMa_Imgsdm);
            TipManager.bind(unlockBtn,LangConfig.getWord("20041",11));
            TipManager.bind(lockBtn,LangConfig.getWord("20042",11));
            updateLockState();
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,updateLockState);
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value == false)
         {
            this.reset_menu_mini();
            this.page_cur = 1;
            CommandManager.inform_bagVisible(false);
            ControlPan.dic_panel[ControlPan.BAG] = null;
            if(GameScene.instance.hasFrameCallBack(this.onCDHandler))
            {
               GameScene.instance.removeFrameCallBack(this.onCDHandler);
            }
         }
         else
         {
            ControlPan.dic_panel[ControlPan.BAG] = this;
            CommandManager.inform_bagVisible(true);
            this.Show();
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               SingleLoader.add("lang/ch/Bag_Imgs.swf",function(info:Object):void
               {
                  Global.Bag_Imgsdm = info.applicationDomain;
                  getTitle();
               });
               bind_target = Enum_explor.bind(Enum_explor.BTN_BAG);
               this.setGridLoad();
            }
            else
            {
               this.updateLockState();
            }
         }
         ControlPan.panelControl(this);
      }
      
      public function setGridLoad() : void
      {
         var i:int = 0;
         while(i < this.vec_View_Grid.length)
         {
            this.vec_View_Grid[i].isAutoLoad = true;
            this.vec_View_Grid[i].beginLoad();
            i++;
         }
      }
      
      public function update() : void
      {
         this.vec_Vo_valuable_cache = CommandManager.get_bag_vec(this.filter);
         this.Show();
      }
      
      public function set_mask(gridId:int, bMask:Boolean) : void
      {
         var i:int = 0;
         if(bMask)
         {
            this.dic_mask[gridId] = 1;
            i = 0;
            while(i < this.vec_View_Grid.length)
            {
               if(this.vec_View_Grid[i].vo.gridId == gridId && this.vec_View_Grid[i].vo.id != 0)
               {
                  this.vec_View_Grid[i].bMask = true;
               }
               i++;
            }
            this.btn_tidy.enabled = false;
         }
         else
         {
            this.dic_mask[gridId] = null;
            i = 0;
            while(i < this.vec_View_Grid.length)
            {
               if(this.vec_View_Grid[i].vo.gridId == gridId && this.vec_View_Grid[i].vo.id != 0)
               {
                  this.vec_View_Grid[i].bMask = false;
               }
               i++;
            }
            if(this.bCanTidy())
            {
               this.btn_tidy.enabled = true;
            }
         }
      }
      
      public function bCanTidy() : Boolean
      {
         var gridId:String = null;
         for(gridId in this.dic_mask)
         {
            if(this.dic_mask[gridId] == 1)
            {
               return false;
            }
         }
         return true;
      }
      
      public function update_attribute(bingSilver:int, YB:int, coupon:int, silver:int) : void
      {
         this.band_tf_silver.text = Utils.getGapNum(bingSilver.toString());
         this.tf_YB.text = Utils.getGapNum(YB.toString());
         this.tf_coupon.text = Utils.getGapNum(coupon.toString());
         this.tf_silver.text = Utils.getGapNum(silver.toString());
      }
      
      private function Show() : void
      {
         var temp:int = 0;
         var vo:Vo_valuable = null;
         this.onHideOpenGridCD();
         var i:int = 0;
         while(i < this.vec_View_Grid.length)
         {
            temp = i + (this.page_cur - 1) * COUNT_PAGE;
            if(!this.vec_Vo_valuable_cache)
            {
               this.vec_Vo_valuable_cache = CommandManager.get_bag_vec(this.filter);
            }
            if(temp < this.vec_Vo_valuable_cache.length && Boolean(this.vec_Vo_valuable_cache[temp]))
            {
               this.vec_View_Grid[i].vo = this.vec_Vo_valuable_cache[temp];
               this.vec_View_Grid[i].set_bmp_bg();
               this.setMouseEvent(this.vec_View_Grid[i],false);
            }
            else
            {
               vo = new Vo_valuable();
               vo.gridId = temp + 1;
               this.vec_View_Grid[i].vo = vo;
               if(temp + 1 > CommandManager.get_bag_canUse())
               {
                  this.vec_View_Grid[i].set_bmp_bg(View_Grid.GRID_BAG_LOCK);
                  this.setMouseEvent(this.vec_View_Grid[i],true);
               }
               else
               {
                  this.vec_View_Grid[i].set_bmp_bg();
                  this.setMouseEvent(this.vec_View_Grid[i],false);
               }
            }
            if(this.vec_View_Grid[i].vo.str_name == null || this.dic_mask[this.vec_View_Grid[i].vo.gridId] == null)
            {
               this.vec_View_Grid[i].bMask = false;
            }
            else
            {
               this.vec_View_Grid[i].bMask = true;
            }
            i++;
         }
         this.tf_capacity.text = CommandManager.get_bag_used() + "/" + CommandManager.get_bag_canUse();
         this.page_max = this.vec_Vo_valuable_cache.length / COUNT_PAGE + 1;
         if(this.page_max > 6)
         {
            this.page_max = 6;
         }
         this.tf_page.text = this.page_cur + "/" + this.page_max;
         this._wenzi();
         addChild(this.view_menu_mini);
      }
      
      public function setMouseEvent(_view_grid:View_Grid, value:Boolean) : void
      {
         _view_grid.useHandCursor = value;
         _view_grid.buttonMode = value;
         if(value)
         {
            TipManager.bind(_view_grid,LangConfig.getWord("60239",6));
         }
         else
         {
            TipManager.unBind(_view_grid);
         }
         if(value)
         {
            this.setGridState(_view_grid);
            _view_grid.addEventListener(MouseEvent.CLICK,this.onOpenGridHandle);
         }
         else if(_view_grid.hasEventListener(MouseEvent.CLICK))
         {
            _view_grid.removeEventListener(MouseEvent.CLICK,this.onOpenGridHandle);
         }
         if(Boolean(this.curCDSp))
         {
            this.curCDSp.visible = this.page_cur == this.curCDGridPage;
         }
      }
      
      private function onOpenGridHandle(e:MouseEvent) : void
      {
         var target:View_Grid = e.currentTarget as View_Grid;
         var canUseIdx:int = CommandManager.get_bag_canUse();
         if(target.vo.gridId == canUseIdx + 1)
         {
            BagCGMessage.CG_BAG_OPEN_GRID_ON_CD(target.vo.gridId);
            Model_bag.openType = 1;
         }
         else
         {
            BagCGMessage.CG_BAG_OPEN_GRID_NOT_ON_TIME(target.vo.gridId);
            Model_bag.openType = 2;
         }
      }
      
      public function autoUseSilver() : void
      {
         var vo:Vo_valuable = null;
         var silver_bag_data:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
         silver_bag_data = CommandManager.get_bag_vec(Enum_filter.ID,null,[suiyin,yinding]);
         Utils.print("背包里面的碎银 和 银锭 " + silver_bag_data.length);
         var i:int = 0;
         while(i < silver_bag_data.length)
         {
            vo = silver_bag_data[i];
            BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
            i++;
         }
      }
      
      private function setGridState(grid:View_Grid) : void
      {
         this.closeGridArr[this.closeGridArr.length] = grid;
         grid.addEventListener(MouseEvent.ROLL_OVER,this.onOpenGridShowCD);
         grid.addEventListener(MouseEvent.ROLL_OUT,this.onOpenGridShowCD);
         var index:int = CommandManager.get_bag_canUse();
         if(grid.vo.gridId == index + 1)
         {
            BagCGMessage.CG_BAG_OPEN_GRID_TIPS(grid.vo.gridId);
            if(!this.curCDSp)
            {
               this.curCDSp = new CoolDown(36);
            }
            this.curCDSp.color = 16776960;
            this.curCDSp.x = grid.x - 1;
            this.curCDSp.y = grid.y - 1;
            var _temp_1:* = this.curCDSp;
            this.curCDSp.mouseChildren = false;
            _temp_1.mouseEnabled = false;
            addChild(this.curCDSp);
            this.curCDGridPage = int(grid.vo.gridId / 30) + 1;
            this.curCDGridPage = grid.vo.gridId % 30 == 0 ? int(this.curCDGridPage - 1) : this.curCDGridPage;
         }
      }
      
      public function onCDHandler() : void
      {
         if(!this.curGrid || !this.curGrid.vo || !Data_lib.bagOpenGridCD[this.curGrid.vo.gridId])
         {
            return;
         }
         var totalCDs:int = this.dataTime * 60;
         var passCD:Number = (getTimer() - Model_bag.curTime) / 1000;
         var leftCD:int = Model_bag.curLeftCDs * 0.001 - 1 - passCD;
         var percent:Number = (totalCDs - leftCD) / totalCDs;
         if(percent >= 1 || this.page_cur != this.curCDGridPage)
         {
            GameScene.instance.removeFrameCallBack(this.onCDHandler);
         }
         this.curCDSp.percent = percent >= 1 ? 1 : percent;
      }
      
      public function onOpenGridShowCD(e:MouseEvent) : void
      {
         var target:View_Grid = e.currentTarget as View_Grid;
         if(!this.getCloseGridById(target.vo.gridId))
         {
            return;
         }
         if(e.type == MouseEvent.ROLL_OVER)
         {
            this.overGrid = target;
            GameScene.instance.addFrameCallBack(this.overGridEFHandler);
         }
         else if(e.type == MouseEvent.ROLL_OUT)
         {
            this.overGrid = null;
            GameScene.instance.removeFrameCallBack(this.overGridEFHandler);
         }
      }
      
      public function onHideOpenGridCD() : void
      {
         var grid:View_Grid = null;
         var len:int = int(this.closeGridArr.length);
         var i:int = 0;
         while(i < len)
         {
            grid = this.closeGridArr[i];
            grid.removeEventListener(MouseEvent.ROLL_OVER,this.onOpenGridShowCD);
            grid.removeEventListener(MouseEvent.ROLL_OUT,this.onOpenGridShowCD);
            grid.removeEventListener(MouseEvent.CLICK,this.onOpenGridHandle);
            this.closeGridArr[i] = null;
            i++;
         }
         this.closeGridArr.length = 0;
      }
      
      private function hideCDSp(value:Boolean) : void
      {
         this.curCDSp.visible = value;
      }
      
      public function onOpenGridAlert(gridID:int, money:int, gridNum:int = 0) : void
      {
         var alertStr:String = null;
         if(Model_bag.openType == 1)
         {
            alertStr = LangConfig.getWord("20002",11,money);
         }
         else if(Model_bag.openType == 2)
         {
            alertStr = LangConfig.getWord("20003",11,gridNum,money);
         }
         View_Alert.show(alertStr,View_Alert.OK_CANCAL,function():void
         {
            var lastID:int = gridID;
            lastID = gridID > NUM_BAG_GRID_ONE_PAGE * 6 ? int(NUM_BAG_GRID_ONE_PAGE * 6) : gridID;
            BagCGMessage.CG_BAG_OPEN_GRID_OPEN(lastID,Model_bag.openType);
         });
         if((gridID - 1) % NUM_BAG_GRID_ONE_PAGE == 0 || gridID % NUM_BAG_GRID_ONE_PAGE > 24)
         {
            this.lastGrid = this.getCloseGridById(NUM_BAG_GRID_ONE_PAGE * this.curCDGridPage);
         }
      }
      
      public function getCloseGridById(id:int) : View_Grid
      {
         var grid:View_Grid = null;
         var i:int = 0;
         while(i < this.closeGridArr.length)
         {
            grid = this.closeGridArr[i] as View_Grid;
            if(grid.vo.gridId == id)
            {
               return grid;
            }
            i++;
         }
         return null;
      }
      
      private function overGridEFHandler() : void
      {
         var h:uint = 0;
         var m:uint = 0;
         var s:uint = 0;
         if(!this.overGrid)
         {
            return;
         }
         var canUseIdx:int = CommandManager.get_bag_canUse();
         var leftTime:uint = Model_bag.curLeftCDs / 1000;
         var seconds:uint = (getTimer() - Model_bag.curTime) / 1000;
         if(seconds > leftTime)
         {
            BagCGMessage.CG_BAG_OPEN_GRID_TIPS(this.overGrid.vo.gridId);
            this.overGrid = null;
            GameScene.instance.removeFrameCallBack(this.overGridEFHandler);
            return;
         }
         leftTime -= seconds;
         if(this.overGrid.vo.gridId == canUseIdx + 1)
         {
            h = leftTime / 3600;
            m = leftTime % 3600 / 60;
            s = leftTime % 3600 % 60;
            TipManager.update(LangConfig.getWord("20000",11,h,m,s));
         }
         else
         {
            TipManager.bind(this.overGrid,LangConfig.getWord("20001",11));
         }
      }
      
      public function lastGridHandler() : void
      {
         this.hideCDSp(false);
         ++this.curCDGridPage;
      }
      
      private function onDePwdHandler(event:MouseEvent) : void
      {
         var type:int = Model_bag.pwdLockState;
         if(type == Model_bag.PWD_STATE_UNLOCK_T)
         {
            this.nullPwdTips();
         }
         else if(type == Model_bag.PWD_STATE_UNLOCK_F)
         {
            this.reLockPwd();
         }
         else if(type == Model_bag.PWD_STATE_LOCK_T)
         {
            this.unlockPwd();
         }
      }
      
      public function nullPwdTips() : void
      {
         View_Alert.show(LangConfig.getWord("20014",11),View_Alert.OK_CANCAL,function():void
         {
            UIManager.bagPwdSetter.visible = true;
         },null,null,null,310,LangConfig.getWord("20017",11),LangConfig.getWord("20018",11));
      }
      
      public function unlockPwd() : void
      {
         UIManager.bagPwdPutIn.visible = true;
      }
      
      public function reLockPwd() : void
      {
         View_Alert.show(LangConfig.getWord("20015",11),View_Alert.OK_CANCAL,function():void
         {
            BagCGMessage.CG_BAG_PWD_LOCK_UP();
         },null,null,null,310,LangConfig.getWord("29034",2),LangConfig.getWord("29035",2));
      }
      
      public function updateLockState() : void
      {
         if(!Global.EJiMiMa_Imgsdm || !this.lockBtn || !this.unlockBtn)
         {
            return;
         }
         if(GameUnitManager.hero.level >= 30)
         {
            if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
            {
               this.lockBtn.visible = true;
               this.unlockBtn.visible = false;
            }
            else
            {
               this.lockBtn.visible = false;
               this.unlockBtn.visible = true;
            }
            return;
         }
         this.unlockBtn.visible = false;
         this.lockBtn.visible = false;
      }
      
      private function _wenzi() : void
      {
      }
      
      private function reset_menu_mini() : void
      {
         this.view_menu_mini.visible = false;
         if(Boolean(this.view_grid_now))
         {
            this.view_grid_now.bSelect = false;
            this.view_grid_now = null;
         }
      }
      
      private function DOUBLE_CLICK_GRID(e:MouseEvent) : void
      {
         var grid:View_Grid = null;
         var vo_equip:Vo_equip = null;
         var vo_item:Vo_item = null;
         var matArr:Array = null;
         var num1:int = 0;
         var num2:int = 0;
         var num3:int = 0;
         var temStrArr:Array = null;
         var temY:int = 0;
         var temM:int = 0;
         var temD:int = 0;
         var temH:int = 0;
         var temMi:int = 0;
         var temS:int = 0;
         var temDate:Date = null;
         var a:uint = 0;
         var dateNum:int = 0;
         var targetPnl:View_nianGaoSMailPnl = null;
         var pan:View_baoshiZY = null;
         var oldItem:Vo_item = null;
         var horsePnl:View_horsePanel = null;
         grid = e.target as View_Grid;
         if(grid.vo.str_name == null)
         {
            return;
         }
         this.reset_menu_mini();
         if(UIManager.zaHuoDian.visible)
         {
            UIManager.zaHuoDian.add_goods_to_shop(grid);
         }
         else if(UIManager.sold_set.visible)
         {
            UIManager.sold_set.add_mart_goods(grid);
         }
         else if(UIManager.long_way_shop.visible)
         {
            UIManager.long_way_shop.add_goods_to_shop(grid);
         }
         else if(UIManager.trans_send_panel.visible)
         {
            UIManager.trans_send_panel.add_JY_goods(grid);
         }
         else if(UIManager.trans_chck.visible)
         {
            UIManager.trans_chck.operation(grid);
         }
         else if(UIManager.depotPanel.visible)
         {
            UIManager.depotPanel.updata_from_bag(grid.vo as Vo_valuable);
         }
         else if(UIManager.selectNum.visible)
         {
            UIManager.selectNum.add_mart_goods(grid);
         }
         else if(UIManager.letterEditViewPanel.visible)
         {
            UIManager.letterEditViewPanel.getGridItem(grid);
         }
         else if(grid.vo is Vo_equip)
         {
            vo_equip = grid.vo as Vo_equip;
            if(GameUnitManager.hero.level < vo_equip.lv_use)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("870",0));
            }
            else if(Enum_job.getBaseJob(GameUnitManager.hero.job) != vo_equip.job && vo_equip.job != Enum_job.ALL)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("871",0));
            }
            else
            {
               if((grid.vo as Vo_equip).type == 11)
               {
                  if(GameUnitManager.hero.sex != (grid.vo as Vo_equip).sex)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("984",0));
                  }
               }
               RoleCGMessage.CG_ROLE_SWAP(RoleCGMessage.BAG_ROLE,grid.vo.gridId);
            }
         }
         else if(grid.vo is Vo_item)
         {
            vo_item = grid.vo as Vo_item;
            matArr = Data_lib.fruitShop[1][2].split(",");
            num1 = int(matArr[0].split("_")[0]);
            num2 = int(matArr[1].split("_")[0]);
            num3 = int(matArr[2].split("_")[0]);
            if(vo_item.id == num1 || vo_item.id == num2 || vo_item.id == num3)
            {
               temStrArr = Data_lib.item[vo_item.id][Enum_lib_item.USEABLE_DATE].split("_");
               temY = int(temStrArr[0].split("-")[0]);
               temM = int(temStrArr[0].split("-")[1]);
               temD = int(temStrArr[0].split("-")[2]);
               temH = int(temStrArr[1].split(":")[0]);
               temMi = int(temStrArr[1].split(":")[1]);
               temS = int(temStrArr[1].split(":")[2]);
               temDate = new Date(temY,temM - 1,temD,temH,temMi,temS);
               a = FruitShopHandler.dateNum;
               dateNum = uint(temDate.time / 1000) - a;
               if(dateNum <= 0)
               {
                  UIManager.centerBroadcast.addMsg("水果过期了");
                  return;
               }
               UIManager.fruitShop.visible = true;
               return;
            }
            if(Global.pf == "qqgame")
            {
               if(vo_item.id == 46415)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60240",6));
                  return;
               }
            }
            else if(vo_item.id == 46463)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60241",6));
               return;
            }
            if(vo_item.id == Config_NewYear.NIANGAOID)
            {
               targetPnl = Singleton.getInstance(View_nianGaoSMailPnl);
               Global.delegate.dosomething(targetPnl,targetPnl.show);
               return;
            }
            if(vo_item.id == 46574)
            {
               View_TianMing.instance.visible = true;
               return;
            }
            if(vo_item.id >= 46933 && vo_item.id <= 46935)
            {
               View_TianMing.instance.visible = true;
               View_BlessingFruit.instance.visible = true;
               return;
            }
            if(vo_item.id == ShenBingUtil.SHENBING_CHIP_ID || vo_item.id == ShenBingUtil.YUPAI_ID)
            {
               ShenBingUtil.askOpenShenBingPanel();
               return;
            }
            if(vo_item.id == 46587)
            {
               (Singleton.getInstance(View_BangHuiGaiMingPanel) as View_BangHuiGaiMingPanel).show();
               return;
            }
            if(vo_item.id == 44477)
            {
               pan = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
               {
                  pan.updata(Vo_baoshiZY.StoneLvl);
               });
               return;
            }
            if(vo_item.id >= 46615 && vo_item.id <= 46618)
            {
               Model_guajiInfo.getInstance().useGjdItem(vo_item);
               return;
            }
            if(Model_Huangbang.jumpIdArr.indexOf(vo_item.id) != -1)
            {
               if(Model_Huangbang.jumpIdArr.indexOf(vo_item.id) < Model_Huangbang.currentLoop)
               {
                  UIManager.centerBroadcast.addMsg("当前跳跃令不能进行下一圈跳跃");
                  return;
               }
               if(SceneConfig.getSceneType() != SceneConfig.HUANGBANG)
               {
                  UIManager.centerBroadcast.addMsg("只能在皇榜地图使用该道具");
                  return;
               }
               View_HuangbangPanel.instance.jump();
               return;
            }
            if(vo_item.id == 46620 || vo_item.id == 46621 || vo_item.id == 46622 || vo_item.id == 46623 || vo_item.id == 46624 || vo_item.id == 46625 || vo_item.id == 46626 || vo_item.id == 46627)
            {
               if(!UIManager.layInPill)
               {
                  UIManager.layInPill = new View_layIn_pill();
                  UIManager.layInPill.init();
               }
               UIManager.layInPill.visible = true;
               UIManager.layInPill.update(vo_item.id,1,vo_item.str_name,vo_item.color,grid.vo.gridId);
               return;
            }
            if(vo_item.type == 422)
            {
               Model_KaiFuGem.askOpenDiscountView(vo_item.id,vo_item.gridId);
               return;
            }
            if(vo_item.id == 46496)
            {
               UIManager.bianXingGaiMing.bianXingHandler(vo_item);
               return;
            }
            if(vo_item.id == 46495)
            {
               UIManager.bianXingGaiMing.gaiMing(vo_item);
               return;
            }
            if(Data_lib.item[vo_item.id][Enum_lib_item.TYPE] == Enum_item_type.PET_SKILL_BOOK)
            {
               UIManager.petPanel.petSkillBook(vo_item);
               return;
            }
            if(Data_lib.item[vo_item.id][Enum_lib_item.TYPE] == Enum_item_type.FLOWERS)
            {
               UIManager.bestowFlower.isNiName = true;
               UIManager.bestowFlower.show();
               return;
            }
            if(Data_lib.item[vo_item.id][Enum_lib_item.TYPE] == Enum_item_type.PET_CHANGE_CARD)
            {
               UIManager.petPanel.petChangeCard(vo_item);
               return;
            }
            if(Data_lib.item[vo_item.id][Enum_lib_item.TYPE] == Enum_item_type.VIP)
            {
               if(GameUnitManager.hero.vip > 0)
               {
                  this.tem_vo = vo_item;
                  oldItem = this.getOldVip();
                  if(this.id_arr[GameUnitManager.hero.vip - 1] == vo_item.id)
                  {
                     BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo_item.gridId,1);
                  }
                  else
                  {
                     View_Alert.show(LangConfig.getWord("10366",1,this.getColor(this.tem_vo),this.getColor(oldItem)),View_Alert.OK_CANCAL,this.OK_USE);
                  }
               }
               else
               {
                  BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo_item.gridId,1);
               }
               return;
            }
            if(vo_item.id == Model_TianmingJJ.TOOLID)
            {
               TianmingJJCGMessage.CG_TMJJ_OPENWIN();
            }
            if(vo_item.bUseable == 1)
            {
               if(GameUnitManager.hero.level < vo_item.lv_use)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("872",0));
               }
               else if(Enum_job.getBaseJob(GameUnitManager.hero.job) != vo_item.job && vo_item.job != Enum_job.ALL)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("873",0));
               }
               else if(vo_item.id == HorseConfig.FORGESTONE_ID)
               {
                  horsePnl = Singleton.getInstance(View_horsePanel);
                  Global.delegate.dosomething(horsePnl,horsePnl.show);
               }
               else if(vo_item.id == HorseConfig.QIANGHUASTONE_ID)
               {
                  horsePnl = Singleton.getInstance(View_horsePanel);
                  Global.delegate.dosomething(horsePnl,function():void
                  {
                     horsePnl.show(2);
                  });
               }
               else if(Data_lib.item[grid.vo.id][Enum_lib_item.TYPE_RESULT] == Enum_item_type.MERIDIAN_COMPOSE)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(5);
               }
               else if(Data_lib.item[grid.vo.id][Enum_lib_item.TYPE] == Enum_item_type.FISH)
               {
                  if(!GameUnitManager.hero.partyId && Model_bang.partyType == 0)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("750",0));
                  }
                  else
                  {
                     BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo_item.gridId,1);
                  }
               }
               else if(Data_lib.item[grid.vo.id][Enum_lib_item.TYPE] == 385)
               {
                  HorseUtil.showIndex = 0;
                  HorseUtil.clickHd();
               }
               else if(Data_lib.item[grid.vo.id][Enum_lib_item.TYPE] == 386)
               {
                  HorseUtil.showIndex = 2;
                  HorseUtil.clickHd();
               }
               else
               {
                  if((grid.vo as Vo_valuable).type == 200)
                  {
                     UIManager.heroHead.buffItemUse(grid.vo as Vo_item,1);
                     return;
                  }
                  if(grid.vo.id == 45384)
                  {
                     ChunJieNianGaoCGMessage.CG_ChunJieNianGao_EAT(1,grid.vo.gridId);
                     return;
                  }
                  if(Model_wing.HuanHuaDanID > 0 && (grid.vo as Vo_valuable).type == 420 && grid.vo.id != Data_lib.wingChange[Model_wing.HuanHuaDanID][0])
                  {
                     View_Alert.show("你确定要用" + HtmlUtil.font(grid.vo.str_name,ColorConstant.getItemColorStr((grid.vo as Vo_valuable).color)) + "覆盖" + HtmlUtil.font(Data_lib.item[Data_lib.wingChange[Model_wing.HuanHuaDanID][0]][1],ColorConstant.getItemColorStr(Data_lib.item[Data_lib.wingChange[Model_wing.HuanHuaDanID][0]][12])) + "吗？",2,function():void
                     {
                        BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,grid.vo.gridId,1);
                     },null,null,null,340);
                     return;
                  }
                  BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,grid.vo.gridId,1);
               }
            }
            else
            {
               Model_bag.handleOf(vo_item);
            }
         }
      }
      
      private function getOldVip() : Vo_item
      {
         var voI:Vo_item = new Vo_item();
         voI.id = this.id_arr[GameUnitManager.hero.vip - 1];
         voI.Init_lib();
         return voI;
      }
      
      private function getColor(item:Vo_item) : String
      {
         var str:String = item.str_name;
         if(item.lv == 1)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.GREEN));
         }
         else if(item.lv == 2)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.BLUE));
         }
         else if(item.lv == 3)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.PURPLE));
         }
         return str;
      }
      
      private function OK_USE() : void
      {
         BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,this.tem_vo.gridId,1);
         this.tem_vo = null;
      }
      
      private function MOUSE_UP_GRID(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var upGrid:View_Grid = e.target as View_Grid;
         if(this.filter == Enum_filter.ALL)
         {
            if(upGrid.vo.gridId > CommandManager.get_bag_canUse())
            {
               return;
            }
         }
         else if(upGrid.vo.str_name == null)
         {
            return;
         }
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            if(dragGrid.type == Enum_type_grid.BAG)
            {
               if(upGrid != dragGrid)
               {
                  BagCGMessage.CG_BAG_SWAP(dragGrid.vo.gridId,upGrid.vo.gridId);
               }
            }
            else if(dragGrid.type == Enum_type_grid.ROLE_EQUIP)
            {
               RoleCGMessage.CG_ROLE_SWAP(RoleCGMessage.ROLE_BAG,dragGrid.vo.gridId);
            }
            else if(dragGrid.type == Enum_type_grid.DEPOT)
            {
               if(upGrid.vo.str_name == null && dragGrid.vo.count > 1)
               {
                  UIManager.num_valuable.Show(dragGrid.vo as Vo_valuable,View_num_valuable.DEPOT_BAG,upGrid.vo.gridId);
               }
               else
               {
                  DepotCGMessage.CG_DEPOT_SWAP(DepotCGMessage.DEPOT_BAG,dragGrid.vo.gridId,upGrid.vo.gridId,0);
               }
            }
         }
         else
         {
            if(upGrid.vo.str_name == null)
            {
               return;
            }
            if(this.view_grid_now == upGrid)
            {
               return;
            }
            if(Boolean(this.view_grid_now))
            {
               this.view_grid_now.bSelect = false;
            }
            this.view_grid_now = upGrid;
            this.view_grid_now.bSelect = true;
            this.view_menu_mini.show(upGrid.vo as Vo_valuable,upGrid);
            this.view_menu_mini.x = this.view_grid_now.x + Const_png.SIZE_GRID - 10;
            this.view_menu_mini.y = this.view_grid_now.y + Const_png.SIZE_GRID - 10;
            if(e.ctrlKey)
            {
               this.view_menu_mini.visible = false;
            }
            TipManager.hide();
         }
      }
      
      private function MOUSE_DOWN(e:MouseEvent) : void
      {
         if((e.target as Sprite).parent is View_Menu_mini == false)
         {
            this.reset_menu_mini();
         }
         else
         {
            this.view_grid_now.bSelect = false;
         }
      }
      
      private function CLICK_TBTN(e:MouseEvent) : void
      {
         if(this.tbtn_now == e.target)
         {
            return;
         }
         var tbtn:TabButton = e.target as TabButton;
         if(this.tbtn_now != null)
         {
            this.tbtn_now.choose = false;
         }
         tbtn.choose = true;
         this.tbtn_now = tbtn;
         this.page_cur = 1;
         if(tbtn.tabIndex == 0)
         {
            this.filter = Enum_filter.ALL;
         }
         else if(tbtn.tabIndex == 1)
         {
            this.filter = Enum_filter.EQUIP_ALL;
         }
         else if(tbtn.tabIndex == 2)
         {
            this.filter = Enum_filter.ITEM_GEM;
         }
         else if(tbtn.tabIndex == 3)
         {
            this.filter = Enum_filter.ITEM_STUFF;
         }
         else if(tbtn.tabIndex == 4)
         {
            this.filter = Enum_filter.ITEM_ELSE;
         }
         this.update();
      }
      
      private function CLICK_BTN_VIP(e:MouseEvent) : void
      {
         if(Boolean(GameUnitManager.hero.vip))
         {
            UIManager.depotPanel.visible = true;
         }
         else
         {
            View_Alert.show(LangConfig.getWord("30144",3),View_Alert.OK_CANCAL,function():void
            {
               UIManager.vipPanel.visible = true;
            });
         }
      }
      
      private function CLICK_BTN_CONSIGNMENT(e:MouseEvent) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         Model_mart.martSoldHandle(LangConfig.getWord("380",0));
      }
      
      private function CLICK_BTN_FIX(e:MouseEvent) : void
      {
         BagCGMessage.CG_BAG_FIX();
      }
      
      private function CLICK_BTN_TIDY(e:MouseEvent) : void
      {
         if(this.btn_tidy.enabled)
         {
            if(Global.updateTimeManager.bUpdate(Enum_UpdateTime.BAG_TIDY))
            {
               BagCGMessage.CG_BAG_TIDY();
               this._last = getTimer();
               this.set_btn_tidy(false,10);
               this.addCountBack();
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("874",0));
            }
         }
      }
      
      private function addCountBack() : void
      {
         GameScene.instance.addFrameCallBack(this.enabledHanlde);
      }
      
      private function removeCountBack() : void
      {
         GameScene.instance.removeFrameCallBack(this.enabledHanlde);
      }
      
      private function set_btn_tidy(value:Boolean, count:int) : void
      {
         this.btn_tidy.enabled = value;
         this.btn_tidy.useHandCursor = value;
         this.btn_tidy.buttonMode = value;
         if(!value)
         {
            this.btn_tidy.label = "(" + count + ")";
         }
         else
         {
            this.btn_tidy.label = LangConfig.getWord("864",0);
            this.btn_tidy.LabelResize(18,3);
         }
      }
      
      private function enabledHanlde(interenal:int) : void
      {
         this._now = getTimer();
         var temp:int = (this._now - this._last) / 1000;
         if(temp >= 10)
         {
            this.removeCountBack();
            this.set_btn_tidy(true,10 - temp);
         }
         else
         {
            this.set_btn_tidy(false,10 - temp);
         }
      }
      
      private function CLICK_BTN_RIGHT(e:MouseEvent) : void
      {
         if(this.page_cur < this.page_max)
         {
            ++this.page_cur;
            this.Show();
         }
      }
      
      private function CLICK_BTN_LEFT(e:MouseEvent) : void
      {
         if(this.page_cur > 1)
         {
            --this.page_cur;
            this.Show();
         }
      }
      
      public function setIsTween(value:Boolean) : void
      {
         isTween = value;
      }
   }
}

import com.ui.controls.Button;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.VIPCGMessage;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

class HideBtn extends Sprite
{
   
   private var Button_Team:Button;
   
   private var Button_Near:Button;
   
   private var back2:DisplayObject;
   
   public function HideBtn()
   {
      super();
      this.Button_Team = ComponentUtil.getButton(LangConfig.getWord("875",0),"ChannelButtonFour",this,{
         "x":3,
         "y":3
      },ComponentUtil.domain);
      this.Button_Near = ComponentUtil.getButton(LangConfig.getWord("876",0),"ChannelButtonFour",this,{
         "x":3,
         "y":24
      },ComponentUtil.domain);
      this.Button_Team.addEventListener(MouseEvent.CLICK,this.cangkuHandle);
      this.Button_Near.addEventListener(MouseEvent.CLICK,this.shopHandle);
      this.Button_Team.addEventListener(MouseEvent.MOUSE_DOWN,this.mHandle);
      this.Button_Near.addEventListener(MouseEvent.MOUSE_DOWN,this.mHandle);
   }
   
   private function mHandle(e:MouseEvent) : void
   {
      e.stopPropagation();
   }
   
   private function cangkuHandle(e:MouseEvent) : void
   {
      this.visible = false;
      if(GameUnitManager.hero.vip != 0)
      {
         UIManager.depotPanel.visible = !UIManager.depotPanel.visible;
         return;
      }
      VIPCGMessage.CG_GET_VIP_YIQUAN(3);
   }
   
   private function shopHandle(e:MouseEvent) : void
   {
      this.visible = false;
      UIManager.long_way_shop.visible = !UIManager.long_way_shop.visible;
   }
   
   override public function set visible(value:Boolean) : void
   {
      super.visible = value;
      if(value)
      {
         Global.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
      }
      else
      {
         Global.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
      }
   }
   
   private function mDownHandle(e:MouseEvent) : void
   {
      this.visible = false;
   }
}
