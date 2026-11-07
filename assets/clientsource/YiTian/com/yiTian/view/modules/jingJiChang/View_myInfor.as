package com.yiTian.view.modules.jingJiChang
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.team.ZhenFaViewGrid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_myInfor extends Panel
   {
      
      private var sureBtn:Button;
      
      private var _grid:View_Grid;
      
      private var _grids:Array = [];
      
      private var isFirstOpen:Boolean = true;
      
      private var pet_icon:int;
      
      private var hero_position:int = 22;
      
      private var pet_position:int = 11;
      
      public function View_myInfor()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var _i:int = 0;
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":1,
            "y":0,
            "width":300,
            "height":246
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":29,
            "y":44,
            "width":242,
            "height":160
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":62,
            "y":59,
            "width":178,
            "height":128
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,30);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":266,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.sureBtn = ComponentUtil.getButton(LangConfig.getWord("6",0),"Button_Four",this,{
            "x":114,
            "y":210,
            "textColor":16184781
         },Global.Img_Cdm);
         var sx:int = 77 + 2 * 53;
         _i = 0;
         while(_i < 6)
         {
            this._grid = new ZhenFaViewGrid(false,".jpg");
            this._grid.set_bmp_bg("resource/image/team/zxBg.png");
            this._grid.set_bmp_select();
            this._grid.set_tf_count(true,false,true);
            this._grid.isAutoLoad = false;
            this._grid.x = sx - 53 * (_i % 3);
            this._grid.y = 76 + 53 * int(_i / 3);
            this._grid.index = _i;
            addChild(this._grid);
            this._grids.push(this._grid);
            _i++;
         }
         this.sureBtn.callBack = this.sureHandle;
      }
      
      private function sureHandle(e:MouseEvent) : void
      {
         Model_jingJiChang.hero_position = this.hero_position;
         Model_jingJiChang.pet_position = this.pet_position;
         JingJiChangCGMessage.CG_SET_POSITION(this.hero_position,this.pet_position);
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.setGridLoad();
               this.isFirstOpen = false;
               Utils.loadTitle("lang/ch/Arena_Imgs.swf","Title_ZhenXing",new Bitmap(),{
                  "x":70,
                  "y":5
               },this);
            }
         }
      }
      
      private function setGridLoad() : void
      {
         var i:int = 0;
         while(i < this._grids.length)
         {
            this._grids[i].isAutoLoad = true;
            this._grids[i].beginLoad();
            i++;
         }
      }
      
      private function re_positoin() : void
      {
         var i:int = 0;
         while(i < this._grids.length)
         {
            this._grids[i].vo = null;
            i++;
         }
      }
      
      public function showSelfHead() : void
      {
         this.re_positoin();
         this.update_grid(Model_jingJiChang.hero_position,Model_jingJiChang.pet_position,GameUnitManager.hero.job,GameUnitManager.hero.sex,GameUnitManager.hero.name);
         this.getPos();
         this.set_grid_drag(true);
      }
      
      private function update_grid(heroPos:int, petPos:int, _job:int, _sex:int, _nameStr:String) : void
      {
         var tem1_num:int = int(heroPos / 10);
         var tem2_num:int = int(petPos / 10);
         var tem3_num:int = int(heroPos % 10);
         var tem4_num:int = int(petPos % 10);
         this.get_hero_position(tem1_num,tem3_num,_job,_sex,_nameStr);
         this.get_pet_position(tem2_num,tem4_num);
      }
      
      private function get_hero_position(_num1:int, _num2:int, _job:int, _sex:int, _nameStr:String) : void
      {
         var temVo:Vo_grid = new Vo_grid();
         if(_num1 == 1)
         {
            temVo.str_icon = "23" + String(Enum_job.getBaseJob(_job)) + "2" + String(_sex);
            temVo.str_name = _nameStr;
            this._grids[_num2 - 1].vo = temVo;
         }
         else
         {
            temVo.str_icon = "23" + String(Enum_job.getBaseJob(_job)) + "2" + String(_sex);
            temVo.str_name = _nameStr;
            this._grids[_num2 + 2].vo = temVo;
         }
      }
      
      private function get_pet_position(_num1:int, _num2:int, nameStr:String = null) : void
      {
         if(nameStr == null)
         {
            nameStr = LangConfig.getWord("10047",1);
         }
         var temVo:Vo_grid = new Vo_grid();
         if(Boolean(UIManager.petPanel.petVO))
         {
            this.pet_icon = UIManager.petPanel.petVO.img;
            if(_num1 == 1)
            {
               temVo.str_icon = String(this.pet_icon) + "_40";
               temVo.str_name = nameStr;
               this._grids[_num2 - 1].vo = temVo;
            }
            else if(_num1 == 2)
            {
               temVo.str_icon = String(this.pet_icon) + "_40";
               temVo.str_name = nameStr;
               this._grids[_num2 + 2].vo = temVo;
            }
            else
            {
               Utils.print(LangConfig.getWord("304",0));
            }
            return;
         }
      }
      
      private function set_grid_drag(value:Boolean) : void
      {
         var i:int = 0;
         if(value)
         {
            i = 0;
            while(i < this._grids.length)
            {
               this._grids[i].addEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
               this._grids[i].addEventListener(MouseEvent.MOUSE_UP,this.upHandle);
               i++;
            }
         }
         else
         {
            i = 0;
            while(i < this._grids.length)
            {
               this._grids[i].removeEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
               this._grids[i].removeEventListener(MouseEvent.MOUSE_UP,this.upHandle);
               i++;
            }
         }
      }
      
      private function upHandle(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var v_grid:View_Grid = null;
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            v_grid = e.target as View_Grid;
            if(Boolean(v_grid.vo))
            {
               this.changed_position(v_grid,dragGrid);
            }
            else
            {
               v_grid.vo = dragGrid.vo;
               v_grid.vo.str_name = dragGrid.vo.str_name;
               dragGrid.vo = null;
            }
         }
         this.getPos();
      }
      
      private function getPos() : void
      {
         var temVo:Vo_grid = null;
         var i:int = 0;
         while(i < this._grids.length)
         {
            if(Boolean(this._grids[i].vo))
            {
               temVo = this._grids[i].vo;
               if(temVo.str_name == LangConfig.getWord("303",0))
               {
                  this.pet_position = (int(i / 3) + 1) * 10 + int(i % 3) + 1;
               }
               else
               {
                  this.hero_position = (int(i / 3) + 1) * 10 + int(i % 3) + 1;
               }
            }
            i++;
         }
      }
      
      private function changed_position(up_grid:View_Grid, drag_grid:View_Grid) : void
      {
         var temVo:Vo_grid = up_grid.vo;
         up_grid.vo = drag_grid.vo;
         this._grids[drag_grid.index].vo = temVo;
      }
   }
}

