package com.yiTian.view.modules.farm
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_treasureChest;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.FarmGuideManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class View_treasureChest extends Panel
   {
      
      private static var nowGrid:View_Grid;
      
      private static var isLoad:Boolean = false;
      
      public static var _curPage:int = 1;
      
      private var hero_silver:MyTextField;
      
      public var itemArr:Array = [];
      
      private var heroMoney:int;
      
      private var remarks:MyTextField;
      
      public var guidePoint:Shape;
      
      public var _totalPage:int;
      
      public function View_treasureChest()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":595,
            "height":449
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":60,
            "width":547,
            "height":379
         },Global.Img_Cdm);
         move = new Rectangle(0,0,459,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":561,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.remarks = ComponentUtil.getTextField(LangConfig.getWord("64",9),this,{
            "x":410,
            "y":38,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("188",9),this,{
            "x":34,
            "y":38,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.guidePoint = new Shape();
         this.addChild(this.guidePoint);
         this.guidePoint.x = CloseButton.x;
         this.guidePoint.y = CloseButton.y;
      }
      
      override protected function initDynamicView() : void
      {
         CloseButton.callBack = this.onCloseButton;
      }
      
      private function onCloseButton(evt:MouseEvent) : void
      {
         this.visible = false;
         FarmGuideManager.instance.nextStep(5);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!isLoad)
            {
               this.showTl();
               this.heroMoney = GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver;
               this.initData();
               isLoad = true;
            }
            else
            {
               this.update();
               FarmGuideManager.instance.nextStep(2);
            }
         }
         else if(Boolean(UIManager.buySeed))
         {
            UIManager.buySeed.visible = false;
         }
      }
      
      public function initData() : void
      {
         this.initItem();
         this.update();
         FarmGuideManager.instance.nextStep(2);
      }
      
      private function initItem() : void
      {
         var i:int = 0;
         var shopItem:View_farmShop_Item = null;
         this.hero_silver = ComponentUtil.getTextField("00000000000",this,{
            "x":75,
            "y":38,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.hero_silver.text = this.heroMoney.toString();
         i = 0;
         while(i < 8)
         {
            shopItem = new View_farmShop_Item();
            addChild(shopItem);
            shopItem.x = 33 + 267 * (i % 2);
            shopItem.y = 68 + 92 * Math.floor(i / 2);
            this.itemArr.push(shopItem);
            shopItem.visible = false;
            shopItem = null;
            i++;
         }
      }
      
      public function updateMoney(silver:int) : void
      {
         this.heroMoney = int(silver);
         if(UIManager.treasureChest.visible)
         {
            this.update();
         }
      }
      
      public function updataBingSilver(bingSilver:int) : void
      {
      }
      
      private function showTl() : void
      {
         ComponentUtil.getBitmap("Title_SZStore",this,{
            "x":216,
            "y":5
         },Global.ShanZhuang_Imgsdm);
      }
      
      public function update() : void
      {
         var i:int = 0;
         while(i < this.itemArr.length)
         {
            this.itemArr[i].visible = false;
            i++;
         }
         if(!this.hero_silver)
         {
            return;
         }
         this.hero_silver.visible = true;
         this.hero_silver.text = this.heroMoney.toString();
         this.init_ST_data();
      }
      
      private function init_ST_data(selectedID:int = 0) : void
      {
         var i:int = 0;
         var temData:View_farmShop_Item = null;
         var j:int = 0;
         var temItem:Vo_item = null;
         var comboxArr:Array = [];
         Model_treasureChest.instance;
         i = 0;
         while(i < 8)
         {
            temData = this.itemArr[i];
            temData.visible = true;
            selectedID = int(Model_treasureChest.storeSeedList[i][0].seed_id);
            if(Boolean(Model_treasureChest.dic1[1]) && Boolean(Model_treasureChest.dic1[1][i + 1]))
            {
               selectedID = int(Model_treasureChest.dic1[1][i + 1].id);
            }
            temData.buy_Button.label = LangConfig.getWord("56",9);
            j = 0;
            while(j < Model_treasureChest.storeSeedList[i].length)
            {
               temItem = new Vo_item();
               temItem.id = Model_treasureChest.storeSeedList[i][j].seed_id;
               temItem.Init_lib();
               temData.grid.vo = temItem;
               comboxArr.push([temItem.str_name,temItem.id]);
               j++;
            }
            temData.buy_Button.addEventListener(MouseEvent.CLICK,this.buyHandle);
            temData.update(comboxArr,selectedID);
            comboxArr = [];
            temData.buy_Button.textColor = 3394713;
            i++;
         }
      }
      
      private function shopGoods(selectedID:int) : void
      {
         var LstemData:View_farmShop_Item = null;
         var j:int = 0;
         var LstemItem:Vo_item = null;
         var comboxArr:Array = [];
         var temN:int = Model_treasureChest.storeSeedList.length % 6 + 6 * int(Model_treasureChest.storeSeedList.length % 6 == 0);
         var i:int = 0;
         while(i < temN)
         {
            LstemData = this.itemArr[i];
            selectedID = int(Model_treasureChest.storeSeedList[i + (_curPage - 1) * 6][0].seed_id);
            if(Boolean(Model_treasureChest.dic1[_curPage]) && Boolean(Model_treasureChest.dic1[_curPage][i + 1]))
            {
               selectedID = int(Model_treasureChest.dic1[_curPage][i + 1].id);
            }
            LstemData.buy_Button.label = LangConfig.getWord("56",9);
            LstemData.visible = true;
            LstemData.buy_Button.textColor = 3394713;
            LstemData.buy_Button.addEventListener(MouseEvent.CLICK,this.buyHandle);
            j = 0;
            while(j < Model_treasureChest.storeSeedList[i + (_curPage - 1) * 6].length)
            {
               LstemItem = new Vo_item();
               LstemItem.id = Model_treasureChest.storeSeedList[i + (_curPage - 1) * 6][j].seed_id;
               LstemItem.Init_lib();
               LstemData.grid.vo = LstemItem;
               comboxArr.push([LstemItem.str_name,LstemItem.id]);
               j++;
            }
            LstemData.update(comboxArr,selectedID);
            comboxArr = [];
            i++;
         }
      }
      
      public function buyHandle(e:MouseEvent = null) : void
      {
         var grid:View_Grid = null;
         grid = (e.target.parent as View_farmShop_Item).grid;
         nowGrid = grid;
         if(!UIManager.buySeed)
         {
            UIManager.buySeed = new View_buy_seed();
            UIManager.buySeed.init();
         }
         UIManager.buySeed.visible = true;
         UIManager.buySeed.update(nowGrid.vo,e.target.parent.price,e.target.parent._textColor,e.target.parent.gridId,_curPage,int(grid.name));
         UIManager.buySeed.parent.setChildIndex(UIManager.buySeed,UIManager.buySeed.parent.numChildren - 1);
         FarmGuideManager.instance.nextStep(3);
      }
      
      public function flyCartoon() : void
      {
         var p:Point = localToGlobal(new Point(this.itemArr[int(nowGrid.name) - 1].x,this.itemArr[int(nowGrid.name) - 1].y));
         Tween.gridToBagBezierFuncDef(this.itemArr[int(nowGrid.name) - 1].grid.vo,-1,p.x,p.y);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

