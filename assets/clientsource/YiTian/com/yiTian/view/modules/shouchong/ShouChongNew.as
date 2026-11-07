package com.yiTian.view.modules.shouchong
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.geom.Rectangle;
   
   public class ShouChongNew extends Panel123
   {
      
      private var data:Array = [[2,96518,1],[1,46314,5],[1,49001,5],[1,46260,5],[1,46012,5],[1,46062,5],[1,43002,2],[1,43012,2]];
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var isFirstOpen:Boolean = true;
      
      public function ShouChongNew()
      {
         super();
         regResource("lang/ch/ShouChong_Imgs.swf","ShouChong_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var i:int;
         var v:Vo_item = null;
         var e:Vo_equip = null;
         var grid:View_Grid = null;
         var tf:MyTextField = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":698,
            "height":482
         },Global.Img_Cdm);
         move = new Rectangle(0,0,698,38);
         ComponentUtil.getBitmap("Back_Img",this,{
            "x":21,
            "y":40
         },Global.ShouChong_Imgsdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":664,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         initDynamicView();
         ComponentUtil.getBitmap("Title_ChongZhi",this,{
            "x":249,
            "y":5
         },Global.ShouChong_Imgsdm);
         ComponentUtil.getButton("","Button_CongZhi",this,{
            "x":356,
            "y":370,
            "textColor":16184781,
            "callBack":function():void
            {
               UIManager.yuanBaoXiang.visible = true;
            }
         },Global.ShouChong_Imgsdm);
         i = 0;
         while(i < 8)
         {
            grid = new View_Grid(true);
            grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
            addChild(grid);
            this.gridVec.push(grid);
            ComponentUtil.setPropertie(grid,{
               "x":307 + 74 * int(i / 2),
               "y":207 + 74 * int(i % 2)
            });
            tf = ComponentUtil.getTextField("",this,{
               "x":grid.x + grid.width - 22,
               "y":grid.y + grid.height - 25
            });
            if(this.data[i][0] == 1)
            {
               v = new Vo_item();
               v.id = this.data[i][1];
               v.count = this.data[i][2];
               v.Init_lib();
               grid.vo = v;
               tf.htmlText = v.count.toString();
            }
            else
            {
               e = new Vo_equip();
               e.id = this.data[i][1];
               e.count = this.data[i][2];
               e.Init_lib();
               grid.vo = e;
               tf.htmlText = e.count.toString();
            }
            if(i == 0)
            {
               EffectManager.addEffect("35180",grid,1000,32,32,true);
            }
            i++;
         }
      }
      
      public function setGridLoad() : void
      {
         var i:int = 8;
         while(Boolean(i--))
         {
            this.gridVec[i].isAutoLoad = true;
            this.gridVec[i].beginLoad();
            this.gridVec[i].count = this.data[i][1];
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.setGridLoad();
            }
         }
      }
   }
}

