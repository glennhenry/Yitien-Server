package com.yiTian.view.modules.activity
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Child_ChouJiangGroup extends Sprite
   {
      
      private var actItemVec:Vector.<View_Grid>;
      
      private const g:Number = 40;
      
      private const gg:Number = 38;
      
      public var isEnabled:Boolean;
      
      private var _dataArr:Array;
      
      private const gridLeng:int = 4;
      
      private const dataLeng1:int = 24;
      
      private const dataLeng2:int = 23;
      
      private var _type:int;
      
      private var meteCount:int;
      
      private var mete:Number;
      
      private var endGridIndex:int = 0;
      
      private var roundMete:Number = 160;
      
      public function Child_ChouJiangGroup()
      {
         super();
         this.init();
      }
      
      public function get aactItemVec() : Vector.<View_Grid>
      {
         return this.actItemVec;
      }
      
      private function init() : void
      {
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16711680,0.3);
         shape.graphics.drawRect(0,-4,this.gg,this.gg + 4);
         shape.graphics.endFill();
         addChild(shape);
         mask = shape;
         this.actItemVec = new Vector.<View_Grid>();
         this.createGrid();
      }
      
      private function createGrid() : void
      {
         var grid:View_Grid = null;
         var index:int = 0;
         while(index < this.gridLeng)
         {
            grid = new View_Grid();
            grid.isAutoLoad = false;
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_over(true,null);
            grid.set_bmp_select();
            grid.set_bmp_bg();
            grid.set_tf_count(true,true,true);
            grid.tabIndex = index;
            if(index == this.gridLeng - 1)
            {
               grid.y = this.g;
            }
            else
            {
               grid.y = -this.g * index;
            }
            grid.x = 2;
            addChild(grid);
            this.actItemVec.push(grid);
            index++;
         }
      }
      
      public function start(round:int, endIndex:int) : void
      {
         this.mete = 0;
         this.endGridIndex = endIndex % this.gridLeng;
         this.meteCount = this["dataLeng" + this._type.toString()] * this.g * round + endIndex * this.g;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameHandle);
      }
      
      public function end() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameHandle);
         dispatchEvent(new Event("endloop"));
      }
      
      private function frameHandle(interval:int) : void
      {
         var speed:Number = NaN;
         var target:View_Grid = null;
         var vo:Vo_item = null;
         var newIndex:int = 0;
         var remainMete:Number = this.meteCount - this.mete;
         if(remainMete > this.roundMete)
         {
            speed = 10;
         }
         else if(remainMete > 20)
         {
            speed = 5;
         }
         else if(remainMete > 5)
         {
            speed = 1;
         }
         else if(remainMete > 2)
         {
            speed = 0.5;
         }
         else
         {
            speed = 0.1;
         }
         var index:int = 0;
         while(index < this.gridLeng)
         {
            target = this.actItemVec[index];
            if(target.y >= this.g * 2)
            {
               vo = new Vo_item();
               newIndex = (target.vo.gridId + this.gridLeng) % this["dataLeng" + this._type.toString()];
               vo.id = this._dataArr[newIndex][1];
               vo.count = this._dataArr[newIndex][3];
               vo.gridId = this._dataArr[newIndex][5];
               vo.bgIndex = 0;
               vo.Init_lib();
               target.vo = vo;
               target.y = -(this.g * 2);
            }
            target.y += speed;
            index++;
         }
         this.mete += speed;
         if(this.mete >= this.meteCount)
         {
            this.end();
         }
      }
      
      public function set curIndex(value:int) : void
      {
         var index:int = value - 1;
      }
      
      public function set itemVisible(value:Boolean) : void
      {
         var item:View_Grid = null;
         for each(item in this.actItemVec)
         {
            item.visible = value;
         }
      }
      
      public function setViewArr(value:Array, type:int) : void
      {
         var vo:Vo_item = null;
         this._type = type;
         this._dataArr = value;
         var index:int = 0;
         while(index < this.gridLeng - 1)
         {
            vo = new Vo_item();
            vo.id = value[index][1];
            vo.gridId = value[index][5];
            vo.count = value[index][3];
            vo.bgIndex = 0;
            vo.Init_lib();
            this.actItemVec[index].vo = vo;
            index++;
         }
         var len:int = int(this["dataLeng" + this._type.toString()]);
         var vo1:Vo_item = new Vo_item();
         vo1.id = value[len - 1][1];
         vo1.gridId = value[len - 1][5];
         vo1.count = value[len - 1][3];
         vo1.bgIndex = 0;
         vo1.Init_lib();
         this.actItemVec[index].vo = vo1;
      }
   }
}

