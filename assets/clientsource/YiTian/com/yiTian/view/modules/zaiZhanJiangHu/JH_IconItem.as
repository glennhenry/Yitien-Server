package com.yiTian.view.modules.zaiZhanJiangHu
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class JH_IconItem extends Sprite
   {
      
      private var gridVec:Vector.<View_Grid>;
      
      private var _effArr:Vector.<Effect> = new Vector.<Effect>();
      
      public function JH_IconItem(length:int)
      {
         var grid:View_Grid = null;
         super();
         this.gridVec = new Vector.<View_Grid>(length);
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,false,true);
            ComponentUtil.setPropertie(grid,{
               "x":98 + 48 * i,
               "y":25
            });
            addChild(grid);
            this.gridVec[i] = grid;
            i++;
         }
         grid = new View_Grid();
         grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         grid.set_bmp_over(false,null);
         ComponentUtil.setPropertie(grid,{
            "x":0,
            "y":0
         });
         addChild(grid);
         ComponentUtil.getBitmap("pic_left_01",this,{
            "x":0,
            "y":0
         },Global.ZZJH_Imgsdm);
         ComponentUtil.getBitmap("Icon_ZZJT",this,{
            "x":70,
            "y":34
         },Global.ZZJH_Imgsdm);
      }
      
      public function dispose() : void
      {
         this.reset();
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
      }
      
      public function addEff(arr:Array) : void
      {
         var effect:Effect = null;
         var grid:View_Grid = null;
         var i:int = 0;
         if(Boolean(this.gridVec.length))
         {
            i = this.gridVec.length - 1;
            while(i >= 0)
            {
               if(arr[i] == 1)
               {
                  grid = this.gridVec[i] as View_Grid;
                  effect = EffectManager.addEffect("35176",grid,1200,17,18,true);
                  this._effArr.push(effect);
               }
               i--;
            }
         }
      }
      
      public function removeEff() : void
      {
         var i:int = 0;
         var eff:Effect = null;
         if(Boolean(this._effArr.length))
         {
            i = this._effArr.length - 1;
            while(i >= 0)
            {
               eff = this._effArr[i] as Effect;
               this._effArr.splice(i,1);
               EffectManager.removeEffect(eff);
               eff = null;
               i--;
            }
         }
      }
      
      private function reset() : void
      {
         var grid:View_Grid = null;
         this.removeEff();
         for each(grid in this.gridVec)
         {
            grid.vo = null;
         }
      }
      
      public function update(arr:Array) : void
      {
         var _grid:View_Grid = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var _isAddEff:int = 0;
         var _voI:Vo_item = null;
         var _voE:Vo_equip = null;
         this.reset();
         var effArr:Array = [];
         var i:int = 0;
         while(i < arr.length)
         {
            _grid = this.gridVec[i];
            _type = int(arr[i][0]);
            _id = int(arr[i][1]);
            _count = int(arr[i][2]);
            _isAddEff = int(arr[i][3]);
            effArr.push(_isAddEff);
            if(_type == 1)
            {
               _voI = new Vo_item();
               _voI.id = _id;
               _voI.count = _count;
               _voI.Init_lib();
               _grid.vo = _voI;
            }
            else if(_type == 2)
            {
               _voE = new Vo_equip();
               _voE.id = _id;
               _voE.count = _count;
               _voE.Init_lib();
               _grid.vo = _voE;
            }
            i++;
         }
         this.addEff(effArr);
      }
      
      public function getAwards() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            grid = this.gridVec[i];
            ComboTweenStep.toBag(grid);
            i++;
         }
      }
   }
}

