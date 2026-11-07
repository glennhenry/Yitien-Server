package com.yiTian.view.modules.nationalTreasure
{
   import com.utils.ComponentUtil;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class Child_ShowItem extends Sprite
   {
      
      private var grid:View_Grid;
      
      public function Child_ShowItem()
      {
         super();
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.set_tf_count(true,false,true);
         ComponentUtil.setPropertie(this.grid,{
            "x":2,
            "y":3
         });
         addChild(this.grid);
      }
      
      public function set Vo(voStr:String) : void
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
         var _type:int = int(arr[0]);
         var _id:int = int(arr[1]);
         var _count:int = int(arr[2]);
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
   }
}

