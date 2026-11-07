package com.yiTian.view.modules.nationalTreasure
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.ModelManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.NationalTreasureCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_GridItem extends Sprite
   {
      
      private var grid:View_Grid;
      
      private var finishBg:ScaleBitmap;
      
      private var canClickBg:ScaleBitmap;
      
      private var canClickIcon:Bitmap = new Bitmap();
      
      private var sprite:Sprite;
      
      private var area:int;
      
      private var isDig:Boolean;
      
      private var gridId:int;
      
      private var _index:int;
      
      public function Child_GridItem()
      {
         super();
         this.finishBg = ComponentUtil.getScaleBitmap("Back_FGG",[5,5,1,1],this,{
            "x":-3,
            "y":-3,
            "width":42,
            "height":42
         },Global.WaBaodm);
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.set_tf_count(true,false,true);
         addChild(this.grid);
         this.sprite = new Sprite();
         addChild(this.sprite);
         this.sprite.addChildAt(this.canClickIcon,0);
         this.canClickIcon.x = -4;
         this.canClickIcon.y = -5;
         this.canClickBg = ComponentUtil.getScaleBitmap("Back_FGY",[5,5,1,1],this.sprite,{
            "x":-3,
            "y":-3,
            "width":44,
            "height":43
         },Global.WaBaodm);
         this.canClickBg.visible = false;
         this.sprite.buttonMode = true;
         this.sprite.addEventListener(MouseEvent.CLICK,this.onClick);
         this.sprite.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this.sprite.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.setBgVisible(false);
      }
      
      private function onOver(e:MouseEvent) : void
      {
         this.canClickBg.visible = true;
      }
      
      private function onOut(e:MouseEvent) : void
      {
         this.canClickBg.visible = false;
      }
      
      public function setGridBmd(area:int, i:int) : void
      {
         i += 1;
         if(area == Enum_NationalTreasure.ORDINARY_AREA)
         {
            this.canClickIcon.bitmapData = ComponentUtil.getBitmapData(area + "_" + i,Global.WaBaodm);
         }
         else
         {
            this.canClickIcon.bitmapData = ComponentUtil.getBitmapData(area + "_" + i,Global.WaBaodm2);
         }
      }
      
      public function setBgVisible(value:Boolean) : void
      {
         this.finishBg.visible = value;
         this.grid.visible = value;
         this.canClickIcon.visible = !value;
         this.sprite.visible = !value;
      }
      
      public function setVo(voStr:String, type:int, index:int) : void
      {
         var _voI:Vo_item = null;
         var _voE:Vo_equip = null;
         if(!voStr)
         {
            this.grid.vo = null;
            return;
         }
         var arr:Array = voStr.split("_");
         if(!arr || !arr.length)
         {
            this.grid.vo = null;
            return;
         }
         this._index = index;
         this.area = type;
         this.gridId = int(arr[0]);
         this.isDig = arr[4];
         var _type:int = int(arr[1]);
         var _id:Number = Number(arr[2]);
         var _count:int = int(arr[3]);
         if(_type == Enum_NationalTreasure.ITEM)
         {
            _voI = new Vo_item();
            _voI.id = _id;
            _voI.Init_lib();
            _voI.count = _count;
            this.grid.vo = _voI;
         }
         else if(_type == Enum_NationalTreasure.EQUIP)
         {
            _voE = new Vo_equip();
            _voE.id = _id;
            _voE.Init_lib();
            _voE.count = _count;
            this.grid.vo = _voE;
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var keyId:int = 0;
         var tip:String = null;
         var yuanbao:int = 0;
         if(this.gridId == 0)
         {
            return;
         }
         if(this.area == Enum_NationalTreasure.ORDINARY_AREA)
         {
            keyId = Enum_NationalTreasure.ORDINARY_KEY_ID;
         }
         else
         {
            keyId = Enum_NationalTreasure.ADVANCED_KEY_ID;
         }
         tip = "你没有" + Model_NationalTreasure.AreaData[this.area] + "挖宝钥匙，是否花费" + Model_NationalTreasure.AreaIngots[this.area] + "元宝进行寻宝";
         yuanbao = int(Model_NationalTreasure.AreaIngots[this.area]);
         if(ModelManager.bag.get_count(keyId) > 0)
         {
            NationalTreasureCGMessage.CG_WABAO(this._index,this.gridId,this.area,Enum_NationalTreasure.USE_KEY);
         }
         else
         {
            UIManager.wuXingProm.show(function():void
            {
               if(GameUnitManager.hero.money < yuanbao)
               {
                  UIManager.centerBroadcast.addMsg("元宝不足");
                  return;
               }
               NationalTreasureCGMessage.CG_WABAO(_index,gridId,area,Enum_NationalTreasure.USE_INGOTS);
            },tip,yuanbao);
         }
         Model_NationalTreasure.currentGridIndex = this._index;
      }
      
      public function flyIcon() : void
      {
         ComboTweenStep.toBag(this.grid);
      }
   }
}

