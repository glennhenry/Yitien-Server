package com.yiTian.view.modules.paoku.view
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.KuPaoCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_KuPaoFriendRank extends Panel123
   {
      
      private var lastQuestTime:int = -888888;
      
      private var _items:Array = [];
      
      private var tf_pageInfo:MyTextField;
      
      private var btn_prePage:Button;
      
      private var btn_nxtPage:Button;
      
      public var curPage:int = 0;
      
      public var itemLen:int = 11;
      
      public var maxPageIndex:int;
      
      public function View_KuPaoFriendRank()
      {
         super();
         regResource("lang/ch/MMKP.swf",KuPaoUtil.mainDmName);
      }
      
      public static function get instance() : View_KuPaoFriendRank
      {
         return Singleton.getInstance(View_KuPaoFriendRank);
      }
      
      override protected function initUI2() : void
      {
         var item:rankItem = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":572,
            "height":418
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":537,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":522,
            "height":368
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":413,
            "height":332
         },Global.MMKPdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":454,
            "y":52,
            "width":81,
            "height":332
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Title_MMKPPH",this,{
            "x":206,
            "y":5
         },Global.MMKPdm);
         ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":42,
            "y":57,
            "width":405,
            "height":27
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_JiFen",this,{
            "x":332,
            "y":60
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Text_JueSeMing",this,{
            "x":180,
            "y":60
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Text_MingCi",this,{
            "x":44,
            "y":60
         },Global.MMKPdm);
         ComponentUtil.getScaleBitmap("Back_KuPaoPH",[3,3,1,1],this,{
            "x":44,
            "y":86,
            "width":401,
            "height":271
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Line_PaiMing",this,{
            "x":44,
            "y":111
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Line_PaiMing",this,{
            "x":44,
            "y":138
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Line_PaiMing",this,{
            "x":44,
            "y":165
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Line_PaiMing",this,{
            "x":44,
            "y":192
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Line_PaiMing",this,{
            "x":44,
            "y":219
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Line_PaiMing",this,{
            "x":44,
            "y":246
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Line_PaiMing",this,{
            "x":44,
            "y":273
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Line_PaiMing",this,{
            "x":44,
            "y":300
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Line_PaiMing",this,{
            "x":44,
            "y":327
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Text_ZhouJiangLi",this,{
            "x":454,
            "y":56
         },Global.MMKPdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":461,
            "y":86
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":461,
            "y":160
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":461,
            "y":234
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":461,
            "y":308
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Icon_DYiMing",this,{
            "x":462,
            "y":87
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Icon_QMingNei",this,{
            "x":462,
            "y":309
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Icon_QShiMing",this,{
            "x":462,
            "y":161
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Icon_QWuShi",this,{
            "x":462,
            "y":235
         },Global.MMKPdm);
         ComponentUtil.getTextField("每周一零时以系统邮件自动发放排名奖励物品并清除所有排名从新累计。",this,{
            "x":45,
            "y":386,
            "color":16763955,
            "size":12,
            "leading":0
         });
         this.btn_prePage = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":191,
            "y":360,
            "callBack":this.preClickHd
         },Global.Img_Cdm);
         this.btn_nxtPage = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":279,
            "y":360,
            "callBack":this.nxtClickHd
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":216,
            "y":361,
            "width":58,
            "height":18
         },Global.Img_Cdm);
         this.tf_pageInfo = ComponentUtil.getTextField("10/10",this,{
            "x":243,
            "y":361,
            "color":14662240
         });
         this.tf_pageInfo.autoSize = TextFieldAutoSize.CENTER;
         var i:int = 0;
         while(i < this.itemLen)
         {
            item = new rankItem();
            item.y = i * 27 + 89;
            item.x = 50;
            this._items.push(item);
            addChild(item);
            i++;
         }
      }
      
      private function preClickHd(e:MouseEvent) : void
      {
         this.showPage(this.curPage - 1);
      }
      
      private function nxtClickHd(e:MouseEvent) : void
      {
         this.showPage(this.curPage + 1);
      }
      
      public function show() : void
      {
         var now:int = getTimer();
         if(now - this.lastQuestTime > 1)
         {
            this.lastQuestTime = now;
            KuPaoCGMessage.CG_KP_FRIENDSRANK();
         }
         this.visible = true;
      }
      
      public function hide(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.update();
            Global.control.registerCallBack(Model_KuPao.FRIENDRANK_UPDATE,this.update);
         }
         else
         {
            Global.control.removeCallBack(Model_KuPao.FRIENDRANK_UPDATE,this.update);
         }
         super.visible = value;
      }
      
      public function update(arr:Array = null) : void
      {
         var data:Array = Model_KuPao.friendRanks;
         if(data == null)
         {
            return;
         }
         this.maxPageIndex = data.length / this.itemLen;
         if(data.length % this.maxPageIndex == 0)
         {
            this.maxPageIndex = 0;
         }
         this.showPage(this.curPage);
      }
      
      public function showPage(pageIndex:int) : void
      {
         var perData:Array = null;
         var data:Array = Model_KuPao.friendRanks;
         this.curPage = Math.max(0,Math.min(pageIndex,this.maxPageIndex));
         this.tf_pageInfo.htmlText = (this.curPage + 1).toString() + "/" + (this.maxPageIndex + 1).toString();
         var endIndex:int = this.curPage * this.itemLen + this.itemLen;
         var index:int = 0;
         var i:int = this.curPage * this.itemLen;
         while(i < endIndex)
         {
            perData = data[i];
            this._items[index].update(perData);
            index++;
            i++;
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

class rankItem extends Sprite
{
   
   public var _tfRank:MyTextField;
   
   public var _tfRoleName:MyTextField;
   
   public var _tfScore:MyTextField;
   
   public function rankItem()
   {
      super();
      this.init();
   }
   
   public function init() : void
   {
      this._tfRank = ComponentUtil.getTextField("",this,{
         "x":50,
         "realWidth":0
      });
      this._tfRank.autoSize = TextFieldAutoSize.CENTER;
      this._tfRoleName = ComponentUtil.getTextField("",this,{
         "x":195,
         "realWidth":0
      });
      this._tfRoleName.autoSize = TextFieldAutoSize.CENTER;
      this._tfScore = ComponentUtil.getTextField("",this,{
         "x":340,
         "realWidth":0
      });
      this._tfScore.autoSize = TextFieldAutoSize.CENTER;
   }
   
   public function update(data:Object) : void
   {
      if(data == null)
      {
         visible = false;
         return;
      }
      visible = true;
      this._tfRank.text = data[0];
      this._tfRoleName.text = data[1];
      this._tfScore.text = data[2];
   }
}
