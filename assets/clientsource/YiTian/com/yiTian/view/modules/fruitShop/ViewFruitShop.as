package com.yiTian.view.modules.fruitShop
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.vo.Vo_fruitShop;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.net.handler.FruitShopHandler;
   import com.yiTian.net.message.cg.FruitShopCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ViewFruitShop extends Panel123
   {
      
      private var SOURCE_URL:String = "lang/ch/SGSD.swf";
      
      public var check_item_id_1:int;
      
      public var check_item_id_2:int;
      
      public var check_item_id_3:int;
      
      private var titleBg:Bitmap;
      
      private var backBitmap:Bitmap;
      
      private var backLayer:Sprite;
      
      private var txtLayer:Sprite;
      
      private var dymLayer:Sprite;
      
      private var pageLeft:Button;
      
      private var pageRight:Button;
      
      private var pageTxt:MyTextField;
      
      private var xgTxt:MyTextField;
      
      private var liTxt:MyTextField;
      
      private var pgTxt:MyTextField;
      
      private var childContainer:Sprite;
      
      private var curPage:int = 1;
      
      private var maxPage:int;
      
      private var itemList:Array = [];
      
      public function ViewFruitShop()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.backLayer = new Sprite();
         addChild(this.backLayer);
         this.txtLayer = new Sprite();
         addChild(this.txtLayer);
         this.dymLayer = new Sprite();
         addChild(this.dymLayer);
         move = new Rectangle(0,38,808,70);
      }
      
      override protected function initUI2() : void
      {
         var temN:int;
         var matArr:Array;
         var childItem:Child_FruitShop = null;
         var i:int = 0;
         var idxNum:int = 0;
         var itemStrArr:Array = null;
         var itemID:int = 0;
         var vo:Vo_fruitShop = null;
         var itemVo:Vo_item = null;
         CloseButton = ComponentUtil.getButton("","BT_SGC",this,{
            "x":860,
            "y":70,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.fruitShop_Imgsdm);
         this.backBitmap = ComponentUtil.getBitmap("BG_SGSD",this.backLayer,{
            "x":268,
            "y":45
         },Global.fruitShop_Imgsdm);
         this.titleBg = ComponentUtil.getBitmap("Title_SG",this,{
            "x":504,
            "y":62
         },Global.fruitShop_Imgsdm);
         ComponentUtil.getBitmap("Text_DZZH",this,{
            "x":352,
            "y":98
         },Global.fruitShop_Imgsdm);
         this.pageLeft = ComponentUtil.getButton(" ","Button_PageL",this.dymLayer,{
            "x":530,
            "y":498,
            "textColor":16771436,
            "callBack":this.onPageHandler
         },Global.fruitShop_Imgsdm);
         this.pageRight = ComponentUtil.getButton(" ","Button_PageR",this.dymLayer,{
            "x":619,
            "y":498,
            "textColor":16771436,
            "callBack":this.onPageHandler
         },Global.fruitShop_Imgsdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.backLayer,{
            "x":558,
            "y":498,
            "width":57,
            "height":23
         },Global.Img_Cdm);
         this.pageTxt = ComponentUtil.getTextField("1/1",this.dymLayer,{
            "x":576,
            "y":501,
            "color":15856113,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Ico_XG",this.backLayer,{
            "x":315,
            "y":498
         },Global.fruitShop_Imgsdm);
         ComponentUtil.getBitmap("Ico_Li",this.backLayer,{
            "x":367,
            "y":498
         },Global.fruitShop_Imgsdm);
         ComponentUtil.getBitmap("Ico_PG",this.backLayer,{
            "x":420,
            "y":498
         },Global.fruitShop_Imgsdm);
         this.xgTxt = ComponentUtil.getTextField("x 0 ",this.dymLayer,{
            "x":335,
            "y":501,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.liTxt = ComponentUtil.getTextField("x 0 ",this.dymLayer,{
            "x":387,
            "y":501,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.pgTxt = ComponentUtil.getTextField("x 0 ",this.dymLayer,{
            "x":440,
            "y":501,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.childContainer = new Sprite();
         this.dymLayer.addChild(this.childContainer);
         i = 0;
         while(i < FruitShopHandler.MAX_PAGE_SIZE)
         {
            idxNum = (i + 1) * this.curPage;
            childItem = new Child_FruitShop();
            childItem.x = 302 + i % 3 * (childItem.width + 4);
            childItem.y = 141 + int(i / 3) * (childItem.height + 4);
            this.dymLayer.addChild(childItem);
            this.itemList[this.itemList.length] = childItem;
            itemStrArr = Data_lib.fruitShop[idxNum][0].split("_");
            itemID = int(itemStrArr[1]);
            if(Boolean(Data_lib.item[itemID]))
            {
               vo = new Vo_fruitShop();
               vo.index = idxNum;
               vo.name = Data_lib.item[itemID][Enum_lib_item.STR_NAME];
               vo.buyTimes = Data_lib.fruitShop[idxNum][1];
               vo.mats = Data_lib.fruitShop[idxNum][2];
               itemVo = new Vo_item();
               itemVo.id = itemID;
               itemVo.Init_lib();
               vo.itemVo = itemVo;
               vo.itemVo.count = itemStrArr[2];
               vo.itemVo.bBind = Boolean(Data_lib.fruitShop[idxNum][4]);
               childItem.vo = vo;
            }
            childItem.updateVo();
            i++;
         }
         temN = Data_lib.fruitShop.getLength() / 6;
         this.maxPage = Data_lib.fruitShop.getLength() % 6 == 0 ? temN : int(temN + 1);
         this.pageTxt.text = this.curPage + "/" + this.maxPage;
         matArr = Data_lib.fruitShop[idxNum][2].split(",");
         this.check_item_id_1 = matArr[0].split("_")[0];
         this.check_item_id_2 = matArr[1].split("_")[0];
         this.check_item_id_3 = matArr[2].split("_")[0];
         ComponentUtil.getBitmap("BG_GCN",this,{
            "x":0,
            "y":0
         },Global.fruitShop_Imgsdm);
         this.checkHander();
         FruitShopCGMessage.CG_FRUIT_SHOP_DATA();
         Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.checkHander);
      }
      
      private function onPageHandler(e:MouseEvent) : void
      {
         var btn:Button = e.target as Button;
         switch(btn)
         {
            case this.pageLeft:
               --this.curPage;
               this.curPage = this.curPage < 1 ? 1 : this.curPage;
               break;
            case this.pageRight:
               ++this.curPage;
               this.curPage = this.curPage > this.maxPage ? this.maxPage : this.curPage;
         }
         this.pageTxt.text = this.curPage + "/" + this.maxPage;
         this.updateList();
      }
      
      public function updateList() : void
      {
         var childItem:Child_FruitShop = null;
         var idxNum:int = 0;
         var itemStrArr:Array = null;
         var itemID:int = 0;
         var vo:Vo_fruitShop = null;
         var itemVo:Vo_item = null;
         var i:int = 0;
         while(i < FruitShopHandler.MAX_PAGE_SIZE)
         {
            idxNum = i + 1 + (this.curPage - 1) * FruitShopHandler.MAX_PAGE_SIZE;
            childItem = this.itemList[i] as Child_FruitShop;
            childItem.vo = null;
            if(!Data_lib.fruitShop[idxNum])
            {
               childItem.updateVo();
            }
            else
            {
               itemStrArr = Data_lib.fruitShop[idxNum][0].split("_");
               itemID = int(itemStrArr[1]);
               if(Boolean(Data_lib.item[itemID]))
               {
                  vo = new Vo_fruitShop();
                  vo.index = idxNum;
                  vo.name = Data_lib.item[itemID][Enum_lib_item.STR_NAME];
                  vo.buyTimes = Data_lib.fruitShop[idxNum][1];
                  vo.mats = Data_lib.fruitShop[idxNum][2];
                  itemVo = new Vo_item();
                  itemVo.id = itemID;
                  itemVo.Init_lib();
                  vo.itemVo = itemVo;
                  vo.itemVo.count = itemStrArr[2];
                  vo.itemVo.bBind = Boolean(Data_lib.fruitShop[idxNum][4]);
                  childItem.vo = vo;
               }
               childItem.updateVo();
            }
            i++;
         }
      }
      
      private function checkHander() : void
      {
         this.xgTxt.text = "x" + CommandManager.get_bag_count(this.check_item_id_1);
         this.liTxt.text = "x" + CommandManager.get_bag_count(this.check_item_id_2);
         this.pgTxt.text = "x" + CommandManager.get_bag_count(this.check_item_id_3);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.fruitShop_Imgsdm)
            {
               regResource(this.SOURCE_URL,"fruitShop_Imgsdm");
               preFun();
            }
            else
            {
               if(!this.titleBg)
               {
                  this.initUI2();
               }
               this.updateList();
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2 - 50;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get width() : Number
      {
         return 920;
      }
      
      override public function get height() : Number
      {
         return 560;
      }
   }
}

