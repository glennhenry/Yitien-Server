package com.yiTian.view.modules.jingJiChang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.pet.PetVO;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class View_CZItem extends Panel
   {
      
      public var Button_Set:Button;
      
      private var PlayerName_text:MyTextField;
      
      private var PlayerLever_text:MyTextField;
      
      private var BangPai_text:MyTextField;
      
      private var PetName_text:Button;
      
      private var head:DisplayObject;
      
      private var _grid:View_Grid;
      
      private var _grids:Array = [];
      
      private var head_grid:View_Grid;
      
      private var isSelfBoard:Boolean = false;
      
      private var isFirstOpen:Boolean = true;
      
      private var hero_position:int = 22;
      
      private var pet_position:int = 11;
      
      private var role_head:Bitmap;
      
      private var pet_head:Bitmap;
      
      public var jobArr:Array = [[LangConfig.getWord("305",0)],[LangConfig.getWord("306",0)],[LangConfig.getWord("307",0)],[LangConfig.getWord("308",0)]];
      
      private var headBM:Bitmap;
      
      private var hero_name:String;
      
      private var _pet_id:int;
      
      private var pet_icon:int;
      
      private var hero_id:int;
      
      private var selfRoleHead:Bitmap;
      
      private var _heroHead:RoleHead;
      
      public function View_CZItem()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
      }
      
      private function mHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function petHandle(e:MouseEvent) : void
      {
         if(this.isSelfBoard)
         {
            UIManager.petPanel.visible = !UIManager.petPanel.visible;
            return;
         }
         PetCGMessage.CG_PET_OTHER_INFO(this._pet_id);
         PetPanel.curPanel = this;
      }
      
      public function showPetInfoView(petVO:PetVO) : void
      {
         UIManager.petInfoPanel.petVO = petVO;
         UIManager.petInfoPanel.update();
         UIManager.petInfoPanel.visible = true;
         UIManager.petInfoPanel.x = (Global.stage.stageWidth - UIManager.petInfoPanel.width) / 2;
         UIManager.petInfoPanel.y = (Global.stage.stageHeight - UIManager.petInfoPanel.height) / 2;
      }
      
      public function setGridLoad() : void
      {
         var i:int = 0;
         while(i < this._grids.length)
         {
            this._grids[i].set_bmp_bg("resource/image/team/zxBg.png");
            this._grids[i].isAutoLoad = true;
            this._grids[i].beginLoad();
            i++;
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
               this.isFirstOpen = false;
            }
         }
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
         if(this.pet_icon == 0)
         {
            this.pet_icon = 20902;
         }
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
      }
      
      private function set_pet_btn_enabled(value:Boolean) : void
      {
         this.PetName_text.enabled = value;
         this.PetName_text.useHandCursor = value;
         this.PetName_text.mouseEnabled = value;
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
      
      private function MHandle(e:MouseEvent) : void
      {
         if(this.PlayerName_text.text == GameUnitManager.hero.name)
         {
            Model_jingJiChang.hero_position = this.hero_position;
            Model_jingJiChang.pet_position = this.pet_position;
            JingJiChangCGMessage.CG_SET_POSITION(this.hero_position,this.pet_position);
         }
         this.visible = false;
      }
      
      public function updata(_roleId:int, name:String, level:int, job:int, sex:int, petId:int, hr_pos:int, pet_pos:int, _pet_icon:int = 0) : void
      {
         this.hero_id = _roleId;
         this.reset_handle();
         this.re_positoin();
         if(Boolean(this.headBM))
         {
            this.headBM.visible = false;
            this.headBM.bitmapData = null;
         }
         this._pet_id = petId;
         this.pet_icon = _pet_icon;
         this.PlayerName_text.textColor = Model_jingJiChang.getColor[Enum_job.getBaseJob(job) - 1];
         this.PlayerName_text.text = name;
         this.hero_name = name;
         this.PlayerLever_text.textColor = Model_jingJiChang.getColor[Enum_job.getBaseJob(job) - 1];
         this.PlayerLever_text.text = "LV." + String(level);
         this.BangPai_text.textColor = Model_jingJiChang.getColor[Enum_job.getBaseJob(job) - 1];
         this.BangPai_text.text = this.jobArr[Enum_job.getBaseJob(job) - 1];
         this._heroHead.getURL(Const_strImg.getPlayerHead(Enum_job.getBaseJob(job),sex),this.hero_id);
         this.hero_position = hr_pos;
         this.pet_position = pet_pos;
         if(this.hero_position == 0)
         {
            this.hero_position = 22;
         }
         if(petId != 0 && this.pet_position == 0)
         {
            this.pet_position = 11;
         }
         else if(petId == 0)
         {
            this.pet_position = 0;
         }
         this.update_grid(this.hero_position,this.pet_position,job,sex,name);
         this.set_grid_drag(false);
         this.set_pet_btn_enabled(petId != 0);
      }
      
      private function re_positoin() : void
      {
         this.hero_position = 0;
         this.pet_position = 0;
      }
      
      public function showSelfHead() : void
      {
         this.reset_handle();
         this._heroHead.getURL(Const_strImg.getPlayerHead(GameUnitManager.hero.job,GameUnitManager.hero.sex),GameUnitManager.hero.id);
         this.PlayerName_text.textColor = Model_jingJiChang.getColor[Enum_job.getBaseJob(GameUnitManager.hero.job) - 1];
         this.PlayerName_text.text = GameUnitManager.hero.name;
         this.PlayerLever_text.textColor = Model_jingJiChang.getColor[Enum_job.getBaseJob(GameUnitManager.hero.job) - 1];
         this.PlayerLever_text.text = "LV." + String(GameUnitManager.hero.level);
         this.BangPai_text.textColor = Model_jingJiChang.getColor[Enum_job.getBaseJob(GameUnitManager.hero.job) - 1];
         this.BangPai_text.text = this.jobArr[Enum_job.getBaseJob(GameUnitManager.hero.job) - 1];
         if(!GameUnitManager.pet)
         {
            Model_jingJiChang.pet_position = 0;
         }
         if(GameUnitManager.pet != null)
         {
            trace("宠物坐标",Model_jingJiChang.pet_position);
         }
         this.isSelfBoard = true;
         this.update_grid(Model_jingJiChang.hero_position,Model_jingJiChang.pet_position,GameUnitManager.hero.job,GameUnitManager.hero.sex,GameUnitManager.hero.name);
         this.set_grid_drag(true);
         this.set_pet_btn_enabled(GameUnitManager.pet != null);
      }
      
      private function reset_handle() : void
      {
         this.isSelfBoard = false;
         this._heroHead.dispose();
         var i:int = 0;
         while(i < this._grids.length)
         {
            this._grids[i].vo = null;
            i++;
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
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.utils.Utils;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class RoleHead extends Sprite
{
   
   private var _roleHead:Bitmap = new Bitmap();
   
   private var heroId:int;
   
   public function RoleHead()
   {
      super();
      mouseChildren = true;
      mouseEnabled = true;
      useHandCursor = true;
      buttonMode = true;
   }
   
   public function getURL(url:String, roleId:int) : void
   {
      this.heroId = roleId;
      this._roleHead = Utils.getLoadBitmap(url);
      addChild(this._roleHead);
      addEventListener(MouseEvent.CLICK,this.cliHandle);
   }
   
   private function cliHandle(e:MouseEvent) : void
   {
      Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this.heroId);
   }
   
   public function dispose() : void
   {
      removeEventListener(MouseEvent.CLICK,this.cliHandle);
      this._roleHead.bitmapData = null;
   }
}
