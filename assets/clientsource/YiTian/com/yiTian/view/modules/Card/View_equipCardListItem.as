package com.yiTian.view.modules.Card
{
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CardCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_equipCardListItem extends Sprite
   {
      
      private static var _instance:View_equipCardListItem;
      
      private var gridArr:Array;
      
      private var _equipArr:Array;
      
      public function View_equipCardListItem()
      {
         super();
         this.init();
      }
      
      public static function get instance() : View_equipCardListItem
      {
         if(!_instance)
         {
            _instance = new View_equipCardListItem();
         }
         return _instance;
      }
      
      private function init() : void
      {
         var i:int = 0;
         var grid:Sprite = null;
         var card:View_card_small = null;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":30,
            "y":69,
            "width":706,
            "height":160
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_KPBTD",this,{
            "x":31,
            "y":70
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_CZKP",this,{
            "x":350,
            "y":71
         },Global.KaPaidm);
         this.gridArr = [];
         this._equipArr = [];
         i = 0;
         while(i < 5)
         {
            ComponentUtil.getBitmap("Back_XiaoKKP",this,{
               "x":39 + i * 140,
               "y":95
            },Global.KaPaidm);
            grid = new Sprite();
            addChild(grid);
            grid.x = 39 + i * 140;
            grid.y = 95;
            grid.buttonMode = true;
            this.gridArr.push(grid);
            grid.addEventListener(MouseEvent.CLICK,this.onClickEquipCard);
            ComponentUtil.getBitmap("Back_XKGS",grid,{
               "x":24,
               "y":12
            },Global.KaPaidm);
            ComponentUtil.getTextField(Data_lib.cardOpenEquipGridCost[i + 1][0] + "级开启或\n花费" + Data_lib.cardOpenEquipGridCost[i + 1][1] + "\n元宝开启",grid,{
               "x":26,
               "y":35,
               "color":16764206,
               "size":14,
               "leading":3,
               "align":"center"
            });
            i++;
         }
         var j:int = 0;
         while(j < 5)
         {
            card = new View_card_small(true);
            addChild(card);
            card.x = 39 + j * 140;
            card.y = 95;
            card.addEventListener(CardEvent.LOCK,this.onLock);
            card.addEventListener(CardEvent.CLICK,this.onClickCard);
            card.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDragCard);
            this.equipArr.push(card);
            j++;
         }
         this.setFuShenGrid();
         this.updateEquipCard();
         Global.control.registerCallBack(CardEvent.EQUIP_GRID_OPEN,this.setFuShenGrid);
         Global.control.registerCallBack(CardEvent.UPDATE_EQUIP_CARD,this.updateEquipCard);
      }
      
      private function setFuShenGrid() : void
      {
         var i:* = undefined;
         for(i in this.gridArr)
         {
            if(i < Model_card.equipGridOpen)
            {
               this.gridArr[i].visible = false;
            }
            else
            {
               this.gridArr[i].visible = true;
            }
         }
      }
      
      private function updateEquipCard() : void
      {
         var i:int = 0;
         while(i < 5)
         {
            if(Boolean(Model_card.equipCardVoArray[i]))
            {
               this.equipArr[i].vo = Model_card.equipCardVoArray[i];
            }
            else
            {
               this.equipArr[i].vo = null;
            }
            i++;
         }
      }
      
      private function onClickCard(e:CardEvent) : void
      {
         if(e.card.lock == 1)
         {
            UIManager.centerBroadcast.addMsg("卡牌已锁，请先解锁",1);
            return;
         }
         Global.control.sendNotification(CardEvent.EQUIP_PANEL_SELECT_CARD,[e.card.vo,this.equipArr.indexOf(e.card),1]);
      }
      
      private function onStartDragCard(e:MouseEvent) : void
      {
         if(e.target == e.currentTarget.lockSpr)
         {
            return;
         }
         if(Model_card.canUndress && View_FuShen_panel.instance.mouseFlag == 0)
         {
            Model_card.dragType = 2;
            Model_card.dragCardGridID = this.equipArr.indexOf(e.currentTarget);
            Global.control.sendNotification(CardEvent.START_DRAG,e.currentTarget.vo);
         }
      }
      
      private function onClickEquipCard(e:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < Data_lib.cardOpenEquipGridCost[Model_card.equipGridOpen + 1][1])
         {
            UIManager.centerBroadcast.addMsg("元宝不足，无法开启卡牌槽",1);
            return;
         }
         View_Alert.show(HtmlUtil.fontNoSize("确定要花费" + HtmlUtil.fontNoSize(Data_lib.cardOpenEquipGridCost[Model_card.equipGridOpen + 1][1],ColorConstant.getColorStr(ColorConstant.YELLOW)) + "元宝来开启第" + (Model_card.equipGridOpen + 1) + "个卡牌槽吗？",ColorConstant.getColorStr(ColorConstant.WHITE)),2,function():void
         {
            CardCGMessage.CG_CARD_OPEN_EQUIP_GRID();
         });
      }
      
      public function get equipArr() : Array
      {
         return this._equipArr;
      }
      
      private function onLock(e:CardEvent) : void
      {
         var index:int = Model_card.equipCardVoArray.indexOf(e.card.vo);
         trace("卡槽上锁ID",index);
         if(index != -1)
         {
            CardCGMessage.CG_CARD_LOCK(index,1);
         }
      }
   }
}

