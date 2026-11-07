package com.yiTian.view.modules.hapStone
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HapStoneCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Pool;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flashx.textLayout.formats.TextAlign;
   
   public class Child_stoneAward extends Sprite
   {
      
      private var btn:Button;
      
      private var grid:View_Grid;
      
      private var numsTf:MyTextField;
      
      private var jifen_show_tf:MyTextField;
      
      private var sa_vo:Vo_hapStone;
      
      public function Child_stoneAward()
      {
         super();
      }
      
      public function init(vo:Vo_hapStone) : void
      {
         var ss:Sprite;
         var eff:Effect = null;
         this.sa_vo = vo;
         this.grid = new View_Grid(true);
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         this.grid.type = Enum_type_grid.STORE;
         addChild(this.grid);
         this.grid.vo = vo.vo;
         if(Boolean(vo.isLight))
         {
            eff = EffectManager.addEffect("35180",this.grid,1000,32,32,true);
            eff.alpha = 0.8;
         }
         ComponentUtil.setPropertie(this.grid,{
            "x":19,
            "y":0
         });
         this.btn = ComponentUtil.getButton("免费领取","Button_GreenTwo",this,{
            "x":25,
            "y":74,
            "textColor":16771436,
            "callBack":function():void
            {
               if(Model_hapStone.nowScore == -1)
               {
                  UIManager.centerBroadcast.addMsg("活动还没开启");
                  return;
               }
               HapStoneCGMessage.CG_GETAWARD_HAP(vo.index);
            }
         },Global.Img_Cdm);
         ss = new Sprite();
         addChild(ss);
         ComponentUtil.getBitmap("Icon_Zuan",ss,{
            "x":0,
            "y":106
         },Global.HLZSdm);
         TipManager.bind(ss,View_hapStone.TipStr);
         this.jifen_show_tf = ComponentUtil.getTextField(":" + vo.jifen + "免费领取",this,{
            "x":25,
            "y":102,
            "color":16772287,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER
         });
         this.numsTf = ComponentUtil.getTextField("",this,{
            "x":this.grid.x + 41,
            "y":this.grid.y + 44,
            "color":16772287,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER
         });
         this.numsTf.htmlText = vo.itemSellCount.toString();
         this.update();
      }
      
      public function update() : void
      {
         var colorStr:String = Model_hapStone.totalScore >= this.sa_vo.jifen ? "#04ff00" : "#fe0000";
         this.jifen_show_tf.htmlText = HtmlUtil.font(Model_hapStone.totalScore + "/" + this.sa_vo.jifen.toString() + "",colorStr) + "\n免费领取";
         this.label = Model_hapStone.data_of_jifen[this.sa_vo.index - 1];
      }
      
      public function getAwardEff() : void
      {
         var b:Bitmap = Pool.getObject(Bitmap);
         b.bitmapData = this.grid.get_icon_BitmapData();
         Model_hapStone.getAward([b],this.grid);
      }
      
      public function set label(value:int) : void
      {
         if(value == 0)
         {
            this.btn.label = "未达条件";
         }
         else if(value == 1)
         {
            this.btn.label = "免费领取";
         }
         else if(value == 2)
         {
            this.btn.label = "已经领取";
         }
         this.btn.enabled = value == 1 ? true : false;
      }
   }
}

