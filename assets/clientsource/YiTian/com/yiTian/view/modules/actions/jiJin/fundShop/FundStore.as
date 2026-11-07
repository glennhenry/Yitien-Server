package com.yiTian.view.modules.actions.jiJin.fundShop
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_store;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.Shopping.shoppingMall.MallItem;
   import com.yiTian.view.modules.Shopping.shoppingMall.Model_mall;
   import com.yiTian.view.modules.Shopping.shoppingMall.PriceItem;
   import com.yiTian.view.modules.ZaHuoDian.shops.Model_shp;
   import com.yiTian.view.modules.actions.jiJin.FundBuy;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.utils.Dictionary;
   
   public class FundStore extends Panel
   {
      
      public static var specialOpen:Boolean = false;
      
      private static const searchStr:String = "请输入道具名称";
      
      private static var isFirstOpen:Boolean = true;
      
      public static var dataDic:Dictionary = new Dictionary();
      
      public static var _typeInx:int = 0;
      
      public static var specialDell:Boolean = false;
      
      private var femalBmp:Bitmap;
      
      private var femalContainer:Sprite;
      
      private var femalContainerMsk:Sprite;
      
      private var itemContainerMsk:Sprite;
      
      private var itemContainer:Sprite;
      
      private var searchTxt:MyTextField;
      
      private var pageTxt:MyTextField;
      
      private var TabBtnArr:Array = ["普通商店","低级商店","中级商店","高级商店"];
      
      private var typeAr:Array = ["1","2","3","4"];
      
      private var changeItem:Sprite;
      
      private var tbVec:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var maxP:int;
      
      private var sign:int;
      
      public var _curPage:int = 1;
      
      private var dataArr:Array = [];
      
      private var nowTab:TabButton;
      
      private var comparLvl:Boolean;
      
      private var _firstOpenLvel:int;
      
      private var priIVec:Vector.<PriceItem> = new Vector.<PriceItem>();
      
      public var fundOwn:int;
      
      public var ratio:int = 2;
      
      public var powerr:Number = 0.8;
      
      public function FundStore()
      {
         super();
         this.initB();
      }
      
      private function initB() : void
      {
         this.femalBmp = new Bitmap();
         this.femalContainer = new Sprite();
         this.femalContainerMsk = new Sprite();
         this.itemContainer = new Sprite();
         this.itemContainerMsk = new Sprite();
         this.changeItem = new Sprite();
         this.femalContainer.graphics.beginFill(0,0);
         this.femalContainer.graphics.drawRect(0,0,265,570);
         this.femalContainer.graphics.endFill();
         addChild(this.femalContainer);
         this.femalContainerMsk.graphics.beginFill(0,0);
         this.femalContainerMsk.graphics.drawRect(0,0,265,570);
         this.femalContainerMsk.graphics.endFill();
         addChild(this.femalContainerMsk);
         this.femalContainer.mask = this.femalContainerMsk;
         this.femalContainer.visible = false;
         this.femalBmp.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = true;
            alpha = 1;
            this.updataMon();
            GameScene.instance.addFrameCallBack(this.updataMon);
            if(isFirstOpen)
            {
               if(!Global.Store_Imgsdm)
               {
                  SingleLoader.add("lang/ch/Store_Imgs.swf",function(info:Object):void
                  {
                     Global.Store_Imgsdm = info.applicationDomain;
                     showStatic();
                     showDynamic();
                  });
               }
               else
               {
                  this.showStatic();
                  this.showDynamic();
               }
               isFirstOpen = false;
            }
            else
            {
               this.autoMove("in");
            }
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.updataMon);
            _typeInx = 0;
            this._curPage = 1;
            if(Boolean(this.nowTab))
            {
               this.nowTab.choose = false;
               this.nowTab = null;
            }
            this.autoMove("out");
         }
      }
      
      private function updataMon() : void
      {
         this.updatePriceCost();
      }
      
      private function showStatic() : void
      {
         var i:int;
         var btnL:Button;
         var btnR:Button;
         var tab:TabButton = null;
         ComponentUtil.getScaleBitmap("Store_Back1",[229,44,2,3],this,{
            "x":233,
            "y":3,
            "width":712,
            "height":575
         },Global.Store_Imgsdm);
         ComponentUtil.getScaleBitmap("Store_Back4",[2,2,4,4],this,{
            "x":262,
            "y":65,
            "width":654,
            "height":502
         },Global.Store_Imgsdm);
         ComponentUtil.getScaleBitmap("Store_Back3",[3,3,4,4],this,{
            "x":749,
            "y":42,
            "width":108,
            "height":22
         },Global.Store_Imgsdm);
         ComponentUtil.getBitmap("JiJinStore_Title",this,{
            "x":468,
            "y":0
         },Global.Store_Imgsdm);
         this.itemContainer.graphics.beginFill(0,0);
         this.itemContainer.graphics.drawRect(0,0,650,460);
         this.itemContainer.graphics.endFill();
         addChild(this.itemContainer);
         this.itemContainerMsk.graphics.beginFill(0,0);
         this.itemContainerMsk.graphics.drawRect(0,0,650,460);
         this.itemContainerMsk.graphics.endFill();
         this.itemContainer.x = 262;
         this.itemContainerMsk.x = 262;
         this.itemContainer.y = this.itemContainerMsk.y = 65;
         addChild(this.itemContainerMsk);
         setChildIndex(this.itemContainer,numChildren - 1);
         addChild(this.changeItem);
         ComponentUtil.getScaleBitmap("Store_Back3",[3,3,4,4],this.changeItem,{
            "x":26,
            "y":1,
            "width":57,
            "height":23
         },Global.Store_Imgsdm);
         move = new Rectangle(50,0,811,38);
         ComponentUtil.getButton("","Button_SClose",this,{
            "x":894,
            "y":13,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Store_Imgsdm);
         i = 0;
         while(i < this.TabBtnArr.length)
         {
            tab = ComponentUtil.getTabButton(this.TabBtnArr[i],"TabButton_Store",this,{
               "x":274 + i * 75,
               "y":43,
               "textColor":8827782,
               "chooseColor":16777215,
               "name":this.typeAr[i]
            },Global.Store_Imgsdm);
            tab.addEventListener(MouseEvent.CLICK,this.tabChangedHd);
            this.tbVec.push(tab);
            i++;
         }
         ComponentUtil.getButton("","Button_BuyJiJin",this,{
            "x":811,
            "y":532,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               var pan3:* = undefined;
               pan3 = Singleton.getInstance(FundBuy) as FundBuy;
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan3,function():void
               {
                  pan3.visible = true;
               });
            }
         },Global.Store_Imgsdm);
         ComponentUtil.getButton("搜索","Button_Two22",this,{
            "x":862,
            "y":42,
            "textColor":16777215,
            "callBack":function(e:MouseEvent):void
            {
               if(searchTxt.text == "" || searchTxt.text == searchStr)
               {
                  UIManager.centerBroadcast.addMsg("请输入搜索的名称");
                  return;
               }
               var _dArr:* = Model_mall.getArrByName(searchTxt.text,FundShoConfig.dataDic[1],FundShoConfig.dataDic[2],FundShoConfig.dataDic[3],FundShoConfig.dataDic[4]);
               FundShoConfig.dataDic[0] = _dArr;
               sign = 0;
               if(Boolean(nowTab))
               {
                  nowTab.choose = false;
                  nowTab = null;
               }
               showData(1);
            }
         },Global.Store_Imgsdm);
         ComponentUtil.setPropertie(this.changeItem,{
            "x":535,
            "y":536
         });
         btnL = ComponentUtil.getButton("","Button_PageL",this.changeItem,{
            "x":0,
            "y":1,
            "name":"minus",
            "textColor":16184781
         },Global.Store_Imgsdm);
         btnR = ComponentUtil.getButton("","Button_PageR",this.changeItem,{
            "x":87,
            "y":1,
            "name":"rise",
            "textColor":16184781
         },Global.Store_Imgsdm);
         this.pageTxt = ComponentUtil.getTextField("1/1",this.changeItem,{
            "x":42,
            "y":3,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.searchTxt = ComponentUtil.getTextField(searchStr,this,{
            "x":752,
            "y":44,
            "color":14277081,
            "size":12,
            "leading":0,
            "type":TextFieldType.INPUT,
            "realWidth":102,
            "realHeight":18,
            "maxChars":8
         });
         this.searchTxt.addEventListener(FocusEvent.FOCUS_IN,function(e:FocusEvent):void
         {
            var tt:MyTextField = e.target as MyTextField;
            if(tt.text == searchStr)
            {
               tt.text = "";
            }
         });
         this.searchTxt.addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void
         {
            var tf:MyTextField = e.target as MyTextField;
            if(tf.text == "")
            {
               tf.text = searchStr;
            }
         });
         btnL.callBack = btnR.callBack = this.changdHd;
      }
      
      private function changdHd(e:MouseEvent) : void
      {
         switch((e.target as Button).name)
         {
            case "minus":
               --this._curPage;
               this._curPage = this._curPage < 1 ? 1 : this._curPage;
               break;
            case "rise":
               ++this._curPage;
               this._curPage = this._curPage > this.maxP ? this.maxP : this._curPage;
         }
         this.showData(this._curPage);
      }
      
      public function reset() : void
      {
         var item:MallItem = null;
         if(Boolean(this.dataArr.length))
         {
            for each(item in this.dataArr)
            {
               item.dispose();
            }
         }
         while(Boolean(this.dataArr.length))
         {
            this.dataArr.shift();
         }
      }
      
      public function showData(_curPage:int) : void
      {
         var i:int = 0;
         var tab:TabButton = null;
         var item:MallItem = null;
         var voStore:Vo_store = null;
         this.reset();
         var _data:Array = FundShoConfig.dataDic[this.sign];
         if(!_data)
         {
            return;
         }
         this.maxP = _data.length / 12 + int(_data.length % 12 != 0);
         this.pageTxt.text = _curPage + "/" + this.maxP;
         if(_curPage > this.maxP)
         {
            _curPage = this.maxP;
         }
         var _dataA:Array = Model_shp.getData(_data,_curPage,12);
         i = 0;
         while(i < _dataA.length)
         {
            item = MallItem.instance;
            voStore = _dataA[i];
            item.x = 272 + int(i % 3) * 213 - 262;
            item.y = 68 + int(i / 3) * 116 - 65;
            item.update(voStore,i + (_curPage - 1) * 12);
            this.itemContainer.addChild(item);
            this.dataArr.push(item);
            i++;
         }
         for each(tab in this.tbVec)
         {
         }
      }
      
      private function tabChangedHd(e:MouseEvent) : void
      {
         var tabB:TabButton = e.target as TabButton;
         if(tabB == this.nowTab)
         {
            return;
         }
         if(Boolean(this.nowTab))
         {
            this.nowTab.choose = false;
         }
         tabB.choose = true;
         this.nowTab = tabB;
         this.sign = int(this.nowTab.name);
         this._curPage = 1;
         this.showData(this._curPage);
      }
      
      private function matchHeroLvl(hrLv:int) : Boolean
      {
         if(hrLv >= 90)
         {
            this.comparLvl = true;
         }
         else
         {
            this.comparLvl = false;
         }
         return this.comparLvl;
      }
      
      private function matchLvl(heroLvl:int) : Boolean
      {
         return Model_mall.getJieDuanBool(this._firstOpenLvel);
      }
      
      private function set firstOpenLvel(value:int) : void
      {
         this._firstOpenLvel = value;
      }
      
      private function reSetPriceItem() : void
      {
         var item:PriceItem = null;
         if(Boolean(this.priIVec.length))
         {
            for each(var _loc4_ in this.priIVec)
            {
               item = _loc4_;
               _loc4_;
               item.dispose();
            }
         }
         while(Boolean(this.priIVec.length))
         {
            this.priIVec.shift();
         }
      }
      
      public function openView(typeIndex:int, page:int) : void
      {
         this._curPage = page;
         _typeInx = typeIndex;
         specialDell = true;
         if(!visible)
         {
            this.visible = true;
         }
         else
         {
            this.autoMove("in");
         }
      }
      
      public function updatePriceCost() : void
      {
         var priItem:PriceItem = null;
         this.reSetPriceItem();
         priItem = PriceItem.instance;
         this.changeItem.x = 560;
         560;
         priItem.updata("基金：",FundMter.fundOwn.toString());
         addChild(priItem);
         this.priIVec.push(priItem);
         this.setPos();
      }
      
      private function setPos() : void
      {
         var i:int = 0;
         var item:PriceItem = null;
         if(Boolean(this.priIVec.length))
         {
            i = 0;
            while(i < this.priIVec.length)
            {
               item = this.priIVec[i];
               item.x = 280 + 106 * i;
               item.y = 539;
               i++;
            }
         }
      }
      
      private function showDynamic() : void
      {
         this.autoMove();
      }
      
      private function autoMove(ss:String = "in") : void
      {
         if(ss == "in")
         {
            if(_typeInx < this.tbVec.length)
            {
               this.tbVec[_typeInx].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
         }
         else
         {
            mouseChildren = false;
            false;
            this.close();
         }
      }
      
      public function pop(sX:Number = 0.5, sY:Number = 0.5, pX:Number = 0.5, pY:Number = 0.5, starScale:Number = 0.3, endScale:Number = 1, duration:int = 400, endFun:Function = null) : void
      {
         var y1:Number = NaN;
         var x2:Number = NaN;
         var y2:Number = NaN;
         var x1:Number = (Global.stage.stageWidth - width * starScale) * sX;
         y1 = (Global.stage.stageHeight - height * starScale) * sY;
         x2 = (Global.stage.stageWidth - width * endScale) * pX;
         y2 = (Global.stage.stageHeight - height * endScale) * pY;
         scaleX = scaleY = starScale;
         x = x1;
         y = y1;
         Tween.curTo(this,duration,{
            "x":x2,
            "y":y2,
            "scaleX":endScale,
            "scaleY":endScale
         },null,endFun,this.tFun);
      }
      
      private function tFun(p:Number) : Number
      {
         var rate:Number = p * 3.1416 * this.ratio;
         return Math.pow(1 - Math.sin(rate) / rate,this.powerr);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 1106) / 2 - 50;
         y = (Global.stage.stageHeight - 577) / 2;
      }
      
      private function close() : void
      {
         mouseChildren = true;
         super.visible = false;
      }
   }
}

