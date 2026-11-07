package com.yiTian.view.modules.hapStone
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Pool;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flashx.textLayout.formats.TextAlign;
   
   internal class Child_hapStone extends Sprite
   {
      
      internal static var list:Array = [];
      
      internal static var pool:Array = [];
      
      private var numsTf:MyTextField;
      
      private var nameTf:MyTextField;
      
      private var inputTf:MyTextField;
      
      private var grid:View_Grid;
      
      private var __voHap:Vo_hapStone;
      
      private var eff:Effect;
      
      private var isTween:Boolean = false;
      
      private var bmPool:Array = [];
      
      public function Child_hapStone()
      {
         super();
         this.init();
      }
      
      public static function get instance() : Child_hapStone
      {
         return pool.pop() || new Child_hapStone();
      }
      
      internal function init() : void
      {
         var ss:Sprite;
         ComponentUtil.getBitmap("Back_HLZS",this,{
            "x":0,
            "y":0
         },Global.HLZSdm);
         this.nameTf = ComponentUtil.getTextField("物品名字六个",this,{
            "x":50,
            "y":3,
            "color":327424,
            "size":12,
            "leading":0,
            "realWidth":74,
            "align":TextAlign.CENTER
         });
         this.numsTf = ComponentUtil.getTextField("限量\n10次",this,{
            "x":149,
            "y":2,
            "color":52690,
            "size":12,
            "leading":0
         });
         ss = new Sprite();
         addChild(ss);
         ComponentUtil.getBitmap("Icon_Zuan",ss,{
            "x":39,
            "y":107
         },Global.HLZSdm);
         TipManager.bind(ss,View_hapStone.TipStr);
         ComponentUtil.getBitmap("Back_ShuZhi",this,{
            "x":70,
            "y":106
         },Global.HLZSdm);
         ComponentUtil.getTextField(":",this,{
            "x":60,
            "y":105,
            "color":52690,
            "size":12,
            "leading":0
         });
         this.inputTf = ComponentUtil.getTextField("1",this,{
            "x":73,
            "y":106,
            "color":16777215,
            "size":12,
            "leading":0,
            "realWidth":80,
            "realHeight":19
         });
         this.grid = new View_Grid(true);
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         this.grid.type = Enum_type_grid.STORE;
         ComponentUtil.setPropertie(this.grid,{
            "x":54,
            "y":32
         });
         addChild(this.grid);
         ComponentUtil.getButton("兑换","Button_GreenTwo",this,{
            "x":62,
            "y":133,
            "textColor":16771436,
            "callBack":function(e:MouseEvent):void
            {
               if(Model_hapStone.nowScore == -1)
               {
                  UIManager.centerBroadcast.addMsg("活动还没开启");
                  return;
               }
               if(__voHap.itemSellCount == 0)
               {
                  UIManager.centerBroadcast.addMsg("没次数了哦亲");
                  return;
               }
               showNumsPan();
            }
         },Global.Img_Cdm);
      }
      
      private function showNumsPan() : void
      {
         Model_hapStone.nowHapItem = this;
         UIManager.bang_store_prompt.type = "happy_stone";
         if(!UIManager.bang_store_prompt.visible)
         {
            UIManager.bang_store_prompt.show(this.__voHap);
         }
         UIManager.bang_store_prompt.parent.setChildIndex(UIManager.bang_store_prompt,UIManager.bang_store_prompt.parent.numChildren - 1);
      }
      
      public function init_data(vo_hap:Vo_hapStone) : void
      {
         this.__voHap = vo_hap;
         this.inputTf.htmlText = vo_hap.jifen.toString();
         this.nameTf.htmlText = vo_hap.name;
         vo_hap.vo.bBind = true;
         this.grid.vo = vo_hap.vo;
         this.leftNum = vo_hap.itemSellCount;
         if(Boolean(vo_hap.isLight))
         {
            if(!this.eff)
            {
               this.eff = EffectManager.addEffect("35180",this.grid,1000,32,32,true);
            }
            this.eff.alpha = 0.8;
         }
      }
      
      public function set leftNum(value:int) : void
      {
         var color:String = value <= 0 ? "#fe0000" : "#04ff00";
         this.numsTf.htmlText = "限量\n" + HtmlUtil.font(value.toString(),color) + "次";
         Model_hapStone.data_of_voStone[this.__voHap.index - 1].itemSellCount = value;
      }
      
      public function get_award_eff() : void
      {
         var b:Bitmap = null;
         this.bmPool = [];
         var i:int = 0;
         while(i < Model_hapStone.nowDHCount)
         {
            b = Pool.getObject(Bitmap);
            b.bitmapData = this.grid.get_icon_BitmapData();
            this.bmPool.push(b);
            i++;
         }
         Model_hapStone.getAward(this.bmPool,this.grid);
      }
      
      internal function dispose() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         list.splice(list.indexOf(this),1);
         this.numsTf.text = "0";
         this.grid.vo = null;
         this.nameTf.text = "";
         this.__voHap = null;
         pool.push(this);
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
         }
         this.eff = null;
      }
   }
}

