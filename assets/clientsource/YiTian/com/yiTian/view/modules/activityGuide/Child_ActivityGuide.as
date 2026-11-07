package com.yiTian.view.modules.activityGuide
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.ActivityCGMessage;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.nationalTreasure.Enum_NationalTreasure;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class Child_ActivityGuide extends Sprite
   {
      
      private var textDes:MyTextField;
      
      private var textOperate:MyTextField;
      
      private var grid:View_Grid;
      
      private var gridArr:Array = [];
      
      private var btn:Button;
      
      private var id:int;
      
      private var index:int;
      
      private var btnLabalArr:Array = ["条件不符","可领取","已领取","条件不符"];
      
      private var btnLabelTextArr:Array = ["未达成","领取奖励","已达上限"];
      
      private var textGetWardTime:MyTextField;
      
      public var getAwardTimes:int = 20;
      
      private var btnGetWard:Button;
      
      private var btnNormal:Button;
      
      private var lastClickTime:uint;
      
      public function Child_ActivityGuide()
      {
         super();
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":0,
            "y":0,
            "width":430,
            "height":50
         },Global.Img_Cdm);
         this.textDes = ComponentUtil.getTextField("资源塔*00",this,{
            "x":-15,
            "y":9,
            "color":13424242,
            "size":12,
            "leading":0,
            "multiline":true,
            "wordWrap":true
         });
         this.textDes.realWidth = 180;
         this.textDes.align = TextFormatAlign.CENTER;
         this.textOperate = ComponentUtil.getTextField("资源塔*00",this,{
            "x":345,
            "y":15,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.btnNormal = ComponentUtil.getButton("条件不符","Button_Orange",this,{
            "x":345,
            "y":15,
            "textColor":16184781,
            "callBack":this.gain
         },Global.Img_Cdm);
         this.btn = this.btnNormal;
         this.checkBtnVisible(false);
         var i:int = 0;
         while(i < 5)
         {
            this.grid = new View_Grid();
            this.grid.set_bmp_bg();
            this.grid.set_bmp_over(true,null);
            this.grid.set_tf_count(true,false,true);
            addChild(this.grid);
            this.grid.x = 140 + i * 50;
            this.grid.y = 5;
            this.grid.visible = false;
            this.gridArr.push(this.grid);
            i++;
         }
         this.btnGetWard = ComponentUtil.getButton("条件不符","Button_Five",this,{
            "x":335,
            "y":15,
            "textColor":16772287,
            "callBack":this.gain
         },Global.Img_Cdm);
         this.textGetWardTime = ComponentUtil.getTextField("已领取0/20",this,{
            "x":335,
            "y":30,
            "color":13424242,
            "size":11,
            "leading":0
         });
         this.textGetWardTime.visible = false;
         this.textGetWardTime.text = "已领取0/" + this.getAwardTimes;
         this.textGetWardTime.realWidth = 92;
         this.textGetWardTime.x = this.btnGetWard.x + (this.btnGetWard.width - this.textGetWardTime.width) * 0.5;
         this.textGetWardTime.align = TextFormatAlign.CENTER;
         this.btnGetWard.visible = false;
         setChildIndex(this.textGetWardTime,numChildren - 1);
      }
      
      private function checkBtnVisible(value:Boolean) : void
      {
         this.btn.visible = value;
         this.textOperate.visible = !value;
      }
      
      private function gain(e:MouseEvent) : void
      {
         if(getTimer() - this.lastClickTime < 1000)
         {
            return;
         }
         this.lastClickTime = getTimer();
         switch(this.id)
         {
            case Enum_ActivityGuide.NEIDAN_ID:
               DailyActCGMessage.CG_GET_SHENDAN_REWARD(this.index);
               break;
            case Enum_ActivityGuide.WUXING_ID:
               DailyActCGMessage.CG_GET_WUXING_REWARD(this.index);
               break;
            case Enum_ActivityGuide.HORSE_ID:
               DailyActCGMessage.CG_GET_HORSE_REWARD(this.index);
               break;
            case Enum_ActivityGuide.PET_EQUIP_ID:
               DailyActCGMessage.CG_GET_PET_EQUIP_REWARD(this.index);
               break;
            case Enum_ActivityGuide.MeiRiHuiKui:
               DailyActCGMessage.CG_MeiRiHuiKui_GET(this.index);
               break;
            case Enum_ActivityGuide.STONE_ID:
               DailyActCGMessage.CG_GET_STONE_REWARD(this.index);
               break;
            case Enum_ActivityGuide.STRENGHTEN_ID:
               DailyActCGMessage.CG_GET_EQUIP_STRENTHEN_REWARD(this.index);
               break;
            case Enum_ActivityGuide.WASH_ID:
               DailyActCGMessage.CG_GET_WASH_REWARD(this.index);
               break;
            case Enum_ActivityGuide.CHENGZHUANG_WASH_ID:
               DailyActCGMessage.CG_CHENGZHUANG_GET_WASH_REWARD(this.index);
               break;
            case Enum_ActivityGuide.PET_GROW_ID:
               DailyActCGMessage.CG_GET_PET_GROW_REWARD(this.index + 1);
               break;
            case Enum_ActivityGuide.SHENBING_ID:
               DailyActCGMessage.CG_GET_SHENBING_REWARD(this.index);
               break;
            case Enum_ActivityGuide.ChongWuNeiDan2:
               DailyActCGMessage.CG_GET_ChongWuNeiDan2_REWARD(this.index);
               break;
            case Enum_ActivityGuide.CHIBANG_ZHUTI:
               DailyActCGMessage.CG_CHIBANG_GETGIFT(this.index);
               break;
            case Enum_ActivityGuide.XIAOFEIHUIKUI:
               DailyActCGMessage.CG_XIAOFEIHUIKUI_GETAWARD(this.index);
               break;
            case Enum_ActivityGuide.DENGLUYOULI:
               DailyActCGMessage.CG_DengluYouLi_GETAWARD(this.index);
               break;
            case Enum_ActivityGuide.JINGXIU:
               ActivityCGMessage.CG_ACTIVITY_CWJX_GETWARD(this.index);
         }
         Model_ActivityGuide.rewardIndex = this.index;
      }
      
      public function update(id:int, index:int, des:String, statusDes:String, arr:Array, statusDes2:Array = null) : void
      {
         var i:int = 0;
         var tempArr:Array = null;
         var k:int = 0;
         var repeatNum:int = 0;
         var getNum:int = 0;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var isAddEff:int = 0;
         var _voI:Vo_item = null;
         var _voE:Vo_equip = null;
         if(!arr || !arr.length)
         {
            return;
         }
         var len:int = int(arr.length);
         this.id = id;
         this.index = index;
         var arr1:Array = [];
         var itemArr:Array = [];
         if(id == Enum_ActivityGuide.XIAOFEIHUIKUI)
         {
            this.btn = this.btnGetWard;
            this.btn.y = 5;
            this.btnNormal.visible = false;
            this.textGetWardTime.y = 30;
            this.textGetWardTime.visible = true;
            this.textDes.x = -10;
            arr1 = Data_lib.xiaofeihuikui[index + 1];
            tempArr = arr1[2].split(",");
            k = 0;
            while(k < tempArr.length)
            {
               itemArr.push(tempArr[k].split("_"));
               k++;
            }
         }
         else
         {
            this.btn = this.btnNormal;
            this.btnNormal.visible = true;
            this.btnGetWard.visible = false;
            this.textGetWardTime.visible = false;
            this.textGetWardTime.y = 15;
            if(id == Enum_ActivityGuide.DENGLUYOULI)
            {
               this.textDes.x = -30;
            }
            else
            {
               this.textDes.x = -15;
            }
         }
         switch(id)
         {
            case Enum_ActivityGuide.NEIDAN_ID:
            case Enum_ActivityGuide.WUXING_ID:
            case Enum_ActivityGuide.HORSE_ID:
            case Enum_ActivityGuide.PET_EQUIP_ID:
            case Enum_ActivityGuide.MeiRiHuiKui:
            case Enum_ActivityGuide.STONE_ID:
            case Enum_ActivityGuide.STRENGHTEN_ID:
            case Enum_ActivityGuide.WASH_ID:
            case Enum_ActivityGuide.CHENGZHUANG_WASH_ID:
            case Enum_ActivityGuide.PET_GROW_ID:
            case Enum_ActivityGuide.SHENBING_ID:
            case Enum_ActivityGuide.ChongWuNeiDan2:
            case Enum_ActivityGuide.CHIBANG_ZHUTI:
            case Enum_ActivityGuide.DENGLUYOULI:
            case Enum_ActivityGuide.JINGXIU:
               this.btn.label = this.btnLabalArr[int(statusDes)];
               this.checkBtnVisible(true);
               if(int(statusDes) == 1)
               {
                  this.btn.enabled = true;
                  break;
               }
               this.btn.enabled = false;
               break;
            case Enum_ActivityGuide.XIAOFEIHUIKUI:
               this.checkBtnVisible(true);
               repeatNum = int(statusDes2[0]);
               getNum = int(statusDes2[1]);
               this.textGetWardTime.text = "已领取" + repeatNum + "/" + this.getAwardTimes;
               this.textGetWardTime.x = this.btnGetWard.x + (this.btnGetWard.width - this.textGetWardTime.width) * 0.5;
               if(repeatNum == this.getAwardTimes)
               {
                  this.btn.enabled = false;
                  this.btn.label = this.btnLabelTextArr[2];
                  break;
               }
               if(getNum == 0)
               {
                  this.btn.enabled = false;
                  this.btn.label = this.btnLabelTextArr[0];
                  break;
               }
               this.btn.enabled = true;
               this.btn.label = this.btnLabelTextArr[1] + "(" + getNum + ")";
               break;
            default:
               this.checkBtnVisible(false);
               this.textOperate.htmlText = statusDes == "" ? "邮件发送" : statusDes;
         }
         this.textDes.htmlText = des;
         i = 0;
         while(i < 5)
         {
            this.gridArr[i].visible = false;
            if(len == 1)
            {
               this.gridArr[i].x = 230 + i * 50;
            }
            else if(len == 2)
            {
               this.gridArr[i].x = 205 + i * 50;
            }
            else if(len == 3)
            {
               this.gridArr[i].x = 180 + i * 50;
            }
            else if(len == 4)
            {
               this.gridArr[i].x = 125 + i * 50;
            }
            else if(len == 5)
            {
               this.gridArr[i].x = 120 + i * 46;
            }
            i++;
         }
         i = 0;
         while(i < len)
         {
            if(Boolean(this.gridArr[i]))
            {
               if(id != Enum_ActivityGuide.XIAOFEIHUIKUI)
               {
                  _type = int(arr[i][0]);
                  _id = int(arr[i][1]);
                  _count = int(arr[i][2]);
                  if(id == Enum_ActivityGuide.DENGLUYOULI)
                  {
                     isAddEff = int(arr[i][3]);
                     if(isAddEff == 1)
                     {
                        EffectManager.addEffect("35176",this.gridArr[i],1200,17,18,true);
                     }
                  }
               }
               else
               {
                  _type = int(itemArr[i][0]);
                  _id = int(itemArr[i][1]);
                  _count = int(itemArr[i][2]);
               }
               if(_type == Enum_NationalTreasure.ITEM)
               {
                  _voI = new Vo_item();
                  _voI.id = _id;
                  _voI.Init_lib();
                  _voI.count = _count;
                  (this.gridArr[i] as View_Grid).vo = _voI;
               }
               else if(_type == Enum_NationalTreasure.EQUIP)
               {
                  _voE = new Vo_equip();
                  _voE.id = _id;
                  _voE.Init_lib();
                  _voE.count = _count;
                  (this.gridArr[i] as View_Grid).vo = _voE;
               }
               this.gridArr[i].visible = true;
            }
            i++;
         }
      }
      
      public function flyIcon() : void
      {
         var i:int = 0;
         while(i < this.gridArr.length)
         {
            if(Boolean(this.gridArr[i]))
            {
               ComboTweenStep.toBag(this.gridArr[i]);
            }
            i++;
         }
      }
   }
}

