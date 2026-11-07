package com.yiTian.view.modules.actions.jiJin
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.FundCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WuHunLvl extends Sprite
   {
      
      private var tabBtnVec:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var desCripTf:MyTextField;
      
      private var btn:Button;
      
      private var leiJiTf:MyTextField;
      
      private var bmType:Bitmap;
      
      private var bmCon:Sprite;
      
      private var now:TabButton;
      
      private var idArr:Array = [44526,44527,44528];
      
      private var _indx:int;
      
      private var isOn:Boolean = false;
      
      private var statusArr:Array = [];
      
      public function WuHunLvl()
      {
         var ss:String = null;
         var sss:String = null;
         var tabB:TabButton = null;
         super();
         var i:int = 0;
         while(i < 3)
         {
            ss = FundMter.wuHunArr[i];
            sss = FundMter.colorArrX[i];
            tabB = ComponentUtil.getTabButton(ss,"TabButton_Six",this,{
               "x":10 + i * 106,
               "y":7,
               "tabIndex":i + 1,
               "textColor":sss,
               "chooseColor":sss
            },Global.Img_Cdm);
            this.tabBtnVec.push(tabB);
            tabB.addEventListener(MouseEvent.CLICK,this.cliHd);
            i++;
         }
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":0,
            "y":28,
            "width":540,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":10,
            "y":38,
            "width":520,
            "height":96
         },Global.Img_Cdm);
         this.desCripTf = ComponentUtil.getTextField("1、中文中文中文中文中文中文中文\n2、中文中文中文中文中文中文中文\n3、中文中文中文中文中文中文中文\n4、中文中文中文中文中文中文中文\n5、中文中文中文中文中文中文中文",this,{
            "x":20,
            "y":43,
            "color":11523767,
            "size":14,
            "leading":4,
            "multiline":true,
            "wordWrap":true,
            "realWidth":350
         });
         this.bmCon = new Sprite();
         addChild(this.bmCon);
         ComponentUtil.setPropertie(this.bmCon,{
            "x":430,
            "y":41
         });
         this.bmType = ComponentUtil.getBitmap("gift_icon",this.bmCon,{
            "x":0,
            "y":0
         },Global.JiJin_Imgsdm);
         this.bmCon.addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
         this.bmCon.addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
         this.bmCon.addEventListener(MouseEvent.MOUSE_MOVE,this.moveHd);
         this.btn = ComponentUtil.getButton("点击领取","Button_TwoBule91",this,{
            "x":417,
            "y":106,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn.addEventListener(MouseEvent.CLICK,this.getA);
         this.leiJiTf = ComponentUtil.getTextField("累计充值                即可成为",this,{
            "x":14,
            "y":136,
            "color":14662240,
            "size":12,
            "leading":0
         });
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
      
      private function showDescrip(_type:int) : void
      {
         this._indx = _type;
         var ss:String = Data_lib.fundDescrip[_type][0];
         this.desCripTf.htmlText = ss;
         var statusB:int = int(this.statusArr[_type - 1]);
         if(statusB == 1)
         {
            this.btn.enabled = true;
            this.btn.label = "可领取";
            this.bmType.filters = [];
         }
         else if(statusB == 2)
         {
            this.btn.enabled = false;
            this.btn.label = "已领取";
            this.bmType.filters = Util.disabled;
         }
         else if(statusB == 0)
         {
            this.btn.enabled = false;
            this.btn.label = "等级不够";
            this.bmType.filters = Util.disabled;
         }
         this.leiJiTf.visible = true;
         this.leiJiTf.htmlText = "累计充值" + HtmlUtil.font(FundMter.moneyArr[_type - 1] + "元宝","#f9ff00") + "即可成为" + HtmlUtil.font(_type.toString() + "级白金武魂",FundMter.colorArr[_type]);
      }
      
      private function overHd(e:MouseEvent) : void
      {
         this.isOn = true;
         TipManager.update(FundMter.getVoArr(this._indx));
         this.rePos();
      }
      
      private function outHd(e:MouseEvent) : void
      {
         this.isOn = false;
         TipManager.hide();
      }
      
      private function moveHd(e:MouseEvent) : void
      {
         if(this.isOn)
         {
            TipManager.update(FundMter.getVoArr(this._indx));
            this.rePos();
         }
      }
      
      private function rePos() : void
      {
         TipManager.view_tip.x = Global.stage.mouseX + 5;
         TipManager.view_tip.y = Global.stage.mouseY - TipManager.view_tip.height - 5;
         TipManager.view_equip.x = TipManager.view_tip.x + TipManager.view_tip.width;
         TipManager.view_equip.y = TipManager.view_tip.y;
      }
      
      public function show(arr:Array, chongMo:int, lvl:int) : void
      {
         var maxNum:int = 0;
         var lvStr:int = 0;
         this.reset();
         this.statusArr = arr;
         this.tabBtnVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         if(chongMo >= 0 && chongMo < 1000)
         {
            maxNum = 1000;
            lvStr = 1;
         }
         else if(chongMo >= 1000 && chongMo < 10000)
         {
            maxNum = 10000;
            lvStr = 2;
         }
         else if(chongMo >= 10000 && chongMo < 100000)
         {
            maxNum = 100000;
            lvStr = 3;
         }
         var chaJia:int = maxNum - chongMo;
         this.leiJiTf.htmlText = "累计充值" + HtmlUtil.font(maxNum + "元宝","#f9ff00") + "即可成为" + HtmlUtil.font(lvStr.toString() + "级白金武魂",FundMter.colorArr[lvStr]);
      }
      
      public function set money(value:int) : void
      {
         trace("money");
      }
      
      private function getA(e:MouseEvent) : void
      {
         FundMter._chongZhiIndex = this._indx;
         FundCGMessage.CG_GET_REWARD(2,this._indx);
      }
      
      public function getAward(_index:int) : void
      {
         this.statusArr[_index - 1] = 0;
         ComboTweenStep.toBag(this.bmType);
         this.bmType.filters = Util.disabled;
      }
      
      public function reset() : void
      {
         var i:int = 0;
         var tabB:TabButton = null;
         i = 0;
         while(i < this.tabBtnVec.length)
         {
            tabB = this.tabBtnVec[i];
            tabB.visible = true;
            ComponentUtil.setPropertie(tabB,{"x":10 + i * 106});
            i++;
         }
      }
      
      public function update(lvl:int) : void
      {
         var _tab:TabButton = null;
         var __tab:TabButton = null;
         this.reset();
         if(lvl == 0)
         {
            this.tabBtnVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else
         {
            for each(_tab in this.tabBtnVec)
            {
               _tab.visible = false;
            }
            __tab = this.tabBtnVec[lvl - 1];
            __tab.visible = true;
            __tab.x = 10;
            __tab.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
   }
}

