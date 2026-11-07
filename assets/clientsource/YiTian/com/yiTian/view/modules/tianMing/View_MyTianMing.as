package com.yiTian.view.modules.tianMing
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_Tianming;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_MyTianMing extends Sprite
   {
      
      private static var _instance:View_MyTianMing;
      
      private var back:Sprite;
      
      private var gridVec:Vector.<Child_grid>;
      
      public function View_MyTianMing()
      {
         super();
         this.init();
      }
      
      public static function get instance() : View_MyTianMing
      {
         if(!_instance)
         {
            _instance = new View_MyTianMing();
         }
         return _instance;
      }
      
      public function show() : void
      {
         var grid:Child_grid = null;
         var vo:Vo_TianMing = null;
         var vec:Vector.<Vo_TianMing> = Model_Tianming.myTianMing;
         var len:int = int(this.gridVec.length);
         var i:int = 0;
         while(i < len)
         {
            grid = this.gridVec[i];
            vo = vec[i];
            grid.updata(vo,vo.gridId);
            grid.lock = vo.lock;
            i++;
         }
      }
      
      private function ROLL_OVER(event:MouseEvent) : void
      {
         var grid:View_Grid = event.target as View_Grid;
         var vo:Vo_TianMing = grid.vo as Vo_TianMing;
         if(Boolean(vo) && vo.lock)
         {
            TipManager.update(grid.vo,grid.type);
         }
      }
      
      private function ROLL_OUT(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      private function init() : void
      {
         this.back = new Sprite();
         addChild(this.back);
         this.creatRole();
         this.creatGrid();
      }
      
      private function creatRole() : void
      {
         var bm_role:Bitmap = null;
         var hero:Hero = GameUnitManager.hero;
         var picId:int = 20000 + Enum_job.getBaseJob(hero.job) * 100 + hero.sex;
         bm_role = new Bitmap();
         Utils.getSwfBitmap("resource/pic_swf/" + picId.toString() + ".swf",bm_role,null,function():void
         {
            ComponentUtil.setPropertie(bm_role,{
               "x":(240 - bm_role.width) / 2,
               "y":(233 - bm_role.height) / 2
            });
         });
         addChild(bm_role);
      }
      
      private function creatGrid() : void
      {
         var arr:Array = null;
         this.gridVec = new Vector.<Child_grid>();
         var array:Array = [[486,56],[569,117],[538,216],[432,216],[401,117]];
         for each(arr in array)
         {
            this.initGrid(arr[0],arr[1]);
         }
      }
      
      private function initGrid(x:Number, y:Number) : void
      {
         var childGrid:Child_grid = null;
         childGrid = new Child_grid(Enum_type_grid.MY_TIAMMING,null);
         addChild(childGrid);
         childGrid.x = x - 384;
         childGrid.y = y - 48;
         childGrid.upBtnVis = false;
         this.gridVec.push(childGrid);
      }
      
      private function gridDownFun(event:MouseEvent) : void
      {
         UIManager.startDrag(event);
      }
      
      public function initUI() : void
      {
         ComponentUtil.getBitmap("TMBack_Img",this.back,null,Global.TianMing_Imgsdm);
      }
   }
}

