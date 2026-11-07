package com.yiTian.view.modules.Card
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_cardBag_panel extends Panel
   {
      
      private static var _instance:View_cardBag_panel;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      private var bagTxt:MyTextField;
      
      private var _curPage:int;
      
      private const _totalPage:int = 20;
      
      private var gridArr:Array;
      
      public function View_cardBag_panel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_cardBag_panel
      {
         if(!_instance)
         {
            _instance = new View_cardBag_panel();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var card:View_card_small = null;
         move = new Rectangle(0,0,749,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":749,
            "height":367
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":699,
            "height":318
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":675,
            "height":276
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Title_KPBB",this,{
            "x":294,
            "y":5
         },Global.KaPaidm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":346,
            "y":333,
            "width":58,
            "height":18
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":714,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.prevBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":321,
            "y":332,
            "textColor":16771436
         },Global.Img_Cdm);
         this.prevBtn.callBack = this.onPrevBtn;
         this.nextBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":409,
            "y":332,
            "textColor":16771436
         },Global.Img_Cdm);
         this.nextBtn.callBack = this.onNextBtn;
         this.pageTxt = ComponentUtil.getTextField("1/1",this,{
            "x":374,
            "y":332,
            "color":14662240,
            "size":12,
            "leading":0
         },"center");
         this.bagTxt = ComponentUtil.getTextField("背包容量：0/200",this,{
            "x":46,
            "y":333,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.gridArr = [];
         i = 0;
         while(i < 10)
         {
            ComponentUtil.getBitmap("Back_XiaoKKP",this,{
               "x":44 + i % 5 * 133,
               "y":59 + Math.floor(i / 5) * 133
            },Global.KaPaidm);
            card = new View_card_small(true);
            addChild(card);
            card.x = 44 + i % 5 * 133;
            card.y = 59 + Math.floor(i / 5) * 133;
            card.visible = false;
            this.gridArr.push(card);
            card.lockSpr.mouseEnabled = false;
            card.addEventListener(CardEvent.CLICK,this.onClickCard);
            i++;
         }
         this.curPage = 1;
         this.onUpdateBag();
         Global.control.registerCallBack(CardEvent.UPDATE_BAG,this.onUpdateBag);
      }
      
      private function onUpdateBag() : void
      {
         this.bagTxt.text = "背包容量：" + Model_card.bagCardVoArray.length + "/" + this._totalPage * 10;
         this.setCurPage();
      }
      
      private function onClickCard(e:CardEvent) : void
      {
         if(e.card.lock == 1)
         {
            UIManager.centerBroadcast.addMsg("此卡牌已锁定，请在卡牌附身面板解锁后再操作",1);
         }
         else
         {
            Global.control.sendNotification(CardEvent.BAG_PANEL_SELECT_CARD,[e.card.vo,this.gridArr.indexOf(e.card) + (this.curPage - 1) * 10,2]);
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
      
      private function setCurPage() : void
      {
         var index:int = 0;
         var i:int = 0;
         while(i < 10)
         {
            index = (this.curPage - 1) * 10 + i;
            if(Boolean(Model_card.bagCardVoArray[index]))
            {
               this.gridArr[i].visible = true;
               this.gridArr[i].vo = Model_card.bagCardVoArray[index];
            }
            else
            {
               this.gridArr[i].visible = false;
            }
            i++;
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
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - width;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

