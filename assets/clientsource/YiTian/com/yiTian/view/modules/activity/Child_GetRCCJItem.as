package com.yiTian.view.modules.activity
{
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class Child_GetRCCJItem extends Sprite
   {
      
      private static var instance:Child_GetRCCJItem;
      
      private var gridArr:Array;
      
      public function Child_GetRCCJItem()
      {
         var grid:View_Grid = null;
         super();
         if(Boolean(instance))
         {
            throw new Error("singlon error");
         }
         instance = this;
         this.visible = false;
         this.gridArr = new Array();
         var index:uint = 0;
         while(index < 5)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_over(true,null);
            grid.set_bmp_bg();
            grid.set_bmp_select();
            grid.set_tf_count(true,true,true);
            grid.x = index * 49;
            addChild(grid);
            this.gridArr.push(grid);
            index++;
         }
      }
      
      public static function getInstance() : Child_GetRCCJItem
      {
         if(instance)
         {
         }
         return instance;
      }
      
      public function update(array:Array) : void
      {
         var itemArr:Array = null;
         var index:uint = 0;
         var vo:Vo_item = null;
         itemArr = CJInfo.getInstance().itemList1;
         index = 0;
         while(index < 5)
         {
            if(array[index] != null)
            {
               vo = new Vo_item();
               vo.id = itemArr[array[index]][1];
               vo.count = itemArr[array[index]][3];
               vo.bgIndex = 0;
               vo.Init_lib();
               this.gridArr[index].vo = vo;
            }
            else
            {
               this.gridArr[index].vo = null;
            }
            index++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      public function set numVisible(value:int) : void
      {
         var i:int = 0;
         while(i < this.gridArr.length)
         {
            this.gridArr[i].visible = i < value;
            i += 1;
         }
      }
      
      public function showBez() : void
      {
         var index:int = 0;
         while(index < this.gridArr.length)
         {
            ComboTweenStep.toBag(this.gridArr[index]);
            index++;
         }
      }
   }
}

