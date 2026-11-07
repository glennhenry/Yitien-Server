package com.yiTian.view.modules.actions.jiJin.chongzhi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_worldLevel;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FundCGMessage;
   import com.yiTian.net.message.cg.LoginCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import com.yiTian.view.modules.map.Model_GM_KF;
   import com.yiTian.view.modules.roleHead.View_HeroHead;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class View_wuHunItem extends Sprite
   {
      
      private var tabBtnVec:Vector.<TabButton>;
      
      public var tfCheckTf:MyTextField;
      
      private var leiJiTf:MyTextField;
      
      private var grid:View_Grid;
      
      private var tfDes:MyTextField;
      
      private var btn:Button;
      
      private var scalBmp:ScaleBitmap;
      
      private var lvlBm:Bitmap;
      
      private var statusArr:Array;
      
      private var _lvl:int;
      
      private var _grid:View_Grid;
      
      private var bb:Button;
      
      private var now:TabButton;
      
      private var _indx:int;
      
      public function View_wuHunItem()
      {
         var i:int;
         var ss:String = null;
         var sss:String = null;
         var tab:TabButton = null;
         this.tabBtnVec = new Vector.<TabButton>(3);
         this.statusArr = [];
         super();
         i = 0;
         while(i < this.tabBtnVec.length)
         {
            ss = FundMter.wuHunArr[i];
            sss = FundMter.colorArrX[i];
            tab = ComponentUtil.getTabButton(ss,"TabButton_WH",this,{
               "x":10 + 102 * i - 108,
               "tabIndex":i + 1,
               "y":0,
               "textColor":sss,
               "chooseColor":sss
            },Global.JiJin_Imgsdm);
            tab.addEventListener(MouseEvent.CLICK,this.cliHd);
            this.tabBtnVec[i] = tab;
            i++;
         }
         this.tfCheckTf = ComponentUtil.getTextField("查看我的特权",this,{
            "x":348,
            "y":5,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.tfCheckTf.htmlText = HtmlUtil.link(HtmlUtil.underLine("查看我的特权"),"mm");
         this.tfCheckTf.mouseEnabled = true;
         this.tfCheckTf.addEventListener(TextEvent.LINK,this.link);
         this.tfDes = ComponentUtil.getTextField("1、sss",this,{
            "x":10 - 108,
            "y":36,
            "color":11523767,
            "size":14,
            "leading":4,
            "multiline":true,
            "wordWrap":true,
            "realWidth":380
         });
         this.tfDes.addEventListener(TextEvent.LINK,this.onTextLink);
         this.tfDes.mouseEnabled = true;
         this.leiJiTf = ComponentUtil.getTextField("累计充值               即可成文",this,{
            "x":10 - 108,
            "y":162,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.grid = new View_Grid(true);
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         addChild(this.grid);
         ComponentUtil.setPropertie(this.grid,{
            "x":341,
            "y":36
         });
         this.btn = ComponentUtil.getButton("领取","Button_TwoBule91",this,{
            "x":330,
            "y":110,
            "textColor":16184781,
            "callBack":function():void
            {
               if(GameUnitManager.hero.level < Model_worldLevel.worldLev - 20)
               {
                  UIManager.centerBroadcast.addMsg("低于世界等级20级不能够领取该奖励");
                  return;
               }
               FundMter._chongZhiIndex = _indx;
               FundCGMessage.CG_GET_REWARD(2,_indx);
            }
         },Global.Img_Cdm);
         this.lvlBm = ComponentUtil.getBitmap("WH_Lv1",this,{
            "x":13 - 108,
            "y":3
         },Global.JiJin_Imgsdm);
      }
      
      protected function onTextLink(event:TextEvent) : void
      {
         Model_GM_KF.outOf_btn_call = false;
         if(Model_GM_KF.isShowEff)
         {
            Model_GM_KF.showEff(false);
         }
         LoginCGMessage.CG_BTN_EFF();
         LoginCGMessage.CG_GM_KEFU(encodeURI(View_HeroHead.playerName));
      }
      
      public function show(chongMo:int, arr:Array, lvl:int) : void
      {
         var maxNum:int = 0;
         var lvStr:int = 0;
         this.statusArr = arr;
         this._lvl = lvl;
         if(lvl > 0)
         {
            this.tfCheckTf.htmlText = HtmlUtil.link(HtmlUtil.underLine("查看我的特权"),"mm");
            this.tfCheckTf.dispatchEvent(new TextEvent(TextEvent.LINK));
         }
         else
         {
            this.tabBtnVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         if(chongMo >= 0 && chongMo < 100000)
         {
            maxNum = 1000;
            lvStr = 1;
         }
         else if(chongMo >= 100000 && chongMo < 200000)
         {
            maxNum = 10000;
            lvStr = 2;
         }
         else if(chongMo >= 200000 && chongMo < 1000000)
         {
            maxNum = 100000;
            lvStr = 3;
         }
         else if(chongMo >= 1000000)
         {
            maxNum = 100000;
            lvStr = 3;
         }
         this.showKefuMeiNv(this._lvl > 0);
      }
      
      private function showKefuMeiNv(value:Boolean) : void
      {
         if(value)
         {
            if(!this._grid)
            {
               this._grid = new View_Grid(true);
               this._grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
               this._grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
               this._grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
               addChild(this._grid);
               ComponentUtil.setPropertie(this._grid,{
                  "x":341 - 94,
                  "y":36
               });
               addChild(Utils.getLoadBitmap("resource/image/keFuMeinv/meiNv.png",new Bitmap(),{
                  "x":341 - 94,
                  "y":36
               }));
            }
            if(!this.bb)
            {
               this.bb = ComponentUtil.getButton("客服美女","Button_TwoBule91",this,{
                  "x":330 - 93,
                  "y":110,
                  "callBack":function():void
                  {
                     FundCGMessage.CG_MEINVKEFU_SEND();
                     navigateToURL(new URLRequest("http://wpa.qq.com/msgrd?V=1&Uin=800079096"),"_blank");
                  }
               },Global.Img_Cdm);
            }
         }
         else
         {
            if(Boolean(this._grid))
            {
               this._grid.visible = false;
            }
            if(Boolean(this.bb))
            {
               this.bb.visible = false;
            }
         }
      }
      
      private function link(e:TextEvent) : void
      {
         var btn:TabButton = null;
         var _btn:TabButton = null;
         if(this.tfCheckTf.text == "查看我的特权")
         {
            if(this._lvl == 0)
            {
               UIManager.centerBroadcast.addMsg("您还不是白金武魂哦亲");
               return;
            }
            this.tfCheckTf.htmlText = HtmlUtil.link(HtmlUtil.underLine("查看其他特权"),"mm");
            for each(btn in this.tabBtnVec)
            {
               btn.visible = false;
            }
            if(this._lvl < 1)
            {
               this._lvl = 1;
            }
            this.tabBtnVec[this._lvl - 1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else if(this.tfCheckTf.text == "查看其他特权")
         {
            this.tfCheckTf.htmlText = HtmlUtil.link(HtmlUtil.underLine("查看我的特权"),"mm");
            for each(_btn in this.tabBtnVec)
            {
               _btn.visible = true;
            }
            this.tabBtnVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var tb:TabButton = e.target as TabButton;
         var _typeIndex:int = tb.tabIndex;
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         tb.choose = true;
         this.now = tb;
         this.showDescrip(_typeIndex);
      }
      
      private function getVo(_ty:int) : Vo_valuable
      {
         var _vo:Vo_item = new Vo_item();
         _vo.id = 44525 + _ty;
         _vo.Init_lib();
         return _vo as Vo_valuable;
      }
      
      private function showDescrip(_type:int) : void
      {
         var sss:String = null;
         this._indx = _type;
         var ss:String = Data_lib.fundDescrip[_type][0];
         var linkStr:String = HtmlUtil.createLink("<font color=\'#00ff00\'>客服系统</font>");
         ss = LangConfig.reTxt(ss,linkStr);
         this.tfDes.htmlText = ss;
         var statusB:int = int(this.statusArr[_type - 1]);
         this.grid.vo = this.getVo(_type);
         if(statusB == 1)
         {
            this.btn.enabled = true;
            this.btn.label = "可领取";
         }
         else if(statusB == 2)
         {
            this.btn.enabled = false;
            this.btn.label = "已领取";
         }
         else if(statusB == 0)
         {
            this.btn.enabled = false;
            this.btn.label = "等级不够";
         }
         this.leiJiTf.visible = true;
         this.leiJiTf.htmlText = "累计充值" + HtmlUtil.font(FundMter.moneyArr[_type - 1] + "元宝","#f9ff00") + "即可成为" + HtmlUtil.font(_type.toString() + "级白金武魂",FundMter.colorArr[_type]);
         if(this.tfCheckTf.text == "查看其他特权")
         {
            if(this._lvl > 0)
            {
               sss = "WH_Lv" + this._lvl;
               this.lvlBm.visible = true;
               this.lvlBm.bitmapData = ComponentUtil.getBitmapData(sss,Global.JiJin_Imgsdm);
               this.leiJiTf.visible = false;
            }
            else
            {
               this.lvlBm.visible = false;
            }
         }
         else
         {
            this.lvlBm.visible = false;
         }
      }
      
      public function getAward(_index:int) : void
      {
         this.statusArr[_index - 1] = 0;
         ComboTweenStep.toBag(this.grid);
      }
   }
}

