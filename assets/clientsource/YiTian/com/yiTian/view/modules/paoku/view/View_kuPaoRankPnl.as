package com.yiTian.view.modules.paoku.view
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.KuPaoCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_kuPaoRankPnl extends Panel123
   {
      
      private var lastQuestTime:int = -888888;
      
      private var _items:Array = [];
      
      private var tf_pageInfo:MyTextField;
      
      private var btn_prePage:Button;
      
      private var btn_nxtPage:Button;
      
      private var _tfMyName:MyTextField;
      
      private var _tfMyScore:MyTextField;
      
      private var _tfMyRank:MyTextField;
      
      public var curPage:int = 0;
      
      public var itemLen:int = 10;
      
      public var maxPageIndex:int;
      
      public function View_kuPaoRankPnl()
      {
         super();
         regResource("lang/ch/MMKP.swf",KuPaoUtil.mainDmName);
      }
      
      public static function get instance() : View_kuPaoRankPnl
      {
         return Singleton.getInstance(View_kuPaoRankPnl);
      }
      
      override protected function initUI2() : void
      {
         var sp:Sprite = null;
         var item:RankItem = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":572,
            "height":444
         },Global.Img_Cdm);
         move = new Rectangle(0,0,572,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":537,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":522,
            "height":394
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
            "x":56,
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
         ComponentUtil.getBitmap("Line_PaiMing",this,{
            "x":44,
            "y":354
         },Global.MMKPdm);
         ComponentUtil.getScaleBitmap("Back_WDPM",[9,9,1,1],this,{
            "x":44,
            "y":355,
            "width":401,
            "height":26
         },Global.MMKPdm);
         ComponentUtil.getTextField("我的排名",this,{
            "x":46,
            "y":358,
            "color":16772287,
            "size":12,
            "leading":0
         });
         sp = new Sprite();
         addChild(sp);
         sp.x = 462;
         sp.y = 87;
         TipManager.bind(sp,KuPaoUtil.getAwardStr(0));
         ComponentUtil.getBitmap("Icon_DYiMing",sp,null,Global.MMKPdm);
         sp = new Sprite();
         addChild(sp);
         sp.x = 462;
         sp.y = 161;
         TipManager.bind(sp,KuPaoUtil.getAwardStr(1));
         ComponentUtil.getBitmap("Icon_QShiMing",sp,null,Global.MMKPdm);
         sp = new Sprite();
         sp.x = 462;
         sp.y = 235;
         addChild(sp);
         TipManager.bind(sp,KuPaoUtil.getAwardStr(2));
         ComponentUtil.getBitmap("Icon_QWuShi",sp,null,Global.MMKPdm);
         sp = new Sprite();
         addChild(sp);
         sp.x = 462;
         sp.y = 309;
         TipManager.bind(sp,KuPaoUtil.getAwardStr(3));
         ComponentUtil.getBitmap("Icon_QMingNei",sp,null,Global.MMKPdm);
         ComponentUtil.getTextField("周一0点邮件自动发放排名奖励物品并清除所有积分重新累计！",this,{
            "x":45,
            "y":412,
            "color":16763955,
            "size":12,
            "leading":0
         });
         this.btn_prePage = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":191,
            "y":386,
            "callBack":this.preClickHd
         },Global.Img_Cdm);
         this.btn_nxtPage = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":279,
            "y":386,
            "callBack":this.nxtClickHd
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":216,
            "y":387,
            "width":58,
            "height":18
         },Global.Img_Cdm);
         this.tf_pageInfo = ComponentUtil.getTextField("10/10",this,{
            "x":243,
            "y":387,
            "color":14662240
         });
         this.tf_pageInfo.autoSize = TextFieldAutoSize.CENTER;
         var i:int = 0;
         while(i < this.itemLen)
         {
            item = new RankItem();
            item.y = i * 27 + 89;
            item.x = 50;
            this._items.push(item);
            addChild(item);
            i++;
         }
         this._tfMyRank = ComponentUtil.getTextField("",this,{
            "x":116,
            "y":358,
            "color":16777011
         });
         this._tfMyRank.autoSize = TextFieldAutoSize.CENTER;
         this._tfMyName = ComponentUtil.getTextField("",this,{
            "x":244,
            "y":358,
            "color":16777011
         });
         this._tfMyName.autoSize = TextFieldAutoSize.CENTER;
         this._tfMyScore = ComponentUtil.getTextField("",this,{
            "x":388,
            "y":358,
            "color":16777011
         });
         this._tfMyScore.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.update();
            Global.control.registerCallBack(Model_KuPao.RANKUPDATE,this.update);
         }
         else
         {
            Global.control.removeCallBack(Model_KuPao.RANKUPDATE,this.update);
         }
         super.visible = value;
      }
      
      public function show() : void
      {
         this.visible = true;
         var now:int = getTimer();
         if(now - this.lastQuestTime > 10000)
         {
            this.lastQuestTime = now;
            KuPaoCGMessage.CG_KP_RANK(1);
         }
      }
      
      public function hide(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      public function update(arr:Array = null) : void
      {
         var data:Array = Model_KuPao._rankInfo;
         if(data == null)
         {
            return;
         }
         this.maxPageIndex = Model_KuPao._rankInfo.length / this.itemLen;
         if(Model_KuPao._rankInfo.length != 0 && Model_KuPao._rankInfo.length % this.itemLen == 0)
         {
            this.maxPageIndex -= 1;
         }
         this.curPage = Model_KuPao._pageIndex;
         this.showPage(this.curPage);
         this._tfMyRank.text = Model_KuPao._myRank.toString();
         this._tfMyName.text = GameUnitManager.hero.name;
         this._tfMyScore.text = Model_KuPao._myScore.toString();
      }
      
      public function showPage(pageIndex:int) : void
      {
         var perData:Array = null;
         var data:Array = Model_KuPao._rankInfo;
         this.curPage = Math.max(0,Math.min(pageIndex,this.maxPageIndex));
         this.tf_pageInfo.htmlText = (this.curPage + 1).toString() + "/" + (this.maxPageIndex + 1).toString();
         var index:int = 0;
         var i:int = this.curPage * this.itemLen;
         while(i < (this.curPage + 1) * this.itemLen)
         {
            perData = data[i];
            this._items[index].update(perData);
            index++;
            i++;
         }
      }
      
      private function preClickHd(e:MouseEvent) : void
      {
         if(this.curPage <= 0)
         {
            return;
         }
         this.showPage(this.curPage - 1);
      }
      
      private function nxtClickHd(e:MouseEvent) : void
      {
         if(this.curPage >= this.maxPageIndex)
         {
            return;
         }
         this.showPage(this.curPage + 1);
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

class RankItem extends Sprite
{
   
   public var _tfRank:MyTextField;
   
   public var _tfRoleName:MyTextField;
   
   public var _tfScore:MyTextField;
   
   public function RankItem()
   {
      super();
      this.init();
   }
   
   public function init() : void
   {
      this._tfRank = ComponentUtil.getTextField("",this,{
         "x":68,
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
      this._tfRank.color = this._tfRoleName.color = this._tfScore.color = this.getColor(data[0]);
      this._tfRank.text = data[0];
      this._tfRoleName.text = data[1];
      this._tfScore.text = data[2];
   }
   
   public function getColor(rank:int) : int
   {
      return 16777062;
   }
}
