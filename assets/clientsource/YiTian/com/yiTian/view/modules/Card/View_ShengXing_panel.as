package com.yiTian.view.modules.Card
{
   import com.ui.controls.Button;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CardCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_ShengXing_panel extends Sprite
   {
      
      private var selectBtn:Button;
      
      private var ShengXingBtn:Button;
      
      private var curCard:View_card;
      
      private var nextCard:View_card;
      
      private var selectGridID:int;
      
      private var ShengXingVo:Vo_card;
      
      private var materialSpr:Sprite;
      
      private var materialCardArr:Array;
      
      private var matchCardVoArray:Array = [];
      
      private var autoMatchCardVoArray:Array = [];
      
      private var checkVoID:int;
      
      private var checkVoStar:int;
      
      private var checkVoCount:int;
      
      private var ShengXingType:int;
      
      private var successCardArr:Array;
      
      private var playEffCount:int;
      
      private var isPlaying:Boolean;
      
      private var selectingGridID:int = -1;
      
      private var selectMaterial:Boolean;
      
      public function View_ShengXing_panel()
      {
         super();
         this.initStaticView();
      }
      
      private function initStaticView() : void
      {
         var i:int = 0;
         var card:View_card_small = null;
         ComponentUtil.getBitmap("Back_KPTS",this,{
            "x":29,
            "y":232
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_SXWZD",this,{
            "x":31,
            "y":234
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_KKP",this,{
            "x":38,
            "y":304
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_KPLD",this,{
            "x":534,
            "y":290
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_KKP",this,{
            "x":549,
            "y":304
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_SHQKP",this,{
            "x":79,
            "y":242
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_SXHKP",this,{
            "x":595,
            "y":242
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_SXXH",this,{
            "x":355,
            "y":242
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_SXHK",this,{
            "x":253,
            "y":271
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_XiaoKKP",this,{
            "x":262,
            "y":279
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_XiaoKKP",this,{
            "x":262,
            "y":409
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_XiaoKKP",this,{
            "x":392,
            "y":279
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_XiaoKKP",this,{
            "x":392,
            "y":409
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_XZKP",this,{
            "x":77,
            "y":362
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Icon_KPJH",this,{
            "x":213,
            "y":387
         },Global.KaPaidm);
         this.materialSpr = new Sprite();
         addChild(this.materialSpr);
         this.materialSpr.mouseEnabled = false;
         this.materialSpr.x = 262;
         this.materialSpr.y = 279;
         this.nextCard = new View_card();
         addChild(this.nextCard);
         this.nextCard.x = 549;
         this.nextCard.y = 304;
         this.materialCardArr = [];
         i = 0;
         while(i < 4)
         {
            card = new View_card_small();
            this.materialSpr.addChild(card);
            card.x = i % 2 * 130;
            card.y = Math.floor(i / 2) * 130;
            card.buttonMode = true;
            card.addEventListener(CardEvent.CLICK,this.onSelectMaterialCard);
            this.materialCardArr.push(card);
            i++;
         }
         this.curCard = new View_card();
         addChild(this.curCard);
         this.curCard.x = 38;
         this.curCard.y = 304;
         this.selectBtn = ComponentUtil.getButton("","Button_HKP",this,{
            "x":177,
            "y":296,
            "textColor":16771436
         },Global.KaPaidm);
         this.selectBtn.callBack = this.openBag;
         this.ShengXingBtn = ComponentUtil.getButton("","Button_ShengXing",this,{
            "x":366,
            "y":384,
            "textColor":16771436
         },Global.KaPaidm);
         this.ShengXingBtn.callBack = this.onShengXing;
         Global.control.registerCallBack(CardEvent.BAG_PANEL_SELECT_CARD,this.onSelectCard);
         Global.control.registerCallBack(CardEvent.EQUIP_PANEL_SELECT_CARD,this.onSelectMainCard);
         Global.control.registerCallBack(CardEvent.ShengXing_CARD_SUCCESS,this.onShengXingCardSuccess);
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
            this.selectMaterial = false;
         }
      }
      
      private function updatePanel() : void
      {
         Model_card.canUndress = false;
         addChild(View_equipCardListItem.instance);
         this.curCard.visible = false;
         this.nextCard.visible = false;
         this.materialSpr.visible = false;
         this.ShengXingBtn.enabled = false;
      }
      
      private function openBag(e:MouseEvent) : void
      {
         if(this.isPlaying)
         {
            return;
         }
         View_cardBag_panel.instance.visible = true;
         this.selectMaterial = false;
      }
      
      private function onSelectCard(arr:Array) : void
      {
         var vo:Vo_card = null;
         if(!this.visible || this.isPlaying)
         {
            return;
         }
         if(this.selectMaterial)
         {
            vo = arr[0];
            if(this.autoMatchCardVoArray.indexOf(vo) != -1 || vo === this.ShengXingVo)
            {
               UIManager.centerBroadcast.addMsg("此材料已选定，请选择其他材料",1);
            }
            else if(this.matchCardVoArray.indexOf(vo) == -1)
            {
               UIManager.centerBroadcast.addMsg("此卡牌不能作为升星材料，请选择适合的材料",1);
            }
            else
            {
               this.selectMaterial = false;
               View_cardBag_panel.instance.visible = false;
               this.materialCardArr[this.selectingGridID].vo = vo;
               this.autoMatchCardVoArray[this.selectingGridID] = vo;
               this.setNextCard();
            }
         }
         else
         {
            this.onSelectMainCard(arr);
         }
      }
      
      private function onSelectMainCard(arr:Array) : void
      {
         var vo:Vo_card = null;
         if(!this.visible || this.isPlaying)
         {
            return;
         }
         vo = arr[0];
         this.selectGridID = arr[1];
         this.ShengXingType = arr[2];
         this.ShengXingVo = vo;
         View_cardBag_panel.instance.visible = false;
         this.selectMaterial = false;
         this.curCard.vo = vo;
         this.curCard.visible = true;
         this.materialSpr.visible = true;
         if(vo.star >= 5)
         {
            UIManager.centerBroadcast.addMsg("此卡牌星级已满级，无法升星",1);
            this.setCardMaterial([]);
            this.nextCard.visible = false;
            this.ShengXingBtn.enabled = false;
            return;
         }
         this.checkMaterial();
         this.setNextCard();
      }
      
      private function setNextCard() : void
      {
         var i:* = undefined;
         var LeiJi:int = 0;
         var lv:int = 0;
         var vo2:Vo_card = this.ShengXingVo.clone();
         vo2.star += 1;
         var totalExp:int = 0;
         for(i in this.materialCardArr)
         {
            if(Boolean(this.materialCardArr[i].visible))
            {
               LeiJi = 0;
               lv = 1;
               while(lv < this.materialCardArr[i].level)
               {
                  LeiJi += Data_lib.cardLevel[lv][this.materialCardArr[i].color - 1];
                  lv++;
               }
               totalExp += this.materialCardArr[i].exp + LeiJi;
            }
         }
         totalExp += vo2.exp;
         while(vo2.level < Data_lib.cardLevel.getLength() && totalExp >= Data_lib.cardLevel[vo2.level][vo2.color - 1])
         {
            totalExp -= Data_lib.cardLevel[vo2.level][vo2.color - 1];
            vo2.level += 1;
         }
         if(vo2.level == Data_lib.cardLevel.getLength())
         {
            vo2.exp = 0;
         }
         else
         {
            vo2.exp = totalExp;
         }
         this.nextCard.vo = vo2;
         this.nextCard.visible = true;
      }
      
      private function setCardMaterial(arr:Array) : void
      {
         var i:int = 0;
         while(i < 4)
         {
            if(Boolean(arr[i]))
            {
               this.materialCardArr[i].visible = true;
               this.materialCardArr[i].vo = arr[i];
            }
            else
            {
               this.materialCardArr[i].visible = false;
            }
            i++;
         }
      }
      
      private function checkMaterial() : void
      {
         var j:* = undefined;
         var vo_arr:Array = null;
         var i:* = undefined;
         var bagArray:Array = null;
         var itemArr:Array = null;
         var count:int = 0;
         var k:int = 0;
         var vo:Vo_card = null;
         var itrmArr2:Array = null;
         var lackCount:int = 0;
         var n:int = 0;
         var n1:int = 0;
         var t_materialVo:Vo_card = null;
         var itemArr2:Array = null;
         var t_arr1:Array = Data_lib.cardStar[this.curCard.id][8 + this.curCard.star * 2].split(",");
         var materialArr:Array = [];
         for(j in t_arr1)
         {
            itemArr = t_arr1[j].split("_");
            count = int(itemArr[2]);
            k = 0;
            while(k < count)
            {
               materialArr.push([int(itemArr[0]),int(itemArr[1])]);
               k++;
            }
         }
         vo_arr = [];
         for(i in materialArr)
         {
            vo = new Vo_card();
            vo.id = materialArr[i][0];
            vo.star = materialArr[i][1];
            vo.level = 1;
            vo_arr.push(vo);
            this.materialCardArr[i].dark = false;
         }
         this.setCardMaterial(vo_arr);
         bagArray = Model_card.bagCardVoArray.concat();
         if(this.ShengXingType == 2)
         {
            bagArray.splice(this.selectGridID,1);
         }
         bagArray = bagArray.filter(this.checkLock);
         var canShengXing:Boolean = true;
         this.autoMatchCardVoArray = [];
         var gridNum:int = int(t_arr1.length);
         var gridIndex:int = 0;
         var gridID:int = 0;
         while(gridID < gridNum)
         {
            itrmArr2 = t_arr1[gridID].split("_");
            this.checkVoID = itrmArr2[0];
            this.checkVoStar = itrmArr2[1];
            this.checkVoCount = itrmArr2[2];
            this.matchCardVoArray = bagArray.filter(this.callback);
            lackCount = this.checkVoCount - this.matchCardVoArray.length;
            if(lackCount > 0)
            {
               n = 0;
               while(n < lackCount)
               {
                  this.materialCardArr[gridIndex + this.checkVoCount - n - 1].dark = true;
                  n++;
               }
               canShengXing = false;
            }
            else
            {
               this.matchCardVoArray.sortOn(["level","exp"],[Array.NUMERIC,Array.NUMERIC]);
               n1 = 0;
               while(n1 < this.checkVoCount)
               {
                  t_materialVo = this.matchCardVoArray[n1];
                  this.materialCardArr[gridIndex + n1].vo = t_materialVo;
                  this.autoMatchCardVoArray.push(t_materialVo);
                  n1++;
               }
            }
            gridIndex += this.checkVoCount;
            gridID++;
         }
         if(canShengXing)
         {
            this.ShengXingBtn.enabled = true;
            if(Boolean(Data_lib.cardStar[this.curCard.id][9 + this.curCard.star * 2]))
            {
               itemArr2 = Data_lib.cardStar[this.curCard.id][9 + this.curCard.star * 2].split("_");
               TipManager.bind(this.ShengXingBtn,"升星需要" + HtmlUtil.fontNoSize(Data_lib.item[int(itemArr2[0])][1] + "*" + itemArr2[1],ColorConstant.getItemColorStr(Data_lib.item[int(itemArr2[0])][12])));
            }
            else
            {
               TipManager.unBind(this.ShengXingBtn);
            }
         }
         else
         {
            this.ShengXingBtn.enabled = false;
         }
      }
      
      private function onShengXing(e:MouseEvent) : void
      {
         var len:int;
         var i:int;
         var str:String = null;
         var index:int = 0;
         this.selectMaterial = false;
         View_cardBag_panel.instance.visible = false;
         str = "";
         len = int(this.autoMatchCardVoArray.length);
         i = 0;
         while(i < len)
         {
            index = Model_card.bagCardVoArray.indexOf(this.autoMatchCardVoArray[i]);
            str += String(index);
            if(i < len - 1)
            {
               str += "_";
            }
            i++;
         }
         trace("升星材料位置",str);
         View_Alert.show(HtmlUtil.fontNoSize("是否将" + HtmlUtil.fontNoSize(Data_lib.card[this.curCard.id][2],ColorConstant.getItemColorStr(this.curCard.color)) + "由" + HtmlUtil.fontNoSize(this.curCard.star + "星",ColorConstant.getColorStr(ColorConstant.YELLOW)) + "升为" + HtmlUtil.fontNoSize(this.curCard.star + 1 + "星",ColorConstant.getColorStr(ColorConstant.YELLOW)) + "？",ColorConstant.getColorStr(ColorConstant.WHITE)),2,function():void
         {
            CardCGMessage.CG_CARD_ShengXing(ShengXingType,selectGridID,str);
         });
      }
      
      private function onSelectMaterialCard(e:CardEvent) : void
      {
         View_cardBag_panel.instance.visible = true;
         this.selectingGridID = this.materialCardArr.indexOf(e.currentTarget);
         this.selectMaterial = true;
      }
      
      private function callback(item:*, index:int, array:Array) : Boolean
      {
         if(item.id == this.checkVoID && item.star == this.checkVoStar)
         {
            return true;
         }
         return false;
      }
      
      private function checkLock(item:*, index:int, array:Array) : Boolean
      {
         if(item.lock == 0)
         {
            return true;
         }
         return false;
      }
      
      private function onShengXingCardSuccess(arr:Array) : void
      {
         this.successCardArr = arr;
         this.ShengXingBtn.enabled = false;
         this.playEff();
      }
      
      private function playEff() : void
      {
         this.isPlaying = true;
         this.playEffCount = 0;
         Tween.curTo(this.curCard,1000,{
            "x":636,
            "y":416,
            "scaleX":0,
            "scaleY":0
         },this.playEffCom);
         Tween.curTo(this.materialSpr,1000,{
            "x":636,
            "y":416,
            "scaleX":0,
            "scaleY":0
         },this.playEffCom);
      }
      
      private function playEffCom() : void
      {
         ++this.playEffCount;
         if(this.playEffCount == 2)
         {
            this.curCard.x = 38;
            this.curCard.y = 304;
            this.curCard.scaleX = 1;
            this.curCard.scaleY = 1;
            this.curCard.visible = false;
            this.nextCard.visible = true;
            this.materialSpr.x = 262;
            this.materialSpr.y = 279;
            this.materialSpr.scaleX = 1;
            this.materialSpr.scaleY = 1;
            this.materialSpr.visible = false;
            this.isPlaying = false;
         }
      }
   }
}

