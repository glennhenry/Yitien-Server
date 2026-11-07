package com.yiTian.view.modules.actions.ciRiLibao.tomorrDayGf
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ActionsCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class Child_tomDaygf extends Sprite
   {
      
      private var _day:int;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var iner:Iner;
      
      private var btn:Button;
      
      public function Child_tomDaygf()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var grid:View_Grid = null;
         this.btn = ComponentUtil.getButton("领取","Button_TwoBule91",this,{
            "x":406,
            "y":20,
            "textColor":16771436
         },Global.Img_Cdm);
         this.btn.callBack = this.get_aword;
         i = 0;
         while(i < 6)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count();
            grid.visible = false;
            ComponentUtil.setPropertie(grid,{
               "x":132 + 40 * i,
               "y":18
            });
            this.gridVec.push(grid);
            addChild(grid);
            i++;
         }
         ComponentUtil.getBitmap("Text_LJTS",this,{
            "x":0,
            "y":28
         },Global.DLYLdm);
         this.iner = new Iner();
         addChild(this.iner);
         ComponentUtil.setPropertie(this.iner,{
            "x":410,
            "y":25
         });
      }
      
      private function get_aword(e:MouseEvent) : void
      {
         var _n1:int = CommandManager.get_bag_canUse();
         var _n2:int = CommandManager.get_bag_used();
         if(_n1 - _n2 < 5)
         {
            UIManager.centerBroadcast.addMsg("背包格子不够");
            return;
         }
         ActionsCGMessage.CG_GET_CIRI_GF(this.day - 1);
      }
      
      public function set day(value:int) : void
      {
         this._day = value;
         ComponentUtil.getBitmap("Text_JiaZhi_0" + value,this,{
            "x":345,
            "y":0
         },Global.DLYLdm);
         ComponentUtil.getBitmap("JNHNO_" + value,this,{
            "x":67,
            "y":20
         },Global.DLYLdm);
         this.iner.day = value;
      }
      
      public function get day() : int
      {
         return this._day;
      }
      
      public function initItem(vo_tom:Vo_tomorrDaygf) : void
      {
         var i:int = 0;
         var vo:Vo_grid = null;
         var grid:View_Grid = null;
         var ef:Effect = null;
         i = 0;
         while(i < vo_tom.dataVec.length)
         {
            vo = vo_tom.dataVec[i];
            grid = this.gridVec[i];
            grid.visible = true;
            grid.vo = vo;
            if(i == 5)
            {
               ef = EffectManager.addEffect("35180",grid,1000,43,43,true);
               ef.scaleX = 0.5;
               ef.scaleY = 0.5;
            }
            i++;
         }
      }
      
      public function update(status:int) : void
      {
         this.iner.visible = !(status == 0 || status == -1);
         this.btn.visible = status == 0 || status == -1;
         if(this.iner.visible)
         {
            this.iner.day = status;
         }
         this.btn.enabled = status == 0;
         if(status == 0 || status == -1)
         {
            this.btn.label = status == 0 ? "领取" : "已领取";
         }
      }
      
      public function getAword() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            grid = this.gridVec[i];
            this.comboToBag(grid);
            i++;
         }
      }
      
      private function comboToBag(grid:View_Grid) : void
      {
         var count:int = 0;
         var fly:Function = function(_index:int):void
         {
            var n:int;
            if(_index > count)
            {
               return;
            }
            ComboTweenStep.toBag(grid);
            n = int(setTimeout(function():void
            {
               fly(++_index);
            },80));
         };
         count = grid.count;
         fly(1);
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Bitmap;
import flash.display.Sprite;

class Iner extends Sprite
{
   
   private var bm:Bitmap;
   
   public function Iner()
   {
      super();
      this.init();
   }
   
   private function init() : void
   {
      ComponentUtil.getBitmap("Text_HCTS",this,{
         "x":0,
         "y":0
      },Global.DLYLdm);
      this.bm = ComponentUtil.getBitmap("JNHNO_1",this,{
         "x":38,
         "y":-5
      },Global.DLYLdm);
   }
   
   public function set day(value:int) : void
   {
      this.bm.bitmapData = ComponentUtil.getBitmapData("JNHNO_" + value,Global.DLYLdm);
   }
}
