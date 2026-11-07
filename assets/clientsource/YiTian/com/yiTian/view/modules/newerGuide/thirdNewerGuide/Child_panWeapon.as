package com.yiTian.view.modules.newerGuide.thirdNewerGuide
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   
   public class Child_panWeapon extends Panel123
   {
      
      private var arr:Array = [90113,90213,90313,90413];
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      public function Child_panWeapon()
      {
         super();
         regResource("lang/ch/XinShou_3.swf","XinShou_3dm");
      }
      
      public static function get instance() : Child_panWeapon
      {
         return Singleton.getInstance(Child_panWeapon);
      }
      
      private function get idArr() : Array
      {
         var job:int = int(Enum_job.getBaseJob(GameUnitManager.hero.job));
         return [46062,this.arr[job - 1]];
      }
      
      override protected function initUI2() : void
      {
         var id:int = 0;
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         var voE:Vo_equip = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":472,
            "height":350
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":424,
            "height":300
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":404,
            "height":254
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_ZhuangBei",this,{
            "x":36,
            "y":52
         },Global.XinShou_3dm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":436,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getButton("购买","Button_TwoBule91",this,{
            "x":184,
            "y":307,
            "textColor":16184781,
            "tabIndex":2,
            "callBack":Model_thirdNewer.butHd
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WuQi",this,{
            "x":156,
            "y":5
         },Global.XinShou_3dm);
         ComponentUtil.getBitmap("JianTou",this,{
            "x":118,
            "y":151
         },Global.XinShou_3dm);
         var i:int = 0;
         while(i < 2)
         {
            id = int(this.idArr[i]);
            grid = new View_Grid(true);
            grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
            ComponentUtil.setPropertie(grid,{
               "x":100,
               "y":78 + 125 * i
            });
            if(i == 0)
            {
               vo = new Vo_item();
               vo.id = id;
               vo.Init_lib();
               grid.vo = vo;
            }
            else
            {
               voE = new Vo_equip();
               voE.id = id;
               voE.Init_lib();
               grid.vo = voE;
               EffectManager.addEffect("35180",grid,1000,32,32,true);
            }
            this.gridVec.push(grid);
            addChild(grid);
            i++;
         }
         initDynamicView();
      }
      
      public function getAward() : void
      {
         var item:View_Grid = null;
         if(visible)
         {
            visible = false;
         }
         for each(item in this.gridVec)
         {
            ComboTweenStep.toBag(item);
         }
      }
      
      public function show() : void
      {
         if(!visible)
         {
            visible = true;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 400) / 2;
         y = (Global.stage.stageHeight - 250) / 2;
      }
   }
}

