package com.yiTian.view.modules.yellowDiamond
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.New_mainBtnContainer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class View_yellowDiamond extends Panel
   {
      
      public static var stx:int;
      
      public static var sty:int;
      
      private static var MAXCOUNT1:int = 8;
      
      private static var MAXCOUNT2:int = 4;
      
      private static var MAXCOUNT3:int = 2;
      
      private static const descripLen:int = 2;
      
      private static const rightsLen:int = 2;
      
      public static var openYellowDiamondUrl:String = "http://pay.qq.com/qzone/index.shtml?aid=game100621282.op";
      
      public static var openHuangZuanUrl:String = "http://pay.qq.com/qqgame/index.shtml?aid=VIP.WEB.YT.YXN&ADTAG=VIP.WEB.YT.YXN";
      
      public static var isFirstOpen:Boolean = true;
      
      private var Button_LQ03:Button;
      
      private var Button_LQ02:Button;
      
      private var Button_LQ01:Button;
      
      private var Button_Open:Button;
      
      private var Button_OpenYear:Button;
      
      private var Prompt_text:MyTextField;
      
      private var Use_Style_text:MyTextField;
      
      private var Inf03_text:MyTextField;
      
      private var Inf02A_text:MyTextField;
      
      private var Inf02B_text:MyTextField;
      
      private var Inf01_text:MyTextField;
      
      private var i:int;
      
      private var vec_arr1:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var vec_arr2:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var vec_arr3:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var vec_arr3a:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var vec_arr4:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var back:DisplayObject;
      
      private var ylAddTf:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var ylDescrip:Array;
      
      private var hzDescrip:Array;
      
      private var HYDescrip:Array;
      
      private var rsDescrip:Array;
      
      private var rsDescrip_hz:Array;
      
      private var rsDescrip_hz3366:Array;
      
      private var rsDescrip_hy:Array;
      
      private var rsTf:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var getBtn:Button;
      
      private var titleBack:DisplayObject;
      
      private var bmPet:Bitmap;
      
      public var qqGiftBtn:MainUIBtn;
      
      public var qqGiftBtn_kh:MainUIBtn;
      
      private var spImg:Sprite;
      
      private var _bmp1:bmpItem;
      
      private var _bmp2:bmpItem;
      
      private var _bmp3:bmpItem;
      
      private var _lvl:int;
      
      private var data_arr:Array = ["2_96508_1_1","2_93513_1_1","1_46255_2_1","1_46201_3_1","1_46242_1_1","1_46245_1_1","1_43001_1_1","1_43011_1_1"];
      
      private var data2_arr:Array = ["1_46253_1_1","1_46061_2_1"];
      
      private var data3_arr:Array = ["1_44618_1_1"];
      
      private var data4_arr:Array = ["1_46253_1_1","1_46221_1_1"];
      
      private var point:Point;
      
      public var isGetObj:Boolean = false;
      
      private var lastTime:int;
      
      private var starX:int = 665;
      
      public var starY:int = 160;
      
      private var ccc:Sprite;
      
      private var imgList:Vector.<BitmapData>;
      
      private var playIndex:int = 0;
      
      private const INTERVALFRAM:int = 5;
      
      private var _info:Object;
      
      private var imgBM:Bitmap;
      
      private var HHBtn:Button;
      
      private var isFinishVis:Boolean = false;
      
      private var yellowDiaLvl:int;
      
      private var isYearCostCanget:int;
      
      private var isDaysGet:int;
      
      private var _yearNewsCanGet:int;
      
      private var _canLvlGrowGoodsGet:int;
      
      private var _isYellowPetCanGet:int;
      
      private var _haohua:int;
      
      private var isGet_4:int;
      
      private var icon:MainUIBtn;
      
      public function View_yellowDiamond()
      {
         super();
      }
      
      private function getStr() : void
      {
         this.ylDescrip = [LangConfig.getWord("60378",6),LangConfig.getWord("60379",6)];
         this.hzDescrip = [LangConfig.getWord("60380",6),LangConfig.getWord("60381",6)];
         this.HYDescrip = [LangConfig.getWord("60382",6),LangConfig.getWord("60383",6)];
         this.rsDescrip = [LangConfig.getWord("60384",6),LangConfig.getWord("60385",6) + "\n" + LangConfig.getWord("60386",6)];
         this.rsDescrip_hz = [LangConfig.getWord("60387",6),LangConfig.getWord("60385",6) + "(大厅用户加成8%)" + "\n" + LangConfig.getWord("60386",6) + "(大厅用户加成3%)"];
         this.rsDescrip_hz3366 = [LangConfig.getWord("60387",6),LangConfig.getWord("60385",6) + "(3366用户加成8%)" + "\n" + LangConfig.getWord("60386",6) + "(3366用户加成3%)"];
         this.rsDescrip_hy = [LangConfig.getWord("60388",6),LangConfig.getWord("60385",6) + "\n" + LangConfig.getWord("60386",6)];
      }
      
      override protected function initStaticView() : void
      {
         var btnStr1:String = null;
         var btnStr2:String = null;
         var i:int = 0;
         var tf:MyTextField = null;
         var qqStrGf:String = null;
         this.getStr();
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":808,
            "height":448
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":760,
            "height":354
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":66,
            "width":470,
            "height":320
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":30,
            "y":67,
            "width":468,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":30,
            "y":165,
            "width":468,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":30,
            "y":263,
            "width":468,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":504,
            "y":65,
            "width":275,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":504,
            "y":277,
            "width":275,
            "height":110
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":505,
            "y":66,
            "width":273,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":505,
            "y":278,
            "width":273,
            "height":20
         },Global.Img_Cdm);
         this.bmPet = new Bitmap();
         addChild(this.bmPet);
         move = new Rectangle(0,0,this.back.width,38);
         stx = (Global.stage.stageWidth - this.back.width) / 2;
         stx = (Global.stage.stageHeight - this.back.height) / 2;
         this.spImg = new Sprite();
         addChild(this.spImg);
         this.spImg.x = 640;
         this.spImg.y = 210;
         this.imgBM = new Bitmap();
         this.spImg.addChild(this.imgBM);
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            if(GameUnitManager.hero.ylDiaLvl > 0)
            {
               btnStr1 = "xuFeiBlueDia";
               btnStr2 = "Button_GHYKT";
            }
            else
            {
               btnStr1 = "openBlueBtn";
               btnStr2 = "Button_GHYKT";
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            if(GameUnitManager.hero.isHuiyuan > 0)
            {
               btnStr1 = "Button_XFHuiYuan";
               btnStr2 = "Button_GHYKTHY";
            }
            else
            {
               btnStr1 = "Button_KTHuiYuan";
               btnStr2 = "Button_GHYKTHY";
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(GameUnitManager.hero.huangZuanLvl > 0)
            {
               btnStr1 = "Button_XFHZ";
            }
            else
            {
               btnStr1 = "Button_KTHZ";
            }
            btnStr2 = "Button_HYKT";
         }
         else
         {
            btnStr1 = "Button_KTHZ";
            btnStr2 = "Button-KTNF";
         }
         this.Button_Open = ComponentUtil.getButton("",btnStr1,this,{
            "x":210,
            "y":400,
            "textColor":16383744
         },ComponentUtil.domain);
         this.Button_OpenYear = ComponentUtil.getButton("",btnStr2,this,{
            "x":410,
            "y":400,
            "textColor":13434624
         },ComponentUtil.domain);
         this.setMouseOverOut(this.Button_Open);
         this.setMouseOverOut(this.Button_OpenYear);
         this.Button_Open.addEventListener(MouseEvent.CLICK,function():void
         {
            if(Global.pf == "qqgame")
            {
               View_hzTribute.sendType = "self";
               YellowDiaManager.buy();
            }
            else if(Global.pf == "qplus")
            {
               View_hzTribute.sendType = "self";
               YellowDiaManager.buy();
            }
            else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
            {
               View_hzTribute.sendType = "self";
               YellowDiaManager.buy();
            }
            else if(Global.pf == Enum_SPStr.QQ3366)
            {
               View_hzTribute.sendType = "self";
               YellowDiaManager.buy();
            }
            else if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
            {
               View_hzTribute.sendType = "self";
               YellowDiaManager.buy();
            }
         });
         this.Button_OpenYear.addEventListener(MouseEvent.CLICK,function():void
         {
            if(Global.pf == "qqgame")
            {
               View_hzTribute.sendType = "send";
               YellowDiaManager.buy();
            }
            else if(Global.pf == "qplus")
            {
               View_hzTribute.sendType = "send";
               YellowDiaManager.buy();
            }
            else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
            {
               View_hzTribute.sendType = "send";
               YellowDiaManager.buy();
            }
            else if(Global.pf == Enum_SPStr.QQ3366)
            {
               View_hzTribute.sendType = "send";
               YellowDiaManager.buy();
            }
            else if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
            {
               View_hzTribute.sendType = "send";
               YellowDiaManager.buy();
            }
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":774,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_LQ03 = ComponentUtil.getButton(LangConfig.getWord("50046",5),"Button_Four",this,{
            "x":415,
            "y":322.5,
            "textColor":13434624,
            "tabIndex":3
         },Global.Img_Cdm);
         this.Button_LQ02 = ComponentUtil.getButton(LangConfig.getWord("50046",5),"Button_Four",this,{
            "x":415,
            "y":218.5,
            "textColor":13434624,
            "tabIndex":2
         },Global.Img_Cdm);
         this.Button_LQ01 = ComponentUtil.getButton(LangConfig.getWord("50046",5),"Button_Four",this,{
            "x":415,
            "y":113.5,
            "textColor":13434624,
            "tabIndex":1
         },Global.Img_Cdm);
         this.Button_LQ01.enabled = this.Button_LQ02.enabled = this.Button_LQ03.enabled = false;
         this.Prompt_text = ComponentUtil.getTextField("",this,{
            "x":147.9,
            "y":45,
            "textColor":11515029,
            "realWidth":425
         });
         this.Use_Style_text = ComponentUtil.getTextField("",this,{
            "x":73.9,
            "y":45,
            "textColor":16771665
         });
         this.Use_Style_text.visible = false;
         this.Inf01_text = ComponentUtil.getTextField(LangConfig.getWord("50052",5),this,{
            "x":37,
            "y":67,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.Inf02A_text = ComponentUtil.getTextField(LangConfig.getWord("50050",5),this,{
            "x":37,
            "y":165,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.Inf03_text = ComponentUtil.getTextField(LangConfig.getWord("50049",5),this,{
            "x":37,
            "y":263,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.Inf02B_text = ComponentUtil.getTextField(LangConfig.getWord("50051",5),this,{
            "x":250,
            "y":165,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.getGrid();
         CloseButton.callBack = this.cloHandle;
         this._bmp1 = new bmpItem();
         this._bmp2 = new bmpItem();
         this._bmp3 = new bmpItem();
         addChild(this._bmp1);
         addChild(this._bmp2);
         addChild(this._bmp3);
         this.Button_LQ01.callBack = this.Button_LQ02.callBack = this.Button_LQ03.callBack = this.getAwardsHandle;
         i = 0;
         while(i < descripLen)
         {
            tf = ComponentUtil.getTextField(this.ylDescrip[i],this,{
               "x":515,
               "y":66 + i * 211,
               "color":16764206,
               "size":12,
               "leading":0
            });
            this.ylAddTf.push(tf);
            i++;
         }
         i = 0;
         while(i < rightsLen)
         {
            tf = ComponentUtil.getTextField(this.rsDescrip[i],this,{
               "x":517,
               "y":92 + i * 213,
               "color":16764206,
               "realWidth":263,
               "wordWrap":true,
               "multiline":true,
               "leading":5
            });
            this.rsTf.push(tf);
            i++;
         }
         if(Global.pf == Enum_SPStr.QQGAME || Enum_SPStr.isUnion(Global.pf) || Global.pf == Enum_SPStr.CHITU || Enum_SPStr.isIwan(Global.pf))
         {
            if(Global.pf == Enum_SPStr.QQGAME)
            {
               qqStrGf = "Icon_DTLB";
            }
            else if(Enum_SPStr.isUnion(Global.pf) || Enum_SPStr.isIwan(Global.pf))
            {
               qqStrGf = "Icon_AWJL";
            }
            else if(Global.pf == Enum_SPStr.CHITU)
            {
               qqStrGf = "Icon_CT";
            }
            this.qqGiftBtn = new MainUIBtn("resource/image/Diamond/" + qqStrGf + ".png");
            this.qqGiftBtn.addEventListener(MouseEvent.CLICK,this.getQQGift);
            this.showQQgift();
         }
         this.qqGiftBtn_kh = new MainUIBtn("resource/image/Diamond/QI_kuangh.png");
         this.qqGiftBtn_kh.addEventListener(MouseEvent.CLICK,this.qqGiftKH);
         this.getBtn = ComponentUtil.getButton(LangConfig.getWord("60389",6),"Button_Orange",this,{
            "x":591.5,
            "y":235
         });
         this.getBtn.enabled = false;
         this.getBtn.callBack = function():void
         {
            PetCGMessage.CG_PET_YELLOWDIAMOND_AWARD();
         };
         Utils.print("Global.tx_action_assitant_HY:",Global.tx_action_assitant_HY,"Global.tx_action_assitant_H:",Global.tx_action_assitant_H,"Global.tx_action_assitant_L:",Global.tx_action_assitant_L,"Global.redDiamond:",Global.redDiamond);
         if(Global.pf != Enum_SPStr.GUANWANG)
         {
            if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE)
            {
               if(Global.tx_action_assitant_H)
               {
                  View_qqHuiyuan.instance.show();
               }
            }
            else if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366)
            {
               if(Global.tx_action_assitant_L)
               {
                  if(Model_txAction.isShowIconCtrHZ)
                  {
                     View_qqHuiyuan.instance.show();
                  }
               }
               if(Global.QQGameZKJ)
               {
                  QQGameZheKouJuanTips.ins.showTip();
               }
            }
         }
      }
      
      public function showQQgift() : void
      {
         if(Global.pf == "union-10042-16" || Global.pf == "union-10042-15")
         {
            return;
         }
         if(New_mainBtnContainer.isUsingNewBtn)
         {
            UIManager.newMainBtnContainer.addBtn(this.qqGiftBtn);
         }
         else
         {
            UIManager.mainUiBtnContainer.addBTN(this.qqGiftBtn);
         }
      }
      
      public function removeQQgift() : void
      {
         if(New_mainBtnContainer.isUsingNewBtn)
         {
            if(Boolean(this.qqGiftBtn))
            {
               UIManager.newMainBtnContainer.removeBtn(this.qqGiftBtn);
            }
         }
         else if(Boolean(this.qqGiftBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.qqGiftBtn);
         }
      }
      
      public function showQQgiftKH() : void
      {
         if(Global.pf != "qqgame")
         {
            return;
         }
         UIManager.mainUiBtnContainer.addBTN(this.qqGiftBtn_kh);
      }
      
      public function removeQQgiftKH() : void
      {
         if(Boolean(this.qqGiftBtn_kh))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.qqGiftBtn_kh);
         }
      }
      
      private function getQQGift(e:MouseEvent) : void
      {
         UIManager.onlineAward.visible = true;
      }
      
      private function qqGiftKH(e:MouseEvent) : void
      {
      }
      
      private function getAwardsHandle(e:MouseEvent) : void
      {
         var _num:int = 0;
         var i:int = 0;
         var grid:View_Grid = null;
         var btn:Button = e.target as Button;
         var num:int = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
         switch(btn.tabIndex)
         {
            case 1:
               if(num < 8)
               {
                  UIManager.centerBroadcast.addMsg("背包格子不够了");
                  return;
               }
               break;
            case 2:
               if(Boolean(this.isDaysGet))
               {
                  if(num < 4)
                  {
                     UIManager.centerBroadcast.addMsg("背包格子不够了");
                     return;
                  }
               }
               if(Boolean(this.isGet_4))
               {
                  if(num < 2)
                  {
                     UIManager.centerBroadcast.addMsg("背包格子不够了");
                     return;
                  }
               }
               break;
            case 3:
               _num = 0;
               i = 0;
               while(i < this.vec_arr4.length)
               {
                  grid = this.vec_arr4[i];
                  if(grid.visible)
                  {
                     _num++;
                  }
                  i++;
               }
               if(num < _num)
               {
                  UIManager.centerBroadcast.addMsg("背包格子不够了");
                  return;
               }
         }
         YelloDiaCGMessage.CG_YELLOWDIAMOND_AWARD(btn.tabIndex);
      }
      
      public function setMouseOverOut(btn:Button) : void
      {
         btn.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
         {
            e.target.filters = Util.glowFFFFFF;
         });
         btn.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
         {
            e.target.filters = [];
         });
      }
      
      private function cloHandle(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function getGrid() : void
      {
         var grid:View_Grid = null;
         this.i = 0;
         while(this.i < MAXCOUNT1)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.SHOP;
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_bmp_select();
            grid.set_tf_count(true,false,false);
            grid.index = this.i;
            grid.x = 45 + this.i * 45;
            grid.y = 105;
            addChild(grid);
            this.vec_arr1.push(grid);
            ++this.i;
         }
         this.i = 0;
         while(this.i < MAXCOUNT2)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.SHOP;
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_bmp_select();
            grid.set_tf_count(true,false,false);
            grid.index = this.i;
            grid.x = 45 + this.i * 45;
            grid.y = 210;
            grid.visible = false;
            addChild(grid);
            this.vec_arr2.push(grid);
            ++this.i;
         }
         this.i = 0;
         while(this.i < MAXCOUNT3)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.SHOP;
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_bmp_select();
            grid.set_tf_count(true,false,false);
            grid.index = this.i;
            grid.x = 255 + this.i * 45;
            grid.y = 210;
            grid.visible = false;
            addChild(grid);
            this.vec_arr3.push(grid);
            ++this.i;
         }
         grid = new View_Grid();
         grid.type = Enum_type_grid.SHOP;
         grid.set_bmp_bg();
         grid.set_bmp_over(true,null);
         grid.set_bmp_select();
         grid.set_tf_count(true,false,false);
         grid.index = this.i;
         grid.x = 285 + this.i * 45;
         grid.y = 210;
         grid.visible = false;
         addChild(grid);
         this.vec_arr3a.push(grid);
         this.i = 0;
         while(this.i < MAXCOUNT1)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.SHOP;
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_bmp_select();
            grid.set_tf_count(true,false,false);
            grid.index = this.i;
            grid.x = 45 + this.i * 45;
            grid.y = 315;
            grid.visible = false;
            addChild(grid);
            this.vec_arr4.push(grid);
            ++this.i;
         }
      }
      
      private function getDiaMond1(_type:int) : void
      {
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            if(GameUnitManager.hero.superLan > 0)
            {
               Utils.getLoadBitmap("resource/image/Diamond/superLan.png",this._bmp1.bmp);
            }
            else
            {
               Utils.getLoadBitmap("resource/image/Diamond/dia_0.png",this._bmp1.bmp);
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            Utils.getLoadBitmap("resource/image/shouchong/HYIcon.png",this._bmp1.bmp);
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            Utils.getLoadBitmap("resource/image/Diamond/Diamond0010.png",this._bmp1.bmp);
         }
         this._bmp1.x = 29 + int(_type < 1) * 262;
         this._bmp1.y = 47;
      }
      
      private function getDiaMond2(type:int, _value:Boolean) : void
      {
         var _lv:int = 0;
         if(type == 0)
         {
            type = 1;
         }
         this._bmp2.bitmapData = null;
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            if(GameUnitManager.hero.superLan > 0)
            {
               _lv = GameUnitManager.hero.superLan;
               Utils.getLoadBitmap("resource/image/Diamond/superLan_" + String(_lv) + ".png",this._bmp2.bmp);
            }
            else
            {
               Utils.getLoadBitmap("resource/image/Diamond/dia_" + String(type) + ".png",this._bmp2.bmp);
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            if(GameUnitManager.hero.isHuiyuan > 0)
            {
               if(GameUnitManager.hero.isHuiyuan != type)
               {
                  type = GameUnitManager.hero.isHuiyuan;
               }
            }
            Utils.getLoadBitmap("resource/image/shouchong/HY0" + String(type) + ".png",this._bmp2.bmp);
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(Boolean(GameUnitManager.hero.isSuperHuang))
            {
               Utils.getLoadBitmap("resource/image/superHuangZuan/qz_vip_icon_fla_l_" + String(type) + ".png",this._bmp2.bmp);
            }
            else
            {
               Utils.getLoadBitmap("resource/image/Diamond/Diamond000" + String(type) + ".png",this._bmp2.bmp);
            }
         }
         this._bmp2.x = this.Inf02A_text.x + this.Inf02A_text.textWidth + 10;
         this._bmp2.y = this.Inf02A_text.y + 2;
      }
      
      private function getDiaMond3(_value:Boolean) : void
      {
         var supYear:int = 0;
         this._bmp3.x = 326;
         this._bmp3.y = 167;
         this._bmp3.bitmapData = null;
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            supYear = GameUnitManager.hero.superLanYear;
            if(Boolean(supYear))
            {
               Utils.getLoadBitmap("resource/image/Diamond/superLanYear_" + supYear.toString() + ".png",this._bmp3.bmp);
               return;
            }
            if(Boolean(GameUnitManager.hero.isYearDia))
            {
               Utils.getLoadBitmap("resource/image/Diamond/year" + GameUnitManager.hero.ylDiaLvl.toString() + ".png",this._bmp3.bmp);
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            if(Boolean(GameUnitManager.hero.isHuiyuanYear))
            {
               Utils.getLoadBitmap("resource/image/shouchong/HY_year0" + GameUnitManager.hero.isHuiyuan.toString() + ".png",this._bmp3.bmp);
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(Boolean(GameUnitManager.hero.isSuperHuang))
            {
               if(Boolean(GameUnitManager.hero.isHuangZuanYear))
               {
                  Utils.getLoadBitmap("resource/image/superHuangZuan/qz_vip_icon_fla_l_year_" + GameUnitManager.hero.huangZuanLvl + ".png",this._bmp3.bmp);
               }
            }
            else if(Boolean(GameUnitManager.hero.isHuangZuanYear))
            {
               Utils.getLoadBitmap("resource/image/Diamond/Diamond0009.png",this._bmp3.bmp);
            }
         }
      }
      
      private function getAward(_type:int, isGetType1:Boolean = true, isGetType2:Boolean = true, isGetType3:Boolean = false, isGetType4:Boolean = false) : void
      {
         this.newsGet(isGetType1);
         this.daysGet(_type,isGetType2);
         this.levelsGet(GameUnitManager.hero.level,isGetType3);
         this.yearsExtralGet(isGetType4);
      }
      
      private function setbtn(_btn:Button, value:int) : void
      {
         if(value < 1)
         {
            _btn.enabled = false;
            _btn.useHandCursor = false;
            if(value == -1)
            {
               _btn.label = LangConfig.getWord("994",0);
            }
            else if(value == 0)
            {
               _btn.label = LangConfig.getWord("29075",2);
            }
         }
         else if(value == 1)
         {
            _btn.enabled = true;
            _btn.useHandCursor = true;
            _btn.label = LangConfig.getWord("50046",5);
         }
      }
      
      private function newsGet(_value:Boolean) : void
      {
         var temArr:Array = null;
         this.i = 0;
         while(this.i < this.data_arr.length)
         {
            temArr = [];
            temArr = this.data_arr[this.i].split("_");
            this.handleArr(this.vec_arr1,this.i,int(temArr[0]),int(temArr[1]),int(temArr[2]),int(temArr[3]),_value);
            ++this.i;
         }
      }
      
      private function handleArr(vecArr:Vector.<View_Grid>, _index:int, _type:int, wpId:int, _count:int, _bBind:int, _value:Boolean) : void
      {
         var temVo:Vo_item = null;
         var temEVo:Vo_equip = null;
         var temGrid:View_Grid = vecArr[_index];
         temGrid.visible = true;
         if(_type == 1)
         {
            temVo = new Vo_item();
            temVo.id = wpId;
            temVo.count = _count;
            temVo.Init_lib();
            temGrid.vo = temVo;
         }
         else
         {
            temEVo = new Vo_equip();
            temEVo.id = wpId;
            temEVo.count = _count;
            temEVo.Init_lib();
            temGrid.vo = temEVo;
         }
      }
      
      public function getObj() : void
      {
         this.point = UIManager.special_btn.getPos(2);
         this.isGetObj = true;
      }
      
      private function comp() : void
      {
         super.visible = false;
         this.isFinishVis = false;
         EffectManager.addEffect("35062",this,500,stx + this.back.width / 2,sty + this.back.height / 2);
      }
      
      private function onComplete(info:Object) : void
      {
         var c:Class = null;
         var d:BitmapData = null;
         this._info = info;
         this._info = info;
         this._info.content.init();
         this.imgList = new Vector.<BitmapData>(this.INTERVALFRAM * this._info.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         while(i < this.INTERVALFRAM * this._info.content.actionFrame)
         {
            if(i % this.INTERVALFRAM == 0)
            {
               c = info.applicationDomain.getDefinition("_" + (3 * this._info.content.actionFrame + j++)) as Class;
               d = new c();
               this.imgList[i] = d;
            }
            i++;
         }
         GameScene.instance.addFrameCallBack(this.play);
         this.lastTime = getTimer();
         this.playCCC();
      }
      
      private function _onComp() : void
      {
         var str:String = null;
         if(!this._info)
         {
            if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366)
            {
               str = "20907";
            }
            else if(Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
            {
               str = "20908";
            }
            else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
            {
               str = "20906";
            }
            MassLoader.add("modelRes/role/body/run/" + str + ".swf",this.onComplete,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
         }
         else
         {
            GameScene.instance.addFrameCallBack(this.play);
            this.lastTime = getTimer();
            this.playCCC();
         }
      }
      
      private function play(interval:int) : void
      {
         if(!visible)
         {
            GameScene.instance.removeFrameCallBack(this.play);
         }
         if(getTimer() - this.lastTime > 2000)
         {
            this.lastTime = getTimer();
            this.playCCC();
         }
         if(this.playIndex < this.imgList.length)
         {
            if(this.imgList[this.playIndex] != null)
            {
               this.imgBM.x = this._info.content.rect[this._info.content.actionFrame * 3 + this.playIndex / this.INTERVALFRAM][0];
               this.imgBM.y = this._info.content.rect[this._info.content.actionFrame * 3 + this.playIndex / this.INTERVALFRAM][1];
               this.imgBM.bitmapData = this.imgList[this.playIndex];
            }
            ++this.playIndex;
         }
         else
         {
            this.playIndex = 0;
         }
      }
      
      private function playCCC() : void
      {
         var b:Bitmap = null;
         if(!this.ccc)
         {
            this.ccc = new Sprite();
            addChild(this.ccc);
            b = new Bitmap();
            this.ccc.addChild(b);
            this.ccc.alpha = 0;
            Utils.getLoadBitmap("resource/image/pet/7.3.png",b);
         }
         Tween.stop(this.ccc);
         Tween.to(this.ccc,1000,{
            "alpha":[0,1],
            "x":[this.starX,this.starX + 20],
            "scaleX":[0.1,1],
            "scaleY":[0.1,1],
            "y":[this.starY,this.starY - 40 / 2]
         });
      }
      
      private function get_haoHuaHZ() : void
      {
         var ww:Number;
         this.HHBtn = this.HHBtn || ComponentUtil.getButton("","haoHuaHZBtnX",this,{"callBack":function():void
         {
            YellowDiaManager.buy(true);
         }},ComponentUtil.domain);
         ww = this.Button_Open.x + this.Button_OpenYear.x + this.Button_OpenYear.width;
         ComponentUtil.setPropertie(this.HHBtn,{
            "x":(ww - this.HHBtn.width) / 2,
            "y":365
         });
         this.HHBtn.alpha = 0;
         Tween.to(this.Button_Open,600,{"x":[210,210 - this.HHBtn.width / 2 + 10]});
         Tween.to(this.Button_OpenYear,600,{"x":[410,410 + this.HHBtn.width / 2]});
         Tween.to(this.HHBtn,600,{
            "y":[365,400],
            "alpha":[0,1]
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         var haohua_text:MyTextField = null;
         x = stx;
         y = sty;
         if(value)
         {
            super.visible = value;
            scaleX = 1;
            scaleY = 1;
            alpha = 1;
            YelloDiaCGMessage.CG_YELLOWDIAMOND();
            Tween.to(this,300,{"alpha":[0,1]},this._onComp);
            if(Global.pf == "qqgame" || Global.pf == "3366")
            {
               this.Inf01_text.text = LangConfig.getWord("50052",5,LangConfig.getWord("60135",6));
               this.Inf02A_text.text = LangConfig.getWord("50050",5,LangConfig.getWord("60135",6));
               this.Inf03_text.text = LangConfig.getWord("50049",5,LangConfig.getWord("60135",6));
               this.Inf02B_text.text = LangConfig.getWord("50051",5,LangConfig.getWord("60135",6));
               haohua_text = new MyTextField();
               haohua_text.text = "豪华蓝钻奖励";
               if(isFirstOpen)
               {
                  Utils.loadTitle("lang/ch/Diamond_Imgs.swf","Title_Bule",new Bitmap(),{
                     "x":324,
                     "y":5
                  },this);
               }
               this.i = 0;
               while(this.i < descripLen)
               {
                  this.ylAddTf[this.i].text = this.hzDescrip[this.i];
                  if(Global.pf == Enum_SPStr.QQGAME)
                  {
                     this.rsTf[this.i].text = this.rsDescrip_hz[this.i];
                  }
                  else if(Global.pf == Enum_SPStr.QQ3366)
                  {
                     this.rsTf[this.i].text = this.rsDescrip_hz3366[this.i];
                  }
                  ++this.i;
               }
            }
            else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
            {
               this.Inf01_text.text = LangConfig.getWord("50052",5,LangConfig.getWord("60137",6));
               this.Inf02A_text.text = LangConfig.getWord("50050",5,LangConfig.getWord("60137",6));
               this.Inf03_text.text = LangConfig.getWord("50049",5,LangConfig.getWord("60137",6));
               this.Inf02B_text.text = LangConfig.getWord("50051",5,LangConfig.getWord("60137",6));
               if(isFirstOpen)
               {
                  Utils.loadTitle("lang/ch/Diamond_Imgs.swf","Title_VIP",new Bitmap(),{
                     "x":324,
                     "y":5
                  },this);
               }
               this.i = 0;
               while(this.i < descripLen)
               {
                  this.ylAddTf[this.i].text = this.HYDescrip[this.i];
                  this.rsTf[this.i].text = this.rsDescrip_hy[this.i];
                  ++this.i;
               }
            }
            else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
            {
               this.Inf01_text.text = LangConfig.getWord("50052",5,LangConfig.getWord("60138",6));
               this.Inf02A_text.text = LangConfig.getWord("50050",5,LangConfig.getWord("60138",6));
               this.Inf03_text.text = LangConfig.getWord("50049",5,LangConfig.getWord("60138",6));
               this.Inf02B_text.text = LangConfig.getWord("50051",5,LangConfig.getWord("60138",6));
               if(isFirstOpen)
               {
                  Utils.loadTitle("lang/ch/Diamond_Imgs.swf","Title_Diamond",new Bitmap(),{
                     "x":324,
                     "y":5
                  },this);
               }
               this.i = 0;
               while(this.i < descripLen)
               {
                  this.ylAddTf[this.i].text = this.ylDescrip[this.i];
                  this.rsTf[this.i].text = this.rsDescrip[this.i];
                  ++this.i;
               }
            }
            isFirstOpen = false;
            if(!this.bmPet.bitmapData)
            {
               Utils.getLoadBitmap("resource/image/shouchong/Diamond_Imgs.jpg",this.bmPet,{
                  "x":509,
                  "y":92
               });
            }
         }
         else
         {
            super.visible = value;
            if(this.isFinishVis)
            {
               return;
            }
            if(this.isGetObj)
            {
            }
            this.isFinishVis = true;
         }
      }
      
      private function daysGet(_type:int, _value:Boolean) : void
      {
         var temArr:Array = [];
         var temArr2:Array = [];
         if(_type == 0)
         {
            _type = 1;
         }
         temArr = Data_lib.yellowDiamond[_type][0].split(",");
         this.i = 0;
         while(this.i < temArr.length)
         {
            temArr2 = temArr[this.i].split("_");
            this.handleArr(this.vec_arr2,this.i,int(temArr2[0]),int(temArr2[1]),int(temArr2[2]),int(temArr2[3]),_value);
            ++this.i;
         }
      }
      
      private function levelsGet(_lvl:int, _value:Boolean) : void
      {
         if(_lvl >= 90)
         {
            _lvl = 80;
         }
         var temArr:Array = [];
         var temArr2:Array = [];
         if(_lvl % 10 != 0)
         {
            _lvl = 10;
         }
         temArr = Data_lib.yellowDiaMond2[_lvl][0].split(",");
         this.i = 0;
         while(this.i < temArr.length)
         {
            temArr2 = temArr[this.i].split("_");
            this.handleArr(this.vec_arr4,this.i,int(temArr2[0]),int(temArr2[1]),int(temArr2[2]),int(temArr2[3]),_value);
            ++this.i;
         }
      }
      
      private function yearsExtralGet(_value:Boolean) : void
      {
         var temArr:Array = [];
         var tempData:Array = [];
         if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU || Enum_SPStr.isIwan(Global.pf))
         {
            tempData = this.data2_arr;
         }
         else
         {
            tempData = this.data4_arr;
         }
         this.i = 0;
         while(this.i < tempData.length)
         {
            temArr = [];
            temArr = tempData[this.i].split("_");
            this.handleArr(this.vec_arr3,this.i,int(temArr[0]),int(temArr[1]),int(temArr[2]),int(temArr[3]),_value);
            ++this.i;
         }
      }
      
      private function haohua(v:Boolean) : void
      {
         var temArr2:Array = null;
         this.i = 0;
         while(this.i < this.data3_arr.length)
         {
            temArr2 = [];
            temArr2 = this.data3_arr[this.i].split("_");
            this.handleArr(this.vec_arr3a,this.i,int(temArr2[0]),int(temArr2[1]),int(temArr2[2]),int(temArr2[3]),v);
            ++this.i;
         }
      }
      
      public function reset() : void
      {
         this.Prompt_text.htmlText = "";
         if(Boolean(this._bmp1))
         {
            this._bmp1.bitmapData = null;
         }
         if(Boolean(this._bmp2))
         {
            this._bmp2.bitmapData = null;
         }
         if(Boolean(this._bmp1))
         {
            this._bmp3.bitmapData = null;
         }
      }
      
      public function resetArr(vecArr:Vector.<View_Grid>) : void
      {
         var temGrid:View_Grid = null;
         this.i = 0;
         while(this.i < vecArr.length)
         {
            temGrid = vecArr[this.i];
            temGrid.visible = false;
            ++this.i;
         }
      }
      
      public function update(_type:int, isYearCost:Boolean) : void
      {
         this.reset();
         this.getDiaMond1(_type);
         this.getDiaMond2(_type,true);
         this.getDiaMond3(true);
         var s:String = Global.pf == "qqgame" ? LangConfig.getWord("60135",6) : LangConfig.getWord("60138",6);
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            s = LangConfig.getWord("60135",6);
         }
         else if(Global.pf == "qplus" || Enum_SPStr.isUnion(Global.pf))
         {
            s = LangConfig.getWord("60137",6);
         }
         else
         {
            s = LangConfig.getWord("60138",6);
         }
         if(_type == 0)
         {
            this.Prompt_text.align = TextFormatAlign.CENTER;
            this.Prompt_text.htmlText = HtmlUtil.font(LangConfig.getWord("50058",5),"#afb495") + HtmlUtil.font(LangConfig.getWord("50059",5,s),"#ffea51") + HtmlUtil.font(LangConfig.getWord("50060",5),"#afb495");
            this.Prompt_text.x = 187.9;
            this.getAward(_type,false,false,false,false);
         }
         else
         {
            this.Prompt_text.htmlText = LangConfig.getWord("50061",5) + HtmlUtil.font(LangConfig.getWord("50059",5,s),"#ffea51") + LangConfig.getWord("50062",5);
            this.getAward(_type,true,false,false,isYearCost);
         }
      }
      
      public function listenToCanGet() : Boolean
      {
         if(this.Button_LQ01.enabled == true || this.Button_LQ02.enabled == true || this.Button_LQ03.enabled == true || this.getBtn.enabled == true)
         {
            return false;
         }
         return true;
      }
      
      public function updata(isDiaCustor:int, isYeaDiaCustor:int, DiaLevel:int, canLvlGoodsGet:int, canLvlGrowGoodsGet:int, yeaCostCanGet:int, yeaNewsCanGet:int, _level:int, isYellowPetCanGet:int, ishaohua:int) : void
      {
         var bm:Bitmap = null;
         this.reset();
         this.isYearCostCanget = yeaCostCanGet;
         this.isDaysGet = canLvlGoodsGet;
         this._yearNewsCanGet = yeaNewsCanGet;
         this._haohua = ishaohua;
         this.isGet_4 = canLvlGrowGoodsGet;
         this.resetArr(this.vec_arr3);
         this.getDiaMond2(DiaLevel,isDiaCustor > 0);
         this.getDiaMond3(isYeaDiaCustor > 0);
         this.daysGet(DiaLevel,canLvlGoodsGet > 0);
         this.levelsGet(_level,canLvlGrowGoodsGet > 0);
         this.yearsExtralGet(yeaCostCanGet > 0);
         this.newsGet(yeaNewsCanGet > 0);
         this.yellowDiaLvl = DiaLevel;
         var s:String = Global.pf == "qqgame" ? LangConfig.getWord("60135",6) : LangConfig.getWord("60138",6);
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            s = LangConfig.getWord("60135",6);
            this.haohua(ishaohua > 0);
            ComponentUtil.getTextField("豪华蓝钻礼包",this,{
               "x":345,
               "y":164.5,
               "color":16764206,
               "size":12,
               "leading":0
            });
            if(ishaohua != -1)
            {
               bm = Utils.getLoadBitmap("resource/image/hhlz/lz.png",null,{
                  "x":423,
                  "y":165
               });
               addChild(bm);
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            s = LangConfig.getWord("60137",6);
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            s = LangConfig.getWord("60138",6);
         }
         this.Inf03_text.text = LangConfig.getWord("50057",5,s,_level.toString());
         this.getDiaMond1(isDiaCustor);
         if(!isDiaCustor)
         {
            this.Prompt_text.align = TextFormatAlign.CENTER;
            this.Prompt_text.htmlText = HtmlUtil.font(LangConfig.getWord("50058",5),"#afb495") + HtmlUtil.font(LangConfig.getWord("50059",5,s),"#ffea51") + HtmlUtil.font(LangConfig.getWord("50060",5),"#afb495");
            this.Prompt_text.x = 187.9;
         }
         else
         {
            this.Prompt_text.align = TextFormatAlign.LEFT;
            this.Prompt_text.htmlText = HtmlUtil.font(LangConfig.getWord("50061",5),"#afb495") + HtmlUtil.font(LangConfig.getWord("50059",5,s),"#ffea51") + HtmlUtil.font(LangConfig.getWord("50062",5),"#afb495");
            this.Prompt_text.x = 46;
         }
         this.setbtn(this.Button_LQ01,yeaNewsCanGet);
         if(canLvlGoodsGet == 1 || yeaCostCanGet == 1)
         {
            this.setbtn(this.Button_LQ02,1);
         }
         else
         {
            this.setbtn(this.Button_LQ02,yeaCostCanGet);
         }
         if(ishaohua == 1)
         {
            this.setbtn(this.Button_LQ02,ishaohua);
         }
         this.setbtn(this.Button_LQ03,canLvlGrowGoodsGet);
         this.setYellowPetBtn(isYellowPetCanGet);
         this.listenToCanGet();
      }
      
      public function setYellowPetBtn(_isYlPCanGet:int) : void
      {
         switch(_isYlPCanGet)
         {
            case -1:
               this.getBtn.label = "<font color=\'#f9ff00\'>" + LangConfig.getWord("60222",6) + "</font>";
               break;
            case 0:
               this.getBtn.label = "<font color=\'#feff00\'>" + LangConfig.getWord("60389",6) + "</font>";
               break;
            case 1:
               this.getBtn.label = "<font color=\'#feff00\'>" + LangConfig.getWord("60351",6) + "</font>";
         }
         this.getBtn.enabled = _isYlPCanGet == 0 ? true : false;
      }
      
      public function updataTypeGet(typ:int, canGetAward:int, _level:int = 0) : void
      {
         var s:String = null;
         if(typ == 1)
         {
            this.newsGet(canGetAward > 0);
            this.setbtn(this.Button_LQ01,canGetAward);
            this.getGoods(this.vec_arr1);
         }
         else if(typ == 2)
         {
            this.daysGet(this.yellowDiaLvl,canGetAward > 0);
            this.yearsExtralGet(canGetAward > 0);
            this.setbtn(this.Button_LQ02,0);
            if(this.isDaysGet > 0 && this.isYearCostCanget > 0)
            {
               this.getGoods(this.vec_arr2.concat(this.vec_arr3));
            }
            else if(this.isDaysGet > 0 && this.isYearCostCanget < 1)
            {
               this.getGoods(this.vec_arr2);
            }
            else if(this.isDaysGet < 1 && this.isYearCostCanget > 0)
            {
               this.getGoods(this.vec_arr3);
            }
         }
         else if(typ == 3)
         {
            this.levelsGet(_level,canGetAward > 0);
            this.setbtn(this.Button_LQ03,canGetAward);
            this.getGoods(this.vec_arr4);
         }
         if(Global.pf == Enum_SPStr.QQGAME)
         {
            s = LangConfig.getWord("60135",6);
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            s = LangConfig.getWord("60138",6);
         }
         else if(Enum_SPStr.isUnion(Global.pf) || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG)
         {
            s = LangConfig.getWord("60137",6);
         }
         this.Inf03_text.text = LangConfig.getWord("50057",5,s,_level.toString());
      }
      
      private function getGoods(vect_arr:Vector.<View_Grid>) : void
      {
         this.i = 0;
         while(this.i < vect_arr.length)
         {
            Tween.gridToBagBezierFuncDef(vect_arr[this.i]);
            ++this.i;
         }
      }
      
      public function showIcon() : void
      {
         if(Global.via == "YITIAN")
         {
            if(!this.icon)
            {
               this.icon = new MainUIBtn("resource/image/shouchong/btn.png");
               this.icon.addEventListener(MouseEvent.CLICK,this.iconOnClick);
            }
            UIManager.mainUiBtnContainer.addBTN(this.icon);
         }
      }
      
      private function iconOnClick(e:MouseEvent) : void
      {
         YelloDiaCGMessage.CG_OLD_PLAYERS_RETURN_GETGOODS();
      }
      
      public function getG() : void
      {
         var vo:Vo_item = null;
         var p:Point = UIManager.mainUiBtnContainer.localToGlobal(new Point(this.icon.x,this.icon.y));
         vo = new Vo_item();
         vo.id = 46464;
         vo.Init_lib();
         Tween.gridToBagBezierFuncDef(vo,-1,p.x,p.y);
         UIManager.mainUiBtnContainer.removeBTN(this.icon);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class bmpItem extends Sprite
{
   
   private var _bmp:Bitmap;
   
   public function bmpItem()
   {
      super();
      this._bmp = new Bitmap();
      addChild(this._bmp);
   }
   
   public function set bitmapData(_bmd:BitmapData) : void
   {
      this._bmp.bitmapData = _bmd;
   }
   
   public function set bmp(_b:Bitmap) : void
   {
      this._bmp = _b;
   }
   
   public function get bmp() : Bitmap
   {
      return this._bmp;
   }
   
   public function get bitmapData() : BitmapData
   {
      return this._bmp.bitmapData;
   }
}
