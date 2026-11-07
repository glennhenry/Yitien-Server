package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.vo.Vo_farm_fruit;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class View_refresh_fruit extends Panel
   {
      
      private var refresh_Button:Button;
      
      private var define_Button:Button;
      
      public var fruit_pos:int;
      
      public var fruitId:int;
      
      private var gridArr:Array;
      
      private var cropGrid:View_Grid;
      
      private var money:uint;
      
      private var multiple:MyTextField;
      
      private var tf:TextFormat;
      
      private var selectBit:Bitmap;
      
      private var bitArr:Array;
      
      private var multipleArr:Array;
      
      private var refreshEff:Effect;
      
      private var sprite:Sprite;
      
      private var isFirstOpen:Boolean = true;
      
      private var item:Vo_item;
      
      public function View_refresh_fruit()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var grid:View_Grid = null;
         var sp:Sprite = null;
         var str:String = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":378,
            "height":201
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":330,
            "height":120
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("206",9),this,{
            "x":38,
            "y":131,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.sprite = new Sprite();
         this.sprite.y = 90;
         addChild(this.sprite);
         this.refreshEff = EffectManager.addEffect("35171",this.sprite,1000,0,0,true);
         this.gridArr = new Array();
         this.bitArr = new Array();
         this.multipleArr = new Array();
         i = 0;
         while(i < 5)
         {
            grid = new View_Grid();
            sp = new Sprite();
            ComponentUtil.getBitmap("Grid_Open",this,{
               "x":41 + 64 * i,
               "y":59
            },Global.Img_Cdm);
            this.selectBit = ComponentUtil.getBitmap("Back_ZhongZi",sp,{
               "x":34 + 64 * i,
               "y":55
            },Global.ShanZhuang_Imgsdm);
            this.selectBit.filters = Util.disabled;
            addChild(sp);
            this.bitArr.push([this.selectBit,sp]);
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_bmp_select();
            grid.isAutoLoad = true;
            grid.x = 43 + 64 * i;
            grid.y = 62;
            addChild(grid);
            this.gridArr.push(grid);
            ComponentUtil.getBitmap("Arrow10",this,{
               "x":88,
               "y":79
            },Global.ShanZhuang_Imgsdm);
            if(i < 4)
            {
               ComponentUtil.getBitmap("Arrow10",this,{
                  "x":88 + 64 * i,
                  "y":79
               },Global.ShanZhuang_Imgsdm);
            }
            str = 1 + 0.25 * i + "倍";
            this.multiple = ComponentUtil.getTextField("",this,{
               "x":40 + 64 * i,
               "y":101,
               "color":16777215,
               "size":12,
               "leading":0
            });
            this.multiple.color = Model_farm.fruitColor[i];
            this.multiple.realWidth = 44;
            this.multiple.text = str;
            this.tf = new TextFormat();
            this.tf.align = TextFormatAlign.CENTER;
            this.multiple.setTextFormat(this.tf);
            this.multipleArr.push(this.multiple);
            i++;
         }
         this.define_Button = ComponentUtil.getButton(LangConfig.getWord("88",9),"Button_Green",this,{
            "x":236,
            "y":166,
            "textColor":16184781,
            "name":"1"
         },Global.ShanZhuang_Imgsdm);
         this.refresh_Button = ComponentUtil.getButton("","Button_Yellow",this,{
            "x":68,
            "y":166,
            "textColor":16184781,
            "name":"2"
         },Global.ShanZhuang_Imgsdm);
         move = new Rectangle(0,0,345,36);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":344,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.define_Button.callBack = this.cliHandle;
         this.refresh_Button.addEventListener(MouseEvent.CLICK,this.renovateClickHandle);
      }
      
      private function renovateClickHandle(evt:MouseEvent) : void
      {
         var btn:Button = evt.target as Button;
         if(!Model_farm.instace.landList_mine[this.fruit_pos - 1].fruit_id)
         {
            this.visible = false;
            return;
         }
         if(GameUnitManager.hero.money < this.money)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("89",9));
            return;
         }
         FarmCGMessage.cg_farm_refresh_fruit(Model_farm.instace.masterBasic_mine.id,this.fruit_pos);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               this.showBmp();
            }
            if(!this.refreshEff)
            {
               this.refreshEff = EffectManager.addEffect("35171",this.sprite,1000,0,0,true);
            }
         }
         else
         {
            EffectManager.removeEffect(this.refreshEff);
            this.refreshEff = null;
         }
      }
      
      public function updata(pos:int, id:int) : void
      {
         var fruitIcon:String = null;
         var j:int = 0;
         var vo:Vo_grid = null;
         var str:String = null;
         if(!pos || !id)
         {
            return;
         }
         this.fruit_pos = pos;
         this.fruitId = id;
         var i:int = 0;
         while(i < this.gridArr.length)
         {
            this.gridArr[i].vo = null;
            this.bitArr[i][0].filters = Util.disabled;
            i++;
         }
         if(visible)
         {
            this.cropGrid = this.gridArr[Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.fruitCharacter] - 1];
            fruitIcon = Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.outputType].toString().substr(0,5);
            this.money = Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.refreshPrice];
            this.refresh_Button.label = LangConfig.getWord("207",9,Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.refreshPrice]);
            j = 0;
            while(j < 5)
            {
               vo = new Vo_grid();
               vo.str_icon = Data_lib.item[int(fruitIcon)][Enum_lib_item.STR_ICON];
               vo.bgIndex = j + 1;
               this.gridArr[j].vo = vo;
               this.gridArr[j].bSelect = false;
               if(vo.str_icon == "44401")
               {
                  str = "<font color= \'" + Model_farm.fruitColor1[j] + "\'>" + LangConfig.getWord("91",9,Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.name],Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.output]);
               }
               else
               {
                  str = "<font color= \'" + Model_farm.fruitColor1[j] + "\'>" + LangConfig.getWord("91",9,Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.name],Data_lib.farm_fruit[Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.lowest] + j][Vo_farm_fruit.output]);
               }
               this.multipleArr[j].text = Data_lib.farm_fruit[Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.lowest] + j][Vo_farm_fruit.refreshMagnification] + "倍";
               this.multipleArr[j].setTextFormat(this.tf);
               TipManager.bind(this.gridArr[j],str);
               if(j == Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.fruitCharacter] - 1)
               {
                  this.bitArr[j][0].filters = null;
                  this.sprite.x = 62 + 64 * j;
                  if(Data_lib.farm_fruit[this.fruitId][Vo_farm_fruit.fruitCharacter] == 5)
                  {
                     this.refresh_Button.filters = Util.disabled;
                     this.refresh_Button.label = LangConfig.getWord("208",9);
                     this.refresh_Button.mouseEnabled = false;
                  }
                  else
                  {
                     this.refresh_Button.filters = null;
                     this.refresh_Button.mouseEnabled = true;
                  }
               }
               j++;
            }
         }
      }
      
      public function addEffect() : void
      {
         EffectManager.addEffect("35108",this,1000,this.cropGrid.x + this.cropGrid.width / 2,this.cropGrid.y + this.cropGrid.height / 2);
      }
      
      private function showBmp() : void
      {
         ComponentUtil.getBitmap("Title_ReflashList",this,{
            "x":109,
            "y":5
         },Global.ShanZhuang_Imgsdm);
      }
      
      private function cliHandle(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

