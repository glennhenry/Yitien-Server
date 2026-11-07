package com.yiTian.view.modules.weilie
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_Guoshi extends Sprite
   {
      
      private var bm:Bitmap;
      
      private var grid:View_Grid;
      
      private const arr:Array = ["","","Back_LvSe","Back_LanSe","Back_ZiSe","Back_ChengSe"];
      
      private var count:int;
      
      private var eff:Effect;
      
      private var _index:int;
      
      public function Child_Guoshi()
      {
         super();
         this.bm = new Bitmap();
         this.addChild(this.bm);
         this.grid = new View_Grid();
         var _temp_1:* = this.grid;
         this.grid.y = 14;
         _temp_1.x = 14;
         this.grid.type = Enum_type_grid.NO_DRAG;
         this.grid.set_bmp_over(true,"");
         this.grid.set_bmp_bg(null);
         this.grid.set_tf_count();
         this.addChild(this.grid);
      }
      
      public static function get item() : Child_Guoshi
      {
         return new Child_Guoshi();
      }
      
      public function moviePlay() : void
      {
         var end:Function = null;
         end = function():void
         {
            var s:Function = function(times:int):void
            {
               var b:int = 0;
               b = int(setTimeout(function():void
               {
                  clearTimeout(b);
                  Tween.gridToBagBezierFuncDef(grid);
               },times));
            };
            var i:int = 0;
            while(i < count)
            {
               s(i * 200);
               i++;
            }
            setfilter(true);
         };
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
         this.eff = EffectManager.addEffect("35062",this,600,31,33);
         setTimeout(end,400);
         this.count = this.count > 10 ? 10 : this.count;
      }
      
      public function get viewgrid() : View_Grid
      {
         return this.grid;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(value:int) : void
      {
         this._index = value;
      }
      
      public function setVo(count:int, id:int) : void
      {
         var vo:Vo_item = new Vo_item();
         vo.id = id;
         vo.Init_lib();
         vo.bBind = true;
         this.grid.vo = vo;
         this.grid.count = count;
         this.count = count;
         this.bm.bitmapData = ComponentUtil.getBitmapData(this.arr[vo.color],Global.QXWLdm);
      }
      
      public function setfilter(b:Boolean) : void
      {
         if(b)
         {
            this.filters = Util.disabled;
         }
         else
         {
            this.filters = [];
         }
      }
   }
}

