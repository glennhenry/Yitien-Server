package com.yiTian.view.modules.christmas
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.ModelChristmas;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.ChristmasCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flashx.textLayout.formats.TextAlign;
   
   public class ViewChristMas extends Panel
   {
      
      public var dm:ApplicationDomain;
      
      private var snowmanbg:Bitmap;
      
      private var expbg:Bitmap;
      
      private var expbar:Bitmap;
      
      private var currentScoreTxt:MyTextField;
      
      private var currentScore:MyTextField;
      
      private var growupTxt:MyTextField;
      
      private var growupdegreeTxt:MyTextField;
      
      private var growupdegreeValue:MyTextField;
      
      private var snowmanGoodsTxt:MyTextField;
      
      private var scoreShopBtn:Button;
      
      private var onekeySnowMan:Button;
      
      private var goodsList:Vector.<View_Grid>;
      
      private var currentPhase:int = -1;
      
      private var snowman:Bitmap;
      
      private var giftList:Vector.<View_Grid>;
      
      private var giftEffect:Dictionary;
      
      private var _title:Bitmap;
      
      public function ViewChristMas()
      {
         super();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!ModelChristmas.isLoadCom)
            {
               ModelChristmas.isLoadCom = true;
               this._title = new Bitmap();
               Utils.loadTitle("lang/ch/DXuRen.swf","Title_LaZhu",this._title,{
                  "x":176,
                  "y":5
               },this,this.onLoadCom);
            }
            else
            {
               ChristmasCGMessage.cg_christmas_open_view();
            }
         }
      }
      
      private function onLoadCom() : void
      {
         Global.DXuRendm = Utils.swfPool["lang/ch/DXuRen.swf"];
         this.initui();
         ChristmasCGMessage.cg_christmas_open_view();
      }
      
      private function initui() : void
      {
         var xx:Number = NaN;
         var yy:Number = NaN;
         var i:uint = 0;
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         this.snowmanbg = ComponentUtil.getBitmap("BG1",this,{
            "x":24,
            "y":41
         },Global.DXuRendm);
         this.expbg = ComponentUtil.getBitmap("JinDuDi",this,{
            "x":244,
            "y":231
         },Global.DXuRendm);
         this.expbar = ComponentUtil.getBitmap("JinDu",this,{
            "x":245,
            "y":232
         },Global.DXuRendm);
         this.currentScoreTxt = ComponentUtil.getTextField(LangConfig.getWord("9",10),this,{
            "x":245,
            "y":57,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.currentScore = ComponentUtil.getTextField("0",this,{
            "x":305,
            "y":56,
            "color":16753152,
            "size":12,
            "leading":0
         });
         this.growupdegreeValue = ComponentUtil.getTextField("00/00",this,{
            "x":254,
            "y":227,
            "color":16777215,
            "size":12,
            "leading":0,
            "color":14662240,
            "realWidth":200,
            "align":TextAlign.CENTER
         });
         this.growupdegreeTxt = ComponentUtil.getTextField(LangConfig.getWord("10",10),this,{
            "x":245,
            "y":209,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("15",10) + "\n" + LangConfig.getWord("16",10),this,{
            "x":245,
            "y":187 - 10,
            "color":16711699,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField(LangConfig.getWord("12",10),this,{
            "x":242,
            "y":288,
            "color":16711699,
            "size":12,
            "leading":3
         });
         this.scoreShopBtn = ComponentUtil.getButton(LangConfig.getWord("13",10),"Button_Orange",this,{
            "x":401,
            "y":55,
            "textColor":16184781
         },Global.Img_Cdm);
         this.onekeySnowMan = ComponentUtil.getButton(LangConfig.getWord("14",10),"Button_Four",this,{
            "x":401,
            "y":125,
            "textColor":16184781
         },Global.Img_Cdm);
         this.scoreShopBtn.addEventListener(MouseEvent.CLICK,this.onClickScoreShopBtn);
         this.onekeySnowMan.addEventListener(MouseEvent.CLICK,this.onClickOnekeySnowMan);
         this.goodsList = new Vector.<View_Grid>();
         xx = 251;
         yy = 92;
         i = 0;
         while(i < 6)
         {
            if(i == 3)
            {
               xx = 251;
               yy = 92 + 43;
            }
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_bmp_select();
            grid.set_tf_count();
            grid.isAutoLoad = true;
            grid.x = xx;
            grid.y = yy;
            addChild(grid);
            this.goodsList.push(grid);
            xx += grid.width + 5;
            i++;
         }
         this.giftList = new Vector.<View_Grid>();
         xx = 249;
         yy = 247;
         i = 0;
         while(i < 5)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_bmp_select();
            grid.isAutoLoad = true;
            grid.x = xx;
            grid.y = yy;
            addChild(grid);
            this.giftList.push(grid);
            xx += grid.width + 2;
            grid.set_grey(true);
            grid.addEventListener(MouseEvent.CLICK,this.onClickGift);
            vo = new Vo_item();
            vo.id = Data_lib.snowmanGrown[i + 1][1];
            vo.Init_lib();
            grid.vo = vo;
            i++;
         }
      }
      
      private function onClickGift(evt:MouseEvent) : void
      {
         var grid:View_Grid = evt.currentTarget as View_Grid;
         var pos:uint = this.giftList.indexOf(grid) + 1;
         if(ModelChristmas.instance.isCanGet(pos))
         {
            ChristmasCGMessage.cg_christmas_get_gift(pos);
         }
      }
      
      public function updateGift() : void
      {
         var index:int = 0;
         var gift:Vector.<uint> = ModelChristmas.instance.giftList;
         var i:uint = 0;
         while(i < this.giftList.length)
         {
            index = gift.indexOf(i + 1);
            if(index >= 0)
            {
               this.giftList[i].set_grey(false);
               if(!this.giftEffect)
               {
                  this.giftEffect = new Dictionary();
               }
               if(!this.giftEffect[i])
               {
                  this.giftEffect[i] = EffectManager.addEffect("35064",this.giftList[i],1000,14.5,16,true);
               }
            }
            else
            {
               this.giftList[i].set_grey(true);
               if(Boolean(this.giftEffect) && Boolean(this.giftEffect[i]))
               {
                  EffectManager.removeEffect(this.giftEffect[i]);
                  delete this.giftEffect[i];
               }
            }
            i++;
         }
      }
      
      private function onClickScoreShopBtn(evt:MouseEvent) : void
      {
         var pan:ShoppingMallPan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
         pan.openView(5,1);
      }
      
      public function update() : void
      {
         var max:uint = 0;
         this.updateScore();
         if(ModelChristmas.instance.phase < 5)
         {
            max = uint(Data_lib.snowmanGrown[ModelChristmas.instance.phase + 1][0]);
         }
         else
         {
            max = uint(Data_lib.snowmanGrown[5][0]);
         }
         this.expbar.scaleX = ModelChristmas.instance.growupValue / max;
         this.growupdegreeValue.text = ModelChristmas.instance.growupValue + "/" + max;
         this.updateGoods();
         this.updtaePhase();
      }
      
      public function flyEffect() : void
      {
         var point0:Point = this.localToGlobal(new Point(this.goodsList[4].x + 20,this.goodsList[4].y + 75));
         var point1:Point = this.localToGlobal(new Point(this.expbar.x + this.expbar.width,this.expbar.y + 73));
         EffectManager.flyEff(point0,point1);
      }
      
      private function updtaePhase() : void
      {
         if(this.currentPhase == ModelChristmas.instance.phase)
         {
            return;
         }
         this.currentPhase = ModelChristmas.instance.phase;
         this.loadBitmap();
      }
      
      private function loadBitmap() : void
      {
         if(!this.snowman)
         {
            this.snowman = new Bitmap();
            this.snowman.x = 55;
            this.snowman.y = 90;
            this.addChild(this.snowman);
         }
         this.snowman.visible = true;
         var path:String = "resource/image/christmasSnowman/" + this.currentPhase + ".png";
         Utils.getLoadBitmap(path,this.snowman);
      }
      
      private function updateGoods() : void
      {
         var list:Vector.<Vo_item> = ModelChristmas.instance.goodsList;
         var i:uint = 0;
         while(i < this.goodsList.length)
         {
            if(Boolean(list) && i < list.length)
            {
               this.goodsList[i].vo = list[i];
            }
            else
            {
               this.goodsList[i].vo = null;
            }
            i++;
         }
      }
      
      public function updateScore() : void
      {
         this.currentScore.text = GameUnitManager.hero.christmasScore.toString();
      }
      
      private function onClickOnekeySnowMan(evt:MouseEvent) : void
      {
         ChristmasCGMessage.cg_christmas_one_key_snowman();
      }
      
      public function getGiftGrid(pos:uint) : View_Grid
      {
         return this.giftList[pos - 1];
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 464) / 2;
         y = (Global.stage.stageHeight - 277) / 2;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":512,
            "height":327
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":245,
            "y":86,
            "width":140,
            "height":97
         },Global.Img_Cdm);
         move = new Rectangle(0,0,512,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":478,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
   }
}

