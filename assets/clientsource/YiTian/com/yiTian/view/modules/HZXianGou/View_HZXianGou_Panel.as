package com.yiTian.view.modules.HZXianGou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.UIManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.HZXianGouCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class View_HZXianGou_Panel extends Panel123
   {
      
      private static var _instance:View_HZXianGou_Panel;
      
      public static var leftNum:int = 0;
      
      public static var openYellowDiamondUrl:String = "http://pay.qq.com/qzone/index.shtml?aid=game100621282.op";
      
      public static var isHuanZuan:int = 0;
      
      private var itemVec:Vector.<ExchangeItem> = new Vector.<ExchangeItem>();
      
      private var con:Sprite;
      
      private var closeBtn:Button;
      
      private var _leftNumTF:MyTextField;
      
      private var ItemIdArr:Array = [45305,45306,45307,45308,45309];
      
      private var _isUpdated:Boolean = false;
      
      private var Button_Open:Button;
      
      private var Button_OpenYear:Button;
      
      private var timeDes:MyTextField;
      
      private var activityDes:MyTextField;
      
      private var _isAvaible:Boolean = false;
      
      private var colorArr:Array;
      
      public function View_HZXianGou_Panel()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/HuangZuanXianGou.swf","HZXGLBdm");
      }
      
      public static function get instance() : View_HZXianGou_Panel
      {
         if(!_instance)
         {
            _instance = new View_HZXianGou_Panel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var posX:int = 0;
         var posY:int = 0;
         var item:ExchangeItem = null;
         var gridItem:GridItem = null;
         move = new Rectangle(0,0,747,38);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":747,
            "height":536
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":41,
            "width":697,
            "height":486
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":404,
            "width":673,
            "height":113
         },Global.HZXGLBdm);
         ComponentUtil.getBitmap("Back_XGLB",this,{
            "x":37,
            "y":52
         },Global.HZXGLBdm);
         ComponentUtil.getBitmap("Title_NMXL",this,{
            "x":293,
            "y":5
         },Global.HZXGLBdm);
         ComponentUtil.getTextField("全服限购：限量5000份，先到先得！",this,{
            "x":42,
            "y":410,
            "color":327424,
            "size":12,
            "leading":3,
            "realWidth":650,
            "multiline":true,
            "wordWrap":true
         });
         ComponentUtil.getTextField("活动规则：",this,{
            "x":42,
            "y":432,
            "color":327424,
            "size":12,
            "leading":3
         });
         this.activityDes = ComponentUtil.getTextField("",this,{
            "x":100,
            "y":427,
            "color":327424,
            "size":12,
            "leading":3,
            "realWidth":610,
            "multiline":true,
            "wordWrap":true
         });
         this.activityDes.htmlText = "<font color=\'#fad01c\' size = \'18\'>必须在本页面开通/续费黄钻</font></font>";
         ComponentUtil.getTextField("开通/续费1个月，可获得1份黄钻能量。",this,{
            "x":330,
            "y":432,
            "color":327424,
            "size":12,
            "leading":3
         });
         ComponentUtil.getBitmap("XK_LFHZ",this,{
            "x":464,
            "y":110
         },Global.HZXGLBdm);
         ComponentUtil.getBitmap("XK_MFLQ",this,{
            "x":39,
            "y":291
         },Global.HZXGLBdm);
         ComponentUtil.getBitmap("XK_SEFHZ",this,{
            "x":87,
            "y":71
         },Global.HZXGLBdm);
         ComponentUtil.getBitmap("XK_SFHZ",this,{
            "x":63,
            "y":181
         },Global.HZXGLBdm);
         ComponentUtil.getBitmap("XK_YFHZ",this,{
            "x":485,
            "y":249
         },Global.HZXGLBdm);
         this.con = new Sprite();
         addChild(this.con);
         var itemPos:Array = [[39,291],[485,249],[63,181],[464,110],[87,71]];
         this.colorArr = [16777215,327424,3394815,16711935,16742144];
         var len:int = int(Data_lib.huangzuanxiangou.getLength());
         var i:int = 0;
         while(i < len)
         {
            posX = int(itemPos[i][0]);
            posY = int(itemPos[i][1]);
            item = new ExchangeItem();
            ComponentUtil.setPropertie(item,{
               "x":posX,
               "y":posY
            });
            item.buttonIndex = i;
            item.initData(Data_lib.huangzuanxiangou[i + 1][2],Data_lib.huangzuanxiangou[i + 1][3],i,this.colorArr[i]);
            this.con.addChild(item);
            gridItem = new GridItem(i);
            if(i == 1 || i == 3)
            {
               ComponentUtil.setPropertie(gridItem,{
                  "x":posX + 10,
                  "y":posY + 10
               });
            }
            else
            {
               ComponentUtil.setPropertie(gridItem,{
                  "x":posX + 31,
                  "y":posY + 10
               });
            }
            this.con.addChild(gridItem);
            gridItem.updateData(this.ItemIdArr[i]);
            this.itemVec.push(item);
            i++;
         }
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":712,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = this.closeMenu;
         this._leftNumTF = ComponentUtil.getTextField("",this,{
            "x":592,
            "y":59
         });
         this._leftNumTF.htmlText = "剩余:<font color=\'#00ff00\'> 0 黄钻能量</font>";
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
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(this._isUpdated)
            {
               super.visible = value;
               return;
            }
            HZXianGouCGMessage.CG_HZXG_SHOW_PANEL();
         }
         else
         {
            super.visible = value;
            this._isUpdated = false;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 747) / 2;
         y = (Global.stage.stageHeight - 536) / 2;
      }
      
      public function update(isSuper:int, data:Array) : void
      {
         var i:int;
         var item:ExchangeItem = null;
         var btnStr1:String = null;
         var btnStr2:String = null;
         View_HZXianGou_Panel.isHuanZuan = isSuper;
         leftNum = data[0];
         this._leftNumTF.htmlText = "剩余:<font color=\'#00ff00\'> " + leftNum + " 黄钻能量</font>";
         i = 1;
         while(i < data.length)
         {
            item = this.itemVec[i - 1];
            item.updateData(data[i]);
            i++;
         }
         this._isUpdated = true;
         if(this._isUpdated)
         {
            this.visible = true;
         }
         this.isLightedCon();
         if(isHuanZuan > 0)
         {
            btnStr1 = "Button_XFHZ";
         }
         else
         {
            btnStr1 = "Button_KTHZ";
         }
         btnStr2 = "Button_HYKT";
         this.Button_Open = ComponentUtil.getButton("",btnStr1,this,{
            "x":158,
            "y":475,
            "textColor":16383744
         },ComponentUtil.domain);
         this.Button_OpenYear = ComponentUtil.getButton("",btnStr2,this,{
            "x":433,
            "y":475,
            "textColor":13434624
         },ComponentUtil.domain);
         this.setMouseOverOut(this.Button_Open);
         this.setMouseOverOut(this.Button_OpenYear);
         this.Button_Open.addEventListener(MouseEvent.CLICK,function():void
         {
            View_hzTribute.sendType = "self";
            YellowDiaManager.buy();
         });
         this.Button_OpenYear.addEventListener(MouseEvent.CLICK,function():void
         {
            if(btnStr2 == "Button_HYKT")
            {
               View_hzTribute.sendType = "send";
               YellowDiaManager.buy();
            }
            else
            {
               navigateToURL(new URLRequest("http://pay.qq.com/qzone/index.shtml?aid=game100621282.yop&paytime=year"));
            }
         });
      }
      
      public function isLightedCon() : void
      {
         if(isHuanZuan == 0)
         {
            View_HZXianGou_icon.instance.effectEnd();
         }
         else
         {
            this.checkShowIconEff();
         }
      }
      
      public function checkShowIconEff() : void
      {
         var len:int = int(this.itemVec.length);
         var i:int = 0;
         while(i < len)
         {
            if(this.itemVec[i].isAvaible())
            {
               this._isAvaible = true;
               View_HZXianGou_icon.instance.effectBegin();
               break;
            }
            this._isAvaible = false;
            i++;
         }
         if(!this._isAvaible)
         {
            View_HZXianGou_icon.instance.effectEnd();
         }
      }
      
      public function showResult(index:int, flag:int, getedTime:int) : void
      {
         var len1:int = 0;
         var i:int = 0;
         if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("兑换成功");
            len1 = int(this.itemVec.length);
            i = 0;
            while(i < len1)
            {
               if(index == i)
               {
                  this.itemVec[i].showResult(getedTime);
                  this._leftNumTF.htmlText = "剩余:<font color=\'#00ff00\'> " + leftNum + " 黄钻能量</font>";
                  this.checkShowIconEff();
               }
               i++;
            }
         }
         else if(flag == -1)
         {
            UIManager.centerBroadcast.addMsg("不符合条件");
         }
         else if(flag == -2)
         {
            UIManager.centerBroadcast.addMsg("已领完不能再领取");
         }
      }
      
      private function closeMenu(e:*) : void
      {
         this.visible = false;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Enum_type_grid;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.EffectManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.HZXianGouCGMessage;
import com.yiTian.view.comp.View_Alert;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.HZXianGou.View_HZXianGou_Panel;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFormatAlign;

class ExchangeItem extends Sprite
{
   
   private var desTextField:MyTextField;
   
   private var desNumText:MyTextField;
   
   private var limitTextField:MyTextField;
   
   private var upLimitTime:int = 0;
   
   private var curGetedNum:int = 0;
   
   private var needGiftsNum:int = 0;
   
   private var button:Button;
   
   public var buttonIndex:int = 0;
   
   public function ExchangeItem()
   {
      super();
      this.desNumText = ComponentUtil.getTextField("12",this);
      ComponentUtil.setPropertie(this.desNumText,{
         "color":16043313,
         "size":20,
         "x":121,
         "y":2
      });
      this.limitTextField = ComponentUtil.getTextField("0/0",this);
      ComponentUtil.setPropertie(this.limitTextField,{
         "align":TextFormatAlign.CENTER,
         "x":113,
         "y":27,
         "size":18,
         "color":16711680
      });
   }
   
   public function initData(str1:int, limitTime:int, index:int, color:uint) : void
   {
      this.desNumText.text = str1 + "";
      this.needGiftsNum = str1;
      this.limitTextField.text = "0/" + limitTime;
      this.limitTextField.color = color;
      this.upLimitTime = limitTime;
      if(this.needGiftsNum == 0)
      {
         this.button = ComponentUtil.getButton("","Button_XGLQ",this,{
            "x":108,
            "y":57,
            "callBack":this.exchangeGift
         },Global.HZXGLBdm);
      }
      else
      {
         this.button = ComponentUtil.getButton("","Button_DJDH",this,{
            "x":108,
            "y":57,
            "callBack":this.exchangeGift
         },Global.HZXGLBdm);
      }
      if(index == 0)
      {
         this.desNumText.visible = false;
         this.limitTextField.x = 153;
      }
      else if(index == 4)
      {
         this.desNumText.x = 135;
         this.limitTextField.x = 153;
      }
      else if(index == 2)
      {
         this.desNumText.x = 140;
         this.limitTextField.x = 153;
      }
      if(index == 1 || index == 3)
      {
         this.button.x = 90;
      }
   }
   
   private function exchangeGift(e:MouseEvent) : void
   {
      var str:String = null;
      if(this.needGiftsNum == 0)
      {
         if(View_HZXianGou_Panel.isHuanZuan == 0)
         {
            UIManager.centerBroadcast.addMsg("您当前还不是黄钻会员");
            return;
         }
      }
      if(this.curGetedNum >= this.upLimitTime)
      {
         UIManager.centerBroadcast.addMsg("该礼包兑换已达上限");
         return;
      }
      if(View_HZXianGou_Panel.leftNum >= this.needGiftsNum)
      {
         if(this.needGiftsNum == 0)
         {
            HZXianGouCGMessage.CG_HZXG_GET_AWARD(this.buttonIndex);
            return;
         }
         str = "确定消耗<font color=\'#F4CD31\'>" + this.needGiftsNum + "</font>份<font color=\'#F4CD31\'>黄钻能量</font>兑换该礼包？";
         View_Alert.show(str,View_Alert.OK_CANCAL,function():void
         {
            HZXianGouCGMessage.CG_HZXG_GET_AWARD(buttonIndex);
         });
      }
      else
      {
         UIManager.centerBroadcast.addMsg("黄钻能量不足兑换此礼包");
      }
   }
   
   public function updateData(num:int) : void
   {
      this.curGetedNum = num;
      this.limitTextField.text = this.curGetedNum + "/" + this.upLimitTime;
      if(this.buttonIndex == 0 && this.curGetedNum >= this.upLimitTime)
      {
         this.button.enabled = false;
      }
   }
   
   public function showResult(time:int) : void
   {
      this.curGetedNum = time;
      this.limitTextField.text = this.curGetedNum + "/" + this.upLimitTime;
      View_HZXianGou_Panel.leftNum -= this.needGiftsNum;
      if(this.needGiftsNum == 0)
      {
         this.button.enabled = false;
      }
   }
   
   public function isAvaible() : Boolean
   {
      var boolean:Boolean = this.needGiftsNum > View_HZXianGou_Panel.leftNum ? false : true;
      if(boolean)
      {
         if(this.curGetedNum >= this.upLimitTime)
         {
            return false;
         }
         return true;
      }
      return false;
   }
}

class GridItem extends Sprite
{
   
   private var grid:View_Grid;
   
   private var jiazhiBm:Bitmap;
   
   private var yuanBaoArr:Array = ["Text_YiBai","Text_ErJJ","Text_YiLJJ","Text_ErEJJ","Text_SiJJJ"];
   
   private var yuanbaoBm:Bitmap;
   
   public function GridItem(i:int)
   {
      super();
      this.grid = new View_Grid(true);
      this.grid.set_bmp_bg(View_Grid.GRID_OPEN);
      this.grid.set_bmp_over(true,null);
      this.grid.set_bmp_select(View_Grid.GRID_SELECT);
      this.grid.type = Enum_type_grid.STORE;
      this.grid.bmpBacKShow = false;
      addChild(this.grid);
      if(i == 4)
      {
         EffectManager.addEffect("35180",this.grid,1000,32,32,true);
      }
      this.jiazhiBm = ComponentUtil.getBitmap("Text_JiaZhi",this,{
         "x":1,
         "y":2
      },Global.HZXGLBdm);
      this.yuanbaoBm = ComponentUtil.getBitmap(this.yuanBaoArr[i],this,{"y":40},Global.HZXGLBdm);
      if(i == 3 || i == 4)
      {
         this.yuanbaoBm.x = -3;
      }
   }
   
   public function updateData(itemId:int) : void
   {
      var vo:Vo_item = new Vo_item();
      vo.id = itemId;
      vo.Init_lib();
      this.grid.vo = vo;
   }
}
