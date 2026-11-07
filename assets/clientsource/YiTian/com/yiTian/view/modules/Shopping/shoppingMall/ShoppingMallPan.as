package com.yiTian.view.modules.Shopping.shoppingMall
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.vo.Vo_store;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.StoreCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.ZaHuoDian.shops.Model_shp;
   import com.yiTian.view.modules.newerGuide.thirdNewerGuide.Model_thirdNewer;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class ShoppingMallPan extends Panel
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
      
      private var TabBtnArr:Array = [LangConfig.getWord("126",0),LangConfig.getWord("127",0),LangConfig.getWord("128",0),LangConfig.getWord("983",0),LangConfig.getWord("129",0)];
      
      private var typeAr:Array = ["3","4","5","7","1","8"];
      
      private var changeItem:Sprite;
      
      private var tbVec:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var maxP:int;
      
      private var sign:int;
      
      public var _curPage:int = 1;
      
      private var typeName:String;
      
      private var dataArr:Array = [];
      
      private var posArr:Array = [];
      
      private var nowTab:TabButton;
      
      private var comparLvl:Boolean;
      
      private var _firstOpenLvel:int;
      
      private var priIVec:Vector.<PriceItem> = new Vector.<PriceItem>();
      
      public var ratio:int = 2;
      
      public var powerr:Number = 0.8;
      
      private var _effDict:Dictionary = new Dictionary();
      
      private var _effects:Array = [];
      
      public function ShoppingMallPan()
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
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         if(value)
         {
            super.visible = true;
            Model_thirdNewer.hidePan(2);
            alpha = 1;
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
            this.clearEffectKeys();
            this.removeEffects();
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
         ComponentUtil.getBitmap("Store_Title",this,{
            "x":468,
            "y":0
         },Global.Store_Imgsdm);
         this.itemContainer.graphics.beginFill(0,0);
         this.itemContainer.graphics.drawRect(0,0,650,460);
         this.itemContainer.graphics.endFill();
         addChild(this.itemContainer);
         this.itemContainerMsk.graphics.beginFill(0,0);
         this.itemContainerMsk.graphics.drawRect(0,0,650,560);
         this.itemContainerMsk.graphics.endFill();
         this.itemContainer.x = 262;
         this.itemContainerMsk.x = 262;
         this.itemContainer.y = this.itemContainerMsk.y = 65;
         addChild(this.itemContainerMsk);
         this.itemContainer.mask = this.itemContainerMsk;
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
         ComponentUtil.getButton("","Button_Recharge",this,{
            "x":811,
            "y":532,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
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
               var _dArr:* = Model_mall.getArrByName(searchTxt.text,dataDic[3],dataDic[4],dataDic[5],dataDic[7],dataDic[1],dataDic[8]);
               dataDic[0] = _dArr;
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
               if(this._curPage == 1)
               {
                  return;
               }
               --this._curPage;
               break;
            case "rise":
               if(this._curPage == this.maxP)
               {
                  return;
               }
               ++this._curPage;
         }
         this.typeName = e.target.name;
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
         var item:MallItem = null;
         var voStore:Vo_store = null;
         var im:MallItem = null;
         this.reset();
         var _data:Array = dataDic[this.sign];
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
         this.posArr = [];
         i = 0;
         while(i < _dataA.length)
         {
            item = MallItem.instance;
            voStore = _dataA[i];
            item.update(voStore,i + (_curPage - 1) * 12);
            if(this.typeName == "minus")
            {
               item.x = -250;
               item.y = 3 + int(i / 3) * 116;
            }
            else
            {
               item.x = 650;
               item.y = 3 + int(i / 3) * 116;
            }
            this.posArr.push({"x":272 + int(i % 3) * 213 - 262});
            this.itemContainer.addChild(item);
            this.dataArr.push(item);
            i++;
         }
         if(specialOpen)
         {
            for each(im in this.dataArr)
            {
               if(Boolean(im._grid.vo))
               {
                  if(im._grid.vo.id == 46062)
                  {
                     im.speDill();
                     specialOpen = false;
                  }
               }
            }
         }
         this.tweenEff(0);
         specialDell = false;
         this.removeEffects();
         this.updateEffects();
      }
      
      private function tweenEff(index:int) : void
      {
         var obj:Object;
         var item:MallItem;
         var nn:int = 0;
         if(!visible || index >= this.dataArr.length)
         {
            return;
         }
         obj = this.posArr[index];
         item = this.dataArr[index];
         nn = int(setTimeout(function(it:MallItem, pp:Object):void
         {
            clearTimeout(nn);
            Tween.to(it,400,{"x":[it.x,pp.x]},null,null,Tween.SIN010);
            tweenEff(++index);
         },50,item,obj));
      }
      
      private function tabChangedHd(e:MouseEvent) : void
      {
         var isReGetData:Boolean = false;
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
         this.updatePriceCost();
         if(!specialDell)
         {
            this._curPage = 1;
         }
         if(Boolean(dataDic[this.sign]))
         {
            if(this.sign == 4)
            {
               isReGetData = this.matchLvl(GameUnitManager.hero.level);
               if(isReGetData)
               {
                  StoreCGMessage.CG_PLAZA(4);
               }
               else
               {
                  this.showData(this._curPage);
               }
            }
            else if(this.sign == 1)
            {
               if(this._firstOpenLvel > 90)
               {
                  this.showData(this._curPage);
               }
               else if(GameUnitManager.hero.level > this._firstOpenLvel && GameUnitManager.hero.level >= 90)
               {
                  StoreCGMessage.CG_PLAZA(1);
               }
               else
               {
                  this.showData(this._curPage);
               }
            }
            else
            {
               this.showData(this._curPage);
            }
         }
         else if(isFirstOpen)
         {
            isFirstOpen = false;
            this.firstOpenLvel = GameUnitManager.hero.level;
            StoreCGMessage.CG_PLAZA(3);
            StoreCGMessage.CG_PLAZA(4);
            StoreCGMessage.CG_PLAZA(5);
            StoreCGMessage.CG_PLAZA(7);
            StoreCGMessage.CG_PLAZA(8);
            StoreCGMessage.CG_PLAZA(1);
         }
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
            for each(item in this.priIVec)
            {
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
      
      private function updatePriceCost() : void
      {
         var priItem:PriceItem = null;
         var i:int = 0;
         var _id:int = 0;
         var _arr:Array = null;
         var _d1:String = null;
         var _d2:String = null;
         this.reSetPriceItem();
         this.changeItem.x = 560;
         switch(this.sign)
         {
            case 1:
               priItem = PriceItem.instance;
               priItem.updata("声望：",GameUnitManager.hero.prestige.toString());
               addChild(priItem);
               this.priIVec.push(priItem);
               break;
            case 3:
               priItem = PriceItem.instance;
               priItem.updata("元宝：",GameUnitManager.hero.money.toString());
               addChild(priItem);
               this.priIVec.push(priItem);
               break;
            case 4:
               this.changeItem.x = 700;
               i = 0;
               while(i < 4)
               {
                  priItem = PriceItem.instance;
                  this.priIVec.push(priItem);
                  _id = 46252 + i;
                  _arr = Model_mall.getNameById(_id);
                  _d1 = _arr[0];
                  _d2 = _arr[1];
                  priItem.updata(_d1,_d2);
                  addChild(priItem);
                  i++;
               }
               break;
            case 5:
               priItem = PriceItem.instance;
               priItem.updata("礼券：",GameUnitManager.hero.liquan.toString());
               addChild(priItem);
               this.priIVec.push(priItem);
               break;
            case 7:
               priItem = PriceItem.instance;
               priItem.updata("元宝：",GameUnitManager.hero.money.toString());
               addChild(priItem);
               this.priIVec.push(priItem);
               break;
            case 8:
               priItem = PriceItem.instance;
               priItem.updata("积分：",GameUnitManager.hero.christmasScore.toString());
               addChild(priItem);
               this.priIVec.push(priItem);
         }
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
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 940) / 2 - 50;
         y = (Global.stage.stageHeight - 550) / 2;
      }
      
      private function showDynamic() : void
      {
         this.femalBmp = ComponentUtil.getBitmap("JueSe",this.femalContainer,{
            "x":0,
            "y":64
         },Global.Store_Imgsdm);
         this.autoMove();
      }
      
      private function autoMove(ss:String = "in") : void
      {
         if(ss == "in")
         {
            this.femalContainer.visible = true;
            Tween.to(this.femalContainer,600,{"x":[-100,5]});
            if(_typeInx < this.tbVec.length)
            {
               this.tbVec[_typeInx].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
         }
         else
         {
            mouseChildren = false;
            Tween.to(this.femalContainer,600,{"x":[5,-100]});
            Tween.to(this,600,{"alpha":[1,0]},this.close);
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
      
      private function close() : void
      {
         mouseChildren = true;
         super.visible = false;
      }
      
      public function setItemEff(itemID:int, isEff:Boolean = true) : void
      {
         this._effDict[itemID] = isEff ? true : null;
      }
      
      public function updateEffects() : void
      {
         var k:String = null;
         var b:Boolean = false;
         var idx:int = 0;
         var xx:int = 0;
         var yy:int = 0;
         for(k in this._effDict)
         {
            b = Boolean(this._effDict[k]);
            if(b)
            {
               idx = this.getItemIndexByID(int(k));
               if(idx != -1)
               {
                  xx = 315 + 214 * (idx % 3);
                  yy = 140 + 115 * int(idx / 3);
                  this._effects.push(EffectManager.addEffect("35180",this,2000,xx,yy,true));
               }
            }
         }
      }
      
      public function clearEffectKeys() : void
      {
         var k:String = null;
         for(k in this._effDict)
         {
            this._effDict[k] = null;
         }
      }
      
      public function removeEffects() : void
      {
         var eff:Effect = null;
         for each(eff in this._effects)
         {
            EffectManager.removeEffect(eff);
         }
         this._effects.length = 0;
      }
      
      private function getItemIndexByID(id:int) : int
      {
         var item:MallItem = null;
         var index:int = -1;
         var i:int = 0;
         while(i < this.dataArr.length)
         {
            item = this.dataArr[i];
            if(item._grid.vo)
            {
               if(item._grid.vo.id == id)
               {
                  index = i;
                  break;
               }
            }
            i += 1;
         }
         return index;
      }
   }
}

