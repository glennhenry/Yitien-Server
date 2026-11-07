package com.yiTian.view.modules.Card
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CardCGMessage;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_TunShi_panel extends Sprite
   {
      
      private var selectBtn:Button;
      
      private var TunShiBtn:Button;
      
      private var YiJianTunShiBtn:Button;
      
      public var TunShiType:int;
      
      private var expSprite:Sprite;
      
      private var curNumberBmArray:Array;
      
      private var nextNumberBmArray:Array;
      
      private var curCard:View_card;
      
      private var nextCard:View_card;
      
      private var selectGridID:int;
      
      private var curTotalExpTxt:MyTextField;
      
      private var effArr:Array;
      
      private var effID:Array;
      
      public function View_TunShi_panel()
      {
         super();
         this.initStaticView();
      }
      
      private function initStaticView() : void
      {
         ComponentUtil.getBitmap("Back_KPTS",this,{
            "x":29,
            "y":232
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_JYQ",this,{
            "x":237,
            "y":235
         },Global.KaPaidm);
         var eff:Effect = EffectManager.addEffect("35153",this,1000,383,530,true);
         var sha:Shape = new Shape();
         sha.graphics.beginFill(0);
         sha.graphics.drawCircle(385,399,70);
         sha.graphics.endFill();
         addChild(sha);
         eff.mask = sha;
         ComponentUtil.getBitmap("Back_JYL",this,{
            "x":237,
            "y":235
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_KPLD",this,{
            "x":43,
            "y":273
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_KPLD",this,{
            "x":521,
            "y":273
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_KKP",this,{
            "x":57,
            "y":287
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_KKP",this,{
            "x":535,
            "y":287
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_DQKPJYK",this,{
            "x":302,
            "y":464
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_KPBTD",this,{
            "x":31,
            "y":70
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_XJXJSX",this,{
            "x":540,
            "y":240
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_DQXJSX",this,{
            "x":62,
            "y":240
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_XZKP",this,{
            "x":96,
            "y":352
         },Global.KaPaidm);
         this.expSprite = new Sprite();
         addChild(this.expSprite);
         this.expSprite.mouseEnabled = false;
         this.curCard = new View_card();
         addChild(this.curCard);
         this.curCard.x = 57;
         this.curCard.y = 287;
         this.nextCard = new View_card();
         addChild(this.nextCard);
         this.nextCard.x = 535;
         this.nextCard.y = 287;
         this.selectBtn = ComponentUtil.getButton("","Button_HKP",this,{
            "x":196,
            "y":279,
            "textColor":16771436
         },Global.KaPaidm);
         this.selectBtn.callBack = this.openBag;
         this.TunShiBtn = ComponentUtil.getButton("","Button_TunShu",this,{
            "x":255,
            "y":492,
            "textColor":16771436
         },Global.KaPaidm);
         this.TunShiBtn.callBack = this.onTunShi;
         TipManager.bind(this.TunShiBtn,"吞噬卡牌经验直接提升等级一级，若经验不够则吞噬所有经验");
         this.YiJianTunShiBtn = ComponentUtil.getButton("","Button_YJTS",this,{
            "x":397,
            "y":492,
            "textColor":16771436
         },Global.KaPaidm);
         this.YiJianTunShiBtn.callBack = this.onYiJianTunShi;
         TipManager.bind(this.YiJianTunShiBtn,"吞噬所有卡牌经验");
         ComponentUtil.getBitmap("KPGang",this.expSprite,{
            "x":377,
            "y":396
         },Global.KaPaidm);
         this.curNumberBmArray = [];
         this.nextNumberBmArray = [];
         this.curTotalExpTxt = ComponentUtil.getTextField("-1",this,{
            "x":411,
            "y":461,
            "color":16764206,
            "size":14,
            "leading":0
         });
         Global.control.registerCallBack(CardEvent.EXP,this.updateExp);
         Global.control.registerCallBack(CardEvent.BAG_PANEL_SELECT_CARD,this.onSelectCard);
         Global.control.registerCallBack(CardEvent.TunShi_CARD_SUCCESS,this.onTunShiSuccess);
         Global.control.registerCallBack(CardEvent.EQUIP_PANEL_SELECT_CARD,this.onSelectCard);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.updatePanel();
         }
         else
         {
            View_cardBag_panel.instance.visible = false;
         }
      }
      
      private function openBag(e:MouseEvent) : void
      {
         View_cardBag_panel.instance.visible = true;
      }
      
      private function updatePanel() : void
      {
         this.updateExp();
         Model_card.canUndress = false;
         addChild(View_equipCardListItem.instance);
         this.curCard.visible = false;
         this.nextCard.visible = false;
         this.expSprite.visible = false;
         this.selectGridID = 0;
         this.TunShiBtn.enabled = false;
         this.YiJianTunShiBtn.enabled = false;
      }
      
      private function updateExp() : void
      {
         this.curTotalExpTxt.text = String(Model_card.exp);
      }
      
      private function setCardExp(num1:int, num2:int) : void
      {
         var k:* = undefined;
         var numBm1:Bitmap = null;
         var numBm2:Bitmap = null;
         var str1:Array = num1.toString().split("");
         var str2:Array = num2.toString().split("");
         while(str1.length > this.curNumberBmArray.length)
         {
            numBm1 = new Bitmap();
            this.expSprite.addChild(numBm1);
            numBm1.x = 364 - this.curNumberBmArray.length * 13;
            numBm1.y = 396;
            this.curNumberBmArray.unshift(numBm1);
         }
         while(str2.length > this.nextNumberBmArray.length)
         {
            numBm2 = new Bitmap();
            this.expSprite.addChild(numBm2);
            numBm2.x = 390 + this.nextNumberBmArray.length * 13;
            numBm2.y = 396;
            this.nextNumberBmArray.push(numBm2);
         }
         var len1:int = int(this.curNumberBmArray.length);
         var len2:int = int(str1.length);
         var i:int = len1 - 1;
         var j:int = len2 - 1;
         while(i >= 0)
         {
            if(j < 0)
            {
               this.curNumberBmArray[i].bitmapData = null;
            }
            else
            {
               this.curNumberBmArray[i].bitmapData = ComponentUtil.getBitmapData("KP_" + str1[j],Global.KaPaidm);
            }
            i--;
            j--;
         }
         for(k in this.nextNumberBmArray)
         {
            if(Boolean(str2[k]))
            {
               this.nextNumberBmArray[k].bitmapData = ComponentUtil.getBitmapData("KP_" + str2[k],Global.KaPaidm);
            }
            else
            {
               this.nextNumberBmArray[k].bitmapData = null;
            }
         }
      }
      
      private function onSelectCard(arr:Array) : void
      {
         var vo:Vo_card = null;
         if(!this.visible)
         {
            return;
         }
         View_cardBag_panel.instance.visible = false;
         vo = arr[0];
         this.curCard.vo = vo;
         this.curCard.visible = true;
         this.selectGridID = arr[1];
         trace("选择格子ID：",this.selectGridID);
         this.TunShiType = arr[2];
         this.expSprite.visible = true;
         if(vo.level + 1 > Data_lib.cardStar[vo.id][vo.star + 4])
         {
            UIManager.centerBroadcast.addMsg("当前卡牌已满级",1);
            this.setCardExp(vo.exp,Data_lib.cardLevel[vo.level - 1][vo.color - 1]);
            this.TunShiBtn.enabled = false;
            this.YiJianTunShiBtn.enabled = false;
            this.nextCard.visible = false;
            return;
         }
         this.setCardExp(vo.exp,Data_lib.cardLevel[vo.level][vo.color - 1]);
         var vo2:Vo_card = vo.clone();
         vo2.level += 1;
         vo2.exp = 0;
         this.nextCard.vo = vo2;
         this.nextCard.visible = true;
         this.TunShiBtn.enabled = true;
         this.YiJianTunShiBtn.enabled = true;
      }
      
      private function onTunShi(e:MouseEvent) : void
      {
         if(Model_card.exp <= 0)
         {
            UIManager.centerBroadcast.addMsg("剩余卡牌经验不足，不能吞噬",1);
         }
         else
         {
            CardCGMessage.CG_CARD_TunShi(this.TunShiType,1,this.selectGridID);
         }
      }
      
      private function onYiJianTunShi(e:MouseEvent) : void
      {
         if(Model_card.exp <= 0)
         {
            UIManager.centerBroadcast.addMsg("剩余卡牌经验不足，不能吞噬",1);
         }
         else
         {
            CardCGMessage.CG_CARD_TunShi(this.TunShiType,2,this.selectGridID);
         }
      }
      
      private function onTunShiSuccess(arr:Array) : void
      {
         var vo:Vo_card = this.curCard.vo.clone();
         vo.level = arr[1];
         vo.exp = arr[2];
         this.onSelectCard([vo,this.selectGridID,this.TunShiType]);
         this.playEff();
      }
      
      private function playEff() : void
      {
         var j:* = undefined;
         var i:int = 0;
         var effSpr:Sprite = null;
         if(!this.effArr)
         {
            this.effArr = [];
            this.effID = [];
            i = 0;
            while(i < 20)
            {
               effSpr = new Sprite();
               addChild(effSpr);
               effSpr.visible = false;
               EffectManager.addEffect("35040",effSpr,500,0,67,true);
               this.effArr.push(effSpr);
               effSpr.x = 385;
               effSpr.y = 400;
               i++;
            }
         }
         for(j in this.effArr)
         {
            Tween.stop(this.effArr[j]);
            clearTimeout(this.effID[j]);
            this.effID.push(setTimeout(this.effMove,j * 100,j));
         }
      }
      
      private function effMove(id:int) : void
      {
         this.effArr[id].visible = true;
         Tween.to(this.effArr[id],500,{
            "x":[335 + Math.random() * 100,600 + Math.random() * 40],
            "y":[350 + Math.random() * 100,380 + Math.random() * 40]
         },function():void
         {
            effArr[id].visible = false;
         });
      }
   }
}

