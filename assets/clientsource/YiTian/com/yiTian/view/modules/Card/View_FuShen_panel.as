package com.yiTian.view.modules.Card
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CardCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_FuShen_panel extends Sprite
   {
      
      private static var _instance:View_FuShen_panel;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      private var bagTxt:MyTextField;
      
      private var _curPage:int;
      
      private const _totalPage:int = 20;
      
      public var bagCardArr:Array;
      
      private var FenJieBtn:Button;
      
      private var YiJianFenJieBtn:Button;
      
      private var _mouseFlag:int;
      
      private var mouseFenJieBm:Bitmap;
      
      private var needCheckBox:Boolean = true;
      
      private var mouseUpSpr1:Sprite;
      
      private var mouseUpSpr2:Sprite;
      
      private var totalAttributeBtn:Button;
      
      private var setTimeOutID:Array = [];
      
      private var playID:int = 0;
      
      private var vo_tips:Vo_cardTotalAttribute;
      
      public function View_FuShen_panel()
      {
         super();
         this.initStaticView();
      }
      
      public static function get instance() : View_FuShen_panel
      {
         if(!_instance)
         {
            _instance = new View_FuShen_panel();
         }
         return _instance;
      }
      
      private function initStaticView() : void
      {
         var j:int = 0;
         var card:View_card_small = null;
         this.mouseUpSpr1 = new Sprite();
         addChild(this.mouseUpSpr1);
         this.mouseUpSpr1.addEventListener(MouseEvent.MOUSE_UP,this.onDragToEquip);
         this.mouseUpSpr2 = new Sprite();
         addChild(this.mouseUpSpr2);
         this.mouseUpSpr2.addEventListener(MouseEvent.MOUSE_UP,this.onUndressCard);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.mouseUpSpr2,{
            "x":30,
            "y":233,
            "width":706,
            "height":288
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.mouseUpSpr2,{
            "x":354,
            "y":526,
            "width":58,
            "height":18
         },Global.Img_Cdm);
         this.prevBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":329,
            "y":525,
            "textColor":16771436
         },Global.Img_Cdm);
         this.prevBtn.callBack = this.onPrevBtn;
         this.nextBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":417,
            "y":525,
            "textColor":16771436
         },Global.Img_Cdm);
         this.nextBtn.callBack = this.onNextBtn;
         this.bagTxt = ComponentUtil.getTextField("背包容量：0/200",this,{
            "x":39,
            "y":525,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.pageTxt = ComponentUtil.getTextField("1/1",this,{
            "x":382,
            "y":525,
            "color":14662240,
            "size":12,
            "leading":0
         },"center");
         ComponentUtil.getBitmap("Back_KPBTD",this.mouseUpSpr2,{
            "x":31,
            "y":234
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_KPBB",this.mouseUpSpr2,{
            "x":350,
            "y":235
         },Global.KaPaidm);
         this.bagCardArr = [];
         var k:int = 0;
         while(k < 10)
         {
            ComponentUtil.getBitmap("Back_XiaoKKP",this.mouseUpSpr2,{
               "x":39 + k % 5 * 140,
               "y":258 + Math.floor(k / 5) * 130
            },Global.KaPaidm);
            k++;
         }
         j = 0;
         while(j < 10)
         {
            card = new View_card_small(true);
            this.mouseUpSpr2.addChild(card);
            card.x = 39 + j % 5 * 140;
            card.y = 258 + Math.floor(j / 5) * 130;
            card.visible = false;
            this.bagCardArr.push(card);
            card.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDragCard);
            card.addEventListener(CardEvent.CLICK,this.onClickCard);
            card.addEventListener(CardEvent.LOCK,this.onLock);
            j++;
         }
         this.curPage = 1;
         this.mouseFenJieBm = ComponentUtil.getBitmap("MouseFenJie",null,null,Global.KaPaidm);
         this.FenJieBtn = ComponentUtil.getButton("","Button_FenJie",this,{
            "x":542,
            "y":516,
            "textColor":16771436
         },Global.KaPaidm);
         this.FenJieBtn.callBack = this.onClickFenJie;
         this.YiJianFenJieBtn = ComponentUtil.getButton("","Button_YJFJ",this,{
            "x":625,
            "y":514,
            "textColor":16771436
         },Global.KaPaidm);
         this.YiJianFenJieBtn.callBack = this.onClickYiJianFenJie;
         this.totalAttributeBtn = ComponentUtil.getButton("","Button_KPZSX",this,{
            "x":658,
            "y":69,
            "textColor":16771436
         },Global.KaPaidm);
         this.totalAttributeBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverTips);
         this.totalAttributeBtn.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutTips);
         this.onUpdateTips();
         Global.control.registerCallBack(CardEvent.UPDATE_BAG,this.onUpdateBag);
         Global.control.registerCallBack(CardEvent.TOTAL_ATTRIBUTE,this.onUpdateTips);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            CardCGMessage.CG_CARD_TOTAL_ATTIBUTE();
            this.updatePanel();
            this.allCardMove();
         }
      }
      
      private function onStartDragCard(e:MouseEvent) : void
      {
         if(e.target == e.currentTarget.lockSpr)
         {
            return;
         }
         if(this.mouseFlag == 0)
         {
            Model_card.dragType = 1;
            Model_card.dragCardGridID = this.bagCardArr.indexOf(e.currentTarget) + (this.curPage - 1) * 10;
            Global.control.sendNotification(CardEvent.START_DRAG,e.currentTarget.vo);
         }
      }
      
      private function onUndressCard(e:MouseEvent) : void
      {
         if(Model_card.dragType == 2)
         {
            if(Model_card.bagCardVoArray.length >= 200)
            {
               UIManager.centerBroadcast.addMsg("卡牌背包已满",1);
               return;
            }
            CardCGMessage.CG_CARD_EQUIP(2,Model_card.dragCardGridID);
         }
         Model_card.dragType = 0;
      }
      
      private function onDragToEquip(e:MouseEvent) : void
      {
         var i:* = undefined;
         if(Model_card.dragType == 1)
         {
            if(Model_card.equipCardVoArray.length >= Model_card.equipGridOpen)
            {
               UIManager.centerBroadcast.addMsg("出战卡牌已满，请先取下出战卡牌或者开启新的卡牌槽",1);
               return;
            }
            for(i in View_equipCardListItem.instance.equipArr)
            {
               if(Model_card.dragCard.type == View_equipCardListItem.instance.equipArr[i].type)
               {
                  UIManager.centerBroadcast.addMsg("不能同时装备2个同种卡牌",1);
                  return;
               }
            }
            CardCGMessage.CG_CARD_EQUIP(1,Model_card.dragCardGridID);
         }
         Model_card.dragType = 0;
      }
      
      private function onClickFenJie(e:MouseEvent) : void
      {
         this.mouseFlag = 1;
      }
      
      private function onClickYiJianFenJie(e:MouseEvent) : void
      {
         var arr:Array;
         var t_arr:Array;
         var len:int;
         var exp:int;
         var SuiPian:int;
         var str:String;
         var i:int;
         var j:* = undefined;
         var card:Vo_card = null;
         var card1:Vo_card = null;
         var LeiJi:int = 0;
         var lv:int = 0;
         this.mouseFlag = 0;
         if(Model_card.bagCardVoArray.length == 0)
         {
            UIManager.centerBroadcast.addMsg("已没有卡牌可供分解");
            return;
         }
         arr = Model_card.bagCardVoArray.concat();
         arr.sortOn("color");
         t_arr = arr.filter(this.checkLock);
         if(t_arr.length == 0)
         {
            UIManager.centerBroadcast.addMsg("卡牌已锁，请先解锁",1);
            return;
         }
         len = int(t_arr.length);
         exp = 0;
         SuiPian = 0;
         str = "";
         i = len - 1;
         while(i > len - 4 && i >= 0)
         {
            card = t_arr[i] as Vo_card;
            str += HtmlUtil.fontNoSize(Data_lib.card[card.id][2],ColorConstant.getItemColorStr(Data_lib.card[card.id][4]));
            if(i > len - 3 && i > 0)
            {
               str += "/";
            }
            i--;
         }
         if(len > 3)
         {
            str += "等";
         }
         for(j in t_arr)
         {
            card1 = t_arr[j] as Vo_card;
            LeiJi = 0;
            lv = 1;
            while(lv < card1.level)
            {
               LeiJi += Data_lib.cardLevel[lv][card1.color - 1];
               lv++;
            }
            exp += Data_lib.cardDestroy[card1.id][1] + card1.exp + LeiJi;
            SuiPian += Data_lib.cardDestroy[card1.id][2];
         }
         View_Alert.show(HtmlUtil.fontNoSize("确定要分解" + str + "获得" + HtmlUtil.fontNoSize(String(exp),ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.fontNoSize("卡牌经验",ColorConstant.getColorStr(ColorConstant.GREEN)) + (SuiPian > 0 ? "和" + HtmlUtil.fontNoSize(String(SuiPian),ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.fontNoSize("卡牌残页",ColorConstant.getColorStr(ColorConstant.GREEN)) : "") + "吗？",ColorConstant.getColorStr(ColorConstant.WHITE)),2,function():void
         {
            CardCGMessage.CG_CARD_FenJie(2,2,0);
         },null,null,null,310,"","","center");
      }
      
      private function checkLock(item:*, index:int, array:Array) : Boolean
      {
         if(item.lock == 0)
         {
            return true;
         }
         return false;
      }
      
      private function updatePanel() : void
      {
         this.mouseUpSpr1.addChild(View_equipCardListItem.instance);
         Model_card.canUndress = true;
         this.onUpdateBag();
      }
      
      private function onClickCard(e:CardEvent) : void
      {
         var card:View_card_small = null;
         var LeiJi:int = 0;
         var lv:int = 0;
         card = e.card;
         switch(this.mouseFlag)
         {
            case 1:
               if(card.lock == 1)
               {
                  UIManager.centerBroadcast.addMsg("卡牌已锁，请先解锁",1);
                  return;
               }
               if(card.color > 2 && this.needCheckBox)
               {
                  LeiJi = 0;
                  lv = 1;
                  while(lv < card.level)
                  {
                     LeiJi += Data_lib.cardLevel[lv][card.color - 1];
                     lv++;
                  }
                  View_Alert.show(HtmlUtil.fontNoSize("确定要分解" + HtmlUtil.fontNoSize(Data_lib.card[card.id][2],ColorConstant.getItemColorStr(Data_lib.card[card.id][4])) + "获得" + HtmlUtil.fontNoSize(String(Data_lib.cardDestroy[card.id][1] + card.exp + LeiJi),ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.fontNoSize("卡牌经验",ColorConstant.getColorStr(ColorConstant.GREEN)) + (Data_lib.cardDestroy[card.id][2] > 0 ? "和" + HtmlUtil.fontNoSize(String(Data_lib.cardDestroy[card.id][2]),ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.fontNoSize("卡牌残页",ColorConstant.getColorStr(ColorConstant.GREEN)) : "") + "吗？",ColorConstant.getColorStr(ColorConstant.WHITE)),2,function():void
                  {
                     CardCGMessage.CG_CARD_FenJie(2,1,bagCardArr.indexOf(card) + (curPage - 1) * 10);
                  },function():void
                  {
                     needCheckBox = true;
                  },null,null,340,"","","center",this.needCheckBox);
                  View_Alert.instance.showCheckBox = function():void
                  {
                     needCheckBox = !needCheckBox;
                  };
                  break;
               }
               CardCGMessage.CG_CARD_FenJie(2,1,this.bagCardArr.indexOf(card) + (this.curPage - 1) * 10);
         }
      }
      
      public function get mouseFlag() : int
      {
         return this._mouseFlag;
      }
      
      public function set mouseFlag(value:int) : void
      {
         var point:Point = null;
         this._mouseFlag = value;
         switch(this._mouseFlag)
         {
            case 0:
               Mouse.show();
               if(Boolean(this.mouseFenJieBm.stage))
               {
                  this.mouseFenJieBm.parent.removeChild(this.mouseFenJieBm);
               }
               removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
               removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
               break;
            case 1:
               Mouse.hide();
               GameScene.instance.addChild(this.mouseFenJieBm);
               point = localToGlobal(new Point(mouseX,mouseY));
               this.mouseFenJieBm.x = point.x;
               this.mouseFenJieBm.y = point.y;
               addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
               addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         }
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         this.mouseFlag = 0;
      }
      
      private function onMouseMove(e:MouseEvent) : void
      {
         var point:Point = null;
         if(this.mouseFlag == 1)
         {
            point = localToGlobal(new Point(mouseX,mouseY));
            this.mouseFenJieBm.x = point.x;
            this.mouseFenJieBm.y = point.y;
         }
      }
      
      public function get curPage() : int
      {
         return this._curPage;
      }
      
      public function set curPage(value:int) : void
      {
         this._curPage = value;
         this.pageTxt.text = this.curPage + "/" + this._totalPage;
         this.setArrowBtn();
         this.setCurPage();
         this.allCardMove();
      }
      
      private function setArrowBtn() : void
      {
         if(this.curPage == this._totalPage)
         {
            this.nextBtn.enabled = false;
         }
         else
         {
            this.nextBtn.enabled = true;
         }
         if(this.curPage == 1)
         {
            this.prevBtn.enabled = false;
         }
         else
         {
            this.prevBtn.enabled = true;
         }
      }
      
      private function onPrevBtn(e:MouseEvent) : void
      {
         --this.curPage;
      }
      
      private function onNextBtn(e:MouseEvent) : void
      {
         ++this.curPage;
      }
      
      private function onUpdateBag() : void
      {
         this.bagTxt.text = "背包容量：" + Model_card.bagCardVoArray.length + "/" + this._totalPage * 10;
         this.setCurPage();
      }
      
      private function onUpdateTips() : void
      {
         this.vo_tips = new Vo_cardTotalAttribute();
         var len:int = int(Model_card.totalAttribute.length);
         var i:int = 0;
         while(i < len)
         {
            this.vo_tips.attributeArr[i] = [];
            this.vo_tips.attributeArr[i].push(Model_card.totalAttribute[i][0]);
            this.vo_tips.attributeArr[i].push(Model_card.totalAttribute[i][1]);
            this.vo_tips.attributeArr[i].push(Model_card.totalAttribute[i][2]);
            i++;
         }
      }
      
      private function setCurPage() : void
      {
         var index:int = 0;
         var i:int = 0;
         while(i < 10)
         {
            index = (this.curPage - 1) * 10 + i;
            if(Boolean(Model_card.bagCardVoArray[index]))
            {
               this.bagCardArr[i].visible = true;
               this.bagCardArr[i].vo = Model_card.bagCardVoArray[index];
            }
            else
            {
               this.bagCardArr[i].visible = false;
            }
            i++;
         }
      }
      
      private function allCardMove() : void
      {
         while(Boolean(this.setTimeOutID.length))
         {
            clearTimeout(this.setTimeOutID.pop());
         }
         var i:int = 0;
         while(i < 10)
         {
            Tween.stop(this.bagCardArr[i]);
            this.bagCardArr[i].alpha = 0;
            this.setTimeOutID.push(setTimeout(this.cardMove,i * 100,i));
            i++;
         }
      }
      
      private function cardMove(id:int) : void
      {
         Tween.to(this.bagCardArr[id],500,{
            "x":[599,39 + id % 5 * 140],
            "alpha":[0,1]
         },this.checkMove);
      }
      
      private function checkMove() : void
      {
         if(++this.playID == 10)
         {
            this.playID = 0;
         }
      }
      
      private function onRollOverTips(e:MouseEvent) : void
      {
         TipManager.update(this.vo_tips);
      }
      
      private function onRollOutTips(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      private function onLock(e:CardEvent) : void
      {
         var index:int = Model_card.bagCardVoArray.indexOf(e.card.vo);
         trace("背包上锁ID",index);
         if(index != -1)
         {
            CardCGMessage.CG_CARD_LOCK(index,2);
         }
      }
   }
}

